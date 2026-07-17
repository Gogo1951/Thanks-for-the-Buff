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
	log = nil,
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
	EVENT_LOG_HINT = "Records the most recent events the add-on saw, with their arguments, plus every nearby spell cast (SPELL_CAST_SUCCESS) so you can see whether a portal, summon, or feast reaches the add-on and with what spell id.",
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
	TOOLS_ETRACE = "Event tracing for everything (not just this add-on): /etrace.",
}

--------------------------------------------------------------------------------
-- Manifests (tailored to this add-on)
--------------------------------------------------------------------------------

--[[
    Events ns:LogEvent drops before recording. The dispatcher only ever hands
    LogEvent the events TFTB registers (Core's ns.EVENT_NAMES), and the log
    never sees an event the add-on didn't register -- so generic offenders
    (UNIT_AURA and friends) do not belong here unless registered. The one entry
    is COMBAT_LOG_EVENT_UNFILTERED, a sustained firehose TFTB does register:
    raw combat-log traffic would bury the signal, so the buff engine feeds the
    log through ns:LogCombatCast instead (one decoded line per nearby
    SPELL_CAST_SUCCESS, recorded before any filtering).
]]
ns.DIAGNOSTIC_EVENT_EXCLUDE = {
	COMBAT_LOG_EVENT_UNFILTERED = true,
}

--[[
    Existence and shape checks only: read-only, no side effects, no protected
    calls. Kept aligned with the API guards in Features/Utilities.lua,
    Features/Core.lua, and Options/Options.lua, plus the load-bearing APIs the
    reaction engine depends on. Modern and legacy fallbacks are listed
    separately so the report shows exactly what each client provides.
]]
ns.DIAGNOSTIC_API_CHECKS = {
	-- { label, testFunction }
	{
		"C_AddOns.GetAddOnMetadata",
		function()
			return type(C_AddOns) == "table" and type(C_AddOns.GetAddOnMetadata) == "function"
		end,
	},
	{
		"GetAddOnMetadata (legacy)",
		function()
			return type(GetAddOnMetadata) == "function"
		end,
	},
	{
		"C_Spell.GetSpellName",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellName) == "function"
		end,
	},
	{
		"C_Spell.GetSpellInfo",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellInfo) == "function"
		end,
	},
	{
		"GetSpellInfo (legacy)",
		function()
			return type(GetSpellInfo) == "function"
		end,
	},
	{
		"C_Spell.DoesSpellExist",
		function()
			return type(C_Spell) == "table" and type(C_Spell.DoesSpellExist) == "function"
		end,
	},
	{
		"C_Spell.GetSpellDescription",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellDescription) == "function"
		end,
	},
	{
		"GetSpellDescription (legacy)",
		function()
			return type(GetSpellDescription) == "function"
		end,
	},
	{
		"C_Spell.GetSpellTexture",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellTexture) == "function"
		end,
	},
	{
		"GetSpellTexture (legacy)",
		function()
			return type(GetSpellTexture) == "function"
		end,
	},
	{
		"C_Spell.GetSpellLink",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellLink) == "function"
		end,
	},
	{
		"GetSpellLink (legacy)",
		function()
			return type(GetSpellLink) == "function"
		end,
	},
	{
		"C_Item.GetItemInfo",
		function()
			return type(C_Item) == "table" and type(C_Item.GetItemInfo) == "function"
		end,
	},
	{
		"GetItemInfo (legacy)",
		function()
			return type(GetItemInfo) == "function"
		end,
	},
	{
		"C_Item.GetItemIconByID",
		function()
			return type(C_Item) == "table" and type(C_Item.GetItemIconByID) == "function"
		end,
	},
	{
		"GetItemIcon (legacy)",
		function()
			return type(GetItemIcon) == "function"
		end,
	},
	{
		"C_UnitAuras.GetBuffDataByIndex",
		function()
			return type(C_UnitAuras) == "table" and type(C_UnitAuras.GetBuffDataByIndex) == "function"
		end,
	},
	{
		"UnitAura (legacy)",
		function()
			return type(UnitAura) == "function"
		end,
	},
	{
		"CombatLogGetCurrentEventInfo",
		function()
			return type(CombatLogGetCurrentEventInfo) == "function"
		end,
	},
	{
		"GetPlayerInfoByGUID",
		function()
			return type(GetPlayerInfoByGUID) == "function"
		end,
	},
	{
		"DoEmote",
		function()
			return type(DoEmote) == "function"
		end,
	},
	{
		"SendChatMessage",
		function()
			return type(SendChatMessage) == "function"
		end,
	},
	{
		"CreateMacro",
		function()
			return type(CreateMacro) == "function"
		end,
	},
	{
		"GetMacroIndexByName",
		function()
			return type(GetMacroIndexByName) == "function"
		end,
	},
	{
		"GetNumMacros",
		function()
			return type(GetNumMacros) == "function"
		end,
	},
	{
		"C_Timer.After",
		function()
			return type(C_Timer) == "table" and type(C_Timer.After) == "function"
		end,
	},
	{
		"Settings.OpenToCategory",
		function()
			return type(Settings) == "table" and type(Settings.OpenToCategory) == "function"
		end,
	},
	{
		"InterfaceOptionsFrame_OpenToCategory (legacy)",
		function()
			return type(InterfaceOptionsFrame_OpenToCategory) == "function"
		end,
	},
	{
		"IsPlayerSpell",
		function()
			return type(IsPlayerSpell) == "function"
		end,
	},
	{
		"COMBATLOG_OBJECT_* affiliation / reaction / type flags",
		function()
			return COMBATLOG_OBJECT_TYPE_PLAYER ~= nil
				and COMBATLOG_OBJECT_REACTION_FRIENDLY ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_MINE ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_PARTY ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_RAID ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_OUTSIDER ~= nil
		end,
	},
}

