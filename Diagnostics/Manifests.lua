local _, ns = ...

local GetClientHeader = ns.GetDiagnosticClientHeader

--------------------------------------------------------------------------------
-- API Endpoints
--------------------------------------------------------------------------------

--[[
    Existence and shape checks only: read-only, no side effects, no protected
    calls. One row per API TFTB actually calls or guards, wherever it lives --
    nothing incidental, and nothing the add-on does not use. The one
    modern/legacy pair the add-on still picks between (Validate Data's stat
    read) is listed as both halves: a FAIL on one half is the report working,
    since the pair tells a bug report which branch that client took.
]]
local function HasFunction(namespace, name)
	return function()
		local library = _G[namespace]
		return type(library) == "table" and type(library[name]) == "function"
	end
end

local function HasGlobalFunction(name)
	return function()
		return type(_G[name]) == "function"
	end
end

ns.DIAGNOSTIC_API_CHECKS = {
	-- { label, testFunction }
	{ "C_AddOns.GetAddOnMetadata", HasFunction("C_AddOns", "GetAddOnMetadata") },
	{ "C_AddOns.GetNumAddOns", HasFunction("C_AddOns", "GetNumAddOns") },
	{ "C_AddOns.GetAddOnInfo", HasFunction("C_AddOns", "GetAddOnInfo") },
	{ "C_Seasons.GetActiveSeason", HasFunction("C_Seasons", "GetActiveSeason") },
	{
		"Enum.SeasonID.SeasonOfDiscovery",
		function()
			return type(Enum) == "table" and type(Enum.SeasonID) == "table" and Enum.SeasonID.SeasonOfDiscovery ~= nil
		end,
	},
	{ "C_Spell.GetSpellName", HasFunction("C_Spell", "GetSpellName") },
	{ "C_Spell.GetSpellInfo", HasFunction("C_Spell", "GetSpellInfo") },
	{ "C_Spell.DoesSpellExist", HasFunction("C_Spell", "DoesSpellExist") },
	{ "C_Spell.GetSpellDescription", HasFunction("C_Spell", "GetSpellDescription") },
	{ "C_Spell.RequestLoadSpellData", HasFunction("C_Spell", "RequestLoadSpellData") },
	{ "C_Spell.GetSpellTexture", HasFunction("C_Spell", "GetSpellTexture") },
	{ "C_Spell.GetSpellLink", HasFunction("C_Spell", "GetSpellLink") },
	{ "C_Item.GetItemInfo", HasFunction("C_Item", "GetItemInfo") },
	{ "C_Item.GetItemIconByID", HasFunction("C_Item", "GetItemIconByID") },
	{ "C_UnitAuras.GetBuffDataByIndex", HasFunction("C_UnitAuras", "GetBuffDataByIndex") },
	{ "C_UnitAuras.GetAuraCasterGUID", HasFunction("C_UnitAuras", "GetAuraCasterGUID") },
	{ "C_Secrets.ShouldUnitIdentityBeSecret", HasFunction("C_Secrets", "ShouldUnitIdentityBeSecret") },
	{ "C_Secrets.ShouldAurasBeSecret", HasFunction("C_Secrets", "ShouldAurasBeSecret") },
	{ "issecretvalue", HasGlobalFunction("issecretvalue") },
	{ "CombatLogGetCurrentEventInfo", HasGlobalFunction("CombatLogGetCurrentEventInfo") },
	{
		"COMBATLOG_OBJECT_* affiliation / reaction / type flags",
		function()
			return COMBATLOG_OBJECT_TYPE_PLAYER ~= nil
				and COMBATLOG_OBJECT_REACTION_FRIENDLY ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_MINE ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_PARTY ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_RAID ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_OUTSIDER ~= nil
		end,
	},
	{ "GetPlayerInfoByGUID", HasGlobalFunction("GetPlayerInfoByGUID") },
	{ "UnitNameFromGUID", HasGlobalFunction("UnitNameFromGUID") },
	{ "C_ChatInfo.SendChatMessage", HasFunction("C_ChatInfo", "SendChatMessage") },
	{ "C_ChatInfo.PerformEmote", HasFunction("C_ChatInfo", "PerformEmote") },
	{ "UnitIsVisible", HasGlobalFunction("UnitIsVisible") },
	{ "UnitInRange", HasGlobalFunction("UnitInRange") },
	{ "CreateMacro", HasGlobalFunction("CreateMacro") },
	{ "DeleteMacro", HasGlobalFunction("DeleteMacro") },
	{ "GetMacroIndexByName", HasGlobalFunction("GetMacroIndexByName") },
	{ "GetNumMacros", HasGlobalFunction("GetNumMacros") },
	{ "PlaySoundFile", HasGlobalFunction("PlaySoundFile") },
	{ "Settings.OpenToCategory", HasFunction("Settings", "OpenToCategory") },
	{ "InCombatLockdown", HasGlobalFunction("InCombatLockdown") },
	{ "C_Timer.After", HasFunction("C_Timer", "After") },
	{ "C_EventUtils.IsEventValid", HasFunction("C_EventUtils", "IsEventValid") },
	{ "IsPlayerSpell", HasGlobalFunction("IsPlayerSpell") },
	{ "C_SpellBook.IsSpellKnown", HasFunction("C_SpellBook", "IsSpellKnown") },
	-- Validate Data's reads beyond the reader lists it adds itself.
	{ "C_Item.DoesItemExistByID", HasFunction("C_Item", "DoesItemExistByID") },
	{ "C_Item.RequestLoadItemDataByID", HasFunction("C_Item", "RequestLoadItemDataByID") },
	{ "C_Item.GetItemInfoInstant", HasFunction("C_Item", "GetItemInfoInstant") },
	{ "C_Item.GetItemSpell", HasFunction("C_Item", "GetItemSpell") },
	{ "C_Item.GetDetailedItemLevelInfo", HasFunction("C_Item", "GetDetailedItemLevelInfo") },
	{ "C_Item.GetItemStats", HasFunction("C_Item", "GetItemStats") },
	{ "GetItemStats (legacy)", HasGlobalFunction("GetItemStats") },
	{ "C_Item.GetItemClassInfo", HasFunction("C_Item", "GetItemClassInfo") },
	{ "C_Item.GetItemSubClassInfo", HasFunction("C_Item", "GetItemSubClassInfo") },
	{ "C_TooltipInfo.GetItemByID", HasFunction("C_TooltipInfo", "GetItemByID") },
	{ "C_TooltipInfo.GetSpellByID", HasFunction("C_TooltipInfo", "GetSpellByID") },
	{
		"Hidden scan tooltip (legacy)",
		function()
			return type(CreateFrame) == "function"
				and type(GameTooltip) == "table"
				and type(GameTooltip.SetHyperlink) == "function"
				and type(GameTooltip.NumLines) == "function"
		end,
	},
	{ "C_QuestLog.GetTitleForQuestID", HasFunction("C_QuestLog", "GetTitleForQuestID") },
	{ "C_QuestLog.RequestLoadQuestByID", HasFunction("C_QuestLog", "RequestLoadQuestByID") },
	{ "GetCVar", HasGlobalFunction("GetCVar") },
	{ "SetCVar", HasGlobalFunction("SetCVar") },
}

