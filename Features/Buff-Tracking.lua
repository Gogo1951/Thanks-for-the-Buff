local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--[[
    The buff-reaction engine behind the Strangers, Teammates, Services, and
    Good News options panels. Watches the combat log, classifies the source,
    and routes to the announcement helpers. Owns its own lookups, caches,
    cooldowns, and timers; its event handlers attach through Core's dispatcher
    (ns.SetEventHandler), and the events themselves are declared in Core's
    ns.EVENT_NAMES.
]]

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local sessionCooldowns = {}
local isReady = false
local auraLookup = {}
local castLookup = {}
local givenLookup = {} -- Good News: keyed by CAST id (see BuildLookups)
local pendingGiven = {} -- castGUID -> recipient captured at UNIT_SPELLCAST_SENT
local playerGUID -- cached at login; a character's GUID never changes within a session
local FLAVOR_INDEX = ns.FLAVOR_INDEX -- which {Era, TBC, Wrath} default column applies on this client

--------------------------------------------------------------------------------
-- Cooldowns
--------------------------------------------------------------------------------

local function IsOnCooldown(guid)
	local now = GetTime()
	local expiresAt = sessionCooldowns[guid]
	return expiresAt and expiresAt > now
end

local function SetCooldown(guid, duration)
	local now = GetTime()
	-- Opportunistic sweep: drop lapsed entries so the table can't grow unbounded
	-- across a long session (one key per distinct source/recipient reacted to).
	-- Clearing an existing field mid-pairs is defined behavior in Lua.
	for key, expiresAt in pairs(sessionCooldowns) do
		if expiresAt <= now then
			sessionCooldowns[key] = nil
		end
	end
	sessionCooldowns[guid] = now + (duration or 10)
end

--[[
    Per-recipient whisper throttle. Whispers go to OTHER players, so unlike the
    self-only prints (which fire on every buff) they must not repeat: a player who
    rebuffs you several times is thanked at most once per window, which also keeps
    us clear of Blizzard's whisper spam squelch. Keyed by GUID under a "whisper:"
    namespace so it never collides with the praise/service cooldowns on the same
    GUID, and it sits underneath the user-set praise cooldowns as a floor they
    cannot lower. Checks and stamps in one call, and only stamps when a whisper is
    actually cleared to send, so the window is measured from the last whisper we sent.
]]
local WHISPER_COOLDOWN = 45
local function TryWhisperCooldown(guid)
	if not guid then
		return true
	end
	local key = "whisper:" .. guid
	if IsOnCooldown(key) then
		return false
	end
	SetCooldown(key, WHISPER_COOLDOWN)
	return true
end

-- The Strangers panel's overall praise limit: one key for the whole feature,
-- since it asks "how recently did I praise ANYONE", not "how recently did I
-- praise this player" (that is the per-source "praise:<guid>" key).
local PRAISE_OVERALL_KEY = "praise:all"

--------------------------------------------------------------------------------
-- Safety Timer
--------------------------------------------------------------------------------

-- Suppresses buff reactions until the world settles after login or a loading screen.
-- A token invalidates earlier timers: back-to-back loading screens each arm a new
-- pause, and only the most recent callback may restore readiness, so a stale timer
-- can't flip isReady back on mid-pause.
local safetyToken = 0
local function StartSafetyTimer(duration)
	isReady = false
	safetyToken = safetyToken + 1
	local token = safetyToken
	C_Timer.After(duration or Data.SAFETY_PAUSE, function()
		if token == safetyToken then
			isReady = true
		end
	end)
end

--------------------------------------------------------------------------------
-- Tracked Lookups
--------------------------------------------------------------------------------

-- The id the combat log carries for a trigger: the aura it applies (AURA) or the
-- cast id (CAST). An item trigger's `spell` already is that id; a spell trigger
-- may name a separate `aura`.
local function WatchedId(entry, trigger)
	if entry.detect == Data.DETECT.AURA then
		return trigger.aura or trigger.spell
	end
	return trigger.spell
end

