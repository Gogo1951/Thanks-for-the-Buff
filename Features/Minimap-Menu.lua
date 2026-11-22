local ADDON_NAME, ns = ...
local Data = ns.Data
local L = ns.L
local Kit = ns.MenuKit

--[[
    The mini-map menu, on Menu-Kit v2 (Features/Menu-Kit.lua). One block per
    feature in BLOCKS, in ns.FEATURES order (Good News has none: it stays on the
    options panel), each with its Toggle row and a flyout of the
    settings players change mid-session, then TFTB Options. The options panel
    stays complete; the menu shows only what this character can use.
]]

Kit.SetText({
	on = L["MENU_ON"],
	off = L["MENU_OFF"],
	toggle = L["MENU_TOGGLE"],
	more = L["MENU_MORE"],
	clicks = {
		RightButton = L["MENU_CLICK_RIGHT"],
		MiddleButton = L["MENU_CLICK_MIDDLE"],
		ShiftMiddleButton = L["MENU_CLICK_SHIFT_MIDDLE"],
	},
})

-- The Ignored Buffs flyout lists this many, then "%d more".
local IGNORED_LIST_MAX = 5

--------------------------------------------------------------------------------
-- Button Clicks
--------------------------------------------------------------------------------

--[[
    Each feature's block: its flyout key and the button click its Toggle row
    names, which the button runs too (Style Guide → MINIMAP MENU → Button
    Clicks). Left-Click has no job, so it opens and holds the menu, and
    Shift + Middle-Click opens the options panel.
]]
local BLOCKS = {
	["strangers.enabled"] = { key = "giveThanks", click = "RightButton", description = "GIVE_THANKS_DESCRIPTION" },
	["wave.enabled"] = { key = "wave", click = "MiddleButton", description = "WAVE_DESCRIPTION" },
}

--------------------------------------------------------------------------------
-- Rows
--------------------------------------------------------------------------------

local function Profile()
	return ns.db.profile
end

-- A switch row for one profile setting, its tooltip the option's own caption and description.
local function Switch(settings, field, label, caption, desc, extra)
	local row = {
		kind = "toggle",
		left = label,
		on = settings[field] and true or false,
		tooltip = Kit.OptionTooltip(caption or label, desc),
		onClick = function()
			settings[field] = not settings[field]
		end,
	}
	for key, value in pairs(extra or {}) do
		row[key] = value
	end
	return row
end

-- One choice row per value, the stored one checked.
local function Choices(values, sorting, current, pick)
	local rows = {}
	for _, value in ipairs(sorting) do
		rows[#rows + 1] = {
			kind = "choice",
			left = values[value],
			selected = value == current,
			onClick = function()
				pick(value)
			end,
		}
	end
	return rows
end

-- The listed value closest to what is stored, as the options panel's dropdowns show it.
local function Nearest(choices, value, skip)
	local best, bestGap
	for _, choice in ipairs(choices) do
		local gap = math.abs(choice - (value or 0))
		if choice ~= skip and (not bestGap or gap < bestGap) then
			best, bestGap = choice, gap
		end
	end
	return best
end

local function SecondsValues()
	local values = {}
	for _, seconds in ipairs(Data.SECONDS_CHOICES) do
		values[seconds] = ns.FormatDuration(seconds, true)
	end
	return values
end

--[[
    Praise Delay's one pick list: Off (PRAISE_DELAY_OFF), then each delay. A
    delay switches it on, Off switches it off, and the delay it had is kept.
]]
local PRAISE_DELAY_OFF = 0

