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

local function SectionHeader(text, order)
    return {type = "header", name = GetColor("TITLE") .. text .. "|r", order = order, hidden = Hidden}
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
        set = function()
        end
    }
end

function ns.BuildDiagnosticsOptions()
    return {
        name = S.TAB,
        type = "group",
        args = {
            descWarning = {type = "description", name = S.WARNING, fontSize = "medium", order = 1},
            spaceEnable = {type = "description", name = " ", order = 2},
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
                end
            },
            -- Event Log
            headerEventLog = SectionHeader(S.EVENT_LOG_TITLE, 5),
            buttonStartLog = {
                type = "execute",
                name = S.EVENT_LOG_START,
                order = 6,
                hidden = Hidden,
                func = function()
                    ns:StartEventLog()
                end
            },
            buttonStopLog = {
                type = "execute",
                name = S.EVENT_LOG_STOP,
                order = 7,
                hidden = Hidden,
                func = function()
                    ns:StopEventLog()
                end
            },
            buttonShowLog = {
                type = "execute",
                name = S.EVENT_LOG_SHOW,
                order = 8,
                hidden = Hidden,
                func = function()
                    ns.diagnostics.eventLogReport = ns:BuildEventLogReport()
                    Refresh()
                end
            },
            outputEventLog = ReportOutput("eventLogReport", 9),
            descEventLogHint = {type = "description", name = S.EVENT_LOG_HINT, fontSize = "medium", order = 10, hidden = Hidden},
            -- Event Registration
            headerEvents = SectionHeader(S.EVENTS_TITLE, 13),
            buttonEvents = {
                type = "execute",
                name = S.EVENTS_BUTTON,
                order = 14,
                hidden = Hidden,
                func = function()
                    ns.diagnostics.eventsReport = ns:RunEventChecks()
                    Refresh()
                end
            },
            outputEvents = ReportOutput("eventsReport", 15),
            -- API Endpoints
            headerApi = SectionHeader(S.API_TITLE, 20),
            buttonApi = {
                type = "execute",
                name = S.API_BUTTON,
                order = 21,
                hidden = Hidden,
                func = function()
                    ns.diagnostics.apiReport = ns:RunApiChecks()
                    Refresh()
                end
            },
            outputApi = ReportOutput("apiReport", 22),
            -- Add-on Context
            headerContext = SectionHeader(S.CONTEXT_TITLE, 25),
            buttonContext = {
                type = "execute",
                name = S.CONTEXT_BUTTON,
                order = 26,
                hidden = Hidden,
                func = function()
                    ns.diagnostics.contextReport = ns:BuildContextReport()
                    Refresh()
                end
            },
            outputContext = ReportOutput("contextReport", 27),
            -- Other Add-ons
            headerAddons = SectionHeader(S.ADDONS_TITLE, 30),
            buttonAddons = {
                type = "execute",
                name = S.ADDONS_BUTTON,
                order = 31,
                hidden = Hidden,
                func = function()
                    ns.diagnostics.addonsReport = ns:BuildAddOnReport()
                    Refresh()
                end
            },
            outputAddons = ReportOutput("addonsReport", 32),
            -- Saved Variables
            headerSaved = SectionHeader(S.SAVED_TITLE, 40),
            buttonSaved = {
                type = "execute",
                name = S.SAVED_BUTTON,
                order = 41,
                hidden = Hidden,
                func = function()
                    ns.diagnostics.savedReport = ns:BuildSavedVariablesReport()
                    Refresh()
                end
            },
            outputSaved = ReportOutput("savedReport", 42),
            -- Library Versions
            headerLibs = SectionHeader(S.LIBS_TITLE, 50),
            buttonLibs = {
                type = "execute",
                name = S.LIBS_BUTTON,
                order = 51,
                hidden = Hidden,
                func = function()
                    ns.diagnostics.libsReport = ns:BuildLibraryReport()
                    Refresh()
                end
            },
            outputLibs = ReportOutput("libsReport", 52),
            -- Taint Log
            headerTaint = SectionHeader(S.TAINT_TITLE, 60),
            descTaintState = {
                type = "description",
                name = function()
                    return string.format(S.TAINT_STATE, ns:GetTaintLogState() == 2 and "On" or "Off")
                end,
                fontSize = "medium",
                order = 61,
                hidden = Hidden
            },
            buttonTaintOn = {
                type = "execute",
                name = S.TAINT_ON,
                order = 62,
                hidden = Hidden,
                func = function()
                    ns:SetTaintLog(true)
                    Refresh()
                end
            },
            buttonTaintOff = {
                type = "execute",
                name = S.TAINT_OFF,
                order = 63,
                hidden = Hidden,
                func = function()
                    ns:SetTaintLog(false)
                    Refresh()
                end
            },
            descTaintHint = {type = "description", name = S.TAINT_HINT, fontSize = "medium", order = 64, hidden = Hidden},
            -- External Tools
            headerTools = SectionHeader(S.TOOLS_TITLE, 70),
            descToolsErrors = {type = "description", name = S.TOOLS_ERRORS, fontSize = "medium", order = 71, hidden = Hidden},
            descToolsEtrace = {type = "description", name = S.TOOLS_ETRACE, fontSize = "medium", order = 72, hidden = Hidden}
        }
    }
end
