local _, ns = ...
local Data = ns.Data

--[[
    The Buff Window's unit reads: whether a unit can take a buff, what it has
    on, the role and class it is buffed as, how far away it is, its row label,
    and the icons that cast at it. Shared with the other Buff Window files
    through ns.BuffWindow.
]]

local BuffWindow = ns.BuffWindow
local buffs = BuffWindow.buffs
local exclusiveIds = BuffWindow.exclusiveIds
local RankFor = BuffWindow.RankFor

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

--[[
    Each unit's buffs as last read, keyed by GUID so an aura change reported on
    any of a player's tokens marks the one record: spell id -> expiration time,
    -> duration, and -> true for the auras you cast. A record is read again only
    once its GUID is marked dirty or a MarkAllAurasDirty has passed since its
    read, so a raid's aura traffic re-reads only the members it touched.
]]
local auraCache = {}
local dirtyGUIDs = {}
local generation = 0

local function NewRecord()
	return { expires = {}, durations = {}, mine = {} }
end

-- Read fresh every time: a unit whose GUID can't be read has no record to keep.
local uncachedRecord = NewRecord()

-- The record ReadAuras last selected, which Has reads.
local auraExpires, auraDurations, auraMine = uncachedRecord.expires, uncachedRecord.durations, uncachedRecord.mine

--------------------------------------------------------------------------------
-- Unit Reads
--------------------------------------------------------------------------------

function BuffWindow.CanBuff(unit)
	return UnitExists(unit) and UnitIsPlayer(unit) and UnitIsConnected(unit) and not UnitIsDeadOrGhost(unit)
end

--[[
    Every record goes stale, and one not read since the last call is dropped, so
    the cache holds only players the window still looks at.
]]
function BuffWindow.MarkAllAurasDirty()
	for guid, record in pairs(auraCache) do
		if record.generation ~= generation then
			auraCache[guid] = nil
		end
	end
	wipe(dirtyGUIDs)
	generation = generation + 1
end

function BuffWindow.MarkAurasDirty(unit)
	local guid = UnitGUID(unit)
	if guid and ns.IsPlain(guid) then
		dirtyGUIDs[guid] = true
	else
		BuffWindow.MarkAllAurasDirty()
	end
end

function BuffWindow.ReadAuras(unit)
	local guid = UnitGUID(unit)
	local record = uncachedRecord
	if guid and ns.IsPlain(guid) then
		record = auraCache[guid]
		if record and record.generation == generation and not dirtyGUIDs[guid] then
			auraExpires, auraDurations, auraMine = record.expires, record.durations, record.mine
			return
		end
		record = record or NewRecord()
		record.generation = generation
		auraCache[guid] = record
		dirtyGUIDs[guid] = nil
	end

	auraExpires, auraDurations, auraMine = record.expires, record.durations, record.mine
	wipe(auraExpires)
	wipe(auraDurations)
	wipe(auraMine)
	for i = 1, 40 do
		local data = C_UnitAuras.GetBuffDataByIndex(unit, i, "HELPFUL")
		if not data then
			return
		end
		if ns.IsPlain(data.spellId) and data.spellId then
			local expires, duration = data.expirationTime, data.duration
			auraExpires[data.spellId] = ns.IsPlain(expires) and expires or 0
			auraDurations[data.spellId] = ns.IsPlain(duration) and duration or 0
			local source = data.sourceUnit
			if ns.IsPlain(source) and source == "player" then
				auraMine[data.spellId] = true
			end
		end
	end
end

--[[
    The role a player is buffed as, for a buff offered to Tanks or Healers: the
    raid's Main Tank mark, then the role picked in the group finder. Anyone with
    neither -- a low-level player who can't pick a role yet, a group that never
    set one, or a stranger (`unit` nil when out of sight) -- counts as damage,
    since a class says nothing about what a player is doing. Both group calls are
    asked for by name, so a client without one simply skips to the next answer.
]]
function BuffWindow.RoleOf(unit)
	if unit then
		if GetPartyAssignment and GetPartyAssignment("MAINTANK", unit) then
			return "TANK"
		end
		if UnitGroupRolesAssigned then
			local role = UnitGroupRolesAssigned(unit)
			if ns.IsPlain(role) and (role == "TANK" or role == "HEALER") then
				return role
			end
		end
	end
	return "DAMAGER"
