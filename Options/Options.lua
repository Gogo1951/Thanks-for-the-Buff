local _, ns = ...
local L = ns.L

--------------------------------------------------------------------------------
-- Registration
--------------------------------------------------------------------------------

function ns.RegisterOptionsPanels()
	local AceConfig = LibStub("AceConfig-3.0")
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")
	local registry = ns.OPTIONS_REGISTRY
	local parent = L["ADDON_TITLE"]

	AceConfig:RegisterOptionsTable(registry.General, ns.BuildGeneralOptions())
	--[[
	    AddToBlizOptions returns (frame, categoryID). Both are kept: the opener
	    routes by the captured id, falling back to AceConfigDialog:Open, and never
	    resolves the panel by title -- a name lookup returns nil on clients that
	    carry the Settings API, which is what makes the panel open as a floating
	    window.
	]]
	local mainPanel, mainCategoryID = AceConfigDialog:AddToBlizOptions(registry.General, parent)
	ns.optionsFrames = { main = mainPanel, categoryID = mainCategoryID }

	if ns.BuildStrangersOptions then
		AceConfig:RegisterOptionsTable(registry.StrangerBuffs, ns.BuildStrangersOptions())
		AceConfigDialog:AddToBlizOptions(registry.StrangerBuffs, L["TAB_STRANGERS"], parent)
	end

	--[[
	    Each panel with a tracked list gets it as a "Tracked Abilities" sub-panel,
	    nested by the category id AddToBlizOptions hands back, as Buff Duty's are
	    below. The sub-panels register as functions (not prebuilt tables) so the
	    list is rebuilt and re-sorted on open, once lazily-loaded item names are
	    cached.
	]]
	local function AddTrackedSubPanel(appName, builder, parentID)
		AceConfig:RegisterOptionsTable(appName, builder)
		AceConfigDialog:AddToBlizOptions(appName, L["TRACKED_HEADER"], parentID)
	end

	if ns.BuildTeammatesOptions then
		AceConfig:RegisterOptionsTable(registry.TeammateBuffs, ns.BuildTeammatesOptions)
		local _, teammatesID = AceConfigDialog:AddToBlizOptions(registry.TeammateBuffs, L["TAB_TEAMMATES"], parent)
		AddTrackedSubPanel(registry.TeammateBuffsTracked, ns.BuildTeammatesTrackedOptions, teammatesID)
	end

	if ns.BuildGoodNewsOptions then
		AceConfig:RegisterOptionsTable(registry.SendGoodNews, ns.BuildGoodNewsOptions)
		local _, goodNewsID = AceConfigDialog:AddToBlizOptions(registry.SendGoodNews, L["TAB_GOOD_NEWS"], parent)
		AddTrackedSubPanel(registry.SendGoodNewsTracked, ns.BuildGoodNewsTrackedOptions, goodNewsID)
	end

	if ns.BuildServicesOptions then
		AceConfig:RegisterOptionsTable(registry.ServiceAlerts, ns.BuildServicesOptions)
		local _, servicesID = AceConfigDialog:AddToBlizOptions(registry.ServiceAlerts, L["TAB_SERVICES"], parent)
		AddTrackedSubPanel(registry.ServiceAlertsTracked, ns.BuildServicesTrackedOptions, servicesID)
	end

	if ns.BuildPeerPressureOptions then
		AceConfig:RegisterOptionsTable(registry.PeerPressure, ns.BuildPeerPressureOptions)
		local _, peerPressureID =
			AceConfigDialog:AddToBlizOptions(registry.PeerPressure, L["TAB_PEER_PRESSURE"], parent)
		AddTrackedSubPanel(registry.PeerPressureTracked, ns.BuildPeerPressureTrackedOptions, peerPressureID)
	end

	if ns.BuildBuffWindowOptions then
		-- Builders, like Peer Pressure: the class lists exist only after login.
		AceConfig:RegisterOptionsTable(registry.BuffWindow, ns.BuildBuffWindowOptions)
		local _, buffWindowID = AceConfigDialog:AddToBlizOptions(registry.BuffWindow, L["TAB_BUFF_WINDOW"], parent)

		--[[
		    Tracked Abilities, Self-Buffs and Weapon Buffs nest one level deeper, under Buff Duty, by the
		    category id AddToBlizOptions just handed back: the Settings panel finds
		    a parent at any depth and indents each level.
		]]
		AceConfig:RegisterOptionsTable(registry.BuffWindowBuffs, ns.BuildBuffWindowBuffsOptions)
		AceConfigDialog:AddToBlizOptions(registry.BuffWindowBuffs, L["TRACKED_HEADER"], buffWindowID)
		AceConfig:RegisterOptionsTable(registry.BuffWindowSelfBuffs, ns.BuildBuffWindowSelfBuffsOptions)
		AceConfigDialog:AddToBlizOptions(registry.BuffWindowSelfBuffs, L["BUFF_WINDOW_SELF_HEADER"], buffWindowID)
		AceConfig:RegisterOptionsTable(registry.BuffWindowWeaponBuffs, ns.BuildBuffWindowWeaponBuffsOptions)
		AceConfigDialog:AddToBlizOptions(
			registry.BuffWindowWeaponBuffs,
			L["BUFF_WINDOW_WEAPON_PANEL_HEADER"],
			buffWindowID
		)
	end

	if ns.BuildThankYouButtonOptions then
		AceConfig:RegisterOptionsTable(registry.ThankYouButton, ns.BuildThankYouButtonOptions())
		AceConfigDialog:AddToBlizOptions(registry.ThankYouButton, L["TAB_THANK_YOU_BUTTON"], parent)
	end

	--[[
	    Profiles registers after the feature panels, directly above Feedback &
	    Support. Its display name comes already localized from AceDBOptions-3.0.
	]]
	if ns.BuildProfilesOptions then
		local profilesOptions = ns.BuildProfilesOptions()
		AceConfig:RegisterOptionsTable(registry.Profiles, profilesOptions)
		AceConfigDialog:AddToBlizOptions(registry.Profiles, profilesOptions.name, parent)
	end

	if ns.BuildFeedbackSupportOptions then
		AceConfig:RegisterOptionsTable(registry.FeedbackSupport, ns.BuildFeedbackSupportOptions())
		AceConfigDialog:AddToBlizOptions(registry.FeedbackSupport, L["OPTIONS_FEEDBACK"], parent)
	end

	-- Diagnostic Tools registers last so it sits at the bottom of the tree.
	if ns.BuildDiagnosticsOptions then
		--[[
		    Registered as the builder, so every repaint rebuilds it and the enable
		    gate can leave the tabs out of the table while it is off.
		]]
		AceConfig:RegisterOptionsTable(registry.Diagnostics, ns.BuildDiagnosticsOptions)
		AceConfigDialog:AddToBlizOptions(registry.Diagnostics, ns.DiagnosticsStrings.TAB, parent)
	end

	SLASH_TFTB1 = "/tftb"
	SlashCmdList.TFTB = function()
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
    existing macros type; only the internal SlashCmdList key is namespaced.
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
