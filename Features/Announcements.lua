local _, ns = ...
local L = ns.L
local Data = ns.Data

local GetColor = ns.GetColor

--------------------------------------------------------------------------------
-- Print Outs (Player Only)
--------------------------------------------------------------------------------

--[[
    The "TFTB // " brand that opens every print. Exposed so options panels can
    render pipeline-true sample messages that always match the real thing.
    Prints and sent messages brand with the short name, L["ADDON_SHORT_NAME"],
    never the full title.
]]
function ns.GetPrintPrefix()
	return GetColor("INFO") .. L["ADDON_SHORT_NAME"] .. "|r " .. GetColor("SEPARATOR") .. "//" .. "|r "
end

function ns:PrintMessage(message)
	local prefix = ns.GetPrintPrefix()
	--[[
        Plain messages get the standard white body. Messages that embed their own
        colors (spell links, class-colored names) are left untouched so an outer
        |r doesn't terminate the embedded coloring early.
    ]]
	if not message:find("|c", 1, true) then
		message = GetColor("TEXT") .. message .. "|r"
	end
	print(prefix .. message)
end

--------------------------------------------------------------------------------
-- Sent Messages (Other Players)
--------------------------------------------------------------------------------

--[[
    SignOff gives every branded sent message its "{rt1} Message // TFTB" shape:
    the Give Thanks whisper through ns:BuildThanksWhisper, and any locale-key
    message through BuildAnnounceMessage / Announce. The body can carry a spell
    link beside the leading raid-target marker; the chat system renders both on
    send (the marker becomes the Star icon), so the pipes and braces pass
    through unchanged. Every flavor carries the marker, WoW Forever included.
]]
local function MarkerPrefix()
	return ns.TARGET_MARKER .. " "
end

--[[
    The name signs off a sent message, so the body gives up its closing
    punctuation: "Thanks for the [Arcane Intellect] // TFTB", never "...! //
    TFTB". Translations still carry their own (Spanish opens with an inverted
    mark, CJK closes with a full-width one), so the trim covers those too. Marks are matched as whole UTF-8 sequences,
    never as a byte class, so a multi-byte character is never cut in half.
]]
local CLOSING_MARKS = { "!", ".", "?", "\239\188\129", "\227\128\130", "\239\188\159" } -- ! . ? and full-width ！ 。 ？
local OPENING_MARKS = { "\194\161", "\194\191" } -- ¡ ¿

