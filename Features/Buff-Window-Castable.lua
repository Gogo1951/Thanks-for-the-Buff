local _, ns = ...
local Data = ns.Data
local L = ns.L

--[[
    The Buff Window's castable list: which of this client's ns.BUFF_WINDOW_SPELLS
    rows have live ids, who each is offered to (seeded into the profile), the
    options panels' class categories, and the buffs this character can cast
    right now, rank by rank. Creates ns.BuffWindow, the table the other Buff
    Window files share their state and helpers through.
]]

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local BuffWindow = {}
ns.BuffWindow = BuffWindow

--[[
    One per data row with live ids: { key, row, ids, ranks, rankLevels, groupIds,
    auraIds }. rankLevels maps each single-target rank's id to its learn level.
]]
local entries = {}
local lookup = {} -- setting key (a row's first live single-target id) -> its entry
--[[
    Exclusive family ("BLESSING") -> every aura id in it, so a buff can ask
    whether the target carries another of yours from the same family.
]]
local exclusiveIds = {}
local buffs = {} -- the entries this character can cast right now, built by BuildBuffs
--[[
    The same three for self buffs (ns.BUFF_WINDOW_SELF_SPELLS), whose setting is
    when each one shows rather than who it is for.
]]
local selfEntries, selfLookup, selfBuffs = {}, {}, {}

BuffWindow.entries = entries
BuffWindow.exclusiveIds = exclusiveIds
BuffWindow.buffs = buffs
BuffWindow.selfEntries = selfEntries
BuffWindow.selfBuffs = selfBuffs
--[[
    Seconds left under which a buff counts as missing; set from the profile at
    the start of each Refresh.
]]
BuffWindow.refreshSeconds = 0
BuffWindow.isSetUp = false

--------------------------------------------------------------------------------
-- Lookups & Audience Settings
--------------------------------------------------------------------------------

local function LiveIds(ids)
	local live = {}
	for _, id in ipairs(ids or {}) do
		if C_Spell.DoesSpellExist(id) then
			live[#live + 1] = id
		end
	end
	return live
end

function BuffWindow.BuildLookup()
	wipe(entries)
	wipe(lookup)
	wipe(exclusiveIds)
	for _, row in ipairs(ns.BUFF_WINDOW_SPELLS) do
		local ranks, ids, rankLevels = {}, {}, {}
		for _, rank in ipairs(row.single) do
			if C_Spell.DoesSpellExist(rank[1]) then
				ranks[#ranks + 1] = { id = rank[1], level = rank[2] }
				ids[#ids + 1] = rank[1]
				rankLevels[rank[1]] = rank[2]
			end
		end
		if ids[1] then
			local groupIds = LiveIds(row.group)
			--[[
			    Any version counts as buffed: each rank's aura carries its own id.
			    Has drops a single-target rank below the one you'd cast. A Greater
			    Blessing only ever counts, never casts.
			]]
			local auraIds = {}
			for _, list in ipairs({ ids, groupIds, LiveIds(row.greater) }) do
				for _, id in ipairs(list) do
					auraIds[id] = true
				end
			end
			if row.exclusive then
				exclusiveIds[row.exclusive] = exclusiveIds[row.exclusive] or {}
				for id in pairs(auraIds) do
					exclusiveIds[row.exclusive][id] = true
				end
			end
			local entry = {
				key = ids[1],
				row = row,
				ids = ids,
				ranks = ranks,
				rankLevels = rankLevels,
				groupIds = groupIds,
				auraIds = auraIds,
			}
			entries[#entries + 1] = entry
			lookup[entry.key] = entry
		end
	end

	wipe(selfEntries)
	wipe(selfLookup)
	for _, row in ipairs(ns.BUFF_WINDOW_SELF_SPELLS) do
		local ranks, ids, auraIds, rankLevels = {}, {}, {}, {}
		for _, rank in ipairs(row.ranks) do
			if C_Spell.DoesSpellExist(rank[1]) then
				ranks[#ranks + 1] = { id = rank[1], level = rank[2] }
				ids[#ids + 1] = rank[1]
				auraIds[rank[1]] = true
				rankLevels[rank[1]] = rank[2]
			end
		end
		if ids[1] then
			if row.exclusive then
				exclusiveIds[row.exclusive] = exclusiveIds[row.exclusive] or {}
				for id in pairs(auraIds) do
					exclusiveIds[row.exclusive][id] = true
				end
			end
			local entry =
				{ key = ids[1], row = row, ids = ids, ranks = ranks, rankLevels = rankLevels, auraIds = auraIds }
			selfEntries[#selfEntries + 1] = entry
			selfLookup[entry.key] = entry
		end
	end
end

--[[
    Same contract as PopulatePeerPressureWatched: seed what the player never set
    from the row's default, drop any value that isn't a choice the dropdown
    offers, and never touch a key this client lacks. Re-run on profile changes.
]]
local function PopulateBuffWindowAudience()
	local audience = ns.db.profile.buffWindow.audience
	for key, value in pairs(audience) do
		if not Data.BUFF_AUDIENCE[value] then
			audience[key] = nil
		end
	end
	for key, entry in pairs(lookup) do
		if audience[key] == nil then
			audience[key] = entry.row.default
		end
	end

	--[[
	    When each self buff shows, seeded from the row's default; a value the
	    dropdown doesn't offer is dropped and reseeded.
	]]
	local valid = {}
	for _, choice in ipairs(Data.SELF_REFRESH_CHOICES) do
		valid[choice] = true
	end
	local selfRefresh = ns.db.profile.buffWindow.selfRefresh
	for key, value in pairs(selfRefresh) do
		if not valid[value] then
			selfRefresh[key] = nil
		end
	end
	for key, entry in pairs(selfLookup) do
		if selfRefresh[key] == nil then
			selfRefresh[key] = entry.row.default
		end
	end
end
ns.PopulateBuffWindowAudience = PopulateBuffWindowAudience

--------------------------------------------------------------------------------
-- Display Categories
--------------------------------------------------------------------------------

--[[
    One class-colored category per class with live rows, each entry the
    { key, ids, spellName } the panel's audience dropdown needs. Every class is
    listed, not just yours, because the default profile is shared account-wide.
    Only the single-target ids are carried: the dropdown should show and
    describe the buff, not its group version.
]]
function BuffWindow.BuildCategories(list)
	local buckets = {}
	for _, entry in ipairs(list) do
		local class = entry.row.class
		buckets[class] = buckets[class] or {}
		local bucket = buckets[class]
		bucket[#bucket + 1] = {
			key = entry.key,
			ids = entry.ids,
			spellName = C_Spell.GetSpellName(entry.ids[1]) or L["TRACKED_SPELL_PENDING"]:format(entry.ids[1]),
			exclusive = entry.row.exclusive,
		}
	end

	local classNames = {}
	for class in pairs(buckets) do
		classNames[#classNames + 1] = class
	end
	table.sort(classNames)

	local categories = {}
	for _, class in ipairs(classNames) do
		local color = Data.CLASS_COLORS[class] or ns.PALETTE.TEXT
		local label = "|cff" .. color .. (LOCALIZED_CLASS_NAMES_MALE[class] or class) .. "|r"
		categories[#categories + 1] = { id = class, name = label, entries = buckets[class] }
	end
	return categories
end

--[[
    The options panel reads this to say why the window never shows on a class
    with nothing to give (a paladin, a warrior).
]]
function ns.BuffWindowHasClassRows()
	local _, playerClass = UnitClass("player")
	for _, list in ipairs({ entries, selfEntries }) do
		for _, entry in ipairs(list) do
			if entry.row.class == playerClass then
				return true
			end
		end
	end
	return false
end

--------------------------------------------------------------------------------
-- Castable Buffs
--------------------------------------------------------------------------------

--[[
    Any known rank of a group version will do: its button casts by name, which
    resolves to the highest rank you know.
]]
local function FirstKnown(ids)
	for _, id in ipairs(ids) do
		if IsPlayerSpell(id) then
			return id
		end
	end
	return nil
end

-- The client's spell subtext ("Rank 3").
local GetSpellSubtext = C_Spell.GetSpellSubtext

--[[
    The single-target ranks you know, highest first, each with what a macro
    types to cast exactly that rank: "Power Word: Fortitude(Rank 3)", or the bare
    name for a spell with no rank text. Ranks with different names (the three
    Detect Invisibility spells) carry their own.
]]
local function KnownRanks(entry)
	local known = {}
	for _, rank in ipairs(entry.ranks) do
		if IsPlayerSpell(rank.id) then
			local name = C_Spell.GetSpellName(rank.id)
			if name then
				local subtext = GetSpellSubtext(rank.id)
				local castText = (subtext and subtext ~= "") and (name .. "(" .. subtext .. ")") or name
				known[#known + 1] = { id = rank.id, level = rank.level, name = name, castText = castText }
			end
		end
	end
	table.sort(known, function(a, b)
		return a.level > b.level
	end)
	return known
end

--[[
    Rebuilt at setup, on SPELLS_CHANGED (a new rank, or the group version at its
    level) and when a setting on the panel changes.
]]
function BuffWindow.BuildBuffs()
	wipe(buffs)
	local _, playerClass = UnitClass("player")
	local audience = ns.db.profile.buffWindow.audience
	for _, entry in ipairs(entries) do
		local who = audience[entry.key]
		if entry.row.class == playerClass and who and who ~= Data.BUFF_AUDIENCE.OFF then
			local ranks, groupId = KnownRanks(entry), FirstKnown(entry.groupIds)
			if ranks[1] or groupId then
				buffs[#buffs + 1] = {
					--[[
					    The buff's column in the window, shared by its single and
					    group icons so a party's group buff sits over the single
					    one it replaces.
					]]
					column = #buffs + 1,
					key = entry.key,
					audience = who,
					auraIds = entry.auraIds,
					rankLevels = entry.rankLevels,
					manaOnly = entry.row.manaOnly,
					noCasters = entry.row.noCasters,
					exclusive = entry.row.exclusive,
					ranks = ranks,
					-- Set when you know any single-target rank at all.
					singleName = ranks[1] and ranks[1].name,
					groupId = groupId,
					groupName = groupId and C_Spell.GetSpellName(groupId),
				}
			end
		end
	end

	wipe(selfBuffs)
	local selfRefresh = ns.db.profile.buffWindow.selfRefresh
	for _, entry in ipairs(selfEntries) do
		local when = selfRefresh[entry.key]
		if entry.row.class == playerClass and when and when ~= Data.SELF_REFRESH_OFF then
			local ranks = KnownRanks(entry)
			if ranks[1] then
				selfBuffs[#selfBuffs + 1] = {
					-- Self Buffs keeps its own grid, so its columns count from 1.
					column = #selfBuffs + 1,
					key = entry.key,
					auraIds = entry.auraIds,
					rankLevels = entry.rankLevels,
					exclusive = entry.row.exclusive,
					ranks = ranks,
					singleName = ranks[1].name,
					-- Its own "count as missing under", in seconds; 0 waits for it to drop.
					refreshSeconds = when * 60,
				}
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Ranks
--------------------------------------------------------------------------------

--[[
    A rank can go on a player at most this many levels below the level it is
    learned at; lower than that, the cast fails with "Target is too low level".
]]
local RANK_LEVEL_GAP = 10

--[[
    The highest rank you know that a target of `level` can take, or nil when
    even your lowest is too high for them. An unknown level -- a stranger out of
    sight, or one too far above you to show (UnitLevel's -1) -- takes the top
    rank: there is nothing lower to fall back to.
]]
function BuffWindow.RankFor(buff, level)
	if not ns.IsPlain(level) or not level or level <= 0 then
		return buff.ranks[1]
	end
	for _, rank in ipairs(buff.ranks) do
		if level >= rank.level - RANK_LEVEL_GAP then
			return rank
		end
	end
	return nil
end
