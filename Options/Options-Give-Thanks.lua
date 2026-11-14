local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--[[
    "Give Thanks" panel -- a helpful buff on you from a player outside
    your group. Sections in order: the Praise Limits, the thank-you whisper, the
    Notifications only you get. The emote checklist is a child panel of its own,
    Emotes List (Options-Emotes-List.lua), since it is by far the longest.
]]

--------------------------------------------------------------------------------
-- Seconds Dropdowns
--------------------------------------------------------------------------------

--[[
    Always seconds. FormatDuration switches to minutes above 60 and rounds, which
    is right for a buff ticking down and wrong for a fixed list: it would print 89
    as "1 Minute" and 144 as "2 Minutes", two units in one dropdown.
]]
local function FormatChoice(seconds)
	return ns.FormatDuration(seconds, true)
end

-- The listed value closest to what is stored.
local function NearestChoice(value)
	local best, bestGap
	for _, choice in ipairs(Data.SECONDS_CHOICES) do
		local gap = math.abs(choice - (value or 0))
		if not bestGap or gap < bestGap then
			best, bestGap = choice, gap
		end
	end
	return best
end

--[[
    A seconds dropdown over Data.SECONDS_CHOICES.

    `get` snaps to the NEAREST listed value rather than returning what is stored.
    A saved value can sit off the scale -- 25, 47 -- and AceConfig renders a
    select whose value is missing from `values` as an empty box, which a player
    cannot fix without guessing that re-picking is what it wants. Snapping shows
    the closest real option; the stored number is left alone until they choose,
    so nobody's setting is silently rewritten by opening the panel.
]]
local function DefineSecondsSelect(settings, key, order, desc)
	return {
		type = "select",
		desc = desc,
		--[[
		    The right half of a label-beside-control row: the caller pairs this with
		    ns.OptionsRowLabel, the same way every other dropdown in the add-on is
		    built. A select carrying its own `name` stacks the label above itself in
		    header gold, which is not how this UI reads a setting.
		]]
		name = "",
		width = ns.OPTIONS_CONTROL_WIDTH,
		order = order,
		sorting = Data.SECONDS_CHOICES,
		values = function()
			local values = {}
			for _, seconds in ipairs(Data.SECONDS_CHOICES) do
				values[seconds] = FormatChoice(seconds)
			end
			return values
		end,
		get = function()
			return NearestChoice(settings()[key])
		end,
		set = function(_, value)
			settings()[key] = value
		end,
	}
end

--------------------------------------------------------------------------------
-- Example Lines
--------------------------------------------------------------------------------

-- The class whose spell the sample names (Arcane Intellect), so the buffer's name and color agree with it.
local SAMPLE_CLASS = "MAGE"

--[[
    The Example line under the print toggle, hidden with it. build
    gets the sample player's class and name and returns the message body, made
    by the same builder the real print uses.
]]
local function DefinePrintExample(settings, order, build)
	return ns.OptionsExample(
		function()
			return ns.TintText(
				GetColor("TEXT"),
				ns.GetPrintPrefix() .. build(SAMPLE_CLASS, ns.SAMPLE_NAMES[SAMPLE_CLASS])
			)
		end,
		order,
		function()
			return not settings().printEnabled
		end
	)
end

--[[
    The whisper section's sample: the buff the panels always show (Arcane
    Intellect) and the Mage who cast it, so the Example line, the Too Long
    check and Send Test to Me all measure and send the same message.
]]
local function SampleLink()
	return ns.GetSpellLink(ns.GAME_IDS.SAMPLE_BUFF_SPELL_ID) or ""
end

local function SampleBuffer()
	return ns.SAMPLE_NAMES[SAMPLE_CLASS]
end

-- The thank-you whisper's composer (ns.DefineWhisperComposer), following the whisper toggle.
local function DefineWhisperComposer(args, settings, order)
	ns.DefineWhisperComposer(args, {
		settings = settings,
		hidden = function()
			return not settings().whisperEnabled
		end,
		default = ns.GetDefaultThanksWhisper,
		fill = function(text)
			return ns.FillThanksWhisper(text, SampleLink(), SampleBuffer())
		end,
		build = function(text)
			return ns:BuildThanksWhisper(text, SampleLink(), SampleBuffer())
		end,
		test = function(text)
			ns:WhisperThanksTest(text, SampleLink(), SampleBuffer())
		end,
		tokens = function()
			local info, help = GetColor("INFO"), GetColor("HELP")
			return L["WHISPER_TOKENS"]:format(info .. "{spell}" .. help, info .. "{name}" .. help)
		end,
		description = L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"],
	}, order)
