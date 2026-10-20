local ADDON_NAME, ns = ...

local GetClientHeader = ns.GetDiagnosticClientHeader

--------------------------------------------------------------------------------
-- Display Context
--------------------------------------------------------------------------------

--[[
    Answers "the Buff Window or mini-map button is gone / off-screen" reports:
    screen size, UI scale, and the window's saved placement against the screen
    it has now. The
    window saves its top-left corner in UIParent's coordinates, measured from
    the bottom-left, so a corner outside UIParent's size was saved on a bigger
    screen or a smaller UI scale. Read-only.
]]
function ns:BuildDisplayContextReport()
	local lines = { GetClientHeader(), "" }

	local width, height = _G.GetPhysicalScreenSize()
	lines[#lines + 1] = string.format("Physical screen size: %s x %s", tostring(width), tostring(height))
	lines[#lines + 1] = string.format("UIParent scale: %s", tostring(UIParent and UIParent:GetScale()))
	lines[#lines + 1] = string.format("uiScale CVar: %s", tostring(GetCVar("uiScale")))
	lines[#lines + 1] = string.format("useUiScale CVar: %s", tostring(GetCVar("useUiScale")))

	local uiWidth, uiHeight = UIParent:GetWidth(), UIParent:GetHeight()
	lines[#lines + 1] = string.format("UIParent size: %.1f x %.1f", uiWidth, uiHeight)

	lines[#lines + 1] = ""
	local db = ns.db and ns.db.profile.buffWindow
	if not db then
		lines[#lines + 1] = "Buff Window: (database not loaded)"
		return table.concat(lines, "\n")
	end
	local point = db.point
	if type(point) == "table" then
		local left, top = tonumber(point[1]), tonumber(point[2])
		local onScreen = left and top and left >= 0 and left <= uiWidth and top >= 0 and top <= uiHeight
		lines[#lines + 1] = string.format(
			"Buff Window saved top-left: %s, %s (%s)",
			tostring(point[1]),
			tostring(point[2]),
			onScreen and "on screen" or "OFF SCREEN"
		)
	else
		lines[#lines + 1] =
			"Buff Window saved top-left: (never dragged; default, a little left of and above the middle)"
	end
	lines[#lines + 1] = string.format(
		"Buff Window: enabled=%s locked=%s hideInCombat=%s",
		tostring(db.enabled),
		tostring(db.locked),
		tostring(db.hideInCombat)
	)

	--[[
	    The mini-map button: whether it was built, whether Enable Mini-map
	    Button hid it, and whether it still points at the active profile's
	    table, which is where a dragged position is saved.
	]]
	lines[#lines + 1] = ""
	local button = LibStub("LibDBIcon-1.0"):GetMinimapButton(ADDON_NAME)
	local minimap = ns.db.profile.minimap
	lines[#lines + 1] = string.format("Data broker object: %s", ns.dataBrokerObject and "present" or "MISSING")
	lines[#lines + 1] = string.format("Minimap button created: %s", button and "yes" or "no")
	lines[#lines + 1] = string.format(
		"Minimap button hidden: %s  saved angle: %s",
		tostring(minimap.hide or false),
		tostring(minimap.minimapPos)
	)
	if button then
		lines[#lines + 1] = string.format("Button db is ns.db.profile.minimap: %s", tostring(button.db == minimap))
	end

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
    Dumps the single AceDB-managed table (profiles, profileKeys, global) so a
    player can paste their exact configuration: every setting in each profile,
    every watched-buff, Good News and Peer Pressure choice, every Buff Window
    audience, tank, self-buff and weapon choice and its saved position, every
    Thank You button's text, icon and emotes, and the welcome message's last
    version. The Buff Keys' bindings are the game's, not saved here: Buff
    Window Context reads them.
]]
function ns:BuildSavedVariablesReport()
	local lines = { GetClientHeader(), "", ns.SAVED_VARIABLES_NAME .. " = {" }
	DumpTable(_G[ns.SAVED_VARIABLES_NAME] or {}, "    ", 1, lines)
	lines[#lines + 1] = "}"
	return table.concat(lines, "\n")
end
