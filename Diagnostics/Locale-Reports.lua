local _, ns = ...

local GetClientHeader = ns.GetDiagnosticClientHeader

-- A value as one TSV cell: tabs and newlines flattened, pipes escaped so links paste as text.
local function CellText(value)
	return (tostring(value):gsub("[\t\r\n]", " "):gsub("|", "||"))
end

--------------------------------------------------------------------------------
-- Locale Context
--------------------------------------------------------------------------------

--[[
    Answers "the add-on shows the wrong language" reports: the client's locale,
    the text and audio locale CVars it was set to, and how many keys the
    add-on's locale table defines. Read-only.
]]
function ns:BuildLocaleContextReport()
	local lines = { GetClientHeader(), "" }
	lines[#lines + 1] = string.format("GetLocale: %s", tostring(GetLocale()))
	lines[#lines + 1] = string.format("textLocale CVar: %s", tostring(GetCVar("textLocale")))
	lines[#lines + 1] = string.format("audioLocale CVar: %s", tostring(GetCVar("audioLocale")))
	lines[#lines + 1] = string.format("Locale keys defined: %d", ns.CountDiagnosticKeys(ns.L))
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Game Names
--------------------------------------------------------------------------------

--[[
    Every game record the add-on names by ID (ns.DIAGNOSTIC_NAME_LOOKUPS), with
    the name this client returns through the add-on's own accessor, as
    tab-separated text. STATUS reads OK, NIL when the lookup returns nothing,
    or ERROR with the message in the NAME cell when it throws. Run on a
    non-English client, this checks every lookup's spelling at once.
]]
function ns:BuildGameNamesReport()
	local lines = { GetClientHeader(), "", "STATUS\tCONSTANT\tKIND\tID\tNAME" }
	for _, row in ipairs(ns.DIAGNOSTIC_NAME_LOOKUPS()) do
		local ok, name = pcall(row.lookup)
		local status
		if not ok then
			status, name = "ERROR", tostring(name)
		elseif name == nil or name == "" then
			status, name = "NIL", ""
		else
			status = "OK"
		end
		lines[#lines + 1] = table.concat({
			status,
			CellText(row.constant),
			CellText(row.kind),
			CellText(row.id),
			CellText(name),
		}, "\t")
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Message Length
--------------------------------------------------------------------------------

--[[
    Every whisper and macro TFTB can send or write, built through the add-on's
    own builders (ns.DIAGNOSTIC_MESSAGES), with each one's byte length against
    its ceiling, as tab-separated text. STATUS reads OK, or OVER when the line
    is longer than the client accepts. It builds strings only: nothing is sent
    and no macro is written. Any notes the manifest returns follow the table.
]]
function ns:BuildMessageLengthReport()
	local rows, notes = ns.DIAGNOSTIC_MESSAGES()
	local lines = { GetClientHeader(), "", "STATUS\tBYTES\tCEILING\tMESSAGE\tTEXT" }
	for _, row in ipairs(rows) do
		local text = row.text or ""
		lines[#lines + 1] = table.concat({
			#text > row.ceiling and "OVER" or "OK",
			tostring(#text),
			tostring(row.ceiling),
			CellText(row.label),
			CellText(text),
		}, "\t")
	end
	if notes and #notes > 0 then
		lines[#lines + 1] = ""
		for _, note in ipairs(notes) do
			lines[#lines + 1] = note
		end
	end
	return table.concat(lines, "\n")
end
