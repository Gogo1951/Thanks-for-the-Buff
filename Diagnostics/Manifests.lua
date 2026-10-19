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
    halves: the unit tooltip the Buff Window reads a pet's owner from
    (C_TooltipInfo.GetUnit or a hidden tooltip's SetUnit), Validate Data's stat
    read, and its tooltip-text read (C_TooltipInfo.GetItemByID and
    GetSpellByID, or the hidden scan tooltip). The hidden tooltips are probed
    through the GameTooltip methods they inherit, so the check creates nothing.
    A FAIL on one half is the report working rather than a defect: the pair
    tells a bug report which branch that client took.
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
	{ "C_Timer.NewTicker", HasFunction("C_Timer", "NewTicker") },
	{ "C_EventUtils.IsEventValid", HasFunction("C_EventUtils", "IsEventValid") },
	{ "C_Spell.GetSpellName", HasFunction("C_Spell", "GetSpellName") },
	{ "C_Spell.DoesSpellExist", HasFunction("C_Spell", "DoesSpellExist") },
	{ "C_Spell.GetSpellDescription", HasFunction("C_Spell", "GetSpellDescription") },
	{ "C_Spell.RequestLoadSpellData", HasFunction("C_Spell", "RequestLoadSpellData") },
	{ "C_Spell.IsSpellDataCached", HasFunction("C_Spell", "IsSpellDataCached") },
	{ "C_Spell.GetSpellTexture", HasFunction("C_Spell", "GetSpellTexture") },
	{ "C_Spell.GetSpellLink", HasFunction("C_Spell", "GetSpellLink") },
	{ "C_Spell.GetSpellSubtext", HasFunction("C_Spell", "GetSpellSubtext") },
	{ "IsPlayerSpell", HasGlobalFunction("IsPlayerSpell") },
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
	{
		"bit.band",
		function()
			return type(bit) == "table" and type(bit.band) == "function"
		end,
	},
	{ "GetPlayerInfoByGUID", HasGlobalFunction("GetPlayerInfoByGUID") },
	{ "UnitNameFromGUID", HasGlobalFunction("UnitNameFromGUID") },
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
	{ "DeleteMacro", HasGlobalFunction("DeleteMacro") },
	{ "GetMacroIndexByName", HasGlobalFunction("GetMacroIndexByName") },
	{ "GetNumMacros", HasGlobalFunction("GetNumMacros") },
	{ "GetMacroInfo", HasGlobalFunction("GetMacroInfo") },
	{ "PlaySoundFile", HasGlobalFunction("PlaySoundFile") },
	-- The Buff Window's group read, role guesses and range check.
	{ "GetNumGroupMembers", HasGlobalFunction("GetNumGroupMembers") },
	{ "GetRaidRosterInfo", HasGlobalFunction("GetRaidRosterInfo") },
	{ "GetPartyAssignment (guarded)", HasGlobalFunction("GetPartyAssignment") },
	{ "UnitGroupRolesAssigned (guarded)", HasGlobalFunction("UnitGroupRolesAssigned") },
	{ "C_Spell.IsSpellInRange (guarded)", HasFunction("C_Spell", "IsSpellInRange") },
	{ "UnitPowerType", HasGlobalFunction("UnitPowerType") },
	{
		"Enum.PowerType.Mana / Focus",
		function()
			return type(Enum) == "table"
				and type(Enum.PowerType) == "table"
				and Enum.PowerType.Mana ~= nil
				and Enum.PowerType.Focus ~= nil
		end,
	},
	{ "C_Spell.GetSpellCooldown", HasFunction("C_Spell", "GetSpellCooldown") },
	{ "C_TooltipInfo.GetUnit", HasFunction("C_TooltipInfo", "GetUnit") },
	{
		"Hidden unit tooltip (legacy)",
		function()
			return type(CreateFrame) == "function"
				and type(GameTooltip) == "table"
				and type(GameTooltip.SetUnit) == "function"
				and type(GameTooltip.NumLines) == "function"
		end,
	},
	-- The Buff Window's secure buttons and the state driver behind Hide in Combat.
	{ "RegisterStateDriver", HasGlobalFunction("RegisterStateDriver") },
	{ "UnregisterStateDriver", HasGlobalFunction("UnregisterStateDriver") },
	{ "C_XMLUtil.GetTemplateInfo", HasFunction("C_XMLUtil", "GetTemplateInfo") },
	{ "SecureActionButtonTemplate", HasTemplate("SecureActionButtonTemplate") },
	{ "CooldownFrameTemplate", HasTemplate("CooldownFrameTemplate") },
	{ "BackdropTemplate", HasTemplate("BackdropTemplate") },
	{ "GameTooltipTemplate", HasTemplate("GameTooltipTemplate") },
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
	-- Display Context's screen read, and the taintLog button.
	{ "GetPhysicalScreenSize", HasGlobalFunction("GetPhysicalScreenSize") },
	{ "GetCVar", HasGlobalFunction("GetCVar") },
	{ "SetCVar", HasGlobalFunction("SetCVar") },
}

