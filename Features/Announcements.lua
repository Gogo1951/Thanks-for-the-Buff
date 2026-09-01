local _, ns = ...
local L = ns.L
local Data = ns.Data

local GetColor = ns.GetColor

--------------------------------------------------------------------------------
-- Print Outs (Player Only)
--------------------------------------------------------------------------------

-- The "TFTB // " brand that opens every print. Exposed so options panels can
-- render pipeline-true sample messages that always match the real thing.
function ns.GetPrintPrefix()
	return GetColor("INFO") .. L["ADDON_SHORT"] .. "|r " .. GetColor("SEPARATOR") .. "//" .. "|r "
end

-- Format: |cff[INFO]TFTB|r |cff[SEPARATOR]//|r |cff[TEXT]Message|r
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
    Branded sent messages for the automated buff/service thank-yous:
    {rt1} TFTB // Message. BuildAnnounceMessage assembles the decorated string and
    Announce sends it. The body carries a spell/item link and the leading raid-
    target marker; the chat system renders both on send (the marker becomes the
    Star icon), so the pipes and braces pass through unchanged.
]]
function ns:BuildAnnounceMessage(formatKey, ...)
	local template = L[formatKey]
	if not template then
		return nil
	end
	local body = string.format(template, ...)
	return ns.TARGET_MARKER .. " " .. L["ADDON_SHORT"] .. " // " .. body
end

function ns:Announce(channel, target, formatKey, ...)
	if not channel then
		return
	end
	local message = ns:BuildAnnounceMessage(formatKey, ...)
	if not message then
		return
	end
	SendChatMessage(message, channel, nil, target)
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
	SendChatMessage(message, "WHISPER", nil, target)
