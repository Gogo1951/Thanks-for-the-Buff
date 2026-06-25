local _, ns = ...
local L = ns.L

--------------------------------------------------------------------------------
-- Registration
--------------------------------------------------------------------------------

function ns.SetupOptions()
    local AC = LibStub("AceConfig-3.0")
    local ACD = LibStub("AceConfigDialog-3.0")
    local registry = ns.OPTIONS_REGISTRY
    local parent = L["ADDON_TITLE"]

    AC:RegisterOptionsTable(registry.General, ns.GetGeneralOptions())
    ACD:AddToBlizOptions(registry.General, parent)

    if ns.GetStrangersOptions then
        AC:RegisterOptionsTable(registry.Strangers, ns.GetStrangersOptions())
        ACD:AddToBlizOptions(registry.Strangers, L["STRANGERS_TITLE"], parent)
    end

    if ns.GetTeammatesOptions then
        -- Registered as a function (not a prebuilt table) so the tracked list is
        -- rebuilt and re-sorted on open, once lazily-loaded item names are cached.
        AC:RegisterOptionsTable(registry.Teammates, ns.GetTeammatesOptions)
        ACD:AddToBlizOptions(registry.Teammates, L["TEAMMATES_TITLE"], parent)
    end

    if ns.GetServicesOptions then
        AC:RegisterOptionsTable(registry.Services, ns.GetServicesOptions)
        ACD:AddToBlizOptions(registry.Services, L["SERVICES_TITLE"], parent)
    end

    if ns.GetThankYouButtonOptions then
        AC:RegisterOptionsTable(registry.ThankYou, ns.GetThankYouButtonOptions())
        ACD:AddToBlizOptions(registry.ThankYou, L["BUTTON_TITLE"], parent)
    end

    -- Diagnostic Tools registers last so it sits at the bottom of the tree.
    if ns.BuildDiagnosticsOptions then
        AC:RegisterOptionsTable(registry.Diagnostics, ns.BuildDiagnosticsOptions())
        ACD:AddToBlizOptions(registry.Diagnostics, ns.DiagnosticsStrings.TAB, parent)
    end

    SLASH_TFTB_CONFIG1 = "/tftb"
    SlashCmdList.TFTB_CONFIG = function()
        ns.OpenOptions()
    end
end

function ns.OpenOptions()
    if Settings and Settings.GetCategory then
        local category = Settings.GetCategory(L["ADDON_TITLE"])
        if category then
            Settings.OpenToCategory(category.ID)
            return
        end
    end
    if InterfaceOptionsFrame_OpenToCategory then
        InterfaceOptionsFrame_OpenToCategory(L["ADDON_TITLE"])
        InterfaceOptionsFrame_OpenToCategory(L["ADDON_TITLE"])
        return
    end
    LibStub("AceConfigDialog-3.0"):Open(ns.OPTIONS_REGISTRY.General)
end

--------------------------------------------------------------------------------
-- Slash Commands (/thankyou)
--------------------------------------------------------------------------------

-- The command body lives in Features/Thank-You-Button.lua (ns.RunThankYou).
SLASH_THANKYOU1 = "/thankyou"
SlashCmdList.THANKYOU = function()
    if ns.RunThankYou then
        ns.RunThankYou()
    end
end
