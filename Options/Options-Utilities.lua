local ADDON_NAME, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--------------------------------------------------------------------------------
-- Shared Options Helpers
--------------------------------------------------------------------------------

--[[
    Every section header in the add-on is a real AceConfig "header" -- the ruled
    line with the title set into it -- and no panel draws its own out of a colored
    description. `hidden` is optional (a function or a boolean) here and on
    OptionsDesc and OptionsSpacer, for the panels whose whole section collapses
    behind a master switch.
]]
function ns.OptionsHeader(text, order, hidden)
	return { type = "header", name = GetColor("TITLE") .. text .. "|r", order = order, hidden = hidden }
end

function ns.OptionsDesc(text, order, hidden)
	return { type = "description", name = text, fontSize = "medium", order = order, hidden = hidden }
end

function ns.OptionsSpacer(order, hidden)
	return { type = "description", name = " ", order = order, hidden = hidden }
end

--[[
    A row label that explains itself on hover. AceConfig gives a description no
    tooltip, so a label-beside-control row read as a bare caption and only its
    control answered the mouse. This is the stock Label with mouse scripts that
    fire AceGUI's OnEnter and OnLeave, which AceConfigDialog already answers with
    the option's name and desc, so the label shows the control's tooltip under
    its own caption.
]]
local AceGUI = LibStub("AceGUI-3.0")
local ROW_LABEL_WIDGET, ROW_LABEL_VERSION = ADDON_NAME .. "_RowLabel", 1

AceGUI:RegisterWidgetType(ROW_LABEL_WIDGET, function()
	local widget = AceGUI.WidgetRegistry["Label"]()
	widget.type = ROW_LABEL_WIDGET
	widget.frame:EnableMouse(true)
	widget.frame:SetScript("OnEnter", function()
		widget:Fire("OnEnter")
	end)
	widget.frame:SetScript("OnLeave", function()
		widget:Fire("OnLeave")
	end)
	return widget
end, ROW_LABEL_VERSION)

--[[
    The left half of a label-beside-control row: the control that follows carries
    name = "" and ns.OPTIONS_CONTROL_WIDTH, so the two total one row and flow onto
    the same line. A row whose control needs more room passes its own width here.
    `desc` is the control's own tooltip text: given, hovering the label shows it
    too, titled with the label.
]]
function ns.OptionsRowLabel(text, order, width, hidden, desc)
	return {
		type = "description",
		name = text,
		desc = desc,
		dialogControl = desc and ROW_LABEL_WIDGET or nil,
		fontSize = "medium",
		width = width or ns.OPTIONS_LABEL_WIDTH,
		order = order,
		--[[
		    A label has no state of its own, so nothing hides it unless it is told
		    to: on a panel behind a master switch, one left out is the caption that
		    stays floating after everything it described has gone.
		]]
		hidden = hidden,
	}
end

--[[
    A copyable link: a short caption beside a read-only box holding the full URL.
    The caption is one short word, so it takes less than the usual label width
    and the box the rest of the row. Fills `order` and `order + 1`.
]]
local LINK_LABEL_WIDTH = 0.6

function ns.OptionsLinkRow(args, key, caption, url, order)
	args["label" .. key] = ns.OptionsRowLabel(GetColor("TITLE") .. caption .. "|r", order, LINK_LABEL_WIDTH)
	args["url" .. key] = {
		type = "input",
		name = "",
		order = order + 1,
		width = ns.OPTIONS_ROW_WIDTH - LINK_LABEL_WIDTH,
		get = function()
			return url
		end,
		set = function() end,
	}
end

--------------------------------------------------------------------------------
-- Example Lines
--------------------------------------------------------------------------------

--[[
    A panel falls back to white after a link's closing |r, where a chat frame
    falls back to the line's color, so the color is opened again after every |r.
]]
function ns.TintText(color, text)
	return color .. (text:gsub("|r", "|r" .. color)) .. "|r"
end

--[[
    A silver "Example:" line showing the exact string a feature prints or
    sends. getText returns the finished line in its own colors; a function so
    the line redraws as settings change. Silver opens again after the line, for
    a locale whose label runs on past it.
]]
function ns.OptionsExample(getText, order, hidden)
	return {
		type = "description",
		name = function()
			return GetColor("HELP") .. L["SAMPLE_EXAMPLE"]:format(getText() .. GetColor("HELP")) .. "|r"
		end,
		fontSize = "medium",
		order = order,
		hidden = hidden,
	}
end

local WHISPER_FALLBACK_COLOR = "FF80FF"