--------------------------------------------------------------------------------
-- Add-on Context
--------------------------------------------------------------------------------

-- The add-on's own example reports, appended to the shared Event Log intro.
ns.DiagnosticsStrings.EVENT_LOG_EXAMPLES =
	"Best for 'nobody got thanked' or 'a portal wasn't announced' reports. On every flavor it records each buff that lands on you, decoded, with whether TFTB tracks and watches it. Off WoW Forever it also records each nearby cast and revive TFTB tracks the same way, and counts every other spell cast by spell id at the end."

-- Per-class tracked-spell manifest for the IsPlayerSpell readout, rebuilt from
-- ns.TRACKED_ABILITIES at login by Features/Buff-Tracking.lua.
ns.DIAGNOSTIC_SPELLS = {}

-- Tracked-trigger coverage on the running client, filled at login by
-- Features/Buff-Tracking.lua.
ns.DIAGNOSTIC_TRACKED = { entriesLive = 0, entriesTotal = 0, auraIds = 0, castIds = 0 }

-- How many entries of a saved on/off list are switched on, out of how many it holds.
local function CountOn(list)
	local on, total = 0, 0
	if type(list) == "table" then
		for _, value in pairs(list) do
			total = total + 1
			if value then
				on = on + 1
			end
		end
	end
	return on, total
