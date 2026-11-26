local _, ns = ...
local Data = ns.Data
local L = ns.L
local Kit = ns.OptionsKit

local GetColor = ns.GetColor

--------------------------------------------------------------------------------
-- Options-Kit Strings
--------------------------------------------------------------------------------

-- Every string the kit draws, handed over once (Options-Kit.md → Strings).
Kit.SetText({
	example = L["SAMPLE_EXAMPLE"],
	soundPreview = L["OPTIONS_SOUND_PREVIEW_DESCRIPTION"],
	inCombat = L["CHAT_OPTIONS_IN_COMBAT"],
	reset = L["OPTIONS_RESET"],
})

--------------------------------------------------------------------------------
-- Sample Lines
--------------------------------------------------------------------------------

local WHISPER_FALLBACK_COLOR = "FF80FF"

-- The whisper color the player sees in their own chat, so a recolored channel shows as they set it.
local function WhisperColor()
	local info = ChatTypeInfo and ChatTypeInfo.WHISPER
	if not info then
		return WHISPER_FALLBACK_COLOR
	end
	return string.format(
		"%02x%02x%02x",
		math.floor(info.r * 255 + 0.5),
		math.floor(info.g * 255 + 0.5),
		math.floor(info.b * 255 + 0.5)
	)
end

-- The character the panel is open on, in its class color, as a whisper's sender.
local function SampleSender()
	local name = GetUnitName("player") or ""
	local _, class = UnitClass("player")
	local hex = class and Data.CLASS_COLORS[class]
	if hex then
		name = "|cff" .. hex .. name .. "|r"
	end
	return "[" .. name .. "]"
end

-- A whisper as the player receiving it sees it: "[You] whispers: message", in the whisper color.
function ns.SampleWhisper(message)
	local prefix = (CHAT_WHISPER_GET or "%s whispers: "):format(SampleSender())
	return Kit.Tint(WhisperColor(), prefix .. message)
end

-- Chat draws the {rt1} marker as the Star icon; panel text needs the texture itself.
ns.MARKER_TEXTURE = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:16|t"

function ns.MarkerAsTexture(message)
	return (message:gsub(ns.TARGET_MARKER, ns.MARKER_TEXTURE, 1))
end

--------------------------------------------------------------------------------
-- Whisper Composer
--------------------------------------------------------------------------------

--[[
    The whisper composer, the house pattern for any message a player can word
    themselves and TFTB sends for them (Give Thanks and Good News). In order:

    - Send Messages In: the language the message goes out in. One setting for
      the whole profile, so picking another swaps in that language's default
      in every composer still holding the old language's default, and nobody's
      own words are ever replaced.
    - The message row: the Star marker, the box and the "// TFTB" sign-off. The
      marker and sign-off are captions, not part of the box: SignOff adds them
      to whatever is typed, so they can't be deleted, and showing them either
      side makes that plain before anything is sent. A composer with extra
      boxes repeats the row under the first, with no caption.
    - The tokens under the box: what the box understands. Once a filled message
      passes the chat ceiling (in bytes, so Cyrillic, Korean and Chinese get
      there sooner), a red line says the default will go instead. There is no
      live count: the panel only redraws on save, so one would lag the typing.
    - Reset, on its own row under the box, gray while the first box holds the
      default.
    - The Example line and Send Test to Me, built by the same code that sends,
      from the first box.

    `spec` says what the composer edits:
    - settings(): the profile table holding `whisperMessage`.
    - hidden(): true hides the whole composer (its send toggle is off).
    - default(locale): the default text in that language, or in the current one.
    - fill(text): the message as typed with the sample parts, for measuring.
    - build(text): the message as sent with the sample parts, or nil.
    - test(text): sends build's message to the player's own character.
    - tokens: the tokens line, drawn after "Tokens:" in silver.
    - description: the box's tooltip.
    - extraFields: optional; more settings fields, each a box of its own under
      the first, and labelCaption / tokensSuffix to caption them.
]]
local WHISPER_LABEL_WIDTH = 0.9
local WHISPER_MARKER_WIDTH = 0.15
local WHISPER_SIGN_OFF_WIDTH = 0.35
local WHISPER_INPUT_WIDTH = Kit.ROW_WIDTH - WHISPER_LABEL_WIDTH - WHISPER_MARKER_WIDTH - WHISPER_SIGN_OFF_WIDTH
-- The hint rows' first cell spans the label and the marker, so their second starts under the box.
local WHISPER_HINT_INDENT = WHISPER_LABEL_WIDTH + WHISPER_MARKER_WIDTH
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

