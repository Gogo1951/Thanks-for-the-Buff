local _, ns = ...
local L = ns.L

--[[
    The Buff Keys: two key bindings that cast the next buff on Buff Duty's
    list, one press at a time, the way Pally Power's auto-buff keys do.

        Individual Buff Button: a resurrection on your dead target, then on
        your group's dead (priests, paladins and shamans), then your
        self-buffs, then Return the Favor, then single-target buffs -- your
        target first, then your group.

        Group Buff Button: the same resurrections and self-buffs, then group
        buffs -- your target's party first, then the others. A party waits
        until everyone missing the buff is in range, so a cast never leaves
        someone out and costs a second reagent.

    Each key is a hidden SecureActionButtonTemplate button bound by
    Bindings.xml ("CLICK <button>:LeftButton"), and a macro reaches the same
    button with "/click TFTBBuffIndividual" or "/click TFTBBuffGroup" -- the
    way Pally Power's macros click its buttons. A slash command of our own
    can't do it: the game only lets its own secure code cast, and an add-on's
    command never is. Casting from a key press is
    protected, so the pick happens in PreClick: it reads the group fresh,
    builds the same sections the window draws (ns.BuffWindow.BuildSections),
    writes the first castable icon's attributes onto the button, and the
    secure template casts it. PostClick clears them again. All of it needs
    combat to be over -- a secure button's attributes are locked in combat
    -- so a press mid-fight does nothing.
]]

local BuffWindow = ns.BuffWindow

-- The buttons' global names, which a macro's /click types.
local SINGLE_BUTTON, GROUP_BUTTON = "TFTBBuffIndividual", "TFTBBuffGroup"

--[[
    The binding commands, as Bindings.xml names them; the options panel binds
    keys to these.
]]
ns.BUFF_KEY_COMMANDS = {
	SINGLE = "CLICK " .. SINGLE_BUTTON .. ":LeftButton",
	GROUP = "CLICK " .. GROUP_BUTTON .. ":LeftButton",
}

-- The macro line for each key, shown under its binding on the options panel.
ns.BUFF_KEY_MACROS = {
	SINGLE = "/click " .. SINGLE_BUTTON,
	GROUP = "/click " .. GROUP_BUTTON,
}

-- The names the game's Key Bindings list shows.
BINDING_HEADER_TFTB = L["ADDON_TITLE"]
_G["BINDING_NAME_" .. ns.BUFF_KEY_COMMANDS.SINGLE] = L["BUFF_KEY_SINGLE"]
_G["BINDING_NAME_" .. ns.BUFF_KEY_COMMANDS.GROUP] = L["BUFF_KEY_GROUP"]

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

--[[
    How long a cast the keys just made keeps them off that player and buff.
    A buff only needs to bridge the moment before its aura shows up; a
    resurrection waits out the minute its target has to accept it.
]]
local BUFF_SKIP_SECONDS = 3
local RESURRECTION_SKIP_SECONDS = 60
--[[
    A Return the Favor icon targets the stranger by name, and simply fails
    when they've moved off. The key moves past them for this long after a
    press, so one stranger out of reach doesn't stall the list; a cast that
    does go off is then held for BUFF_SKIP_SECONDS like any other
    (ns.OnBuffKeyCastSucceeded).
]]
local FAVOR_RETRY_SECONDS = 30
-- How long a press waits to hear its cast went off; a Resurrection takes 10 seconds.
local PENDING_SECONDS = 15
-- Under this, a cooldown is only the global one.
local GLOBAL_COOLDOWN = 1.5

local recent = {} -- "<GUID or party>:<spell name>" -> GetTime() it stops being skipped
local pending -- { key, ids, seconds, expires }: the last press, until its cast goes off

local GetItemCooldown = C_Container.GetItemCooldown
local IsSpellUsable = C_Spell.IsSpellUsable

--------------------------------------------------------------------------------
-- Candidates
--------------------------------------------------------------------------------

--[[
    Your target, if they're a friendly dead player you can bring back -- in
    your group or not. BuffWindow.ResurrectionIcon says who can take one.
]]
local function ResurrectionSpec()
	if not UnitExists("target") or not UnitIsFriend("player", "target") then
		return nil
	end
	return BuffWindow.ResurrectionIcon("target", "target", GetUnitName("target", false) or "")
end

-- Your target's party, or nil when your target isn't in your group.
local function TargetSubgroup()
	if not UnitExists("target") then
		return nil
	end
	for _, member in ipairs(BuffWindow.GroupMembers()) do
		if UnitIsUnit(member.unit, "target") then
			return member.subgroup
		end
	end
	return nil
