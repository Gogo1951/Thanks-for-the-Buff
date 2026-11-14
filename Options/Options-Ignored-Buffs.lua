local _, ns = ...
local L = ns.L

local GetColor = ns.GetColor

--[[
    "Ignored Buffs", a sub-panel of Give Thanks: the buffs that never get a
    thank-you, laid out like Magic Eraser's Erase List. childGroups = "tree"
    splits the panel in two, with the scope list on the left (All Characters,
    then the characters) and the selected scope's buffs on the right. Each scope
    group closes over its own scope key, so the add controls and the row buttons
    in a pane always act on the list the player is looking at, including another
    character's. The lists themselves live in Features/Ignored-Buffs.lua.

    A buff is a spell, not an item, so each pane keeps this panel's own shape:
    an add-from-what-you-have select first, since a player rarely knows a spell
    ID, then the add box, then one row per buff, sorted by name, with a promote
    button (character panes only) and a remove icon. Registered as the builder
    function so every repaint lists the current buffs and characters.
]]

local REMOVE_ICON = "Interface/Buttons/UI-GroupLoot-Pass-Up"

local function Refresh()
	LibStub("AceConfigRegistry-3.0"):NotifyChange(ns.OPTIONS_REGISTRY.IgnoredBuffs)
end

-- "|T icon:16|t Name" in the spell-link blue, or nil for an ID this client doesn't have.
local function SpellLabel(spellId)
	local name = C_Spell.GetSpellName(spellId)
	if not name then
		return nil
	end
	local icon = C_Spell.GetSpellTexture(spellId)
	local picture = icon and ("|T" .. icon .. ":16|t ") or ""
	return picture .. "|cff" .. ns.SPELL_LINK_COLOR .. name .. "|r", name
end

-- A typed spell ID or a shift-clicked spell link; nil for anything else.
local function ParseSpellId(text)
	text = (text or ""):match("^%s*(.-)%s*$")
	local fromLink = text:match("|Hspell:(%d+)")
	return tonumber(fromLink or text)
end

