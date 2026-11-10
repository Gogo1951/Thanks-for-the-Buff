local _, ns = ...
local Data = ns.Data

local HandleStrangersBuff = ns.HandleStrangersBuff

--[[
    The buff-reaction engine's event side. Watches the combat log (UNIT_AURA on
    Forever) for a helpful buff landing on you from a friendly player outside
    your group, and hands it to Features/Praise.lua. Its event handlers attach
    through Core's dispatcher (ns.SetEventHandler), and the events themselves
    are declared in Core's ns.EVENT_NAMES.
]]

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local isReady = false
local playerGUID -- cached at login; a character's GUID never changes within a session

--------------------------------------------------------------------------------
-- GUID Helpers
--------------------------------------------------------------------------------

--[[
    Is this GUID a player character? The client stamps every GUID with its own
    type -- "Player-<realm>-<hex>" for characters, "Pet-...", "Creature-...",
    "Vehicle-..." for everything else -- which makes this the authoritative test,
    independent of the combat log's TYPE_PLAYER flag. It guards the whisper
    paths: a whisper addressed to a pet bounces back as "No player named 'X' is
    currently playing", so a pet name must never reach SendChatMessage.
]]
local function IsPlayerGUID(guid)
	return type(guid) == "string" and guid:sub(1, 7) == "Player-"
end

--------------------------------------------------------------------------------
-- Safety Timer
--------------------------------------------------------------------------------

--[[
    Suppresses buff reactions until the world settles after login or a loading screen.
    A token invalidates earlier timers: back-to-back loading screens each arm a new
    pause, and only the most recent callback may restore readiness, so a stale timer
    can't flip isReady back on mid-pause.
]]
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
-- Source Resolution
--------------------------------------------------------------------------------

--[[
    An aura's caster can be a pet or guardian (a hunter's Roar of Sacrifice,
    for example). Forever's aura path trades it for its owner, so a group
    member's pet reads as the group member and is left alone -- owners are
    found by matching the pet's GUID to a group pet unit.
]]
local function GetPetOwnerUnit(petGUID)
	if ns.UnitHasGUID("pet", petGUID) then
		return "player"
	end
	for i = 1, 4 do
		if ns.UnitHasGUID("partypet" .. i, petGUID) then
			return "party" .. i
		end
	end
	for i = 1, 40 do
		if ns.UnitHasGUID("raidpet" .. i, petGUID) then
			return "raid" .. i
		end
	end
	return nil
end

--[[
    Is this GUID, or this name, anyone in your group -- a member OR a member's
    pet? A group hunter's pet counts as the hunter: on Forever pets cast real
    buffs on players, and that buff must not reach a stranger thank-you.

    Checked against the whole roster rather than the one unit token the aura
    happened to carry, because that token can be a nameplate, or missing, or
    belong to the pet instead of its owner. The name check backs up the GUID
    check: a caster that only resolves by name (UnitNameFromGUID) still matches
    its roster entry. Names compare with the realm's spaces dropped, so the
    "Name-Realm" we build matches GetUnitName's form, while Forever's realm-free
    "First Last" names keep their space and compare as they are.
]]
local function NormalizeName(name)
	if not name or not ns.IsPlain(name) or name == "" then
		return nil
	end
	local base, realm = name:match("^(.-)%-(.+)$")
	if base then
		return base .. "-" .. realm:gsub("%s", "")
	end
	return name
end

local function UnitMatches(unit, guid, name)
	if not UnitExists(unit) then
		return false
	end
	if guid then
		local unitGUID = UnitGUID(unit)
		if unitGUID and ns.IsPlain(unitGUID) and unitGUID == guid then
			return true
		end
	end
	if name then
		local unitName = NormalizeName(GetUnitName(unit, true))
		if unitName and unitName == name then
			return true
		end
	end
	return false
end

local function IsGroupMemberOrPet(guid, name)
	if guid and not ns.IsPlain(guid) then
		guid = nil
	end
	name = NormalizeName(name)
	if not guid and not name then
		return false
	end
	if UnitMatches("pet", guid, name) then
		return true
	end
	local prefix, petPrefix, count = "party", "partypet", 4
	if IsInRaid() then
		prefix, petPrefix, count = "raid", "raidpet", 40
	end
	for i = 1, count do
		if UnitMatches(prefix .. i, guid, name) or UnitMatches(petPrefix .. i, guid, name) then
			return true
		end
	end
	return false
end

--------------------------------------------------------------------------------
-- Event Handlers
--------------------------------------------------------------------------------

