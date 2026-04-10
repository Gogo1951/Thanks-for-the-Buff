local addonName, ns = ...
local Data = ns.Data
local L = ns.L

local TFTB = LibStub("AceAddon-3.0"):NewAddon("TFTB", "AceConsole-3.0", "AceEvent-3.0")
ns.TFTB = TFTB

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local sessionCooldowns = {}
local welcomeMessageShown = false
local spellLookup = {}

--------------------------------------------------------------------------------
-- Utility Functions
--------------------------------------------------------------------------------

function TFTB:PrintMsg(msg)
    local prefix = ns.GetColor("BRAND") .. Data.ADDON_TITLE .. "|r "
                .. ns.GetColor("SEP") .. "//" .. "|r "
    DEFAULT_CHAT_FRAME:AddMessage(prefix .. msg)
end

local function IsOnCooldown(guid)
    local now = GetTime()
    local expiresAt = sessionCooldowns[guid]
    return expiresAt and expiresAt > now
end

local function SetCooldown(guid, duration)
    sessionCooldowns[guid] = GetTime() + (duration or 10)
end

function TFTB:StartSafetyTimer(duration)
    self.isReady = false
    C_Timer.After(duration or Data.SAFETY_PAUSE, function()
        self.isReady = true
    end)
end

--------------------------------------------------------------------------------
-- Spell Lookup
--------------------------------------------------------------------------------

function TFTB:BuildSpellLookup()
    wipe(spellLookup)
    if not Data.SPELL_LIST then
        return
    end
    for class, spellGroups in pairs(Data.SPELL_LIST) do
        for _, spellData in ipairs(spellGroups) do
            for _, id in ipairs(spellData.ids) do
                spellLookup[id] = {
                    name     = spellData.name,
                    category = spellData.category or "CLASS",
                    noAura   = spellData.noAura or false
                }
            end
        end
    end
end

--------------------------------------------------------------------------------
-- Auto Macro
--------------------------------------------------------------------------------

function TFTB:CreateAutoMacro()
    if InCombatLockdown() then
        return
    end

    if not self.db or not self.db.profile
        or not self.db.profile.slash or not self.db.profile.slash.createMacro then
        return
    end

    local macroIndex = GetMacroIndexByName(Data.MACRO_NAME)
    if macroIndex == 0 then
        local numGlobal, _ = GetNumMacros()
        if numGlobal < 120 then
            CreateMacro(Data.MACRO_NAME, 134411, "/thankyou", nil)
        end
    end
end

--------------------------------------------------------------------------------
-- Initialization
--------------------------------------------------------------------------------

function TFTB:OnInitialize()
    local currentVersion = C_AddOns.GetAddOnMetadata(addonName, "Version") or "0.0.0"

    self.db = LibStub("AceDB-3.0"):New("TFTB_DB", Data.DEFAULTS, "Default")

    local lastVersion = self.db.profile.lastRunVersion
    if not lastVersion or lastVersion < currentVersion then
        self.db:ResetProfile()
    end

    self.db.profile.lastRunVersion = currentVersion

    if not self.db.profile.groupBuffs then
        self:PrintMsg(L["MSG_DB_ERROR"])
        return
    end

    if ns.SetupOptions then
        ns.SetupOptions()
    end

    self:PopulateWatchedBuffs()
    self:BuildSpellLookup()
end

function TFTB:PopulateWatchedBuffs()
    local watched = self.db.profile.groupBuffs.watchedBuffs
    if not Data.SPELL_LIST then
        return
    end
    for class, spellGroups in pairs(Data.SPELL_LIST) do
        for _, spellData in ipairs(spellGroups) do
            for _, id in ipairs(spellData.ids) do
                if watched[id] == nil then
                    watched[id] = true
                end
            end
        end
    end
end

function TFTB:OnEnable()
    self:StartSafetyTimer(Data.SAFETY_PAUSE)
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("LOADING_SCREEN_DISABLED")
    self:CreateAutoMacro()
end

--------------------------------------------------------------------------------
-- Notifications
--------------------------------------------------------------------------------

local function ColorPlayerName(sourceGUID, sourceName)
    if not sourceGUID then
        return sourceName
    end
    local _, englishClass = GetPlayerInfoByGUID(sourceGUID)
    if englishClass and Data.COLORS[englishClass] then
        return string.format("|cff%s%s|r", Data.COLORS[englishClass], sourceName)
    end
    return sourceName
end

local function SendAppreciation(sourceGUID, sourceName, spellLink, category, messagingType, noAura)
    if messagingType == "PRINT" then
        local coloredName = ColorPlayerName(sourceGUID, sourceName)

        if category == "PARTY_ITEM" then
            TFTB:PrintMsg(string.format(L["MSG_PARTY_ITEM"], coloredName, spellLink))
        elseif noAura then
            TFTB:PrintMsg(string.format(L["MSG_HIT"], coloredName, spellLink))
        else
            TFTB:PrintMsg(string.format(L["MSG_BUFFED"], coloredName, spellLink))
        end
    elseif messagingType == "WHISPER" then
        SendChatMessage(string.format(L["MSG_WHISPER_THANKS"], spellLink), "WHISPER", nil, sourceName)
    end
