local _, ns = ...
local Data = ns.Data
local L = ns.L

--[[
    The buff-reaction engine behind the Strangers, Teammates, and Services options
    panels. Watches the combat log, classifies the source, and routes to
    the announcement helpers. Owns its own lookups, caches, cooldowns, and timers;
    its event handlers attach through Core's dispatcher (ns.SetEventHandler), and
    the events themselves are declared in Core's ns.EVENT_NAMES.
]]

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local sessionCooldowns = {}
local isReady = false
local auraLookup = {}
local castLookup = {}
local playerGUID -- cached at login; a character's GUID never changes within a session

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
    namespace so it never collides with the emote/service cooldowns on the same
    GUID. Checks and stamps in one call, and only stamps when a whisper is actually
    cleared to send, so the window is measured from the last whisper we sent.
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
]]
local function BuildLookups()
    local DoesSpellExist = ns.DoesSpellExist
    wipe(auraLookup)
    wipe(castLookup)

    for _, entry in ipairs(Data.TRACKED) do
        local lookup = (entry.detect == Data.DETECT.AURA) and auraLookup or castLookup
        for _, trigger in ipairs(entry.triggers) do
            local watched = WatchedId(entry, trigger)
            -- Drop triggers absent on this client (mirrors BuildDisplayGroups).
            if DoesSpellExist(trigger.spell) or DoesSpellExist(watched) then
                lookup[watched] = {
                    type = entry.type,
                    detect = entry.detect,
                    itemId = trigger.item,
                    opened = entry.opened
                }
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