end

-- The blank line above an Example, hidden whenever the Example is.
local function DefineExampleSpacer(settings, key, order)
	return ns.OptionsSpacer(order, function()
		return not settings()[key]
	end)
end

--------------------------------------------------------------------------------
-- Praise & Notification Controls
--------------------------------------------------------------------------------

--[[
    The reaction toggles, one factory each: the whisper, praise the other player
    sees, and the print and the sound only you get. The emotes are a checklist
    of their own (Options/Options-Emote-Grid.lua). Every factory takes a
    `settings` accessor returning ns.db.profile.strangers.
]]
local function DefineWhisperToggle(settings, order)
	return {
		type = "toggle",
		name = L["GIVE_THANKS_WHISPER_ENABLE"],
		desc = L["PRAISE_WHISPER_DESCRIPTION"],
		width = "full",
		order = order,
		get = function()
			return settings().whisperEnabled
		end,
		set = function(_, value)
			settings().whisperEnabled = value
		end,
	}
end

local function DefinePrintToggle(settings, order)
	return {
		type = "toggle",
		name = L["NOTIFICATIONS_PRINT_ENABLE"],
		desc = L["NOTIFICATIONS_PRINT_DESCRIPTION"],
		width = "full",
		order = order,
		get = function()
			return settings().printEnabled
		end,
		set = function(_, value)
			settings().printEnabled = value
		end,
	}
end

--[[
    The "Enable Sound Effects" toggle. NOT
    full-width: its DefineSoundPreview speaker shares the row, and full-width
    would push the speaker onto its own line.
]]
local function DefineSoundToggle(settings, order)
	return {
		type = "toggle",
		name = L["NOTIFICATIONS_SOUND_ENABLE"],
		desc = L["NOTIFICATIONS_SOUND_DESCRIPTION"],
		order = order,
		get = function()
			return settings().soundEnabled
		end,
		set = function(_, value)
			settings().soundEnabled = value
		end,
	}
end

--[[
    The speaker icon that previews the sound effect, placed on the same row
    right after its "Enable Sound Effects" toggle. It plays regardless of the
    toggle's state -- hearing the sound BEFORE enabling it is the point. The
    texture is the client's own voice-chat speaker, so it matches the UI in
    every locale without shipping art.
]]
local function DefineSoundPreview(playSound, order)
	return {
		type = "execute",
		name = "",
		desc = L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"],
		image = "Interface\\Common\\VoiceChat-Speaker",
		imageWidth = 16,
		imageHeight = 16,
		width = 0.15,
		order = order,
		func = playSound,
	}
end

--[[
    "Enable Praise Delay" and the dropdown that sets its length. The delay holds
    back the whisper and the emote only: the print and the sound are your own
    heads-up and stay instant. The toggle takes the label half of the row and
    the dropdown the other half, so the two total one row and the dropdown sits
    clear of the caption.
]]
local function DefinePraiseDelayToggle(settings, order)
	return {
		type = "toggle",
		name = L["PRAISE_DELAY_ENABLE"],
		desc = L["PRAISE_DELAY_DESCRIPTION"],
		width = ns.OPTIONS_LABEL_WIDTH,
		order = order,
		get = function()
			return settings().praiseDelayEnabled
		end,
		set = function(_, value)
			settings().praiseDelayEnabled = value
		end,
	}
end

