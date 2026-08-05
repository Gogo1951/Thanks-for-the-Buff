local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

-- The whisper row: a caption-sized label, so the message box keeps the rest of the
-- row and a full sentence stays readable while it is being edited.
local WHISPER_LABEL_WIDTH = 0.9
local WHISPER_INPUT_WIDTH = ns.OPTIONS_ROW_WIDTH - WHISPER_LABEL_WIDTH

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.BuildThankYouButtonOptions()
	local options = {
		name = L["TAB_THANK_YOU_BUTTON"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["BUTTON_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),
			createMacro = {
				type = "toggle",
				name = L["BUTTON_CREATE_MACRO"],
				desc = string.format(
					L["BUTTON_CREATE_MACRO_DESCRIPTION"],
					GetColor("TITLE") .. Data.MACRO_NAME .. "|r"
				),
				width = "full",
				order = 10,
				get = function()
					return ns.db.profile.slash.createMacro
				end,
				set = function(_, val)
					ns.db.profile.slash.createMacro = val
				end,
			},
			space1 = ns.OptionsSpacer(11),
			whisperLabel = ns.OptionsRowLabel(L["BUTTON_WHISPER"], 19, WHISPER_LABEL_WIDTH),
			whisperMsg = {
				type = "input",
				name = "",
				width = WHISPER_INPUT_WIDTH,
				order = 20,
				get = function()
					return ns.db.profile.slash.message
				end,
				set = function(_, val)
					ns.db.profile.slash.message = val
				end,
			},
			resetMsg = {
				type = "execute",
				name = L["BUTTON_RESET"],
				desc = L["BUTTON_RESET_DESCRIPTION"],
				width = "half",
				order = 21,
				func = function()
					ns.db.profile.slash.message = L["DEFAULT_WHISPER"]
				end,
			},
			space2 = ns.OptionsSpacer(22),
			slashEmoteGroup = {
				type = "group",
				name = L["PRAISE_EMOTES_SELECT"],
				order = 31,
				inline = true,
				args = {},
			},
		},
	}

	for i, emoteData in ipairs(Data.EMOTES) do
		local emote = emoteData.cmd
		options.args.slashEmoteGroup.args[emote] = {
			type = "toggle",
			name = emoteData.displayName,
			desc = emoteData.desc,
			order = i,
			width = "half",
			get = function()
				return ns.db.profile.slash.emotes[emote]
			end,
			set = function(_, val)
				ns.db.profile.slash.emotes[emote] = val
			end,
		}
	end

	return options
end
