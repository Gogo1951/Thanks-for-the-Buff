local _, ns = ...
local L = ns.L
local Kit = ns.OptionsKit

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

function ns.BuildGeneralOptions()
	local options = {
		name = L["ADDON_TITLE"],
		type = "group",
		args = {
			-- Brief Description
			descIntro = Kit.Desc(L["OPTIONS_DESCRIPTION"], 1),
			space0 = Kit.Spacer(2),
			enableWelcome = {
				type = "toggle",
				name = L["OPTIONS_WELCOME_TOGGLE"],
				desc = L["OPTIONS_WELCOME_DESCRIPTION"],
				width = "full",
				order = 4,
				get = Kit.Get("profile", "showWelcome"),
				set = Kit.Set("profile", "showWelcome"),
			},
			enableMinimap = {
				type = "toggle",
				name = L["OPTIONS_ENABLE_MINIMAP"],
				desc = L["OPTIONS_ENABLE_MINIMAP_DESCRIPTION"],
				width = "full",
				order = 5,
				get = function()
					return not ns.db.profile.minimap.hide
				end,
				set = function(_, value)
					ns.db.profile.minimap.hide = not value
					ns:ApplyMinimapButton()
					ns.RefreshSettings()
				end,
			},
			-- Features: every feature's switch, two to a line.
			spaceFeatures0 = Kit.Spacer(10),
			headerFeatures = Kit.Header(L["OPTIONS_FEATURES_HEADER"], 11),
			spaceFeatures1 = Kit.Spacer(12),
			features = Kit.FeatureSwitches(13),
			-- /Commands
			spaceCommands0 = Kit.Spacer(60),
			headerCommands = Kit.Header(L["OPTIONS_COMMANDS_HEADER"], 61),
			spaceCommands1 = Kit.Spacer(62),
			descCommands = Kit.Desc(
				Kit.Color("INFO", L["OPTIONS_COMMAND"]) .. "  " .. L["OPTIONS_COMMAND_DESCRIPTION"],
				63
			),
			-- Looking for Other Features?
			spaceGoodToGo0 = Kit.Spacer(70),
			headerGoodToGo = Kit.Header(L["OPTIONS_GOOD_TO_GO_HEADER"], 71),
			spaceGoodToGo1 = Kit.Spacer(72),
			descGoodToGo = Kit.Desc(L["OPTIONS_GOOD_TO_GO_DESCRIPTION"], 73),
			spaceGoodToGoCurseForge = Kit.Spacer(74),
			linkGoodToGoCurseForge = Kit.LinkRow(75, L["OPTIONS_CURSEFORGE"], ns.GOOD_TO_GO_LINKS.CURSEFORGE),
			spaceGoodToGoWago = Kit.Spacer(77),
			linkGoodToGoWago = Kit.LinkRow(78, L["OPTIONS_WAGO"], ns.GOOD_TO_GO_LINKS.WAGO),
			spaceGoodToGoCopyLink = Kit.Spacer(80),
			copyCaptionGoodToGo = Kit.Desc(Kit.Color("HELP", L["OPTIONS_COPY_LINK"]), 81),
		},
	}

	return options
end
