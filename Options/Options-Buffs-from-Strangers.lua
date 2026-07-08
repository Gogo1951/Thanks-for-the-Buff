local _, ns = ...
local Data = ns.Data
local L = ns.L

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.GetStrangersOptions()
    local function EmotesHidden()
        return not ns.db.profile.strangers.emotesEnabled
    end

    local options = {
        name = L["STRANGERS_TITLE"],
        type = "group",
        args = {
            descIntro = ns.OptionsDesc(L["STRANGERS_DESC"], 1),
            space0 = ns.OptionsSpacer(2),
            headerMessaging = ns.OptionsSubHeader(L["STRANGERS_MESSAGING"], 5),
            printStrangers = {
                type = "toggle",
                name = L["MESSAGING_PRINT_ENABLE"],
                desc = L["MESSAGING_PRINT_DESC"],
                width = "full",
                order = 6,
                get = function()
                    return ns.db.profile.strangers.printEnabled
                end,
                set = function(_, val)
                    ns.db.profile.strangers.printEnabled = val
                end
            },
            whisperStrangers = {
                type = "toggle",
                name = L["MESSAGING_WHISPER_ENABLE"],
                desc = L["MESSAGING_WHISPER_DESC"],
                width = "full",
                order = 7,
                get = function()
                    return ns.db.profile.strangers.whisperEnabled
                end,
                set = function(_, val)
                    ns.db.profile.strangers.whisperEnabled = val
                end
            },
            enableEmotesStrangers = {
                type = "toggle",
                name = L["MESSAGING_EMOTES_ENABLE"],
                desc = L["MESSAGING_EMOTES_DESC"],
                width = "full",
                order = 8,
                get = function()
                    return ns.db.profile.strangers.emotesEnabled
                end,
                set = function(_, val)
                    ns.db.profile.strangers.emotesEnabled = val
                end
            },
            emoteSpacer = {type = "description", name = " ", order = 9, hidden = EmotesHidden},
            strangersEmoteGroup = {
                type = "group",
                name = L["STRANGERS_EMOTES_SELECT"],
                order = 10,
                inline = true,
                hidden = EmotesHidden,
                args = {}
            },
            space1 = ns.OptionsSpacer(11),
            cooldownStrangers = {
                type = "range",
                name = L["STRANGERS_COOLDOWN"],
                desc = L["STRANGERS_COOLDOWN_DESC"],
                order = 20,
                width = "double",
                min = 1,
                max = 60,
                step = 1,
                get = function()
                    return ns.db.profile.strangers.cooldown
                end,
                set = function(_, val)
                    ns.db.profile.strangers.cooldown = val
                end
            },
            space3 = ns.OptionsSpacer(21),
            minDurationStrangers = {
                type = "range",
                name = L["STRANGERS_MIN_DURATION"],
                desc = L["STRANGERS_MIN_DURATION_DESC"],
                order = 22,
                width = "double",
                min = 0,
                max = 120,
                step = 1,
                get = function()
                    return ns.db.profile.strangers.minBuffDuration
                end,
                set = function(_, val)
                    ns.db.profile.strangers.minBuffDuration = val
                end
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
                return ns.db.profile.strangers.emotes[emote]
            end,
            set = function(_, val)
                ns.db.profile.strangers.emotes[emote] = val
            end
        }
    end

    return options
end