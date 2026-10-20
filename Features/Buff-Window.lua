local _, ns = ...
local L = ns.L

--[[
    The Buff Window -- who in your group is missing a buff YOU can give.

    Reads this client's ns.BUFF_WINDOW_SPELLS, keeps the rows for your class
    whose spells you know, and on every roster or aura change works out, per
    party, which members lack each buff. What it finds goes to
    Features/Buff-Window-Frame.lua as plain section tables to draw; no Buff
    Window logic file owns a frame. A member only appears while they are
    missing something, and a party only while one of its members is, so a fully
    buffed raid shows no window at all.

    The work is split six ways, sharing state through ns.BuffWindow:
    Buff-Window-Castable.lua (what you can cast), Buff-Window-Units.lua
    (reading one unit and building its icons), Buff-Window-Self.lua (your own
    buffs, weapons and Soulstone, pinned on top), Buff-Window-Outsiders.lua
    (your target, and strangers who just buffed you, listed above the parties),
    this file (your group's sections, the refresh, events and setup), and
    Buff-Window-Keys.lua (the two key bindings that cast from the same list).

    Nothing is read in combat: the window's buttons are secure and can't be
    redrawn there anyway (see the frame file), so a change mid-fight waits for
    PLAYER_REGEN_ENABLED.
]]

local BuffWindow = ns.BuffWindow
local buffs = BuffWindow.buffs
local HasAnythingToOffer = BuffWindow.HasAnythingToOffer
local GroupMembers = BuffWindow.GroupMembers
local CanBuff = BuffWindow.CanBuff
local ReadAuras = BuffWindow.ReadAuras
local RoleOf = BuffWindow.RoleOf
local Wants = BuffWindow.Wants
local Has = BuffWindow.Has
local SingleIcon = BuffWindow.SingleIcon
local PlayerLabel = BuffWindow.PlayerLabel
local PetRow = BuffWindow.PetRow
local PetUnitOf = BuffWindow.PetUnitOf
local MarkAurasDirty = BuffWindow.MarkAurasDirty
local MarkAllAurasDirty = BuffWindow.MarkAllAurasDirty

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local inCombat = false
local settingsPending = false
local refreshQueued = false

-- Long enough to fold a raid-wide buff landing on 40 people into one redraw.
local REFRESH_DELAY = 0.3

--[[
    A redraw on a timer, for the changes no event reaches the window with: a
    buff running down under Refresh Under, and a member dying, reviving or
    dropping offline. Neither needs a full re-read: Has compares cached
    expirations with the clock, and ReadAuras re-reads a record whose unit has
    died, revived or changed connection since it was read.
]]
local BACKSTOP_INTERVAL = 3

--------------------------------------------------------------------------------
-- Group Sections
--------------------------------------------------------------------------------

--[[
    A group buff lands on its target's party, so any member who needs it will
    do; one in range is the one worth clicking.
]]
local function PickGroupTarget(units, spellName)
	for _, unit in ipairs(units) do
		if ns.IsBuffInRange(unit, spellName) then
			return unit
		end
	end
	return units[1]
end

--[[
    One section per party with something missing: the party's group-buff icons
    on its header, then a row per member with their single-target icons. Every
    party gets its own group icon once any of its members is missing the buff
    -- a raid buffs party by party, so a party of one in a raid still needs its
    own. Only solo, outside any group, is there none: the single version does
    the same for no reagent.

    A member's pet sits on its own row under them, and keeps the member listed
    -- with no icons of their own, if they need nothing -- until the pet is
    buffed too. Pets don't count toward a group icon: the group versions are
    cast to be sure of the players.
]]
local function AddGroupSections(sections)
	local grouped = IsInGroup()
	local raid = IsInRaid()
	local parties = {}

	for _, member in ipairs(GroupMembers()) do
		local party = parties[member.subgroup]
		if not party then
			party = { missing = {}, rows = {} }
			parties[member.subgroup] = party
		end

		local unit = member.unit
		local _, class = UnitClass(unit)
		local name = GetUnitName(unit, false) or ""
		local row
		if CanBuff(unit) then
			ReadAuras(unit)
			local role = RoleOf(unit, class)
			for _, buff in ipairs(buffs) do
				if Wants(buff, class, role) and not Has(buff, unit) then
					local missing = party.missing[buff] or {}
					party.missing[buff] = missing
					missing[#missing + 1] = unit
					local icon = buff.singleName and SingleIcon(buff, unit, unit, name)
					if icon then
						row = row or { label = PlayerLabel(name, class, unit), icons = {} }
						row.icons[#row.icons + 1] = icon
					end
				end
			end
		end

		local petRow = PetRow(PetUnitOf(unit), PetUnitOf(unit), class)
		if petRow then
			row = row or { label = PlayerLabel(name, class, unit), icons = {} }
		end
		if row then
			party.rows[#party.rows + 1] = row
		end
		if petRow then
			party.rows[#party.rows + 1] = petRow
		end
	end

	for subgroup = 1, 8 do
		local party = parties[subgroup]
		if party then
			local icons = {}
			for _, buff in ipairs(buffs) do
				local missing = party.missing[buff]
				if buff.groupName and missing and grouped then
					local target = PickGroupTarget(missing, buff.groupName)
					icons[#icons + 1] = {
						spellId = buff.groupId,
						castIds = buff.groupIds,
						column = buff.column,
						spellName = buff.groupName,
						castSpell = buff.groupCastText,
						unit = target,
						targetName = GetUnitName(target, false) or "",
						isGroup = true,
						--[[
						    For the Group Buff key, which casts this only while
						    everyone who needs it stands in range.
						]]
						subgroup = subgroup,
						members = missing,
					}
				end
			end
			if #icons > 0 or #party.rows > 0 then
				sections[#sections + 1] = {
					kind = "party",
					subgroup = subgroup,
					label = raid and GROUP_NUMBER:format(subgroup) or GROUP,
					icons = icons,
					rows = party.rows,
					-- The frame wraps parties into columns of four.
					party = true,
				}
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Refresh
--------------------------------------------------------------------------------

--[[
    Every section the window would show, in display order: your own buffs,
    then the players outside your group (Target, Return the Favor), then the
    parties, which the frame wraps into columns of four in a raid. The Buff
    Keys read the same list, so a key casts only what the window offers.
]]
function BuffWindow.BuildSections()
	BuffWindow.refreshSeconds = (ns.db.profile.buffWindow.refreshMinutes or 0) * 60
	local sections = {}
	BuffWindow.AddSelfSection(sections)
	BuffWindow.AddOutsiderSections(sections)
	AddGroupSections(sections)
	return sections
end

local function Refresh()
	if not BuffWindow.isSetUp or not ns.db then
		return
	end
	-- Combat: the buttons can't be redrawn, and REGEN_ENABLED re-runs this.
	if inCombat or InCombatLockdown() then
		return
	end

	local db = ns.db.profile.buffWindow
	if not db.enabled or not HasAnythingToOffer() or ns.AreAurasSecret() then
		ns.HideBuffWindow()
		return
	end

	local sections = BuffWindow.BuildSections()
	if #sections == 0 then
		ns.HideBuffWindow()
	else
		ns.RenderBuffWindow(sections)
	end
end

-- Every trigger funnels through here, so a burst of them costs one Refresh.
function ns.RequestBuffWindowRefresh()
	if refreshQueued then
		return
	end
	refreshQueued = true
	C_Timer.After(REFRESH_DELAY, function()
		refreshQueued = false
		Refresh()
	end)
end

local function ApplySettings()
	settingsPending = not ns.ApplyBuffWindowSettings()
end

-- The options panel's entry point after any Buff Window setting changes.
function ns.RefreshBuffWindow()
	if not BuffWindow.isSetUp then
		return
	end
	BuffWindow.BuildBuffs()
	ApplySettings()
	MarkAllAurasDirty()
	ns.RequestBuffWindowRefresh()
end

--[[
    The window's close button. Turns Buff Duty off through its feature switch,
    so the options panels and the mini-map button agree, and says how to turn
    it back on. In combat the window stays up until combat ends, like any
    other change to it.
]]
function ns.CloseBuffWindow()
	ns.SetFeatureSwitch("buffWindow", false)
	ns:PrintMessage(L["BUFF_WINDOW_CLOSED"]:format(ns.GetColor("INFO") .. L["OPTIONS_COMMAND"] .. "|r"))
end

-- A change that can move who a unit token names, or what the window offers.
local function RequestFullRefresh()
	MarkAllAurasDirty()
	ns.RequestBuffWindowRefresh()
end

--------------------------------------------------------------------------------
-- Event Handlers
--------------------------------------------------------------------------------

--[[
    Called from Buff-Tracking's UNIT_AURA handler, which owns the event. Core
    registers it unfiltered, so nameplates arrive here too; only the units the
    window reads are worth a refresh. Nothing is queued while the window is off
    or in combat: turning it on and PLAYER_REGEN_ENABLED each request a fresh
    read.
]]
function ns.OnBuffWindowAura(unit)
	if not BuffWindow.isSetUp or inCombat or not ns.db.profile.buffWindow.enabled then
		return
	end
	if not HasAnythingToOffer() or not ns.IsPlain(unit) or not unit then
		return
	end
	if
		unit == "player"
		or unit == "target"
		or unit == "targetpet"
		or unit == "pet"
		or unit:find("^party%d")
		or unit:find("^raid%d")
		or unit:find("^partypet%d")
		or unit:find("^raidpet%d")
	then
		MarkAurasDirty(unit)
		ns.RequestBuffWindowRefresh()
	end
end

local function OnGroupRosterUpdate()
	RequestFullRefresh()
end

local function OnUnitPet()
	RequestFullRefresh()
end

local function OnPlayerTargetChanged()
	RequestFullRefresh()
end

local function OnSpellsChanged()
	if BuffWindow.isSetUp then
		BuffWindow.BuildBuffs()
		RequestFullRefresh()
	end
end

--[[
    A poison, imbue or oil going on or wearing off, a weapon swapped, and an
    item used up or bought: the Self Buffs icons read your weapons and bags,
    which no aura event reaches.
]]
local function RefreshForInventory()
	if BuffWindow.isSetUp and not inCombat then
		ns.RequestBuffWindowRefresh()
	end
end

local function OnUnitInventoryChanged()
	RefreshForInventory()
end

local function OnBagUpdateDelayed()
	RefreshForInventory()
end

local function OnPlayerRegenDisabled()
	inCombat = true
end

local function OnPlayerRegenEnabled()
	inCombat = false
	if not BuffWindow.isSetUp then
		return
	end
	if settingsPending then
		ApplySettings()
	end
	RequestFullRefresh()
end

-- The backstop's tick, which skips the redraw while the window is off or in combat.
local function OnBackstopTick()
	if inCombat or not ns.db.profile.buffWindow.enabled then
		return
	end
	ns.RequestBuffWindowRefresh()
end

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

-- Run once from Core's login sequence, after the saved variables are live.
function ns.SetupBuffWindow()
	inCombat = InCombatLockdown() and true or false
	BuffWindow.BuildLookup()
	ns.BuffWindowCategories = BuffWindow.BuildCategories(BuffWindow.entries)
	-- The Self-Buffs panel lists the Soulstone with the warlock's self buffs.
	local selfListed = { unpack(BuffWindow.selfEntries) }
	selfListed[#selfListed + 1] = BuffWindow.soulstoneEntry
	ns.BuffWindowSelfCategories = BuffWindow.BuildCategories(selfListed)
	ns.PopulateBuffWindowAudience()
	BuffWindow.BuildBuffs()
	ns.CreateBuffWindowFrame()
	ApplySettings()
	BuffWindow.isSetUp = true
	ns.RequestBuffWindowRefresh()
	C_Timer.NewTicker(BACKSTOP_INTERVAL, OnBackstopTick)
end

ns.SetEventHandler("GROUP_ROSTER_UPDATE", OnGroupRosterUpdate)
ns.SetEventHandler("UNIT_PET", OnUnitPet)
ns.SetEventHandler("PLAYER_TARGET_CHANGED", OnPlayerTargetChanged)
ns.SetEventHandler("SPELLS_CHANGED", OnSpellsChanged)
ns.SetEventHandler("UNIT_INVENTORY_CHANGED", OnUnitInventoryChanged)
ns.SetEventHandler("BAG_UPDATE_DELAYED", OnBagUpdateDelayed)
ns.SetEventHandler("PLAYER_REGEN_DISABLED", OnPlayerRegenDisabled)
ns.SetEventHandler("PLAYER_REGEN_ENABLED", OnPlayerRegenEnabled)
