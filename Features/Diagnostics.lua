local _, ns = ...

--[[
    Diagnostic Tools — runtime-only environment probing and state capture for bug
    reports. The strings here are developer-facing and intentionally never go
    through Locales/. Nothing in this file persists to SavedVariables.
]]

--------------------------------------------------------------------------------
-- Runtime State
--------------------------------------------------------------------------------

ns.diagnostics = {
    enabled = false,
    logging = false,
    log = nil
}

local EVENT_LOG_SIZE = 500
local EVENT_LOG_MAX_ARGS = 8
local EVENT_LOG_MAX_ARG_LENGTH = 255
local DUMP_MAX_DEPTH = 8
local DUMP_SUMMARY_THRESHOLD = 20

local probeFrame

--------------------------------------------------------------------------------
-- Strings (developer-facing, never localized)
--------------------------------------------------------------------------------

ns.DiagnosticsStrings = {
    TAB = "Diagnostic Tools",
    WARNING = "These tools are for troubleshooting and bug reports. They are runtime-only: nothing is saved, and everything resets when you log out. Leave them off unless you are chasing a problem.",
    ENABLE = "Enable Diagnostic Tools",
    EVENT_LOG_TITLE = "Event Log",
    EVENT_LOG_START = "Start Logging",
    EVENT_LOG_STOP = "Stop Logging",
    EVENT_LOG_SHOW = "Show Log",
    EVENT_LOG_HINT = "Records the most recent events the add-on saw, with their arguments, plus every nearby spell cast (SPELL_CAST_SUCCESS) so you can see whether a portal, summon, or feast reaches the add-on and with what spell id. Review the output before pasting it into a bug report -- if you were whispered while logging, the message text will appear here.",
    EVENTS_TITLE = "Event Registration",
    EVENTS_BUTTON = "Run Event Checks",
    API_TITLE = "API Endpoints",
    API_BUTTON = "Run API Checks",
    CONTEXT_TITLE = "Add-on Context",
    CONTEXT_BUTTON = "Show Context",
    ADDONS_TITLE = "Other Add-ons",
    ADDONS_BUTTON = "List Add-ons",
    SAVED_TITLE = "Saved Variables",
    SAVED_BUTTON = "Dump Saved Variables",
    LIBS_TITLE = "Library Versions",
    LIBS_BUTTON = "List Libraries",
    TAINT_TITLE = "Taint Log",
    TAINT_STATE = "Taint logging is currently: %s",
    TAINT_ON = "Turn Taint Logging On",
    TAINT_OFF = "Turn Taint Logging Off",
    TAINT_HINT = "Writes UI taint to Logs\\taint.log. This setting persists across sessions, and a /reload makes the log capture taint from load onward.",
    TOOLS_TITLE = "External Tools",
    TOOLS_ERRORS = "Lua errors: install BugSack and !BugGrabber, or run /console scriptErrors 1.",
    TOOLS_ETRACE = "Event tracing for everything (not just this add-on): /etrace."
}

--------------------------------------------------------------------------------
-- Manifests (tailored to this add-on)
--------------------------------------------------------------------------------

--[[
    Firehose events are kept out of the log so they cannot bury the signal. The
    only one this add-on registers is COMBAT_LOG_EVENT_UNFILTERED; UNIT_AURA is
    listed defensively in case it is ever added.
]]
ns.DIAGNOSTIC_EVENT_EXCLUDE = {
    COMBAT_LOG_EVENT_UNFILTERED = true,
    UNIT_AURA = true
}

