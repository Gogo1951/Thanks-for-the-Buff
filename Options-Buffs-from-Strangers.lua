local addonName, ns = ...
local Data = ns.Data
local L = ns.L

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

local function Spacer(order)
    return {type = "description", name = " ", order = order}
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.GetStrangersOptions()
    local TFTB = ns.TFTB

    local function IsDisabled()
        return not TFTB.db.profile.strangers.enabled
    end

    local function EmotesHidden()
        return IsDisabled() or not TFTB.db.profile.strangers.emotesEnabled
    end

    local options = {
        name = L["STRANGERS_TITLE"],
        type = "group",
        args = {
            enableStrangers = {
                type = "toggle",
                name = L["STRANGERS_ENABLE"],
                width = "full",
                order = 10,
                get = function()
                    return TFTB.db.profile.strangers.enabled
                end,
                set = function(_, val)
                    TFTB.db.profile.strangers.enabled = val
                end
            },
            space1 = Spacer(11),
            cooldownStrangers = {
                type = "range",
                name = L["STRANGERS_COOLDOWN"],
                desc = L["STRANGERS_COOLDOWN_DESC"],
                order = 20,
                width = "double",
                min = 1,
                max = 60,
                step = 1,
                hidden = IsDisabled,
                get = function()
                    return TFTB.db.profile.strangers.cooldown
                end,
                set = function(_, val)
                    TFTB.db.profile.strangers.cooldown = val
                end
            },
            space2 = {type = "description", name = " ", order = 21, hidden = IsDisabled},
            minDurationStrangers = {
                type = "range",
                name = L["STRANGERS_MIN_DURATION"],
                desc = L["STRANGERS_MIN_DURATION_DESC"],
                order = 22,
                width = "double",
                min = 0,
                max = 120,
                step = 1,
                hidden = IsDisabled,
                get = function()
                    return TFTB.db.profile.strangers.minBuffDuration
                end,
                set = function(_, val)
                    TFTB.db.profile.strangers.minBuffDuration = val
                end
            },
            space3 = {type = "description", name = " ", order = 23, hidden = IsDisabled},
            messagingStrangers = {
                type = "select",
                name = L["STRANGERS_MESSAGING"],
                style = "dropdown",
                width = "double",
                order = 30,
                hidden = IsDisabled,
                values = {
                    ["NONE"] = L["MESSAGING_NONE_DEFAULT"],
                    ["PRINT"] = L["MESSAGING_PRINT"],
                    ["WHISPER"] = L["MESSAGING_WHISPER"]
                },
                get = function()
                    return TFTB.db.profile.strangers.messaging
                end,
                set = function(_, val)
                    TFTB.db.profile.strangers.messaging = val
                end
            },
            space4 = {type = "description", name = " ", order = 31, hidden = IsDisabled},
            enableEmotesStrangers = {
                type = "toggle",
                name = L["STRANGERS_EMOTES_ENABLE"],
                desc = L["STRANGERS_EMOTES_DESC"],
                width = "full",
                order = 40,
                hidden = IsDisabled,
                get = function()
                    return TFTB.db.profile.strangers.emotesEnabled
                end,
                set = function(_, val)
                    TFTB.db.profile.strangers.emotesEnabled = val
                end
            },
            space5 = {type = "description", name = " ", order = 41, hidden = EmotesHidden},
            strangersEmoteGroup = {
                type = "group",
                name = L["STRANGERS_EMOTES_SELECT"],
                order = 50,
                inline = true,
                hidden = EmotesHidden,
                args = {}
            }
        }
    }

    for i, emoteData in ipairs(Data.EMOTES) do
        local emote = emoteData.cmd
        options.args.strangersEmoteGroup.args[emote] = {
            type = "toggle",
            name = emoteData.displayName,
            desc = emoteData.desc,
            order = i,
            width = "half",
            get = function()
                return TFTB.db.profile.strangers.emotes[emote]
            end,
            set = function(_, val)
                TFTB.db.profile.strangers.emotes[emote] = val
            end
        }
    end

    return options
end