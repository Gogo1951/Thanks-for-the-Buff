local _, ns = ...
local Data = ns.Data
local L = ns.L
local Kit = ns.OptionsKit

local GetColor = ns.GetColor

--[[
    "Tracked Abilities" panel, under Good News: one checkbox per row of
    Data/<Flavor>/Good-News-Abilities-<Flavor>.lua that this client can cast,
    grouped by class, then Items. A ticked row is one Good News whispers about.

    Not hidden behind the Good News switch: the list is worth setting up before
    turning it on, and a silver line says so while it is off. Registered as the
    builder, so every repaint picks up item names the client has loaded since.
]]

--------------------------------------------------------------------------------
-- Labels
--------------------------------------------------------------------------------

local ITEMS_GROUP = "ITEMS"

local function ClassName(class)
	return (LOCALIZED_CLASS_NAMES_MALE and LOCALIZED_CLASS_NAMES_MALE[class]) or class
end

local function GroupTitle(class)
	if class == ITEMS_GROUP then
		return GetColor("TITLE") .. L["GOOD_NEWS_ITEMS"] .. "|r"
	end
	return Kit.Color(Data.CLASS_COLORS[class] or "TEXT", ClassName(class))
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.BuildGoodNewsAbilitiesOptions()
	local options = {
		name = Kit.SubPanelTitle(L["TAB_GOOD_NEWS"], L["TAB_GOOD_NEWS_ABILITIES"]),
		type = "group",
		args = {
			-- The list stays open while Good News is off, so it can be set up first; say nothing goes out yet.
			status = Kit.StatusLine(function()
				if ns.db.profile.goodNews.enabled then
					return nil
				end
				return L["GOOD_NEWS_ABILITIES_OFF"]:format(L["TAB_GOOD_NEWS"], L["GOOD_NEWS_ENABLE"])
			end, 0.5),
			descIntro = Kit.Desc(L["GOOD_NEWS_ABILITIES_DESCRIPTION"], 1),
			space0 = Kit.Spacer(2),
		},
	}

	-- Classes alphabetically by their names in the player's language, then Items; rows alphabetically within each.
	local groups, classes = {}, {}
	for _, info in ipairs(ns.GetGoodNewsRows()) do
		local class = info.row.class or ITEMS_GROUP
		if not groups[class] then
			groups[class] = {}
			if class ~= ITEMS_GROUP then
				classes[#classes + 1] = class
			end
		end
		local label, sortName = ns.GetGoodNewsRowLabel(info)
		table.insert(groups[class], { info = info, label = label, sortName = sortName })
	end
	table.sort(classes, function(a, b)
		return ClassName(a) < ClassName(b)
	end)
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
					ns.RefreshSettings()
				end,
			}
		end
		options.args["group" .. class] = group
	end

	return options
end
