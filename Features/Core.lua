local ADDON_NAME, ns = ...
local L = ns.L

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local welcomeMessageShown = false

--------------------------------------------------------------------------------
-- Version
--------------------------------------------------------------------------------

local function GetVersion()
    local GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
    local version = GetAddOnMetadata and GetAddOnMetadata(ADDON_NAME, "Version")
    if not version or version:find("@") then
        return "Dev"
    end
    return version
end

ns.Version = GetVersion()

--------------------------------------------------------------------------------
-- Saved Variables
--------------------------------------------------------------------------------

--[[
    Additive merge: fill only nil fields so a user's explicit choices are never
    overwritten. New defaults shipped in an update appear for existing users.
]]
local function ApplyDefaults(target, defaults)
    for key, value in pairs(defaults) do
        if type(value) == "table" then
            if type(target[key]) ~= "table" then
                target[key] = {}
            end
            ApplyDefaults(target[key], value)
        elseif target[key] == nil then
            target[key] = value
        end
    end
end

--[[
    One-time lift from the retired AceDB profile layout: settings used to live
    under TFTB_DB.profiles[key]. Move the active profile up to the account table,
    then drop the AceDB bookkeeping keys so the merge below sees a flat table.
]]
local function MigrateLegacyProfile()
    local profiles = TFTB_DB.profiles
    if type(profiles) ~= "table" then
        return
    end

    local charKey = TFTB_DB.profileKeys and TFTB_DB.profileKeys[UnitName("player") .. " - " .. GetRealmName()]
    local source = (charKey and profiles[charKey]) or profiles.Default
    if type(source) == "table" then
        if type(source.global) == "table" and source.global.welcomeMessage ~= nil then
            source.welcomeMessage = source.global.welcomeMessage
        end
        source.global = nil
        for key, value in pairs(source) do
            if TFTB_DB[key] == nil then
                TFTB_DB[key] = value
            end
        end
    end

    TFTB_DB.profiles = nil
    TFTB_DB.profileKeys = nil
    TFTB_DB.profile = nil
end

local function InitializeDatabase()
    TFTB_DB = TFTB_DB or {}
    MigrateLegacyProfile()
    ApplyDefaults(TFTB_DB, ns.DEFAULT_CONFIGURATION)
    ns.db = TFTB_DB
    ns.db.lastRunVersion = ns.Version

    -- Retired the tri-state "messaging" dropdown (independent print / whisper /
    -- emote toggles now) and the strangers master enable (2026-06; the messaging
    -- toggles are the enable). Drop the stale fields if they linger.
    ns.db.strangers.messaging = nil
    ns.db.strangers.enabled = nil

    -- Renamed welcomeMessage -> showWelcome (2026-06): keep the user's choice, drop the old key.
    if ns.db.welcomeMessage ~= nil then
        ns.db.showWelcome = ns.db.welcomeMessage
        ns.db.welcomeMessage = nil
    end

    -- Split the old combined "groupBuffs" config (2026-06) into independent
    -- "Buffs from Teammates" and "Group Services" settings. Carry the player's old
    -- messaging prefs into both and keep their watched list, so upgrading resets
    -- nothing.
    if ns.db.groupBuffs then
        local old = ns.db.groupBuffs
        if type(old.watchedBuffs) == "table" then
            ns.db.watchedBuffs = old.watchedBuffs
        end
        for _, cfg in ipairs({ns.db.teammates, ns.db.services}) do
            if old.printEnabled ~= nil then
                cfg.printEnabled = old.printEnabled
            end
            if old.whisperEnabled ~= nil then
                cfg.whisperEnabled = old.whisperEnabled
            end
            if old.emotesEnabled ~= nil then
                cfg.emotesEnabled = old.emotesEnabled
            end
            if type(old.emotes) == "table" then
                local copy = {}
                for k, v in pairs(old.emotes) do
                    copy[k] = v
                end
                cfg.emotes = copy
            end
        end
        ns.db.groupBuffs = nil
    end
end

--------------------------------------------------------------------------------
-- Reset
--------------------------------------------------------------------------------

function ns:ResetSettings()
    wipe(TFTB_DB)
    ApplyDefaults(TFTB_DB, ns.DEFAULT_CONFIGURATION)
    ns.db.lastRunVersion = ns.Version
    if ns.PopulateWatchedBuffs then
        ns.PopulateWatchedBuffs()
    end
end

--------------------------------------------------------------------------------
-- Event Dispatch
--------------------------------------------------------------------------------

--[[
    Every registered event routes through this single dispatcher, which is what
    lets the diagnostics event log capture them all from one tap. Feature modules
    register their handlers through ns.RegisterEvent rather than creating their
    own frames, so the dispatcher stays the single point that sees every event.
    Each event has a single owner: registering the same event twice replaces the
    earlier handler, so two modules must not claim the same event.
]]
local eventFrame = CreateFrame("Frame")
local eventHandlers = {}
ns.eventHandlers = eventHandlers

function ns.RegisterEvent(event, handler)
    eventHandlers[event] = handler
    eventFrame:RegisterEvent(event)
end

eventFrame:SetScript("OnEvent", function(_, event, ...)
    if ns.diagnostics and ns.diagnostics.logging then
        ns:LogEvent(event, ...)
    end
    local handler = eventHandlers[event]
    if handler then
        handler(...)
    end
end)

--------------------------------------------------------------------------------
-- Lifecycle
--------------------------------------------------------------------------------

--[[
    The login sequence owns ordering: the saved variables must exist before any
    feature reads them, and the display groups must exist before the options panels
    that render them. Feature logic lives in the feature modules; Core only calls
    their setup hooks in the right order.
]]
local function OnPlayerLogin()
    InitializeDatabase()

    if ns.SetupBuffTracking then
        ns.SetupBuffTracking()
    end

    if ns.SetupOptions then
        ns.SetupOptions()
    end

    if ns.CreateAutoMacro then
        ns:CreateAutoMacro()
    end
end

local function OnPlayerEnteringWorld()
    if ns.db and ns.db.showWelcome and not welcomeMessageShown then
        ns:PrintMessage(L["CHAT_LOADED"]:format(ns.Version))
        welcomeMessageShown = true
    end
end

ns.RegisterEvent("PLAYER_LOGIN", OnPlayerLogin)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", OnPlayerEnteringWorld)