--[[
    Every message with a language default: its profile table and its default.
    A language change swaps the new default into each one still holding the old
    language's, from the panel or the menu alike.
]]
local LANGUAGE_DEFAULTS = {
	{
		settings = function()
			return ns.db.profile.strangers
		end,
		default = function(locale)
			return ns.GetDefaultThanksWhisper(locale)
		end,
	},
	{
		settings = function()
			return ns.db.profile.goodNews
		end,
		default = function(locale)
			return ns.GetDefaultGoodNewsWhisper(locale)
		end,
	},
}

function ns.SetMessageLanguage(value)
	local current = ns.GetMessageLanguage()
	for _, message in ipairs(LANGUAGE_DEFAULTS) do
		local settings = message.settings()
		if settings.whisperMessage == message.default(current) then
			settings.whisperMessage = message.default(value)
		end
	end
	ns.db.profile.messageLanguage = value
	ns.RefreshSettings()
end

-- The Send Messages In choices, locale → name, and their order.
ns.GetMessageLanguageChoices = LanguageChoices

local function Trim(value)
	return (value or ""):match("^%s*(.-)%s*$")
end

-- One message row: caption, marker, box, sign-off. Totals the row.
local function MessageRow(order, hidden, spec, field, caption)
	return Kit.Row(order, hidden, {
		Kit.Label(caption, nil, WHISPER_LABEL_WIDTH, caption ~= " " and spec.description or nil),
		Kit.Label(ns.MARKER_TEXTURE, nil, WHISPER_MARKER_WIDTH, L["WHISPER_SIGN_OFF_DESCRIPTION"]),
		{
			type = "input",
			name = "",
			desc = spec.description,
			width = WHISPER_INPUT_WIDTH,
			get = function()
				return spec.settings()[field]
			end,
			set = function(_, value)
				spec.settings()[field] = Trim(value)
				ns.RefreshSettings()
			end,
		},
		Kit.Label(
			GetColor("SEPARATOR") .. "// " .. L["ADDON_SHORT_NAME"] .. "|r",
			nil,
			WHISPER_SIGN_OFF_WIDTH,
			L["WHISPER_SIGN_OFF_DESCRIPTION"]
		),
	})
end

-- A line under the box, held clear of the label column.
local function HintRow(order, hidden, line)
	line.width = Kit.ROW_WIDTH - WHISPER_HINT_INDENT
	return Kit.Row(order, hidden, { Kit.Label(" ", nil, WHISPER_HINT_INDENT), line })
end

