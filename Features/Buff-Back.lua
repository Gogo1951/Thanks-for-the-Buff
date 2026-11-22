local _, ns = ...
local Data = ns.Data

--[[
    Return Buff: an account-wide macro, "- Return Buff", that casts one of your
    own buffs on the last player outside your group who buffed you. It sits in
    the account's macros, like the Thank You macros, so it never takes one of a
    character's 18 slots; whichever character logs in rewrites it with its own
    buff and target (ns.ReconcileMacros runs at login). Praise names
    that player as each stranger's buff lands; the macro is rewritten to aim at
    them, out of combat only, since the game refuses macro edits in combat. An
    edit held back by combat goes through when it ends.

    The buffs on offer are this class's in Data.RETURN_BUFF_SPELLS and its Good
    News rows that leave a buff, those this character knows. The macro casts by
    name, so the highest rank known goes out. The options panel is Give Thanks >
    Return Buff (Options/Options-Return-Buff.lua).
]]

local pending = false

local function Settings()
	return ns.db and ns.db.profile.buffBack
end

local function Knows(spellIds)
	for _, spellId in ipairs(spellIds) do
		if IsPlayerSpell(spellId) then
			return true
		end
	end
	return false
end

-- Each offered buff's rank IDs, keyed by the ID it is offered under; filled by ns.GetBuffBackChoices.
local ranksByChoice = {}

