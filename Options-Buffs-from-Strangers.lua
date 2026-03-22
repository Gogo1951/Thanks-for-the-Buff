local addonName, ns = ...
local Data = ns.Data

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local function Spacer(order)
    return {
        type  = "description",
        name  = " ",
        order = order
    }
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------
function ns.GetStrangersOptions()
    local TFTB = ns.TFTB

    local options = {
        name = "Buffs from Strangers",
        type = "group",
        args = {
            enableStrangers = {
                type  = "toggle",
                name  = "React to Buffs from Strangers",
                width = "full",
                order = 10,
                get   = function() return TFTB.db.profile.strangers.enabled end,
                set   = function(_, val) TFTB.db.profile.strangers.enabled = val end
            },
            space1 = Spacer(11),

            cooldownStrangers = {
                type  = "range",
                name  = "Cooldown (Seconds)",
                desc  = "At most, how often to thank the same player.",
                order = 20,
                min   = 1,
                max   = 60,
                step  = 1,
                get   = function() return TFTB.db.profile.strangers.cooldown end,
                set   = function(_, val) TFTB.db.profile.strangers.cooldown = val end
            },

            minDurationStrangers = {
                type  = "range",
                name  = "Minimum Buff Duration (Seconds)",
                desc  = "Minimum duration the buff must last to trigger a thank you."
                     .. "\n\nFilters out short heals over time like Renew or Rejuvenation.",
                order = 21,
                min   = 0,
                max   = 120,
                step  = 1,
                get   = function() return TFTB.db.profile.strangers.minBuffDuration end,
                set   = function(_, val) TFTB.db.profile.strangers.minBuffDuration = val end
            },
            space2 = Spacer(22),

            messagingStrangers = {
                type   = "select",
                name   = "Messaging",
                style  = "dropdown",
                width  = "double",
                order  = 30,
                values = {
                    ["NONE"]    = "No Message (Default)",
                    ["PRINT"]   = "Print-out Message (Self Only)",
                    ["WHISPER"] = "Whisper Message"
                },
                get = function() return TFTB.db.profile.strangers.messaging end,
                set = function(_, val) TFTB.db.profile.strangers.messaging = val end
            },
            space3 = Spacer(31),

            enableEmotesStrangers = {
                type  = "toggle",
                name  = "Enable Emotes",
                desc  = "Emote your appreciation for buffs from strangers.",
                width = "full",
                order = 40,
                get   = function() return TFTB.db.profile.strangers.emotesEnabled end,
                set   = function(_, val) TFTB.db.profile.strangers.emotesEnabled = val end
            },
            space4 = Spacer(41),

            strangersEmoteGroup = {
                type   = "group",
                name   = "Select Emotes",
                order  = 50,
                inline = true,
                args   = {}
            }
        }
    }

    -- Populate emote toggles
    for i, emoteData in ipairs(Data.EMOTES) do
        local emote = emoteData.cmd
        options.args.strangersEmoteGroup.args[emote] = {
            type  = "toggle",
            name  = emoteData.displayName,
            desc  = emoteData.desc,
            order = i,
            width = "half",
            get   = function() return TFTB.db.profile.strangers.emotes[emote] end,
            set   = function(_, val) TFTB.db.profile.strangers.emotes[emote] = val end
        }
    end

    return options
end