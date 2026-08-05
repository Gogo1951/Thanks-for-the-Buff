local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor
local GetSpellName = ns.GetSpellName
local GetSpellDescription = ns.GetSpellDescription
local GetSpellTexture = ns.GetSpellTexture

--------------------------------------------------------------------------------
-- Shared Options Helpers
--------------------------------------------------------------------------------

--[[
    Every section header in the add-on is a real AceConfig "header" -- the ruled
    line with the title set into it -- and no panel draws its own out of a colored
    description. `hidden` is optional (a function or a boolean) for the panels
    whose whole section collapses behind a master switch.
]]
function ns.OptionsHeader(text, order, hidden)
	return { type = "header", name = GetColor("TITLE") .. text .. "|r", order = order, hidden = hidden }
end

function ns.OptionsDesc(text, order)
	return { type = "description", name = text, fontSize = "medium", order = order }
end

function ns.OptionsSpacer(order)
	return { type = "description", name = " ", order = order }
end

--[[
    The left half of a label-beside-control row: the control that follows carries
    name = "" and ns.OPTIONS_CONTROL_WIDTH, so the two total one row and flow onto
    the same line. A row whose control needs more room passes its own width here.
]]
function ns.OptionsRowLabel(text, order, width)
	return {
		type = "description",
		name = text,
		fontSize = "medium",
		width = width or ns.OPTIONS_LABEL_WIDTH,
		order = order,
	}
end

--------------------------------------------------------------------------------
-- Shared Buff-Panel Builders
--------------------------------------------------------------------------------

--[[
    Widget factories shared by the three buff panels (Buffs from Strangers, Buffs
    from Teammates, Group Services). Each panel file owns its own layout and order
    numbers, since the three no longer share one shape, and draws its controls
    from here. Every factory takes a `settings` accessor returning the profile
    subtable the control binds to (ns.db.profile.strangers / .teammates /
    .services), so one definition serves every panel. The watched-buff list is
    shared between Teammates and Services (ns.db.profile.watchedBuffs); a given id
    only ever appears on one of the two panels.
]]

