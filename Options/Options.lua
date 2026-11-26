local _, ns = ...
local L = ns.L
local Kit = ns.OptionsKit

--------------------------------------------------------------------------------
-- Registration
--------------------------------------------------------------------------------

--[[
    Every panel registers as its builder through Kit.RegisterPanel, in tree
    order: the root, each feature panel followed by its sub-panels, then
    Profiles, Feedback & Support and Diagnostic Tools at the bottom. A builder
    is rebuilt on every repaint, so lists and names are always current.
]]
function ns.RegisterOptionsPanels()
	local _, categoryID = Kit.RegisterPanel("General", ns.BuildGeneralOptions, L["ADDON_TITLE"])
	-- The root's category ID, which the Diagnostics context report reads.
	ns.optionsFrames = { categoryID = categoryID }

	Kit.RegisterPanel("GiveThanks", ns.BuildGiveThanksOptions, L["TAB_GIVE_THANKS"])
	Kit.RegisterPanel("EmotesList", ns.BuildEmotesListOptions, L["TAB_EMOTES_LIST"], "GiveThanks")
	Kit.RegisterPanel("IgnoredBuffs", ns.BuildIgnoredBuffsOptions, L["TAB_IGNORED_BUFFS"], "GiveThanks")
	-- The tree opens on the character being played, every visit.
	Kit.PrepareTree("IgnoredBuffs", function()
		return ns.db.keys.char
	end)
	-- Return the Favor works with Give Thanks on or off, so it has its own line.
	Kit.RegisterPanel("ReturnBuff", ns.BuildReturnBuffOptions, L["TAB_RETURN_BUFF"])

	Kit.RegisterPanel("WaveToFriends", ns.BuildWaveToFriendsOptions, L["TAB_WAVE_TO_FRIENDS"])

	-- Good News isn't loaded on WoW Forever, so its panels aren't there to register.
	if ns.BuildGoodNewsOptions then
		Kit.RegisterPanel("GoodNews", ns.BuildGoodNewsOptions, L["TAB_GOOD_NEWS"])
		Kit.RegisterPanel(
			"GoodNewsAbilities",
			ns.BuildGoodNewsAbilitiesOptions,
			L["TAB_GOOD_NEWS_ABILITIES"],
			"GoodNews"
		)
	end

	Kit.RegisterPanel("ThankYouButton", ns.BuildThankYouButtonOptions, L["TAB_THANK_YOU_BUTTON"])

	-- Profiles' display name comes already localized from AceDBOptions-3.0.
	Kit.RegisterPanel("Profiles", ns.BuildProfilesOptions, ns.BuildProfilesOptions().name)
	Kit.RegisterPanel("FeedbackSupport", ns.BuildFeedbackSupportOptions, L["OPTIONS_FEEDBACK"])
	Kit.RegisterPanel("Diagnostics", ns.BuildDiagnosticsOptions, ns.DiagnosticsStrings.TAB)
end

--------------------------------------------------------------------------------
-- /tftb
--------------------------------------------------------------------------------

SLASH_TFTB1 = "/tftb"
SlashCmdList.TFTB = function()
	ns:OpenOptionsPanel()
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