end

-- Is this player someone the buff is offered to at all, whatever they have on?
function BuffWindow.Wants(buff, class, role)
	if buff.manaOnly and Data.NO_MANA_CLASSES[class] then
		return false
	end
	if buff.noCasters and Data.CASTER_CLASSES[class] then
		return false
	end
	if buff.audience == Data.BUFF_AUDIENCE.TANK then
		return role == "TANK"
	elseif buff.audience == Data.BUFF_AUDIENCE.HEALER then
		return role == "HEALER"
	end
	return true
end

--[[
    Asked after ReadAuras(unit) for the same unit. A buff about to run out --
    under the player's "Refresh Under" time -- counts as missing, so it
    can be topped up before it drops. A buff with no timer never runs out, and
    one whose whole duration is no longer than that time only counts once it is
    gone: otherwise a 10-minute Thorns under a 10-minute setting would read as
    missing the moment it landed, and never stop.

    A single-target rank lower than the one you would cast on `unit` -- the
    highest you know that their level can take -- counts as missing too, so a
    stranger's Rank 2 Arcane Intellect doesn't hide your Rank 5. Group and
    Greater versions always count: they aren't ranked against the single ones.

    An exclusive buff (a blessing) also counts as had when the unit carries
    ANOTHER of yours from the same family, even one running low: you can only
    have one on them, so casting this one would replace yours rather than add
    to it. With none of yours on them, every one you turned on is offered.
]]
local function Has(buff, unit)
	local now = GetTime()
	-- A self buff carries its own time; every other buff uses the window's.
	local threshold = buff.refreshSeconds or BuffWindow.refreshSeconds
	local best = RankFor(buff, unit and UnitLevel(unit))
	for id in pairs(buff.auraIds) do
		local expires = auraExpires[id]
		local level = buff.rankLevels[id]
		if expires and not (best and level and level < best.level) then
			if expires == 0 or auraDurations[id] <= threshold or expires - now >= threshold then
				return true
			end
		end
	end
	if buff.exclusive then
		for id in pairs(exclusiveIds[buff.exclusive]) do
			if auraMine[id] and not buff.auraIds[id] then
				return true
			end
		end
	end
	return false
end
BuffWindow.Has = Has