end

--[[
    Every icon the key could cast, in the order it should: resurrections,
    self-buffs, then (Individual) Return the Favor, your target, and every
    party's members, or (Group) your target's party's group buffs and then
    every other party's.
]]
local function Candidates(sections, group)
	local list, added = {}, {}
	--[[
	    Weapon icons are never candidates: putting a poison or oil on, and
	    answering the game's "replace your enchant?" question, is a click on
	    the window, not a key run through a list.
	]]
	local function Add(spec)
		if spec and not spec.weapon and not added[spec] then
			added[spec] = true
			list[#list + 1] = spec
		end
	end
	local function AddRows(section, onlyTarget)
		for _, row in ipairs(section.rows) do
			for _, spec in ipairs(row.icons) do
				if not onlyTarget or (spec.unit and UnitIsUnit(spec.unit, "target")) then
					Add(spec)
				end
			end
		end
	end
	local function Each(kind, handler)
		for _, section in ipairs(sections) do
			if section.kind == kind then
				handler(section)
			end
		end
	end

	-- Resurrections before anything else: your dead target, then your group's dead.
	Add(ResurrectionSpec())
	Each("party", function(section)
		for _, row in ipairs(section.rows) do
			for _, spec in ipairs(row.icons) do
				if spec.isResurrection then
					Add(spec)
				end
			end
		end
	end)
	Each("self", function(section)
		for _, spec in ipairs(section.icons) do
			Add(spec)
		end
	end)

	if group then
		local targetSubgroup = TargetSubgroup()
		Each("party", function(section)
			if section.subgroup == targetSubgroup then
				for _, spec in ipairs(section.icons) do
					Add(spec)
				end
			end
		end)
		Each("party", function(section)
			for _, spec in ipairs(section.icons) do
				Add(spec)
			end
		end)
	else
		Each("favor", AddRows)
		Each("target", AddRows)
		Each("party", function(section)
			AddRows(section, true)
		end)
		Each("party", AddRows)
	end
	return list
end

--------------------------------------------------------------------------------
-- Picking
--------------------------------------------------------------------------------

--[[
    What a press remembers a cast by: who it went on (a party, for a group
    buff) and the spell's name. Nil for an item (a Soulstone), whose result
    the window reads straight off your bags and the group's auras.
]]
local function SkipKey(spec)
	local name = spec.spellName
	if not name then
		return nil
	end
	if spec.subgroup then
		return "party" .. spec.subgroup .. ":" .. name
	end
	--[[
	    Its own key: the favor's macro targets the stranger, and if the cast
	    then fails (a press inside the global cooldown) the Target section's
	    icon for them shouldn't wait out the favor's retry.
	]]
	if spec.favorGUID then
		return "favor:" .. spec.favorGUID .. ":" .. name
	end
	local guid = spec.unit and UnitGUID(spec.unit)
	if guid and ns.IsPlain(guid) then
		return guid .. ":" .. name
	end
	return nil
end

local function OnCooldown(start, duration)
	return ns.IsPlain(start)
		and ns.IsPlain(duration)
		and start
		and duration
		and duration > GLOBAL_COOLDOWN
		and start + duration > GetTime()
end

--[[
    "cooldown" for a spell or item that can't go off for a while yet (a used
    Soulstone, Fear Ward), "unusable" for one the client refuses for any
    reason but mana (no reagent, no Soul Shard), otherwise "ready". Short on
    mana still counts as ready: the cast's own error says so.
]]
local function Readiness(spec)
	if spec.itemId then
		if OnCooldown(GetItemCooldown(spec.itemId)) then
			return "cooldown"
		end
		return "ready"
	end
	local info = C_Spell.GetSpellCooldown(spec.spellId)
	if info and OnCooldown(info.startTime, info.duration) then
		return "cooldown"
	end
	local usable, noMana = IsSpellUsable(spec.spellId)
	if ns.IsPlain(usable) and ns.IsPlain(noMana) and not usable and not noMana then
		return "unusable"
	end
	return "ready"
end

--[[
    Whether the cast can reach everyone it's for, and if not, the name of
    someone it's waiting on. A group buff needs every member missing it in
    range; a member who already has it, or is dead or offline, doesn't hold
    the party up.
]]
local function Reachable(spec)
	if spec.members then
		for _, unit in ipairs(spec.members) do
			if not ns.IsBuffInRange(unit, spec.spellName) then
				return false, GetUnitName(unit, false)
			end
		end
		return true
	end
	if ns.IsBuffSpecInRange(spec) then
		return true
	end
	return false, spec.targetName
end

