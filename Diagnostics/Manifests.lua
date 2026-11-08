local _, ns = ...

local GetClientHeader = ns.GetDiagnosticClientHeader

--------------------------------------------------------------------------------
-- API Endpoints
--------------------------------------------------------------------------------

--[[
    Existence and shape checks only: read-only, no side effects, no protected
    calls. One row per API TFTB actually calls or guards, wherever it lives --
    nothing incidental, and nothing the add-on does not use.

    Every modern/legacy pair the add-on still picks between is listed as both
    halves: Validate Data's tooltip-text read (C_TooltipInfo.GetItemByID and
    GetSpellByID, or the hidden scan tooltip). Rows for one flavor's buff
    detection are added only on that flavor, below.
    The hidden tooltip is probed through the GameTooltip methods it inherits,
    so the check creates nothing. A FAIL on one half is the report working
    rather than a defect: the pair tells a bug report which branch that client
    took.
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

-- CreateFrame throws on a template the client doesn't ship, so each one the add-on names gets a row.
local function HasTemplate(name)
	return function()
		local xml = _G.C_XMLUtil
		return type(xml) == "table" and type(xml.GetTemplateInfo) == "function" and xml.GetTemplateInfo(name) ~= nil
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
	{ "Settings.OpenToCategory", HasFunction("Settings", "OpenToCategory") },
	{ "InCombatLockdown", HasGlobalFunction("InCombatLockdown") },
	{ "C_Timer.After", HasFunction("C_Timer", "After") },
	{ "C_EventUtils.IsEventValid", HasFunction("C_EventUtils", "IsEventValid") },
	{ "C_Spell.GetSpellName", HasFunction("C_Spell", "GetSpellName") },
	{ "C_Spell.GetSpellDescription", HasFunction("C_Spell", "GetSpellDescription") },
	{ "C_Spell.RequestLoadSpellData", HasFunction("C_Spell", "RequestLoadSpellData") },
	{ "C_Spell.IsSpellDataCached", HasFunction("C_Spell", "IsSpellDataCached") },
	{ "C_Spell.GetSpellLink", HasFunction("C_Spell", "GetSpellLink") },
	-- Ignored Buffs' row icons; a client without it lists each buff by name alone.
	{ "C_Spell.GetSpellTexture (guarded)", HasFunction("C_Spell", "GetSpellTexture") },
	{ "C_UnitAuras.GetBuffDataByIndex", HasFunction("C_UnitAuras", "GetBuffDataByIndex") },
	{ "issecretvalue", HasGlobalFunction("issecretvalue") },
	{ "GetPlayerInfoByGUID", HasGlobalFunction("GetPlayerInfoByGUID") },
	{ "Ambiguate", HasGlobalFunction("Ambiguate") },
	{ "C_ChatInfo.SendChatMessage", HasFunction("C_ChatInfo", "SendChatMessage") },
	{ "C_ChatInfo.PerformEmote", HasFunction("C_ChatInfo", "PerformEmote") },
	-- The emote catalog reads both when present and falls back without them.
	{
		"MAXEMOTEINDEX (guarded)",
		function()
			return type(MAXEMOTEINDEX) == "number"
		end,
	},
	{
		"TextEmoteSpeechList (guarded)",
		function()
			return type(TextEmoteSpeechList) == "table"
		end,
	},
	{ "UnitIsVisible", HasGlobalFunction("UnitIsVisible") },
	{ "UnitInRange", HasGlobalFunction("UnitInRange") },
	{ "CreateMacro", HasGlobalFunction("CreateMacro") },
	{ "EditMacro", HasGlobalFunction("EditMacro") },
	{ "DeleteMacro", HasGlobalFunction("DeleteMacro") },
	{ "GetMacroIndexByName", HasGlobalFunction("GetMacroIndexByName") },
	{ "GetNumMacros", HasGlobalFunction("GetNumMacros") },
	{ "GetMacroInfo", HasGlobalFunction("GetMacroInfo") },
	{ "PlaySoundFile", HasGlobalFunction("PlaySoundFile") },
	-- Validate Data's spell tooltip read: C_TooltipInfo where the client ships both getters, else the scan tooltip.
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
	{ "C_XMLUtil.GetTemplateInfo", HasFunction("C_XMLUtil", "GetTemplateInfo") },
	{ "GameTooltipTemplate", HasTemplate("GameTooltipTemplate") },
	-- Display Context's screen read, and the taintLog button.
	{ "GetPhysicalScreenSize", HasGlobalFunction("GetPhysicalScreenSize") },
	{ "GetCVar", HasGlobalFunction("GetCVar") },
	{ "SetCVar", HasGlobalFunction("SetCVar") },
}

