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

-- Chat draws the {rt1} marker as the Star icon; panel text needs the texture itself.
local MARKER_TEXTURE = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:16|t"

local function MarkerAsTexture(message)
	return (message:gsub(ns.TARGET_MARKER, MARKER_TEXTURE, 1))
end

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
    Intellect) and the Mage who cast it, so the Example line, the Room Left
    meter and Send Test to Me all measure and send the same message.
]]
local function SampleLink()
	return ns.GetSpellLink(ns.GAME_IDS.SAMPLE_BUFF_SPELL_ID) or ""
end

local function SampleBuffer()
	return ns.SAMPLE_NAMES[SAMPLE_CLASS]
end

--[[
    The Example line under the whisper rows, hidden with them: the whisper as
    the buffer receives it, "[You] whispers: ...", in the whisper color.
]]
local function DefineWhisperExample(settings, order, hidden)
	return ns.OptionsExample(function()
		local message = ns:BuildThanksWhisper(settings().whisperMessage, SampleLink(), SampleBuffer())
		return ns.SampleWhisper(MarkerAsTexture(message or ""))
	end, order, hidden)
end

--[[
    The whisper composer, the house pattern for any message a player can word
    themselves and TFTB sends for them. In order:

    - Send Messages In: the language the message goes out in. Picking another
      swaps in that language's default text, but only while the box still holds
      the old language's default, so nobody's own words are ever replaced.
    - The message row: the Star marker, the box, the "// TFTB" sign-off and
      Reset. The marker and sign-off are captions, not part of the box: SignOff
      adds them to whatever is typed, so they can't be deleted, and showing them
      either side makes that plain before anything is sent.
    - Room Left under the caption, tokens under the box: how many bytes are
      left once the marker, sign-off and the sample buff's link are in, and
      what the box understands. Bytes, not letters, because that is what the
      chat ceiling counts, and Cyrillic, Korean and Chinese spend two or three
      per letter. Past the ceiling a line
      says the default will go instead (ns:BuildThanksWhisper).
    - The Example line and Send Test to Me, built by the same code that sends.

    Everything follows the whisper toggle. The box keeps whatever is typed.
]]
local WHISPER_LABEL_WIDTH = 0.9
local WHISPER_MARKER_WIDTH = 0.15
local WHISPER_SIGN_OFF_WIDTH = 0.35
local WHISPER_RESET_WIDTH = 0.5
local WHISPER_INPUT_WIDTH = ns.OPTIONS_ROW_WIDTH
	- WHISPER_LABEL_WIDTH
	- WHISPER_MARKER_WIDTH
	- WHISPER_SIGN_OFF_WIDTH
	- WHISPER_RESET_WIDTH
-- The hint row's first cell spans the label and the marker, so its second starts under the box.
local WHISPER_HINT_INDENT = WHISPER_LABEL_WIDTH + WHISPER_MARKER_WIDTH
local WHISPER_LANGUAGE_WIDTH = 1.2
local WHISPER_TEST_WIDTH = 1.0

local languageValues, languageSorting

