local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--[[
    "Wave to Friends" panel. The switch, the rules and the cooldown sit on top;
    below them three tabs: Friends, Guilds, Custom List. The Custom List is still
    checked first, as its own description tells the player; it sits last because
    it is an exceptions list. Friends and Guilds each carry their own emote
    checklist (the same grid Give Thanks uses, under its own grid ID).
    Registered as the builder function, so every repaint lists the current
    guilds and names.
]]

local REMOVE_ICON = "Interface/Buttons/UI-GroupLoot-Pass-Up"

--[[
    A tab's border eats into the pane, so rows inside one spend a slightly
    shorter budget than ns.OPTIONS_ROW_WIDTH or their last cell wraps.
]]
local TAB_ROW_WIDTH = ns.OPTIONS_ROW_WIDTH - 0.2
local TAB_LABEL_WIDTH = TAB_ROW_WIDTH - ns.OPTIONS_CONTROL_WIDTH
local CUSTOM_EMOTE_WIDTH = 1.1
local CUSTOM_NAME_WIDTH = TAB_ROW_WIDTH - CUSTOM_EMOTE_WIDTH - ns.OPTIONS_REMOVE_ICON_WIDTH

local function Settings()
	return ns.db.profile.wave
end

local function Refresh()
	LibStub("AceConfigRegistry-3.0"):NotifyChange(ns.OPTIONS_REGISTRY.WaveToFriends)
end

local function Toggle(key, name, desc, order, width)
	return {
		type = "toggle",
		name = name,
		desc = desc,
		width = width or "full",
		order = order,
		get = function()
			return Settings()[key]
		end,
		set = function(_, value)
			Settings()[key] = value
		end,
	}
end

--[[
    A sub-option row (Build Reference: Sub-Option Rows): an unnamed inline group
    that pins one row, led by a blank cell that indents the control. `hidden`
    sits on the group so the indent collapses with it.
]]
local function SubRow(order, hidden, controls)
	local args = {
		indent = { type = "description", name = "", width = ns.OPTIONS_SUB_INDENT_WIDTH, order = 0 },
	}
	for key, control in pairs(controls) do
		args[key] = control
	end
	return { type = "group", name = "", inline = true, order = order, hidden = hidden, args = args }
end

local function SubLabel(text)
	return GetColor("HELP") .. text .. "|r"
end