local function OnCombatLogEventUnfiltered()
	if not isReady or not ns.db then
		return
	end

	local _, subEvent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, _, _, _, spellID =
		CombatLogGetCurrentEventInfo()

	--[[
	    REFRESH counts as an aura landing: recasting a buff the target already has
	    emits SPELL_AURA_REFRESH, not APPLIED, and a rebuff earns the same thanks.
	    Ordered cheapest first, so an aura landing on anyone but you stops at a
	    comparison.
	]]
	if subEvent ~= "SPELL_AURA_APPLIED" and subEvent ~= "SPELL_AURA_REFRESH" then
		return
	end
	if destGUID ~= playerGUID then
		return
	end

	--[[
	    Diagnostics probe: log every aura landing on you before the guards below
	    drop anything, so even your own casts and buffs that get filtered out are
	    still visible in the event log. See ns:LogAuraApplied.
	]]
	if ns.diagnostics and ns.diagnostics.logging then
		ns:LogAuraApplied(spellID, sourceName, sourceFlags)
	end

	if not sourceGUID or sourceGUID == playerGUID then
		return
	end

	--[[
	    A stranger buff is a HELPFUL aura that lands on you from a friendly
	    player outside your group. Only the GUID check proves the source is a
	    player (a pet's doesn't, whatever its flags claim); the flags then say
	    whose side they're on, and the affiliation flag recognizes an outsider
	    without a UnitIn* scan. Trap: a name lookup misses cross-realm sources,
	    whose combat-log name is "Name-Realm", which is why affiliation decides.
	    A pet that buffs you is never credited: its name is not a player's, so
	    the whisper would bounce.
	]]
	if not IsPlayerGUID(sourceGUID) or not sourceName then
		return
	end
	if bit.band(sourceFlags or 0, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0 then
		return
	end
	if bit.band(sourceFlags or 0, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) == 0 then
		return
	end
	-- Backstop for the affiliation flag: a group member is never a stranger.
	if IsGroupMemberOrPet(sourceGUID, sourceName) then
		return
	end

	HandleStrangersBuff(sourceGUID, sourceName, spellID)
end

--[[
    Who to credit for an aura on you, as creditGUID, creditName, the unit token
    we hold for them (nil for a stranger we can only name), and the raw caster's
    GUID (the pet's own, when a pet cast it): a player or nobody,
    with a pet traded for its owner so a group member's pet still reads as the
    group member and is left alone.

    The aura's sourceUnit is the first choice: a group token for a teammate, a
    nameplate token for a stranger. A stranger without a nameplate leaves it nil,
    so the caster is then read from the aura itself by GUID and named with
    UnitNameFromGUID -- no unit token needed. That GUID may still belong to a
    teammate whose token the aura didn't carry, so the group is checked first.
]]
local function ResolveAuraCaster(aura)
	local sourceUnit = aura.sourceUnit
	local creditUnit, casterGUID
	if sourceUnit then
		if not ns.IsPlain(sourceUnit) then
			return nil
		end
		local sourceGUID = UnitGUID(sourceUnit)
		if not sourceGUID or not ns.IsPlain(sourceGUID) then
			return nil
		end
		casterGUID = sourceGUID
		creditUnit = IsPlayerGUID(sourceGUID) and sourceUnit or GetPetOwnerUnit(sourceGUID)
	else
		local instanceID = aura.auraInstanceID
		if not instanceID or not ns.IsPlain(instanceID) then
			return nil
		end
		local ok
		ok, casterGUID = pcall(C_UnitAuras.GetAuraCasterGUID, "player", instanceID)
		if not ok or not casterGUID or not ns.IsPlain(casterGUID) then
			return nil
		end
		local isPlayer = IsPlayerGUID(casterGUID)
		creditUnit = isPlayer and ns.GetUnitByGUID(casterGUID) or GetPetOwnerUnit(casterGUID)
		if not creditUnit then
			if not isPlayer then
				return nil
			end
			-- A stranger out of nameplate range: name them from the GUID alone.
			local name, realm = UnitNameFromGUID(casterGUID)
			if not name or not ns.IsPlain(name) or name == "" then
				return nil
			end
			-- Whispers need "Name-Realm" across realms, and a realm name has no spaces there.
			if realm and ns.IsPlain(realm) and realm ~= "" then
				name = name .. "-" .. realm:gsub("%s", "")
			end
			return casterGUID, name, nil, casterGUID
		end
	end

	local creditGUID = creditUnit and UnitGUID(creditUnit)
	local creditName = creditUnit and GetUnitName(creditUnit, true)
	if not (creditGUID and creditName and ns.IsPlain(creditGUID) and ns.IsPlain(creditName)) then
		return nil
	end
	return creditGUID, creditName, creditUnit, casterGUID
end

--[[
    Forever has no combat log, so buffs on you are read from UNIT_AURA instead.
    Nothing is read while C_Secrets reports auras secret or while you are in
    combat, so a buff that lands then is skipped, never queued. Only newly added auras count; a recast of a buff you already have is
    not seen.
]]
local function HandleAddedAura(aura)
	local spellID = aura.spellId
	if not (ns.IsPlain(spellID) and ns.IsPlain(aura.isHelpful)) then
		return
	end
	if not aura.isHelpful then
		return
	end

	local creditGUID, creditName, creditUnit, casterGUID = ResolveAuraCaster(aura)
	if not creditGUID or creditGUID == playerGUID then
		return
	end

	--[[
	    A group member is not a stranger, and neither is their pet. Both the
	    credited player and the raw caster are checked against the whole roster,
	    so a buff from a group hunter's pet is left alone however the aura named
	    its caster.
	]]
	if creditUnit and (UnitInParty(creditUnit) or UnitInRaid(creditUnit)) then
		return
	end
	if IsGroupMemberOrPet(creditGUID, creditName) or IsGroupMemberOrPet(casterGUID) then
		return
	end
	if IsPlayerGUID(creditGUID) then
		--[[
		    Only a unit can be asked whether it's friendly. A player we know by GUID
		    alone just put a helpful buff on you, which the other faction can't do.
		]]
		if creditUnit then
			local isFriend = UnitIsFriend("player", creditUnit)
			if not (ns.IsPlain(isFriend) and isFriend) then
				return
			end
		end
		HandleStrangersBuff(creditGUID, creditName, spellID)
	end
end

--[[
    Diagnostics probe for Forever's UNIT_AURA, which the event log excludes
    because its update table can't be written as text. Names the first gate in
    OnUnitAura that stops this update, then logs a full update once, or each
    added helpful aura (and any whose helpfulness is secret), before any gate
    runs. A secret value is checked with ns.IsPlain before it is tested. See
    ns:LogAuraUpdate.
]]
local function LogAuraUpdate(updateInfo)
	if not ns.IsPlain(updateInfo) or not updateInfo then
		return
	end
	local verdict
	if not isReady then
		verdict = "not ready"
	elseif not ns.db then
		verdict = "no db"
	elseif InCombatLockdown() then
		verdict = "in combat"
	elseif ns.AreAurasSecret() then
		verdict = "auras secret"
	end

	local isFullUpdate = updateInfo.isFullUpdate
	if not ns.IsPlain(isFullUpdate) or isFullUpdate then
		ns:LogAuraUpdate(verdict or "full update", nil)
		return
	end
	local added = updateInfo.addedAuras
	if not ns.IsPlain(added) or not added then
		return
	end
	for _, aura in ipairs(added) do
		local helpful = ns.IsPlain(aura) and aura.isHelpful
		if not ns.IsPlain(aura) or not ns.IsPlain(helpful) or helpful then
			ns:LogAuraUpdate(verdict or "read", aura)
		end
	end
end

--[[
    Core registers UNIT_AURA on Forever only, and for the player only: it is
    Forever's buff detection, which only ever cares about auras on you.
]]
local function OnUnitAura(unit, updateInfo)
	if not ns.IsPlain(unit) or unit ~= "player" then
		return
	end
	if ns.diagnostics and ns.diagnostics.logging then
		LogAuraUpdate(updateInfo)
	end
	if not isReady or not ns.db or InCombatLockdown() or ns.AreAurasSecret() then
		return
	end
	if not updateInfo or not ns.IsPlain(updateInfo.isFullUpdate) or updateInfo.isFullUpdate then
		return
	end
	local added = updateInfo.addedAuras
	if not added or not ns.IsPlain(added) then
		return
	end

	for _, aura in ipairs(added) do
		HandleAddedAura(aura)
	end
end

local function OnLoadingScreenDisabled()
	StartSafetyTimer(Data.SAFETY_PAUSE)
end

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

-- Diagnostics reads these.
function ns.IsBuffTrackingReady()
	return isReady
end

function ns.IsBuffTrackingSetUp()
	return playerGUID ~= nil
end

--[[
    Run once from Core's login sequence, after the saved variables are live:
    caches your GUID and arms the safety timer.
]]
function ns.SetupBuffTracking()
	playerGUID = UnitGUID("player")
	StartSafetyTimer(Data.SAFETY_PAUSE)
end

ns.SetEventHandler("COMBAT_LOG_EVENT_UNFILTERED", OnCombatLogEventUnfiltered)
ns.SetEventHandler("UNIT_AURA", OnUnitAura)
ns.SetEventHandler("LOADING_SCREEN_DISABLED", OnLoadingScreenDisabled)
