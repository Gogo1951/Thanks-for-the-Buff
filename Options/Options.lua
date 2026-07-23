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

	AC:RegisterOptionsTable(registry.General, ns.BuildGeneralOptions())
	-- AddToBlizOptions returns (frame, categoryID). Both are kept: the opener
	-- routes by the captured id, then by the captured frame, and never resolves
	-- the panel by title -- a name lookup returns nil on clients that carry the
	-- Settings API, which is what makes the panel open as a floating window.
	local mainPanel, mainCategoryID = ACD:AddToBlizOptions(registry.General, parent)
	ns.optionsFrames = { main = mainPanel, categoryID = mainCategoryID }

	if ns.BuildStrangersOptions then
		AC:RegisterOptionsTable(registry.Strangers, ns.BuildStrangersOptions())
		ACD:AddToBlizOptions(registry.Strangers, L["TAB_STRANGERS"], parent)
	end

	if ns.BuildTeammatesOptions then
		-- Registered as a function (not a prebuilt table) so the tracked list is
		-- rebuilt and re-sorted on open, once lazily-loaded item names are cached.
		AC:RegisterOptionsTable(registry.Teammates, ns.BuildTeammatesOptions)
		ACD:AddToBlizOptions(registry.Teammates, L["TAB_TEAMMATES"], parent)
	end

	if ns.BuildServicesOptions then
		AC:RegisterOptionsTable(registry.Services, ns.BuildServicesOptions)
		ACD:AddToBlizOptions(registry.Services, L["TAB_SERVICES"], parent)
	end

	if ns.BuildGoodNewsOptions then
		AC:RegisterOptionsTable(registry.GoodNews, ns.BuildGoodNewsOptions)
		ACD:AddToBlizOptions(registry.GoodNews, L["TAB_GOOD_NEWS"], parent)
	end

	if ns.BuildPeerPressureOptions then
		AC:RegisterOptionsTable(registry.PeerPressure, ns.BuildPeerPressureOptions)
		ACD:AddToBlizOptions(registry.PeerPressure, L["TAB_PEER_PRESSURE"], parent)
	end

	if ns.BuildThankYouButtonOptions then
		AC:RegisterOptionsTable(registry.ThankYou, ns.BuildThankYouButtonOptions())
		ACD:AddToBlizOptions(registry.ThankYou, L["TAB_THANK_YOU_BUTTON"], parent)
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
		ns:OpenOptionsPanel()
	end
end

function ns:OpenOptionsPanel()
	if not ns.optionsFrames then
		return
	end

	if Settings and Settings.OpenToCategory and ns.optionsFrames.categoryID then
		Settings.OpenToCategory(ns.optionsFrames.categoryID)
		return
	end

	if InterfaceOptionsFrame_OpenToCategory then
		InterfaceOptionsFrame_OpenToCategory(ns.optionsFrames.main)
		-- Called twice for Classic compatibility
		InterfaceOptionsFrame_OpenToCategory(ns.optionsFrames.main)
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
