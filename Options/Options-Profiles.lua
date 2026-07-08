local _, ns = ...
local L = ns.L

--------------------------------------------------------------------------------
-- Profiles Panel
--------------------------------------------------------------------------------

--[[
    The stock AceDBOptions-3.0 profiles table (picker, Copy From, Delete, Reset
    Profile -- all pre-wired to ns.db and already translated) extended with the
    one control we author: Reset All Profiles, which wipes every profile on the
    account. Registered second-to-last, directly above Diagnostic Tools.
]]
function ns.BuildProfilesOptions()
    local options = LibStub("AceDBOptions-3.0"):GetOptionsTable(ns.db)
    options.args.resetAllProfiles = {
        type = "execute",
        name = L["OPTIONS_RESET_ALL_PROFILES"],
        desc = L["OPTIONS_RESET_ALL_PROFILES_DESCRIPTION"],
        confirm = true,
        confirmText = L["OPTIONS_RESET_ALL_PROFILES_CONFIRM"],
        func = function()
            ns:ResetAllProfiles()
        end,
        order = 100
    }
    return options
end