--------------------------------------------------------------------------------
-- Buff Reactions Context
--------------------------------------------------------------------------------

--[[
    The probes read feature state through the accessors the feature files
    expose (ns.IsBuffTrackingReady, ns.GetPraiseCooldownState, ns.BuffWindow
    and the like), so a report shows the values the features act on rather
    than a copy of their logic.
]]

-- The add-on's own example reports, appended to the shared Event Log intro.
ns.DiagnosticsStrings.EVENT_LOG_EXAMPLES =
	"Best for 'nobody got thanked' or 'a portal wasn't announced' reports. On every flavor it records each buff that lands on you, decoded, with whether TFTB tracks and watches it. Off WoW Forever it also records each nearby cast and revive TFTB tracks the same way, and counts every other spell cast by spell id at the end."

-- Per-class tracked-spell manifest for the IsPlayerSpell readout, rebuilt from
-- ns.TRACKED_ABILITIES at login by Features/Tracked-Lookups.lua.
ns.DIAGNOSTIC_SPELLS = {}

-- Tracked-trigger coverage on the running client, filled at login by
-- Features/Tracked-Lookups.lua.
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

--[[
    How many of a panel's toggles are on, out of how many it shows. A toggle
    carries every live id of one entry and switches them together, so it reads
    on when any of its ids is watched.
]]
local function CountToggles(toggles, watched)
	local on = 0
	for _, toggle in ipairs(toggles or {}) do
		for _, id in ipairs(toggle.ids or {}) do
			if watched and watched[id] then
				on = on + 1
				break
			end
		end
	end
	return on, #(toggles or {})
end

local function CountCategoryToggles(categories, watched)
	local on, total = 0, 0
	for _, category in ipairs(categories or {}) do
		local categoryOn, categoryTotal = CountToggles(category.entries, watched)
		on, total = on + categoryOn, total + categoryTotal
	end
	return on, total
end