end

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

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
    place: this addon does not emote into the void.

    Trap for anyone tempted to pass a target straight through: DoEmote(cmd, nil)
    is NOT undirected -- it falls back to your CURRENT TARGET, thanking whatever
    bystander you happen to be pointing at. "none" is what actually forces the
    undirected flavor, and an unresolvable name degrades to it the same way,
    which is why neither is reachable from here any more.
]]
function ns:DoRandomEmote(emotes, target)
	if not emotes or not target then
		return
	end
	--[[
        Driven by Data.EMOTES rather than by the saved table's own keys, so a key
        that is no longer a real emote can never be picked. Saved settings outlive
        the list: renaming the /yes toggle from the bogus "YES" to its true NOD
        token leaves "YES" sitting in every existing profile, and iterating the
        saved table would keep offering it -- a silent no-op every time the random
        pick landed on it.
    ]]
	local available = {}
	for _, data in ipairs(Data.EMOTES) do
		if emotes[data.cmd] then
			available[#available + 1] = data.cmd
		end
	end
	if #available > 0 then
		DoEmote(available[math.random(#available)], target)
	end
end

--[[
    Perform ONE specific emote, for the buttons that choose from a dropdown
    instead of randomising over a checklist.

    Validated against the CLIENT catalog rather than Data.EMOTES: that dropdown
    offers every emote this build has, which is far more than the twelve the
    praise panels curate. An unknown token is dropped rather than handed on,
    because DoEmote given a bad token is a silent no-op -- indistinguishable, to
    whoever pressed the button, from the button being broken.
]]
function ns:DoEmoteToken(token, target)
	if not token or token == "" or not target then
		return
	end
	if not ns.IsClientEmote(token) then
		return
	end
	DoEmote(token, target)
end

--------------------------------------------------------------------------------
-- Buff Announcements
--------------------------------------------------------------------------------

-- Tint a player's name with their class color.
local function ColorName(guid, name)
	if guid then
		local _, class = GetPlayerInfoByGUID(guid)
		if class and Data.CLASS_COLORS[class] then
			return "|cff" .. Data.CLASS_COLORS[class] .. name .. "|r"
		end
	end
	return name
end

--[[
    Item-driven buffs link the source item; everything else links the spell. A
    stranger buff carries no tracked entry, so a nil entry is simply the spell
    case. Resolved once by the caller and passed to whichever of the print and
    the whisper actually fire, since the two no longer go out together (see
    ns:WhisperThanks).
]]
function ns.GetBuffLink(entry, spellID)
	if entry and entry.itemId then
		local link = select(2, ns.GetItemInfo(entry.itemId))
		if link then
			return link
		end
	end
	return ns.GetSpellLink(spellID) or L["UNKNOWN_SPELL"]
end

--[[
    The chat line for a tracked teammate buff or group service. The verb comes
    from the entry's type/detect: a solo buff "gave you", a group buff "gave your
    group", a service "set out", an item used on you "used X on you", a cast
    "used X on you".
]]
function ns:AnnounceTracked(entry, creditGUID, creditName, link)
	local name = ColorName(creditGUID, creditName)
	local message
	if entry.type == Data.BUFF.SERVICE then
		message = (entry.opened and L["MESSAGE_OPENED"] or L["MESSAGE_SET_OUT"]):format(name, link)
	elseif entry.type == Data.BUFF.GROUP then
		message = L["MESSAGE_GAVE_GROUP"]:format(name, link)
	elseif entry.itemId then
		message = L["MESSAGE_USED_ITEM"]:format(name, link)
	elseif entry.detect == Data.DETECT.CAST then
		message = L["MESSAGE_USED_SPELL"]:format(name, link)
	else
		message = L["MESSAGE_GAVE_YOU"]:format(name, link)
	end
	ns:PrintMessage(message)
end

--[[
    The thank-you whisper behind both the Strangers and the Teammates reactions.
    Split out from the prints above because the two are no longer sent together:
    the whisper is praise the other player sees and can be held back by the Praise
    Delay, while the print is your own heads-up and always fires immediately.
]]
function ns:WhisperThanks(target, link)
	ns:Announce("WHISPER", target, "MESSAGE_WHISPER_THANKS", link)
end

--[[
    Peer Pressure: a same-class player popped a tracked cooldown. The body renders
    in the caster's class color (always your own class), the spell link keeps
    the standard link blue, and the target's name wears the TARGET's class color
    (falling back to the body color when their class isn't known) -- only the
    "TFTB //" brand keeps the house colors. Trap: a closing |r resets the
    fontstring to white, so the body color is re-opened right after the link and
    after the target's name or the rest of the sentence loses it. Split
    builder/announcer so the options panel can show a pipeline-true sample.
]]
function ns:BuildPeerPressureMessage(class, sourceName, spellID, targetName, targetClass)
	local color = "|cff" .. (Data.CLASS_COLORS[class] or ns.PALETTE.TEXT)
	local link = (ns.GetSpellLink(spellID) or L["UNKNOWN_SPELL"]) .. color
	local body
	if targetName then
		local targetColor = targetClass and Data.CLASS_COLORS[targetClass]
		if targetColor then
			targetName = "|cff" .. targetColor .. targetName .. "|r" .. color
		end
		body = L["MESSAGE_PEER_PRESSURE_TARGET"]:format(sourceName, link, targetName)
	else
		body = L["MESSAGE_PEER_PRESSURE"]:format(sourceName, link)
	end
	return color .. body .. "|r"
end

function ns:AnnouncePeerPressure(class, sourceName, spellID, targetName, targetClass)
	ns:PrintMessage(ns:BuildPeerPressureMessage(class, sourceName, spellID, targetName, targetClass))
end

-- The chat line for any helpful buff from a non-grouped friendly player. Its
-- thank-you whisper goes out through ns:WhisperThanks.
function ns:AnnounceStranger(sourceGUID, sourceName, link)
	ns:PrintMessage(L["MESSAGE_BUFFED"]:format(ColorName(sourceGUID, sourceName), link))
end

--------------------------------------------------------------------------------
-- Good News
--------------------------------------------------------------------------------

--[[
    Good News whispers are queued with a small gap instead of sent inline: a
    raid-wide buff (Prayer of Fortitude) lands on every recipient in the same
    instant, and a burst of same-frame whispers risks the server-side chat
    squelch. An empty queue still sends immediately, so the common
    one-recipient case feels instant.
]]
local WHISPER_GAP = 0.35
local nextWhisperAt = 0
local function QueueWhisper(target, message)
	local now = GetTime()
	local delay = nextWhisperAt - now
	if delay < 0 then
		delay = 0
	end
	nextWhisperAt = now + delay + WHISPER_GAP
	if delay == 0 then
		SendChatMessage(message, "WHISPER", nil, target)
	else
		C_Timer.After(delay, function()
			SendChatMessage(message, "WHISPER", nil, target)
		end)
	end
end

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

			local n = tonumber(count) or 0
			local pick
			if #forms >= 3 then
				local mod10, mod100 = n % 10, n % 100
				if mod10 == 1 and mod100 ~= 11 then
					pick = forms[1] -- 1, 21, 31...
				elseif mod10 >= 2 and mod10 <= 4 and (mod100 < 12 or mod100 > 14) then
					pick = forms[2] -- 2-4, 22-24...
				else
					pick = forms[3]
				end
			else
				pick = (n == 1) and forms[1] or (forms[2] or forms[1])
			end
			return count .. gap .. pick
		end)
	)
end

--[[
    Durations run to round numbers, so the largest whole unit states one exactly.
    Exposed on ns so the Good News options panel can render its sample message
    through the real pipeline. `forceSeconds` keeps the seconds wording whatever
    the size: the rounding is right for a duration read as a length ("1 Minute"
    for 89s) but wrong for a fixed menu choice, where 89 would print as "1
    Minute" directly beneath "55 Seconds".

    No caller reaches the minute or hour rung today -- Good News caps its clause
    below a minute (GOOD_NEWS_MAX_SECONDS) and both dropdowns list seconds. They
    stay because this formats whatever duration it is handed, and a later caller
    re-deriving the ladder would walk back into the plural-escape trap that
    ResolvePlurals exists to solve.
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

--[[
    Only a SHORT duration is worth stating. "for 15 Seconds" tells the recipient
    to spend it now; "for 10 Minutes" is a number nobody acts on, and it pushes
    the ability name further from the front of a whisper that has one job. So the
    clause is capped: under a minute it prints, a minute or longer it is dropped
    and the whisper is just the ability.

    This cap is the LAST of the three ways a message ends up clause-less, and the
    only one that a real ticking timer can fail. The other two are settled before
    the duration ever reaches here, in Buff-Tracking's givenLookup: a cast that
    leaves no aura (Rebirth, Lay on Hands, jumper cables) and a `noDuration`
    entry spent by an event rather than by time (Fear Ward, Misdirection) both
    carry no auraId at all, so nothing is ever read for them.
]]
local GOOD_NEWS_MAX_SECONDS = 60

--[[
    Build the Good News whisper from the player's own template.

    ONE token, %a, carrying the whole ability phrase: "[Power Infusion] for 15
    Seconds" when the buff has a short readable timer, plain "[Rebirth]" when it
    does not. Folding the duration in rather than exposing it as a second token
    is what lets a single template cover both cases -- there is no clause left
    dangling when a one-shot cast has no duration to report, so the template
    needs no conditional and the player needs no second variable.

    Substitution is gsub with a replacement FUNCTION, never string.format. The
    template is user-editable, so a stray % in it would make format raise an
    error mid-whisper; a replacement function also stops a % inside a spell link
    from being read back as a capture reference.
]]
function ns:BuildGoodNewsMessage(link, duration)
	local db = ns.db and ns.db.profile.goodNews
	local template = db and db.message
	if type(template) ~= "string" or template:match("^%s*$") then
		template = L["DEFAULT_GOOD_NEWS"]
	end

	local ability = link or ""
	if duration and duration > 0 then
		-- Rounded up front, the same way FormatDuration would round it, so a 59.7s
		-- aura is tested as the "60 Seconds" it would print as instead of slipping
		-- under the cap and printing a full minute in seconds.
		local whole = math.floor(duration + 0.5)
		if whole < GOOD_NEWS_MAX_SECONDS then
			ability = ability .. " " .. string.format(L["GOOD_NEWS_DURATION_CLAUSE"], FormatDuration(whole))
		end
	end

	local body = template:gsub("%%a", function()
		return ability
	end)

	return ns.TARGET_MARKER .. " " .. L["ADDON_SHORT"] .. " // " .. body
end

function ns:AnnounceGoodNews(entry, destName, spellID, duration)
	local link = ns.GetBuffLink(entry, spellID)
	local message = ns:BuildGoodNewsMessage(link, duration)
	if message then
		QueueWhisper(destName, message)
	end
end