local function LanguageChoices()
	if not languageValues then
		languageValues, languageSorting = {}, {}
		for _, language in ipairs(Data.MESSAGE_LANGUAGES) do
			languageValues[language.locale] = language.name
			languageSorting[#languageSorting + 1] = language.locale
		end
	end
	return languageValues, languageSorting
end

local function DefineWhisperComposer(args, settings, order)
	local function hidden()
		return not settings().whisperEnabled
	end
	local function messageHidden()
		return hidden() or (settings().whisperMessage or "") == ""
	end
	local function RoomLeft()
		local message = ns.FillThanksWhisper(settings().whisperMessage or "", SampleLink(), SampleBuffer())
		return ns.CHAT_MESSAGE_MAX_LENGTH - #message
	end

	-- Send Messages In
	args.messageLanguageLabel = ns.OptionsRowLabel(
		L["SEND_MESSAGES_IN"],
		order,
		WHISPER_LABEL_WIDTH,
		hidden,
		L["SEND_MESSAGES_IN_DESCRIPTION"]
	)
	args.messageLanguage = {
		type = "select",
		name = "",
		desc = L["SEND_MESSAGES_IN_DESCRIPTION"],
		width = WHISPER_LANGUAGE_WIDTH,
		order = order + 0.01,
		hidden = hidden,
		values = function()
			return (LanguageChoices())
		end,
		sorting = select(2, LanguageChoices()),
		get = function()
			return ns.GetMessageLanguage()
		end,
		set = function(_, value)
			if settings().whisperMessage == ns.GetDefaultThanksWhisper(ns.GetMessageLanguage()) then
				settings().whisperMessage = ns.GetDefaultThanksWhisper(value)
			end
			ns.db.profile.messageLanguage = value
		end,
	}
	args.messageLanguageSpacer = ns.OptionsSpacer(order + 0.05, hidden)

	-- The message row: label, marker, box, sign-off, Reset.
	args.whisperMessageLabel = ns.OptionsRowLabel(
		L["WHISPER_MESSAGE"],
		order + 0.1,
		WHISPER_LABEL_WIDTH,
		hidden,
		L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"]
	)
	args.whisperMarker = ns.OptionsRowLabel(
		MARKER_TEXTURE,
		order + 0.11,
		WHISPER_MARKER_WIDTH,
		hidden,
		L["WHISPER_SIGN_OFF_DESCRIPTION"]
	)
	args.whisperMessage = {
		type = "input",
		name = "",
		desc = L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"],
		width = WHISPER_INPUT_WIDTH,
		order = order + 0.12,
		hidden = hidden,
		get = function()
			return settings().whisperMessage
		end,
		set = function(_, value)
			settings().whisperMessage = (value or ""):match("^%s*(.-)%s*$")
		end,
	}
	args.whisperSignOff = ns.OptionsRowLabel(
		GetColor("SEPARATOR") .. "// " .. L["ADDON_SHORT_NAME"] .. "|r",
		order + 0.13,
		WHISPER_SIGN_OFF_WIDTH,
		hidden,
		L["WHISPER_SIGN_OFF_DESCRIPTION"]
	)
	args.whisperMessageReset = {
		type = "execute",
		name = L["WHISPER_MESSAGE_RESET"],
		desc = L["WHISPER_MESSAGE_RESET_DESCRIPTION"],
		width = WHISPER_RESET_WIDTH,
		order = order + 0.14,
		hidden = hidden,
		func = function()
			settings().whisperMessage = ns.GetDefaultThanksWhisper()
		end,
	}

	--[[
	    Room Left in the label column, under the caption, and the tokens line
	    beside it, under the box: the tokens get the full width in every locale.
	    With the box empty there is nothing to measure, so the cell goes blank
	    rather than hiding, which would pull the tokens line left.
	]]
	args.whisperRoomLeft = ns.OptionsRowLabel(
		function()
			if (settings().whisperMessage or "") == "" then
				return " "
			end
			local left = RoomLeft()
			return GetColor(left < 0 and "OFF" or "HELP") .. L["WHISPER_ROOM_LEFT"]:format(left) .. "|r"
		end,
		order + 0.2,
		WHISPER_HINT_INDENT,
		hidden,
		L["WHISPER_ROOM_LEFT_DESCRIPTION"]
	)
	args.whisperTokens = {
		type = "description",
		name = function()
			local info = GetColor("INFO")
			return GetColor("HELP")
				.. L["WHISPER_TOKENS"]:format(
					info .. "{spell}" .. GetColor("HELP"),
					info .. "{name}" .. GetColor("HELP")
				)
				.. "|r"
		end,
		width = ns.OPTIONS_ROW_WIDTH - WHISPER_HINT_INDENT,
		fontSize = "medium",
		order = order + 0.21,
		hidden = hidden,
	}

	-- Past the ceiling: say what will happen instead.
	local function fitsHidden()
		return messageHidden() or RoomLeft() >= 0
	end
	args.whisperTooLongIndent = ns.OptionsRowLabel(" ", order + 0.25, WHISPER_HINT_INDENT, fitsHidden)
	args.whisperTooLong = {
		type = "description",
		name = GetColor("OFF") .. L["WHISPER_TOO_LONG"] .. "|r",
		width = ns.OPTIONS_ROW_WIDTH - WHISPER_HINT_INDENT,
		fontSize = "medium",
		order = order + 0.26,
		hidden = fitsHidden,
	}

	-- The Example line, then Send Test to Me.
	args.whisperExampleSpacer = ns.OptionsSpacer(order + 0.3, messageHidden)
	args.whisperExample = DefineWhisperExample(settings, order + 0.31, messageHidden)
	args.whisperTestSpacer = ns.OptionsSpacer(order + 0.35, messageHidden)
	args.whisperTest = {
		type = "execute",
		name = L["WHISPER_TEST"],
		desc = L["WHISPER_TEST_DESCRIPTION"],
		width = WHISPER_TEST_WIDTH,
		order = order + 0.36,
		hidden = messageHidden,
		func = function()
			ns:WhisperThanksTest(settings().whisperMessage, SampleLink(), SampleBuffer())
		end,
	}
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
		name = L["PRAISE_WHISPER_ENABLE"],
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
			-- The limits come first: they hold back the emote and the whisper alike.
			-- Dropdowns over Data.SECONDS_CHOICES, the scale that explains its own steps.
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
			headerWhispers = ns.OptionsHeader(L["WHISPERS_HEADER"], 40),
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