end

-- How many of the curated emotes a panel has picked, out of how many there are.
local function EmotesPicked(emotes)
	local picked = 0
	if type(emotes) == "table" then
		for _, data in ipairs(ns.Data.EMOTES) do
			if emotes[data.cmd] then
				picked = picked + 1
			end
		end
	end
	return string.format("%d/%d", picked, #ns.Data.EMOTES)
end

local function KnowsAny(ids)
	for _, id in ipairs(ids) do
		if IsPlayerSpell(id) then
			return true
		end
	end
	return false
end

-- A value that may be secret on WoW Forever, as text that never tests it.
local function PlainText(value)
	if ns.IsPlain(value) then
		return tostring(value)
	end
	return "<secret>"
end

--[[
    Who the player has targeted and whether TFTB would praise them right now:
    the Thank You Button's player and faction checks, and the per-source praise
    and whisper throttles for that GUID. A target whose identity is secret
    (WoW Forever) is reported as such and never read further.
]]
local function CurrentTargetLine()
	if not UnitExists("target") then
		return "Current target: none"
	end
	if ns.IsUnitIdentitySecret("target") then
		return "Current target: identity secret"
	end
	local playerFaction, targetFaction = UnitFactionGroup("player"), UnitFactionGroup("target")
	local sameFaction = "<secret>"
	if ns.IsPlain(playerFaction) and ns.IsPlain(targetFaction) then
		sameFaction = tostring(playerFaction == targetFaction)
	end
	local line =
		string.format("Current target: player=%s sameFaction=%s", PlainText(UnitIsPlayer("target")), sameFaction)
	local guid = UnitGUID("target")
	if guid and ns.IsPlain(guid) then
		local _, source, whisper = ns.GetPraiseCooldownState(guid)
		line = line .. string.format(" praiseCooldown=%s whisperCooldown=%s", tostring(source), tostring(whisper))
	end
	return line
end

--[[
    The state most likely to explain a "nothing happens when I get buffed"
    report: who the player is and which profile they're on, how buffs are
    detected on this flavor and whether that path is open right now (the
    post-login pause, combat, WoW Forever's secret auras), every panel's
    settings and picked emotes, the watched counts, the praise throttles, the
    sound settings the Master channel answers to, how much of the tracked data
    is live on this client, whether they actually know the spells the add-on
    tracks for their class, and what stops each Thank You button: its toggle,
    its macro, its whisper text and its emotes.
]]
function ns:BuildContextReport()
	local lines = { GetClientHeader(), "" }
	local db = ns.db and ns.db.profile

	local _, class = UnitClass("player")
	lines[#lines + 1] = string.format(
		"Player: %s  Class: %s  Level: %s  Faction: %s",
		UnitName("player") or "?",
		tostring(class),
		tostring(UnitLevel("player") or 0),
		tostring(UnitFactionGroup("player") or "?")
	)
	if db then
		lines[#lines + 1] = string.format(
			"Active profile: %s  Welcome message: %s",
			tostring(ns.db:GetCurrentProfile()),
			tostring(db.showWelcome)
		)
	end
	lines[#lines + 1] = string.format(
		"Grouped: party=%s raid=%s  InCombat=%s",
		tostring(IsInGroup() and true or false),
		tostring(IsInRaid() and true or false),
		tostring(InCombatLockdown() and true or false)
	)
	if ns.FLAVOR == "Camelot" then
		lines[#lines + 1] =
			"Buff detection: UNIT_AURA (WoW Forever has no combat log; skipped in combat and while auras are secret)"
	else
		lines[#lines + 1] = "Buff detection: combat log"
	end
	lines[#lines + 1] = string.format("Auras secret now: %s", tostring(ns.AreAurasSecret()))
	lines[#lines + 1] =
		string.format("Buff tracking ready: %s", tostring(ns.IsBuffTrackingReady and ns.IsBuffTrackingReady()))
	lines[#lines + 1] = string.format(
		"Sound: Sound_EnableAllSound=%s Sound_MasterVolume=%s",
		tostring(GetCVar("Sound_EnableAllSound")),
		tostring(GetCVar("Sound_MasterVolume"))
	)

	if db then
		local strangers, teammates, services = db.strangers or {}, db.teammates or {}, db.services or {}
		lines[#lines + 1] = string.format(
			"Strangers: enabled=%s print=%s whisper=%s emotes=%s emotesPicked=%s sound=%s  praiseDelay=%s/%s praiseCooldown=%s minDuration=%s cooldown=%s",
			tostring(strangers.enabled),
			tostring(strangers.printEnabled),
			tostring(strangers.whisperEnabled),
			tostring(strangers.emotesEnabled),
			EmotesPicked(strangers.emotes),
			tostring(strangers.soundEnabled),
			tostring(strangers.praiseDelayEnabled),
			tostring(strangers.praiseDelay),
			tostring(strangers.praiseCooldown),
			tostring(strangers.minBuffDuration),
			tostring(strangers.cooldown)
		)
		lines[#lines + 1] = string.format(
			"Teammates: enabled=%s print=%s whisper=%s emotes=%s emotesPicked=%s sound=%s  praiseDelay=%s/%s",
			tostring(teammates.enabled),
			tostring(teammates.printEnabled),
			tostring(teammates.whisperEnabled),
			tostring(teammates.emotesEnabled),
			EmotesPicked(teammates.emotes),
			tostring(teammates.soundEnabled),
			tostring(teammates.praiseDelayEnabled),
			tostring(teammates.praiseDelay)
		)
		lines[#lines + 1] = string.format(
			"Services: enabled=%s print=%s whisper=%s emotes=%s emotesPicked=%s sound=%s  praiseDelay=%s/%s",
			tostring(services.enabled),
			tostring(services.printEnabled),
			tostring(services.whisperEnabled),
			tostring(services.emotesEnabled),
			EmotesPicked(services.emotes),
			tostring(services.soundEnabled),
			tostring(services.praiseDelayEnabled),
			tostring(services.praiseDelay)
		)
		lines[#lines + 1] = string.format("Service Alerts entries live: %d", #(ns.ServiceEntries or {}))

		-- A blank saved template sends the default, so it reads as default here too.
		local goodNews = db.goodNews or {}
		local goodNewsOn, goodNewsTotal = CountOn(goodNews.watched)
		local message = goodNews.message
		local template = "default"
		if type(message) == "string" and not message:match("^%s*$") and message ~= ns.L["DEFAULT_GOOD_NEWS"] then
			template = string.format("custom (%d bytes)", #message)
		end
		lines[#lines + 1] = string.format(
			"Good News: whisper=%s scope=%s watched=%d/%d template=%s",
			tostring(goodNews.whisperEnabled),
			tostring(goodNews.scope),
			goodNewsOn,
			goodNewsTotal,
			template
		)

		local peerPressure = db.peerPressure or {}
		local peerOn, peerTotal = CountOn(peerPressure.watched)
		lines[#lines + 1] = string.format(
			"Peer Pressure: loaded=%s enabled=%s print=%s ownCasts=%s sound=%s watched=%d/%d",
			tostring(ns.CheckPeerPressure ~= nil),
			tostring(peerPressure.enabled),
			tostring(peerPressure.printEnabled),
			tostring(peerPressure.triggerOnOwnCasts),
			tostring(peerPressure.soundEnabled),
			peerOn,
			peerTotal
		)

		local watchedOn, watchedTotal = CountOn(db.watchedBuffs)
		lines[#lines + 1] = string.format("Watched buffs: %d enabled / %d total", watchedOn, watchedTotal)
	else
		lines[#lines + 1] = "Saved variables not initialized."
	end

	local tracked = ns.DIAGNOSTIC_TRACKED
	lines[#lines + 1] = string.format(
		"Tracked triggers live on this client: %d / %d entries  (aura ids=%d, cast ids=%d)",
		tracked.entriesLive or 0,
		tracked.entriesTotal or 0,
		tracked.auraIds or 0,
		tracked.castIds or 0
	)

	lines[#lines + 1] = ""
	lines[#lines + 1] = "Praise cooldowns:"
	if ns.GetPraiseCooldownState then
		lines[#lines + 1] =
			string.format("  Overall praise cooldown active: %s", tostring(ns.GetPraiseCooldownState(nil)))
	end
	lines[#lines + 1] = "  " .. CurrentTargetLine()

	lines[#lines + 1] = ""
	lines[#lines + 1] = "Tracked spells for your class (IsPlayerSpell):"
	local classSpells = class and ns.DIAGNOSTIC_SPELLS[class]
	if classSpells then
		for _, spellData in ipairs(classSpells) do
			lines[#lines + 1] = string.format("  %s = %s", spellData.name, tostring(KnowsAny(spellData.ids)))
		end
	else
		lines[#lines + 1] = "  (no tracked spells for this class)"
	end

	lines[#lines + 1] = ""
	lines[#lines + 1] = "Peer Pressure spells for your class (IsPlayerSpell):"
	if not ns.CheckPeerPressure then
		lines[#lines + 1] = "  (Peer Pressure is not loaded on this flavor)"
	else
		local category
		for _, candidate in ipairs(ns.PeerPressureCategories or {}) do
			if candidate.id == class then
				category = candidate
			end
		end
		if category then
			for _, entry in ipairs(category.entries) do
				lines[#lines + 1] = string.format("  %s = %s", entry.spellName, tostring(KnowsAny(entry.ids)))
			end
		else
			lines[#lines + 1] = "  (no Peer Pressure spells for this class)"
		end
	end

	-- Read only: the macros are looked up by name, never created or deleted here.
	lines[#lines + 1] = ""
	lines[#lines + 1] = "Thank You buttons:"
	if db then
		lines[#lines + 1] = string.format(
			"  Account macros: %s / %d (TFTB creates a macro only while the list is under the cap)",
			tostring(GetNumMacros()),
			ns.Data.MAX_GLOBAL_MACROS
		)
		for _, button in ipairs(ns.Data.THANK_YOU_BUTTONS) do
			local config = db[button.profileKey] or {}
			local message = config.message
			local whisper = "none"
			if type(message) == "string" and message ~= "" then
				whisper = string.format("%d bytes", #message)
			end
			local emote
			if button.singleEmote then
				local token = config.emote
				emote = string.format(
					"emote=%s valid=%s",
					(token and token ~= "") and tostring(token) or "none",
					tostring(ns.IsClientEmote(token))
				)
			else
				emote = "emotesPicked=" .. EmotesPicked(config.emotes)
			end
			lines[#lines + 1] = string.format(
				"  %s (%s): createMacro=%s macroPresent=%s whisper=%s %s",
				button.command,
				button.macroName,
				tostring(config.createMacro),
				tostring((GetMacroIndexByName(button.macroName) or 0) > 0),
				whisper,
				emote
			)
		end
	else
		lines[#lines + 1] = "  Saved variables not initialized."
	end

	return table.concat(lines, "\n")
end

--[[
    Every emote this client can perform, as a tab-separated table. The catalog
    is read from the running client's own globals, so running this on another
    flavor extracts that build's list with no code change. The voice column
    comes from the client's speech list, the only place an add-on can see it.
]]
function ns:BuildEmoteReport()
	local catalog = ns.GetEmoteCatalog()
	local lines = { GetClientHeader(), "" }
	lines[#lines + 1] = string.format("%d emotes", #catalog)
	lines[#lines + 1] = ""
	lines[#lines + 1] = "index\ttoken\tcommands\tvoice"
	for _, emote in ipairs(catalog) do
		lines[#lines + 1] =
			string.format("%d\t%s\t%s\t%s", emote.index, emote.token, emote.aliases, emote.voice and "voice" or "")
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Combat Cast Probe
--------------------------------------------------------------------------------

--[[
    The event log's per-id filter asks this whether a firing of an id-filtered
    event (ns.MESSAGE_ID_FILTERED_EVENTS) is one TFTB acts on. For
    UNIT_SPELLCAST_SUCCEEDED that is a spell id the live lookups hold -- a
    service or other cast entry, or a buff you can give for Good News -- the
    same lookups the handlers match against. Everything else is counted.
]]
function ns.IsCorrelatedMessage(event, id)
	if event == "UNIT_SPELLCAST_SUCCEEDED" then
		return ns.GetCastEntry(id) ~= nil or ns.GetGivenEntry(id) ~= nil
	end
	return false
end

--[[
    The "why isn't this cast announced" and "why wasn't I thanked for that
    buff" cases (portals, summons, feasts, jumper cables, buffs on you).
    COMBAT_LOG_EVENT_UNFILTERED is excluded from the log as a firehose, so the
    buff engine calls this for each SPELL_CAST_SUCCESS and SPELL_RESURRECT, and
    for each SPELL_AURA_APPLIED or SPELL_AURA_REFRESH that lands on you
    (labelled AURA), while logging is on, before any of its own filtering.

    An aura on you, and a cast or revive TFTB acts on (a tracked entry, a buff
    you give for Good News, or a Peer Pressure cooldown), records in full:
    spell id and name, source, the decoded affiliation/reaction flags, and
    whether the add-on tracks and watches that id. tracked=true watched=true
    means the cast reached the add-on and the issue is downstream. A cable that
    revives nobody logs CAST with no REZ after it. Every other cast is counted
    by spell id in the log's summary instead, so a busy raid can't push the
    signal out of the buffer; a portal missing from the data still shows its id
    and name there.
]]
function ns:LogCombatCast(spellID, sourceName, sourceFlags, tracked, watched, label)
	label = label or "CAST"
	local name = C_Spell.GetSpellName(spellID) or "?"
	local correlated = label == "AURA"
		or tracked
		or ns.GetGivenEntry(spellID) ~= nil
		or (ns.IsPeerPressureSpell and ns.IsPeerPressureSpell(spellID))
	if not correlated then
		ns:CountUncorrelated("COMBAT_LOG_EVENT_UNFILTERED", spellID, label .. " " .. name)
		return
	end

	local flags = sourceFlags or 0
	local affiliation = (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 and "MINE")
		or (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0 and "PARTY")
		or (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_RAID) > 0 and "RAID")
		or (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0 and "OUTSIDER")
		or "?"
	ns:LogEventNow(
		"COMBAT_LOG_EVENT_UNFILTERED",
		label,
		spellID,
		name,
		sourceName,
		string.format(
			"player=%s friendly=%s aff=%s",
			tostring(bit.band(flags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0),
			tostring(bit.band(flags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0),
			affiliation
		),
		"tracked=" .. tostring(tracked and true or false),
		"watched=" .. tostring(watched and true or false)
	)
end

--[[
    Forever's version of the case above: UNIT_AURA is excluded from the log
    because its update table can't be written as text, so the buff engine calls
    this for each helpful aura added to you (or one whose helpfulness is
    secret), and once for a full update, while logging is on. verdict is the
    first gate that stops the update -- not ready, no db, in combat, auras
    secret, full update -- or read when the aura goes on to be classified.
    tracked=true watched=true with verdict read means the buff reached the
    add-on and the issue is downstream. A secret value is never tested here:
    ns:LogEventNow writes it as <secret>, and the id-keyed reads are skipped.
]]
function ns:LogAuraUpdate(verdict, aura)
	if not ns.IsPlain(aura) then
		ns:LogEventNow("UNIT_AURA", "ADDED", verdict, aura)
		return
	end
	if aura == nil then
		ns:LogEventNow("UNIT_AURA", "FULL", verdict)
		return
	end
	local spellID = aura.spellId
	local name, tracked, watched = nil, "?", "?"
	if ns.IsPlain(spellID) and spellID then
		name = C_Spell.GetSpellName(spellID)
		tracked = tostring(ns.GetAuraEntry(spellID) ~= nil)
		watched = tostring(ns.db and ns.db.profile.watchedBuffs[spellID] and true or false)
	end
	ns:LogEventNow(
		"UNIT_AURA",
		"ADDED",
		verdict,
		spellID,
		name or "?",
		aura.sourceUnit,
		"tracked=" .. tracked,
		"watched=" .. watched
	)
end

--------------------------------------------------------------------------------
-- Game Names
--------------------------------------------------------------------------------

local function SortedKeys(set)
	local keys = {}
	for key in pairs(set) do
		keys[#keys + 1] = key
	end
	table.sort(keys)
	return keys
end

--[[
    Every game record TFTB names by ID, for the Localization tab's Game Names
    report, built at report time so it follows this client's data. Each row is
    { constant, kind, id, lookup }, and lookup is the exact call the features
    make:

    - every ns.GAME_IDS constant, a spell named through C_Spell.GetSpellName
      (what ns.GetSpellLink builds the panel samples from);
    - every class token this client's tracked and Peer Pressure data carries,
      named through LOCALIZED_CLASS_NAMES_MALE as the panels show it;
    - the client's duration strings, through ns.FormatDuration as the Good News
      whisper uses them, with the sample count in the ID cell.

    TFTB names no item by constant. An item row would need Validate Data's
    request-and-settle, since an item name can be nil until it loads.
]]
ns.DIAGNOSTIC_NAME_LOOKUPS = function()
	local rows = {}

	for _, constant in ipairs(SortedKeys(ns.GAME_IDS or {})) do
		local id = ns.GAME_IDS[constant]
		rows[#rows + 1] = {
			constant = constant,
			kind = "spell",
			id = id,
			lookup = function()
				return C_Spell.GetSpellName(id)
			end,
		}
	end

	local classes = {}
	for _, entry in ipairs(ns.TRACKED_ABILITIES or {}) do
		if entry.class then
			classes[entry.class] = true
		end
	end
	for _, row in ipairs(ns.PEER_PRESSURE_ABILITIES or {}) do
		if row[1] then
			classes[row[1]] = true
		end
	end
	for _, token in ipairs(SortedKeys(classes)) do
		rows[#rows + 1] = {
			constant = token,
			kind = "class",
			id = token,
			lookup = function()
				return LOCALIZED_CLASS_NAMES_MALE[token]
			end,
		}
	end

	local durations = { { "D_SECONDS", 1 }, { "D_SECONDS", 15 }, { "D_MINUTES", 120 }, { "D_HOURS", 7200 } }
	for _, duration in ipairs(durations) do
		local seconds = duration[2]
		rows[#rows + 1] = {
			constant = duration[1],
			kind = "global string",
			id = seconds,
			lookup = function()
				return ns.FormatDuration(seconds)
			end,
		}
	end

	return rows
end

--------------------------------------------------------------------------------
-- Message Length
--------------------------------------------------------------------------------

-- A macro body's ceiling, measured in bytes with #body, as the Style Guide's Message Length rule asks.
local MACRO_MAX_LENGTH = 255

--[[
    Every whisper and macro TFTB sends or writes, for the Localization tab's
    Message Length report, built at report time through the add-on's own
    builders with the longest names this client's data holds in this locale.
    Returns rows of { label, ceiling, text } and a list of notes. The ceiling
    is in bytes, so the overflow canary is the widest-encoding locale, usually
    ruRU.

    The longest link is the longest of ns.GetBuffLink over every trigger live
    on this client, the same link the thank-you and Good News whispers carry.
    An item link is only as long as its cached name, so items not loaded yet
    are counted into a note.
]]
ns.DIAGNOSTIC_MESSAGES = function()
	local longestLink, longestGivenLink, unloaded = "", "", 0
	for _, entry in ipairs(ns.TRACKED_ABILITIES or {}) do
		for _, trigger in ipairs(entry.triggers or {}) do
			local watched = trigger.aura or trigger.spell
			if C_Spell.DoesSpellExist(trigger.spell) or C_Spell.DoesSpellExist(watched) then
				if trigger.item and not select(2, C_Item.GetItemInfo(trigger.item)) then
					unloaded = unloaded + 1
				end
				local link = ns.GetBuffLink({ itemId = trigger.item }, watched)
				if #link > #longestLink then
					longestLink = link
				end
				if ns.GetGivenEntry(trigger.spell) and #link > #longestGivenLink then
					longestGivenLink = link
				end
			end
		end
	end

	local rows = {
		{
			label = "Thank-you whisper",
			ceiling = ns.CHAT_MESSAGE_MAX_LENGTH,
			text = ns:BuildAnnounceMessage("MESSAGE_WHISPER_THANKS", longestLink),
		},
		-- 59 seconds forces the longest duration clause the whisper ever carries.
		{
			label = "Good News whisper",
			ceiling = ns.CHAT_MESSAGE_MAX_LENGTH,
			text = ns:BuildGoodNewsMessage(longestGivenLink, 59),
		},
	}

	local profile = ns.db and ns.db.profile
	for _, button in ipairs(ns.Data.THANK_YOU_BUTTONS) do
		local config = profile and profile[button.profileKey]
		local message = config and config.message
		if type(message) == "string" and message ~= "" then
			rows[#rows + 1] = {
				label = "Thank You whisper (" .. button.command .. ")",
				ceiling = ns.CHAT_MESSAGE_MAX_LENGTH,
				text = message,
			}
		end
	end
	for _, button in ipairs(ns.Data.THANK_YOU_BUTTONS) do
		rows[#rows + 1] = {
			label = "Thank You macro (" .. button.macroName .. ")",
			ceiling = MACRO_MAX_LENGTH,
			text = button.command,
		}
	end

	local notes = {}
	if unloaded > 0 then
		notes[1] = string.format("%d items not loaded yet; the longest link may be understated.", unloaded)
	end
	return rows, notes
end

--------------------------------------------------------------------------------
-- Validate Data Sources
--------------------------------------------------------------------------------

--[[
    One entry per data file, and one report row per entry on the Data tab
    (Diagnostics/Options-Diagnostics.lua). Each entry's label is the table-name
    part of its file name, so ns.DataSourceFileName can name the file this
    client's folder built. Each source names the static table on ns and its kind,
    and reaches its ids through collect(tbl), which returns { id, key, row }
    entries. dataColumns carries the shipped row's own values as
    { header, getter(key, row) }, so the export sets what the file says beside
    what the client says.
]]
local function TrackedCollector(kind)
	return function(entries)
		local found = {}
		for index, entry in ipairs(entries) do
			for _, trigger in ipairs(entry.triggers or {}) do
				local roles = kind == "item" and { item = trigger.item }
					or { cast = trigger.spell, aura = trigger.aura }
				for role, id in pairs(roles) do
					found[#found + 1] =
						{ id = id, key = index, row = { entry = entry, trigger = trigger, role = role } }
				end
			end
		end
		return found
	end
end

local function EntryField(field)
	return function(_, row)
		return row.entry[field]
	end
end

local function CollectPeerPressure(rows)
	local found = {}
	for index, row in ipairs(rows) do
		for _, id in ipairs(row[2] or {}) do
			found[#found + 1] = { id = id, key = index, row = row }
		end
	end
	return found
end

ns.DIAGNOSTIC_DATA_SOURCES = {
	-- { label, sources = { { table, kind, collect, dataColumns } } }
	{
		label = "Tracked-Abilities",
		sources = {
			{
				table = "TRACKED_ABILITIES",
				kind = "spell",
				collect = TrackedCollector("spell"),
				dataColumns = {
					{
						"DATA_ROLE",
						function(_, row)
							return row.role
						end,
					},
					{ "DATA_TYPE", EntryField("type") },
					{ "DATA_DETECT", EntryField("detect") },
					{ "DATA_CLASS", EntryField("class") },
					{ "DATA_RECEIVED", EntryField("received") },
					{ "DATA_GIVEN", EntryField("given") },
				},
			},
			{
				table = "TRACKED_ABILITIES",
				kind = "item",
				collect = TrackedCollector("item"),
				dataColumns = {
					{
						"DATA_SPELL_ID",
						function(_, row)
							return row.trigger.spell
						end,
					},
					{ "DATA_TYPE", EntryField("type") },
				},
			},
		},
	},
	{
		label = "Game-IDs",
		sources = {
			{
				table = "GAME_IDS",
				kind = "spell",
				collect = function(ids)
					local found = {}
					for constant, id in pairs(ids) do
						found[#found + 1] = { id = id, key = constant, row = id }
					end
					return found
				end,
				dataColumns = {
					{
						"DATA_CONSTANT",
						function(key)
							return key
						end,
					},
				},
			},
		},
	},
	{
		label = "Peer-Pressure-Abilities",
		sources = {
			{
				table = "PEER_PRESSURE_ABILITIES",
				kind = "spell",
				collect = CollectPeerPressure,
				dataColumns = {
					{
						"DATA_CLASS",
						function(_, row)
							return row[1]
						end,
					},
					{
						"DATA_DEFAULT",
						function(_, row)
							return row[3]
						end,
					},
				},
			},
		},
	},
}
