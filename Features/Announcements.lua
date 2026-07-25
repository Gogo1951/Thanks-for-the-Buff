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
    player (never the combat log's "Name-Realm" form -- callers strip the realm),
    else nil to emote undirected. Trap: DoEmote(cmd, nil) is NOT undirected -- it
    falls back to your CURRENT TARGET, thanking a bystander when the buffer
    couldn't be resolved. "none" matches no unit, which is what actually forces
    the undirected flavor; an unresolvable name degrades the same way.
]]
function ns:DoRandomEmote(emotes, target)
	if not emotes then
		return
	end
	local available = {}
	for cmd, enabled in pairs(emotes) do
		if enabled then
			available[#available + 1] = cmd
		end
	end
	if #available > 0 then
		DoEmote(available[math.random(#available)], target or "none")
	end
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

local function Possessive(guid)
	local sex = guid and select(5, GetPlayerInfoByGUID(guid))
	if sex == 2 then
		return L["PRONOUN_HIS"]
	elseif sex == 3 then
		return L["PRONOUN_HER"]
	end
	return L["PRONOUN_THEIR"]
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
    group", a service "set out", an item used on you "used [their] X on you", a
    cast "used X on you".
]]
function ns:AnnounceTracked(entry, creditGUID, creditName, link)
	local name = ColorName(creditGUID, creditName)
	local message
	if entry.type == Data.BUFF.SERVICE then
		message = (entry.opened and L["MESSAGE_OPENED"] or L["MESSAGE_SET_OUT"]):format(name, link)
	elseif entry.type == Data.BUFF.GROUP then
		message = L["MESSAGE_GAVE_GROUP"]:format(name, link)
	elseif entry.itemId then
		message = L["MESSAGE_USED_ITEM"]:format(name, Possessive(creditGUID), link)
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
    the standard link blue -- same look as every other message -- and only the
    "TFTB //" brand keeps the house colors. Trap: the link's own closing |r
    resets the fontstring to white, so the class color is re-opened right after
    the link or the rest of the sentence loses it. Split builder/announcer so
    the options panel can show a pipeline-true sample.
]]
function ns:BuildPeerPressureMessage(class, sourceName, spellID, targetName)
	local color = "|cff" .. (Data.CLASS_COLORS[class] or "FFFFFF")
	local link = (ns.GetSpellLink(spellID) or L["UNKNOWN_SPELL"]) .. color
	local body
	if targetName then
		body = L["MESSAGE_PEER_PRESSURE_TARGET"]:format(sourceName, link, targetName)
	else
		body = L["MESSAGE_PEER_PRESSURE"]:format(sourceName, link)
	end
	return color .. body .. "|r"
end

function ns:AnnouncePeerPressure(class, sourceName, spellID, targetName)
	ns:PrintMessage(ns:BuildPeerPressureMessage(class, sourceName, spellID, targetName))
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

-- Tracked buffs run to round durations (15 seconds, 10 minutes, 30 minutes), so
-- the largest whole unit states one exactly. Exposed on ns so the Good News
-- options panel can render its sample message through the real pipeline.
local function FormatDuration(seconds)
	seconds = math.floor((seconds or 0) + 0.5)
	local template, count
	if seconds >= 3600 then
		template, count = D_HOURS, math.floor(seconds / 3600 + 0.5)
	elseif seconds >= 60 then
		template, count = D_MINUTES, math.floor(seconds / 60 + 0.5)
	else
		template, count = D_SECONDS, seconds
	end
	return ResolvePlurals(template:format(count))
end
ns.FormatDuration = FormatDuration

--[[
    Tell the player YOU just buffed what they got: with a readable duration,
    "Good News! You have X for 30 min!"; without one (no-aura casts like
    Rebirth, or a recipient we hold no unit for), just "Good News! You have
    X!".
]]
function ns:AnnounceGoodNews(entry, destName, spellID, duration)
	local link = ns.GetBuffLink(entry, spellID)
	local message
	if duration and duration > 0 then
		message = ns:BuildAnnounceMessage("MESSAGE_GOOD_NEWS_DURATION", link, FormatDuration(duration))
	else
		message = ns:BuildAnnounceMessage("MESSAGE_GOOD_NEWS", link)
	end
	if message then
		QueueWhisper(destName, message)
	end
end