end

--------------------------------------------------------------------------------
-- Buff Handlers
--------------------------------------------------------------------------------

local function HandleStrangersBuff(sourceGUID, sourceName, spellID)
    local db = TFTB.db.profile.strangers
    if not db or not db.enabled then
        return
    end

    local duration = 0
    local foundAsBuff = false
    for i = 1, 40 do
        local aura = C_UnitAuras.GetAuraDataByIndex("player", i, "HELPFUL")
        if not aura then
            break
        end
        if aura.spellId == spellID then
            foundAsBuff = true
            duration = aura.duration
            break
        end
    end

    if not foundAsBuff then
        return
    end

    if db.minBuffDuration and db.minBuffDuration > 0
        and duration > 0 and duration < db.minBuffDuration then
        return
    end

    local spellLink = GetSpellLink(spellID) or "Unknown Spell"

    SendAppreciation(sourceGUID, sourceName, spellLink, "STRANGER", db.messaging)

    if not IsOnCooldown(sourceGUID) then
        if db.emotesEnabled then
            local availableEmotes = {}
            for emoteCmd, isEnabled in pairs(db.emotes) do
                if isEnabled then
                    table.insert(availableEmotes, emoteCmd)
                end
            end
            if #availableEmotes > 0 then
                DoEmote(availableEmotes[math.random(#availableEmotes)], sourceName)
            end
        end
        SetCooldown(sourceGUID, db.cooldown)
    end
end

local function HandleGroupBuff(sourceGUID, sourceName, spellID, isAuraEvent)
    local db = TFTB.db.profile.groupBuffs
    if not db or not db.watchedBuffs[spellID] then
        return
    end

    local info = spellLookup[spellID]
    if not info then
        return
    end

    -- Aura spells fire on SPELL_AURA_APPLIED only; noAura spells fire on
    -- SPELL_CAST_SUCCESS only. Prevents double-firing.
    if info.noAura and isAuraEvent then
        return
    end
    if not info.noAura and not isAuraEvent then
        return
    end

    local spellLink = GetSpellLink(spellID) or "Unknown Spell"

    SendAppreciation(sourceGUID, sourceName, spellLink, info.category, db.messaging, info.noAura)
    SetCooldown(sourceGUID, 3)
end

--------------------------------------------------------------------------------
-- Event Handling
--------------------------------------------------------------------------------

function TFTB:COMBAT_LOG_EVENT_UNFILTERED()
    if not self.isReady or not self.db then
        return
    end

    local _, subEvent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, _, _, _, spellID =
        CombatLogGetCurrentEventInfo()

    local isAuraEvent = (subEvent == "SPELL_AURA_APPLIED")
    local isCastEvent = (subEvent == "SPELL_CAST_SUCCESS")

    if not isAuraEvent and not isCastEvent then
        return
    end

    if destGUID ~= UnitGUID("player") or sourceGUID == UnitGUID("player") or not sourceName then
        return
    end

    if UnitInParty(sourceName) or UnitInRaid(sourceName) then
        HandleGroupBuff(sourceGUID, sourceName, spellID, isAuraEvent)
    elseif isAuraEvent and not InCombatLockdown()
        and bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0
        and bit.band(sourceFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0 then
        HandleStrangersBuff(sourceGUID, sourceName, spellID)
    end
end

function TFTB:LOADING_SCREEN_DISABLED()
    self:StartSafetyTimer(Data.SAFETY_PAUSE)
end

function TFTB:PLAYER_ENTERING_WORLD()
    self:CreateAutoMacro()

    if self.db and self.db.profile and self.db.profile.global
        and self.db.profile.global.welcomeMessage and not welcomeMessageShown then
        TFTB:PrintMsg(L["MSG_ENABLED"])
        welcomeMessageShown = true
    end
end

--------------------------------------------------------------------------------
-- Slash Commands (/thankyou)
--------------------------------------------------------------------------------

SLASH_THANKYOU1 = "/thankyou"
SlashCmdList.THANKYOU = function(msg)
    if not UnitExists("target") or not UnitIsPlayer("target") then
        TFTB:PrintMsg(L["MSG_SELECT_PLAYER"])
        return
    end
    if UnitIsUnit("target", "player") then
        TFTB:PrintMsg(L["MSG_CANT_THANK_SELF"])
        return
    end

    local db = TFTB.db.profile.slash
    if not db then
        return
    end

    local availableEmotes = {}
    for emoteCmd, isEnabled in pairs(db.emotes) do
        if isEnabled then
            table.insert(availableEmotes, emoteCmd)
        end
    end
    if #availableEmotes > 0 then
        DoEmote(availableEmotes[math.random(#availableEmotes)], "target")
    end

    if UnitFactionGroup("player") == UnitFactionGroup("target")
        and db.message and db.message ~= "" then
        SendChatMessage(db.message, "WHISPER", nil, GetUnitName("target", true))
    end
end