local function TrimSentBody(body)
	local trimmed = true
	while trimmed do
		trimmed = false
		body = body:gsub("%s+$", "")
		for _, mark in ipairs(CLOSING_MARKS) do
			if body:sub(-#mark) == mark then
				body = body:sub(1, -#mark - 1)
				trimmed = true
			end
		end
	end
	for _, mark in ipairs(OPENING_MARKS) do
		if body:sub(1, #mark) == mark then
			body = body:sub(#mark + 1)
		end
	end
	return body
end

local function SignOff(body)
	return MarkerPrefix() .. TrimSentBody(body) .. " // " .. L["ADDON_SHORT_NAME"]
end

function ns:BuildAnnounceMessage(formatKey, ...)
	local template = L[formatKey]
	if not template then
		return nil
	end
	return SignOff(string.format(template, ...))
end

function ns:Announce(channel, target, formatKey, ...)
	if not channel then
		return
	end
	local message = ns:BuildAnnounceMessage(formatKey, ...)
	if not message then
		return
	end
	C_ChatInfo.SendChatMessage(message, channel, nil, target)
end

--[[
    Unbranded, natural-language whisper for the manual Thank You Button only: a
    human-sounding message to your target, deliberately without the marker or
    add-on name. Links are legal in whispers, so pipes are not stripped.
]]
function ns:Whisper(target, message)
	if not target or not message or message == "" then
		return
	end
	C_ChatInfo.SendChatMessage(message, "WHISPER", nil, target)
end

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

--[[
    The one place an emote reaches the client, through the namespaced call every
    target client ships. Returns its success flag, or nil when that comes back secret.
]]
local function PerformEmote(token, target)
	local success = C_ChatInfo.PerformEmote(token, target)
	if ns.IsPlain(success) then
		return success
	end
end

--[[
    The picked emotes this client can actually perform, as a list. A saved
    profile can hold keys that are not emote tokens here (an old "YES" key, or
    an emote from another flavor), and picking one would be a silent no-op, so
    each key is checked against the client catalog.
]]
function ns.GetPickableEmotes(emotes)
	local available = {}
	if type(emotes) ~= "table" then
		return available
	end
	for token, picked in pairs(emotes) do
		if picked and ns.IsClientEmote(token) then
			available[#available + 1] = token
		end
	end
	return available
end

--[[
    Perform a random enabled emote from the given selection. `target` is what to
    direct the emote at: a live unit token ("target", "party3") when the caller
    holds one, else a bare character name the client may resolve to a visible
    player (never the combat log's "Name-Realm" form -- callers strip the realm).

    No target means NO emote. The undirected flavor ("You thank everyone around
    you.") is never what a caller wants here: it fires precisely when the buffer
    could not be resolved, and failing to resolve them is itself the evidence
    they are gone -- so it thanks an empty room and reads as a bug. Refusing it
    at the chokepoint instead of at each call site keeps the promise in one
    place: this add-on does not emote into the void.

    Trap for anyone tempted to pass a target straight through:
    C_ChatInfo.PerformEmote(token, nil) is NOT undirected -- it falls back to
    your CURRENT TARGET, thanking whatever bystander you happen to be pointing
    at. "none" is what actually forces the undirected flavor, and a name the
    client can't resolve degrades to it the same way; no API pre-tests a name,
    so that case still reaches here (see ResolveEmoteTarget in Praise.lua).
]]
function ns:DoRandomEmote(emotes, target)
	if not emotes or not target then
		return
	end
	local available = ns.GetPickableEmotes(emotes)
	if #available > 0 then
		PerformEmote(available[math.random(#available)], target)
	end
end

--[[
    Perform ONE specific emote, for the buttons that choose from a dropdown
    instead of randomizing over a checklist.

    Validated against the CLIENT catalog: that dropdown offers every emote this
    build has, and a profile can carry a token from another flavor. An unknown token is dropped rather than handed on,
    because C_ChatInfo.PerformEmote given a bad token is a silent no-op --
    indistinguishable, to whoever pressed the button, from the button being
    broken.
]]
function ns:DoEmoteToken(token, target)
	if not token or token == "" or not target then
		return
	end
	if not ns.IsClientEmote(token) then
		return
	end
	PerformEmote(token, target)
end

--------------------------------------------------------------------------------
-- Buff Announcements
--------------------------------------------------------------------------------

-- Tint a player's name with their class color; an unknown class leaves it plain.
local function ColorNameByClass(class, name)
	if class and Data.CLASS_COLORS[class] then
		return "|cff" .. Data.CLASS_COLORS[class] .. name .. "|r"
	end
	return name
end

local function ClassOf(guid)
	if guid then
		return (select(2, GetPlayerInfoByGUID(guid)))
	end
	return nil
end

--[[
    The buff's spell link. Resolved once by the caller and passed to whichever
    of the print and the whisper actually fire, since each has its own toggle
    and timing (see ns:WhisperThanks).
]]
function ns.GetBuffLink(spellID)
	return ns.GetSpellLink(spellID) or L["UNKNOWN_SPELL"]
end

--[[
    The Give Thanks whisper: the player's own message with "{spell}" swapped for
    the buff's link and "{name}" for the buffer's short name, signed off like
    every sent message. Unlike the print, the other player sees it, and the
    Praise Delay can hold it back.

    FillThanksWhisper builds it as typed, however long, so the options panel
    can tell when it runs past the chat ceiling. BuildThanksWhisper is what gets sent:
    nil for an empty message, which sends no whisper, and the default text of
    the language messages go out in (ns.GetDefaultThanksWhisper) when the
    player's own runs past the chat ceiling, rather than being rejected.
]]
local function ShortName(name)
	if not name or name == "" then
		return ""
	end
	return Ambiguate(name, "short")
end

function ns.FillThanksWhisper(template, link, name)
	local body = template:gsub("{spell}", function()
		return link or ""
	end)
	body = body:gsub("{name}", function()
		return ShortName(name)
	end)
	return SignOff(body)
end

function ns:BuildThanksWhisper(template, link, name)
	if not template or template == "" then
		return nil
	end
	local message = ns.FillThanksWhisper(template, link, name)
	if #message > ns.CHAT_MESSAGE_MAX_LENGTH then
		message = ns.FillThanksWhisper(ns.GetDefaultThanksWhisper(), link, name)
	end
	return message
end

function ns:WhisperThanks(target, link, template)
	local message = ns:BuildThanksWhisper(template, link, target)
	if message then
		C_ChatInfo.SendChatMessage(message, "WHISPER", nil, target)
	end
end

--[[
    The options panel's Send Test to Me: the whisper exactly as a buffer would
    get it, sent to the player's own character, so they see the marker and the
    link drawn by real chat rather than by the panel.
]]
function ns:WhisperThanksTest(template, link, name)
	local message = ns:BuildThanksWhisper(template, link, name)
	local me = GetUnitName("player", true)
	if message and me then
		C_ChatInfo.SendChatMessage(message, "WHISPER", nil, me)
	end
end

--[[
    The print out for any helpful buff from a non-grouped friendly player. Its
    thank-you whisper goes out through ns:WhisperThanks.
]]
function ns:BuildStrangerMessage(class, sourceName, link)
	return L["MESSAGE_BUFFED"]:format(ColorNameByClass(class, sourceName), link)
end

function ns:AnnounceStranger(sourceGUID, sourceName, link)
	ns:PrintMessage(ns:BuildStrangerMessage(ClassOf(sourceGUID), sourceName, link))
end

--------------------------------------------------------------------------------
-- Durations
--------------------------------------------------------------------------------

--[[
    Resolve the client's plural escape to plain text.

    Trap: WoW's own duration strings (D_MINUTES == "%d |4minute:minutes;") carry
    a |4 escape that the UI expands only at render time. It looks right in a
    print, but SendChatMessage rejects any message still holding one -- "Invalid
    escape code in chat message" -- and silently drops the whole line. Resolving
    it here is what lets the units come from the client's own localization in
    every language it ships, instead of TFTB carrying its own copies.

    Slavic locales list a third form (one/few/many) and get their rule; two-form
    languages take a simple count check; languages that don't inflect (zhCN,
    koKR) carry no escape at all, so the gsub finds nothing to do.
]]
local function ResolvePlurals(text)
	return (
		text:gsub("(%d+)(%s*)|4([^;]*);", function(count, gap, body)
			local forms = {}
			for form in body:gmatch("[^:]+") do
				forms[#forms + 1] = form
			end
			if #forms == 0 then
				return count .. gap
			end

			local number = tonumber(count) or 0
			local pick
			if #forms >= 3 then
				local mod10, mod100 = number % 10, number % 100
				if mod10 == 1 and mod100 ~= 11 then
					pick = forms[1] -- 1, 21, 31...
				elseif mod10 >= 2 and mod10 <= 4 and (mod100 < 12 or mod100 > 14) then
					pick = forms[2] -- 2-4, 22-24...
				else
					pick = forms[3]
				end
			else
				pick = (number == 1) and forms[1] or (forms[2] or forms[1])
			end
			return count .. gap .. pick
		end)
	)
end

--[[
    Durations run to round numbers, so the largest whole unit states one exactly.
    Exposed on ns for the options panels' duration dropdowns. `forceSeconds`
    keeps the seconds wording whatever the size: the rounding is right for a
    duration read as a length ("1 Minute" for 89s) but wrong for a fixed menu
    choice, where 89 would print as "1 Minute" directly beneath "55 Seconds".
    The minute and hour rungs word Wave to Friends' cooldown dropdown, which
    runs in minutes.
]]
local function FormatDuration(seconds, forceSeconds)
	seconds = math.floor((seconds or 0) + 0.5)
	local template, count
	if not forceSeconds and seconds >= 3600 then
		template, count = D_HOURS, math.floor(seconds / 3600 + 0.5)
	elseif not forceSeconds and seconds >= 60 then
		template, count = D_MINUTES, math.floor(seconds / 60 + 0.5)
	else
		template, count = D_SECONDS, seconds
	end
	return ResolvePlurals(template:format(count))
end
ns.FormatDuration = FormatDuration

--------------------------------------------------------------------------------
-- Good News
--------------------------------------------------------------------------------

--[[
    The Good News whisper: the player's own message with "{spell}" swapped for
    the ability and "{name}" for the recipient's short name, signed off like
    every sent message.

    {spell} carries the whole ability phrase: "[Power Infusion] for 15 Seconds"
    when the buff has a short, readable timer, plain "[Rebirth]" when it has
    none. Folding the duration in is what lets one message cover both, with no
    "for" left dangling after a one-shot cast. Only a short duration is worth
    saying: "for 15 Seconds" tells the recipient to spend it now, "for 30
    Minutes" is a number nobody acts on. The clause comes from the language
    messages go out in (ns.GetGoodNewsDurationClause), so it matches the rest
    of the whisper rather than the sender's client.

    FillGoodNewsWhisper builds it as typed, however long, so the options panel
    can measure it. BuildGoodNewsWhisper is what gets sent: nil for an empty
    message, and the default text of the language messages go out in when the
    player's own runs past the chat ceiling.
]]
local GOOD_NEWS_MAX_SECONDS = 60

local function GoodNewsAbility(link, seconds)
	local ability = link or ""
	if seconds then
		-- Rounded first, so 59.7 is tested as the 60 it would print as.
		local whole = math.floor(seconds + 0.5)
		if whole > 0 and whole < GOOD_NEWS_MAX_SECONDS then
			ability = ability .. " " .. ResolvePlurals(ns.GetGoodNewsDurationClause(whole))
		end
	end
	return ability
end

function ns.FillGoodNewsWhisper(template, link, name, seconds)
	local ability = GoodNewsAbility(link, seconds)
	local body = template:gsub("{spell}", function()
		return ability
	end)
	body = body:gsub("{name}", function()
		return ShortName(name)
	end)
	return SignOff(body)
end

function ns:BuildGoodNewsWhisper(template, link, name, seconds)
	if not template or template == "" then
		return nil
	end
	local message = ns.FillGoodNewsWhisper(template, link, name, seconds)
	if #message > ns.CHAT_MESSAGE_MAX_LENGTH then
		message = ns.FillGoodNewsWhisper(ns.GetDefaultGoodNewsWhisper(), link, name, seconds)
	end
	return message
end

--[[
    Good News whispers go out a little apart rather than all at once: casting
    on several players in a row (scrolls handed round a raid) would otherwise
    send a burst the server's chat squelch can catch. An empty queue sends at
    once, so the usual single whisper feels instant.

    C_ChatInfo.InChatMessagingLockdown, where a client has it, says the game is
    holding add-on chat back right now (a boss fight on newer clients). A
    whisper due then is dropped rather than sent into a block.
]]
local WHISPER_GAP = 0.35
local nextWhisperAt = 0

local function SendWhisper(target, message)
	local lockdown = C_ChatInfo.InChatMessagingLockdown
	if lockdown then
		local locked = lockdown()
		if not ns.IsPlain(locked) or locked then
			return
		end
	end
	C_ChatInfo.SendChatMessage(message, "WHISPER", nil, target)
end

local function QueueWhisper(target, message)
	local now = GetTime()
	local delay = math.max(nextWhisperAt - now, 0)
	nextWhisperAt = now + delay + WHISPER_GAP
	if delay == 0 then
		SendWhisper(target, message)
	else
		C_Timer.After(delay, function()
			SendWhisper(target, message)
		end)
	end
end

function ns:WhisperGoodNews(target, link, seconds)
	local message = ns:BuildGoodNewsWhisper(ns.db.profile.goodNews.whisperMessage, link, target, seconds)
	if message then
		QueueWhisper(target, message)
	end
end

-- The options panel's Send Test to Me, as ns:WhisperThanksTest is for Give Thanks.
function ns:WhisperGoodNewsTest(template, link, name, seconds)
	local message = ns:BuildGoodNewsWhisper(template, link, name, seconds)
	local me = GetUnitName("player", true)
	if message and me then
		C_ChatInfo.SendChatMessage(message, "WHISPER", nil, me)
	end
end