--[[
    One toggle per tracked entry. Spell entries carry a resolved name (ranks were
    already collapsed at build time); item entries carry an itemId whose name and
    icon resolve lazily, so a cold item cache fills the label in by the time the
    panel is viewed. Grouped items (Soulstone ranks, Scroll of Agility ranks...)
    also carry an explicit `label` naming the whole group, since their per-rank
    item names differ. Either way the toggle flips every watched id in the entry
    and reads its state from the first.

    `watched` is an optional accessor returning the id->bool table the toggle
    binds to; it defaults to the shared thank-you list (watchedBuffs). The
    Good News panel passes its own list, since it reuses the same ids with
    independent choices.
]]
function ns.DefineEntryToggle(entry, order, watched)
	local ids = entry.ids
	local primary = ids[1]
	local function list()
		return watched and watched() or ns.db.profile.watchedBuffs
	end

	local nameField, descField

	if entry.itemId then
		local itemId = entry.itemId
		local groupLabel = entry.label
		nameField = function()
			local shown = groupLabel or ns.GetItemInfo(itemId) or L["COMBAT_ITEM_PENDING"]:format(itemId)
			local texture = ns.GetItemIcon and ns.GetItemIcon(itemId)
			if texture then
				return "|T" .. texture .. ":16|t " .. shown
			end
			return shown
		end
		descField = function()
			-- For a grouped toggle, list every member item (links) so the tooltip
			-- spells out exactly what the single checkbox covers.
			if entry.itemIds and #entry.itemIds > 1 then
				local lines = {}
				for _, id in ipairs(entry.itemIds) do
					lines[#lines + 1] = (select(2, ns.GetItemInfo(id))) or L["COMBAT_ITEM_PENDING"]:format(id)
				end
				return table.concat(lines, "\n")
			end
			return (select(2, ns.GetItemInfo(itemId))) or ""
		end
	else
		local name = entry.spellName
		local displayName = name
		if primary then
			local texture = GetSpellTexture and GetSpellTexture(primary)
			if texture then
				displayName = "|T" .. texture .. ":16|t " .. name
			end
		end
		nameField = displayName

		if entry.spellIds and #entry.spellIds > 1 then
			-- Grouped spells (e.g. Portals): list the members alphabetically so the
			-- tooltip spells out exactly what the one checkbox covers.
			descField = function()
				local names = {}
				for _, id in ipairs(entry.spellIds) do
					names[#names + 1] = GetSpellName(id) or L["COMBAT_SPELL_PENDING"]:format(id)
				end
				table.sort(names)
				return table.concat(names, "\n")
			end
		else
			local desc = string.format(L["COMBAT_TOGGLE_TRACKING"], name)
			if primary then
				local spellDesc = GetSpellDescription and GetSpellDescription(primary)
				if spellDesc and spellDesc ~= "" then
					desc = spellDesc
				end
			end
			descField = desc
		end
	end

	return {
		type = "toggle",
		name = nameField,
		desc = descField,
		order = order,
		width = "full",
		get = function()
			return list()[primary]
		end,
		set = function(_, val)
			for _, id in ipairs(ids) do
				list()[id] = val
			end
		end,
	}
end

-- The displayed name embeds an icon escape (|T...|t), so sorting by it would sort
-- by texture path. This returns the clean, lowercased name for comparison only.
local function EntrySortKey(entry)
	local name = entry.label or entry.spellName
	if not name and entry.itemId then
		name = ns.GetItemInfo(entry.itemId)
	end
	return (name or ""):lower()
end

-- A copy of `entries` ordered alphabetically by display name, with the watched id
-- breaking ties for a stable result. Item names resolve lazily, which is why the
-- panels register their builders as functions (run on open, when the item cache
-- is warm) rather than as prebuilt tables.
function ns.SortedEntries(entries)
	local sorted = {}
	for i = 1, #entries do
		sorted[i] = entries[i]
	end
	table.sort(sorted, function(a, b)
		local ka, kb = EntrySortKey(a), EntrySortKey(b)
		if ka == kb then
			return (a.ids[1] or 0) < (b.ids[1] or 0)
		end
		return ka < kb
	end)
	return sorted
end

--[[
    The "Enable Sound Effects" toggle, offered by every buff panel. NOT
    full-width: its DefineSoundPreview speaker shares the row, and full-width
    would push the speaker onto its own line.
]]
function ns.DefineSoundToggle(settings, order)
	return {
		type = "toggle",
		name = L["NOTIFICATIONS_SOUND_ENABLE"],
		desc = L["NOTIFICATIONS_SOUND_DESCRIPTION"],
		order = order,
		get = function()
			return settings().soundEnabled
		end,
		set = function(_, val)
			settings().soundEnabled = val
		end,
	}
end

--[[
    The speaker icon that previews a panel's sound effect, placed on the same
    row right after its "Enable Sound Effects" toggle. It plays regardless of the
    toggle's state -- hearing the sound BEFORE enabling it is the point. The
    texture is the client's own voice-chat speaker, so it matches the UI in
    every locale without shipping art.
]]
function ns.DefineSoundPreview(playSound, order, hidden)
	return {
		type = "execute",
		name = "",
		image = "Interface\\Common\\VoiceChat-Speaker",
		imageWidth = 18,
		imageHeight = 18,
		width = 0.15,
		order = order,
		hidden = hidden,
		func = playSound,
	}
end

--------------------------------------------------------------------------------
-- Shared Praise & Notification Controls
--------------------------------------------------------------------------------

--[[
    The reaction toggles every buff panel offers, one factory each. They are
    separate rather than one block because the panels file them under different
    headers: the whisper and the emote are praise the other player sees, the
    print and the sound are notifications only you get.
]]
function ns.DefinePrintToggle(settings, order)
	return {
		type = "toggle",
		name = L["NOTIFICATIONS_PRINT_ENABLE"],
		desc = L["NOTIFICATIONS_PRINT_DESCRIPTION"],
		width = "full",
		order = order,
		get = function()
			return settings().printEnabled
		end,
		set = function(_, val)
			settings().printEnabled = val
		end,
	}
end

function ns.DefineWhisperToggle(settings, order)
	return {
		type = "toggle",
		name = L["PRAISE_WHISPER_ENABLE"],
		desc = L["PRAISE_WHISPER_DESCRIPTION"],
		width = "full",
		order = order,
		get = function()
			return settings().whisperEnabled
		end,
		set = function(_, val)
			settings().whisperEnabled = val
		end,
	}
end

function ns.DefineEmotesToggle(settings, order)
	return {
		type = "toggle",
		name = L["PRAISE_EMOTES_ENABLE"],
		desc = L["PRAISE_EMOTES_DESCRIPTION"],
		width = "full",
		order = order,
		get = function()
			return settings().emotesEnabled
		end,
		set = function(_, val)
			settings().emotesEnabled = val
		end,
	}
end

-- Shared by the emote picker and the blank line above it, so both disappear
-- together when the panel's emotes are switched off.
function ns.EmotesHidden(settings)
	return function()
		return not settings().emotesEnabled
	end
end

-- The emote picker: one half-width toggle per entry in Data.EMOTES, inline under
-- the panel's Enable Emotes toggle and hidden along with it.
function ns.DefineEmoteGroup(settings, order)
	local group = {
		type = "group",
		name = L["PRAISE_EMOTES_SELECT"],
		order = order,
		inline = true,
		hidden = ns.EmotesHidden(settings),
		args = {},
	}

	for i, emoteData in ipairs(Data.EMOTES) do
		local emote = emoteData.cmd
		group.args[emote] = {
			type = "toggle",
			name = emoteData.displayName,
			desc = emoteData.desc,
			order = i,
			width = "half",
			get = function()
				return settings().emotes[emote]
			end,
			set = function(_, val)
				settings().emotes[emote] = val
			end,
		}
	end

	return group
end

--[[
    "Enable Praise Delay" and the dropdown that sets its length, offered by every
    buff panel. The delay holds back the whisper and the emote only: the print and
    the sound are your own heads-up and stay instant. The toggle takes the label
    half of the row and the dropdown the other half, so the two total one row and
    the dropdown sits clear of the caption.
]]
function ns.DefinePraiseDelayToggle(settings, order)
	return {
		type = "toggle",
		name = L["PRAISE_DELAY_ENABLE"],
		desc = L["PRAISE_DELAY_DESCRIPTION"],
		width = ns.OPTIONS_LABEL_WIDTH,
		order = order,
		get = function()
			return settings().praiseDelayEnabled
		end,
		set = function(_, val)
			settings().praiseDelayEnabled = val
		end,
	}
end

-- Nothing to set while the delay is off, so the dropdown only appears with it.
-- Its labels come from the client's own duration strings (ns.FormatDuration), so
-- "2 seconds" reads correctly in every language without TFTB shipping a string
-- per length. Data.PRAISE_DELAY_CHOICES doubles as the display order.
function ns.DefinePraiseDelaySelect(settings, order)
	return {
		type = "select",
		name = "",
		desc = L["PRAISE_DELAY_LENGTH_DESCRIPTION"],
		width = ns.OPTIONS_CONTROL_WIDTH,
		order = order,
		hidden = function()
			return not settings().praiseDelayEnabled
		end,
		sorting = Data.PRAISE_DELAY_CHOICES,
		values = function()
			local values = {}
			for _, seconds in ipairs(Data.PRAISE_DELAY_CHOICES) do
				values[seconds] = ns.FormatDuration(seconds)
			end
			return values
		end,
		get = function()
			return settings().praiseDelay
		end,
		set = function(_, val)
			settings().praiseDelay = val
		end,
	}
end
