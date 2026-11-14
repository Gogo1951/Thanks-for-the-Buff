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
    halves: Wave to Friends' mouse-focus read (GetMouseFoci, or GetMouseFocus)
    and Validate Data's tooltip-text read (C_TooltipInfo.GetItemByID and
    GetSpellByID, or the hidden scan tooltip). Rows for one flavor's buff
    detection and name reads are added only on that flavor, below.
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
	-- Ignored Buffs' row icons.
	{ "C_Spell.GetSpellTexture", HasFunction("C_Spell", "GetSpellTexture") },
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
	-- Emote blockers: a cast in progress, a fishing pole in hand.
	{ "UnitCastingInfo", HasGlobalFunction("UnitCastingInfo") },
	{ "UnitChannelInfo", HasGlobalFunction("UnitChannelInfo") },
	{ "GetInventoryItemID", HasGlobalFunction("GetInventoryItemID") },
	{ "C_Item.GetItemInfoInstant", HasFunction("C_Item", "GetItemInfoInstant") },
	{ "UnitIsVisible", HasGlobalFunction("UnitIsVisible") },
	{ "UnitInRange", HasGlobalFunction("UnitInRange") },
	{ "CreateMacro", HasGlobalFunction("CreateMacro") },
	{ "EditMacro", HasGlobalFunction("EditMacro") },
	{ "DeleteMacro", HasGlobalFunction("DeleteMacro") },
	{ "GetMacroIndexByName", HasGlobalFunction("GetMacroIndexByName") },
	{ "GetNumMacros", HasGlobalFunction("GetNumMacros") },
	{ "GetMacroInfo", HasGlobalFunction("GetMacroInfo") },
	{ "PlaySoundFile", HasGlobalFunction("PlaySoundFile") },
	-- Wave to Friends: who counts, and the resting rule.
	{ "C_FriendList.IsFriend", HasFunction("C_FriendList", "IsFriend") },
	{ "C_BattleNet.GetAccountInfoByGUID", HasFunction("C_BattleNet", "GetAccountInfoByGUID") },
	{ "GetGuildInfo", HasGlobalFunction("GetGuildInfo") },
	{ "IsResting", HasGlobalFunction("IsResting") },
	-- Wave to Friends' mouse-focus read: GetMouseFoci where the client ships it, else GetMouseFocus.
	{ "GetMouseFoci", HasGlobalFunction("GetMouseFoci") },
	{ "GetMouseFocus (legacy)", HasGlobalFunction("GetMouseFocus") },
	-- Good News: which abilities this client has, who you cast at, and the item rows' links and labels.
	{ "C_Spell.DoesSpellExist", HasFunction("C_Spell", "DoesSpellExist") },
	-- Good News Context's known= read, which prints unreadable without it.
	{ "IsPlayerSpell", HasGlobalFunction("IsPlayerSpell") },
	{ "UnitInParty", HasGlobalFunction("UnitInParty") },
	{ "UnitInRaid", HasGlobalFunction("UnitInRaid") },
	{ "C_Item.GetItemInfo", HasFunction("C_Item", "GetItemInfo") },
	{ "C_Item.GetItemNameByID", HasFunction("C_Item", "GetItemNameByID") },
	{ "C_Item.GetItemIconByID", HasFunction("C_Item", "GetItemIconByID") },
	-- Asked at login for every item a row names, so the panel and the whisper have its name.
	{ "C_Item.RequestLoadItemDataByID", HasFunction("C_Item", "RequestLoadItemDataByID") },
	-- Tracked Abilities' class headings, which fall back to the class token without it.
	{
		"LOCALIZED_CLASS_NAMES_MALE (guarded)",
		function()
			return type(LOCALIZED_CLASS_NAMES_MALE) == "table"
		end,
	},
	-- Good News holds a whisper back while the game locks add-on chat, on a client that has the call.
	{ "C_ChatInfo.InChatMessagingLockdown (guarded)", HasFunction("C_ChatInfo", "InChatMessagingLockdown") },
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
	-- The context report's sound reads, and the taintLog button.
	{ "GetCVar", HasGlobalFunction("GetCVar") },
	{ "SetCVar", HasGlobalFunction("SetCVar") },
}