--[[
    Two lookups keyed by the id the combat log carries: auras (SPELL_AURA_APPLIED)
    and casts (SPELL_CAST_SUCCESS). Each records its message type and detect mode,
    and -- for item reactions -- the source item so the message links the item.

    A third, givenLookup, backs Good News and is keyed by the CAST id instead,
    because that is what UNIT_SPELLCAST_SENT/SUCCEEDED carry -- which for an
    aura-detect entry whose aura id differs from its cast id (Misdirection) is
    NOT the id auraLookup uses. It carries `watchedId` (the id the panel toggles
    and the settings list are keyed by) and `auraId` (what to read the duration
    off the recipient with), so neither has to be re-derived at cast time.
    Services are excluded: they have no per-person recipient to tell.
]]
local function BuildLookups()
	local DoesSpellExist = ns.DoesSpellExist
	wipe(auraLookup)
	wipe(castLookup)
	wipe(givenLookup)

	for _, entry in ipairs(Data.TRACKED) do
		--[[
            "-" in the entry's received column: this row does not exist on this
            flavor at all -- a stronger statement than DoesSpellExist can make,
            because Blizzard reuses spell ids across flavors for entirely
            different abilities (see the data file header). A skipped row owns
            nothing: no lookup, no toggle, no seed.
        ]]
		local received = entry.received and entry.received[FLAVOR_INDEX]
		if received ~= "-" then
			local lookup = (entry.detect == Data.DETECT.AURA) and auraLookup or castLookup
			-- Seeds consumed by PopulateWatchedBuffs: 0 seeds a checkbox off,
			-- anything else on; a missing column degrades to on (the
			-- pre-column behavior).
			local receivedDefault = received ~= 0
			local givenDefault = entry.given == nil or entry.given[FLAVOR_INDEX] ~= 0
			for _, trigger in ipairs(entry.triggers) do
				local watched = WatchedId(entry, trigger)
				-- Drop triggers absent on this client (mirrors BuildDisplayGroups).
				if DoesSpellExist(trigger.spell) or DoesSpellExist(watched) then
					lookup[watched] = {
						type = entry.type,
						detect = entry.detect,
						itemId = trigger.item,
						opened = entry.opened,
						receivedDefault = receivedDefault,
						givenDefault = givenDefault,
					}
					if entry.type ~= Data.BUFF.SERVICE then
						givenLookup[trigger.spell] = {
							type = entry.type,
							detect = entry.detect,
							itemId = trigger.item,
							watchedId = watched,
							-- What to read the recipient's remaining duration with.
							-- Deliberately absent for a cast that leaves no aura and
							-- for a `noDuration` entry (Fear Ward, Misdirection):
							-- nothing to read is what drops the "for 10 minutes"
							-- clause from their message.
							auraId = (entry.detect == Data.DETECT.AURA and not entry.noDuration) and watched or nil,
						}
					end
				end
			end
		end
	end

	-- Surface the watched-id counts for the diagnostics context report.
	local auraCount, castCount = 0, 0
	for _ in pairs(auraLookup) do
		auraCount = auraCount + 1
	end
	for _ in pairs(castLookup) do
		castCount = castCount + 1
	end
	ns.DIAGNOSTIC_TRACKED.auraIds = auraCount
	ns.DIAGNOSTIC_TRACKED.castIds = castCount
end

-- Watched state is keyed by the watched spell id; a key the saved list doesn't
-- hold yet seeds from the entry's per-flavor received/given columns, carried on
-- the lookup records by BuildLookups (0 seeds off), and a user's own choice is
-- never overwritten. One shared list backs both the Teammates and Services
-- panels; ids never overlap between them, so a single table is unambiguous. The
-- Good News panel reuses the teammate ids with independent choices, so it
-- seeds its own list here -- service ids are excluded (a service has no
-- per-person recipient to whisper).
local function PopulateWatchedBuffs()
	local SERVICE = Data.BUFF.SERVICE
	local watched = ns.db.profile.watchedBuffs
	local given = ns.db.profile.goodNews.watched
	for id, info in pairs(auraLookup) do
		if watched[id] == nil then
			watched[id] = info.receivedDefault
		end
		if info.type ~= SERVICE and given[id] == nil then
			given[id] = info.givenDefault
		end
	end
	for id, info in pairs(castLookup) do
		if watched[id] == nil then
			watched[id] = info.receivedDefault
		end
		if info.type ~= SERVICE and given[id] == nil then
			given[id] = info.givenDefault
		end
	end

	--[[
        Drop persisted ids not live on this client, so the saved list and the
        diagnostics counts stay client-real. Ids re-seed above if the client
        later gains them, so this is safe across a client's progression.
    ]]
	for id in pairs(watched) do
		if auraLookup[id] == nil and castLookup[id] == nil then
			watched[id] = nil
		end
	end
	for id in pairs(given) do
		local info = auraLookup[id] or castLookup[id]
		if not info or info.type == SERVICE then
			given[id] = nil
		end
	end
