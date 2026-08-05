local _, ns = ...

local GetColor = ns.GetColor
local S = ns.DiagnosticsStrings

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

--------------------------------------------------------------------------------
-- Diagnostic Tools Panel
--------------------------------------------------------------------------------

local function DiagnosticsOn()
	return ns.diagnostics.enabled == true
end

local function Hidden()
	return not DiagnosticsOn()
end

local function Refresh()
	AceConfigRegistry:NotifyChange(ns.OPTIONS_REGISTRY.Diagnostics)
end

-- The shared header and the blank line that follows every one of them, both
-- pre-bound to this panel's enable gate so each section collapses with it.
local function SectionHeader(text, order)
	return ns.OptionsHeader(text, order, Hidden)
end

local function SectionSpacer(order)
	return { type = "description", name = " ", order = order, hidden = Hidden }
end

local function ReportOutput(field, order)
	return {
		type = "input",
		name = "",
		multiline = 12,
		width = "full",
		order = order,
		hidden = Hidden,
		get = function()
			return ns.diagnostics[field] or ""
		end,
		set = function() end,
	}
end

function ns.BuildDiagnosticsOptions()
	return {
		name = S.TAB,
		type = "group",
		args = {
			descWarning = ns.OptionsDesc(S.WARNING, 1),
			spaceEnable = ns.OptionsSpacer(2),
			toggleEnable = {
				type = "toggle",
				name = S.ENABLE,
				width = "full",
				order = 3,
				get = function()
					return ns.diagnostics.enabled
				end,
				set = function(_, val)
					ns:SetDiagnosticsEnabled(val)
					Refresh()
				end,
			},
			-- Event Log
			headerEventLog = SectionHeader(S.EVENT_LOG_TITLE, 5),
			spaceEventLog = SectionSpacer(6),
			buttonStartLog = {
				type = "execute",
				name = S.EVENT_LOG_START,
				order = 7,
				hidden = Hidden,
				func = function()
					ns:StartEventLog()
				end,
			},
			buttonStopLog = {
				type = "execute",
				name = S.EVENT_LOG_STOP,
				order = 8,
				hidden = Hidden,
				func = function()
					ns:StopEventLog()
				end,
			},
			buttonShowLog = {
				type = "execute",
				name = S.EVENT_LOG_SHOW,
				order = 9,
				hidden = Hidden,
				func = function()
					ns.diagnostics.eventLogReport = ns:BuildEventLogReport()
					Refresh()
				end,
			},
			outputEventLog = ReportOutput("eventLogReport", 10),
			descEventLogHint = {
				type = "description",
				name = GetColor("HELP") .. S.EVENT_LOG_HINT .. "|r",
				fontSize = "medium",
				order = 11,
				hidden = Hidden,
			},
			-- Event Registration
			headerEvents = SectionHeader(S.EVENTS_TITLE, 13),
			spaceEvents = SectionSpacer(14),
			buttonEvents = {
				type = "execute",
				name = S.EVENTS_BUTTON,
				order = 15,
				hidden = Hidden,
				func = function()
					ns.diagnostics.eventsReport = ns:RunEventChecks()
					Refresh()
				end,
			},
			outputEvents = ReportOutput("eventsReport", 16),
			-- API Endpoints
			headerApi = SectionHeader(S.API_TITLE, 20),
			spaceApi = SectionSpacer(21),
			buttonApi = {
				type = "execute",
				name = S.API_BUTTON,
				order = 22,
				hidden = Hidden,
				func = function()
					ns.diagnostics.apiReport = ns:RunApiChecks()
					Refresh()
				end,
			},
			outputApi = ReportOutput("apiReport", 23),
			-- Add-on Context
			headerContext = SectionHeader(S.CONTEXT_TITLE, 25),
			spaceContext = SectionSpacer(26),
			buttonContext = {
				type = "execute",
				name = S.CONTEXT_BUTTON,
				order = 27,
				hidden = Hidden,
				func = function()
					ns.diagnostics.contextReport = ns:BuildContextReport()
					Refresh()
				end,
			},
			outputContext = ReportOutput("contextReport", 28),
			-- Other Add-ons
			headerAddons = SectionHeader(S.ADDONS_TITLE, 30),
			spaceAddons = SectionSpacer(31),
			buttonAddons = {
				type = "execute",
				name = S.ADDONS_BUTTON,
				order = 32,
				hidden = Hidden,
				func = function()
					ns.diagnostics.addonsReport = ns:BuildAddOnReport()
					Refresh()
				end,
			},
			outputAddons = ReportOutput("addonsReport", 33),
			-- Saved Variables
			headerSaved = SectionHeader(S.SAVED_TITLE, 40),
			spaceSaved = SectionSpacer(41),
			buttonSaved = {
				type = "execute",
				name = S.SAVED_BUTTON,
				order = 42,
				hidden = Hidden,
				func = function()
					ns.diagnostics.savedReport = ns:BuildSavedVariablesReport()
					Refresh()
				end,
			},
			outputSaved = ReportOutput("savedReport", 43),
			-- Library Versions
			headerLibs = SectionHeader(S.LIBS_TITLE, 50),
			spaceLibs = SectionSpacer(51),
			buttonLibs = {
				type = "execute",
				name = S.LIBS_BUTTON,
				order = 52,
				hidden = Hidden,
				func = function()
					ns.diagnostics.libsReport = ns:BuildLibraryReport()
					Refresh()
				end,
			},
			outputLibs = ReportOutput("libsReport", 53),
			-- Taint Log
			headerTaint = SectionHeader(S.TAINT_TITLE, 60),
			spaceTaint = SectionSpacer(61),
			descTaintState = {
				type = "description",
				name = function()
					return GetColor("HELP")
						.. string.format(S.TAINT_STATE, ns:GetTaintLogState() == 2 and "On" or "Off")
						.. "|r"
				end,
				fontSize = "medium",
				order = 62,
				hidden = Hidden,
			},
			buttonTaintOn = {
				type = "execute",
				name = S.TAINT_ON,
				order = 63,
				hidden = Hidden,
				func = function()
					ns:SetTaintLog(true)
					Refresh()
				end,
			},
			buttonTaintOff = {
				type = "execute",
				name = S.TAINT_OFF,
				order = 64,
				hidden = Hidden,
				func = function()
					ns:SetTaintLog(false)
					Refresh()
				end,
			},
			descTaintHint = {
				type = "description",
				name = GetColor("HELP") .. S.TAINT_HINT .. "|r",
				fontSize = "medium",
				order = 65,
				hidden = Hidden,
			},
			-- External Tools
			headerTools = SectionHeader(S.TOOLS_TITLE, 70),
			spaceTools = SectionSpacer(71),
			descToolsErrors = {
				type = "description",
				name = GetColor("HELP") .. S.TOOLS_ERRORS .. "|r",
				fontSize = "medium",
				order = 72,
				hidden = Hidden,
			},
			descToolsEtrace = {
				type = "description",
				name = GetColor("HELP") .. S.TOOLS_ETRACE .. "|r",
				fontSize = "medium",
				order = 73,
				hidden = Hidden,
			},
		},
	}
end