-- Watched state is keyed by the watched spell id and defaults on for every entry.
-- One shared list backs both the Teammates and Services panels; ids never overlap
-- between them, so a single table is unambiguous.
local function PopulateWatchedBuffs()
    local watched = ns.db.profile.watchedBuffs
    for id in pairs(auraLookup) do
        if watched[id] == nil then
            watched[id] = true
        end
    end
    for id in pairs(castLookup) do
        if watched[id] == nil then
            watched[id] = true
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

    One TRACKED entry becomes exactly one toggle; triggers absent from the running
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
            local name = entry.name or GetSpellName(abilities[1]) or ("Spell " .. abilities[1])

            -- One TRACKED entry == one toggle.
            local toggle = {ids = ids}
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
                d[#d + 1] = {name = name, ids = abilities}
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
        categories[#categories + 1] = {id = class, name = label, entries = classBuckets[class]}
    end

    if #itemEntries > 0 then
        categories[#categories + 1] = {
            id = "ITEMS",
            name = "|cff" .. Data.COLORS.TITLE .. L["COMBAT_GROUP_ITEMS"] .. "|r",
            entries = itemEntries
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

local function ResolveSource(sourceGUID, sourceName, sourceFlags)
    if bit.band(sourceFlags or 0, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
        return sourceGUID, sourceName
    end
    local ownerUnit = GetPetOwnerUnit(sourceGUID)
    if ownerUnit then
        return UnitGUID(ownerUnit), GetUnitName(ownerUnit, true)
    end
    return sourceGUID, sourceName
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
    for _, unit in ipairs({"target", "focus", "mouseover"}) do
        if UnitExists(unit) and UnitGUID(unit) == guid then
            return unit
        end
    end
    return nil
end

--------------------------------------------------------------------------------
-- Buff Handlers
--------------------------------------------------------------------------------

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
    local whisperAllowed = db.whisperEnabled and TryWhisperCooldown(creditGUID)
    ns:AnnounceTracked(entry, creditGUID, creditName, spellID, db.printEnabled, whisperAllowed)

    -- Emotes are visible and social, so they are held back until you leave combat.
    if db.emotesEnabled and not InCombatLockdown() then
        ns:DoRandomEmote(db.emotes, ResolveEmoteUnit(creditGUID))
    end
end

local function HandleStrangersBuff(sourceGUID, sourceName, spellID)
    -- No master on/off switch: the print / whisper / emote toggles are the enable.
    -- With all three off, AnnounceStranger and the emote both no-op, so nothing fires.
    local db = ns.db.profile.strangers
    if not db then
        return
    end

    -- nil means the buff isn't on you; a live buff may still report 0 (no timer).
    local duration = ns.GetBuffDuration("player", spellID)
    if not duration then
        return
    end

    if db.minBuffDuration and db.minBuffDuration > 0 and duration > 0 and duration < db.minBuffDuration then
        return
    end

    local spellLink = ns.GetSpellLink(spellID) or L["UNKNOWN_SPELL"]

    --[[
        Prints, whispers, and emotes are rate-limited differently, on purpose:

        - Prints fire on EVERY qualifying buff. They are self-only, so they always
          reflect the buff that just landed -- in or out of combat.
        - Whispers go to the OTHER player, so they are throttled per-recipient
          (TryWhisperCooldown): a player who rebuffs you repeatedly is thanked at
          most once per window, which also keeps us clear of the whisper squelch.
        - The emote is gated by the per-source cooldown (db.cooldown) so we don't
          visibly emote at the same player over and over, and is held back
          entirely while you are in combat. The cooldown is only spent when an
          emote actually fires, so the next buff after combat reacts right away.
    ]]
    local whisperAllowed = db.whisperEnabled and TryWhisperCooldown(sourceGUID)
    ns:AnnounceStranger(sourceGUID, sourceName, spellLink, db.printEnabled, whisperAllowed)

    if db.emotesEnabled and not InCombatLockdown() and not IsOnCooldown(sourceGUID) then
        ns:DoRandomEmote(db.emotes, ResolveEmoteUnit(sourceGUID))
        SetCooldown(sourceGUID, db.cooldown)
    end
end

--------------------------------------------------------------------------------
-- Event Handlers
--------------------------------------------------------------------------------

local function OnCombatLogEvent()
    if not isReady or not ns.db then
        return
    end

    local _, subEvent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, _, _, _, spellID =
        CombatLogGetCurrentEventInfo()

    local isAura = (subEvent == "SPELL_AURA_APPLIED")
    local isCast = (subEvent == "SPELL_CAST_SUCCESS")
    if not isAura and not isCast then
        return
    end

    -- Diagnostics probe: log raw cast-success events (portals, summons, feasts)
    -- before the guards below drop anything, so even your own test casts and casts
    -- that get filtered out are still visible in the event log. See ns:LogCombatCast.
    if isCast and ns.diagnostics and ns.diagnostics.logging then
        ns:LogCombatCast(spellID, sourceName, sourceFlags, castLookup[spellID] ~= nil, ns.db.profile.watchedBuffs and ns.db.profile.watchedBuffs[spellID])
    end

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
    ]]
    local sourceIsOutsider =
        bit.band(sourceFlags or 0, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 and
        bit.band(sourceFlags or 0, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0 and
        bit.band(sourceFlags or 0, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0

    local maybeStranger = isAura and destGUID == playerGUID and sourceIsOutsider

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
    local sourceIsGroupMember =
        creditGUID ~= playerGUID and (
            bit.band(sourceFlags or 0, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 or
            bit.band(sourceFlags or 0, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0 or
            bit.band(sourceFlags or 0, COMBATLOG_OBJECT_AFFILIATION_RAID) > 0
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

    The per-source "service:" cooldown does double duty: it rate-limits a mage
    opening several portals in a row, and it dedupes the multiple tokens a single
    cast can fire (party1 and target for the same caster resolve to one GUID, so the
    second is already on cooldown).
]]
local function OnUnitSpellcastSucceeded(unitTarget, _, spellID)
    if not isReady or not ns.db then
        return
    end

    local entry = castLookup[spellID]
    if not entry or entry.type ~= Data.BUFF.SERVICE then
        return
    end

    -- Friendly players only, never ourselves.
    if not UnitIsPlayer(unitTarget) or not UnitIsFriend("player", unitTarget) then
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
ns.SetEventHandler("UNIT_SPELLCAST_SUCCEEDED", OnUnitSpellcastSucceeded)
ns.SetEventHandler("LOADING_SCREEN_DISABLED", OnLoadingScreenDisabled)
