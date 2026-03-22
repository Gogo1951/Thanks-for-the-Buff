local addonName, ns = ...
local Data = ns.Data

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local function Desc(text, order)
    return {
        type     = "description",
        name     = text,
        fontSize = "medium",
        order    = order
    }
end

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
function ns.GetThankYouButtonOptions()
    local TFTB = ns.TFTB

    local options = {
        name = "Thank You Button",
        type = "group",
        args = {
            createMacro = {
                type  = "toggle",
                name  = "Create Macro",
                desc  = "A macro named "
                     .. ns.GetColor("TITLE") .. Data.MACRO_NAME .. "|r"
                     .. " will be automatically created for you on sign-in.",
                width = "full",
                order = 10,
                get   = function() return TFTB.db.profile.slash.createMacro end,
                set   = function(_, val) TFTB.db.profile.slash.createMacro = val end
            },
            space1 = Spacer(11),

            whisperMsg = {
                type  = "input",
                name  = "Whisper Message",
                width = "full",
                order = 20,
                get   = function() return TFTB.db.profile.slash.message end,
                set   = function(_, val) TFTB.db.profile.slash.message = val end
            },
            resetMsg = {
                type  = "execute",
                name  = "Reset",
                desc  = "Reset the whisper message to the default text.",
                width = "half",
                order = 21,
                func  = function()
                    TFTB.db.profile.slash.message = "Thanks, you're the best! (="
                end
            },
            space2 = Spacer(22),

            headerSlashEmotes = Desc(
                "\n" .. ns.GetColor("TEXT") .. "Thank You Button Emotes:" .. "|r",
                30
            ),
            slashEmoteGroup = {
                type   = "group",
                name   = "Select Emotes",
                order  = 31,
                inline = true,
                args   = {}
            }
        }
    }

    -- Populate emote toggles
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