local function PraiseDelayValues()
	local values, sorting = { [PRAISE_DELAY_OFF] = L["MENU_OFF"] }, { PRAISE_DELAY_OFF }
	for _, seconds in ipairs(Data.PRAISE_DELAY_CHOICES) do
		values[seconds] = ns.FormatDuration(seconds)
		sorting[#sorting + 1] = seconds
	end
	return values, sorting
end

local function PraiseDelay()
	local settings = Profile().strangers
	return settings.praiseDelayEnabled and settings.praiseDelay or PRAISE_DELAY_OFF
end

local function WaveCooldownValues()
	local values = {}
	for _, seconds in ipairs(Data.WAVE_COOLDOWN_CHOICES) do
		values[seconds] = seconds == 0 and L["WAVE_COOLDOWN_ONCE_PER_SESSION"] or ns.FormatDuration(seconds)
	end
	return values
end

-- 0 is Once per Session, never the nearest neighbor of a short timer.
local function WaveCooldown()
	local stored = Profile().wave.cooldown
	if stored == 0 then
		return 0
	end
	return Nearest(Data.WAVE_COOLDOWN_CHOICES, stored, 0)
end

-- "|T icon|t Name" for a spell, and its tooltip.
local function SpellRow(spellId, onClick, extra)
	local name = C_Spell.GetSpellName(spellId) or tostring(spellId)
	local icon = C_Spell.GetSpellTexture(spellId)
	local row = {
		kind = "item",
		left = (icon and ("|T" .. icon .. ":0|t ") or "") .. name,
		leftColor = ns.SPELL_LINK_COLOR,
		tooltip = function(tooltip)
			tooltip:SetSpellByID(spellId)
		end,
		onClick = onClick,
	}
	for key, value in pairs(extra or {}) do
		row[key] = value
	end
	return row, name
end

local function OpenPanel(key)
	ns:OpenOptionsPanel(key)
end

--------------------------------------------------------------------------------
-- Flyouts
--------------------------------------------------------------------------------

local FLYOUTS = {}

-- Give Thanks: the whisper, the notifications, the limits, the emote list, and the buff lists.
function FLYOUTS.giveThanks()
	local settings = Profile().strangers
	if not settings.enabled then
		return {}
	end
	local entries = {}
	local seconds = SecondsValues()

	entries[#entries + 1] = Kit.Section(L["GIVE_THANKS_WHISPER_HEADER"])
	entries[#entries + 1] = Switch(
		settings,
		"whisperEnabled",
		L["MENU_WHISPER"],
		L["GIVE_THANKS_WHISPER_ENABLE"],
		L["PRAISE_WHISPER_DESCRIPTION"]
	)
	local languages = ns.GetMessageLanguageChoices()
	entries[#entries + 1] = {
		kind = "value",
		left = L["SEND_MESSAGES_IN"],
		right = languages[ns.GetMessageLanguage()],
		submenu = "language",
	}

	entries[#entries + 1] = Kit.Section(L["NOTIFICATIONS_HEADER"])
	entries[#entries + 1] = Switch(
		settings,
		"printEnabled",
		L["MENU_PRINT"],
		L["NOTIFICATIONS_PRINT_ENABLE"],
		L["NOTIFICATIONS_PRINT_DESCRIPTION"]
	)
	entries[#entries + 1] = Switch(
		settings,
		"soundEnabled",
		L["MENU_SOUND"],
		L["NOTIFICATIONS_SOUND_ENABLE"],
		L["NOTIFICATIONS_SOUND_DESCRIPTION"]
	)

	entries[#entries + 1] = Kit.Section(L["PRAISE_HEADER"])
	entries[#entries + 1] = {
		kind = "value",
		left = L["GIVE_THANKS_OVERALL_COOLDOWN"],
		right = seconds[Nearest(Data.SECONDS_CHOICES, settings.praiseCooldown)],
		submenu = "praiseCooldown",
	}
	entries[#entries + 1] = {
		kind = "value",
		left = L["GIVE_THANKS_SOURCE_COOLDOWN"],
		right = seconds[Nearest(Data.SECONDS_CHOICES, settings.cooldown)],
		submenu = "sourceCooldown",
	}
	entries[#entries + 1] = {
		kind = "value",
		left = L["GIVE_THANKS_MIN_DURATION"],
		right = seconds[Nearest(Data.SECONDS_CHOICES, settings.minBuffDuration)],
		submenu = "minDuration",
	}
	entries[#entries + 1] = {
		kind = "value",
		left = L["MENU_PRAISE_DELAY"],
		right = PraiseDelayValues()[PraiseDelay()],
		tooltip = Kit.OptionTooltip(L["PRAISE_DELAY_ENABLE"], L["PRAISE_DELAY_DESCRIPTION"]),
		submenu = "praiseDelay",
	}

	-- Emotes List: how many are ticked, and the way to the checklist.
	local checked = 0
	for _, picked in pairs(settings.emotes or {}) do
		if picked then
			checked = checked + 1
		end
	end
	entries[#entries + 1] = Kit.Section(L["TAB_EMOTES_LIST"], L["MENU_CHECKED"]:format(checked))
	entries[#entries + 1] = {
		kind = "action",
		left = L["MENU_CHOOSE_EMOTES"],
		closes = true,
		onClick = function()
			OpenPanel("EmotesList")
		end,
	}

	-- Recent Buffs: a click ignores the buff on this character.
	entries[#entries + 1] = Kit.Section(L["MENU_RECENT"])
	local recent = {}
	for _, buff in ipairs(ns.GetRecentBuffs()) do
		if not ns.IsBuffIgnored(buff.spellId) and C_Spell.GetSpellName(buff.spellId) then
			local spellId = buff.spellId
			recent[#recent + 1] = SpellRow(spellId, function()
				ns.SetBuffIgnoredInScope(ns.db.keys.char, spellId, true)
				ns:PrintMessage(
					L["MENU_IGNORED_PRINT"]:format(ns.GetSpellLink(spellId) or C_Spell.GetSpellName(spellId))
				)
			end)
		end
	end
	if #recent == 0 then
		entries[#entries + 1] = { kind = "note", left = L["MENU_RECENT_EMPTY"] }
	else
		entries[#entries + 1] = { kind = "note", left = L["MENU_RECENT_NOTE"] }
		for _, row in ipairs(recent) do
			entries[#entries + 1] = row
		end
	end

	-- Ignored Buffs: this character's and All Characters', by name; a click stops ignoring it.
	entries[#entries + 1] = Kit.Section(L["TAB_IGNORED_BUFFS"])
	local ignored, seen = {}, {}
	for _, scope in ipairs({ ns.db.keys.char, ns.LIST_SCOPE_GLOBAL }) do
		for spellId in pairs(ns.GetIgnoredBuffsForScope(scope) or {}) do
			if not seen[spellId] then
				seen[spellId] = true
				local row, name = SpellRow(spellId, function()
					ns.SetBuffIgnoredInScope(ns.db.keys.char, spellId, false)
					ns.SetBuffIgnoredInScope(ns.LIST_SCOPE_GLOBAL, spellId, false)
					ns:PrintMessage(
						L["MENU_UNIGNORED_PRINT"]:format(
							ns.GetSpellLink(spellId) or C_Spell.GetSpellName(spellId) or ""
						)
					)
				end, { right = Kit.REMOVE_ICON, rightOnHover = true })
				row.sortName = name
				ignored[#ignored + 1] = row
			end
		end
	end
	table.sort(ignored, function(a, b)
		return a.sortName < b.sortName
	end)
	if #ignored == 0 then
		entries[#entries + 1] = { kind = "note", left = L["MENU_IGNORED_EMPTY"] }
	else
		entries[#entries + 1] = { kind = "note", left = L["MENU_IGNORED_NOTE"] }
		Kit.List(entries, ignored, IGNORED_LIST_MAX)
	end

	return entries
end

function FLYOUTS.praiseCooldown()
	local settings = Profile().strangers
	return Choices(
		SecondsValues(),
		Data.SECONDS_CHOICES,
		Nearest(Data.SECONDS_CHOICES, settings.praiseCooldown),
		function(value)
			settings.praiseCooldown = value
		end
	)
end

function FLYOUTS.sourceCooldown()
	local settings = Profile().strangers
	return Choices(
		SecondsValues(),
		Data.SECONDS_CHOICES,
		Nearest(Data.SECONDS_CHOICES, settings.cooldown),
		function(value)
			settings.cooldown = value
		end
	)
end

function FLYOUTS.minDuration()
	local settings = Profile().strangers
	return Choices(
		SecondsValues(),
		Data.SECONDS_CHOICES,
		Nearest(Data.SECONDS_CHOICES, settings.minBuffDuration),
		function(value)
			settings.minBuffDuration = value
		end
	)
end

function FLYOUTS.praiseDelay()
	local settings = Profile().strangers
	local values, sorting = PraiseDelayValues()
	return Choices(values, sorting, PraiseDelay(), function(value)
		settings.praiseDelayEnabled = value ~= PRAISE_DELAY_OFF
		if value ~= PRAISE_DELAY_OFF then
			settings.praiseDelay = value
		end
	end)
end

function FLYOUTS.language()
	local values, sorting = ns.GetMessageLanguageChoices()
	return Choices(values, sorting, ns.GetMessageLanguage(), ns.SetMessageLanguage)
end

-- Wave to Friends: where and how often, then who gets a wave, with the way to the Custom List.
function FLYOUTS.wave()
	local settings = Profile().wave
	if not settings.enabled then
		return {}
	end
	local entries = {}

	entries[#entries + 1] =
		Switch(settings, "restingOnly", L["WAVE_RESTING_ENABLE"], nil, L["WAVE_RESTING_ENABLE_DESCRIPTION"])
	entries[#entries + 1] = {
		kind = "value",
		left = L["WAVE_COOLDOWN"],
		right = WaveCooldownValues()[WaveCooldown()],
		submenu = "waveCooldown",
	}

	entries[#entries + 1] = Kit.Section(L["MENU_WHO_WAVES"])
	entries[#entries + 1] =
		Switch(settings, "friendsEnabled", L["WAVE_FRIENDS_ENABLE"], nil, L["WAVE_FRIENDS_ENABLE_DESCRIPTION"])
	entries[#entries + 1] = Switch(
		settings,
		"bnetFriends",
		L["WAVE_BNET_ENABLE"],
		nil,
		L["WAVE_BNET_ENABLE_DESCRIPTION"],
		{ disabled = not settings.friendsEnabled }
	)
	entries[#entries + 1] =
		Switch(settings, "myGuildEnabled", L["WAVE_MY_GUILD_ENABLE"], nil, L["WAVE_MY_GUILD_ENABLE_DESCRIPTION"])
	entries[#entries + 1] = Switch(
		settings,
		"customEnabled",
		L["WAVE_TAB_CUSTOM"],
		L["WAVE_CUSTOM_ENABLE"],
		L["WAVE_CUSTOM_ENABLE_DESCRIPTION"]
	)
	-- The names themselves are edited on the options panel's Custom List tab.
	entries[#entries + 1] = {
		kind = "action",
		left = L["MENU_EDIT_CUSTOM"],
		closes = true,
		onClick = function()
			OpenPanel("WaveToFriends")
			if not InCombatLockdown() then
				LibStub("AceConfigDialog-3.0"):SelectGroup(ns.OPTIONS_REGISTRY.WaveToFriends, "custom")
			end
		end,
	}

	return entries
end

function FLYOUTS.waveCooldown()
	local settings = Profile().wave
	return Choices(WaveCooldownValues(), Data.WAVE_COOLDOWN_CHOICES, WaveCooldown(), function(value)
		settings.cooldown = value
	end)
end

--------------------------------------------------------------------------------
-- Main Menu
--------------------------------------------------------------------------------

local function Resolve(feature)
	local node = ns.db[feature.store]
	local path = {}
	for part in string.gmatch(feature.setting, "[^%.]+") do
		path[#path + 1] = part
	end
	for index = 1, #path - 1 do
		node = node[path[index]]
	end
	return node, path[#path]
end

local function BuildMainEntries()
	local entries = {
		{ kind = "header", left = L["ADDON_TITLE"], right = ns.Version },
		Kit.Spacer(),
	}

	for _, feature in ipairs(ns.FEATURES) do
		local block = BLOCKS[feature.setting]
		if block then
			local node, field = Resolve(feature)
			local on = node[field] and true or false
			local state, stateColor = Kit.OnOff(on)
			Kit.FeatureBlock(entries, {
				key = block.key,
				title = L[feature.name],
				state = state,
				stateColor = stateColor,
				description = L[block.description],
				toggle = {
					name = L[feature.caption],
					desc = L[feature.desc],
					click = block.click,
					flip = function()
						node[field] = not node[field]
					end,
				},
			})
		end
	end

	Kit.OptionsRow(entries, L["MENU_OPTIONS"])
	return entries
end

ns.minimapMenu = Kit.CreateMenu({
	name = ADDON_NAME .. "Menu",
	build = BuildMainEntries,
	flyouts = FLYOUTS,
	afterChange = function()
		ns.RefreshSettings()
	end,
})
