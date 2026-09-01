local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

-- The Feedback & Support rows: a caption-sized label, so the URL box gets the rest
-- of the row and a full address fits without being cut off.
local LINK_LABEL_WIDTH = 0.6
local LINK_URL_WIDTH = ns.OPTIONS_ROW_WIDTH - LINK_LABEL_WIDTH

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
				set = function(_, val)
					ns.db.profile.showWelcome = val
				end,
			},
			-- /Commands
			spaceCommands0 = ns.OptionsSpacer(5),
			headerCommands = ns.OptionsHeader(L["OPTIONS_COMMANDS_HEADER"], 6),
			spaceCommands1 = ns.OptionsSpacer(7),
			descCommands = ns.OptionsDesc(
				GetColor("INFO") .. L["OPTIONS_COMMAND"] .. "|r" .. "  " .. L["OPTIONS_COMMAND_DESCRIPTION"],
				8
			),
			-- Feedback & Support (house order: Discord, GitHub, CurseForge, Wago)
			spaceLinks0 = ns.OptionsSpacer(69),
			headerLinks = ns.OptionsHeader(L["OPTIONS_SUPPORT"], 70),
			spaceLinks1 = ns.OptionsSpacer(71),
			discordLabel = ns.OptionsRowLabel(GetColor("TITLE") .. L["OPTIONS_DISCORD"] .. "|r", 72, LINK_LABEL_WIDTH),
			discordURL = {
				type = "input",
				name = "",
				order = 73,
				width = LINK_URL_WIDTH,
				get = function()
					return Data.DISCORD_URL
				end,
				set = function() end,
			},
			spaceLinks2 = ns.OptionsSpacer(74),
			githubLabel = ns.OptionsRowLabel(GetColor("TITLE") .. L["OPTIONS_GITHUB"] .. "|r", 75, LINK_LABEL_WIDTH),
			githubURL = {
				type = "input",
				name = "",
				order = 76,
				width = LINK_URL_WIDTH,
				get = function()
					return Data.GITHUB_URL
				end,
				set = function() end,
			},
			spaceLinks3 = ns.OptionsSpacer(77),
			curseforgeLabel = ns.OptionsRowLabel(
				GetColor("TITLE") .. L["OPTIONS_CURSEFORGE"] .. "|r",
				78,
				LINK_LABEL_WIDTH
			),
			curseforgeURL = {
				type = "input",
				name = "",
				order = 79,
				width = LINK_URL_WIDTH,
				get = function()
					return Data.CURSEFORGE_URL
				end,
				set = function() end,
			},
			spaceLinks4 = ns.OptionsSpacer(80),
			wagoLabel = ns.OptionsRowLabel(GetColor("TITLE") .. L["OPTIONS_WAGO"] .. "|r", 81, LINK_LABEL_WIDTH),
			wagoURL = {
				type = "input",
				name = "",
				order = 82,
				width = LINK_URL_WIDTH,
				get = function()
					return Data.WAGO_URL
				end,
				set = function() end,
			},
			-- Version
			spaceVersion0 = {
				type = "description",
				name = " ",
				width = "full",
				order = 998,
			},
			versionLine = {
				type = "description",
				name = GetColor("MUTED") .. "Version " .. ns.Version .. "|r",
				fontSize = "medium",
				order = 999,
			},
		},
	}

	return options
end
