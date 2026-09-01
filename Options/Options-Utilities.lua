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

--[[
    Silver helper text, for a line of explanation sitting under the control it
    explains rather than hidden behind a hover. HELP is the palette's colour for
    exactly this.
]]
function ns.OptionsHelp(text, order, hidden)
	return {
		type = "description",
		name = GetColor("HELP") .. text .. "|r",
		fontSize = "medium",
		order = order,
		hidden = hidden,
	}
end

-- Always seconds. FormatDuration switches to minutes above 60 and rounds, which
-- is right for a buff ticking down and wrong for a fixed list: it would print 89
-- as "1 Minute" and 144 as "2 Minutes", two units in one dropdown.
local function FormatChoice(seconds)
	return ns.FormatDuration(seconds, true)
end

-- The listed value closest to what is stored.
local function NearestChoice(value)
	local best, bestGap
	for _, choice in ipairs(Data.SECONDS_CHOICES) do
		local gap = math.abs(choice - (value or 0))
		if not bestGap or gap < bestGap then
			best, bestGap = choice, gap
		end
	end
	return best
end

--[[
    A seconds dropdown over Data.SECONDS_CHOICES, replacing the sliders these
    settings used to use.

    `get` snaps to the NEAREST listed value rather than returning what is stored.
    The sliders could store any integer -- 25, 47 -- and AceConfig renders a
    select whose value is missing from `values` as an empty box, which a player
    cannot fix without guessing that re-picking is what it wants. Snapping shows
    the closest real option; the stored number is left alone until they choose,
    so nobody's setting is silently rewritten by opening the panel.
]]
function ns.DefineSecondsSelect(settings, key, order)
	return {
		type = "select",
		-- The right half of a label-beside-control row: the caller pairs this with
		-- ns.OptionsRowLabel, the same way every other dropdown in the add-on is
		-- built. A select carrying its own `name` stacks the label above itself in
		-- header gold, which is not how this UI reads a setting.
		name = "",
		width = ns.OPTIONS_CONTROL_WIDTH,
		order = order,
		sorting = Data.SECONDS_CHOICES,
		values = function()
			local values = {}
			for _, seconds in ipairs(Data.SECONDS_CHOICES) do
				values[seconds] = FormatChoice(seconds)
			end
			return values
		end,
		get = function()
			return NearestChoice(settings()[key])
		end,
		set = function(_, val)
			settings()[key] = val
		end,
	}
end

function ns.OptionsSpacer(order)
	return { type = "description", name = " ", order = order }
end

--[[
    Cut to a byte budget without splitting a multi-byte character. The cap is
    counted in bytes, not characters, because what it really protects is the
    chat line: WoW measures that in bytes too, and one ability link already
    spends a good part of it. For English the two are the same number.

    A cut landing mid-character would leave a broken tail byte that renders as a
    replacement glyph, so step back off any UTF-8 continuation byte (0x80-0xBF)
    sitting at the cut.
]]
function ns.TrimToBytes(text, maxBytes)
	if #text <= maxBytes then
		return text
	end
	local cut = maxBytes
	while cut > 0 do
		local b = text:byte(cut + 1)
		if not b or b < 128 or b >= 192 then
			break
		end
		cut = cut - 1
	end
	return text:sub(1, cut)
end

--[[
    The left half of a label-beside-control row: the control that follows carries
    name = "" and ns.OPTIONS_CONTROL_WIDTH, so the two total one row and flow onto
    the same line. A row whose control needs more room passes its own width here.
]]
function ns.OptionsRowLabel(text, order, width, hidden)
	return {
		type = "description",
		name = text,
		fontSize = "medium",
		width = width or ns.OPTIONS_LABEL_WIDTH,
		order = order,
		-- A label has no state of its own, so nothing hides it unless it is told
		-- to: on a panel behind a master switch, one left out is the caption that
		-- stays floating after everything it described has gone.
		hidden = hidden,
	}
end

--[[
    Hide every control on a panel behind its master switch.

    Applied to the finished args table rather than threaded through every shared
    Define* builder. The rule is positional -- everything except the intro text
    and the switch itself -- so a control added later is covered automatically
    instead of depending on someone remembering to pass a flag down.

    Existing `hidden` values are COMPOSED, not replaced. Several controls already
    hide for their own reasons (the emote grid follows its own toggle), and
    overwriting that would leave the grid showing whenever the master was on.
]]
function ns.HideAllExcept(args, isHidden, keep)
	for key, option in pairs(args) do
		if not keep[key] then
			local own = option.hidden
			if own == nil then
				option.hidden = isHidden
			else
				option.hidden = function(info)
					if isHidden(info) then
						return true
					end
					if type(own) == "function" then
						return own(info)
					end
					return own
				end
			end
		end
	end
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
			local shown = groupLabel or ns.GetItemInfo(itemId) or L["TRACKED_ITEM_PENDING"]:format(itemId)
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
					lines[#lines + 1] = (select(2, ns.GetItemInfo(id))) or L["TRACKED_ITEM_PENDING"]:format(id)
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
					names[#names + 1] = GetSpellName(id) or L["TRACKED_SPELL_PENDING"]:format(id)
				end
				table.sort(names)
				return table.concat(names, "\n")
			end
		else
			--[[
                The ability's own tooltip text, preferred over the generic
                "Toggle tracking for X." line, and taken from the HIGHEST id in
                the entry: a rank group collapses to one name but not to one set
                of numbers, and the tooltip should quote the rank you actually
                cast, not rank 1. The ids are sorted here rather than trusted in
                data order -- rows are not reliably rank-ordered (Combustion is
                { 29977, 11129 }, Vanish { 1856, 1857, 27617, 26889, 44290 }).
                Walking down from the top also skips any id that is dead on this
                client, so a row spanning flavors still describes itself.

                A function, not a baked string, for the same reason the item
                branch above uses one: descriptions arrive asynchronously.
                Classic holds tooltip data only for spells the character has
                known, and this panel lists every class, so the first look at
                another class's cooldown legitimately has nothing to show. The
                request below asks for it when the panel is built and the draw
                re-asks each time, so the real text appears once it lands.
            ]]
			local ranked = {}
			for i = 1, #ids do
				ranked[i] = ids[i]
			end
			table.sort(ranked)

			if ns.RequestSpellData then
				ns.RequestSpellData(ranked)
			end

			local fallback = string.format(L["TRACKED_TOGGLE_DESCRIPTION"], name)
			descField = function()
				if GetSpellDescription then
					for i = #ranked, 1, -1 do
						local spellDesc = GetSpellDescription(ranked[i])
						if spellDesc and spellDesc ~= "" then
							return spellDesc
						end
					end
				end
				return fallback
			end
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

-- Sits under the toggle and its dropdown, and stays put when the delay is off:
-- it is the reason to switch the delay on, so it is exactly then that it is worth
-- reading.
function ns.DefinePraiseDelayHelp(order)
	return ns.OptionsHelp(L["PRAISE_DELAY_HELP"], order)
end

-- Nothing to set while the delay is off, so the dropdown only appears with it.
-- Its labels come from the client's own duration strings (ns.FormatDuration), so
-- "2 seconds" reads correctly in every language without TFTB shipping a string
-- per length. Data.PRAISE_DELAY_CHOICES doubles as the display order.
function ns.DefinePraiseDelaySelect(settings, order)
	return {
		type = "select",
		name = "",
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