--[[
    The buffs this character can cast with Return Buff: spell ID → "|T icon|t
    Name", and their order by name. Read fresh each time: a character learns
    spells as it levels. Data.RETURN_BUFF_SPELLS holds the everyday buffs
    (Mark of the Wild, Fortitude); the class's Good News buffs add the rest
    (Power Infusion, Fear Ward). One entry per name, since the macro casts by name.
]]
function ns.GetBuffBackChoices()
	local values, sorting, named = {}, {}, {}
	local function Add(ranks)
		local spellId = ranks[1]
		local name = C_Spell.GetSpellName(spellId)
		if name and not named[name] then
			named[name] = true
			local icon = C_Spell.GetSpellTexture(spellId)
			values[spellId] = (icon and ("|T" .. icon .. ":16|t ") or "") .. name
			sorting[#sorting + 1] = spellId
			ranksByChoice[spellId] = ranks
		end
	end

	local _, class = UnitClass("player")
	for _, ranks in ipairs(Data.RETURN_BUFF_SPELLS[class] or {}) do
		local known = {}
		for _, spellId in ipairs(ranks) do
			if C_Spell.DoesSpellExist(spellId) and IsPlayerSpell(spellId) then
				known[#known + 1] = spellId
			end
		end
		if known[1] then
			Add(known)
		end
	end
	for _, info in ipairs(ns.GetGoodNewsRows()) do
		local row = info.row
		if row.class == class and row.detect == Data.GOOD_NEWS_DETECT.AURA and Knows(info.spellIds) then
			Add(info.spellIds)
		end
	end
	table.sort(sorting, function(a, b)
		return C_Spell.GetSpellName(a) < C_Spell.GetSpellName(b)
	end)
	return values, sorting
end

--[[
    The picked buff's spell ID, or nil while this character can cast none. The
    pick is kept per character, like the target: each class has its own buffs.
]]
local function PickedSpell()
	local values, sorting = ns.GetBuffBackChoices()
	local spellId = ns.db and ns.db.char.buffBackSpell
	if not (spellId and values[spellId]) then
		-- Nothing picked yet, or a buff this character can't cast: the first on offer, so switching it on makes the macro.
		spellId = sorting[1]
		if not spellId then
			return nil
		end
		ns.db.char.buffBackSpell = spellId
	end
	return spellId
end

--[[
    The rank of the picked buff the last buffer can take, as the spell ID and
    the rank text the macro adds ("Rank 2"), or no text for your highest rank.
    A rank lands only on a player no more than Data.RETURN_BUFF_RANK_GAP levels
    below the level it's learned at, on Wrath and earlier; later clients have
    no ranks. Without the buffer's level it's your highest rank, and a player
    too low for every rank gets the lowest, so the game says why it failed.
]]
local HAS_RANK_GAP = (ns.EXPANSION or 1) <= 3

function ns.GetBuffBackRank(spellId)
	local name = C_Spell.GetSpellName(spellId)
	local level = ns.db and ns.db.char.buffBackTargetLevel
	if not (name and HAS_RANK_GAP and level and C_Spell.GetSpellLevelLearned) then
		return spellId, nil
	end
	local ranks = {}
	for _, id in ipairs(ranksByChoice[spellId] or { spellId }) do
		if IsPlayerSpell(id) and C_Spell.GetSpellName(id) == name then
			local learned = C_Spell.GetSpellLevelLearned(id)
			if learned and learned > 0 then
				ranks[#ranks + 1] = { id = id, level = learned }
			end
		end
	end
	if #ranks < 2 then
		return spellId, nil
	end
	table.sort(ranks, function(a, b)
		return a.level > b.level
	end)
	local pick = ranks[#ranks]
	for _, rank in ipairs(ranks) do
		if level >= rank.level - Data.RETURN_BUFF_RANK_GAP then
			pick = rank
			break
		end
	end
	if pick == ranks[1] then
		return pick.id, nil
	end
	local text = C_Spell.GetSpellSubtext(pick.id)
	return pick.id, (text and text ~= "") and text or nil
end

-- What the macro types to cast the picked buff: "Power Word: Fortitude(Rank 2)", or the bare name for your highest.
local function CastText(spellId)
	local _, rankText = ns.GetBuffBackRank(spellId)
	local name = C_Spell.GetSpellName(spellId)
	return rankText and (name .. "(" .. rankText .. ")") or name
end

--[[
    Targets the last stranger who buffed you by name, casts, then goes back to
    your own target. A [target=Name] condition would be shorter, but the game
    resolves a name there only for a party or raid member, and a stranger is
    neither. Until a stranger has buffed you, a plain cast on your target.
]]
local function MacroBody(castText)
	local target = ns.db.char.buffBackTarget
	if target then
		return "/targetexact " .. target .. "\n/cast " .. castText .. "\n/targetlasttarget"
	end
	return "/cast " .. castText
end

--[[
    Bring the macro in line with the settings: create it while switched on and
    a buff is picked, aim it at the last buffer, and delete it when switched
    off. In combat it waits for PLAYER_REGEN_ENABLED.
]]
function ns.ReconcileBuffBack()
	local settings = Settings()
	if not settings then
		return
	end
	if InCombatLockdown() then
		pending = true
		return
	end
	pending = false

	local index = GetMacroIndexByName(Data.BUFF_BACK_MACRO)
	-- An earlier build made it per character; that copy goes, and the account-wide one replaces it.
	if index > Data.MAX_GLOBAL_MACROS then
		DeleteMacro(index)
		index = 0
	end
	--[[
	    A character with no buff to cast (a Warrior) leaves the macro as the last
	    one wrote it: deleting it would take it off every character's bars.
	]]
	local spellId = settings.enabled and PickedSpell()
	if not spellId then
		if not settings.enabled and index > 0 then
			DeleteMacro(index)
		end
		return
	end

	local body = MacroBody(CastText(spellId))
	local icon = Data.THANK_YOU_DEFAULT_ICON
	if index == 0 then
		if GetNumMacros() < Data.MAX_GLOBAL_MACROS then
			CreateMacro(Data.BUFF_BACK_MACRO, icon, body, nil)
		end
	elseif GetMacroBody(index) ~= body or select(2, GetMacroInfo(index)) ~= icon then
		EditMacro(index, nil, icon, body)
	end
end

--[[
    The level of the player with this GUID, while the game shows TFTB a unit
    for them: a group member, your target, focus or mouseover, or a nameplate.
    Nil when none does, or when the game keeps it secret (WoW Forever, in combat).
]]
local function LevelOf(guid)
	if not guid or not ns.IsPlain(guid) then
		return nil
	end
	local unit = ns.GetUnitByGUID(guid)
	if not unit then
		for i = 1, 40 do
			local plate = "nameplate" .. i
			if UnitExists(plate) and ns.UnitHasGUID(plate, guid) then
				unit = plate
				break
			end
		end
	end
	local level = unit and UnitLevel(unit)
	if level and ns.IsPlain(level) and level > 0 then
		return level
	end
	return nil
end

-- Praise's hook: the stranger who just buffed you becomes the macro's target, at their level.
function ns.SetBuffBackTarget(name, guid)
	if not ns.db or not ns.IsPlain(name) or not name or name == "" then
		return
	end
	local level = LevelOf(guid) or false
	local char = ns.db.char
	if char.buffBackTarget == name and char.buffBackTargetLevel == level then
		return
	end
	char.buffBackTarget, char.buffBackTargetLevel = name, level
	local settings = Settings()
	if settings and settings.enabled then
		ns.ReconcileBuffBack()
	end
end

--[[
    True while Return Buff is on with a buff to cast but its macro is missing
    because the account's macro slots are full, so the panel can say so
    instead of leaving Pick Up Macro gray with no reason.
]]
function ns.IsBuffBackBlockedByMacroCap()
	local settings = Settings()
	if not (settings and settings.enabled) or GetMacroIndexByName(Data.BUFF_BACK_MACRO) > 0 then
		return false
	end
	return #select(2, ns.GetBuffBackChoices()) > 0 and GetNumMacros() >= Data.MAX_GLOBAL_MACROS
end

-- The player Return Buff aims at, or nil before anyone has buffed this character.
function ns.GetBuffBackTarget()
	return ns.db and ns.db.char.buffBackTarget or nil
end

-- That player's level when their buff landed, or nil when TFTB couldn't see it.
function ns.GetBuffBackTargetLevel()
	return ns.db and ns.db.char.buffBackTargetLevel or nil
end

ns.SetEventHandler("PLAYER_REGEN_ENABLED", function()
	if pending then
		ns.ReconcileBuffBack()
	end
end)