-- Per-class tracked-spell manifest for the IsPlayerSpell probe below. Rebuilt
-- from Data.TRACKED at login by Features/Buff-Tracking.lua; the empty default
-- keeps the probe safe if it somehow runs before login.
ns.DIAGNOSTIC_SPELLS = {}

-- Tracked-trigger coverage on the running client, filled at login by
-- Features/Buff-Tracking.lua. Zeroed here so the context report is safe before login.
ns.DIAGNOSTIC_TRACKED = { entriesLive = 0, entriesTotal = 0, auraIds = 0, castIds = 0 }

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

--[[
    Called by Core's dispatcher for every event while logging is active.
    Snapshots arguments to strings immediately -- never retain references, since
    some events carry frames or tables that would leak memory or go stale. Caps
    the arg count and string length so a single entry can't run away.

    Pipes are escaped (| -> ||) AFTER the length cut so each argument shows
    verbatim in the report editbox, and a truncated argument can never leave a
    dangling pipe that would eat the following ", " separator.
]]
function ns:LogEvent(event, ...)
	if ns.DIAGNOSTIC_EVENT_EXCLUDE[event] then
		return
	end
	local parts = {}
	for index = 1, select("#", ...) do
		if index > EVENT_LOG_MAX_ARGS then
			break
		end
		local raw = string.sub(tostring((select(index, ...))), 1, EVENT_LOG_MAX_ARG_LENGTH)
		parts[index] = (raw:gsub("|", "||"))
	end
	local log = ns.diagnostics.log
	log[#log + 1] = string.format("%.3f %s(%s)", GetTime(), event, table.concat(parts, ", "))
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
	local affiliation = (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 and "MINE")
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
	local lines = { GetClientHeader(), "" }
	local log = ns.diagnostics.log
	if not log or #log == 0 then
		lines[#lines + 1] = "(no events captured)"
	else
		for _, entry in ipairs(log) do
			lines[#lines + 1] = entry
		end
	end
	return table.concat(lines, "\n")
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
	local lines = { GetClientHeader(), "" }
	local hasIsEventValid = type(C_EventUtils) == "table" and type(C_EventUtils.IsEventValid) == "function"
	local probe = GetProbeFrame()
	local failures = 0
	for _, event in ipairs(ns.EVENT_NAMES or {}) do
		local valid = "n/a"
		if hasIsEventValid then
			valid = C_EventUtils.IsEventValid(event) and "valid" or "INVALID"
		end
		local ok = pcall(probe.RegisterEvent, probe, event)
		if ok then
			probe:UnregisterEvent(event)
		else
			failures = failures + 1
		end
		lines[#lines + 1] = string.format("[%s] %s (IsEventValid: %s)", ok and "PASS" or "FAIL", event, valid)
	end
	lines[#lines + 1] = ""
	if failures == 0 then
		lines[#lines + 1] = "All events register on this client."
	else
		lines[#lines + 1] = string.format("%d event(s) failed to register.", failures)
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- API Endpoints
--------------------------------------------------------------------------------

function ns:RunApiChecks()
	local lines = { GetClientHeader(), "" }
	for _, check in ipairs(ns.DIAGNOSTIC_API_CHECKS) do
		local ok, result = pcall(check[2])
		lines[#lines + 1] = ((ok and result) and "[PASS] " or "[FAIL] ") .. check[1]
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
	local lines = { GetClientHeader(), "" }

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
		lines[#lines + 1] = string.format("Good News: whisper=%s", tostring(db.goodNews and db.goodNews.whisperEnabled))
		lines[#lines + 1] = string.format(
			"Peer Pressure: enabled=%s print=%s ownCasts=%s sound=%s",
			tostring(db.peerPressure and db.peerPressure.enabled),
			tostring(db.peerPressure and db.peerPressure.printEnabled),
			tostring(db.peerPressure and db.peerPressure.triggerOnOwnCasts),
			tostring(db.peerPressure and db.peerPressure.soundEnabled)
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

	local lines = { GetClientHeader(), "" }
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
	local lines = { GetClientHeader(), "", "TFTB_DB = {" }
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
	local lines = { GetClientHeader(), "" }
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