end
ns.PopulateWatchedBuffs = PopulateWatchedBuffs

--------------------------------------------------------------------------------
-- Display Groups
--------------------------------------------------------------------------------

--[[
    Reshape Data.TRACKED into the products the options panels and the diagnostics
    report consume. Built once at login, when the spell/item APIs are live:

    - ns.TeammateCategories : ordered categories for the Buffs-from-Teammates
      panel -- one per class, then a generic Items group.
    - ns.ServiceEntries     : a flat list for the Group-Services panel.
    - ns.DIAGNOSTIC_SPELLS  : per-class { name, ids } (ability ids) for the
      IsPlayerSpell probe in the diagnostics report.
    - ns.DIAGNOSTIC_TRACKED : live/total entry and watched-id counts for the
      diagnostics report, so a Data/client spell-id mismatch is visible.

    One TRACKED entry becomes exactly one toggle; rows whose received column is
    "-" for this flavor are skipped outright, triggers absent from the running
    client are dropped, and an entry with none left is skipped.
]]
local function WarmItemCache()
	-- Touch every tracked item so its name/link is cached for the options panel
	-- and the "used their X on you" message. Cold entries resolve asynchronously.
	for _, entry in ipairs(Data.TRACKED) do
		for _, trigger in ipairs(entry.triggers) do
			if trigger.item then
				ns.GetItemInfo(trigger.item)
			end
		end
	end
end

