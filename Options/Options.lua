local _, ns = ...
local L = ns.L

--------------------------------------------------------------------------------
-- Registration
--------------------------------------------------------------------------------

function ns.SetupOptions()
	local AceConfig = LibStub("AceConfig-3.0")
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")
	local registry = ns.OPTIONS_REGISTRY
	local parent = L["ADDON_TITLE"]

	AceConfig:RegisterOptionsTable(registry.General, ns.BuildGeneralOptions())
	-- AddToBlizOptions returns (frame, categoryID). Both are kept: the opener
	-- routes by the captured id, then by the captured frame, and never resolves
	-- the panel by title -- a name lookup returns nil on clients that carry the
	-- Settings API, which is what makes the panel open as a floating window.
	local mainPanel, mainCategoryID = AceConfigDialog:AddToBlizOptions(registry.General, parent)
	ns.optionsFrames = { main = mainPanel, categoryID = mainCategoryID }

	if ns.BuildStrangersOptions then
		AceConfig:RegisterOptionsTable(registry.Strangers, ns.BuildStrangersOptions())
		AceConfigDialog:AddToBlizOptions(registry.Strangers, L["TAB_STRANGERS"], parent)
	end

	if ns.BuildTeammatesOptions then
		-- Registered as a function (not a prebuilt table) so the tracked list is
		-- rebuilt and re-sorted on open, once lazily-loaded item names are cached.
		AceConfig:RegisterOptionsTable(registry.Teammates, ns.BuildTeammatesOptions)
		AceConfigDialog:AddToBlizOptions(registry.Teammates, L["TAB_TEAMMATES"], parent)
	end

	if ns.BuildGoodNewsOptions then
		AceConfig:RegisterOptionsTable(registry.GoodNews, ns.BuildGoodNewsOptions)
		AceConfigDialog:AddToBlizOptions(registry.GoodNews, L["TAB_GOOD_NEWS"], parent)
	end

	if ns.BuildServicesOptions then
		AceConfig:RegisterOptionsTable(registry.Services, ns.BuildServicesOptions)
		AceConfigDialog:AddToBlizOptions(registry.Services, L["TAB_SERVICES"], parent)
	end

	if ns.BuildPeerPressureOptions then
		AceConfig:RegisterOptionsTable(registry.PeerPressure, ns.BuildPeerPressureOptions)
		AceConfigDialog:AddToBlizOptions(registry.PeerPressure, L["TAB_PEER_PRESSURE"], parent)
	end

	if ns.BuildThankYouButtonOptions then
		AceConfig:RegisterOptionsTable(registry.ThankYou, ns.BuildThankYouButtonOptions())
		AceConfigDialog:AddToBlizOptions(registry.ThankYou, L["TAB_THANK_YOU_BUTTON"], parent)
	end

	-- Profiles registers second-to-last, directly above Diagnostic Tools. Its
	-- display name comes already localized from AceDBOptions-3.0.
	if ns.BuildProfilesOptions then
		local profilesOptions = ns.BuildProfilesOptions()
		AceConfig:RegisterOptionsTable(registry.Profiles, profilesOptions)
		AceConfigDialog:AddToBlizOptions(registry.Profiles, profilesOptions.name, parent)
	end

	-- Diagnostic Tools registers last so it sits at the bottom of the tree.
	if ns.BuildDiagnosticsOptions then
		AceConfig:RegisterOptionsTable(registry.Diagnostics, ns.BuildDiagnosticsOptions())
		AceConfigDialog:AddToBlizOptions(registry.Diagnostics, ns.DiagnosticsStrings.TAB, parent)
	end

	SLASH_TFTB_CONFIG1 = "/tftb"
	SlashCmdList.TFTB_CONFIG = function()
		ns:OpenOptionsPanel()
	end
end

function ns:OpenOptionsPanel()
	-- Combat first: the Settings panel is protected there, so every route below is blocked.
	if InCombatLockdown() then
		ns:PrintMessage(L["CHAT_OPTIONS_IN_COMBAT"])
		return
	end

	if not ns.optionsFrames then
		return
	end

	if Settings and Settings.OpenToCategory and ns.optionsFrames.categoryID then
		Settings.OpenToCategory(ns.optionsFrames.categoryID)
		return
	end

	LibStub("AceConfigDialog-3.0"):Open(ns.OPTIONS_REGISTRY.General)
end

--------------------------------------------------------------------------------
-- Slash Commands (/thankyou .. /thankyou5)
--------------------------------------------------------------------------------

--[[
    One command per Thank You button, generated from the same list the macros and
    the options sections come from. The command TEXT is what users and their
    existing macros type, and button 1's is unchanged; only the internal
    SlashCmdList key is namespaced, which nothing outside this file reads.
]]
for index, button in ipairs(ns.Data.THANK_YOU_BUTTONS) do
	local key = "TFTB_THANKYOU" .. index
	_G["SLASH_" .. key .. "1"] = button.command
	SlashCmdList[key] = function()
		if ns.RunThankYou then
			ns.RunThankYou(button)
		end
	end
end