-- The whisper color the player sees in their own chat, so a recolored channel shows as they set it.
local function WhisperColor()
	local info = ChatTypeInfo and ChatTypeInfo.WHISPER
	if not info then
		return "|cff" .. WHISPER_FALLBACK_COLOR
	end
	return string.format(
		"|cff%02x%02x%02x",
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
	return ns.TintText(WhisperColor(), prefix .. message)
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
    - The message row: the Star marker, the box, the "// TFTB" sign-off and
      Reset. The marker and sign-off are captions, not part of the box: SignOff
      adds them to whatever is typed, so they can't be deleted, and showing them
      either side makes that plain before anything is sent.
    - The tokens under the box: what the box understands. Once the filled
      message passes the chat ceiling (in bytes, so Cyrillic, Korean and Chinese
      get there sooner), a line says the default will go instead. There is no
      live count: the panel only redraws on save, so one would lag the typing.
    - The Example line and Send Test to Me, built by the same code that sends.

    `spec` says what the composer edits:
    - settings(): the profile table holding `whisperMessage`.
    - hidden(): true hides the whole composer (its send toggle is off).
    - default(locale): the default text in that language, or in the current one.
    - fill(text): the message as typed with the sample parts, for measuring.
    - build(text): the message as sent with the sample parts, or nil.
    - test(text): sends build's message to the player's own character.
    - tokens: the tokens line, drawn after "Tokens:" in silver.
    - description: the box's tooltip.
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
local WHISPER_LANGUAGE_WIDTH = ns.OPTIONS_ROW_WIDTH - WHISPER_LABEL_WIDTH
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

-- Every composer built, so a language change reaches each message, whichever panel it was made on.
local composers = {}

local function SetMessageLanguage(value)
	local current = ns.GetMessageLanguage()
	for _, spec in ipairs(composers) do
		local settings = spec.settings()
		if settings.whisperMessage == spec.default(current) then
			settings.whisperMessage = spec.default(value)
		end
	end
	ns.db.profile.messageLanguage = value
end

-- Fills `order` through `order + 0.36`.
function ns.DefineWhisperComposer(args, spec, order)
	composers[#composers + 1] = spec
	local hidden = spec.hidden
	local function messageHidden()
		return hidden() or (spec.settings().whisperMessage or "") == ""
	end

	-- Send Messages In
	args.messageLanguageLabel =
		ns.OptionsRowLabel(L["SEND_MESSAGES_IN"], order, WHISPER_LABEL_WIDTH, hidden, L["SEND_MESSAGES_IN_DESCRIPTION"])
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
			SetMessageLanguage(value)
		end,
	}
	args.messageLanguageSpacer = ns.OptionsSpacer(order + 0.05, hidden)

	-- The message row: label, marker, box, sign-off, Reset.
	args.whisperMessageLabel =
		ns.OptionsRowLabel(L["WHISPER_MESSAGE"], order + 0.1, WHISPER_LABEL_WIDTH, hidden, spec.description)
	args.whisperMarker = ns.OptionsRowLabel(
		ns.MARKER_TEXTURE,
		order + 0.11,
		WHISPER_MARKER_WIDTH,
		hidden,
		L["WHISPER_SIGN_OFF_DESCRIPTION"]
	)
	args.whisperMessage = {
		type = "input",
		name = "",
		desc = spec.description,
		width = WHISPER_INPUT_WIDTH,
		order = order + 0.12,
		hidden = hidden,
		get = function()
			return spec.settings().whisperMessage
		end,
		set = function(_, value)
			spec.settings().whisperMessage = (value or ""):match("^%s*(.-)%s*$")
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
			spec.settings().whisperMessage = spec.default()
		end,
	}

	-- The tokens line under the box, a blank cell holding it clear of the label column.
	args.whisperTokensIndent = ns.OptionsRowLabel(" ", order + 0.2, WHISPER_HINT_INDENT, hidden)
	args.whisperTokens = {
		type = "description",
		name = function()
			return GetColor("HELP") .. spec.tokens() .. "|r"
		end,
		width = ns.OPTIONS_ROW_WIDTH - WHISPER_HINT_INDENT,
		fontSize = "medium",
		order = order + 0.21,
		hidden = hidden,
	}

	-- Past the ceiling: say what will happen instead.
	local function fitsHidden()
		return messageHidden() or #spec.fill(spec.settings().whisperMessage or "") <= ns.CHAT_MESSAGE_MAX_LENGTH
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

	-- The Example line: the whisper as the recipient gets it, "[You] whispers: ...". Then Send Test to Me.
	args.whisperExampleSpacer = ns.OptionsSpacer(order + 0.3, messageHidden)
	args.whisperExample = ns.OptionsExample(function()
		return ns.SampleWhisper(ns.MarkerAsTexture(spec.build(spec.settings().whisperMessage) or ""))
	end, order + 0.31, messageHidden)
	args.whisperTestSpacer = ns.OptionsSpacer(order + 0.35, messageHidden)
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
-- Feature Switches
--------------------------------------------------------------------------------

--[[
    Every feature's on/off switch, built once here and placed twice: at the top
    of the feature's own panel and in the General panel's Features section. Both
    copies bind the same setting and carry the same caption and tooltip, and
    flipping either repaints every panel so the other copy and the settings it
    hides follow at once.
]]
ns.FEATURE_SWITCHES = {
	--[[
	    key: the profile subtable, setting: its on/off field, name/desc: locale keys,
	    onChange: present only for a feature that must react the moment either copy flips.
	]]
	{ key = "strangers", setting = "enabled", name = "GIVE_THANKS_ENABLE", desc = "GIVE_THANKS_ENABLE_DESCRIPTION" },
	{ key = "goodNews", setting = "enabled", name = "GOOD_NEWS_ENABLE", desc = "GOOD_NEWS_ENABLE_DESCRIPTION" },
	{ key = "wave", setting = "enabled", name = "WAVE_ENABLE", desc = "WAVE_ENABLE_DESCRIPTION" },
}

local function NotifyAllPanels()
	local registry = LibStub("AceConfigRegistry-3.0")
	for _, name in pairs(ns.OPTIONS_REGISTRY) do
		registry:NotifyChange(name)
	end
end

function ns.OptionsFeatureToggle(feature, order, width)
	return {
		type = "toggle",
		name = L[feature.name],
		desc = L[feature.desc],
		width = width or "full",
		order = order,
		get = function()
			return ns.db.profile[feature.key][feature.setting]
		end,
		set = function(_, value)
			ns.SetFeatureSwitch(feature.key, value)
		end,
	}
end

function ns.GetFeatureSwitch(key)
	for _, feature in ipairs(ns.FEATURE_SWITCHES) do
		if feature.key == key then
			return feature
		end
	end
	return nil
end

--[[
    Flips a feature from either copy of its toggle, so each one reacts and
    every open panel repaints the same way.
]]
function ns.SetFeatureSwitch(key, value)
	local feature = ns.GetFeatureSwitch(key)
	ns.db.profile[key][feature.setting] = value
	if feature.onChange then
		feature.onChange()
	end
	NotifyAllPanels()
end

--[[
    Lays toggles out two to a line, each pair in its own unnamed inline group so
    every pair pins its own row. The widths leave slack under
    ns.OPTIONS_ROW_WIDTH: a row summing exactly to the pane sits on the wrap
    boundary and can drop its second toggle onto a line of its own.
]]
local TOGGLE_PAIR_WIDTH = (ns.OPTIONS_ROW_WIDTH - 0.2) / 2

function ns.OptionsTogglePairs(args, keyPrefix, startOrder, toggles)
	for index = 1, #toggles, 2 do
		local pair = {}
		for offset = 0, 1 do
			local toggle = toggles[index + offset]
			if toggle then
				toggle.width = TOGGLE_PAIR_WIDTH
				toggle.order = offset + 1
				pair["toggle" .. (offset + 1)] = toggle
			end
		end
		args[keyPrefix .. index] = {
			type = "group",
			name = "",
			inline = true,
			order = startOrder + index,
			args = pair,
		}
	end
end

--------------------------------------------------------------------------------
-- Master Switch
--------------------------------------------------------------------------------

--[[
    Hides every arg not named in `keep` while isHidden() is true.

    Applied to the finished args table rather than threaded through every
    Define* builder, so a control added later is covered automatically.

    An arg's own `hidden` is COMPOSED, not replaced, so a control that hides for
    its own reason (the whisper Example follows its toggle) still does while
    the switch is on.
]]
function ns.HideAllExcept(args, isHidden, keep)
	for key, option in pairs(args) do
		if not keep[key] then
			local own = option.hidden
			if own == nil then
				option.hidden = isHidden
			else
				option.hidden = function(info)
					if isHidden(info) then
						return true
					end
					if type(own) == "function" then
						return own(info)
					end
					return own
				end
			end
		end
	end
end

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
