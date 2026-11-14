local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--[[
    "Tracked Abilities" panel, under Good News: one checkbox per row of
    Data/<Flavor>/Good-News-Abilities-<Flavor>.lua that this client can cast,
    grouped by class, then Items. A ticked row is one Good News whispers about.

    Not hidden behind the Good News switch: the parent panel says whether it is
    on, and the list is worth setting up before turning it on. Registered as the
    builder, so every repaint picks up item names the client has loaded since.
]]

--------------------------------------------------------------------------------
-- Labels
--------------------------------------------------------------------------------

local ITEMS_GROUP = "ITEMS"

--[[
    "|T icon:16|t Name": the item for an item row (a group named after one of
    its items takes labelItem's name), else the first spell. An item the client
    hasn't loaded yet shows its spell until it has.
]]
local function RowLabel(info)
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

local function GroupTitle(class)
	if class == ITEMS_GROUP then
		return GetColor("TITLE") .. L["GOOD_NEWS_ITEMS"] .. "|r"
	end
	local color = Data.CLASS_COLORS[class] or ns.PALETTE.TEXT
	return "|cff" .. color .. ((LOCALIZED_CLASS_NAMES_MALE and LOCALIZED_CLASS_NAMES_MALE[class]) or class) .. "|r"
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.BuildGoodNewsAbilitiesOptions()
	local options = {
		name = L["TAB_GOOD_NEWS_ABILITIES"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["GOOD_NEWS_ABILITIES_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),
		},
	}

	-- Classes alphabetically, then Items; rows alphabetically within each.
	local groups, classes = {}, {}
	for _, info in ipairs(ns.GetGoodNewsRows()) do
		local class = info.row.class or ITEMS_GROUP
		if not groups[class] then
			groups[class] = {}
			if class ~= ITEMS_GROUP then
				classes[#classes + 1] = class
			end
		end
		local label, sortName = RowLabel(info)
		table.insert(groups[class], { info = info, label = label, sortName = sortName })
	end
	table.sort(classes)
	if groups[ITEMS_GROUP] then
		classes[#classes + 1] = ITEMS_GROUP
	end

	for groupOrder, class in ipairs(classes) do
		local entries = groups[class]
		table.sort(entries, function(a, b)
			return a.sortName < b.sortName
		end)
		local group = {
			type = "group",
			name = GroupTitle(class),
			inline = true,
			order = 10 + groupOrder,
			args = {},
		}
		for entryOrder, entry in ipairs(entries) do
			local ids = entry.info.watchedIds
			group.args["row" .. ids[1]] = {
				type = "toggle",
				name = entry.label,
				desc = C_Spell.GetSpellDescription(entry.info.spellIds[1]) or "",
				width = "full",
				order = entryOrder,
				get = function()
					return ns.IsGoodNewsWatched(ids[1])
				end,
				-- Every ID the row watches is saved, so each rank or variant answers the same.
				set = function(_, value)
					local watched = ns.db.profile.goodNews.watched
					for _, id in ipairs(ids) do
						watched[id] = value
					end
				end,
			}
		end
		options.args["group" .. class] = group
	end

	return options
end