local function BuildScopeArgs(scopeKey)
	local isGlobalScope = scopeKey == ns.LIST_SCOPE_GLOBAL
	-- The tree sidebar takes its share first, so a pane spends the shorter tree budget.
	local rowWidth = ns.OPTIONS_TREE_ROW_WIDTH
	local labelWidth = rowWidth - ns.OPTIONS_CONTROL_WIDTH

	local function List()
		return ns.GetIgnoredBuffsForScope(scopeKey) or {}
	end

	-- A buff All Characters already ignores is a row that could change nothing here.
	local function AlreadyCovered(spellId)
		if List()[spellId] then
			return true
		end
		local globalList = ns.GetIgnoredBuffsForScope(ns.LIST_SCOPE_GLOBAL)
		return (not isGlobalScope and globalList and globalList[spellId]) and true or false
	end

	local function Add(spellId)
		if spellId and C_Spell.GetSpellName(spellId) then
			if not AlreadyCovered(spellId) then
				ns.SetBuffIgnoredInScope(scopeKey, spellId, true)
			end
			Refresh()
			return true
		end
		return false
	end

	--[[
	    The picker's choices and their order: the buffs on you now, then the ones
	    strangers gave you this session that have since worn off, newest first,
	    each naming who cast it in their class color.
	]]
	local function RecentChoices()
		local values, order = {}, {}
		local function Offer(spellId, label)
			if label and not values[spellId] and not AlreadyCovered(spellId) then
				values[spellId] = label
				order[#order + 1] = spellId
			end
		end
		for _, spellId in ipairs(ns.GetPlayerBuffIds()) do
			Offer(spellId, (SpellLabel(spellId)))
		end
		for _, recent in ipairs(ns.GetRecentBuffs()) do
			local label = SpellLabel(recent.spellId)
			if label then
				local hex = recent.classToken and ns.Data.CLASS_COLORS[recent.classToken]
				local caster = hex and ("|cff" .. hex .. recent.name .. "|r") or recent.name
				Offer(recent.spellId, L["IGNORED_BUFFS_RECENT_FROM"]:format(label, caster))
			end
		end
		return values, order
	end

	local args = {
		addRecentLabel = ns.OptionsRowLabel(
			L["IGNORED_BUFFS_ADD_RECENT"],
			3,
			labelWidth,
			nil,
			L["IGNORED_BUFFS_ADD_RECENT_DESCRIPTION"]
		),
		addRecent = {
			type = "select",
			name = "",
			desc = L["IGNORED_BUFFS_ADD_RECENT_DESCRIPTION"],
			width = ns.OPTIONS_CONTROL_WIDTH,
			order = 3.1,
			values = function()
				return (RecentChoices())
			end,
			sorting = function()
				return select(2, RecentChoices())
			end,
			get = function()
				return nil
			end,
			set = function(_, spellId)
				Add(spellId)
			end,
		},

		addLabel = ns.OptionsRowLabel(L["IGNORED_BUFFS_ADD"], 5, labelWidth, nil, L["IGNORED_BUFFS_ADD_DESCRIPTION"]),
		add = {
			type = "input",
			name = "",
			desc = L["IGNORED_BUFFS_ADD_DESCRIPTION"],
			width = ns.OPTIONS_CONTROL_WIDTH,
			order = 5.1,
			-- Returns "" so the box clears itself after each add.
			get = function()
				return ""
			end,
			set = function(_, value)
				if (value or ""):match("^%s*(.-)%s*$") == "" then
					return
				end
				if not Add(ParseSpellId(value)) then
					ns:PrintMessage(L["IGNORED_BUFFS_NOT_FOUND"]:format(value))
				end
			end,
		},
		space2 = ns.OptionsSpacer(6),
	}

	-- One row per ignored buff, by name: a list ordered by ID reads as random.
	local rows = {}
	for spellId in pairs(List()) do
		local label, name = SpellLabel(spellId)
		rows[#rows + 1] = { id = spellId, label = label or tostring(spellId), name = name or tostring(spellId) }
	end
	table.sort(rows, function(a, b)
		return a.name < b.name
	end)

	if #rows == 0 then
		args.empty = ns.OptionsDesc(GetColor("HELP") .. L["IGNORED_BUFFS_EMPTY"] .. "|r", 10)
	end

	--[[
	    The All Characters pane has nowhere to promote to, so its spell cell
	    absorbs that column and the remove icon stays put as scopes are picked.
	]]
	local spellWidth = rowWidth - ns.OPTIONS_REMOVE_ICON_WIDTH
	if not isGlobalScope then
		spellWidth = spellWidth - ns.OPTIONS_PROMOTE_WIDTH
	end

	for index, row in ipairs(rows) do
		local cells = {
			spell = {
				type = "description",
				name = row.label,
				fontSize = "medium",
				width = spellWidth,
				order = 1,
			},
			remove = {
				type = "execute",
				name = "",
				desc = L["IGNORED_BUFFS_REMOVE"],
				image = REMOVE_ICON,
				imageWidth = 16,
				imageHeight = 16,
				width = ns.OPTIONS_REMOVE_ICON_WIDTH,
				order = 3,
				func = function()
					ns.SetBuffIgnoredInScope(scopeKey, row.id, false)
					Refresh()
				end,
			},
		}
		--[[
		    Promote, not copy: the account-wide add clears the buff off every
		    character's list itself, so the row leaves this pane and turns up
		    under All Characters instead.
		]]
		if not isGlobalScope then
			cells.promote = {
				type = "execute",
				name = L["IGNORED_BUFFS_ALL_CHARACTERS"],
				desc = L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"],
				width = ns.OPTIONS_PROMOTE_WIDTH,
				order = 2,
				func = function()
					ns.SetBuffIgnoredInScope(ns.LIST_SCOPE_GLOBAL, row.id, true)
					Refresh()
				end,
			}
		end
		args["buff" .. row.id] = {
			type = "group",
			name = "",
			inline = true,
			order = 10 + index,
			args = cells,
		}
	end

	args.spacerTop = ns.OptionsSpacer(2)

	return args
end

--[[
    The description lives on the root group, not in the scope panes: a tree
    group renders its own non-group args once, full width, above the tree, so
    the copy reads once instead of repeating in every pane.

    Scope groups are keyed by scope, not by position: the tree remembers the
    selected node by its arg key, so a key that moved when a character appeared
    or dropped out would silently reselect a different character.
]]
function ns.BuildIgnoredBuffsOptions()
	local function ScopeGroup(name, order, scopeKey)
		return {
			type = "group",
			name = name,
			order = order,
			args = BuildScopeArgs(scopeKey),
		}
	end

	local args = {
		descIntro = ns.OptionsDesc(L["IGNORED_BUFFS_DESCRIPTION"], 1),
		spacerIntro = ns.OptionsSpacer(2),
	}

	args[ns.LIST_SCOPE_GLOBAL] = ScopeGroup(L["IGNORED_BUFFS_ALL_CHARACTERS"], 3, ns.LIST_SCOPE_GLOBAL)

	-- A blank, unclickable row between All Characters and the characters.
	args.spacerCharacters = {
		type = "group",
		name = " ",
		order = 4,
		disabled = true,
		args = {},
	}

	if ns.db then
		local currentCharacter = ns.db.keys.char
		local order = 10
		for _, charKey in ipairs(ns.GetCharacterKeys()) do
			--[[
			    A character with an empty list is noise in the tree, so it is left
			    out -- except the character playing right now, whose list has to be
			    reachable to put a first buff in it.
			]]
			local list = ns.GetIgnoredBuffsForScope(charKey)
			if charKey == currentCharacter or (list and next(list) ~= nil) then
				args[charKey] = ScopeGroup(ns.GetCharacterDisplayName(charKey), order, charKey)
				order = order + 1
			end
		end
	end

	return {
		name = L["TAB_IGNORED_BUFFS"],
		type = "group",
		childGroups = "tree",
		args = args,
	}
end

--[[
    Seeds the tree's status before it is first drawn: treewidth sizes the tree
    (AceGUI fills it in only when absent, so this wins, while a drag on the
    splitter still overwrites it), and selected opens it on the character being
    played -- set again every time the panel hides, so each visit starts there.
]]
function ns.PrepareIgnoredBuffsTree(panel)
	local status = LibStub("AceConfigDialog-3.0"):GetStatusTable(ns.OPTIONS_REGISTRY.IgnoredBuffs)
	status.groups = status.groups or {}
	status.groups.treewidth = ns.OPTIONS_TREE_WIDTH
	status.groups.selected = ns.db.keys.char

	if panel then
		panel:HookScript("OnHide", function()
			status.groups.selected = ns.db.keys.char
		end)
	end
end