--[[
    Nothing to set while the delay is off, so the dropdown only appears with it.
    Its labels come from the client's own duration strings (ns.FormatDuration), so
    "2 seconds" reads correctly in every language without TFTB shipping a string
    per length. Data.PRAISE_DELAY_CHOICES doubles as the display order.
]]
local function DefinePraiseDelaySelect(settings, order)
	return {
		type = "select",
		name = "",
		desc = L["PRAISE_DELAY_LENGTH_DESCRIPTION"],
		width = ns.OPTIONS_CONTROL_WIDTH,
		order = order,
		hidden = function()
			return not settings().praiseDelayEnabled
		end,
		sorting = Data.PRAISE_DELAY_CHOICES,
		values = function()
			local values = {}
			for _, seconds in ipairs(Data.PRAISE_DELAY_CHOICES) do
				values[seconds] = ns.FormatDuration(seconds)
			end
			return values
		end,
		get = function()
			return settings().praiseDelay
		end,
		set = function(_, value)
			settings().praiseDelay = value
		end,
	}
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.BuildGiveThanksOptions()
	local function settings()
		return ns.db.profile.strangers
	end

	local options = {
		name = L["TAB_GIVE_THANKS"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["GIVE_THANKS_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),

			--[[
			    Master switch: everything below it hides when off, and the feature
			    itself stops -- see the `enabled` gate in Praise. Its twin sits in
			    the General panel's Features section. Fractional orders keep it above
			    the first header without renumbering the panel.
			]]
			enable = ns.OptionsFeatureToggle(ns.GetFeatureSwitch("strangers"), 2.5),
			enableSpacer = ns.OptionsSpacer(2.6),

			headerPraise = ns.OptionsHeader(L["PRAISE_HEADER"], 3),
			space1 = ns.OptionsSpacer(4),
			descPraise = ns.OptionsDesc(L["PRAISE_DESCRIPTION"], 4.3),
			spacePraise = ns.OptionsSpacer(4.6),
			-- The limits come first, as dropdowns over Data.SECONDS_CHOICES: they hold back the emote and the whisper alike.
			praiseCooldownStrangersLabel = ns.OptionsRowLabel(
				L["GIVE_THANKS_OVERALL_COOLDOWN"],
				11,
				nil,
				nil,
				L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"]
			),
			praiseCooldownStrangers = DefineSecondsSelect(
				settings,
				"praiseCooldown",
				11.1,
				L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"]
			),
			space4 = ns.OptionsSpacer(12),
			cooldownStrangersLabel = ns.OptionsRowLabel(
				L["GIVE_THANKS_SOURCE_COOLDOWN"],
				13,
				nil,
				nil,
				L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"]
			),
			cooldownStrangers = DefineSecondsSelect(
				settings,
				"cooldown",
				13.1,
				L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"]
			),
			space5 = ns.OptionsSpacer(14),
			minDurationStrangersLabel = ns.OptionsRowLabel(
				L["GIVE_THANKS_MIN_DURATION"],
				15,
				nil,
				nil,
				L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"]
			),
			minDurationStrangers = DefineSecondsSelect(
				settings,
				"minBuffDuration",
				15.1,
				L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"]
			),
			space6 = ns.OptionsSpacer(16),
			-- Praise Delay closes the section.
			praiseDelayStrangers = DefinePraiseDelayToggle(settings, 17),
			praiseDelayLengthStrangers = DefinePraiseDelaySelect(settings, 18),
			space7 = ns.OptionsSpacer(19),

			-- The emote checklist has its own child panel, Emotes List.
			headerWhispers = ns.OptionsHeader(L["GIVE_THANKS_WHISPER_HEADER"], 40),
			spaceWhispers = ns.OptionsSpacer(40.5),
			whisperStrangers = DefineWhisperToggle(settings, 41),
			-- 41.1 through 41.5 belong to the whisper composer, added below.
			whisperComposerSpacer = DefineExampleSpacer(settings, "whisperEnabled", 41.05),
			spaceAfterWhispers = ns.OptionsSpacer(42),

			headerNotifications = ns.OptionsHeader(L["NOTIFICATIONS_HEADER"], 50),
			space8 = ns.OptionsSpacer(51),
			descNotifications = ns.OptionsDesc(L["NOTIFICATIONS_DESCRIPTION"], 51.3),
			spaceNotifications = ns.OptionsSpacer(51.6),
			printStrangers = DefinePrintToggle(settings, 52),
			printExampleSpacer = DefineExampleSpacer(settings, "printEnabled", 52.3),
			printExample = DefinePrintExample(settings, 52.6, function(class, name)
				return ns:BuildStrangerMessage(class, name, ns.GetSpellLink(ns.GAME_IDS.SAMPLE_BUFF_SPELL_ID) or "")
			end),
			space9 = ns.OptionsSpacer(53),
			soundStrangers = DefineSoundToggle(settings, 54),
			soundPreviewStrangers = DefineSoundPreview(ns.PlayBuffSound, 55),
			spaceAfterNotifications = ns.OptionsSpacer(56),
		},
	}

	DefineWhisperComposer(options.args, settings, 41.1)

	-- Intro text and the switch itself stay; everything else follows the switch.
	ns.HideAllExcept(options.args, function()
		return not settings().enabled
	end, { descIntro = true, space0 = true, enable = true })

	return options
end