-- Fills `order` through `order + 0.36`.
function ns.DefineWhisperComposer(args, spec, order)
	local hidden = spec.hidden
	local fields = { "whisperMessage" }
	for _, field in ipairs(spec.extraFields or {}) do
		fields[#fields + 1] = field
	end
	local function messageHidden()
		return hidden() or (spec.settings().whisperMessage or "") == ""
	end

	-- Send Messages In
	local values, sorting = LanguageChoices()
	args.messageLanguage = Kit.LabelRow(order, hidden, L["SEND_MESSAGES_IN"], {
		type = "select",
		desc = L["SEND_MESSAGES_IN_DESCRIPTION"],
		values = values,
		sorting = sorting,
		get = function()
			return ns.GetMessageLanguage()
		end,
		set = function(_, value)
			ns.SetMessageLanguage(value)
		end,
	})
	args.messageLanguageSpacer = Kit.Spacer(order + 0.05, hidden)

	-- The message rows: the first captioned, any extra boxes under it.
	for index, field in ipairs(fields) do
		local caption = index == 1 and (spec.labelCaption or L["WHISPER_MESSAGE"]) or " "
		args["whisperMessageRow" .. index] = MessageRow(order + 0.1 + index * 0.001, hidden, spec, field, caption)
	end

	-- The tokens line under the boxes.
	args.whisperTokens = HintRow(order + 0.2, hidden, {
		type = "description",
		name = function()
			return GetColor("HELP") .. spec.tokens() .. (spec.tokensSuffix or "") .. "|r"
		end,
		fontSize = "medium",
	})

	-- Past the ceiling: say what will happen instead.
	local function tooLong()
		if hidden() then
			return false
		end
		for _, field in ipairs(fields) do
			local text = spec.settings()[field] or ""
			if text ~= "" and #spec.fill(text) > ns.CHAT_MESSAGE_MAX_LENGTH then
				return true
			end
		end
		return false
	end
	args.whisperTooLong = HintRow(order + 0.25, function()
		return not tooLong()
	end, Kit.WarningLine(L["WHISPER_TOO_LONG"], tooLong))

	-- Reset, on its own row under the box.
	args.whisperMessageReset = Kit.ResetRow(
		order + 0.27,
		hidden,
		" ",
		L["WHISPER_MESSAGE_RESET_DESCRIPTION"],
		function()
			return spec.settings().whisperMessage == spec.default()
		end,
		function()
			spec.settings().whisperMessage = spec.default()
		end
	)

	-- The Example: the whisper as the recipient gets it, "[You] whispers: ...". Then Send Test to Me.
	args.whisperExample = Kit.Example(order + 0.31, messageHidden, function()
		return ns.SampleWhisper(ns.MarkerAsTexture(spec.build(spec.settings().whisperMessage) or ""))
	end)
	args.whisperTestSpacer = Kit.Spacer(order + 0.35, messageHidden)
	args.whisperTest = {
		type = "execute",
		name = L["WHISPER_TEST"],
		desc = L["WHISPER_TEST_DESCRIPTION"],
		width = WHISPER_TEST_WIDTH,
		order = order + 0.36,
		hidden = messageHidden,
		func = function()
			spec.test(spec.settings().whisperMessage)
		end,
	}
end

--------------------------------------------------------------------------------
-- Features
--------------------------------------------------------------------------------

--[[
    Every feature's on/off switch, in menu order. The root panel's Features
    section, each feature panel's Enable switch and the mini-map menu all build
    from this one list (Options-Kit.md → Features), so every copy shares its
    caption, tooltip and setter, and flipping any one repaints the rest.
]]
ns.FEATURES = {
	{
		store = "profile",
		setting = "strangers.enabled",
		name = "TAB_GIVE_THANKS",
		caption = "GIVE_THANKS_ENABLE",
		desc = "GIVE_THANKS_ENABLE_DESCRIPTION",
		block = true,
	},
	{
		store = "profile",
		setting = "wave.enabled",
		name = "TAB_WAVE_TO_FRIENDS",
		caption = "WAVE_ENABLE",
		desc = "WAVE_ENABLE_DESCRIPTION",
		block = true,
	},
}
-- Good News adds itself between the two (Options-Good-News.lua), except on WoW Forever, which doesn't load it.

--------------------------------------------------------------------------------
-- Emote Picker
--------------------------------------------------------------------------------

--[[
    The emote picker: one half-width toggle per entry in Data.EMOTES, for Thank
    You Button 1. Give Thanks uses the larger emote grid instead
    (Options/Options-Emote-Grid.lua). The caller sets `hidden`.
]]
function ns.DefineEmoteGroup(settings, order)
	local group = {
		type = "group",
		name = L["EMOTES_SELECT"],
		order = order,
		inline = true,
		args = {},
	}

	for i, emoteData in ipairs(Data.EMOTES) do
		local emote = emoteData.token
		group.args[emote] = {
			type = "toggle",
			name = ns.GetEmoteCommand(emote),
			-- No tooltip: the command is the whole label. "inline" with no desc tells AceConfigDialog to show none.
			descStyle = "inline",
			order = i,
			width = "half",
			get = function()
				return settings().emotes[emote]
			end,
			set = function(_, value)
				settings().emotes[emote] = value
				ns.RefreshSettings()
			end,
		}
	end

	return group
end

--[[
    The single-emote dropdown's contents, for Thank You Buttons 2 to 5 and Wave
    to Friends' Custom List rows: every emote the client has, plus an explicit
    None, ordered by slash command. Built from ns.GetEmoteCatalog rather than
    Data.EMOTES, since these are a free choice from the whole client set.

    Cached: the catalog cannot change during a session, and the panels rebuild
    on every open otherwise.
]]
local emoteValues, emoteSorting

function ns.GetEmoteSelectChoices()
	if not emoteValues then
		emoteValues = { [""] = L["BUTTON_EMOTE_NONE"] }
		emoteSorting = { "" }
		for _, emote in ipairs(ns.GetEmoteCatalog()) do
			emoteValues[emote.token] = emote.command
			emoteSorting[#emoteSorting + 1] = emote.token
		end
	end
	return emoteValues, emoteSorting
end
