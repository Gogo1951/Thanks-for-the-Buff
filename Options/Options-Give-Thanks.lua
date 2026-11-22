local _, ns = ...
local Data = ns.Data
local L = ns.L
local Kit = ns.OptionsKit

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
local function DefineSecondsSelect(settings, key, desc)
	return {
		type = "select",
		desc = desc,
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
			ns.RefreshSettings()
		end,
	}
end

--------------------------------------------------------------------------------
-- Example Lines
--------------------------------------------------------------------------------

-- The class whose spell the sample names (Arcane Intellect), so the buffer's name and color agree with it.
local SAMPLE_CLASS = "MAGE"

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
		-- Up to three boxes; each whisper picks one of the filled ones at random.
		extraFields = { "whisperMessage2", "whisperMessage3" },
		labelCaption = L["WHISPER_MESSAGES"],
		tokensSuffix = "\n" .. L["WHISPER_RANDOM"],
	}, order)
end

--------------------------------------------------------------------------------
-- Praise & Notification Controls
--------------------------------------------------------------------------------

--[[
    The reaction switches: the whisper, praise the other player sees, and the
    print and the sound only you get. The emotes are a checklist of their own
    (Options/Options-Emote-Grid.lua). Every switch reads and writes
    ns.db.profile.strangers.
]]
local function Switch(setting, name, desc)
	return {
		type = "toggle",
		name = name,
		desc = desc,
		width = "full",
		get = Kit.Get("profile", "strangers." .. setting),
		set = Kit.Set("profile", "strangers." .. setting),
	}
end

--[[
    Praise Delay's length. Its labels come from the client's own duration
    strings (ns.FormatDuration), so "2 seconds" reads correctly in every
    language without TFTB shipping a string per length.
    Data.PRAISE_DELAY_CHOICES doubles as the display order.
]]
local function DefinePraiseDelaySelect()
	return {
		type = "select",
		desc = L["PRAISE_DELAY_LENGTH_DESCRIPTION"],
		sorting = Data.PRAISE_DELAY_CHOICES,
		values = function()
			local values = {}
			for _, seconds in ipairs(Data.PRAISE_DELAY_CHOICES) do
				values[seconds] = ns.FormatDuration(seconds)
			end
			return values
		end,
		get = Kit.Get("profile", "strangers.praiseDelay"),
		set = Kit.Set("profile", "strangers.praiseDelay"),
	}
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.BuildGiveThanksOptions()
	local function settings()
		return ns.db.profile.strangers
	end

	-- A Praise Limits row: caption and a seconds dropdown.
	local function LimitRow(order, captionKey, key)
		local desc = L[captionKey .. "_DESCRIPTION"]
		return Kit.LabelRow(order, nil, L[captionKey], DefineSecondsSelect(settings, key, desc))
	end

	local options = {
		name = L["TAB_GIVE_THANKS"],
		type = "group",
		args = {
			descIntro = Kit.Desc(L["GIVE_THANKS_DESCRIPTION"], 1),
			space0 = Kit.Spacer(2),

			--[[
			    Master switch: everything below it hides when off, and the feature
			    itself stops -- see the `enabled` gate in Praise. Its twin sits in
			    the General panel's Features section.
			]]
			enable = Kit.FeatureSwitch("strangers.enabled", 2.5),
			enableSpacer = Kit.Spacer(2.6),

			headerPraise = Kit.Header(L["PRAISE_HEADER"], 3),
			space1 = Kit.Spacer(4),
			descPraise = Kit.Desc(L["PRAISE_DESCRIPTION"], 4.3),
			spacePraise = Kit.Spacer(4.6),
			-- The limits come first, as dropdowns over Data.SECONDS_CHOICES: they hold back the emote and the whisper alike.
			praiseCooldownStrangers = LimitRow(11, "GIVE_THANKS_OVERALL_COOLDOWN", "praiseCooldown"),
			space4 = Kit.Spacer(12),
			cooldownStrangers = LimitRow(13, "GIVE_THANKS_SOURCE_COOLDOWN", "cooldown"),
			space5 = Kit.Spacer(14),
			minDurationStrangers = LimitRow(15, "GIVE_THANKS_MIN_DURATION", "minBuffDuration"),
			space6 = Kit.Spacer(16),
			--[[
			    Praise Delay closes the section, its length beside it while it is on.
			    The delay holds back the whisper and the emote only: the print and the
			    sound are your own heads-up and stay instant.
			]]
			praiseDelayStrangers = Kit.ToggleRow(
				17,
				Switch("praiseDelayEnabled", L["PRAISE_DELAY_ENABLE"], L["PRAISE_DELAY_DESCRIPTION"]),
				{ control = DefinePraiseDelaySelect() }
			),
			space7 = Kit.Spacer(19),

			-- The emote checklist has its own child panel, Emotes List.
			headerWhispers = Kit.Header(L["GIVE_THANKS_WHISPER_HEADER"], 40),
			spaceWhispers = Kit.Spacer(40.5),
			whisperStrangers = Kit.ToggleRow(
				41,
				Switch("whisperEnabled", L["GIVE_THANKS_WHISPER_ENABLE"], L["PRAISE_WHISPER_DESCRIPTION"])
			),
			-- 41.1 through 41.46 belong to the whisper composer, added below.
			whisperComposerSpacer = Kit.Spacer(41.05, function()
				return not settings().whisperEnabled
			end),
			spaceAfterWhispers = Kit.Spacer(42),

			headerNotifications = Kit.Header(L["NOTIFICATIONS_HEADER"], 50),
			space8 = Kit.Spacer(51),
			descNotifications = Kit.Desc(L["NOTIFICATIONS_DESCRIPTION"], 51.3),
			spaceNotifications = Kit.Spacer(51.6),
			printStrangers = Kit.ToggleRow(
				52,
				Switch("printEnabled", L["NOTIFICATIONS_PRINT_ENABLE"], L["NOTIFICATIONS_PRINT_DESCRIPTION"])
			),
			printExample = Kit.Example(52.6, function()
				return not settings().printEnabled
			end, function()
				local link = ns.GetSpellLink(ns.GAME_IDS.SAMPLE_BUFF_SPELL_ID) or ""
				return Kit.PrintedLine(
					ns.GetPrintPrefix() .. ns:BuildStrangerMessage(SAMPLE_CLASS, ns.SAMPLE_NAMES[SAMPLE_CLASS], link)
				)
			end),
			space9 = Kit.Spacer(53),
			-- The speaker previews the sound beside its switch.
			soundStrangers = Kit.ToggleRow(
				54,
				Switch("soundEnabled", L["NOTIFICATIONS_SOUND_ENABLE"], L["NOTIFICATIONS_SOUND_DESCRIPTION"]),
				{ preview = Kit.SoundPreview(ns.PlayBuffSound) }
			),
			spaceAfterNotifications = Kit.Spacer(56),
		},
	}

	DefineWhisperComposer(options.args, settings, 41.1)

	-- Intro text and the switch itself stay; everything else follows the switch.
	Kit.HideAllExcept(options.args, function()
		return not settings().enabled
	end, { "descIntro", "space0", "enable" })

	return options
end