-- Several entries in one box: commas, semicolons or new lines split them.
local function SplitEntries(text)
	local entries = {}
	for entry in (text or ""):gmatch("[^,;\n]+") do
		entry = entry:match("^%s*(.-)%s*$")
		if entry ~= "" then
			entries[#entries + 1] = entry
		end
	end
	return entries
end

local function DefaultCustomEmote()
	for _, token in ipairs(Data.WAVE_CUSTOM_DEFAULT_EMOTES) do
		if ns.IsClientEmote(token) then
			return token
		end
	end
	return ""
end

-- The Reset tooltip names the default emotes by the commands this client gives them.
local function ResetDescription(defaults)
	local commands = {}
	for token, picked in pairs(defaults) do
		if picked then
			commands[#commands + 1] = ns.GetEmoteCommand(token)
		end
	end
	table.sort(commands)
	return L["WAVE_EMOTES_RESET_DEFAULTS_DESCRIPTION"]:format(table.concat(commands, ", "))
end

local function SortedRows(list, labelOf)
	local rows = {}
	for key, value in pairs(list or {}) do
		rows[#rows + 1] = { key = key, value = value, label = labelOf(key, value) }
	end
	table.sort(rows, function(a, b)
		return a.label:lower() < b.label:lower()
	end)
	return rows
end

local function RemoveCell(desc, order, func)
	return {
		type = "execute",
		name = "",
		desc = desc,
		image = REMOVE_ICON,
		imageWidth = 16,
		imageHeight = 16,
		width = ns.OPTIONS_REMOVE_ICON_WIDTH,
		order = order,
		func = func,
	}
end

--------------------------------------------------------------------------------
-- Custom List Tab
--------------------------------------------------------------------------------

-- WoW Forever has no realms, so its names are "First Last" (the same test Features/Wave-To-Friends.lua uses).
local REALM_FREE = ns.FLAVOR == "Camelot"

local function BuildCustomTab()
	local namesText = REALM_FREE and L["WAVE_CUSTOM_NAMES_FOREVER"] or L["WAVE_CUSTOM_NAMES_REALM"]
	local addDescription = REALM_FREE and L["WAVE_CUSTOM_ADD_DESCRIPTION_FOREVER"] or L["WAVE_CUSTOM_ADD_DESCRIPTION"]
	local args = {
		desc = ns.OptionsDesc(L["WAVE_CUSTOM_DESCRIPTION"] .. " " .. namesText, 1),
		space1 = ns.OptionsSpacer(2),
		enable = Toggle("customEnabled", L["WAVE_CUSTOM_ENABLE"], L["WAVE_CUSTOM_ENABLE_DESCRIPTION"], 3),
		-- A list switched off looks exactly like a list that never matches, so say so.
		offWarning = ns.OptionsDesc(GetColor("OFF") .. L["WAVE_CUSTOM_OFF_WARNING"] .. "|r", 3.5, function()
			return Settings().customEnabled
		end),
		space2 = ns.OptionsSpacer(4),
		addLabel = ns.OptionsRowLabel(L["WAVE_CUSTOM_ADD"], 5, TAB_LABEL_WIDTH, nil, addDescription),
		add = {
			type = "input",
			name = "",
			desc = addDescription,
			width = ns.OPTIONS_CONTROL_WIDTH,
			order = 5.1,
			get = function()
				return ""
			end,
			set = function(_, value)
				local players = Settings().players
				local emote = DefaultCustomEmote()
				for _, name in ipairs(SplitEntries(value)) do
					local key = ns.NormalizeWaveName(name)
					if key and not players[key] then
						players[key] = { name = name, emote = emote }
					end
				end
				Refresh()
			end,
		},
		space3 = ns.OptionsSpacer(6),
	}

	local players = Settings().players
	local rows = SortedRows(players, function(key, entry)
		return type(entry) == "table" and entry.name or key
	end)

	if #rows == 0 then
		args.empty = ns.OptionsDesc(GetColor("HELP") .. L["WAVE_CUSTOM_EMPTY"] .. "|r", 10)
	end

	local values, sorting = ns.GetEmoteSelectChoices()
	for index, row in ipairs(rows) do
		args["player" .. index] = {
			type = "group",
			name = "",
			inline = true,
			order = 10 + index,
			args = {
				name = {
					type = "description",
					name = GetColor("TEXT") .. row.label .. "|r",
					fontSize = "medium",
					width = CUSTOM_NAME_WIDTH,
					order = 1,
				},
				emote = {
					type = "select",
					name = "",
					desc = L["WAVE_CUSTOM_EMOTE_DESCRIPTION"],
					width = CUSTOM_EMOTE_WIDTH,
					order = 2,
					values = values,
					sorting = sorting,
					get = function()
						local entry = players[row.key]
						local token = type(entry) == "table" and entry.emote or ""
						return ns.IsClientEmote(token) and token or ""
					end,
					set = function(_, token)
						if type(players[row.key]) == "table" then
							players[row.key].emote = token
						end
					end,
				},
				remove = RemoveCell(L["WAVE_CUSTOM_REMOVE"], 3, function()
					players[row.key] = nil
					Refresh()
				end),
			},
		}
	end

	return {
		type = "group",
		name = L["WAVE_TAB_CUSTOM"],
		order = 30,
		args = args,
	}
end

--------------------------------------------------------------------------------
-- Friends Tab
--------------------------------------------------------------------------------

local function BuildFriendsTab()
	local args = {
		enable = Toggle("friendsEnabled", L["WAVE_FRIENDS_ENABLE"], L["WAVE_FRIENDS_ENABLE_DESCRIPTION"], 3),
		bnet = SubRow(4, nil, {
			bnet = Toggle(
				"bnetFriends",
				SubLabel(L["WAVE_BNET_ENABLE"]),
				L["WAVE_BNET_ENABLE_DESCRIPTION"],
				1,
				TAB_ROW_WIDTH - ns.OPTIONS_SUB_INDENT_WIDTH
			),
		}),
		space2 = ns.OptionsSpacer(5),
	}
	ns.DefineEmoteGrid(args, Settings, 10, {
		id = "waveFriends",
		key = "friendEmotes",
		defaults = ns.DATABASE_DEFAULTS.profile.wave.friendEmotes,
		description = L["WAVE_FRIENDS_EMOTES_DESCRIPTION"],
		resetDescription = ResetDescription(ns.DATABASE_DEFAULTS.profile.wave.friendEmotes),
		registry = ns.OPTIONS_REGISTRY.WaveToFriends,
		width = TAB_ROW_WIDTH,
	})
	-- Battle.net Friends and the checklist only matter while Wave at Friends is on; the switch itself stays.
	ns.HideAllExcept(args, function()
		return not Settings().friendsEnabled
	end, { enable = true })
	return {
		type = "group",
		name = L["WAVE_TAB_FRIENDS"],
		order = 10,
		args = args,
	}
end

--------------------------------------------------------------------------------
-- Guilds Tab
--------------------------------------------------------------------------------

local function BuildGuildsTab()
	local args = {
		myGuild = Toggle("myGuildEnabled", L["WAVE_MY_GUILD_ENABLE"], L["WAVE_MY_GUILD_ENABLE_DESCRIPTION"], 3),
		space2 = ns.OptionsSpacer(4),
		addLabel = ns.OptionsRowLabel(L["WAVE_GUILD_ADD"], 5, TAB_LABEL_WIDTH, nil, L["WAVE_GUILD_ADD_DESCRIPTION"]),
		add = {
			type = "input",
			name = "",
			desc = L["WAVE_GUILD_ADD_DESCRIPTION"],
			width = ns.OPTIONS_CONTROL_WIDTH,
			order = 5.1,
			get = function()
				return ""
			end,
			set = function(_, value)
				local guilds = Settings().guilds
				for _, name in ipairs(SplitEntries(value)) do
					local key = ns.NormalizeGuildName(name)
					if key and not guilds[key] then
						guilds[key] = (name:gsub("%s+", " "))
					end
				end
				Refresh()
			end,
		},
		space3 = ns.OptionsSpacer(6),
	}

	local guilds = Settings().guilds
	local rows = SortedRows(guilds, function(key, name)
		return type(name) == "string" and name or key
	end)

	if #rows == 0 then
		args.empty = ns.OptionsDesc(GetColor("HELP") .. L["WAVE_GUILDS_EMPTY"] .. "|r", 10)
	end

	for index, row in ipairs(rows) do
		args["guild" .. index] = {
			type = "group",
			name = "",
			inline = true,
			order = 10 + index * 0.01,
			args = {
				name = {
					type = "description",
					name = GetColor("TEXT") .. "<" .. row.label .. ">|r",
					fontSize = "medium",
					width = TAB_ROW_WIDTH - ns.OPTIONS_REMOVE_ICON_WIDTH,
					order = 1,
				},
				remove = RemoveCell(L["WAVE_GUILD_REMOVE"], 2, function()
					guilds[row.key] = nil
					Refresh()
				end),
			},
		}
	end

	args.space4 = ns.OptionsSpacer(19)
	ns.DefineEmoteGrid(args, Settings, 20, {
		id = "waveGuilds",
		key = "guildEmotes",
		defaults = ns.DATABASE_DEFAULTS.profile.wave.guildEmotes,
		description = L["WAVE_GUILDS_EMOTES_DESCRIPTION"],
		resetDescription = ResetDescription(ns.DATABASE_DEFAULTS.profile.wave.guildEmotes),
		registry = ns.OPTIONS_REGISTRY.WaveToFriends,
		width = TAB_ROW_WIDTH,
	})
	return {
		type = "group",
		name = L["WAVE_TAB_GUILDS"],
		order = 20,
		args = args,
	}
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

local function DefineCooldownSelect(order)
	return {
		type = "select",
		name = "",
		desc = L["WAVE_COOLDOWN_DESCRIPTION"],
		width = ns.OPTIONS_CONTROL_WIDTH,
		order = order,
		sorting = Data.WAVE_COOLDOWN_CHOICES,
		values = function()
			local values = {}
			for _, seconds in ipairs(Data.WAVE_COOLDOWN_CHOICES) do
				values[seconds] = seconds == 0 and L["WAVE_COOLDOWN_ONCE_PER_SESSION"] or ns.FormatDuration(seconds)
			end
			return values
		end,
		get = function()
			local stored = Settings().cooldown
			-- 0 is Once per Session, never the nearest neighbor of a short timer.
			if stored == 0 then
				return 0
			end
			-- The nearest listed timer, so an off-scale saved number never shows an empty box.
			local best, bestGap = nil, nil
			for _, choice in ipairs(Data.WAVE_COOLDOWN_CHOICES) do
				local gap = math.abs(choice - stored)
				if choice ~= 0 and (not bestGap or gap < bestGap) then
					best, bestGap = choice, gap
				end
			end
			return best
		end,
		set = function(_, value)
			Settings().cooldown = value
		end,
	}
end

function ns.BuildWaveToFriendsOptions()
	local options = {
		name = L["TAB_WAVE_TO_FRIENDS"],
		type = "group",
		childGroups = "tab",
		args = {
			descIntro = ns.OptionsDesc(L["WAVE_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),
			enable = ns.OptionsFeatureToggle(ns.GetFeatureSwitch("wave"), 2.5),
			enableSpacer = ns.OptionsSpacer(2.6),

			descRules = ns.OptionsDesc(GetColor("HELP") .. L["WAVE_RULES"] .. "|r", 3),
			space1 = ns.OptionsSpacer(4),
			restingOnly = Toggle("restingOnly", L["WAVE_RESTING_ENABLE"], L["WAVE_RESTING_ENABLE_DESCRIPTION"], 5),
			space2 = ns.OptionsSpacer(6),
			cooldownLabel = ns.OptionsRowLabel(L["WAVE_COOLDOWN"], 7, nil, nil, L["WAVE_COOLDOWN_DESCRIPTION"]),
			cooldown = DefineCooldownSelect(7.1),
			space3 = ns.OptionsSpacer(8),
		},
	}

	-- Intro text and the switch itself stay; everything else follows the switch.
	ns.HideAllExcept(options.args, function()
		return not Settings().enabled
	end, { descIntro = true, space0 = true, enable = true })

	--[[
	    The tabs are left out while the feature is off, not hidden: AceConfigDialog
	    reads a child group's `hidden` against its parent's path when deciding
	    whether to draw the tab frame, so hidden tabs still leave an empty bordered
	    box. Every repaint rebuilds this table, so they return when the switch flips.
	]]
	if Settings().enabled then
		options.args.custom = BuildCustomTab()
		options.args.friends = BuildFriendsTab()
		options.args.guilds = BuildGuildsTab()
	end

	return options
end
