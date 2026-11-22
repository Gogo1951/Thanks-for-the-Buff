local ADDON_NAME, ns = ...
-- luacheck: read globals GetPhysicalScreenSize UISpecialFrames

local GetClientHeader = ns.GetDiagnosticClientHeader

--------------------------------------------------------------------------------
-- Display Context
--------------------------------------------------------------------------------

--[[
    Answers "the mini-map button is gone / off-screen" and "hovering the button
    shows nothing" reports: screen size, UI scale, the button's saved placement
    and its Enable Mini-map Button switch, and whether its menu loaded and is
    wired to the button. Read-only.
]]

-- True when Escape's list of frames to close holds the menu (Features/Minimap-Menu.lua).
local function MenuClosesOnEscape()
	local menuName = ADDON_NAME .. "Menu"
	for _, name in ipairs(type(UISpecialFrames) == "table" and UISpecialFrames or {}) do
		if name == menuName then
			return true
		end
	end
	return false
end

function ns:BuildDisplayContextReport()
	local lines = { GetClientHeader(), "" }

	local width, height = GetPhysicalScreenSize()
	lines[#lines + 1] = string.format("Physical screen size: %s x %s", tostring(width), tostring(height))
	lines[#lines + 1] = string.format("UIParent scale: %s", tostring(UIParent and UIParent:GetScale()))
	lines[#lines + 1] = string.format("uiScale CVar: %s", tostring(GetCVar("uiScale")))

	lines[#lines + 1] = ""
	local LibDBIcon = LibStub("LibDBIcon-1.0")
	local button = LibDBIcon:GetMinimapButton(ADDON_NAME)
	-- Without the data object, login never registers a button.
	lines[#lines + 1] = string.format("Data broker object: %s", ns.dataBrokerObject and "present" or "MISSING")
	lines[#lines + 1] = string.format("Minimap button created: %s", button and "yes" or "no")
	if button then
		lines[#lines + 1] = string.format(
			"Minimap button shown: %s, visible: %s",
			tostring(button:IsShown() and true or false),
			tostring(button:IsVisible() and true or false)
		)
	end

	-- The Enable Mini-map Button switch on the General panel is this hide flag, inverted.
	local minimap = ns.db and ns.db.profile.minimap
	if type(minimap) == "table" then
		lines[#lines + 1] = string.format("Minimap button hidden: %s", tostring(minimap.hide or false))
		lines[#lines + 1] = string.format("Minimap saved angle: %s", tostring(minimap.minimapPos))
	else
		lines[#lines + 1] = "Minimap saved position: (none yet)"
	end

	--[[
	    Hovering the button opens the menu, and a click runs the menu's click
	    table; both go through ns.minimapMenu, which returns early until the
	    database is open. A TOC missing the menu's files leaves it nil and the
	    hover does nothing.
	]]
	local broker = ns.dataBrokerObject
	lines[#lines + 1] = ""
	lines[#lines + 1] = string.format(
		"Menu loaded: %s, database open: %s",
		type(ns.minimapMenu) == "table" and "yes" or "MISSING",
		ns.db and "yes" or "no"
	)
	lines[#lines + 1] = string.format(
		"Button hover opens menu: %s, click runs menu clicks: %s",
		tostring(type(broker) == "table" and type(broker.OnEnter) == "function"),
		tostring(type(broker) == "table" and type(broker.OnClick) == "function" and type(ns.minimapMenu) == "table")
	)
	lines[#lines + 1] = string.format(
		"Menu open now: %s, closes on Escape: %s",
		tostring(type(ns.IsMenuShown) == "function" and ns.IsMenuShown() or false),
		tostring(MenuClosesOnEscape())
	)
	lines[#lines + 1] = string.format("Feature rows: %d", #(ns.FEATURES or {}))

	--[[
	    Where a dragged position lives, link by link: LibDBIcon's drag handler
	    computes the angle with math.atan2 every frame and writes it into the
	    button's db, which has to be the very table AceDB saves, and the raw
	    SavedVariables value is what the client writes at logout.
	]]
	lines[#lines + 1] = ""
	lines[#lines + 1] = string.format("math.atan2 present: %s", tostring(type(math.atan2) == "function"))
	lines[#lines + 1] = string.format("LibDBIcon-1.0 minor: %s", tostring(LibStub.minors["LibDBIcon-1.0"]))
	if button then
		lines[#lines + 1] = string.format("Button db present: %s", tostring(button.db ~= nil))
		lines[#lines + 1] = string.format(
			"Button db is ns.db.profile.minimap: %s",
			tostring(button.db ~= nil and minimap ~= nil and button.db == minimap)
		)
		lines[#lines + 1] = string.format("Button db.minimapPos: %s", tostring(button.db and button.db.minimapPos))
	end
	local saved = _G[ns.SAVED_VARIABLES_NAME]
	local profileName = ns.db and ns.db:GetCurrentProfile() or "Default"
	local savedProfiles = type(saved) == "table" and saved.profiles
	local savedProfile = type(savedProfiles) == "table" and savedProfiles[profileName]
	local savedMinimap = type(savedProfile) == "table" and savedProfile.minimap
	lines[#lines + 1] = string.format(
		"%s.profiles[%q].minimap.minimapPos: %s",
		ns.SAVED_VARIABLES_NAME,
		profileName,
		tostring(type(savedMinimap) == "table" and savedMinimap.minimapPos or nil)
	)

	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Other Add-ons
--------------------------------------------------------------------------------

function ns:BuildAddOnReport()
	local lines = { GetClientHeader(), "" }
	local count = C_AddOns.GetNumAddOns()
	for index = 1, count do
		local name, _, _, loadable = C_AddOns.GetAddOnInfo(index)
		local version = C_AddOns.GetAddOnMetadata(index, "Version") or "?"
		lines[#lines + 1] = string.format("%s v%s [%s]", name, version, loadable and "loadable" or "disabled")
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Saved Variables
--------------------------------------------------------------------------------

local function DumpTable(value, indent, depth, lines)
	if depth > 8 then
		lines[#lines + 1] = indent .. "<max depth>"
		return
	end
	local keys = {}
	for key in pairs(value) do
		keys[#keys + 1] = key
	end
	table.sort(keys, function(a, b)
		return tostring(a) < tostring(b)
	end)
	for _, key in ipairs(keys) do
		local entry = value[key]
		if type(entry) == "table" then
			lines[#lines + 1] = indent .. tostring(key) .. " = {"
			DumpTable(entry, indent .. "    ", depth + 1, lines)
			lines[#lines + 1] = indent .. "}"
		else
			lines[#lines + 1] = indent .. tostring(key) .. " = " .. tostring(entry)
		end
	end
end

--[[
    Dumps the single AceDB-managed table (profiles, profileKeys, char, global)
    so a player can paste their exact configuration: every setting each
    profile has saved (AceDB fills the rest in from the defaults, which the
    context reports print as read), every Give Thanks switch, throttle,
    whisper box and emote pick, every Thank You button's text, icon and
    emotes, every Good News switch, its text and each ability unticked, every
    Wave to Friends switch, guild, name and emote, the Buff Back switch and
    each character's buff and target, the mini-map button's place and switch,
    and every Ignored Buffs row in both scopes.
]]
function ns:BuildSavedVariablesReport()
	local lines = { GetClientHeader(), "", ns.SAVED_VARIABLES_NAME .. " = {" }
	DumpTable(_G[ns.SAVED_VARIABLES_NAME] or {}, "    ", 1, lines)
	lines[#lines + 1] = "}"
	return table.concat(lines, "\n")
end