local function BuildDisplayGroups()
	local SERVICE = Data.BUFF.SERVICE
	local GetSpellName = ns.GetSpellName
	local DoesSpellExist = ns.DoesSpellExist

	local classBuckets = {} -- class -> { toggle entries }  (Buffs from Teammates)
	local itemEntries = {} -- class-less, non-service        (Items group)
	local serviceEntries = {} -- Group Services
	local diagnostic = {} -- class -> { {name, ids} }
	local entriesTotal, entriesLive = 0, 0 -- client coverage for diagnostics

	for _, entry in ipairs(Data.TRACKED) do
		-- Rows marked "-" in received for this flavor don't exist here: no
		-- toggle, and they stay out of the coverage counts -- absent by
		-- declaration, not by a Data/client id mismatch.
		if (entry.received and entry.received[FLAVOR_INDEX]) ~= "-" then
			entriesTotal = entriesTotal + 1
			-- Drop triggers whose spell is absent on this client; skip a hollow entry.
			local ids, items, abilities, iconItem = {}, {}, {}, nil
			for _, trigger in ipairs(entry.triggers) do
				local watched = WatchedId(entry, trigger)
				if DoesSpellExist(trigger.spell) or DoesSpellExist(watched) then
					ids[#ids + 1] = watched
					abilities[#abilities + 1] = trigger.spell
					if trigger.item then
						items[#items + 1] = trigger.item
						iconItem = iconItem or trigger.item
					end
				end
			end

			if #ids > 0 then
				entriesLive = entriesLive + 1
				local name = entry.name or GetSpellName(abilities[1]) or L["COMBAT_SPELL_PENDING"]:format(abilities[1])

				-- One TRACKED entry == one toggle.
				local toggle = { ids = ids }
				if #items > 0 then
					toggle.itemId = iconItem
					toggle.itemIds = items -- tooltip lists them when more than one
					toggle.label = entry.name -- nil for a lone item -> uses its own name
				else
					toggle.spellName = name
					if entry.name then
						toggle.spellIds = abilities -- named group -> tooltip lists members
					end
				end

				-- Route to a panel: services first, then class, then generic items.
				if entry.type == SERVICE then
					serviceEntries[#serviceEntries + 1] = toggle
				elseif entry.class then
					classBuckets[entry.class] = classBuckets[entry.class] or {}
					local bucket = classBuckets[entry.class]
					bucket[#bucket + 1] = toggle
				else
					itemEntries[#itemEntries + 1] = toggle
				end

				-- Diagnostics: every class-flavored *spell* (items aren't player spells).
				if entry.class and #items == 0 then
					diagnostic[entry.class] = diagnostic[entry.class] or {}
					local d = diagnostic[entry.class]
					d[#d + 1] = { name = name, ids = abilities }
				end
			end
		end
	end

	ns.DIAGNOSTIC_SPELLS = diagnostic
	ns.DIAGNOSTIC_TRACKED.entriesLive = entriesLive
	ns.DIAGNOSTIC_TRACKED.entriesTotal = entriesTotal

	-- Classes alphabetically, then the generic Items group.
	local categories = {}
	local classNames = {}
	for class in pairs(classBuckets) do
		classNames[#classNames + 1] = class
	end
	table.sort(classNames)
	for _, class in ipairs(classNames) do
		local color = Data.CLASS_COLORS[class] or "FFFFFF"
		local label = "|cff" .. color .. (LOCALIZED_CLASS_NAMES_MALE[class] or class) .. "|r"
		categories[#categories + 1] = { id = class, name = label, entries = classBuckets[class] }
	end

	if #itemEntries > 0 then
		categories[#categories + 1] = {
			id = "ITEMS",
			name = GetColor("TITLE") .. L["COMBAT_GROUP_ITEMS"] .. "|r",
			entries = itemEntries,
		}
	end

	ns.TeammateCategories = categories
	ns.ServiceEntries = serviceEntries
end

--------------------------------------------------------------------------------
-- Source Resolution
--------------------------------------------------------------------------------

--[[
    A buff's combat-log source can be a pet or guardian (a hunter's Roar of
    Sacrifice, for example). Credit the owner so the message names the player,
    not the pet — owners are found by matching the pet's GUID to a group pet unit.
]]
local function GetPetOwnerUnit(petGUID)
	if UnitGUID("pet") == petGUID then
		return "player"
	end
	for i = 1, 4 do
		if UnitGUID("partypet" .. i) == petGUID then
			return "party" .. i
		end
	end
	for i = 1, 40 do
		if UnitGUID("raidpet" .. i) == petGUID then
			return "raid" .. i
		end
	end
	return nil
end

--[[
    Credit for a buff goes to a player or to nobody. A pet/guardian source is
    traded for its owner; when that lookup fails -- group pet tokens are missing
    more often than you'd think (a raid pet out of range, a pet the client hasn't
    loaded) -- we return nil so the caller drops the event entirely. Trap: do NOT
    fall back to the pet itself. Its name is not a player's, so the thank-you
    whisper bounces ("No player named 'Woofbark' is currently playing") and the
    print credits an animal; and because a pet inherits its owner's PARTY/RAID
    affiliation, nothing downstream would catch it.
]]
local function ResolveSource(sourceGUID, sourceName, sourceFlags)
	if ns.IsPlayerGUID(sourceGUID) then
		return sourceGUID, sourceName
	end
	local ownerUnit = GetPetOwnerUnit(sourceGUID)
	if ownerUnit then
		return UnitGUID(ownerUnit), GetUnitName(ownerUnit, true)
	end
	return nil
end

--[[
    A usable emote target must be a live unit token: DoEmote only directs "you
    cheer at X" at a real unit, and a combat-log name is not one -- cross-realm
    sources arrive as "Name-Realm" and never resolve. Map the buffer's GUID to a
    unit we actually have (the player, a group member, or the current target /
    focus / mouseover) and return nil when none matches, so the caller emotes
    undirected instead of passing an unmatchable name.
]]
local function ResolveEmoteUnit(guid)
	if not guid then
		return nil
	end
	if UnitGUID("player") == guid then
		return "player"
	end
	local prefix, count = "party", 4
	if IsInRaid() then
		prefix, count = "raid", 40
	end
	for i = 1, count do
		local unit = prefix .. i
		if UnitExists(unit) and UnitGUID(unit) == guid then
			return unit
		end
	end
	for _, unit in ipairs({ "target", "focus", "mouseover" }) do
		if UnitExists(unit) and UnitGUID(unit) == guid then
			return unit
		end
	end
	return nil
end

--[[
    Best emote direction for a buffer: their unit token when we hold one, else
    their bare character name. The client resolves a name to any player it can
    currently see -- but only the bare form, never the combat log's cross-realm
    "Name-Realm", so the realm is stripped. This fallback is strictly safe:
    DoEmote treats a name it can't resolve exactly like "none" (the undirected
    emote), never the current target. Worst realistic miss is two visible
    same-named players from different realms, which just salutes the wrong twin.
]]
local function ResolveEmoteTarget(guid, name)
	local unit = ResolveEmoteUnit(guid)
	if unit then
		return unit
	end
	if name then
		return Ambiguate(name, "short")
	end
	return nil
end

--------------------------------------------------------------------------------
-- Buff Handlers
--------------------------------------------------------------------------------

--[[
    Send the praise: the thank-you whisper, the emote, or both. Every gate -- the
    toggles, the cooldowns, the whisper throttle, the combat check -- is settled
    by the caller before the timer is armed, so the Praise Delay holds back
    delivery only; a burst of buffs can't slip past a cooldown by landing inside
    the delay window.

    Two things are deliberately decided late instead, when the emote actually
    fires. Combat, because the promise on that toggle is that an emote never
    plays while you are fighting. And the emote target: ResolveEmoteTarget hands
    back a live unit token, and "target", "focus", and "mouseover" all name
    whoever you are pointing at in that instant -- resolve it early and a delayed
    emote thanks whoever you moved on to. An unresolvable buffer degrades to
    their bare name, then to the undirected emote.
]]
local function DeliverPraise(db, guid, name, link, whisperAllowed, emoteAllowed)
	local function Praise()
		if whisperAllowed then
			ns:WhisperThanks(name, link)
		end
		if emoteAllowed and not InCombatLockdown() then
			ns:DoRandomEmote(db.emotes, ResolveEmoteTarget(guid, name))
		end
	end

	local delay = db.praiseDelayEnabled and db.praiseDelay or 0
	if delay > 0 then
		C_Timer.After(delay, Praise)
	else
		Praise()
	end
end

--[[
    Group/raid PRINTS and emotes are intentionally NOT rate-limited: each cast is a
    distinct cooldown a teammate spent, so we acknowledge every one. The outgoing
    whisper is the exception -- it is throttled per-recipient (TryWhisperCooldown)
    so a teammate who repeatedly buffs you in a raid isn't whisper-spammed.
]]
local function HandleTracked(entry, spellID, creditGUID, creditName, destGUID, playerGUID)
	if entry.type == Data.BUFF.SERVICE then
		-- A service set out for the group: no per-you dest, just don't self-credit.
		if creditGUID == playerGUID then
			return
		end
	elseif destGUID ~= playerGUID then
		-- SOLO / GROUP buffs must actually land on you.
		return
	end

	if not ns.db.profile.watchedBuffs[spellID] then
		return
	end

	-- No-aura raid help reacts with the Group Services settings; everything cast
	-- on you (SOLO / GROUP) uses the Buffs from Teammates settings.
	local db = (entry.type == Data.BUFF.SERVICE) and ns.db.profile.services or ns.db.profile.teammates
	local link = ns.GetBuffLink(entry, spellID)

	if db.printEnabled then
		ns:AnnounceTracked(entry, creditGUID, creditName, link)
	end

	-- Like the print, the sound is self-only and fires on every acknowledged
	-- cast, in or out of combat.
	if db.soundEnabled then
		ns.PlayBuffSound()
	end

	-- Emotes are visible and social, so they are held back until you leave combat.
	local whisperAllowed = db.whisperEnabled and TryWhisperCooldown(creditGUID)
	local emoteAllowed = db.emotesEnabled and not InCombatLockdown()
	if whisperAllowed or emoteAllowed then
		DeliverPraise(db, creditGUID, creditName, link, whisperAllowed, emoteAllowed)
	end
end

local function HandleStrangersBuff(sourceGUID, sourceName, spellID)
	-- No master on/off switch: the print / whisper / emote / sound toggles are the
	-- enable. With all four off, every reaction below no-ops, so nothing fires.
	local db = ns.db.profile.strangers
	if not db then
		return
	end

	-- nil means the buff isn't on you; a live buff may still report 0 (no timer).
	local duration = ns.GetBuffDuration("player", spellID)
	if not duration then
		return
	end

	-- Too short to be worth reacting to at all: no notification and no praise.
	if db.minBuffDuration and db.minBuffDuration > 0 and duration > 0 and duration < db.minBuffDuration then
		return
	end

	local link = ns.GetBuffLink(nil, spellID)

	-- Notifications are self-only and fire for every qualifying buff, in or out of
	-- combat. Only the praise below answers to the cooldowns and the delay.
	if db.printEnabled then
		ns:AnnounceStranger(sourceGUID, sourceName, link)
	end

	if db.soundEnabled then
		ns.PlayBuffSound()
	end

	--[[
        Two praise cooldowns, both user settings: the overall one keeps a
        mass-buff moment from turning into a chain of thank-yous, the per-source
        one keeps a single player from being praised over and over. Neither is
        spent unless praise is cleared to go out, so a buff that arrives while you
        are in combat with emotes as your only enabled praise costs nothing. The
        per-recipient whisper throttle sits on top as a floor no setting can
        lower, so a short cooldown can't whisper someone into the server's chat
        squelch.
    ]]
	local sourceKey = "praise:" .. sourceGUID
	if IsOnCooldown(PRAISE_OVERALL_KEY) or IsOnCooldown(sourceKey) then
		return
	end

	local whisperAllowed = db.whisperEnabled and TryWhisperCooldown(sourceGUID)
	local emoteAllowed = db.emotesEnabled and not InCombatLockdown()
	if not whisperAllowed and not emoteAllowed then
		return
	end

	if db.praiseCooldown and db.praiseCooldown > 0 then
		SetCooldown(PRAISE_OVERALL_KEY, db.praiseCooldown)
	end
	SetCooldown(sourceKey, db.cooldown)

	DeliverPraise(db, sourceGUID, sourceName, link, whisperAllowed, emoteAllowed)
end

--------------------------------------------------------------------------------
-- Good News
--------------------------------------------------------------------------------

--[[
    Good News whispers for tracked buffs YOU cast on another player.

    Driven by UNIT_SPELLCAST_SENT + UNIT_SPELLCAST_SUCCEEDED, NOT the combat log.
    Trap: the combat log is scoped to you, your group, and units in combat, so
    buffing a player outside your group produces no SPELL_AURA_APPLIED at all --
    the single most common case for this feature is exactly the one the combat
    log never reports. SENT is also the only event that names the recipient;
    SUCCEEDED then confirms the cast actually went off, so an interrupted cast
    stays silent.

    Deduped per recipient+spell so a quick recast doesn't whisper twice.
]]
local GOODNEWS_DEDUP = 10
local PENDING_TTL = 15 -- a SENT whose SUCCEEDED never arrives (cast interrupted)
local AURA_SETTLE = 0.1 -- the aura lands a moment after the cast succeeds

--[[
    UNIT_SPELLCAST_SENT names the recipient but gives neither unit nor GUID. Map
    the name back to a unit we hold, which is what lets us confirm the recipient
    is a player (buffing a pet must stay silent -- it has nobody to read the
    whisper) and read the buff's duration off them afterwards. Ordered by how
    people actually cast: at your target, a mouseover/focus macro, then a group
    member by unit token.
]]
local function ResolveUnitByName(name)
	if not name then
		return nil
	end
	local short = Ambiguate(name, "short")
	local function Matches(unit)
		if not UnitExists(unit) then
			return false
		end
		local unitName = GetUnitName(unit, true)
		return unitName ~= nil and (unitName == name or Ambiguate(unitName, "short") == short)
	end

	for _, unit in ipairs({ "target", "mouseover", "focus" }) do
		if Matches(unit) then
			return unit, UnitGUID(unit)
		end
	end
	local prefix, count = "party", 4
	if IsInRaid() then
		prefix, count = "raid", 40
	end
	for i = 1, count do
		local unit = prefix .. i
		if Matches(unit) then
			return unit, UnitGUID(unit)
		end
	end
	return nil
end

local function SweepPendingGiven()
	local cutoff = GetTime() - PENDING_TTL
	for castGUID, pending in pairs(pendingGiven) do
		if pending.at < cutoff then
			pendingGiven[castGUID] = nil
		end
	end
end

local function AnnounceGivenCast(pending)
	local dedupKey = "goodnews:" .. pending.guid .. ":" .. pending.spellID
	if IsOnCooldown(dedupKey) then
		return
	end
	SetCooldown(dedupKey, GOODNEWS_DEDUP)

	--[[
        The aura is applied a beat after the cast succeeds, so reading it now
        would report "no duration" for every buff. Wait a tick, then read it off
        the recipient -- re-checking the unit still holds their GUID, since they
        may have been untargeted in the meantime. A no-aura cast (Rebirth) and an
        unreadable one both fall through to the duration-less flavor.
    ]]
	C_Timer.After(AURA_SETTLE, function()
		local duration
		if pending.unit and pending.auraId and UnitGUID(pending.unit) == pending.guid then
			duration = ns.GetBuffDuration(pending.unit, pending.auraId)
		end
		ns:AnnounceGoodNews(pending.entry, pending.name, pending.spellID, duration)
	end)
end

local function OnUnitSpellcastSent(unit, target, castGUID, spellID)
	if unit ~= "player" or not isReady or not ns.db then
		return
	end
	local db = ns.db.profile.goodNews
	if not db or not db.whisperEnabled then
		return
	end
	local entry = givenLookup[spellID]
	if not entry or not db.watched[entry.watchedId] then
		return
	end

	local recipientUnit, guid = ResolveUnitByName(target)
	-- Players only, never yourself. An unresolvable name is dropped rather than
	-- guessed at: we can't confirm it isn't a pet, and a whisper to a pet bounces.
	if not ns.IsPlayerGUID(guid) or guid == playerGUID then
		return
	end

	-- Recipient scope: ALWAYS whispers anyone you buff; everything else means
	-- group members only -- your party or raid, and a battleground IS a raid
	-- group, so it needs no case of its own. Unrecognized values fail closed
	-- into the group check: for an outgoing-whisper feature, the safe wrong
	-- guess is fewer strangers whispered, not more.
	if db.scope ~= "ALWAYS" then
		if not (UnitInParty(recipientUnit) or UnitInRaid(recipientUnit)) then
			return
		end
	end

	SweepPendingGiven()
	pendingGiven[castGUID] = {
		name = target,
		guid = guid,
		unit = recipientUnit,
		entry = entry,
		spellID = spellID,
		auraId = entry.auraId,
		at = GetTime(),
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--------------------------------------------------------------------------------

local function OnCombatLogEvent()
	if not isReady or not ns.db then
		return
	end

	local _, subEvent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, _, _, spellID =
		CombatLogGetCurrentEventInfo()

	-- REFRESH counts as an aura landing: recasting a buff the target already has
	-- emits SPELL_AURA_REFRESH, not APPLIED, and a rebuff earns the same thanks.
	local isAura = (subEvent == "SPELL_AURA_APPLIED") or (subEvent == "SPELL_AURA_REFRESH")
	local isCast = (subEvent == "SPELL_CAST_SUCCESS")
	if not isAura and not isCast then
		return
	end

	-- Diagnostics probe: log raw cast-success events (portals, summons, feasts)
	-- before the guards below drop anything, so even your own test casts and casts
	-- that get filtered out are still visible in the event log. See ns:LogCombatCast.
	if isCast and ns.diagnostics and ns.diagnostics.logging then
		ns:LogCombatCast(
			spellID,
			sourceName,
			sourceFlags,
			castLookup[spellID] ~= nil,
			ns.db.profile.watchedBuffs and ns.db.profile.watchedBuffs[spellID]
		)
	end

	-- Peer Pressure: same-class cooldown pops. Sits above the own-source drop below
	-- because "Trigger on Own Casts" lets your own cooldowns fire the alert too;
	-- CheckPeerPressure applies that setting itself. A cheap tap -- its first line
	-- is a lookup that misses for everything untracked.
	if isCast and ns.CheckPeerPressure then
		ns.CheckPeerPressure(spellID, sourceGUID, sourceName, destGUID, destName)
	end

	-- Your own casts are Good News's business, and it runs off the cast events
	-- instead (see OnUnitSpellcastSent); everything below reacts to what OTHERS
	-- do to you.
	if not sourceGUID or sourceGUID == playerGUID then
		return
	end

	local entry = (isAura and auraLookup[spellID]) or (isCast and castLookup[spellID])

	-- Service casts (portals, summons, feasts) are announced from
	-- UNIT_SPELLCAST_SUCCEEDED instead -- they don't reliably reach the combat log
	-- -- so drop any that surface here, both to avoid a double announce and because
	-- the combat log can't be relied on to carry them at all.
	if entry and entry.type == Data.BUFF.SERVICE then
		entry = nil
	end

	--[[
        A stranger buff is a HELPFUL aura that lands on you from a friendly
        player outside your group. Combat no longer suppresses stranger messages
        (only the emote waits until you leave combat -- see HandleStrangersBuff),
        but the source/group resolution below is still gated: react only to a
        tracked spell or to a stranger buff on you. Everything else -- including
        group members' untracked buffs in a raid -- bails here so combat log
        processing stays cheap, using the affiliation flag instead of a UnitIn*
        scan to recognize an outsider.

        Ordered cheapest first, so a cast event or an aura landing on anyone but
        you stops at a comparison before the GUID check allocates. Only that GUID
        check proves the source is a player (a pet's doesn't, whatever its flags
        claim); the flags then say whose side they're on and which group.
    ]]
	local maybeStranger = isAura
		and destGUID == playerGUID
		and ns.IsPlayerGUID(sourceGUID)
		and bit.band(sourceFlags or 0, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0
		and bit.band(sourceFlags or 0, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0

	if not entry and not maybeStranger then
		return
	end

	local creditGUID, creditName = ResolveSource(sourceGUID, sourceName, sourceFlags)
	if not creditName then
		return
	end

	--[[
        Trap: a name lookup misses cross-realm sources, whose combat-log name is
        "Name-Realm". Classify by affiliation flags instead. MINE/PARTY/RAID cover
        group members and their pets, which inherit the owner's affiliation. MINE
        also covers the player's own pet, so the creditGUID guard stops a self-cast
        (a hunter's Roar of Sacrifice on themselves) from crediting the player.
    ]]
	local sourceIsGroupMember = creditGUID ~= playerGUID
		and (
			bit.band(sourceFlags or 0, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0
			or bit.band(sourceFlags or 0, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0
			or bit.band(sourceFlags or 0, COMBATLOG_OBJECT_AFFILIATION_RAID) > 0
		)

	if sourceIsGroupMember then
		if entry then
			HandleTracked(entry, spellID, creditGUID, creditName, destGUID, playerGUID)
		end
	elseif maybeStranger then
		HandleStrangersBuff(sourceGUID, sourceName, spellID)
	end
end

--[[
    Group services are announced from UNIT_SPELLCAST_SUCCEEDED, not the combat log:
    portals, summons, feasts and the like are utility casts that don't reliably
    produce a SPELL_CAST_SUCCESS in COMBAT_LOG_EVENT_UNFILTERED, but they DO fire
    this unit event for any unit the client tracks (party/raid, target, focus). A
    service has no per-you target, so crediting the casting unit is all we need --
    which is also why solo casts (Rebirth, Lay on Hands) stay on the combat log,
    where the destination tells us the buff actually landed on you.

    That same breadth is why the caster is filtered to your party or raid below:
    the event's reach is much wider than the feature's, and a service cast by
    someone you merely have targeted was never meant to announce.

    The per-source "service:" cooldown does double duty: it rate-limits a mage
    opening several portals in a row, and it dedupes the multiple tokens a single
    cast can fire (party1 and target for the same caster resolve to one GUID, so the
    second is already on cooldown).
]]
local function OnUnitSpellcastSucceeded(unitTarget, castGUID, spellID)
	if not isReady or not ns.db then
		return
	end

	-- Good News: this cast is one of yours, and SENT already vetted and named
	-- the recipient. Claimed before the service check below, which is about
	-- OTHER people's casts.
	local pending = castGUID and pendingGiven[castGUID]
	if pending then
		pendingGiven[castGUID] = nil
		AnnounceGivenCast(pending)
	end

	local entry = castLookup[spellID]
	if not entry or entry.type ~= Data.BUFF.SERVICE then
		return
	end

	-- Group members only, never ourselves. The event fires for every unit the
	-- client tracks, so without the group test a stranger opening a portal
	-- across a capital city reads as a service to us -- and "Group Services" is
	-- the whole promise of the panel. Being in the group subsumes the old
	-- friendly-player test; UnitIsPlayer stays to drop group pets, which the
	-- group calls don't distinguish. A battleground IS a raid, so it needs no
	-- case of its own.
	if not UnitIsPlayer(unitTarget) then
		return
	end
	if not (UnitInParty(unitTarget) or UnitInRaid(unitTarget)) then
		return
	end
	local creditGUID = UnitGUID(unitTarget)
	if not creditGUID or creditGUID == playerGUID then
		return
	end
	local creditName = GetUnitName(unitTarget, true)
	if not creditName then
		return
	end

	local cooldownKey = "service:" .. creditGUID
	if not IsOnCooldown(cooldownKey) then
		HandleTracked(entry, spellID, creditGUID, creditName, nil, playerGUID)
		SetCooldown(cooldownKey)
	end
end

local function OnLoadingScreenDisabled()
	StartSafetyTimer(Data.SAFETY_PAUSE)
end

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

--[[
    Run once from Core's login sequence, after the saved variables are live and
    the spell/item APIs return real data. Builds the lookups and display groups,
    seeds the watched list, warms the item cache, and arms the safety timer.
]]
function ns.SetupBuffTracking()
	playerGUID = UnitGUID("player")
	BuildLookups()
	PopulateWatchedBuffs()
	WarmItemCache()
	BuildDisplayGroups()
	StartSafetyTimer(Data.SAFETY_PAUSE)
end

ns.SetEventHandler("COMBAT_LOG_EVENT_UNFILTERED", OnCombatLogEvent)
ns.SetEventHandler("UNIT_SPELLCAST_SENT", OnUnitSpellcastSent)
ns.SetEventHandler("UNIT_SPELLCAST_SUCCEEDED", OnUnitSpellcastSucceeded)
ns.SetEventHandler("LOADING_SCREEN_DISABLED", OnLoadingScreenDisabled)
