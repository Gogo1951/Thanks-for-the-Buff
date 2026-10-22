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
			spaceMinimap = ns.OptionsSpacer(4.5),
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
					ns.RefreshMinimapButton()
				end,
			},
			-- Features
			spaceFeatures0 = ns.OptionsSpacer(10),
			headerFeatures = ns.OptionsHeader(L["OPTIONS_FEATURES_HEADER"], 11),
			spaceFeatures1 = ns.OptionsSpacer(12),
			descFeatures = ns.OptionsDesc(L["OPTIONS_FEATURES_DESCRIPTION"], 12.3),
			spaceFeatures2 = ns.OptionsSpacer(12.6),
			-- The feature rows fill 13 onward; the note sits below them.
			spaceFeatures3 = ns.OptionsSpacer(50),
			noteFeatures = ns.OptionsFeaturesNote(51),
			-- /Commands
			spaceCommands0 = ns.OptionsSpacer(60),
			headerCommands = ns.OptionsHeader(L["OPTIONS_COMMANDS_HEADER"], 61),
			spaceCommands1 = ns.OptionsSpacer(62),
			descCommands = ns.OptionsDesc(
				GetColor("INFO") .. L["OPTIONS_COMMAND"] .. "|r" .. "  " .. L["OPTIONS_COMMAND_DESCRIPTION"],
				63
			),
		},
	}

	-- Every feature's switch, two to a line.
	local toggles = {}
	for _, feature in ipairs(ns.FEATURE_SWITCHES) do
		toggles[#toggles + 1] = ns.OptionsFeatureToggle(feature)
	end
	ns.OptionsTogglePairs(options.args, "rowFeatures", 12, toggles)

	return options
end
