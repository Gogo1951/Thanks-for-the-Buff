local _, ns = ...

--[[
    "Group Services" panel -- raid-wide help with no aura on you (feasts, soulwells,
    portals, repair bots). The scaffold and tracked-list helpers are shared with
    Buffs from Teammates and live in Options-Utilities.lua (ns.BuildBuffPanel /
    ns.SortedEntries / ns.DefineEntryToggle). This file owns only the flat tracked
    list: the whole panel is one category, so there are no inner headers.
]]

function ns.GetServicesOptions()
    local options = ns.BuildBuffPanel("SERVICES_TITLE", "SERVICES_DESC", "services")

    local entryOrder = 20
    for _, entry in ipairs(ns.SortedEntries(ns.ServiceEntries or {})) do
        options.args["entry_" .. entry.ids[1]] = ns.DefineEntryToggle(entry, entryOrder)
        entryOrder = entryOrder + 1
    end

    return options
end
