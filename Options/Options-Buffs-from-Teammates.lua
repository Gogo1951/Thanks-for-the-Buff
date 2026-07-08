local _, ns = ...

--[[
    "Buffs from Teammates" panel -- party/raid buffs & cooldowns cast on you. The
    scaffold (description, messaging toggles, emote picker) and the tracked-list
    helpers are shared with Group Services and live in Options-Utilities.lua
    (ns.BuildBuffPanel / ns.SortedEntries / ns.DefineEntryToggle). This file owns
    only the Teammates-specific layout: one inline group per class category, then
    the generic Items group.
]]

function ns.GetTeammatesOptions()
    local options = ns.BuildBuffPanel("TEAMMATES_TITLE", "TEAMMATES_DESC", "teammates")

    -- One inline group per category (each class, then Items), built at login.
    local categoryOrder = 20
    for _, category in ipairs(ns.TeammateCategories or {}) do
        local groupKey = "cat_" .. category.id
        options.args[groupKey] = {
            type = "group",
            name = category.name,
            order = categoryOrder,
            inline = true,
            args = {}
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
