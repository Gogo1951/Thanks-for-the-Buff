local _, ns = ...
local L = ns.L
local Data = ns.Data

local GetColor = ns.GetColor

--------------------------------------------------------------------------------
-- Print Outs (Player Only)
--------------------------------------------------------------------------------

-- Format: |cff[INFO]Add-on Name|r |cff[SEPARATOR]//|r |cff[TEXT]Message|r
function ns:PrintMessage(message)
    local prefix = GetColor("INFO") .. L["ADDON_TITLE"] .. "|r " .. GetColor("SEPARATOR") .. "//" .. "|r "
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
    {marker} Add-on Name // Message. BuildAnnounceMessage assembles the decorated
    string and Announce sends it. The body carries a spell/item link, which is
    legal in chat and passes through unchanged, so pipes are not stripped.
]]
function ns:BuildAnnounceMessage(formatKey, ...)
    local template = L[formatKey]
    if not template then
        return nil
    end
    local body = string.format(template, ...)
    return ns.TARGET_MARKER .. " " .. L["ADDON_TITLE"] .. " // " .. body
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

-- Perform a random enabled emote from the given selection, directed at target.
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
        DoEmote(available[math.random(#available)], target)
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

-- Item-driven buffs link the source item; everything else links the spell.
local function GetLink(entry, spellID)
    if entry.itemId then
        local link = select(2, GetItemInfo(entry.itemId))
        if link then
            return link
        end
    end
    return GetSpellLink(spellID) or L["UNKNOWN_SPELL"]
end

--[[
    Tracked teammate buffs and group services. The verb comes from the entry's
    type/detect: a solo buff "gave you", a group buff "gave your group", a service
    "set out", an item used on you "used [their] X on you", a cast "used X on you".
]]
function ns:AnnounceTracked(entry, creditGUID, creditName, spellID, printEnabled, whisperEnabled)
    if not printEnabled and not whisperEnabled then
        return
    end

    local link = GetLink(entry, spellID)

    if printEnabled then
        local name = ColorName(creditGUID, creditName)
        local message
        if entry.type == Data.BUFF.SERVICE then
            message = L["MSG_SET_OUT"]:format(name, link)
        elseif entry.type == Data.BUFF.GROUP then
            message = L["MSG_GAVE_GROUP"]:format(name, link)
        elseif entry.itemId then
            message = L["MSG_USED_ITEM"]:format(name, Possessive(creditGUID), link)
        elseif entry.detect == Data.DETECT.CAST then
            message = L["MSG_USED_SPELL"]:format(name, link)
        else
            message = L["MSG_GAVE_YOU"]:format(name, link)
        end
        ns:PrintMessage(message)
    end

    if whisperEnabled then
        ns:Announce("WHISPER", creditName, "MSG_WHISPER_THANKS", link)
    end
end

-- Any helpful buff from a non-grouped friendly player.
function ns:AnnounceStranger(sourceGUID, sourceName, link, printEnabled, whisperEnabled)
    if printEnabled then
        ns:PrintMessage(L["MSG_BUFFED"]:format(ColorName(sourceGUID, sourceName), link))
    end
    if whisperEnabled then
        ns:Announce("WHISPER", sourceName, "MSG_WHISPER_THANKS", link)
    end
end
