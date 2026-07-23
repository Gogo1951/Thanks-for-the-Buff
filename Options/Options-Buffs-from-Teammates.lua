local _, ns = ...

--[[
    "Buffs from Teammates" panel -- party/raid buffs & cooldowns cast on you. The
    scaffold (description, messaging toggles, emote picker) and the tracked-list
    helpers are shared with Group Services and live in Options-Utilities.lua
    (ns.BuildBuffPanel / ns.SortedEntries / ns.DefineEntryToggle). This file owns
    only the Teammates-specific layout: one inline group per class category, then
    the generic Items group.
]]

function ns.BuildTeammatesOptions()
	local options = ns.BuildBuffPanel("TAB_TEAMMATES", "TEAMMATES_DESCRIPTION", "teammates")

	-- Added here, not in the shared scaffold: Group Services has no sound option.
	-- 8.5/8.6 slot the toggle and its preview speaker right after the scaffold's
	-- Enable Emotes toggle (order 8).
	options.args.sound = ns.DefineSoundToggle(function()
		return ns.db.profile.teammates
	end, 8.5)
	options.args.soundPreview = ns.DefineSoundPreview(ns.PlayBuffSound, 8.6)

	-- One inline group per category (each class, then Items), built at login.
	local categoryOrder = 20
	for _, category in ipairs(ns.TeammateCategories or {}) do
		local groupKey = "cat_" .. category.id
		options.args[groupKey] = {
			type = "group",
			name = category.name,
			order = categoryOrder,
			inline = true,
			args = {},
		}

		local entryOrder = 1
		for _, entry in ipairs(ns.SortedEntries(category.entries)) do
			options.args[groupKey].args["entry_" .. entry.ids[1]] = ns.DefineEntryToggle(entry, entryOrder)
			entryOrder = entryOrder + 1
		end

		categoryOrder = categoryOrder + 1
	end

	return options
end