--[[
    Each flavor's buff detection, probed only where it runs: WoW Forever reads
    UNIT_AURA and names a caster out of nameplate range from its GUID, and asks
    C_Secrets before every read; every other flavor reads the combat log.
]]
if ns.FLAVOR == "Camelot" then
	local checks = ns.DIAGNOSTIC_API_CHECKS
	checks[#checks + 1] = { "C_UnitAuras.GetAuraCasterGUID", HasFunction("C_UnitAuras", "GetAuraCasterGUID") }
	checks[#checks + 1] = { "UnitNameFromGUID", HasGlobalFunction("UnitNameFromGUID") }
	checks[#checks + 1] =
		{ "C_Secrets.ShouldUnitIdentityBeSecret", HasFunction("C_Secrets", "ShouldUnitIdentityBeSecret") }
	checks[#checks + 1] = { "C_Secrets.ShouldAurasBeSecret", HasFunction("C_Secrets", "ShouldAurasBeSecret") }
else
	local checks = ns.DIAGNOSTIC_API_CHECKS
	checks[#checks + 1] = { "CombatLogGetCurrentEventInfo", HasGlobalFunction("CombatLogGetCurrentEventInfo") }
	checks[#checks + 1] = {
		"COMBATLOG_OBJECT_* affiliation / reaction / type flags",
		function()
			return COMBATLOG_OBJECT_TYPE_PLAYER ~= nil
				and COMBATLOG_OBJECT_REACTION_FRIENDLY ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_MINE ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_PARTY ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_RAID ~= nil
				and COMBATLOG_OBJECT_AFFILIATION_OUTSIDER ~= nil
		end,
	}
	checks[#checks + 1] = {
		"bit.band",
		function()
			return type(bit) == "table" and type(bit.band) == "function"
		end,
	}
end

--------------------------------------------------------------------------------
-- Buff Reactions Context
--------------------------------------------------------------------------------

--[[
    The probes read feature state through the accessors the feature files
    expose (ns.IsBuffTrackingReady, ns.GetPraiseCooldownState,
    ns.GetThankYouIcon and the like), so a report shows the values the features
    act on rather than a copy of their logic.
]]

-- The add-on's own example reports, appended to the shared Event Log intro.
ns.DiagnosticsStrings.EVENT_LOG_EXAMPLES =
	"Best for 'nobody got thanked' reports. It records each buff that lands on you, decoded: the spell, who cast it, how long it lasts, and, off WoW Forever, whether the combat log calls them a friendly player outside your group. On WoW Forever it records each buff added to you with the gate, if any, that kept TFTB from reading it."

--[[
    How many emotes a list has picked, out of how many this client offers, and
    how many picks this client can't perform. Those are skipped when the random
    pick is made, so they only matter when they are all a list has.
]]
local function EmotesPicked(emotes)
	local picked, missing = 0, 0
	if type(emotes) == "table" then
		for token, on in pairs(emotes) do
			if on then
				picked = picked + 1
				if not ns.IsClientEmote(token) then
					missing = missing + 1
				end
			end
		end
	end
	local text = string.format("%d/%d", picked, #ns.GetEmoteCatalog())
	if missing > 0 then
		text = text .. string.format(" (%d NOT ON CLIENT)", missing)
	end
	return text
end

-- A whisper's length, or none when it is empty and so never sent.
local function WhisperLength(message)
	if type(message) == "string" and message ~= "" then
		return string.format("%d bytes", #message)
	end
	return "none"
end

--[[
    The buffs Give Thanks never thanks for on this character -- the All
    Characters list and this character's own, one call each -- by ID and this
    client's name for each. A buff on the list still prints and plays the sound; it only goes
    unthanked, which is a "nobody got thanked" report on its own.
]]
local function IgnoredBuffLines(lines, ignoredBuffs, scopeName)
	local ids = {}
	for spellId, on in pairs(type(ignoredBuffs) == "table" and ignoredBuffs or {}) do
		if on and type(spellId) == "number" then
			ids[#ids + 1] = spellId
		end
	end
	table.sort(ids)
	lines[#lines + 1] =
		string.format("Ignored buffs (%s): %d (each still notifies you, but is never thanked)", scopeName, #ids)
	for _, spellId in ipairs(ids) do
		lines[#lines + 1] = string.format("  %d %s", spellId, C_Spell.GetSpellName(spellId) or "NOT ON CLIENT")
	end
end

--[[
    How this client's emotes sort into the Give Thanks panel's groups, read
    through ns.GetEmoteGroup as the panel reads them. Every emote lands in Text
    when this flavor's Emote-Groups file never loaded, which empties the other
    groups.
]]
local function EmoteGroupsLine()
	local counts = {}
	for _, emote in ipairs(ns.GetEmoteCatalog()) do
		local group = ns.GetEmoteGroup(emote.token)
		counts[group] = (counts[group] or 0) + 1
	end
	local parts = {}
	for _, group in ipairs(ns.Data.EMOTE_GROUPS) do
		parts[#parts + 1] = string.format("%s=%d", group, counts[group] or 0)
	end
	return string.format(
		"Emote groups (%s/Emote-Groups-%s.lua %s): %s",
		tostring(ns.DATA_FOLDER),
		tostring(ns.DATA_FOLDER),
		type(ns.EMOTE_GROUP_BY_TOKEN) == "table" and "loaded" or "MISSING",
		table.concat(parts, " ")
	)
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
    the Thank You Button's player, self and faction checks, whether they're
    friendly and in your party or raid (Give Thanks reacts only to friendly
    players outside it), whether they could see an emote (visible, and in range
    where the client checks that, as Praise.lua's CanWitnessEmote reads them),
    and the per-source praise and whisper throttles for that GUID. A target
    whose identity is secret (WoW Forever) is reported as such and never read
    further.
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
	local inParty, inRaid = UnitInParty("target"), UnitInRaid("target")
	local inGroup = "<secret>"
	if ns.IsPlain(inParty) and ns.IsPlain(inRaid) then
		inGroup = tostring((inParty or inRaid) and true or false)
	end
	local inRange, checkedRange = UnitInRange("target")
	local range = "<secret>"
	if ns.IsPlain(inRange) and ns.IsPlain(checkedRange) then
		range = checkedRange and tostring(inRange and true or false) or "unchecked"
	end
	local line = string.format(
		"Current target: player=%s self=%s friend=%s sameFaction=%s inGroup=%s visible=%s inRange=%s",
		PlainText(UnitIsPlayer("target")),
		PlainText(UnitIsUnit("target", "player")),
		PlainText(UnitIsFriend("player", "target")),
		sameFaction,
		inGroup,
		PlainText(UnitIsVisible("target")),
		range
	)
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
    post-loading-screen pause, combat, WoW Forever's secret auras), every
    Give Thanks switch, its whisper text, picked emotes, minimum duration,
    praise throttles and Ignored Buffs, how this client's emotes sort into the
    panel's groups, the sound settings the Master channel answers to, where
    /tftb goes, and what stops each Thank You button: its command, its toggle,
    its macro and the icon it wears, its whisper text and its emotes.
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
	-- The route ns:OpenOptionsPanel takes for /tftb.
	local categoryID = ns.optionsFrames and ns.optionsFrames.categoryID
	lines[#lines + 1] = string.format(
		"Options panel: category id %s, opened through %s",
		tostring(categoryID),
		(type(Settings) == "table" and Settings.OpenToCategory and categoryID) and "Settings.OpenToCategory"
			or "AceConfigDialog:Open"
	)
	lines[#lines + 1] = string.format(
		"Grouped: party=%s raid=%s  InCombat=%s",
		tostring(IsInGroup() and true or false),
		tostring(IsInRaid() and true or false),
		tostring(InCombatLockdown() and true or false)
	)
	--[[
	    Set up is false when the login setup never ran. Ready is false until the
	    safety timer armed at login, and again after every loading screen, runs out.
	]]
	lines[#lines + 1] = string.format(
		"Buff tracking set up: %s  Ready (past the post-loading-screen pause): %s",
		tostring(ns.IsBuffTrackingSetUp and ns.IsBuffTrackingSetUp()),
		tostring(ns.IsBuffTrackingReady and ns.IsBuffTrackingReady())
	)
	if ns.FLAVOR == "Camelot" then
		lines[#lines + 1] =
			"Buff detection: UNIT_AURA (WoW Forever has no combat log; skipped in combat and while auras are secret)"
	else
		lines[#lines + 1] = "Buff detection: combat log"
	end
	lines[#lines + 1] = string.format("Auras secret now: %s", tostring(ns.AreAurasSecret()))
	lines[#lines + 1] = string.format(
		"Sound: Sound_EnableAllSound=%s Sound_MasterVolume=%s",
		tostring(GetCVar("Sound_EnableAllSound")),
		tostring(GetCVar("Sound_MasterVolume"))
	)

	if db then
		local strangers = db.strangers or {}
		lines[#lines + 1] = string.format(
			"Give Thanks: enabled=%s print=%s whisper=%s whisperText=%s emotesPicked=%s sound=%s  praiseDelay=%s/%s praiseCooldown=%s minDuration=%s cooldown=%s",
			tostring(strangers.enabled),
			tostring(strangers.printEnabled),
			tostring(strangers.whisperEnabled),
			WhisperLength(strangers.whisperMessage),
			EmotesPicked(strangers.emotes),
			tostring(strangers.soundEnabled),
			tostring(strangers.praiseDelayEnabled),
			tostring(strangers.praiseDelay),
			tostring(strangers.praiseCooldown),
			tostring(strangers.minBuffDuration),
			tostring(strangers.cooldown)
		)
		IgnoredBuffLines(lines, ns.GetIgnoredBuffsForScope(ns.LIST_SCOPE_GLOBAL), "All Characters")
		IgnoredBuffLines(lines, ns.GetIgnoredBuffsForScope(ns.db.keys.char), "this character")
	else
		lines[#lines + 1] = "Saved variables not initialized."
	end
	lines[#lines + 1] = EmoteGroupsLine()

	lines[#lines + 1] = ""
	lines[#lines + 1] = "Praise cooldowns:"
	if ns.GetPraiseCooldownState then
		lines[#lines + 1] =
			string.format("  Overall praise cooldown active: %s", tostring(ns.GetPraiseCooldownState(nil)))
	end
	lines[#lines + 1] = "  " .. CurrentTargetLine()

	-- Read only: the macros are looked up by name, never created or deleted here.
	lines[#lines + 1] = ""
	lines[#lines + 1] = "Thank You buttons:"
	if db then
		lines[#lines + 1] = string.format(
			"  Account macros: %s / %d (TFTB creates a macro only while the list is under the cap, and never in combat)",
			tostring(GetNumMacros()),
			ns.Data.MAX_GLOBAL_MACROS
		)
		for index, button in ipairs(ns.Data.THANK_YOU_BUTTONS) do
			local config = db[button.profileKey] or {}
			local whisper = WhisperLength(config.message)
			local emote
			if button.singleEmote then
				local token = config.emote
				if token and token ~= "" then
					emote = string.format("emote=%s valid=%s", tostring(token), tostring(ns.IsClientEmote(token)))
				else
					emote = "emote=none"
				end
			else
				emote = "emotesPicked=" .. EmotesPicked(config.emotes)
			end
			-- A macro the player edited no longer runs the command, so the button does nothing.
			local macroIndex = GetMacroIndexByName(button.macroName) or 0
			local macro = "missing"
			if macroIndex == 0 and config.createMacro and GetNumMacros() >= ns.Data.MAX_GLOBAL_MACROS then
				macro = "missing (macro list FULL)"
			elseif macroIndex > 0 then
				local _, _, body = _G.GetMacroInfo(macroIndex)
				macro = (body and body:gsub("%s+$", "") == button.command) and "runs command" or "BODY EDITED"
			end
			-- A picked icon this client's list lacks falls back to the default, since profiles travel between flavors.
			local icon = ns.GetThankYouIcon and ns.GetThankYouIcon(config)
			local iconText = tostring(icon)
			if config.macroIcon ~= nil and config.macroIcon ~= icon then
				iconText = iconText .. string.format(" (picked %s NOT ON CLIENT)", tostring(config.macroIcon))
			end
			lines[#lines + 1] = string.format(
				"  %s (%s): command=%s createMacro=%s macro=%s icon=%s whisper=%s %s",
				button.command,
				button.macroName,
				SlashCmdList["TFTB_THANKYOU" .. index] and "registered" or "MISSING",
				tostring(config.createMacro),
				macro,
				iconText,
				whisper,
				emote
			)
		end
	else
		lines[#lines + 1] = "  Saved variables not initialized."
	end

	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Emote Extract
--------------------------------------------------------------------------------

--[[
    Every emote this client can perform, as a tab-separated table. The catalog
    is read from the running client's own globals, so running this on another
    flavor extracts that build's list with no code change. The voice column
    comes from the client's speech list, the only place an add-on can see it,
    and the group column is the one this flavor's Emote-Groups file gives it,
    read through ns.GetEmoteGroup as the Give Thanks panel reads it.
]]
function ns:BuildEmoteReport()
	local catalog = ns.GetEmoteCatalog()
	local lines = { GetClientHeader(), "" }
	lines[#lines + 1] = string.format("%d emotes", #catalog)
	lines[#lines + 1] = ""
	lines[#lines + 1] = "index\ttoken\tcommands\tvoice\tgroup"
	for _, emote in ipairs(catalog) do
		lines[#lines + 1] = string.format(
			"%d\t%s\t%s\t%s\t%s",
			emote.index,
			emote.token,
			emote.aliases,
			emote.voice and "voice" or "",
			ns.GetEmoteGroup(emote.token)
		)
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Buff Probes
--------------------------------------------------------------------------------

--[[
    The "why wasn't I thanked for that buff" case. COMBAT_LOG_EVENT_UNFILTERED
    is excluded from the log as a firehose, so the buff engine calls this for
    each SPELL_AURA_APPLIED or SPELL_AURA_REFRESH that lands on you while
    logging is on, before any of its own filtering, and it records in full
    (labeled AURA): spell id and name, source, the decoded type, reaction and
    affiliation flags, and the buff's duration as Give Thanks reads it. A
    stranger's buff reads friendly=true aff=OUTSIDER from a player; one that
    does and still went unthanked reached the add-on, and the issue is
    downstream: duration=nil (the buff wasn't found on you), a duration under
    the minimum, a switch, an ignored buff or a cooldown, the last four on Buff
    Reactions Context. Your own buffs log too, and are never thanked.
]]
function ns:LogAuraApplied(spellID, sourceName, sourceFlags)
	local flags = sourceFlags or 0
	local affiliation = (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 and "MINE")
		or (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0 and "PARTY")
		or (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_RAID) > 0 and "RAID")
		or (bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0 and "OUTSIDER")
		or "?"
	ns:LogEventNow(
		"COMBAT_LOG_EVENT_UNFILTERED",
		"AURA",
		spellID,
		C_Spell.GetSpellName(spellID) or "?",
		sourceName,
		string.format(
			"player=%s friendly=%s aff=%s duration=%s",
			tostring(bit.band(flags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0),
			tostring(bit.band(flags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0),
			affiliation,
			tostring(ns.GetBuffDuration("player", spellID))
		)
	)
end

--[[
    Forever's version of the case above: UNIT_AURA is excluded from the log
    because its update table can't be written as text, so the buff engine calls
    this for each helpful aura added to you (or one whose helpfulness is
    secret), and once for a full update, while logging is on. verdict is the
    first gate that stops the update -- not ready, no db, in combat, auras
    secret, full update -- or read when the aura goes on to be classified.
    verdict read means the buff reached the add-on and the issue is
    downstream, so a read aura also carries its duration as Give Thanks
    reads it (nil when it isn't found on you). A secret value is never tested
    here: ns:LogEventNow writes it as <secret>, and the name and duration
    reads are skipped.
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
	local name, duration
	if ns.IsPlain(spellID) and spellID then
		name = C_Spell.GetSpellName(spellID)
		if verdict == "read" then
			duration = "duration=" .. tostring(ns.GetBuffDuration("player", spellID))
		end
	end
	ns:LogEventNow("UNIT_AURA", "ADDED", verdict, spellID, name or "?", aura.sourceUnit, duration)
end

--------------------------------------------------------------------------------
-- Name Lookups
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
    The command this client gives an emote token, through ns.GetEmoteCommand as
    the panels name it; nil when the client has no such emote, where the
    accessor would fall back to the bare token.
]]
local function EmoteCommand(token)
	return ns.IsClientEmote(token) and ns.GetEmoteCommand(token) or nil
end

--[[
    Every record TFTB shows or matches by the name this client gives it, for
    the Localization tab's Game Names report, built at load from this client's
    data. Each row reads the name exactly as the features do:

    - every ns.GAME_IDS constant, a spell named through C_Spell.GetSpellName
      (what ns.GetSpellLink builds the panel samples from), requested when it
      loads late;
    - the client's seconds string, through ns.FormatDuration as the options
      panels' cooldown, duration and Praise Delay dropdowns label their
      choices, with the sample count in the ID cell;
    - every curated emote token the Give Thanks and Thank You panels pick
      from, named by the command this client gives it (NIL means the client has
      no such emote, so a pick of it never plays).

    TFTB names no item by constant.
]]
ns.DIAGNOSTIC_NAME_LOOKUPS = {}

do
	local rows = ns.DIAGNOSTIC_NAME_LOOKUPS

	for _, constant in ipairs(SortedKeys(ns.GAME_IDS or {})) do
		local id = ns.GAME_IDS[constant]
		rows[#rows + 1] = {
			constant = constant,
			kind = "spell",
			id = id,
			lookup = function()
				return C_Spell.GetSpellName(id)
			end,
			request = function()
				C_Spell.RequestLoadSpellData(id)
			end,
		}
	end

	for _, seconds in ipairs({ 1, 15 }) do
		rows[#rows + 1] = {
			constant = "D_SECONDS",
			kind = "globalString",
			id = seconds,
			lookup = function()
				return ns.FormatDuration(seconds, true)
			end,
		}
	end

	for _, emote in ipairs(ns.Data.EMOTES) do
		local token = emote.token
		rows[#rows + 1] = {
			constant = token,
			kind = "emote",
			id = token,
			lookup = function()
				return EmoteCommand(token)
			end,
		}
	end
end

--------------------------------------------------------------------------------
-- Message Length
--------------------------------------------------------------------------------

-- A macro body's ceiling, measured in bytes with #body, as the Style Guide's Message Length rule asks.
local MACRO_MAX_LENGTH = 255

--[[
    Every whisper and macro TFTB sends or writes, for the Localization tab's
    Message Length report, built at report time through the add-on's own
    builders. Returns rows of { label, ceiling, text } and a list of notes. The
    ceiling is in bytes, so the overflow canary is the widest-encoding locale,
    usually ruRU.

    The Give Thanks thank-you whisper, in the player's own words, carries the link of whatever buff
    landed, and no list of buffs bounds that, so it is built with the panels'
    sample spell (ns.GAME_IDS.SAMPLE_BUFF_SPELL_ID) and a note says how long
    any buff's link can run before the whisper goes over. A whisper that runs
    over is sent as the default text instead, so the row never reads OVER, and
    a second note says when the player's own text fell back. Each Thank You
    button's whisper is the player's own text, shown only when set, and each
    macro body is its button's command.
]]
ns.DIAGNOSTIC_MESSAGES = function()
	local rows, notes = {}, {}

	local sampleID = ns.GAME_IDS and ns.GAME_IDS.SAMPLE_BUFF_SPELL_ID
	local sampleLink = sampleID and ns.GetBuffLink(sampleID) or ""
	local strangers = ns.db and ns.db.profile.strangers
	local defaultTemplate = ns.L["DEFAULT_GIVE_THANKS_WHISPER"]
	local template = strangers and strangers.whisperMessage or defaultTemplate
	local whisper = ns:BuildThanksWhisper(template, sampleLink) or ""
	rows[#rows + 1] = {
		label = "Thank-you whisper",
		ceiling = ns.CHAT_MESSAGE_MAX_LENGTH,
		text = whisper,
	}
	notes[#notes + 1] = string.format(
		"The thank-you whisper is shown with %s; it fits any buff whose link runs %d bytes or less.",
		tostring(sampleID and C_Spell.GetSpellName(sampleID) or sampleID),
		ns.CHAT_MESSAGE_MAX_LENGTH - (#whisper - #sampleLink)
	)
	if
		template ~= defaultTemplate
		and whisper ~= ""
		and whisper == (ns:BuildThanksWhisper(defaultTemplate, sampleLink) or "")
	then
		notes[#notes + 1] =
			"Your own whisper text runs past the limit with this buff, so the default text is shown and sent instead; a buff with a shorter link may still send yours."
	end

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
ns.DIAGNOSTIC_DATA_SOURCES = {
	-- { label, sources = { { table, kind, collect, dataColumns } } }
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
			-- Texture file IDs, which no client API looks up, so the report counts them.
			{ table = "THANK_YOU_MACRO_ICONS", kind = "other" },
		},
	},
	{
		label = "Emote-Groups",
		sources = {
			-- Emote tokens, which no client API looks up by ID, so the report counts them.
			{ table = "EMOTE_GROUP_BY_TOKEN", kind = "other" },
		},
	},
}
