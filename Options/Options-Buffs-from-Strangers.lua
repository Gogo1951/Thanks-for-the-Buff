local _, ns = ...
local L = ns.L

--[[
    "Buffs from Strangers" panel -- a helpful buff on you from a player outside
    your group. Two sections: Praise (what the buffer sees you send back, and the
    limits on it) and Notifications (the chat line and sound only you get). The
    controls themselves come from the shared factories in Options-Utilities.lua.
]]

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.BuildStrangersOptions()
	local function settings()
		return ns.db.profile.strangers
	end

	return {
		name = L["TAB_STRANGERS"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["STRANGERS_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),

			headerPraise = ns.OptionsHeader(L["PRAISE_HEADER"], 3),
			space1 = ns.OptionsSpacer(4),
			emotesStrangers = ns.DefineEmotesToggle(settings, 5),
			emoteSpacer = { type = "description", name = " ", order = 6, hidden = ns.EmotesHidden(settings) },
			strangersEmoteGroup = ns.DefineEmoteGroup(settings, 7),
			space2 = ns.OptionsSpacer(8),
			whisperStrangers = ns.DefineWhisperToggle(settings, 9),
			space3 = ns.OptionsSpacer(10),
			praiseDelayStrangers = ns.DefinePraiseDelayToggle(settings, 11),
			praiseDelayLengthStrangers = ns.DefinePraiseDelaySelect(settings, 12),
			space4 = ns.OptionsSpacer(13),
			praiseCooldownStrangers = {
				type = "range",
				name = L["STRANGERS_OVERALL_COOLDOWN"],
				desc = L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"],
				order = 14,
				width = "double",
				min = 0,
				max = 60,
				step = 1,
				get = function()
					return settings().praiseCooldown
				end,
				set = function(_, val)
					settings().praiseCooldown = val
				end,
			},
			space5 = ns.OptionsSpacer(15),
			cooldownStrangers = {
				type = "range",
				name = L["STRANGERS_SOURCE_COOLDOWN"],
				desc = L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"],
				order = 16,
				width = "double",
				min = 1,
				max = 60,
				step = 1,
				get = function()
					return settings().cooldown
				end,
				set = function(_, val)
					settings().cooldown = val
				end,
			},
			space6 = ns.OptionsSpacer(17),
			minDurationStrangers = {
				type = "range",
				name = L["STRANGERS_MIN_DURATION"],
				desc = L["STRANGERS_MIN_DURATION_DESCRIPTION"],
				order = 18,
				width = "double",
				min = 0,
				max = 120,
				step = 1,
				get = function()
					return settings().minBuffDuration
				end,
				set = function(_, val)
					settings().minBuffDuration = val
				end,
			},
			space7 = ns.OptionsSpacer(19),

			headerNotifications = ns.OptionsHeader(L["NOTIFICATIONS_HEADER"], 20),
			space8 = ns.OptionsSpacer(21),
			printStrangers = ns.DefinePrintToggle(settings, 22),
			space9 = ns.OptionsSpacer(23),
			soundStrangers = ns.DefineSoundToggle(settings, 24),
			soundPreviewStrangers = ns.DefineSoundPreview(ns.PlayBuffSound, 25),
		},
	}
end
