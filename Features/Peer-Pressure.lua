local _, ns = ...
local Data = ns.Data
local L = ns.L

--[[
    Peer Pressure -- the same-class cooldown alert.
    When ANOTHER player of YOUR class uses a cooldown from Data.PEER_PRESSURE
    (Data/Peer-Pressure-Abilities.lua), print a message and/or play the Thunder
    sound so you can join in. With "Trigger on Own Casts" turned on
    (default off), your own cooldowns fire it too.

    The combat log tap arrives via ns.CheckPeerPressure, called from Buff-Tracking's
    OnCombatLogEvent -- Core's rule is one owner per event, and
    COMBAT_LOG_EVENT_UNFILTERED belongs to Buff-Tracking. Spells are class-locked,
    so "the caster is your class" needs no GUID inspection: the entry's class tag
    against your own class is the whole test.
]]

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local lookup = {} -- live spell id -> its Data.PEER_PRESSURE entry
local playerGUID, playerClass

--------------------------------------------------------------------------------
-- Lookups & Watched List
--------------------------------------------------------------------------------

--[[
    Rows are positional (see the data file header): [1] class, [2] spell ids,
    [3][4][5] the default checkbox state on Era / TBC / Wrath. The applicable
    slot comes from the shared ns.FLAVOR_INDEX (Features/Utilities.lua).
]]
local FLAVOR_SLOT = 2 + ns.FLAVOR_INDEX

local function BuildLookup()
	local DoesSpellExist = ns.DoesSpellExist
	wipe(lookup)
	for _, entry in ipairs(Data.PEER_PRESSURE) do
		--[[
            "-" in the flavor slot: this row does not exist on this flavor at
            all. That is a stronger statement than DoesSpellExist can make --
            Blizzard REUSES ids across flavors for different abilities (12472
            is Cold Snap on Era but Icy Veins in TBC+), so the id existing
            proves nothing about which ability it is here. See the data header.
        ]]
		if entry[FLAVOR_SLOT] ~= "-" then
			for _, id in ipairs(entry[2]) do
				if DoesSpellExist(id) then
					lookup[id] = entry
				end
			end
		end
	end
end

-- Same contract as PopulateWatchedBuffs, except the seeded state comes from
-- the row's digit for the running flavor (0 seeds off, anything else on).
-- Dead ids are pruned so the saved list stays client-real, and a user's own
-- choices are never overwritten. Re-run on profile changes.
local function PopulatePeerPressureWatched()
	local watched = ns.db.profile.peerPressure.watched
	for id, entry in pairs(lookup) do
		if watched[id] == nil then
			watched[id] = entry[FLAVOR_SLOT] ~= 0
		end
	end
	for id in pairs(watched) do
		if lookup[id] == nil then
			watched[id] = nil
		end
	end
end
ns.PopulatePeerPressureWatched = PopulatePeerPressureWatched

--------------------------------------------------------------------------------
-- Display Categories
--------------------------------------------------------------------------------

--[[
    One class-colored category per class that still has live entries on this
    client, each entry shaped for ns.DefineEntryToggle ({ids, spellName}) -- rank
    groups share one toggle under the first live rank's name. Built at login,
    when the spell APIs return real data.
]]
local function BuildCategories()
	local GetSpellName = ns.GetSpellName
	local buckets = {}

	for _, entry in ipairs(Data.PEER_PRESSURE) do
		local class = entry[1]
		local ids = {}
		for _, id in ipairs(entry[2]) do
			-- Ownership, not mere existence: an id belongs to THIS row's toggle
			-- only if the lookup credits it here. A row hidden on this flavor
			-- ("-") owns nothing, so it renders nothing -- even when another
			-- live row legitimately claims the same id.
			if lookup[id] == entry then
				ids[#ids + 1] = id
			end
		end
		if #ids > 0 then
			buckets[class] = buckets[class] or {}
			local bucket = buckets[class]
			bucket[#bucket + 1] = {
				ids = ids,
				spellName = GetSpellName(ids[1]) or L["COMBAT_SPELL_PENDING"]:format(ids[1]),
			}
		end
	end

	local classNames = {}
	for class in pairs(buckets) do
		classNames[#classNames + 1] = class
	end
	table.sort(classNames)

	local categories = {}
	for _, class in ipairs(classNames) do
		local color = Data.CLASS_COLORS[class] or "FFFFFF"
		local label = "|cff" .. color .. (LOCALIZED_CLASS_NAMES_MALE[class] or class) .. "|r"
		categories[#categories + 1] = { id = class, name = label, entries = buckets[class] }
	end
	ns.PeerPressureCategories = categories
end

--------------------------------------------------------------------------------
-- Combat Log Tap
--------------------------------------------------------------------------------

--[[
    Called by Buff-Tracking for every SPELL_CAST_SUCCESS -- including your own,
    which count only while "Trigger on Own Casts" is enabled. First line is the
    lookup miss, so untracked casts cost one table probe. The "on Sally" flavor
    is used only when the cast had a target who is a real player other than the
    caster -- self-buffs and pet targets read as plain.
]]
function ns.CheckPeerPressure(spellID, sourceGUID, sourceName, destGUID, destName)
	local entry = lookup[spellID]
	if not entry or entry[1] ~= playerClass then
		return
	end
	local db = ns.db.profile.peerPressure
	if not db or not db.enabled or (not db.printEnabled and not db.soundEnabled) then
		return
	end
	if not db.watched[spellID] then
		return
	end
	if not sourceGUID or not sourceName or not ns.IsPlayerGUID(sourceGUID) then
		return
	end
	if sourceGUID == playerGUID and not db.triggerOnOwnCasts then
		return
	end

	local targetName
	if destName and ns.IsPlayerGUID(destGUID) and destGUID ~= sourceGUID then
		targetName = destName
	end

	if db.printEnabled then
		ns:AnnouncePeerPressure(entry[1], sourceName, spellID, targetName)
	end
	if db.soundEnabled then
		ns.PlayPeerPressureSound()
	end
end

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

-- Run from Core's login sequence, after the saved variables are live and the
-- spell APIs return real data (same timing as SetupBuffTracking).
function ns.SetupPeerPressure()
	playerGUID = UnitGUID("player")
	playerClass = select(2, UnitClass("player"))
	BuildLookup()
	PopulatePeerPressureWatched()
	BuildCategories()
end
