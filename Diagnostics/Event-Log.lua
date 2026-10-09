local _, ns = ...

local GetClientHeader = ns.GetDiagnosticClientHeader

--------------------------------------------------------------------------------
-- Event Log
--------------------------------------------------------------------------------

local EVENT_LOG_SIZE = 500
local EVENT_LOG_MAX_ARGS = 8
local EVENT_LOG_MAX_ARG_LENGTH = 255

--[[
    Events ns:LogEvent drops before recording. The dispatcher only ever hands
    LogEvent the events TFTB registers (Core's ns.EVENT_NAMES), and the buff
    engine writes the signal firings of both entries itself, decoded, through
    ns:LogEventNow:

    - COMBAT_LOG_EVENT_UNFILTERED, registered on every flavor but Forever: raw
      combat-log traffic would bury the signal, so every aura landing on you
      and every cast or revive TFTB tracks is logged in full instead, and every
      other cast is counted by spell id in the summary (see ns:LogCombatCast).
    - UNIT_AURA, registered only on Forever and only for the player: its update
      table can't be logged as text, so each added aura is logged with the gate
      that decided it instead (see ns:LogAuraUpdate).
]]
ns.DIAGNOSTIC_EVENT_EXCLUDE = {
	COMBAT_LOG_EVENT_UNFILTERED = true,
	UNIT_AURA = true,
}

--[[
    Events that carry an id worth classifying, and the argument position it
    arrives in, for ns:SuppressUncorrelatedMessage to classify per firing
    rather than drop wholesale. UNIT_SPELLCAST_SUCCEEDED fires for every unit
    the client tracks, so in a group or a city it is a firehose; its id is the
    spell id, a firing logs in full when TFTB correlates that id
    (ns.IsCorrelatedMessage), and every other firing is counted.
]]
ns.MESSAGE_ID_FILTERED_EVENTS = {
	UNIT_SPELLCAST_SUCCEEDED = 3,
}

-- The counter id a secret id (WoW Forever) folds into, since a secret can't key a table.
local SECRET_ID = 0

--[[
    Folds one uncorrelated firing into its counter: the first-seen text plus a
    count, rendered as one block at the end of the report. Counters are keyed
    by event, then id, so one id arriving on two events stays two rows. A
    secret id counts under SECRET_ID with the text <secret>. Counts only while
    logging, like ns:LogEventNow.
]]
function ns:CountUncorrelated(event, id, text)
	local suppressed = ns.diagnostics.suppressed
	if not suppressed or not ns.diagnostics.logging then
		return
	end
	if not ns.IsPlain(id) then
		id, text = SECRET_ID, "<secret>"
	elseif not ns.IsPlain(text) then
		text = "<secret>"
	end
	local counters = suppressed[event]
	if not counters then
		counters = {}
		suppressed[event] = counters
	end
	local entry = counters[id]
	if entry then
		entry.count = entry.count + 1
		return
	end
	local raw = string.sub(tostring(text or ""), 1, EVENT_LOG_MAX_ARG_LENGTH)
	counters[id] = { text = (raw:gsub("|", "||")), count = 1 }
end

--[[
    Per-firing filter for the events above. A firing whose id the add-on
    correlates (ns.IsCorrelatedMessage, where the add-on defines one) logs in
    full; any other folds into its counter, so firehose traffic can't evict
    the entries the log exists to carry. A secret id counts too. A plain
    firing carrying no numeric id in the filtered position is unclassifiable,
    and unclassifiable is signal: it logs verbatim. The counter's text is the
    argument after the id, or blank when none follows.

    Returns true when the firing was counted and must not reach the buffer.
]]
function ns:SuppressUncorrelatedMessage(event, ...)
	local idPosition = ns.MESSAGE_ID_FILTERED_EVENTS[event]
	if not idPosition then
		return false
	end
	local messageID = select(idPosition, ...)
	if ns.IsPlain(messageID) then
		if type(messageID) ~= "number" then
			return false
		end
		if ns.IsCorrelatedMessage and ns.IsCorrelatedMessage(event, messageID) then
			return false
		end
	end
	local text
	if select("#", ...) > idPosition then
		text = select(idPosition + 1, ...)
	end
	ns:CountUncorrelated(event, messageID, text)
	return true
end

function ns:StartEventLog()
	ns.diagnostics.log = {}
	ns.diagnostics.suppressed = {}
	ns.diagnostics.logging = true
end

function ns:StopEventLog()
	ns.diagnostics.logging = false
end

--[[
    Called by Core's central dispatcher for every event while logging is active.
    Snapshots arguments to strings immediately -- never retain references, since
    some events carry frames or tables that would leak memory or go stale. Caps
    the arg count and per-argument byte length so a single entry can't run away.

    Pipes are escaped (| -> ||) AFTER the length cut so each argument shows
    verbatim in the report editbox instead of rendering as a clickable item
    swatch. Escaping last also means the cut can never leave a dangling pipe that
    would eat the following ", " separator.
]]
function ns:LogEvent(event, ...)
	if ns.DIAGNOSTIC_EVENT_EXCLUDE[event] then
		return
	end
	if ns:SuppressUncorrelatedMessage(event, ...) then
		return
	end
	ns:LogEventNow(event, ...)
end

--[[
    Records one entry with no exclusion check, for a handler that decides a
    firing of an excluded firehose is signal. A secret argument (WoW Forever)
    can't be turned into text, so it records as <secret>.
]]
function ns:LogEventNow(event, ...)
	local log = ns.diagnostics.log
	if not log or not ns.diagnostics.logging then
		return
	end
	local parts = {}
	for index = 1, select("#", ...) do
		if index > EVENT_LOG_MAX_ARGS then
			break
		end
		local value = select(index, ...)
		if ns.IsPlain(value) then
			local raw = string.sub(tostring(value), 1, EVENT_LOG_MAX_ARG_LENGTH)
			parts[index] = (raw:gsub("|", "||"))
		else
			parts[index] = "<secret>"
		end
	end
	log[#log + 1] = string.format("%.3f %s(%s)", GetTime(), event, table.concat(parts, ", "))
	if #log > EVENT_LOG_SIZE then
		table.remove(log, 1)
	end
end

--[[
    Renders the suppressed-traffic counters as one compact block, biggest
    offender first. This is also how a tester discovers a message id the add-on
    should be correlating but isn't.
]]
local function AppendSuppressedSummary(lines)
	local suppressed = ns.diagnostics.suppressed
	if not suppressed then
		return
	end
	local rows = {}
	for event, counters in pairs(suppressed) do
		for id, entry in pairs(counters) do
			rows[#rows + 1] = { event = event, id = id, entry = entry }
		end
	end
	if #rows == 0 then
		return
	end
	table.sort(rows, function(a, b)
		if a.entry.count ~= b.entry.count then
			return a.entry.count > b.entry.count
		end
		if a.event ~= b.event then
			return a.event < b.event
		end
		return a.id < b.id
	end)
	lines[#lines + 1] = ""
	lines[#lines + 1] = "Suppressed uncorrelated traffic:"
	for _, row in ipairs(rows) do
		if row.id == SECRET_ID then
			lines[#lines + 1] = string.format("%s(<secret>) x%d", row.event, row.entry.count)
		else
			lines[#lines + 1] = string.format("%s(%d, %s) x%d", row.event, row.id, row.entry.text, row.entry.count)
		end
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
	AppendSuppressedSummary(lines)
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Taint Log
--------------------------------------------------------------------------------

--[[
    The taintLog CVar controls UI taint logging to Logs\taint.log. Level 2 logs
    both blocked actions and accesses to tainted globals; 0 is off. This is the
    only state the diagnostics panel ever writes.
]]

function ns:GetTaintLogState()
	return tonumber(GetCVar("taintLog")) or 0
end

function ns:SetTaintLog(enabled)
	SetCVar("taintLog", enabled and 2 or 0)
end