-- One row per API the add-on calls or guards for. Existence checks only.
ns.DIAGNOSTIC_API_CHECKS = {
    {
        label = "C_AddOns.GetAddOnMetadata / GetAddOnMetadata",
        test = function()
            return (C_AddOns and C_AddOns.GetAddOnMetadata) ~= nil or GetAddOnMetadata ~= nil
        end
    },
    {
        label = "C_Spell.GetSpellDescription / GetSpellDescription",
        test = function()
            return (C_Spell and C_Spell.GetSpellDescription) ~= nil or GetSpellDescription ~= nil
        end
    },
    {
        label = "C_Spell.GetSpellTexture / GetSpellTexture",
        test = function()
            return (C_Spell and C_Spell.GetSpellTexture) ~= nil or GetSpellTexture ~= nil
        end
    },
    {
        label = "C_Spell.DoesSpellExist / C_Spell.GetSpellInfo / GetSpellInfo",
        test = function()
            return (C_Spell and (C_Spell.DoesSpellExist or C_Spell.GetSpellInfo)) ~= nil or GetSpellInfo ~= nil
        end
    },
    {
        label = "C_UnitAuras.GetBuffDataByIndex / UnitAura",
        test = function()
            return (C_UnitAuras and C_UnitAuras.GetBuffDataByIndex) ~= nil or UnitAura ~= nil
        end
    },
    {
        label = "CombatLogGetCurrentEventInfo",
        test = function()
            return CombatLogGetCurrentEventInfo ~= nil
        end
    },
    {
        label = "C_Spell.GetSpellLink / GetSpellLink",
        test = function()
            return (C_Spell and C_Spell.GetSpellLink) ~= nil or GetSpellLink ~= nil
        end
    },
    {
        label = "C_Item.GetItemInfo / GetItemInfo",
        test = function()
            return (C_Item and C_Item.GetItemInfo) ~= nil or GetItemInfo ~= nil
        end
    },
    {
        label = "C_Item.GetItemIconByID / GetItemIcon",
        test = function()
            return (C_Item and C_Item.GetItemIconByID) ~= nil or GetItemIcon ~= nil
        end
    },
    {
        label = "GetPlayerInfoByGUID",
        test = function()
            return GetPlayerInfoByGUID ~= nil
        end
    },
    {
        label = "DoEmote",
        test = function()
            return DoEmote ~= nil
        end
    },
    {
        label = "SendChatMessage",
        test = function()
            return SendChatMessage ~= nil
        end
    },
    {
        label = "CreateMacro / GetMacroIndexByName / GetNumMacros",
        test = function()
            return CreateMacro ~= nil and GetMacroIndexByName ~= nil and GetNumMacros ~= nil
        end
    },
    {
        label = "C_Timer.After",
        test = function()
            return C_Timer ~= nil and C_Timer.After ~= nil
        end
    },
    {
        label = "Settings.OpenToCategory / InterfaceOptionsFrame_OpenToCategory",
        test = function()
            return (Settings and Settings.OpenToCategory) ~= nil or InterfaceOptionsFrame_OpenToCategory ~= nil
        end
    },
    {
        label = "IsPlayerSpell",
        test = function()
            return IsPlayerSpell ~= nil
        end
    },
    {
        label = "COMBATLOG_OBJECT_* affiliation / reaction / type flags",
        test = function()
            return COMBATLOG_OBJECT_TYPE_PLAYER ~= nil
                and COMBATLOG_OBJECT_REACTION_FRIENDLY ~= nil
                and COMBATLOG_OBJECT_AFFILIATION_MINE ~= nil
                and COMBATLOG_OBJECT_AFFILIATION_PARTY ~= nil
                and COMBATLOG_OBJECT_AFFILIATION_RAID ~= nil
                and COMBATLOG_OBJECT_AFFILIATION_OUTSIDER ~= nil
        end
    }
}

-- Per-class tracked-spell manifest for the IsPlayerSpell probe below. Rebuilt
-- from Data.TRACKED at login by Features/Buff-Tracking.lua; the empty default
-- keeps the probe safe if it somehow runs before login.
ns.DIAGNOSTIC_SPELLS = {}

-- Tracked-trigger coverage on the running client, filled at login by
-- Features/Buff-Tracking.lua. Zeroed here so the context report is safe before login.
ns.DIAGNOSTIC_TRACKED = {entriesLive = 0, entriesTotal = 0, auraIds = 0, castIds = 0}

--------------------------------------------------------------------------------
-- Report Header
--------------------------------------------------------------------------------

