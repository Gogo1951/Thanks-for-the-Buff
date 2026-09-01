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
    AceDB-3.0 owns the SavedVariables lifecycle: it applies ns.DATABASE_DEFAULTS
    itself -- copied into the saved table, an explicit false preserved -- so there
    is no hand-rolled merge and every setting lives under ns.db.profile.
]]

--[[
    A profile switch / copy / reset swaps every user setting at once, so re-seed
    the watched-buff lists (a fresh profile starts empty and seeds from the
    per-flavor default columns in the Data files), bring the Thank You macros in
    line with the incoming profile, and refresh any open options panels off the
    new values. Settings read live from the database update themselves; anything
    applied imperatively, like a macro on the bars, has to be re-applied here.
]]
local function OnProfileChanged()
	if ns.PopulateWatchedBuffs then
		ns.PopulateWatchedBuffs()
	end
	if ns.PopulatePeerPressureWatched then
		ns.PopulatePeerPressureWatched()
	end
	if ns.ReconcileMacros then
		ns.ReconcileMacros()
	end
	local registry = LibStub("AceConfigRegistry-3.0")
	for _, name in pairs(ns.OPTIONS_REGISTRY) do
		registry:NotifyChange(name)
	end
end

local function InitializeDatabase()
	ns.db = LibStub("AceDB-3.0"):New("TFTBDB", ns.DATABASE_DEFAULTS, true)
	ns.db.RegisterCallback(ns, "OnProfileChanged", OnProfileChanged)
	ns.db.RegisterCallback(ns, "OnProfileCopied", OnProfileChanged)
	ns.db.RegisterCallback(ns, "OnProfileReset", OnProfileChanged)
end

--------------------------------------------------------------------------------
-- Event Dispatch
--------------------------------------------------------------------------------

--[[
    The complete list of events the add-on uses. Core owns it, the dispatcher
    registers the frame from it, and Diagnostics reads it -- so the registered
    set, the tap the event log relies on, and the event-registration probe can
    never drift from one another. To use a new event, add it here and attach its
    handler with ns.SetEventHandler; never register a frame anywhere else.
]]
ns.EVENT_NAMES = {
	"PLAYER_LOGIN",
	"PLAYER_ENTERING_WORLD",
	"COMBAT_LOG_EVENT_UNFILTERED",
	"UNIT_SPELLCAST_SENT",
	"UNIT_SPELLCAST_SUCCEEDED",
	"LOADING_SCREEN_DISABLED",
}

--[[
    Every event routes through this one dispatcher, which is what lets the
    diagnostics event log capture everything from a single tap. Attaching the same
    event twice replaces the earlier handler -- one owner per event.
]]
local eventFrame = CreateFrame("Frame")
local eventHandlers = {}

function ns.SetEventHandler(event, handler)
	eventHandlers[event] = handler
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

for _, event in ipairs(ns.EVENT_NAMES) do
	eventFrame:RegisterEvent(event)
end

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

	if ns.SetupPeerPressure then
		ns.SetupPeerPressure()
	end

	if ns.SetupOptions then
		ns.SetupOptions()
	end

	if ns.CreateAutoMacro then
		ns:CreateAutoMacro()
	end
end

local function OnPlayerEnteringWorld()
	if ns.db and ns.db.profile.showWelcome and not welcomeMessageShown then
		ns:PrintMessage(L["CHAT_LOADED"]:format(ns.Version))
		welcomeMessageShown = true
	end
end

ns.SetEventHandler("PLAYER_LOGIN", OnPlayerLogin)
ns.SetEventHandler("PLAYER_ENTERING_WORLD", OnPlayerEnteringWorld)
