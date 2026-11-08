local ADDON_NAME, ns = ...
local L = ns.L

--------------------------------------------------------------------------------
-- Version
--------------------------------------------------------------------------------

local function GetVersion()
	local version = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version")
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
    A profile switch / copy / reset swaps every user setting at once, so bring
    the Thank You macros in line with the incoming profile and refresh any open
    options panels off the new values. Settings read live from the database update
    themselves; anything applied imperatively, like a macro on the bars, has to
    be re-applied here.
]]
local function OnProfileChanged()
	if ns.ReconcileMacros then
		ns.ReconcileMacros()
	end
	local registry = LibStub("AceConfigRegistry-3.0")
	for _, name in pairs(ns.OPTIONS_REGISTRY) do
		registry:NotifyChange(name)
	end
end

--[[
    Characters from another game version, dropped without a word. AceDB keys
    a character "Name - Realm" on realm clients and "First Last" on the
    realm-free ones (WoW Forever), so a saved key shaped the other way from
    the one being played came from a copied WTF folder: its char section,
    its profile choice and, unless someone still uses it, its own profile go.
]]
local REALM_KEY_SEPARATOR = " - "

---@param characterKey any
---@param realmClient boolean
---@return boolean
local function IsOtherClientKey(characterKey, realmClient)
	if type(characterKey) ~= "string" then
		return true
	end
	return (characterKey:find(REALM_KEY_SEPARATOR, 1, true) ~= nil) ~= realmClient
end

---@param sv table # the saved table, or one of its namespaces
---@param realmClient boolean
---@param profilesInUse table<string, boolean>
---@return nil
local function PruneSavedTable(sv, realmClient, profilesInUse)
	local pruned = {}
	for _, section in ipairs({ "char", "profileKeys" }) do
		local characters = sv[section]
		if type(characters) == "table" then
			for characterKey in pairs(characters) do
				if IsOtherClientKey(characterKey, realmClient) then
					characters[characterKey] = nil
					pruned[characterKey] = true
				end
			end
		end
	end
	if type(sv.profiles) == "table" then
		for characterKey in pairs(pruned) do
			if not profilesInUse[characterKey] then
				sv.profiles[characterKey] = nil
			end
		end
	end
end

---@return nil
local function PruneOtherClientCharacters()
	local currentKey = ns.db.keys and ns.db.keys.char
	local sv = ns.db.sv
	if type(currentKey) ~= "string" or type(sv) ~= "table" then
		return
	end
	local realmClient = currentKey:find(REALM_KEY_SEPARATOR, 1, true) ~= nil
	local profilesInUse = { [ns.db.keys.profile or ""] = true }
	for characterKey, profileName in pairs(sv.profileKeys or {}) do
		if not IsOtherClientKey(characterKey, realmClient) then
			profilesInUse[profileName] = true
		end
	end
	PruneSavedTable(sv, realmClient, profilesInUse)
	for _, namespace in pairs(sv.namespaces or {}) do
		if type(namespace) == "table" then
			PruneSavedTable(namespace, realmClient, profilesInUse)
		end
	end
end

--[[
    Bumped when a release starts every player over from the defaults. A saved
    table stamped with any other value is thrown away whole before AceDB reads
    it, without a word in chat. AceDB leaves a top-level key it doesn't manage
    alone, so the stamp survives every logout.
]]
local SETTINGS_RESET = 2

local function InitializeDatabase()
	if type(TFTBDB) ~= "table" or TFTBDB.settingsReset ~= SETTINGS_RESET then
		TFTBDB = { settingsReset = SETTINGS_RESET }
	end
	ns.db = LibStub("AceDB-3.0"):New("TFTBDB", ns.DATABASE_DEFAULTS, true)
	PruneOtherClientCharacters()
	-- Saved every login so the Ignored Buffs tree can color any character by class.
	local _, classToken = UnitClass("player")
	ns.db.char.classToken = classToken or false
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
	"LOADING_SCREEN_DISABLED",
}

--[[
    Forever has no combat log, and registering COMBAT_LOG_EVENT_UNFILTERED there
    errors, so it reads buffs on you from UNIT_AURA instead.
]]
if ns.FLAVOR == "Camelot" then
	table.insert(ns.EVENT_NAMES, "UNIT_AURA")
else
	table.insert(ns.EVENT_NAMES, "COMBAT_LOG_EVENT_UNFILTERED")
end

--[[
    Unit events the add-on only ever needs for these units register with
    RegisterUnitEvent, so the client never wakes the dispatcher for every
    nameplate and raid member. Every other event registers unfiltered.
]]
ns.EVENT_UNITS = {
	UNIT_AURA = { "player" },
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
	local units = ns.EVENT_UNITS[event]
	if units then
		eventFrame:RegisterUnitEvent(event, unpack(units))
	else
		eventFrame:RegisterEvent(event)
	end
end

--------------------------------------------------------------------------------
-- Lifecycle
--------------------------------------------------------------------------------

--[[
    The login sequence owns ordering: the saved variables must exist before any
    feature reads them or any panel registers (the Profiles panel binds to ns.db).
    Feature logic lives in the feature modules; Core only calls their setup hooks
    in the right order.
]]
local function OnPlayerLogin()
	InitializeDatabase()

	if ns.RegisterOptionsPanels then
		ns.RegisterOptionsPanels()
	end

	if ns.SetupBuffTracking then
		ns.SetupBuffTracking()
	end

	if ns.CreateAutoMacro then
		ns:CreateAutoMacro()
	end
end

-- Once per session: PLAYER_ENTERING_WORLD refires on every loading screen.
local welcomeMessageShown = false

function ns.PrintWelcome()
	if not ns.db.profile.showWelcome or welcomeMessageShown then
		return
	end
	ns:PrintMessage(L["CHAT_LOADED"]:format(ns.Version))
	welcomeMessageShown = true
end

local function OnPlayerEnteringWorld()
	if ns.db then
		ns.PrintWelcome()
	end
end

ns.SetEventHandler("PLAYER_LOGIN", OnPlayerLogin)
ns.SetEventHandler("PLAYER_ENTERING_WORLD", OnPlayerEnteringWorld)
