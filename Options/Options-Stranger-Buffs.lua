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

	local options = {
		name = L["TAB_STRANGERS"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["STRANGERS_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),

			-- Master switch: everything below it hides when off, and the feature
			-- itself stops -- see the `enabled` gate in Buff-Tracking. Fractional
			-- orders keep it above the first header without renumbering the panel.
			enable = {
				type = "toggle",
				name = L["STRANGERS_ENABLE"],
				width = "full",
				order = 2.5,
				get = function()
					return settings().enabled
				end,
				set = function(_, val)
					settings().enabled = val
				end,
			},
			enableSpacer = { type = "description", name = " ", order = 2.6 },

			headerPraise = ns.OptionsHeader(L["PRAISE_HEADER"], 3),
			space1 = ns.OptionsSpacer(4),
			emotesStrangers = ns.DefineEmotesToggle(settings, 5),
			emoteSpacer = { type = "description", name = " ", order = 6, hidden = ns.EmotesHidden(settings) },
			strangersEmoteGroup = ns.DefineEmoteGroup(settings, 7),
			space2 = ns.OptionsSpacer(8),
			whisperStrangers = ns.DefineWhisperToggle(settings, 9),
			space3 = ns.OptionsSpacer(10),
			--[[
                Dropdowns, not sliders. The old ranges offered every integer from
                0 to 120, which is 121 positions for a choice with maybe a dozen
                meaningful answers -- and made the helper text below each one
                impossible to place. See Data.SECONDS_CHOICES.
            ]]
			praiseCooldownStrangersLabel = ns.OptionsRowLabel(L["STRANGERS_OVERALL_COOLDOWN"], 11),
			praiseCooldownStrangers = ns.DefineSecondsSelect(settings, "praiseCooldown", 11.1),
			praiseCooldownHelp = ns.OptionsHelp(L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"], 11.5),
			space4 = ns.OptionsSpacer(12),
			cooldownStrangersLabel = ns.OptionsRowLabel(L["STRANGERS_SOURCE_COOLDOWN"], 13),
			cooldownStrangers = ns.DefineSecondsSelect(settings, "cooldown", 13.1),
			cooldownHelp = ns.OptionsHelp(L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"], 13.5),
			space5 = ns.OptionsSpacer(14),
			minDurationStrangersLabel = ns.OptionsRowLabel(L["STRANGERS_MIN_DURATION"], 15),
			minDurationStrangers = ns.DefineSecondsSelect(settings, "minBuffDuration", 15.1),
			minDurationHelp = ns.OptionsHelp(L["STRANGERS_MIN_DURATION_DESCRIPTION"], 15.5),
			space6 = ns.OptionsSpacer(16),
			-- Praise Delay closes the section, matching Teammates and Group
			-- Services, where it is already the last praise control.
			praiseDelayStrangers = ns.DefinePraiseDelayToggle(settings, 17),
			praiseDelayLengthStrangers = ns.DefinePraiseDelaySelect(settings, 18),
			praiseDelayHelpStrangers = ns.DefinePraiseDelayHelp(18.5),
			space7 = ns.OptionsSpacer(19),

			headerNotifications = ns.OptionsHeader(L["NOTIFICATIONS_HEADER"], 20),
			space8 = ns.OptionsSpacer(21),
			printStrangers = ns.DefinePrintToggle(settings, 22),
			space9 = ns.OptionsSpacer(23),
			soundStrangers = ns.DefineSoundToggle(settings, 24),
			soundPreviewStrangers = ns.DefineSoundPreview(ns.PlayBuffSound, 25),
		},
	}

	-- Intro text and the switch itself stay; everything else follows the switch.
	ns.HideAllExcept(options.args, function()
		return not settings().enabled
	end, { descIntro = true, space0 = true, enable = true })

	return options
end
