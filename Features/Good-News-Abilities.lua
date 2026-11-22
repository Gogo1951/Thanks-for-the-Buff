local _, ns = ...
local Data = ns.Data

local DETECT = Data.GOOD_NEWS_DETECT

--------------------------------------------------------------------------------
-- Good News Abilities
--------------------------------------------------------------------------------

--[[
    The abilities Good News can whisper about, from
    Data/<Flavor>/Good-News-Abilities-<Flavor>.lua. Every flavor loads this
    file, WoW Forever included: Buff Back picks its buffs from these rows even
    where Good News itself is left out (Good-News.lua isn't in that TOC).
]]

--------------------------------------------------------------------------------
-- Ability Lookup
--------------------------------------------------------------------------------

--[[
    Built once, at login (ns.SetupGoodNews). castLookup is keyed by
    the CAST id, which is what the spellcast events carry; that differs from the
    aura id for a row like Misdirection, so each record also carries the ids the
    checkbox is saved under (watchedIds) and the aura to read the duration from
    (auraId). Rows reads the same data for the Tracked Abilities panel.

    Every item a row names is requested here, so the client has its name by
    the time the panel labels a scroll with it rather than with its spell.

    A RESURRECT row needs the combat log to confirm the revive, so it is left out
    on WoW Forever, where that never arrives. Its data lists none anyway.
]]
local castLookup, rows

local function WatchedId(row, trigger)
	if row.detect == DETECT.AURA then
		return trigger.aura or trigger.spell
	end
	return trigger.spell
end

local function RequestItem(itemId)
	if itemId and not C_Item.GetItemNameByID(itemId) then
		C_Item.RequestLoadItemDataByID(itemId)
	end
end

local function BuildLookup()
	castLookup, rows = {}, {}
	local DoesSpellExist = C_Spell.DoesSpellExist
	for _, row in ipairs(ns.GOOD_NEWS_ABILITIES or {}) do
		RequestItem(row.labelItem)
		local usable = not (row.detect == DETECT.RESURRECT and ns.FLAVOR == "Camelot")
		local info = { row = row, watchedIds = {}, spellIds = {}, itemIds = {} }
		for _, trigger in ipairs(usable and row.triggers or {}) do
			local watched = WatchedId(row, trigger)
			-- A rank or variant this client lacks is dropped; a row with none left is skipped.
			if DoesSpellExist(trigger.spell) or DoesSpellExist(watched) then
				info.watchedIds[#info.watchedIds + 1] = watched
				info.spellIds[#info.spellIds + 1] = trigger.spell
				if trigger.item then
					info.itemIds[#info.itemIds + 1] = trigger.item
					RequestItem(trigger.item)
				end
				castLookup[trigger.spell] = {
					info = info,
					watchedId = watched,
					itemId = trigger.item,
					--[[
					    Nothing to read for a cast that leaves no aura, or for a
					    buff spent by an event rather than by time (noDuration):
					    no auraId is what leaves the duration out of the whisper.
					]]
					auraId = (row.detect == DETECT.AURA and not row.noDuration) and watched or nil,
				}
			end
		end
		if #info.watchedIds > 0 then
			rows[#rows + 1] = info
		end
	end
end

-- Run once from Core's login sequence.
function ns.SetupGoodNews()
	if not castLookup then
		BuildLookup()
	end
end

-- Every row this client can cast, for the Tracked Abilities panel.
function ns.GetGoodNewsRows()
	if not rows then
		BuildLookup()
	end
	return rows
end

-- The record for a cast id, or nil when no row watches it. Good-News.lua reads it as each cast is sent.
function ns.GetGoodNewsCastRecord(spellID)
	if not castLookup then
		BuildLookup()
	end
	return castLookup[spellID]
end

--[[
    "|T icon:16|t Name": the item for an item row (a group named after one of
    its items takes labelItem's name), else the first spell. An item the client
    hasn't loaded yet shows its spell until it has.
]]
function ns.GetGoodNewsRowLabel(info)
	local row = info.row
	local itemId = row.labelItem or info.itemIds[1]
	local name, icon
	if itemId then
		name = C_Item.GetItemNameByID(itemId)
		icon = C_Item.GetItemIconByID(itemId)
	end
	if not name then
		name = C_Spell.GetSpellName(info.spellIds[1]) or tostring(info.spellIds[1])
		icon = C_Spell.GetSpellTexture(info.spellIds[1])
	end
	return (icon and ("|T" .. icon .. ":16|t ") or "") .. name, name
end

-- A row with no saved choice is ticked.
function ns.IsGoodNewsWatched(watchedId)
	return ns.db.profile.goodNews.watched[watchedId] ~= false
end
