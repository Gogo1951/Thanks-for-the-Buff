local _, ns = ...
local Data = ns.Data
local L = ns.L
local Kit = ns.OptionsKit

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
    shorter budget than Kit.ROW_WIDTH or their last cell wraps.
]]
local TAB_ROW_WIDTH = Kit.ROW_WIDTH - 0.2
local TAB_LABEL_WIDTH = TAB_ROW_WIDTH - Kit.CONTROL_WIDTH
local CUSTOM_EMOTE_WIDTH = 1.1
local CUSTOM_NAME_WIDTH = TAB_ROW_WIDTH - CUSTOM_EMOTE_WIDTH - Kit.REMOVE_ICON_WIDTH

local function Settings()
	return ns.db.profile.wave
end

local function Toggle(key, name, desc, order, width)
	return {
		type = "toggle",
		name = name,
		desc = desc,
		width = width or "full",
		order = order,
		get = Kit.Get("profile", "wave." .. key),
		set = Kit.Set("profile", "wave." .. key),
	}
end

-- A caption and its control inside a tab, on the tab's shorter budget.
local function TabLabelRow(order, caption, control)
	control.name = ""
	control.width = Kit.CONTROL_WIDTH
	return Kit.Row(order, nil, { Kit.Label(caption, nil, TAB_LABEL_WIDTH, control.desc), control })
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
		width = Kit.REMOVE_ICON_WIDTH,
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
		desc = Kit.Desc(L["WAVE_CUSTOM_DESCRIPTION"] .. " " .. namesText, 1),
		space1 = Kit.Spacer(2),
		enable = Toggle("customEnabled", L["WAVE_CUSTOM_ENABLE"], L["WAVE_CUSTOM_ENABLE_DESCRIPTION"], 3),
		-- A list switched off looks exactly like a list that never matches, so say so.
		offWarning = Kit.StatusLine(function()
			return not Settings().customEnabled and L["WAVE_CUSTOM_OFF_WARNING"] or nil
		end, 3.5),
		space2 = Kit.Spacer(4),
		add = TabLabelRow(5, L["WAVE_CUSTOM_ADD"], {
			type = "input",
			desc = addDescription,
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
				ns.RefreshSettings()
			end,
		}),
		space3 = Kit.Spacer(6),
	}

	local players = Settings().players
	local rows = SortedRows(players, function(key, entry)
		return type(entry) == "table" and entry.name or key
	end)

	if #rows == 0 then
		args.empty = Kit.Desc(Kit.Color("HELP", L["WAVE_CUSTOM_EMPTY"]), 10)
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
						ns.RefreshSettings()
					end,
				},
				remove = RemoveCell(L["WAVE_CUSTOM_REMOVE"], 3, function()
					players[row.key] = nil
					ns.RefreshSettings()
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
		bnet = Kit.SubRow(4, nil, {
			Toggle(
				"bnetFriends",
				Kit.SubLabel(L["WAVE_BNET_ENABLE"]),
				L["WAVE_BNET_ENABLE_DESCRIPTION"],
				nil,
				TAB_ROW_WIDTH - Kit.SUB_INDENT_WIDTH
			),
		}),
		space2 = Kit.Spacer(5),
	}
	ns.DefineEmoteGrid(args, Settings, 10, {
		id = "waveFriends",
		key = "friendEmotes",
		defaults = ns.DATABASE_DEFAULTS.profile.wave.friendEmotes,
		description = L["WAVE_FRIENDS_EMOTES_DESCRIPTION"],
		resetDescription = ResetDescription(ns.DATABASE_DEFAULTS.profile.wave.friendEmotes),
		width = TAB_ROW_WIDTH,
	})
	-- Battle.net Friends and the checklist only matter while Wave at Friends is on; the switch itself stays.
	Kit.HideAllExcept(args, function()
		return not Settings().friendsEnabled
	end, { "enable" })
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
		space2 = Kit.Spacer(4),
		add = TabLabelRow(5, L["WAVE_GUILD_ADD"], {
			type = "input",
			desc = L["WAVE_GUILD_ADD_DESCRIPTION"],
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
				ns.RefreshSettings()
			end,
		}),
		space3 = Kit.Spacer(6),
	}

	local guilds = Settings().guilds
	local rows = SortedRows(guilds, function(key, name)
		return type(name) == "string" and name or key
	end)

	if #rows == 0 then
		args.empty = Kit.Desc(Kit.Color("HELP", L["WAVE_GUILDS_EMPTY"]), 10)
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
					width = TAB_ROW_WIDTH - Kit.REMOVE_ICON_WIDTH,
					order = 1,
				},
				remove = RemoveCell(L["WAVE_GUILD_REMOVE"], 2, function()
					guilds[row.key] = nil
					ns.RefreshSettings()
				end),
			},
		}
	end

	args.space4 = Kit.Spacer(19)
	ns.DefineEmoteGrid(args, Settings, 20, {
		id = "waveGuilds",
		key = "guildEmotes",
		defaults = ns.DATABASE_DEFAULTS.profile.wave.guildEmotes,
		description = L["WAVE_GUILDS_EMOTES_DESCRIPTION"],
		resetDescription = ResetDescription(ns.DATABASE_DEFAULTS.profile.wave.guildEmotes),
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

local function DefineCooldownSelect()
	return {
		type = "select",
		desc = L["WAVE_COOLDOWN_DESCRIPTION"],
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
		set = Kit.Set("profile", "wave.cooldown"),
	}
end

function ns.BuildWaveToFriendsOptions()
	local options = {
		name = L["TAB_WAVE_TO_FRIENDS"],
		type = "group",
		childGroups = "tab",
		args = {
			descIntro = Kit.Desc(L["WAVE_DESCRIPTION"], 1),
			space0 = Kit.Spacer(2),
			enable = Kit.FeatureSwitch("wave.enabled", 2.5),
			enableSpacer = Kit.Spacer(2.6),

			descRules = Kit.Desc(Kit.Color("HELP", L["WAVE_RULES"]), 3),
			space1 = Kit.Spacer(4),
			restingOnly = Toggle("restingOnly", L["WAVE_RESTING_ENABLE"], L["WAVE_RESTING_ENABLE_DESCRIPTION"], 5),
			space2 = Kit.Spacer(6),
			cooldown = Kit.LabelRow(7, nil, L["WAVE_COOLDOWN"], DefineCooldownSelect()),
			space3 = Kit.Spacer(8),
		},
	}

	-- Intro text and the switch itself stay; everything else follows the switch.
	Kit.HideAllExcept(options.args, function()
		return not Settings().enabled
	end, { "descIntro", "space0", "enable" })

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
