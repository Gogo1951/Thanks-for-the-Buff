local addonName, ns = ...
local Data = ns.Data
local L = ns.L

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

local function Desc(text, order)
    return {type = "description", name = text, fontSize = "medium", order = order}
end

local function Spacer(order)
    return {type = "description", name = " ", order = order}
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.GetThankYouButtonOptions()
    local TFTB = ns.TFTB

    local options = {
        name = L["BUTTON_TITLE"],
        type = "group",
        args = {
            createMacro = {
                type  = "toggle",
                name  = L["BUTTON_CREATE_MACRO"],
                desc  = string.format(L["BUTTON_CREATE_MACRO_DESC"],
                    ns.GetColor("TITLE") .. Data.MACRO_NAME .. "|r"),
                width = "full",
                order = 10,
                get   = function() return TFTB.db.profile.slash.createMacro end,
                set   = function(_, val) TFTB.db.profile.slash.createMacro = val end
            },
            space1 = Spacer(11),

            whisperMsg = {
                type  = "input",
                name  = L["BUTTON_WHISPER"],
                width = "full",
                order = 20,
                get   = function() return TFTB.db.profile.slash.message end,
                set   = function(_, val) TFTB.db.profile.slash.message = val end
            },
            resetMsg = {
                type  = "execute",
                name  = L["BUTTON_RESET"],
                desc  = L["BUTTON_RESET_DESC"],
                width = "half",
                order = 21,
                func  = function()
                    TFTB.db.profile.slash.message = L["DEFAULT_WHISPER"]
                end
            },
            space2 = Spacer(22),

            headerSlashEmotes = Desc(
                "\n" .. ns.GetColor("TEXT") .. L["BUTTON_EMOTES_HEADER"] .. "|r",
                30
            ),
            slashEmoteGroup = {
                type   = "group",
                name   = L["BUTTON_EMOTES_SELECT"],
                order  = 31,
                inline = true,
                args   = {}
            }
        }
    }

    for i, emoteData in ipairs(Data.EMOTES) do
        local emote = emoteData.cmd
        options.args.slashEmoteGroup.args[emote] = {
            type  = "toggle",
            name  = emoteData.displayName,
            desc  = emoteData.desc,
            order = i,
            width = "half",
            get   = function() return TFTB.db.profile.slash.emotes[emote] end,
            set   = function(_, val) TFTB.db.profile.slash.emotes[emote] = val end
        }
    end

    return options
end