--[[
    The first candidate that is ready and in reach. With none, the first one
    the client refuses, so its own error ("Missing reagent") says why the key
    did nothing; failing that, nil and whoever the list is waiting on.
]]
local function PickNext(group)
	local db = ns.db and ns.db.profile.buffWindow
	if not BuffWindow.isSetUp or not db or not db.enabled or ns.AreAurasSecret() then
		return nil
	end
	if UnitIsDeadOrGhost("player") then
		return nil
	end

	-- A cast a moment ago may not be in the cache yet; read everyone fresh.
	BuffWindow.MarkAllAurasDirty()
	local candidates = Candidates(BuffWindow.BuildSections(), group)
	local now = GetTime()
	local refused, waitingOn
	for _, spec in ipairs(candidates) do
		local key = SkipKey(spec)
		if not (key and recent[key] and recent[key] > now) then
			local readiness = Readiness(spec)
			if readiness ~= "cooldown" then
				local inReach, waiting = Reachable(spec)
				if not inReach then
					waitingOn = waitingOn or waiting
				elseif readiness == "ready" then
					return spec
				else
					refused = refused or spec
				end
			end
		end
	end
	return refused, waitingOn
end

--------------------------------------------------------------------------------
-- Remembering Casts
--------------------------------------------------------------------------------

local function Remember(spec)
	local now = GetTime()
	for key, expires in pairs(recent) do
		if expires <= now then
			recent[key] = nil
		end
	end
	local key = SkipKey(spec)
	if not key then
		pending = nil
		return
	end
	if spec.favorGUID then
		recent[key] = now + FAVOR_RETRY_SECONDS
	end
	local ids = {}
	for _, id in ipairs(spec.castIds or { spec.spellId }) do
		ids[id] = true
	end
	pending = {
		key = key,
		ids = ids,
		seconds = spec.isResurrection and RESURRECTION_SKIP_SECONDS or BUFF_SKIP_SECONDS,
		expires = now + PENDING_SECONDS,
	}
end

--[[
    Called from Buff-Tracking's UNIT_SPELLCAST_SUCCEEDED handler, which owns
    the event. The cast is matched by spell ID against every rank the press
    could go off as, since a group buff or a resurrection is cast by its bare
    name and resolves to whichever rank you know.
]]
function ns.OnBuffKeyCastSucceeded(unit, spellID)
	if not pending or not ns.IsPlain(unit) or unit ~= "player" or not ns.IsPlain(spellID) then
		return
	end
	local now = GetTime()
	if now > pending.expires then
		pending = nil
		return
	end
	if pending.ids[spellID] then
		recent[pending.key] = now + pending.seconds
		pending = nil
	end
end

--------------------------------------------------------------------------------
-- Buttons
--------------------------------------------------------------------------------

--[[
    A key press reaches the button twice, down and up, while a macro's
    /click sends a single up. The buttons set useOnKeyDown to false (below),
    so the secure template acts on the up half for both, whatever
    ActionButtonUseKeyDown says -- otherwise a key-down player's /click
    would cast nothing. Both halves write the attributes, so a client that
    acted on the other half would still cast; only the up half remembers
    the cast and shows a message.
]]
local function OnKeyPreClick(self, _, down)
	local acting = not down
	if InCombatLockdown() then
		if acting then
			UIErrorsFrame:AddMessage(ERR_NOT_IN_COMBAT, 1, 0.1, 0.1)
		end
		return
	end
	local spec, waitingOn = PickNext(self.isGroup)
	ns.SetBuffButtonAttributes(self, spec)
	if not acting then
		return
	end
	if spec then
		Remember(spec)
	elseif waitingOn then
		UIErrorsFrame:AddMessage(L["BUFF_KEY_WAITING"]:format(waitingOn), 1, 0.82, 0)
	else
		UIErrorsFrame:AddMessage(L["BUFF_KEY_DONE"], 1, 0.82, 0)
	end
end

local function OnKeyPostClick(self)
	if not InCombatLockdown() then
		ns.SetBuffButtonAttributes(self, nil)
	end
end

local function CreateKeyButton(name, isGroup)
	local button = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
	button.isGroup = isGroup
	-- Both halves, as the window's own buttons do; see OnKeyPreClick.
	button:RegisterForClicks("AnyUp", "AnyDown")
	button:SetAttribute("useOnKeyDown", false)
	button:SetScript("PreClick", OnKeyPreClick)
	button:SetScript("PostClick", OnKeyPostClick)
	button:Hide()
	return button
end

CreateKeyButton(SINGLE_BUTTON, false)
CreateKeyButton(GROUP_BUTTON, true)
