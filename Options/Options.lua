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

	if ns.BuildGiveThanksOptions then
		AceConfig:RegisterOptionsTable(registry.GiveThanks, ns.BuildGiveThanksOptions())
		local _, strangersID = AceConfigDialog:AddToBlizOptions(registry.GiveThanks, L["TAB_GIVE_THANKS"], parent)
		ns.optionsFrames.strangersID = strangersID
	end

	--[[
	    Emotes List and Ignored Buffs are child panels of Give Thanks, in that
	    order. A panel nested one level further down passes its parent's captured
	    category ID, not its title: AddToBlizOptions resolves a parent by name
	    only among top-level panels. Ignored Buffs registers as the builder, so
	    every repaint lists the current buffs.
	]]
	if ns.BuildEmotesListOptions then
		AceConfig:RegisterOptionsTable(registry.EmotesList, ns.BuildEmotesListOptions())
		AceConfigDialog:AddToBlizOptions(registry.EmotesList, L["TAB_EMOTES_LIST"], ns.optionsFrames.strangersID)
	end

	if ns.BuildIgnoredBuffsOptions then
		AceConfig:RegisterOptionsTable(registry.IgnoredBuffs, ns.BuildIgnoredBuffsOptions)
		local ignoredPanel = AceConfigDialog:AddToBlizOptions(
			registry.IgnoredBuffs,
			L["TAB_IGNORED_BUFFS"],
			ns.optionsFrames.strangersID
		)
		ns.PrepareIgnoredBuffsTree(ignoredPanel)
	end

	--[[
	    Good News, then its Tracked Abilities child, nested by the captured
	    category ID for the same reason as Give Thanks' children. Tracked
	    Abilities registers as the builder, so every repaint names items the
	    client has loaded since.
	]]
	if ns.BuildGoodNewsOptions then
		AceConfig:RegisterOptionsTable(registry.GoodNews, ns.BuildGoodNewsOptions())
		local _, goodNewsID = AceConfigDialog:AddToBlizOptions(registry.GoodNews, L["TAB_GOOD_NEWS"], parent)
		if ns.BuildGoodNewsAbilitiesOptions then
			AceConfig:RegisterOptionsTable(registry.GoodNewsAbilities, ns.BuildGoodNewsAbilitiesOptions)
			AceConfigDialog:AddToBlizOptions(registry.GoodNewsAbilities, L["TAB_GOOD_NEWS_ABILITIES"], goodNewsID)
		end
	end

	if ns.BuildThankYouButtonOptions then
		AceConfig:RegisterOptionsTable(registry.ThankYouButton, ns.BuildThankYouButtonOptions())
		AceConfigDialog:AddToBlizOptions(registry.ThankYouButton, L["TAB_THANK_YOU_BUTTON"], parent)
	end

	-- Registered as the builder, so every repaint lists the current guilds and names.
	if ns.BuildWaveToFriendsOptions then
		AceConfig:RegisterOptionsTable(registry.WaveToFriends, ns.BuildWaveToFriendsOptions)
		AceConfigDialog:AddToBlizOptions(registry.WaveToFriends, L["TAB_WAVE_TO_FRIENDS"], parent)
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
