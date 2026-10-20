local _, ns = ...
local L = ns.L

local GetColor = ns.GetColor

--[[
    "Buff Duty" panel -- the click-to-cast list of group members missing a buff
    you can give (Features/Buff-Window.lua, data in this client's
    Data/{Game}/Buff-Window-Spells-{Game}.lua). The enable switch at the top,
    twinned in the General panel's Features section, is the master; everything
    below it hides while it is off. Each optional row of the window has its
    switch here, Self Buffs and Weapon Buffs included, and so do the two Buff
    Keys' bindings (Features/Buff-Window-Keys.lua); what each buff is offered
    to lives in three sub-panels of this one: Tracked Abilities
    (Options-Buff-Window-Buffs.lua), Self-Buffs
    (Options-Buff-Window-Self-Buffs.lua) and Weapon Buffs
    (Options-Buff-Window-Weapon-Buffs.lua).

    Every window setting's setter ends in ns.RefreshBuffWindow, which rebuilds
    the castable list and redraws the window: none of them is read live by the
    window. The key-binding rows write game bindings instead.
]]

function ns.BuildBuffWindowOptions()
	local function Settings()
		return ns.db.profile.buffWindow
	end
	local function Hidden()
		return not Settings().enabled
	end

	local function Toggle(key, name, desc, order, width)
		return {
			type = "toggle",
			name = name,
			desc = desc,
			width = width or "full",
			order = order,
			hidden = Hidden,
			get = function()
				return Settings()[key]
			end,
			set = function(_, value)
				Settings()[key] = value
				ns.RefreshBuffWindow()
			end,
		}
	end

	--[[
	    The right half of a Buff Key's row: the same binding the game's Key
	    Bindings list shows under Thanks for the Buff, so setting it in either
	    place sets both. A key moved here leaves whatever it did before, and the
	    command's old key is let go. Bindings are locked in combat.
	]]
	local function KeyBinding(command, desc, order)
		return {
			type = "keybinding",
			name = "",
			desc = desc,
			width = ns.OPTIONS_CONTROL_WIDTH,
			order = order,
			hidden = Hidden,
			disabled = function()
				return InCombatLockdown()
			end,
			get = function()
				return GetBindingKey(command)
			end,
			set = function(_, key)
				if InCombatLockdown() then
					return
				end
				for _, old in ipairs({ GetBindingKey(command) }) do
					SetBinding(old)
				end
				if key and key ~= "" then
					SetBinding(key, command)
				end
				SaveBindings(GetCurrentBindingSet())
			end,
		}
	end

	--[[
	    A row under a Buff Key's row: what to put in a macro to press the same
	    key from an action bar, in a read-only box so it can be copied. The box
	    sits under the key button, beside its caption.
	]]
	local function MacroLine(macro, order)
		return {
			label = ns.OptionsRowLabel(GetColor("HELP") .. L["BUFF_KEY_MACRO_CAPTION"] .. "|r", order, nil, Hidden),
			box = {
				type = "input",
				name = "",
				width = ns.OPTIONS_CONTROL_WIDTH,
				order = order + 0.05,
				hidden = Hidden,
				get = function()
					return macro
				end,
				set = function() end,
			},
		}
	end

	local singleMacro = MacroLine(ns.BUFF_KEY_MACROS.SINGLE, 22.2)
	local groupMacro = MacroLine(ns.BUFF_KEY_MACROS.GROUP, 24.2)

	local options = {
		name = L["TAB_BUFF_WINDOW"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["BUFF_WINDOW_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),
			enable = ns.OptionsFeatureToggle(ns.GetFeatureSwitch("buffWindow"), 3),
			--[[
			    A status line, shown only on a class with nothing on the list: the
			    switch above is on, and the window will still never appear.
			]]
			noBuffs = {
				type = "description",
				name = GetColor("HELP") .. L["BUFF_WINDOW_NO_BUFFS"] .. "|r",
				fontSize = "medium",
				order = 4,
				hidden = function()
					return Hidden() or ns.BuffWindowHasClassRows()
				end,
			},
			spaceNote = ns.OptionsSpacer(4.3),
			note = ns.OptionsFeaturesNote(4.6),
			space1 = ns.OptionsSpacer(5, Hidden),

			--[[
			    The window's optional rows, in the order it shows them: your self
			    buffs above the group, the players outside it below.
			]]
			headerShow = ns.OptionsHeader(L["BUFF_WINDOW_SHOW_HEADER"], 6, Hidden),
			space2 = ns.OptionsSpacer(7, Hidden),
			descShow = ns.OptionsDesc(L["BUFF_WINDOW_SHOW_DESCRIPTION"], 7.3, Hidden),
			spaceShow = ns.OptionsSpacer(7.6, Hidden),
			selfEnabled = Toggle(
				"selfEnabled",
				L["BUFF_WINDOW_SELF_ENABLE"],
				L["BUFF_WINDOW_SELF_ENABLE_DESCRIPTION"],
				8
			),
			spaceWeapon = ns.OptionsSpacer(8.3, Hidden),
			weaponEnabled = Toggle(
				"weaponEnabled",
				L["BUFF_WINDOW_WEAPON_ENABLE"],
				L["BUFF_WINDOW_WEAPON_ENABLE_DESCRIPTION"],
				8.6
			),
			space3 = ns.OptionsSpacer(9, Hidden),
			favorEnabled = Toggle(
				"favorEnabled",
				L["BUFF_WINDOW_FAVOR_ENABLE"],
				L["BUFF_WINDOW_FAVOR_ENABLE_DESCRIPTION"],
				10,
				ns.OPTIONS_LABEL_WIDTH
			),
			--[[
			    The toggle and how long a stranger stays listed, on one row; the
			    dropdown appears only while the toggle is on. Labelled with the
			    client's own duration strings, so "1 Minute" reads right in every
			    locale without a string of ours.
			]]
			favorSeconds = {
				type = "select",
				name = "",
				desc = L["BUFF_WINDOW_FAVOR_SECONDS_DESCRIPTION"],
				values = function()
					local values = {}
					for _, seconds in ipairs(ns.Data.BUFF_WINDOW_FAVOR_CHOICES) do
						values[seconds] = ns.FormatDuration(seconds)
					end
					return values
				end,
				sorting = ns.Data.BUFF_WINDOW_FAVOR_CHOICES,
				width = ns.OPTIONS_CONTROL_WIDTH,
				order = 10.1,
				hidden = function()
					return Hidden() or not Settings().favorEnabled
				end,
				get = function()
					return Settings().favorSeconds
				end,
				set = function(_, value)
					Settings().favorSeconds = value
					ns.RefreshBuffWindow()
				end,
			},
			space4 = ns.OptionsSpacer(11, Hidden),
			targetEnabled = Toggle(
				"targetEnabled",
				L["BUFF_WINDOW_TARGET_ENABLE"],
				L["BUFF_WINDOW_TARGET_ENABLE_DESCRIPTION"],
				12
			),
			space5 = ns.OptionsSpacer(13, Hidden),

			headerWindow = ns.OptionsHeader(L["BUFF_WINDOW_HEADER"], 14, Hidden),
			space6 = ns.OptionsSpacer(15, Hidden),
			descWindow = ns.OptionsDesc(L["BUFF_WINDOW_WINDOW_DESCRIPTION"], 15.3, Hidden),
			spaceWindow = ns.OptionsSpacer(15.6, Hidden),
			locked = Toggle("locked", L["BUFF_WINDOW_LOCK"], L["BUFF_WINDOW_LOCK_DESCRIPTION"], 16),
			space7 = ns.OptionsSpacer(17, Hidden),
			hideInCombat = Toggle(
				"hideInCombat",
				L["BUFF_WINDOW_HIDE_IN_COMBAT"],
				L["BUFF_WINDOW_HIDE_IN_COMBAT_DESCRIPTION"],
				18
			),
			space8 = ns.OptionsSpacer(19, Hidden),

			headerKeys = ns.OptionsHeader(L["BUFF_KEYS_HEADER"], 20, Hidden),
			space9 = ns.OptionsSpacer(21, Hidden),
			descKeys = ns.OptionsDesc(L["BUFF_KEYS_DESCRIPTION"], 21.3, Hidden),
			spaceKeys = ns.OptionsSpacer(21.6, Hidden),
			singleKeyLabel = ns.OptionsRowLabel(L["BUFF_KEY_SINGLE"], 22, nil, Hidden),
			singleKey = KeyBinding(ns.BUFF_KEY_COMMANDS.SINGLE, L["BUFF_KEY_SINGLE_DESCRIPTION"], 22.1),
			singleMacroLabel = singleMacro.label,
			singleMacro = singleMacro.box,
			space10 = ns.OptionsSpacer(23, Hidden),
			groupKeyLabel = ns.OptionsRowLabel(L["BUFF_KEY_GROUP"], 24, nil, Hidden),
			groupKey = KeyBinding(ns.BUFF_KEY_COMMANDS.GROUP, L["BUFF_KEY_GROUP_DESCRIPTION"], 24.1),
			groupMacroLabel = groupMacro.label,
			groupMacro = groupMacro.box,
			space11 = ns.OptionsSpacer(25, Hidden),
		},
	}

	return options
end