local function GetClientHeader()
    local version, build, _, tocVersion = GetBuildInfo()
    return string.format(
        "%s %s // Client %s // Build %s // TOC %s // Locale %s // Project %s",
        ns.L["ADDON_TITLE"],
        ns.Version or "Dev",
        tostring(version),
        tostring(build),
        tostring(tocVersion),
        tostring(GetLocale()),
        tostring(WOW_PROJECT_ID or 0)
    )
end

--------------------------------------------------------------------------------
-- Enable Gate
--------------------------------------------------------------------------------

function ns:SetDiagnosticsEnabled(value)
    ns.diagnostics.enabled = value and true or false
    if not value then
        ns:StopEventLog()
    end
end

--------------------------------------------------------------------------------
-- Event Log
--------------------------------------------------------------------------------

function ns:StartEventLog()
    ns.diagnostics.log = {}
    ns.diagnostics.logging = true
end

function ns:StopEventLog()
    ns.diagnostics.logging = false
    ns.diagnostics.log = nil
end

function ns:LogEvent(event, ...)
    local log = ns.diagnostics.log
    if not log or ns.DIAGNOSTIC_EVENT_EXCLUDE[event] then
        return
    end

    local count = select("#", ...)
    if count > EVENT_LOG_MAX_ARGS then
        count = EVENT_LOG_MAX_ARGS
    end

    local parts = {}
    for i = 1, count do
        local value = tostring(select(i, ...))
        if #value > EVENT_LOG_MAX_ARG_LENGTH then
            value = value:sub(1, EVENT_LOG_MAX_ARG_LENGTH)
        end
        parts[i] = value:gsub("|", "||")
    end

    local entry = string.format("%.3f  %s", GetTime(), event)
    if count > 0 then
        entry = entry .. "  " .. table.concat(parts, ", ")
    end

    log[#log + 1] = entry
    if #log > EVENT_LOG_SIZE then
        table.remove(log, 1)
    end
end

--[[
    Opt-in probe for the "why isn't this cast announced" case (portals, summons,
    feasts). COMBAT_LOG_EVENT_UNFILTERED is kept out of the general event log as a
    firehose, so the buff engine calls this directly for each SPELL_CAST_SUCCESS
    while logging is on. It records the RAW event -- spell id + name, source, the
    decoded affiliation/reaction flags, and whether the add-on tracks and watches
    that id -- before any filtering, so a cast that arrives but is dropped is still
    visible. tracked=false on a portal means its id never made the lookup (a data
    problem); tracked=true watched=true means the cast reached us and the issue is
    downstream.
]]
function ns:LogCombatCast(spellID, sourceName, sourceFlags, tracked, watched)
    local log = ns.diagnostics.log
    if not log then
        return
    end

    local flags = sourceFlags or 0
    local isPlayer = bit.band(flags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0
    local isFriendly = bit.band(flags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0
    local affiliation =
        (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 and "MINE")
        or (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0 and "PARTY")
        or (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_RAID) > 0 and "RAID")
        or (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0 and "OUTSIDER")
        or "?"

    local spellName = (ns.GetSpellName and ns.GetSpellName(spellID)) or "?"

    local entry = string.format(
        "%.3f  CAST  %s [%s]  from %s  player=%s friendly=%s aff=%s  tracked=%s watched=%s",
        GetTime(),
        tostring(spellID),
        tostring(spellName),
        tostring(sourceName),
        tostring(isPlayer),
        tostring(isFriendly),
        affiliation,
        tostring(tracked and true or false),
        tostring(watched and true or false)
    )

    log[#log + 1] = entry
    if #log > EVENT_LOG_SIZE then
        table.remove(log, 1)
    end
end

function ns:BuildEventLogReport()
    local log = ns.diagnostics.log
    local body
    if not log or #log == 0 then
        body = "(no events captured)"
    else
        body = table.concat(log, "\n")
    end
    return GetClientHeader() .. "\n\n" .. body
end

--------------------------------------------------------------------------------
-- Event Registration
--------------------------------------------------------------------------------

local function GetProbeFrame()
    if not probeFrame then
        probeFrame = CreateFrame("Frame")
    end
    return probeFrame
end

function ns:RunEventChecks()
    local frame = GetProbeFrame()

    local names = {}
    for _, event in ipairs(ns.EVENT_NAMES or {}) do
        names[#names + 1] = event
    end
    table.sort(names)

    local lines = {GetClientHeader(), ""}
    for _, event in ipairs(names) do
        local valid = C_EventUtils and C_EventUtils.IsEventValid and C_EventUtils.IsEventValid(event)
        local ok = pcall(function()
            frame:RegisterEvent(event)
            frame:UnregisterEvent(event)
        end)
        local status = ok and "[PASS]" or "[FAIL]"
        lines[#lines + 1] = string.format("%s  %s  (IsEventValid=%s)", status, event, tostring(valid and true or false))
    end
    return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- API Endpoints
--------------------------------------------------------------------------------

function ns:RunApiChecks()
    local lines = {GetClientHeader(), ""}
    for _, check in ipairs(ns.DIAGNOSTIC_API_CHECKS) do
        local ok, result = pcall(check.test)
        local status = (ok and result) and "[PASS]" or "[FAIL]"
        lines[#lines + 1] = status .. "  " .. check.label
    end
    return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Add-on Context
--------------------------------------------------------------------------------

--[[
    The state most likely to explain a "nothing happens when I get buffed" report:
    who the player is, whether the group/stranger paths are reachable right now,
    how many buffs are watched, how much of the tracked data is live on this
    client, and whether they actually know the spells the add-on tracks for their
    class.
]]
function ns:BuildContextReport()
    local lines = {GetClientHeader(), ""}

    local _, class = UnitClass("player")
    lines[#lines + 1] = string.format(
        "Player: %s  Class: %s  Level: %s  Faction: %s",
        UnitName("player") or "?",
        tostring(class),
        tostring(UnitLevel("player") or 0),
        tostring(UnitFactionGroup("player") or "?")
    )
    lines[#lines + 1] = string.format(
        "Grouped: party=%s raid=%s  InCombat=%s",
        tostring(IsInGroup() and true or false),
        tostring(IsInRaid() and true or false),
        tostring(InCombatLockdown() and true or false)
    )

    local db = ns.db and ns.db.profile
    if db then
        lines[#lines + 1] = string.format(
            "Strangers: print=%s whisper=%s emotes=%s  minDuration=%s cooldown=%s",
            tostring(db.strangers and db.strangers.printEnabled),
            tostring(db.strangers and db.strangers.whisperEnabled),
            tostring(db.strangers and db.strangers.emotesEnabled),
            tostring(db.strangers and db.strangers.minBuffDuration),
            tostring(db.strangers and db.strangers.cooldown)
        )
        lines[#lines + 1] = string.format(
            "Teammates: print=%s whisper=%s emotes=%s",
            tostring(db.teammates and db.teammates.printEnabled),
            tostring(db.teammates and db.teammates.whisperEnabled),
            tostring(db.teammates and db.teammates.emotesEnabled)
        )
        lines[#lines + 1] = string.format(
            "Services: print=%s whisper=%s emotes=%s",
            tostring(db.services and db.services.printEnabled),
            tostring(db.services and db.services.whisperEnabled),
            tostring(db.services and db.services.emotesEnabled)
        )

        local watchedOn, watchedTotal = 0, 0
        if type(db.watchedBuffs) == "table" then
            for _, on in pairs(db.watchedBuffs) do
                watchedTotal = watchedTotal + 1
                if on then
                    watchedOn = watchedOn + 1
                end
            end
        end
        lines[#lines + 1] = string.format("Watched buffs: %d enabled / %d total", watchedOn, watchedTotal)
    else
        lines[#lines + 1] = "Saved variables not initialized."
    end

    local tracked = ns.DIAGNOSTIC_TRACKED
    if tracked then
        lines[#lines + 1] = string.format(
            "Tracked triggers live on this client: %d / %d entries  (aura ids=%d, cast ids=%d)",
            tracked.entriesLive or 0,
            tracked.entriesTotal or 0,
            tracked.auraIds or 0,
            tracked.castIds or 0
        )
    end

    lines[#lines + 1] = ""
    lines[#lines + 1] = "Tracked spells for your class (IsPlayerSpell):"
    local classSpells = class and ns.DIAGNOSTIC_SPELLS and ns.DIAGNOSTIC_SPELLS[class]
    if classSpells then
        for _, spellData in ipairs(classSpells) do
            local known = false
            for _, id in ipairs(spellData.ids) do
                if IsPlayerSpell(id) then
                    known = true
                    break
                end
            end
            lines[#lines + 1] = string.format("  %s = %s", spellData.name, tostring(known))
        end
    else
        lines[#lines + 1] = "  (no tracked spells for this class)"
    end

    return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Other Add-ons
--------------------------------------------------------------------------------

function ns:BuildAddOnReport()
    local getNumAddOns = (C_AddOns and C_AddOns.GetNumAddOns) or GetNumAddOns
    local getAddOnInfo = (C_AddOns and C_AddOns.GetAddOnInfo) or GetAddOnInfo
    local getMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
    local isLoaded = (C_AddOns and C_AddOns.IsAddOnLoaded) or IsAddOnLoaded

    local lines = {GetClientHeader(), ""}
    local total = (getNumAddOns and getNumAddOns()) or 0
    for i = 1, total do
        local name = getAddOnInfo and getAddOnInfo(i)
        local version = (getMetadata and getMetadata(i, "Version")) or "?"
        local loaded = (isLoaded and isLoaded(i)) and "loaded" or "not loaded"
        lines[#lines + 1] = string.format("%s (%s) [%s]", tostring(name), tostring(version), loaded)
    end
    return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Saved Variables
--------------------------------------------------------------------------------

local function DumpTable(value, indent, depth, lines)
    if depth > DUMP_MAX_DEPTH then
        lines[#lines + 1] = indent .. "...(max depth)"
        return lines
    end

    local count = 0
    for _ in pairs(value) do
        count = count + 1
    end
    if count > DUMP_SUMMARY_THRESHOLD then
        lines[#lines + 1] = string.format("%s...(%d entries)", indent, count)
        return lines
    end

    local keys = {}
    for key in pairs(value) do
        keys[#keys + 1] = key
    end
    table.sort(keys, function(a, b)
        return tostring(a) < tostring(b)
    end)

    for _, key in ipairs(keys) do
        local child = value[key]
        if type(child) == "table" then
            lines[#lines + 1] = string.format("%s%s = {", indent, tostring(key))
            DumpTable(child, indent .. "    ", depth + 1, lines)
            lines[#lines + 1] = indent .. "}"
        else
            lines[#lines + 1] = string.format("%s%s = %s", indent, tostring(key), tostring(child))
        end
    end
    return lines
end

function ns:BuildSavedVariablesReport()
    local lines = {GetClientHeader(), "", "TFTB_DB = {"}
    if type(TFTB_DB) == "table" then
        DumpTable(TFTB_DB, "    ", 1, lines)
    end
    lines[#lines + 1] = "}"
    return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Library Versions
--------------------------------------------------------------------------------

function ns:BuildLibraryReport()
    local lines = {GetClientHeader(), ""}
    local libs = {}
    if LibStub and LibStub.libs then
        for major in pairs(LibStub.libs) do
            libs[#libs + 1] = string.format("%s (minor %s)", major, tostring(LibStub.minors and LibStub.minors[major]))
        end
    end
    table.sort(libs)
    for _, line in ipairs(libs) do
        lines[#lines + 1] = line
    end
    return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Taint Log
--------------------------------------------------------------------------------

function ns:GetTaintLogState()
    local getCVar = (C_CVar and C_CVar.GetCVar) or GetCVar
    local value = getCVar and getCVar("taintLog") or "0"
    return tonumber(value) or 0
end

function ns:SetTaintLog(enabled)
    local value = enabled and "2" or "0"
    if C_CVar and C_CVar.SetCVar then
        C_CVar.SetCVar("taintLog", value)
    elseif SetCVar then
        SetCVar("taintLog", value)
    end
end