--[[
    Each flavor's buff detection, probed only where it runs: WoW Forever reads
    UNIT_AURA and names a caster out of nameplate range from its GUID, and asks
    C_Secrets before every read; every other flavor reads the combat log. Wave
    to Friends' Custom List reads a WoW Forever name's surname through
    UnitNameUnmodified, and a realm client's home realm through
    GetNormalizedRealmName; both skip the read where the client lacks it.
]]
if ns.FLAVOR == "Camelot" then
	local checks = ns.DIAGNOSTIC_API_CHECKS
	checks[#checks + 1] = { "C_UnitAuras.GetAuraCasterGUID", HasFunction("C_UnitAuras", "GetAuraCasterGUID") }
	checks[#checks + 1] = { "UnitNameFromGUID", HasGlobalFunction("UnitNameFromGUID") }
	checks[#checks + 1] =
		{ "C_Secrets.ShouldUnitIdentityBeSecret", HasFunction("C_Secrets", "ShouldUnitIdentityBeSecret") }
	checks[#checks + 1] = { "C_Secrets.ShouldAurasBeSecret", HasFunction("C_Secrets", "ShouldAurasBeSecret") }
	checks[#checks + 1] = { "UnitNameUnmodified (guarded)", HasGlobalFunction("UnitNameUnmodified") }
else
	local checks = ns.DIAGNOSTIC_API_CHECKS
	checks[#checks + 1] = { "GetNormalizedRealmName (guarded)", HasGlobalFunction("GetNormalizedRealmName") }
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
	"Best for 'nobody got thanked' reports. It records each buff that lands on you, decoded: the spell, who cast it, how long it lasts, and, off WoW Forever, whether the combat log calls them a friendly player outside your group. On WoW Forever it records each buff added to you with the gate, if any, that kept TFTB from reading it, and who cast each one it read. For 'nobody got waved at' reports, each time you mouse over someone records UPDATE_MOUSEOVER_UNIT; with none, the game never told TFTB. For 'my Good News whisper never went out' reports, each cast of an ability Good News tracks records UNIT_SPELLCAST_SENT, naming who you cast at, then UNIT_SPELLCAST_SUCCEEDED once it goes off, and off WoW Forever each revive of yours records RESURRECT, which a Jumper Cables whisper waits for; every other cast is only counted, at the end."

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
		"Emotes held back now: %s (combat, casting or a fishing pole in hand)",
		tostring(ns.GetEmoteBlocker() or "no")
	)
	lines[#lines + 1] = string.format(
		"Sound: Sound_EnableAllSound=%s Sound_MasterVolume=%s",
		tostring(GetCVar("Sound_EnableAllSound")),
		tostring(GetCVar("Sound_MasterVolume"))
	)

	if db then
		local strangers = db.strangers or {}
		lines[#lines + 1] = string.format(
			"Give Thanks: enabled=%s print=%s whisper=%s whisperText=%s messageLanguage=%s emotesPicked=%s sound=%s  praiseDelay=%s/%s praiseCooldown=%s minDuration=%s cooldown=%s",
			tostring(strangers.enabled),
			tostring(strangers.printEnabled),
			tostring(strangers.whisperEnabled),
			WhisperLength(strangers.whisperMessage),
			ns.GetMessageLanguage(),
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
-- Wave to Friends Context
--------------------------------------------------------------------------------

local function SortedKeys(set)
	local keys = {}
	for key in pairs(set) do
		keys[#keys + 1] = key
	end
	table.sort(keys)
	return keys
end

-- A value that may be secret on WoW Forever, as true or false, never tested while secret.
local function PlainFlag(value)
	if not ns.IsPlain(value) then
		return "<secret>"
	end
	return tostring(value and true or false)
end

-- The mouse-focus read ns.IsMouseOverWorld chose at load, found the way Features/Utilities.lua finds it.
local function MouseFocusRead()
	if GetMouseFoci then
		return "GetMouseFoci"
	elseif GetMouseFocus then
		return "GetMouseFocus"
	end
	return "none (every mouseover counts as the world)"
end

local function WaveCooldownText(seconds)
	if seconds == 0 then
		return "once per session"
	end
	return tostring(seconds) .. " seconds"
end

-- A Custom List entry's emote: None waves at nobody, and a token this client lacks plays nothing.
local function CustomEmoteText(token)
	if token == nil or token == "" then
		return "None (never waved at)"
	end
	return string.format("%s valid=%s", tostring(token), tostring(ns.IsClientEmote(token)))
end

--[[
    The Custom List keys a unit's name reads as, short then full, built through
    ns.NormalizeWaveName from the name calls Wave to Friends makes: Name and
    Name-Realm on a realm client, First and First Last on WoW Forever, whose
    surname comes from UnitNameUnmodified, else UnitName. nil when the name
    can't be read.
]]
local function WaveNameKeys(unit)
	if ns.FLAVOR == "Camelot" then
		local name, surname
		for _, getName in ipairs(UnitNameUnmodified and { UnitNameUnmodified, UnitName } or { UnitName }) do
			local first, second = getName(unit)
			if ns.IsPlain(first) and ns.IsPlain(second) and first then
				name = name or first
				if not surname and second and second ~= "" then
					surname = second
				end
			end
		end
		if not name then
			return nil
		end
		local full =
			ns.NormalizeWaveName((surname and not name:find(" ", 1, true)) and (name .. " " .. surname) or name)
		return full and full:match("^(%S+)"), full
	end
	local name, realm = UnitName(unit)
	if not (ns.IsPlain(name) and ns.IsPlain(realm) and name) then
		return nil
	end
	if not realm or realm == "" then
		realm = GetNormalizedRealmName and GetNormalizedRealmName()
	end
	return ns.NormalizeWaveName(name), realm and ns.NormalizeWaveName(name .. "-" .. realm)
end

--[[
    How Wave to Friends reads the current target, as it reads a mouseover:
    whether it is a player outside your group, then each list in the order
    the feature checks them (Custom List, Friends, Guilds), and which one would
    greet them. The per-player wave cooldown lives in the feature's memory and
    isn't shown; a /reload clears it.
]]
local function WaveTargetLines(lines, settings)
	local unit = "target"
	if not UnitExists(unit) then
		lines[#lines + 1] = "Current target: none (target someone who wasn't waved at, then run this again)"
		return
	end
	if ns.IsUnitIdentitySecret(unit) then
		lines[#lines + 1] = "Current target: identity secret (Wave to Friends skips them)"
		return
	end
	local inParty, inRaid = UnitInParty(unit), UnitInRaid(unit)
	local inGroup = "<secret>"
	if ns.IsPlain(inParty) and ns.IsPlain(inRaid) then
		inGroup = tostring((inParty or inRaid) and true or false)
	end
	lines[#lines + 1] = string.format(
		"Current target: player=%s self=%s inGroup=%s (only players outside your party or raid are waved at)",
		PlainFlag(UnitIsPlayer(unit)),
		PlainFlag(UnitIsUnit(unit, "player")),
		inGroup
	)

	local short, full = WaveNameKeys(unit)
	local entry = (full and (settings.players or {})[full]) or (short and (settings.players or {})[short])
	local customText = "no entry"
	if not short and not full then
		customText = "name unreadable"
	elseif type(entry) == "table" then
		customText = "entry, emote=" .. CustomEmoteText(entry.emote)
	end
	lines[#lines + 1] =
		string.format("  Custom List: %s (read as %s / %s)", customText, tostring(short), tostring(full))

	local guid = UnitGUID(unit)
	local isFriend, isBnetFriend = false, false
	local friendText, bnetText = "<no GUID>", "<no GUID>"
	if guid and ns.IsPlain(guid) then
		local friend = C_FriendList.IsFriend(guid)
		friendText = PlainFlag(friend)
		isFriend = ns.IsPlain(friend) and friend and true or false
		local info = C_BattleNet.GetAccountInfoByGUID(guid)
		local bnet = type(info) == "table" and info.isFriend
		bnetText = PlainFlag(bnet)
		isBnetFriend = ns.IsPlain(bnet) and bnet and true or false
	end
	lines[#lines + 1] = string.format("  Friends: friend=%s battleNetFriend=%s", friendText, bnetText)

	local guildName = GetGuildInfo(unit)
	local guildListed, sameGuild = false, false
	local guildText = "none"
	if not ns.IsPlain(guildName) then
		guildText = "<secret>"
	elseif guildName and guildName ~= "" then
		local key = ns.NormalizeGuildName(guildName)
		guildListed = key ~= nil and settings.guilds ~= nil and settings.guilds[key] ~= nil
		local myGuild = GetGuildInfo("player")
		sameGuild = ns.IsPlain(myGuild) and myGuild ~= nil and myGuild == guildName
		guildText = string.format("<%s> listed=%s yourGuild=%s", guildName, tostring(guildListed), tostring(sameGuild))
	end
	lines[#lines + 1] = "  Guild: " .. guildText

	-- First match wins, as in the feature: a Custom List entry set to None stops the lists below it.
	local greeting = "nobody"
	if settings.customEnabled and type(entry) == "table" then
		greeting = (entry.emote and entry.emote ~= "") and ("Custom List (" .. tostring(entry.emote) .. ")")
			or "Custom List, set to None: never waved at"
	elseif settings.friendsEnabled and (isFriend or (settings.bnetFriends and isBnetFriend)) then
		greeting = "Friends"
		if #ns.GetPickableEmotes(settings.friendEmotes) == 0 then
			greeting = greeting .. " (NO EMOTE this client can play is picked)"
		end
	elseif guildListed or (settings.myGuildEnabled and sameGuild) then
		greeting = "Guilds"
		if #ns.GetPickableEmotes(settings.guildEmotes) == 0 then
			greeting = greeting .. " (NO EMOTE this client can play is picked)"
		end
	end
	lines[#lines + 1] = "  Would greet them through: " .. greeting
end

--[[
    The state behind a "my friend walked past and nothing happened" report:
    every gate the mouseover handler checks before it looks at who you moused
    over (the switch, the resting rule, the emote blockers, the mouse-focus read), the
    cooldown, each list with its switch, entries and picked emotes, and how
    the current target reads to the feature.
]]
function ns:BuildWaveContextReport()
	local lines = { GetClientHeader(), "" }
	local settings = ns.db and ns.db.profile.wave
	if not settings then
		lines[#lines + 1] = "Saved variables not initialized."
		return table.concat(lines, "\n")
	end

	lines[#lines + 1] = string.format(
		"Wave to Friends: enabled=%s restingOnly=%s resting=%s emotesHeldBack=%s cooldown=%s",
		tostring(settings.enabled),
		tostring(settings.restingOnly),
		tostring(IsResting() and true or false),
		tostring(ns.GetEmoteBlocker() or "no"),
		WaveCooldownText(settings.cooldown)
	)
	lines[#lines + 1] = string.format(
		"Mouse focus read: %s (a wave fires only with the mouse on the 3D world, never on a unit frame or nameplate)",
		MouseFocusRead()
	)
	if ns.FLAVOR == "Camelot" then
		lines[#lines + 1] = "Names read as: First Last (WoW Forever has no realms)"
	else
		lines[#lines + 1] = string.format(
			"Names read as: Name-Realm, your realm %s",
			tostring(GetNormalizedRealmName and GetNormalizedRealmName())
		)
	end

	lines[#lines + 1] = ""
	local players = type(settings.players) == "table" and settings.players or {}
	local playerKeys = SortedKeys(players)
	lines[#lines + 1] = string.format(
		"Custom List: enabled=%s entries=%d (checked first)",
		tostring(settings.customEnabled),
		#playerKeys
	)
	for _, key in ipairs(playerKeys) do
		local entry = players[key]
		lines[#lines + 1] = string.format(
			"  %s (key %s): emote=%s",
			tostring(type(entry) == "table" and entry.name or "?"),
			key,
			CustomEmoteText(type(entry) == "table" and entry.emote or nil)
		)
	end
	lines[#lines + 1] = string.format(
		"Friends: enabled=%s battleNet=%s emotesPicked=%s",
		tostring(settings.friendsEnabled),
		tostring(settings.bnetFriends),
		EmotesPicked(settings.friendEmotes)
	)
	local guilds = type(settings.guilds) == "table" and settings.guilds or {}
	local guildKeys = SortedKeys(guilds)
	local myGuild = GetGuildInfo("player")
	lines[#lines + 1] = string.format(
		"Guilds: myGuild=%s yourGuild=%s listed=%d emotesPicked=%s",
		tostring(settings.myGuildEnabled),
		(ns.IsPlain(myGuild) and myGuild) and ("<" .. myGuild .. ">") or "none",
		#guildKeys,
		EmotesPicked(settings.guildEmotes)
	)
	for _, key in ipairs(guildKeys) do
		lines[#lines + 1] = string.format("  <%s> (key %s)", tostring(guilds[key]), key)
	end

	lines[#lines + 1] = ""
	WaveTargetLines(lines, settings)

	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Good News Context
--------------------------------------------------------------------------------

-- Absent where the client lacks it; the API Endpoints rows say which.
local IsPlayerSpell = _G.IsPlayerSpell

--[[
    A Good News row's name as the Tracked Abilities panel labels it: its
    labelItem or first item, else its first spell. An item the client hasn't
    loaded yet reads as its spell, as on the panel.
]]
local function GoodNewsRowName(info)
	local itemId = info.row.labelItem or info.itemIds[1]
	local name = itemId and C_Item.GetItemNameByID(itemId)
	return name or C_Spell.GetSpellName(info.spellIds[1]) or tostring(info.spellIds[1])
end

--[[
    One line per row this client can cast: ticked or not, its class (Items for
    a row with none), how it confirms the cast, and its cast ids. A row of
    your class also lists which of those ids you know: knowing the ability under none
    of them means your rank's cast id is missing from the data, so your cast is
    never matched. An item row says how many of its items the client has
    loaded; one not loaded yet is named by its spell in the whisper.
]]
local function GoodNewsRowLines(lines, rows)
	local _, playerClass = UnitClass("player")
	for _, info in ipairs(rows) do
		local row = info.row
		local detail
		if row.class and row.class ~= playerClass then
			detail = "(not your class)"
		elseif row.class then
			local known = {}
			for _, spellId in ipairs(info.spellIds) do
				if IsPlayerSpell and IsPlayerSpell(spellId) then
					known[#known + 1] = tostring(spellId)
				end
			end
			detail = string.format(
				"known=%s",
				not IsPlayerSpell and "unreadable" or (#known > 0 and table.concat(known, ",") or "none")
			)
		else
			local loaded = 0
			for _, itemId in ipairs(info.itemIds) do
				if C_Item.GetItemNameByID(itemId) then
					loaded = loaded + 1
				end
			end
			detail = string.format("itemsLoaded=%d/%d", loaded, #info.itemIds)
		end
		lines[#lines + 1] = string.format(
			"  [%s] %s (%s, %s%s): casts=%s %s",
			ns.IsGoodNewsWatched(info.watchedIds[1]) and "ticked" or "UNTICKED",
			GoodNewsRowName(info),
			row.class or "Items",
			tostring(row.detect),
			row.noDuration and ", no duration" or "",
			table.concat(info.spellIds, ","),
			detail
		)
	end
end

--[[
    How Good News reads the current target as a cast's recipient, the checks
    OnUnitSpellcastSent makes in order: identity readable (WoW Forever hides
    it in combat), a player and not you, a readable name, and, under the
    group-only scope, in your party or raid.
]]
local function GoodNewsTargetLine(scope)
	local unit = "target"
	if not UnitExists(unit) then
		return "Current target: none (target the player you cast on, then run this again)"
	end
	if ns.IsUnitIdentitySecret(unit) then
		return "Current target: identity secret (Good News sends nothing to them)"
	end
	local guid = UnitGUID(unit)
	local isPlayer = ns.IsPlain(guid) and guid ~= nil and guid:sub(1, 7) == "Player-"
	local isSelf = isPlayer and ns.UnitHasGUID("player", guid)
	local name = GetUnitName(unit, true)
	local nameReadable = ns.IsPlain(name) and name ~= nil and name ~= ""
	local inParty, inRaid = UnitInParty(unit), UnitInRaid(unit)
	local inGroup = (ns.IsPlain(inParty) and inParty and true) or (ns.IsPlain(inRaid) and inRaid ~= nil) or false
	local verdict = "yes"
	if not isPlayer then
		verdict = "no, not a player"
	elseif isSelf then
		verdict = "no, that's you"
	elseif not nameReadable then
		verdict = "no, name unreadable"
	elseif scope ~= "ALWAYS" and not inGroup then
		verdict = "no, outside your group"
	end
	return string.format(
		"Current target: player=%s self=%s nameReadable=%s inGroup=%s  Would be whispered: %s",
		tostring(isPlayer),
		tostring(isSelf),
		tostring(nameReadable),
		tostring(inGroup),
		verdict
	)
end

--[[
    The state behind a "my Good News whisper never went out" report: the
    switch, who it whispers and the text it sends, whether the post-loading-
    screen pause it shares with Give Thanks is over, what WoW Forever is hiding
    right now, whether the game is holding add-on chat back, your pet (whose
    casts count too), whether this flavor's abilities file loaded, every row
    this client can cast, and how the current target reads as a recipient.
    Repeat whispers within a few seconds of each other are held back in the
    feature's memory and not shown here.
]]
function ns:BuildGoodNewsContextReport()
	local lines = { GetClientHeader(), "" }
	local settings = ns.db and ns.db.profile.goodNews
	if not settings then
		lines[#lines + 1] = "Saved variables not initialized."
		return table.concat(lines, "\n")
	end
	if not ns.GetGoodNewsRows then
		lines[#lines + 1] = "Good News is not loaded on this client."
		return table.concat(lines, "\n")
	end

	lines[#lines + 1] = string.format(
		"Good News: enabled=%s scope=%s whisperText=%s messageLanguage=%s",
		tostring(settings.enabled),
		tostring(settings.scope),
		WhisperLength(settings.whisperMessage),
		ns.GetMessageLanguage()
	)
	lines[#lines + 1] = string.format(
		"Ready (past the post-loading-screen pause): %s  InCombat=%s  Grouped: party=%s raid=%s",
		tostring(ns.IsBuffTrackingReady and ns.IsBuffTrackingReady()),
		tostring(InCombatLockdown() and true or false),
		tostring(IsInGroup() and true or false),
		tostring(IsInRaid() and true or false)
	)
	lines[#lines + 1] =
		string.format("Auras secret now: %s (the whisper then leaves out the duration)", tostring(ns.AreAurasSecret()))
	local lockdown = "no such call on this client"
	if C_ChatInfo.InChatMessagingLockdown then
		local locked = C_ChatInfo.InChatMessagingLockdown()
		lockdown = ns.IsPlain(locked) and tostring(locked and true or false) or "<secret>"
	end
	lines[#lines + 1] = string.format("Add-on chat held back now: %s (a whisper due then is dropped)", lockdown)
	lines[#lines + 1] =
		string.format("Pet: %s (its casts count as yours)", UnitExists("pet") and PlainText(UnitName("pet")) or "none")

	local rows = ns.GetGoodNewsRows()
	local ticked = 0
	for _, info in ipairs(rows) do
		if ns.IsGoodNewsWatched(info.watchedIds[1]) then
			ticked = ticked + 1
		end
	end
	lines[#lines + 1] = ""
	-- Every row is dropped when this flavor's abilities file never loaded, so nothing can be tracked.
	lines[#lines + 1] = string.format(
		"Abilities data (%s/Good-News-Abilities-%s.lua): %s",
		tostring(ns.DATA_FOLDER),
		tostring(ns.DATA_FOLDER),
		type(ns.GOOD_NEWS_ABILITIES) == "table" and "loaded" or "MISSING"
	)
	lines[#lines + 1] = string.format(
		"Tracked abilities: %d rows this client can cast, %d ticked (%d data rows dropped as not on this client)",
		#rows,
		ticked,
		#(ns.GOOD_NEWS_ABILITIES or {}) - #rows
	)
	GoodNewsRowLines(lines, rows)

	lines[#lines + 1] = ""
	lines[#lines + 1] = GoodNewsTargetLine(settings.scope)

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
    Who cast an aura on you, read the way Buff-Tracking.lua finds its caster:
    the aura's sourceUnit, or with none (a stranger out of nameplate range) the
    caster's GUID from C_UnitAuras.GetAuraCasterGUID. Reports the GUID's type
    (Player, Pet, Creature, ...), self when it is you, and, where the aura names
    a unit, whether that unit is in your group and friendly. Give Thanks credits
    only a friendly Player outside your group, so a read aura that went
    unthanked with anything else here stopped at that check. unresolved means
    no caster could be read, which Give Thanks skips too. A secret value is
    never tested.
]]
local function AuraCasterText(aura)
	local unit = aura.sourceUnit
	if not ns.IsPlain(unit) then
		return "caster=<secret>"
	end
	local guid
	if unit then
		guid = UnitGUID(unit)
	else
		local instanceID = aura.auraInstanceID
		if ns.IsPlain(instanceID) and instanceID then
			local ok, casterGUID = pcall(C_UnitAuras.GetAuraCasterGUID, "player", instanceID)
			if ok then
				guid = casterGUID
			end
		end
	end
	if not ns.IsPlain(guid) then
		return "caster=<secret>"
	end
	if not guid then
		return "caster=unresolved"
	end
	local text = "caster=" .. tostring(guid:match("^(%a+)%-") or "?")
	if guid == UnitGUID("player") then
		text = text .. " self"
	end
	if unit then
		local inParty, inRaid = UnitInParty(unit), UnitInRaid(unit)
		local inGroup = "<secret>"
		if ns.IsPlain(inParty) and ns.IsPlain(inRaid) then
			inGroup = tostring((inParty or inRaid) and true or false)
		end
		text = text .. string.format(" inGroup=%s friend=%s", inGroup, PlainFlag(UnitIsFriend("player", unit)))
	end
	return text
end

--[[
    Forever's version of the case above: UNIT_AURA is excluded from the log
    because its update table can't be written as text, so the buff engine calls
    this for each helpful aura added to you (or one whose helpfulness is
    secret), and once for a full update, while logging is on. verdict is the
    first gate that stops the update -- not ready, no db, in combat, auras
    secret, full update -- or read when the aura goes on to be classified.
    verdict read means the buff reached the add-on and the issue is
    downstream, so a read aura also carries who cast it (AuraCasterText) and
    its duration as Give Thanks reads it (nil when it isn't found on you). A
    secret value is never tested here: ns:LogEventNow writes it as <secret>,
    and the name, caster and duration reads are skipped.
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
	local name, caster, duration
	if verdict == "read" then
		caster = AuraCasterText(aura)
	end
	if ns.IsPlain(spellID) and spellID then
		name = C_Spell.GetSpellName(spellID)
		if verdict == "read" then
			duration = "duration=" .. tostring(ns.GetBuffDuration("player", spellID))
		end
	end
	ns:LogEventNow("UNIT_AURA", "ADDED", verdict, spellID, name or "?", aura.sourceUnit, caster, duration)
end

--[[
    Good News' Jumper Cables case. The jolt logs as UNIT_SPELLCAST_SENT and
    SUCCEEDED, but its whisper waits for the combat log's SPELL_RESURRECT,
    which the COMBAT_LOG_EVENT_UNFILTERED exclusion keeps out of the log. The
    buff engine hands every revive of yours to ns.ClaimGoodNewsResurrect, so
    that hand-off is wrapped here to record it first (labeled RESURRECT): the
    spell and the GUID of who got up. A jolt that SUCCEEDED with no RESURRECT
    after it revived nobody, so no whisper was due. Never called on WoW
    Forever, which has no combat log.
]]
local ClaimGoodNewsResurrect = ns.ClaimGoodNewsResurrect
if ClaimGoodNewsResurrect then
	function ns.ClaimGoodNewsResurrect(destGUID, spellID)
		if ns.diagnostics.logging then
			ns:LogEventNow(
				"COMBAT_LOG_EVENT_UNFILTERED",
				"RESURRECT",
				spellID,
				C_Spell.GetSpellName(spellID) or "?",
				destGUID
			)
		end
		return ClaimGoodNewsResurrect(destGUID, spellID)
	end
end

--------------------------------------------------------------------------------
-- Name Lookups
--------------------------------------------------------------------------------

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
      choices, and its minutes and hours strings, as Wave to Friends' cooldown
      dropdown labels its choices, with the sample count in the ID cell (1, 2
      and 5, one count per plural form a Slavic locale has);
    - every curated emote token the Give Thanks and Thank You panels pick
      from, then the ones Wave to Friends starts its lists on, each named by
      the command this client gives it (NIL means the client has no such
      emote, so a pick of it never plays);
    - every Good News row, by the record the Tracked Abilities panel labels it
      with (its labelItem or first item through C_Item.GetItemNameByID, else
      its first spell through C_Spell.GetSpellName), then every other item a
      row casts, since the whisper names the very item used; a spell row's
      ranks share its first spell's name, so that one stands for them all;
    - the class name over each class's rows, from LOCALIZED_CLASS_NAMES_MALE
      as the panel reads it.
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

	-- { constant, seconds per count, counts }; minutes and hours word the cooldown without forceSeconds.
	for _, unit in ipairs({
		{ "D_SECONDS", 1, { 1, 2, 5 } },
		{ "D_MINUTES", 60, { 1, 2, 5 } },
		{ "D_HOURS", 3600, { 1 } },
	}) do
		local constant, size = unit[1], unit[2]
		for _, count in ipairs(unit[3]) do
			rows[#rows + 1] = {
				constant = constant,
				kind = "globalString",
				id = count,
				lookup = function()
					return ns.FormatDuration(count * size, size == 1)
				end,
			}
		end
	end

	local tokens, seen = {}, {}
	local function AddToken(token)
		if not seen[token] then
			seen[token] = true
			tokens[#tokens + 1] = token
		end
	end
	for _, emote in ipairs(ns.Data.EMOTES) do
		AddToken(emote.token)
	end
	local wave = ns.DATABASE_DEFAULTS.profile.wave
	for _, set in ipairs({ wave.friendEmotes, wave.guildEmotes }) do
		for _, token in ipairs(SortedKeys(set)) do
			AddToken(token)
		end
	end
	for _, token in ipairs(ns.Data.WAVE_CUSTOM_DEFAULT_EMOTES) do
		AddToken(token)
	end

	for _, token in ipairs(tokens) do
		rows[#rows + 1] = {
			constant = token,
			kind = "emote",
			id = token,
			lookup = function()
				return EmoteCommand(token)
			end,
		}
	end

	local function AddItem(constant, itemId)
		rows[#rows + 1] = {
			constant = constant,
			kind = "item",
			id = itemId,
			lookup = function()
				return C_Item.GetItemNameByID(itemId)
			end,
			request = function()
				C_Item.RequestLoadItemDataByID(itemId)
			end,
		}
	end

	local classes, classSeen = {}, {}
	for index, ability in ipairs(ns.GOOD_NEWS_ABILITIES or {}) do
		local constant = string.format("GOOD_NEWS_ABILITIES[%d]", index)
		local triggers = ability.triggers or {}
		local labelItem = ability.labelItem
		for _, trigger in ipairs(triggers) do
			labelItem = labelItem or trigger.item
		end
		local named = {}
		if labelItem then
			named[labelItem] = true
			AddItem(constant, labelItem)
		elseif triggers[1] then
			local spellId = triggers[1].spell
			rows[#rows + 1] = {
				constant = constant,
				kind = "spell",
				id = spellId,
				lookup = function()
					return C_Spell.GetSpellName(spellId)
				end,
				request = function()
					C_Spell.RequestLoadSpellData(spellId)
				end,
			}
		end
		for _, trigger in ipairs(triggers) do
			if trigger.item and not named[trigger.item] then
				named[trigger.item] = true
				AddItem(constant, trigger.item)
			end
		end
		if ability.class and not classSeen[ability.class] then
			classSeen[ability.class] = true
			classes[#classes + 1] = ability.class
		end
	end
	table.sort(classes)
	for _, class in ipairs(classes) do
		rows[#rows + 1] = {
			constant = "LOCALIZED_CLASS_NAMES_MALE",
			kind = "globalString",
			id = class,
			lookup = function()
				return LOCALIZED_CLASS_NAMES_MALE and LOCALIZED_CLASS_NAMES_MALE[class]
			end,
		}
	end
end

--------------------------------------------------------------------------------
-- Message Length
--------------------------------------------------------------------------------

-- A macro body's ceiling, measured in bytes with #body, as the Style Guide's Message Length rule asks.
local MACRO_MAX_LENGTH = 255

-- The longest duration a Good News whisper names: it says one only under a minute.
local GOOD_NEWS_LONGEST_SECONDS = 59

--[[
    The longest link a Good News whisper can carry on this client, and the
    ability it belongs to: over every row this client can cast, each cast's
    spell link (ns.GetBuffLink) and each item's link where the client has the
    item loaded, the two links the whisper picks between.
]]
local function LongestGoodNewsLink()
	local link, label = "", nil
	local function Consider(candidate, name)
		if candidate and #candidate > #link then
			link, label = candidate, name
		end
	end
	for _, info in ipairs(ns.GetGoodNewsRows and ns.GetGoodNewsRows() or {}) do
		for _, spellId in ipairs(info.spellIds) do
			Consider(ns.GetBuffLink(spellId), C_Spell.GetSpellName(spellId) or spellId)
		end
		for _, itemId in ipairs(info.itemIds) do
			local name, itemLink = C_Item.GetItemInfo(itemId)
			Consider(itemLink, name or itemId)
		end
	end
	return link, label
end

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
    a second note says when the player's own text fell back. The Good News
    whisper's abilities are bounded by this client's rows, so it is built at
    its longest: the longest link any tracked ability carries and the longest
    duration the whisper names, with the same fallback note. Each Thank You
    button's whisper is the player's own text, shown only when set, and each
    macro body is its button's command.
]]
ns.DIAGNOSTIC_MESSAGES = function()
	local rows, notes = {}, {}

	local sampleID = ns.GAME_IDS and ns.GAME_IDS.SAMPLE_BUFF_SPELL_ID
	local sampleLink = sampleID and ns.GetBuffLink(sampleID) or ""
	local strangers = ns.db and ns.db.profile.strangers
	local defaultTemplate = ns.GetDefaultThanksWhisper()
	local template = strangers and strangers.whisperMessage or defaultTemplate
	local sampleName = ns.SAMPLE_NAMES.MAGE
	local whisper = ns:BuildThanksWhisper(template, sampleLink, sampleName) or ""
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
		and whisper == (ns:BuildThanksWhisper(defaultTemplate, sampleLink, sampleName) or "")
	then
		notes[#notes + 1] =
			"Your own whisper text runs past the limit with this buff, so the default text is shown and sent instead; a buff with a shorter link may still send yours."
	end

	local goodNews = ns.db and ns.db.profile.goodNews
	local goodNewsTemplate = goodNews and goodNews.whisperMessage or ns.GetDefaultGoodNewsWhisper()
	if goodNewsTemplate == "" then
		notes[#notes + 1] = "The Good News whisper text is empty, so Good News sends nothing."
	else
		local link, label = LongestGoodNewsLink()
		local longest, typedOver = "", false
		for count = 0, GOOD_NEWS_LONGEST_SECONDS do
			local seconds = count > 0 and count or nil
			local message = ns:BuildGoodNewsWhisper(goodNewsTemplate, link, sampleName, seconds) or ""
			if #message > #longest then
				longest = message
			end
			typedOver = typedOver
				or #ns.FillGoodNewsWhisper(goodNewsTemplate, link, sampleName, seconds) > ns.CHAT_MESSAGE_MAX_LENGTH
		end
		rows[#rows + 1] = {
			label = "Good News whisper",
			ceiling = ns.CHAT_MESSAGE_MAX_LENGTH,
			text = longest,
		}
		notes[#notes + 1] = string.format(
			"The Good News whisper is shown with the longest link of any ability this client tracks (%s) and its longest duration, so every other one is shorter.",
			tostring(label or "none on this client")
		)
		if typedOver and goodNewsTemplate ~= ns.GetDefaultGoodNewsWhisper() then
			notes[#notes + 1] =
				"Your own Good News text runs past the limit with that ability, so the default text is shown and sent instead; a shorter ability may still send yours."
		end
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

--[[
    Every id a Good News row names, of one kind: "spell" for each trigger's
    cast and, where it differs, the aura it leaves; "item" for each trigger's
    item and the row's labelItem. Each id appears once per row, keyed by the
    row's position, with the part of the row it came from.
]]
local function CollectAbilityIds(abilities, kind)
	local found = {}
	for index, row in ipairs(abilities) do
		local seen = {}
		local function Add(id, role)
			if type(id) == "number" and not seen[id] then
				seen[id] = true
				found[#found + 1] = { id = id, key = index, row = { ability = row, role = role } }
			end
		end
		if kind == "item" then
			Add(row.labelItem, "label")
		end
		for _, trigger in ipairs(row.triggers or {}) do
			if kind == "spell" then
				Add(trigger.spell, "cast")
				Add(trigger.aura, "aura")
			else
				Add(trigger.item, "item")
			end
		end
	end
	return found
end

-- A Good News row's position, class (blank for an item row), detect type and the part of the row the id came from.
local ABILITY_DATA_COLUMNS = {
	{
		"DATA_ROW",
		function(key)
			return key
		end,
	},
	{
		"DATA_CLASS",
		function(_, entry)
			return entry.ability.class or ""
		end,
	},
	{
		"DATA_DETECT",
		function(_, entry)
			return entry.ability.detect
		end,
	},
	{
		"DATA_ROLE",
		function(_, entry)
			return entry.role
		end,
	},
}

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
	{
		label = "Good-News-Abilities",
		sources = {
			{
				table = "GOOD_NEWS_ABILITIES",
				kind = "spell",
				collect = function(abilities)
					return CollectAbilityIds(abilities, "spell")
				end,
				dataColumns = ABILITY_DATA_COLUMNS,
			},
			{
				table = "GOOD_NEWS_ABILITIES",
				kind = "item",
				collect = function(abilities)
					return CollectAbilityIds(abilities, "item")
				end,
				dataColumns = ABILITY_DATA_COLUMNS,
			},
		},
	},
}
