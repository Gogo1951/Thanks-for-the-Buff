local _, ns = ...
local Data = ns.Data

--------------------------------------------------------------------------------
-- Default Emote Settings
--------------------------------------------------------------------------------

local function GetDefaultEmoteSettings()
    local emotes = {}
    for _, data in ipairs(Data.EMOTES) do
        emotes[data.cmd] = true
    end
    return emotes
end

--------------------------------------------------------------------------------
-- Database Defaults
--------------------------------------------------------------------------------

--[[
    The AceDB-3.0 defaults table. Every user setting lives under `profile`; AceDB
    applies these via metatables (no hand-rolled merge). `global` is reserved for
    profile-independent, account-wide state -- this add-on has no minimap button,
    so it stays empty.
]]
ns.DATABASE_DEFAULTS = {
    profile = {
        showWelcome = true,
        strangers = {
            printEnabled = false,
            whisperEnabled = false,
            cooldown = 3,
            minBuffDuration = 25,
            emotesEnabled = true,
            emotes = GetDefaultEmoteSettings()
        },
        slash = {
            createMacro = true,
            message = ns.L["DEFAULT_WHISPER"],
            emotes = GetDefaultEmoteSettings()
        },
        -- Buffs from Teammates (party/raid buffs & cooldowns cast on you) and Group
        -- Services (no-aura raid help) each own their messaging settings, like
        -- strangers above. The watched-buff list is shared -- ids never overlap.
        teammates = {
            printEnabled = true,
            whisperEnabled = false,
            emotesEnabled = false,
            emotes = GetDefaultEmoteSettings()
        },
        services = {
            printEnabled = true,
            whisperEnabled = false,
            emotesEnabled = false,
            emotes = GetDefaultEmoteSettings()
        },
        watchedBuffs = {}
    },
    global = {}
}