--[[
    A pet in Phase Shift (a warlock's imp) can't be targeted, so no buff
    reaches it until it phases back in, however close it stands. Secret auras
    on WoW Forever read as not shifted.
]]
local function IsPhaseShifted(unit)
	local spellId = ns.GAME_IDS.PHASE_SHIFT_SPELL_ID
	if not spellId or ns.AreAurasSecret() then
		return false
	end
	local isPlayer = UnitIsPlayer(unit)
	if not ns.IsPlain(isPlayer) or isPlayer then
		return false
	end
	return ns.GetBuffDuration(unit, spellId) ~= nil
end

--[[
    Is `unit` close enough to take `spellName`? A phase-shifted pet never is.
    Otherwise the spell's own range check first; when it has no answer,
    UnitInRange's group-wide ~40 yards, which only knows about group members. A unit we can't ask about reads as in range, and so does any
    secret answer (WoW Forever's for a stranger): the fade is a hint, and a
    wrong "out of range" would hide a buff the player could have cast.
]]
function ns.IsBuffInRange(unit, spellName)
	if not unit then
		return true
	end
	local isPlayer = UnitIsUnit(unit, "player")
	if not ns.IsPlain(isPlayer) or isPlayer then
		return true
	end
	if IsPhaseShifted(unit) then
		return false
	end
	if spellName then
		local inRange = C_Spell.IsSpellInRange(spellName, unit)
		if ns.IsPlain(inRange) and inRange ~= nil then
			return inRange and true or false
		end
	end
	local visible = UnitIsVisible(unit)
	if not ns.IsPlain(visible) then
		return true
	end
	if not visible then
		return false
	end
	local inRange, checked = UnitInRange(unit)
	if ns.IsPlain(checked) and ns.IsPlain(inRange) and checked then
		return inRange and true or false
	end
	return true
end

--------------------------------------------------------------------------------
-- Labels
--------------------------------------------------------------------------------

-- A pet's inline icon in front of its name, sized to the small font.
local LABEL_ICON_SIZE = 14

--[[
    The group finder's round role icons, cut from its 64-pixel sheet (as pixels,
    the way the |T escape wants them): left, right, top, bottom.
]]
local ROLE_ICON_SHEET = "Interface/LFGFrame/UI-LFG-ICON-PORTRAITROLES"
local ROLE_ICON_COORDS = {
	TANK = "0:19:22:41",
	HEALER = "20:39:1:20",
	DAMAGER = "20:39:22:41",
}

local function RoleIcon(role)
	return ("|T%s:%d:%d:0:0:64:64:%s|t "):format(
		ROLE_ICON_SHEET,
		Data.BUFF_WINDOW_ICON_SIZE,
		Data.BUFF_WINDOW_ICON_SIZE,
		ROLE_ICON_COORDS[role]
	)
end

--[[
    A player's row label: role icon, then the name in its class color -- the
    color already says the class, so the icon says the role. `unit` is nil for
    a stranger out of sight, who is shown as damage.
]]
function BuffWindow.PlayerLabel(name, class, unit)
	return RoleIcon(BuffWindow.RoleOf(unit))
		.. "|cff"
		.. (Data.CLASS_COLORS[class] or ns.PALETTE.TEXT)
		.. name
		.. "|r"
end

--[[
    A pet's row label: its summoning spell's icon, then the name in its owner's
    class color. A warlock's demon is told apart by the creature ID in its GUID
    ("Pet-0-server-instance-zone-npc-spawn"); every other pet wears Call Pet.
]]
local function PetNPCID(unit)
	local guid = UnitGUID(unit)
	return ns.IsPlain(guid) and guid and tonumber(guid:match("^%a+%-%d+%-%d+%-%d+%-%d+%-(%d+)%-")) or nil
end

--[[
    The class of a pet's owner, read off the pet: a known demon is a warlock's,
    and a pet that runs on Focus is a hunter's beast. The tooltip's "'s Pet" or
    "'s Minion" (`guessed`) is the last resort only -- on Classic Era it named
    the owner without matching the wording that gives the class away.
]]
function BuffWindow.PetOwnerClass(unit, guessed)
	local npcID = PetNPCID(unit)
	if npcID and ns.BUFF_WINDOW_PET_ICONS.demons[npcID] then
		return "WARLOCK"
	end
	local powerType = UnitPowerType(unit)
	if ns.IsPlain(powerType) and Enum.PowerType.Focus and powerType == Enum.PowerType.Focus then
		return "HUNTER"
	end
	return guessed
end

local function PetLabel(unit, name, ownerClass)
	local icons = ns.BUFF_WINDOW_PET_ICONS
	local npcID = PetNPCID(unit)
	local spell = (npcID and icons.demons[npcID]) or icons.beast
	local texture = spell and C_Spell.GetSpellTexture(spell)
	-- The same 5-pixel trim the window's buttons give every spell icon's border.
	local icon = texture
			and ("|T" .. texture .. ":" .. LABEL_ICON_SIZE .. ":" .. LABEL_ICON_SIZE .. ":0:0:64:64:5:59:5:59|t ")
		or ""
	return icon .. "|cff" .. (Data.CLASS_COLORS[ownerClass] or ns.PALETTE.HELP) .. name .. "|r"
end

--------------------------------------------------------------------------------
-- Icons
--------------------------------------------------------------------------------

--[[
    /targetexact finds a nearby player by name with no unit token. [help] stops
    the cast when that fails, so it never falls through to whatever you had
    targeted or to yourself. Leaving them targeted is deliberate: it is how the
    window sees the buff land and drops the icon.
]]
local function TargetMacro(name, castText)
	return "/targetexact " .. name .. "\n/cast [help] " .. castText
end

--[[
    One single-target icon, sized to the target: `unit` is who it is for (nil
    when out of sight), `castUnit` the token the button casts at. Without a
    castUnit the button targets `fullName` by macro instead. The button casts
    the chosen rank by its rank text, "Power Word: Fortitude(Rank 2)": a bare
    name casts your highest rank and fails on anyone too low for it, and a
    spell ID did nothing at all on Classic Era. Nil when the target is too low
    for any rank.
]]
local function SingleIcon(buff, unit, castUnit, targetName, fullName, favorGUID)
	local rank = RankFor(buff, unit and UnitLevel(unit))
	if not rank then
		return nil
	end
	return {
		spellId = rank.id,
		column = buff.column,
		spellName = rank.name,
		castSpell = rank.castText,
		unit = castUnit,
		targetName = targetName,
		macrotext = not castUnit and TargetMacro(fullName, rank.castText) or nil,
		favorGUID = favorGUID,
	}
end
BuffWindow.SingleIcon = SingleIcon

--------------------------------------------------------------------------------
-- Pets
--------------------------------------------------------------------------------

--[[
    Whether pets count as tanks right now, per "Consider Pets as Tanks": solo,
    a pet is usually what holds aggro; in a group, someone else usually is.
]]
local function PetsAreTanks()
	local db = ns.db.profile.buffWindow
	return db.petsAsTanks and (db.petsAsTanksWhen == Data.PETS_AS_TANKS.ALWAYS or not IsInGroup())
end

--[[
    A pet takes the buffs offered to Everyone, and those offered to Tanks while
    "Consider Pets as Tanks" applies -- never those for Healers. It has no role of
    its own, and its "class" is the creature's, not a player class. Whether it has mana is read off its power bar instead, so a
    warlock's demon gets Intellect and a hunter's beast doesn't.
]]
local function PetWants(buff, unit)
	if buff.audience == Data.BUFF_AUDIENCE.TANK then
		if not PetsAreTanks() then
			return false
		end
	elseif buff.audience ~= Data.BUFF_AUDIENCE.ALL then
		return false
	end
	if buff.manaOnly then
		local powerType = UnitPowerType(unit)
		return ns.IsPlain(powerType) and powerType == Enum.PowerType.Mana
	end
	return true
end

local function CanBuffPet(unit)
	return UnitExists(unit) and not UnitIsPlayer(unit) and not UnitIsDeadOrGhost(unit)
end
BuffWindow.CanBuffPet = CanBuffPet

-- The pet token that goes with a group member's token.
function BuffWindow.PetUnitOf(unit)
	if unit == "player" then
		return "pet"
	end
	local prefix, index = unit:match("^(%a+)(%d+)$")
	return prefix and (prefix .. "pet" .. index) or nil
end

--[[
    A pet's row: its missing buffs, cast at `castUnit` (the pet's own token in
    the party list, "target" or "targetpet" in the Target list). Nil when it
    needs nothing. Under its owner it is indented and named alone; standing on
    its own (a targeted stranger's pet) it carries `ownerName` in brackets
    instead, "Valko (Kiib)", since the owner has no row of their own above it.
]]
function BuffWindow.PetRow(unit, castUnit, ownerClass, ownerName)
	if not unit or not CanBuffPet(unit) then
		return nil
	end
	BuffWindow.ReadAuras(unit)
	local name = GetUnitName(unit, false) or ""
	local icons = {}
	for _, buff in ipairs(buffs) do
		if buff.singleName and PetWants(buff, unit) and not Has(buff, unit) then
			icons[#icons + 1] = SingleIcon(buff, unit, castUnit, name)
		end
	end
	if #icons == 0 then
		return nil
	end
	if ownerName then
		return { label = PetLabel(unit, name .. " (" .. ownerName .. ")", ownerClass), icons = icons }
	end
	return { label = PetLabel(unit, name, ownerClass), icons = icons, pet = true }
end
