local _, ns = ...
local L = ns.L

local GetColor = ns.GetColor

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

function ns.BuildGeneralOptions()
	local options = {
		name = L["ADDON_TITLE"],
		type = "group",
		args = {
			-- Brief Description
			descIntro = ns.OptionsDesc(L["OPTIONS_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),
			enableWelcome = {
				type = "toggle",
				name = L["OPTIONS_WELCOME_TOGGLE"],
				desc = L["OPTIONS_WELCOME_DESCRIPTION"],
				width = "full",
				order = 4,
				get = function()
					return ns.db.profile.showWelcome
				end,
				set = function(_, value)
					ns.db.profile.showWelcome = value
				end,
			},
			-- Features
			spaceFeatures0 = ns.OptionsSpacer(10),
			headerFeatures = ns.OptionsHeader(L["OPTIONS_FEATURES_HEADER"], 11),
			spaceFeatures1 = ns.OptionsSpacer(12),
			descFeatures = ns.OptionsDesc(L["OPTIONS_FEATURES_DESCRIPTION"], 12.3),
			spaceFeatures2 = ns.OptionsSpacer(12.6),
			-- The feature rows fill 13 onward.
			-- /Commands
			spaceCommands0 = ns.OptionsSpacer(60),
			headerCommands = ns.OptionsHeader(L["OPTIONS_COMMANDS_HEADER"], 61),
			spaceCommands1 = ns.OptionsSpacer(62),
			descCommands = ns.OptionsDesc(
				GetColor("INFO") .. L["OPTIONS_COMMAND"] .. "|r" .. "  " .. L["OPTIONS_COMMAND_DESCRIPTION"],
				63
			),
			-- Looking for Other Features?
			spaceGoodToGo0 = ns.OptionsSpacer(70),
			headerGoodToGo = ns.OptionsHeader(L["OPTIONS_GOOD_TO_GO_HEADER"], 71),
			spaceGoodToGo1 = ns.OptionsSpacer(72),
			descGoodToGo = ns.OptionsDesc(L["OPTIONS_GOOD_TO_GO_DESCRIPTION"], 73),
			spaceGoodToGoCurseForge = ns.OptionsSpacer(74),
			-- 75-76: CurseForge row
			spaceGoodToGoWago = ns.OptionsSpacer(77),
			-- 78-79: Wago row
			spaceGoodToGoCopyLink = ns.OptionsSpacer(80),
			copyCaptionGoodToGo = ns.OptionsDesc(GetColor("HELP") .. L["OPTIONS_COPY_LINK"] .. "|r", 81),
		},
	}

	ns.OptionsLinkRow(options.args, "GoodToGoCurseForge", L["OPTIONS_CURSEFORGE"], ns.GOOD_TO_GO_LINKS.CURSEFORGE, 75)
	ns.OptionsLinkRow(options.args, "GoodToGoWago", L["OPTIONS_WAGO"], ns.GOOD_TO_GO_LINKS.WAGO, 78)

	-- Every feature's switch, two to a line.
	local toggles = {}
	for _, feature in ipairs(ns.FEATURE_SWITCHES) do
		toggles[#toggles + 1] = ns.OptionsFeatureToggle(feature)
	end
	ns.OptionsTogglePairs(options.args, "rowFeatures", 12, toggles)

	return options
end
