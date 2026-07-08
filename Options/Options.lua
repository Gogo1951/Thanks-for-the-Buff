local _, ns = ...
local L = ns.L

-- Category id for the top-level options panel, captured from AddToBlizOptions at
-- registration so OpenOptions can jump straight to it instead of resolving the
-- category by title string (fragile: the id is numeric on newer clients).
local optionsCategoryID

--------------------------------------------------------------------------------
-- Registration
--------------------------------------------------------------------------------

function ns.SetupOptions()
    local AC = LibStub("AceConfig-3.0")
    local ACD = LibStub("AceConfigDialog-3.0")
    local registry = ns.OPTIONS_REGISTRY
    local parent = L["ADDON_TITLE"]

    AC:RegisterOptionsTable(registry.General, ns.GetGeneralOptions())
    -- AddToBlizOptions returns (frame, categoryID); keep the id for OpenOptions.
    local _, categoryID = ACD:AddToBlizOptions(registry.General, parent)
    optionsCategoryID = categoryID

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

    -- Profiles registers second-to-last, directly above Diagnostic Tools. Its
    -- display name comes already localized from AceDBOptions-3.0.
    if ns.BuildProfilesOptions then
        local profilesOptions = ns.BuildProfilesOptions()
        AC:RegisterOptionsTable(registry.Profiles, profilesOptions)
        ACD:AddToBlizOptions(registry.Profiles, profilesOptions.name, parent)
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
    if Settings and Settings.OpenToCategory and optionsCategoryID then
        Settings.OpenToCategory(optionsCategoryID)
        return
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
