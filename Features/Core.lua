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
    via metatables, so there is no hand-rolled merge and every setting lives under
    ns.db.profile. The two helpers below only bridge older on-disk layouts into
    the profile once; AceDB handles everything else.
]]

--[[
    Overlay saved user values onto the defaults-backed profile. Recurses into
    tables so a value the user set wins while keys they never touched keep their
    default -- this preserves AceDB's default-fill for newly shipped keys, which a
    wholesale subtable assignment would drop.
]]
local function LiftInto(dst, src)
	for key, value in pairs(src) do
		if type(value) == "table" and type(dst[key]) == "table" then
			LiftInto(dst[key], value)
		else
			dst[key] = value
		end
	end
end

--[[
    MIGRATION (remove after 2026-10-05): lift the pre-AceDB flat layout into the
    AceDB profile. Settings used to live at the TFTB_DB root; AceDB now owns the
    root for its own bookkeeping, so those orphaned root keys are copied into the
    shared Default profile once and then removed. Older copies that still hold a
    real AceDB `profiles` table are adopted by AceDB:New directly and never reach
    this path. When the window closes, delete this function and its call.
]]
local function MigrateFlatToProfile()
	local root = TFTB_DB
	if type(root) ~= "table" then
		return
	end
	local profile = ns.db.profile

	local liftKeys = {
		"showWelcome",
		"welcomeMessage",
		"strangers",
		"teammates",
		"services",
		"slash",
		"watchedBuffs",
		"groupBuffs",
	}
	for _, key in ipairs(liftKeys) do
		local value = root[key]
		if value ~= nil then
			if type(value) == "table" and type(profile[key]) == "table" then
				LiftInto(profile[key], value)
			else
				profile[key] = value
			end
			root[key] = nil
		end
	end

	-- Retired scalar, never carried forward.
	root.lastRunVersion = nil
end

--[[
    Field-level cleanups from the flat era, now applied to the profile. Kept until
    their windows close so a user upgrading straight from an older build doesn't
    lose a setting.
]]
local function ApplyFieldMigrations()
	local profile = ns.db.profile

	-- MIGRATION (remove after 2026-09-28): drop the retired tri-state "messaging"
	-- dropdown and the strangers master enable (the print / whisper / emote
	-- toggles are the enable now).
	if type(profile.strangers) == "table" then
		profile.strangers.messaging = nil
		profile.strangers.enabled = nil
	end

	-- MIGRATION (remove after 2026-09-28): renamed welcomeMessage -> showWelcome.
	if profile.welcomeMessage ~= nil then
		profile.showWelcome = profile.welcomeMessage
		profile.welcomeMessage = nil
	end

	-- MIGRATION (remove after 2026-09-28): split the old combined "groupBuffs"
	-- config into independent "Buffs from Teammates" and "Group Services"
	-- settings. Carry the player's old messaging prefs into both and keep their
	-- watched list, so upgrading resets nothing.
	if profile.groupBuffs then
		local old = profile.groupBuffs
		if type(old.watchedBuffs) == "table" then
			profile.watchedBuffs = old.watchedBuffs
		end
		for _, cfg in ipairs({ profile.teammates, profile.services }) do
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
		profile.groupBuffs = nil
	end

	-- MIGRATION (remove after 2027-01-17): the Buff Train and Buffs Given features
	-- were renamed Peer Pressure and Good News. Their saved settings move to the
	-- renamed profile keys so no one loses their toggles or watched lists.
	if type(profile.buffTrain) == "table" then
		LiftInto(profile.peerPressure, profile.buffTrain)
		profile.buffTrain = nil
	end
	if type(profile.buffsGiven) == "table" then
		LiftInto(profile.goodNews, profile.buffsGiven)
		profile.buffsGiven = nil
	end
end

--[[
    A profile switch / copy / reset swaps every user setting at once, so re-seed
    the watched-buff lists (a fresh profile starts empty and seeds from the
    per-flavor default columns in the Data files) and refresh any open options
    panels off the new values.
]]
local function OnProfileChanged()
	if ns.PopulateWatchedBuffs then
		ns.PopulateWatchedBuffs()
	end
	if ns.PopulatePeerPressureWatched then
		ns.PopulatePeerPressureWatched()
	end
	local registry = LibStub("AceConfigRegistry-3.0")
	for _, name in pairs(ns.OPTIONS_REGISTRY) do
		registry:NotifyChange(name)
	end
end

local function InitializeDatabase()
	ns.db = LibStub("AceDB-3.0"):New("TFTB_DB", ns.DATABASE_DEFAULTS, true)
	MigrateFlatToProfile()
	ApplyFieldMigrations()
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
