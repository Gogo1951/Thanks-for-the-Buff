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
-- Default Configuration
--------------------------------------------------------------------------------

ns.DEFAULT_CONFIGURATION = {
    lastRunVersion = "0.0.0",
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
}