--[[
    How many of the curated emotes a panel has picked, out of how many there
    are, and how many of those picks this client can't perform: the random pick
    can land on one, and then no emote plays.
]]
local function EmotesPicked(emotes)
	local picked, missing = 0, 0
	if type(emotes) == "table" then
		for _, data in ipairs(ns.Data.EMOTES) do
			if emotes[data.token] then
				picked = picked + 1
				if not ns.IsClientEmote(data.token) then
					missing = missing + 1
				end
			end
		end
	end
	local text = string.format("%d/%d", picked, #ns.Data.EMOTES)
	if missing > 0 then
		text = text .. string.format(" (%d NOT ON CLIENT)", missing)
	end
	return text
end

local function KnowsAny(ids)
	for _, id in ipairs(ids or {}) do
		if IsPlayerSpell(id) then
			return true
		end
	end
	return false
end

local function OnOff(value)
	return value and "on" or "off"
end

-- A value that may be secret on WoW Forever, as text that never tests it.
local function PlainText(value)
	if ns.IsPlain(value) then
		return tostring(value)
	end
	return "<secret>"
end

--[[
    Whether Good News watches a tracked spell you cast: the first of its cast
    ids that Good News knows decides, through the same watchedId the panel's
    toggle writes. n/a for a spell Good News doesn't offer (a service).
]]
local function GoodNewsState(ids, goodNews)
	for _, id in ipairs(ids or {}) do
		local entry = ns.GetGivenEntry and ns.GetGivenEntry(id)
		if entry then
			return OnOff(goodNews.watched and goodNews.watched[entry.watchedId])
		end
	end
	return "n/a"
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
    report: who the player is and which profile they're on, whether the buff
    engine ever set up and how buffs are detected on this flavor, whether that
    path is open right now (the post-loading-screen pause, combat, WoW
    Forever's secret auras), every panel's switches and picked emotes, how many
    of each panel's toggles are on, the praise throttles, the sound settings
    the Master channel answers to, how much of the tracked data is live on this
    client, which tracked spells of their class they know and whether Good
    News and Peer Pressure watch each one, where /tftb goes, and what stops
    each Thank You button: its command, its toggle, its macro, its whisper
    text and its emotes.
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
	-- A nil player GUID means the login setup never ran, and with it no lookup, list or timer.
	lines[#lines + 1] = string.format(
		"Buff tracking set up: %s  Ready (past the post-loading-screen pause): %s",
		tostring(ns.GetPlayerGUID and ns.GetPlayerGUID() ~= nil),
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
		local teammatesOn, teammatesTotal = CountCategoryToggles(ns.TeammateCategories, db.watchedBuffs)
		lines[#lines + 1] = string.format(
			"Teammates: enabled=%s print=%s whisper=%s emotes=%s emotesPicked=%s sound=%s  praiseDelay=%s/%s watched=%d/%d",
			tostring(teammates.enabled),
			tostring(teammates.printEnabled),
			tostring(teammates.whisperEnabled),
			tostring(teammates.emotesEnabled),
			EmotesPicked(teammates.emotes),
			tostring(teammates.soundEnabled),
			tostring(teammates.praiseDelayEnabled),
			tostring(teammates.praiseDelay),
			teammatesOn,
			teammatesTotal
		)
		local servicesOn, servicesTotal = CountToggles(ns.ServiceEntries, db.watchedBuffs)
		lines[#lines + 1] = string.format(
			"Services: enabled=%s print=%s whisper=%s emotes=%s emotesPicked=%s sound=%s  praiseDelay=%s/%s watched=%d/%d",
			tostring(services.enabled),
			tostring(services.printEnabled),
			tostring(services.whisperEnabled),
			tostring(services.emotesEnabled),
			EmotesPicked(services.emotes),
			tostring(services.soundEnabled),
			tostring(services.praiseDelayEnabled),
			tostring(services.praiseDelay),
			servicesOn,
			servicesTotal
		)

		-- A blank saved template sends the default, so it reads as default here too.
		local goodNews = db.goodNews or {}
		local goodNewsOn, goodNewsTotal = CountCategoryToggles(ns.GoodNewsCategories, goodNews.watched)
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
	lines[#lines + 1] = "Tracked spells for your class (known / Good News):"
	local classSpells = class and ns.DIAGNOSTIC_SPELLS[class]
	if classSpells then
		local goodNews = db and db.goodNews or {}
		for _, spellData in ipairs(classSpells) do
			lines[#lines + 1] = string.format(
				"  %s = known:%s goodNews:%s",
				spellData.name,
				tostring(KnowsAny(spellData.ids)),
				GoodNewsState(spellData.ids, goodNews)
			)
		end
	else
		lines[#lines + 1] = "  (no tracked spells for this class)"
	end

	lines[#lines + 1] = ""
	lines[#lines + 1] = "Peer Pressure spells for your class (known / watched):"
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
			local watched = db and db.peerPressure and db.peerPressure.watched or {}
			for _, entry in ipairs(category.entries) do
				local on = false
				for _, id in ipairs(entry.ids) do
					on = on or watched[id] and true or false
				end
				lines[#lines + 1] = string.format(
					"  %s = known:%s watched:%s",
					entry.spellName,
					tostring(KnowsAny(entry.ids)),
					OnOff(on)
				)
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
			"  Account macros: %s / %d (TFTB creates a macro only while the list is under the cap, and never in combat)",
			tostring(GetNumMacros()),
			ns.Data.MAX_GLOBAL_MACROS
		)
		for index, button in ipairs(ns.Data.THANK_YOU_BUTTONS) do
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
			-- A macro the player edited no longer runs the command, so the button does nothing.
			local macroIndex = GetMacroIndexByName(button.macroName) or 0
			local macro = "missing"
			if macroIndex > 0 then
				local _, _, body = _G.GetMacroInfo(macroIndex)
				macro = (body and body:gsub("%s+$", "") == button.command) and "runs command" or "BODY EDITED"
			end
			lines[#lines + 1] = string.format(
				"  %s (%s): command=%s createMacro=%s macro=%s whisper=%s %s",
				button.command,
				button.macroName,
				SlashCmdList["TFTB_THANKYOU" .. index] and "registered" or "MISSING",
				tostring(config.createMacro),
				macro,
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
-- Buff Window Context
--------------------------------------------------------------------------------

-- The group the Buff Window reads, in its order: the raid by subgroup, or you and your party.
local function GroupUnits()
	local members = {}
	if IsInRaid() then
		for index = 1, GetNumGroupMembers() do
			local _, _, subgroup = GetRaidRosterInfo(index)
			if subgroup then
				members[#members + 1] = { unit = "raid" .. index, subgroup = subgroup }
			end
		end
	else
		members[1] = { unit = "player", subgroup = 1 }
		for index = 1, 4 do
			if UnitExists("party" .. index) then
				members[#members + 1] = { unit = "party" .. index, subgroup = 1 }
			end
		end
	end
	return members
end

local function CountKnown(ids)
	local known = 0
	for _, id in ipairs(ids or {}) do
		if IsPlayerSpell(id) then
			known = known + 1
		end
	end
	return known
end

local function SpellLabel(entry)
	local id = entry.ids[1]
	return string.format("%s (%d)", C_Spell.GetSpellName(id) or "?", id)
end

--[[
    One line per member as the window sees them: class, level, the role a
    Tanks or Healers buff is matched against, whether they can take a buff at
    all, whether they're in range of your first castable buff, and their pet.
]]
local function MemberLine(BW, member, rangeSpell)
	local unit = member.unit
	local _, class = UnitClass(unit)
	local pet = BW.PetUnitOf(unit)
	local petState = "none"
	if pet and UnitExists(pet) then
		petState = BW.CanBuffPet(pet) and "buffable" or "not buffable"
	end
	return string.format(
		"  %s (party %d): class=%s level=%s role=%s canBuff=%s connected=%s dead=%s inRange=%s pet=%s",
		unit,
		member.subgroup,
		tostring(class),
		PlainText(UnitLevel(unit)),
		BW.RoleOf(unit),
		tostring(BW.CanBuff(unit) and true or false),
		PlainText(UnitIsConnected(unit)),
		PlainText(UnitIsDeadOrGhost(unit)),
		rangeSpell and tostring(ns.IsBuffInRange(unit, rangeSpell)) or "n/a",
		petState
	)
end

-- A unit's helpful auras straight off the client: spell id -> seconds left (0 for no timer), and whether you cast it.
local function ReadUnitBuffs(unit)
	local left, mine = {}, {}
	local now = GetTime()
	for index = 1, 40 do
		local data = C_UnitAuras.GetBuffDataByIndex(unit, index, "HELPFUL")
		if not data then
			break
		end
		local spellID, expires = data.spellId, data.expirationTime
		if ns.IsPlain(spellID) and spellID and ns.IsPlain(expires) then
			left[spellID] = (expires and expires > 0) and math.max(1, math.floor(expires - now)) or 0
			mine[spellID] = ns.IsPlain(data.sourceUnit) and data.sourceUnit == "player"
		end
	end
	return left, mine
end

--[[
    What a unit has on of each castable buff in `list` that is offered to it:
    the longest-lasting version and its time left (yours or someone else's), or
    missing with the rank the window would cast at the unit's level, TOO LOW
    when none of yours fits. `class` nil skips the audience check (self buffs).
    The window's own read adds Refresh Under and the blessing families on top
    of this. A plain read of the unit's auras: the window's cache is untouched.
]]
local function BuffStates(BW, unit, class, list)
	local left, mine = ReadUnitBuffs(unit)
	local role = class and BW.RoleOf(unit)
	local parts = {}
	for _, buff in ipairs(list) do
		local name = buff.singleName or buff.groupName or "?"
		if class and not BW.Wants(buff, class, role) then
			parts[#parts + 1] = name .. "=not offered"
		else
			local best
			for id in pairs(buff.auraIds) do
				local seconds = left[id]
				if seconds and (not best or seconds == 0 or (left[best] ~= 0 and seconds > left[best])) then
					best = id
				end
			end
			if best then
				local seconds = left[best]
				parts[#parts + 1] = string.format(
					"%s=on %s%s",
					name,
					seconds == 0 and "(no timer)" or (math.floor(seconds / 60) .. "m" .. (seconds % 60) .. "s"),
					mine[best] and " yours" or ""
				)
			else
				local cast = "group version only"
				if buff.singleName then
					local rank = BW.RankFor(buff, UnitLevel(unit))
					cast = rank and rank.castText or "TOO LOW"
				end
				parts[#parts + 1] = string.format("%s=missing cast=%s", name, cast)
			end
		end
	end
	if #parts == 0 then
		return "    buffs: (none castable)"
	end
	return "    buffs: " .. table.concat(parts, " | ")
end

--[[
    The state behind a "the Buff Window never shows" or "it doesn't offer X"
    report: whether it set up, every switch and setting, each gate its refresh
    checks (combat, WoW Forever's secret auras, nothing castable), every buff
    and self buff your class has on this client with who it's offered to, the
    ranks you know, and the rank and group version the window would cast, then
    every group member and your target as the window reads them, each with
    which of your buffs they have on or are missing. The group read is skipped
    in combat, as the window skips it. Existence/value reads only: nothing is
    cast, targeted or redrawn.
]]
function ns:BuildBuffWindowContextReport()
	local lines = { GetClientHeader(), "" }
	local BW = ns.BuffWindow
	local db = ns.db and ns.db.profile.buffWindow
	if not BW then
		lines[#lines + 1] = "Buff Window: not loaded"
		return table.concat(lines, "\n")
	end
	if not db then
		lines[#lines + 1] = "Buff Window: (database not loaded)"
		return table.concat(lines, "\n")
	end

	local _, class = UnitClass("player")
	lines[#lines + 1] = string.format(
		"Set up: %s  Class: %s  Class has Buff Window rows: %s",
		tostring(BW.isSetUp),
		tostring(class),
		tostring(ns.BuffWindowHasClassRows and ns.BuffWindowHasClassRows())
	)
	lines[#lines + 1] = string.format(
		"Switches: enabled=%s hideInCombat=%s locked=%s selfBuffs=%s returnTheFavor=%s target=%s",
		tostring(db.enabled),
		tostring(db.hideInCombat),
		tostring(db.locked),
		tostring(db.selfEnabled),
		tostring(db.favorEnabled),
		tostring(db.targetEnabled)
	)
	lines[#lines + 1] = string.format(
		"Settings: countAsMissingUnder=%s min petsAsTanks=%s (%s)",
		tostring(db.refreshMinutes),
		tostring(db.petsAsTanks),
		tostring(db.petsAsTanksWhen)
	)
	lines[#lines + 1] = string.format(
		"Gates now: inCombat=%s aurasSecret=%s castableBuffs=%d castableSelfBuffs=%d",
		tostring(InCombatLockdown() and true or false),
		tostring(ns.AreAurasSecret()),
		#BW.buffs,
		#BW.selfBuffs
	)
	lines[#lines + 1] = string.format(
		"Rows live on this client: %d of %d buffs, %d of %d self buffs",
		#BW.entries,
		#(ns.BUFF_WINDOW_SPELLS or {}),
		#BW.selfEntries,
		#(ns.BUFF_WINDOW_SELF_SPELLS or {})
	)

	local castable = {}
	for _, buff in ipairs(BW.buffs) do
		castable[buff.key] = buff
	end
	lines[#lines + 1] = ""
	lines[#lines + 1] = "Buffs for your class:"
	local any = false
	for _, entry in ipairs(BW.entries) do
		if entry.row.class == class then
			any = true
			local buff = castable[entry.key]
			local line = string.format(
				"  %s: audience=%s ranksKnown=%d/%d groupKnown=%d/%d",
				SpellLabel(entry),
				tostring(db.audience[entry.key]),
				CountKnown(entry.ids),
				#entry.ids,
				CountKnown(entry.groupIds),
				#entry.groupIds
			)
			if buff then
				line = line
					.. string.format(
						" inWindow=yes cast=%s group=%s",
						buff.ranks[1] and buff.ranks[1].castText or "none",
						tostring(buff.groupName)
					)
			else
				line = line .. " inWindow=NO"
			end
			lines[#lines + 1] = line
		end
	end
	if not any then
		lines[#lines + 1] = "  (none for this class on this client)"
	end

	local castableSelf = {}
	for _, buff in ipairs(BW.selfBuffs) do
		castableSelf[buff.key] = buff
	end
	lines[#lines + 1] = ""
	lines[#lines + 1] = "Self buffs for your class:"
	any = false
	for _, entry in ipairs(BW.selfEntries) do
		if entry.row.class == class then
			any = true
			local buff = castableSelf[entry.key]
			lines[#lines + 1] = string.format(
				"  %s: shows=%s ranksKnown=%d/%d inWindow=%s",
				SpellLabel(entry),
				tostring(db.selfRefresh[entry.key]),
				CountKnown(entry.ids),
				#entry.ids,
				buff and ("yes cast=" .. tostring(buff.ranks[1] and buff.ranks[1].castText)) or "NO"
			)
		end
	end
	if not any then
		lines[#lines + 1] = "  (none for this class on this client)"
	end
	local aurasSecret = ns.AreAurasSecret()
	if #BW.selfBuffs > 0 then
		lines[#lines + 1] = aurasSecret and "    buffs: (auras secret)" or BuffStates(BW, "player", nil, BW.selfBuffs)
	end

	lines[#lines + 1] = ""
	if InCombatLockdown() then
		lines[#lines + 1] = "Group and target: (in combat; the window reads nobody until combat ends)"
		return table.concat(lines, "\n")
	end
	local members = GroupUnits()
	lines[#lines + 1] = string.format(
		"Group: party=%s raid=%s members read=%d",
		tostring(IsInGroup() and true or false),
		tostring(IsInRaid() and true or false),
		#members
	)
	local first = BW.buffs[1]
	local rangeSpell = first and (first.singleName or first.groupName)
	for _, member in ipairs(members) do
		lines[#lines + 1] = MemberLine(BW, member, rangeSpell)
		if BW.CanBuff(member.unit) then
			local _, memberClass = UnitClass(member.unit)
			lines[#lines + 1] = aurasSecret and "    buffs: (auras secret)"
				or BuffStates(BW, member.unit, memberClass, BW.buffs)
		end
	end

	if not UnitExists("target") then
		lines[#lines + 1] = "Target: none"
	elseif ns.IsUnitIdentitySecret("target") then
		lines[#lines + 1] = "Target: identity secret"
	else
		lines[#lines + 1] = string.format(
			"Target: player=%s inParty=%s inRaid=%s canAssist=%s canBuff=%s petControlledByPlayer=%s",
			PlainText(UnitIsPlayer("target")),
			PlainText(UnitInParty("target")),
			PlainText(UnitInRaid("target") ~= nil),
			PlainText(UnitCanAssist("player", "target")),
			tostring(BW.CanBuff("target") and true or false),
			PlainText(not UnitIsPlayer("target") and UnitPlayerControlled("target"))
		)
		if BW.CanBuff("target") then
			local _, targetClass = UnitClass("target")
			lines[#lines + 1] = aurasSecret and "    buffs: (auras secret)"
				or BuffStates(BW, "target", targetClass, BW.buffs)
		end
	end
	lines[#lines + 1] = string.format(
		"Return the Favor: a stranger who buffs you is listed for %d seconds, %d at a time.",
		db.favorSeconds,
		ns.Data.BUFF_WINDOW_FAVOR_MAX
	)

	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Emote Extract
--------------------------------------------------------------------------------

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
    same lookups the handlers match against. For GET_ITEM_INFO_RECEIVED it is
    an item of a tracked trigger, the set the panels' repaint watches (built
    from ns.TRACKED_ABILITIES the same way, on the first firing while
    logging). Everything else is counted.
]]
local trackedItems

local function IsTrackedItem(itemID)
	if not trackedItems then
		trackedItems = {}
		for _, entry in ipairs(ns.TRACKED_ABILITIES or {}) do
			for _, trigger in ipairs(entry.triggers or {}) do
				if trigger.item then
					trackedItems[trigger.item] = true
				end
			end
		end
	end
	return trackedItems[itemID] == true
end

function ns.IsCorrelatedMessage(event, id)
	if event == "GET_ITEM_INFO_RECEIVED" then
		return IsTrackedItem(id)
	end
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

local function UiLabel(constant)
	return {
		constant = constant,
		kind = "uiLabel",
		id = constant,
		lookup = function()
			return _G[constant]
		end,
	}
end

-- The command this client gives an emote token, the same catalog the emote checks read; nil when it has none.
local function EmoteCommand(token)
	for _, emote in ipairs(ns.GetEmoteCatalog()) do
		if emote.token == token then
			return emote.command
		end
	end
	return nil
end

--[[
    Every record TFTB shows or matches by the name this client gives it, for
    the Localization tab's Game Names report, built at load from this client's
    data. Each row reads the name exactly as the features do:

    - every ns.GAME_IDS constant, a spell named through C_Spell.GetSpellName
      (what ns.GetSpellLink builds the panel samples from), requested when it
      loads late;
    - every class token this client's tracked, Peer Pressure and Buff Window
      data carries, named through LOCALIZED_CLASS_NAMES_MALE as the panels show
      it;
    - the client's duration strings, through ns.FormatDuration as the Good News
      whisper uses them, with the sample count in the ID cell;
    - the pet-owner tooltip formats the Buff Window turns into patterns to find
      a targeted pet's owner (NIL means that wording is skipped on this client);
    - the group labels the Buff Window heads its party sections with;
    - every curated emote token the praise panels pick from, named by the
      command this client gives it (NIL means the client has no such emote, so
      a pick of it never plays).

    TFTB names no item by constant: tracked items' names show on Validate Data.
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
	for _, list in ipairs({ ns.BUFF_WINDOW_SPELLS or {}, ns.BUFF_WINDOW_SELF_SPELLS or {} }) do
		for _, row in ipairs(list) do
			if row.class then
				classes[row.class] = true
			end
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
			kind = "globalString",
			id = seconds,
			lookup = function()
				return ns.FormatDuration(seconds)
			end,
		}
	end

	for _, constant in ipairs({
		"UNITNAME_TITLE_PET",
		"UNITNAME_TITLE_MINION",
		"UNITNAME_TITLE_GUARDIAN",
		"UNITNAME_TITLE_CREATION",
		"UNITNAME_TITLE_CHARM",
		"UNITNAME_TITLE_COMPANION",
		"GROUP",
		"GROUP_NUMBER",
	}) do
		rows[#rows + 1] = UiLabel(constant)
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

-- The longest name a character can have, in letters.
local CHARACTER_NAME_MAX_LETTERS = 12

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

    The Buff Window's Return the Favor buttons cast through a macro naming the
    stranger, one per buff you can give right now, built by ns.BuffWindow's
    own SingleIcon with your top rank's cast text and a 12-letter name on your
    realm.
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
	local BW = ns.BuffWindow
	if BW and BW.SingleIcon then
		local realm = _G.GetNormalizedRealmName and _G.GetNormalizedRealmName() or "Realm"
		local fullName = string.rep("W", CHARACTER_NAME_MAX_LETTERS) .. "-" .. tostring(realm)
		for _, buff in ipairs(BW.buffs) do
			if buff.singleName then
				local icon = BW.SingleIcon(buff, nil, nil, fullName, fullName)
				rows[#rows + 1] = {
					label = "Buff Window favor macro (" .. buff.singleName .. ")",
					ceiling = MACRO_MAX_LENGTH,
					text = icon and icon.macrotext or "",
				}
			end
		end
		if #BW.buffs == 0 then
			notes[#notes + 1] = "No Buff Window buff is castable right now, so no favor macro was built."
		end
		notes[#notes + 1] =
			"A character name in a non-Latin script takes 2 or 3 bytes a letter, so a favor macro can run longer than shown."
	end
	if unloaded > 0 then
		notes[#notes + 1] = string.format("%d items not loaded yet; the longest link may be understated.", unloaded)
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

local function BuffRowField(field)
	return function(_, row)
		return row.row[field]
	end
end

local function FoundField(field)
	return function(_, row)
		return row[field]
	end
end

-- Single-target ranks are { id, level learned }; group ranks are bare ids.
local function CollectBuffWindow(rows)
	local found = {}
	for index, row in ipairs(rows) do
		for _, rank in ipairs(row.single or {}) do
			found[#found + 1] = { id = rank[1], key = index, row = { row = row, role = "single", level = rank[2] } }
		end
		for _, id in ipairs(row.group or {}) do
			found[#found + 1] = { id = id, key = index, row = { row = row, role = "group" } }
		end
		for _, id in ipairs(row.greater or {}) do
			found[#found + 1] = { id = id, key = index, row = { row = row, role = "greater" } }
		end
	end
	return found
end

-- Self buffs: every rank, { id, level learned }.
local function CollectSelfBuffs(rows)
	local found = {}
	for index, row in ipairs(rows) do
		for _, rank in ipairs(row.ranks or {}) do
			found[#found + 1] = { id = rank[1], key = index, row = { row = row, level = rank[2] } }
		end
	end
	return found
end

-- The pet icons' summoning spells: Call Pet for beasts, and one per demon by NPC id.
local function CollectPetIcons(icons)
	local found = {}
	if icons.beast then
		found[#found + 1] = { id = icons.beast, key = "beast", row = { npc = "" } }
	end
	for npc, spell in pairs(icons.demons or {}) do
		found[#found + 1] = { id = spell, key = npc, row = { npc = npc } }
	end
	return found
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
					{ "DATA_ROLE", FoundField("role") },
					{ "DATA_TYPE", EntryField("type") },
					{ "DATA_DETECT", EntryField("detect") },
					{ "DATA_CLASS", EntryField("class") },
					{ "DATA_RECEIVED", EntryField("received") },
					{ "DATA_GIVEN", EntryField("given") },
					{ "DATA_RECEIVABLE", EntryField("receivable") },
					{ "DATA_NO_DURATION", EntryField("noDuration") },
					{ "DATA_OPENED", EntryField("opened") },
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
	{
		label = "Buff-Window-Spells",
		sources = {
			{
				table = "BUFF_WINDOW_SPELLS",
				kind = "spell",
				collect = CollectBuffWindow,
				dataColumns = {
					{ "DATA_ROLE", FoundField("role") },
					{ "DATA_LEVEL", FoundField("level") },
					{ "DATA_CLASS", BuffRowField("class") },
					{ "DATA_EXCLUSIVE", BuffRowField("exclusive") },
					{ "DATA_MANA_ONLY", BuffRowField("manaOnly") },
					{ "DATA_NO_CASTERS", BuffRowField("noCasters") },
					{ "DATA_DEFAULT", BuffRowField("default") },
				},
			},
			{
				table = "BUFF_WINDOW_SELF_SPELLS",
				kind = "spell",
				collect = CollectSelfBuffs,
				dataColumns = {
					{ "DATA_LEVEL", FoundField("level") },
					{ "DATA_CLASS", BuffRowField("class") },
					{ "DATA_EXCLUSIVE", BuffRowField("exclusive") },
					{ "DATA_DEFAULT", BuffRowField("default") },
				},
			},
			{
				table = "BUFF_WINDOW_PET_ICONS",
				kind = "spell",
				collect = CollectPetIcons,
				dataColumns = {
					{ "DATA_NPC_ID", FoundField("npc") },
				},
			},
		},
	},
}
