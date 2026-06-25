local _, ns = ...
local Data = ns.Data
local L = ns.L

--[[
    The buff-reaction engine behind the Strangers, Teammates, and Services options
    panels. Watches the combat log, classifies the source, and routes to
    the announcement helpers. Owns its own lookups, caches, cooldowns, and timers;
    its event handlers register through Core's dispatcher (ns.RegisterEvent).
]]

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local sessionCooldowns = {}
local isReady = false
local auraLookup = {}
local castLookup = {}

--------------------------------------------------------------------------------
-- Cooldowns
--------------------------------------------------------------------------------

local function IsOnCooldown(guid)
    local now = GetTime()
    local expiresAt = sessionCooldowns[guid]
    return expiresAt and expiresAt > now
end

local function SetCooldown(guid, duration)
    sessionCooldowns[guid] = GetTime() + (duration or 10)
end

--------------------------------------------------------------------------------
-- Safety Timer
--------------------------------------------------------------------------------

-- Suppresses buff reactions until the world settles after login or a loading screen.
local function StartSafetyTimer(duration)
    isReady = false
    C_Timer.After(duration or Data.SAFETY_PAUSE, function()
        isReady = true
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
                    itemId = trigger.item
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
    local watched = ns.db.watchedBuffs
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
                GetItemInfo(trigger.item)
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

--------------------------------------------------------------------------------
-- Buff Handlers
--------------------------------------------------------------------------------

--[[
    Group/raid reactions are intentionally NOT rate-limited: each cast is a
    distinct cooldown a teammate spent, so we acknowledge every one.
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

    if not ns.db.watchedBuffs[spellID] then
        return
    end

    -- No-aura raid help reacts with the Group Services settings; everything cast
    -- on you (SOLO / GROUP) uses the Buffs from Teammates settings.
    local db = (entry.type == Data.BUFF.SERVICE) and ns.db.services or ns.db.teammates
    ns:AnnounceTracked(entry, creditGUID, creditName, spellID, db.printEnabled, db.whisperEnabled)

    -- Emotes are visible and social, so they are held back until you leave combat.
    if db.emotesEnabled and not InCombatLockdown() then
        ns:DoRandomEmote(db.emotes, creditName)
    end
end

local function HandleStrangersBuff(sourceGUID, sourceName, spellID)
    -- No master on/off switch: the print / whisper / emote toggles are the enable.
    -- With all three off, AnnounceStranger and the emote both no-op, so nothing fires.
    local db = ns.db.strangers
    if not db then
        return
    end

    local duration = 0
    local foundAsBuff = false
    for i = 1, 40 do
        local name, _, _, _, auraDuration, _, _, _, _, auraSpellId = UnitAura("player", i, "HELPFUL")
        if not name then
            break
        end
        if auraSpellId == spellID then
            foundAsBuff = true
            duration = auraDuration
            break
        end
    end

    if not foundAsBuff then
        return
    end

    if db.minBuffDuration and db.minBuffDuration > 0 and duration > 0 and duration < db.minBuffDuration then
        return
    end

    local spellLink = GetSpellLink(spellID) or L["UNKNOWN_SPELL"]

    --[[
        Messages and emotes are rate-limited differently, on purpose:

        - Messages fire on EVERY qualifying buff, ignoring the per-source
          cooldown. Print-outs are self-only and whispers go to the buffer, so
          they always reflect the buff that just landed -- in or out of combat.
        - The emote is gated by the per-source cooldown (db.cooldown) so we don't
          visibly emote at the same player over and over, and is held back
          entirely while you are in combat. The cooldown is only spent when an
          emote actually fires, so the next buff after combat reacts right away.
    ]]
    ns:AnnounceStranger(sourceGUID, sourceName, spellLink, db.printEnabled, db.whisperEnabled)

    if db.emotesEnabled and not InCombatLockdown() and not IsOnCooldown(sourceGUID) then
        ns:DoRandomEmote(db.emotes, sourceName)
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

    local playerGUID = UnitGUID("player")
    if not sourceGUID or sourceGUID == playerGUID then
        return
    end

    local entry = (isAura and auraLookup[spellID]) or (isCast and castLookup[spellID])

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
    local maybeStranger =
        isAura and destGUID == playerGUID and
        bit.band(sourceFlags or 0, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 and
        bit.band(sourceFlags or 0, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0 and
        bit.band(sourceFlags or 0, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0

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
    BuildLookups()
    PopulateWatchedBuffs()
    WarmItemCache()
    BuildDisplayGroups()
    StartSafetyTimer(Data.SAFETY_PAUSE)
end

ns.RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", OnCombatLogEvent)
ns.RegisterEvent("LOADING_SCREEN_DISABLED", OnLoadingScreenDisabled)
