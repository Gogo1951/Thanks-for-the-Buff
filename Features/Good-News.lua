local _, ns = ...
local Data = ns.Data

local DETECT = Data.GOOD_NEWS_DETECT

--------------------------------------------------------------------------------
-- Good News
--------------------------------------------------------------------------------

--[[
    A whisper telling a player what you just cast on them: "Good News! You
    have [Power Infusion] for 15 Seconds // TFTB". Only abilities
    ticked on the Tracked Abilities panel count, from Data/<Flavor>/Good-News-Abilities-<Flavor>.lua.

    Driven by your own UNIT_SPELLCAST_SENT and UNIT_SPELLCAST_SUCCEEDED, never
    by the combat log, which is what lets it run on WoW Forever: add-ons can't
    register Forever's combat log at all. SENT is the only event that names who
    you cast at; SUCCEEDED confirms the cast went off, so an interrupted one
    stays silent.

    WoW Forever hides unit identity and auras in combat (C_Secrets). A cast at
    a player whose identity is hidden can't be matched to anyone, so it sends
    nothing; one whose auras are hidden still sends, without the duration.
]]

--------------------------------------------------------------------------------
-- Ability Lookup
--------------------------------------------------------------------------------

--[[
    Built once, at login (ns.SetupGoodNews). castLookup is keyed by
    the CAST id, which is what the spellcast events carry; that differs from the
    aura id for a row like Misdirection, so each record also carries the ids the
    checkbox is saved under (watchedIds) and the aura to read the duration from
    (auraId). Rows reads the same data for the Tracked Abilities panel.

    Every item a row names is requested here, so the client has its name by
    the time the panel labels a scroll with it rather than with its spell.

    A RESURRECT row needs the combat log to confirm the revive, so it is left out
    on WoW Forever, where that never arrives. Its data lists none anyway.
]]
local castLookup, rows

local function WatchedId(row, trigger)
	if row.detect == DETECT.AURA then
		return trigger.aura or trigger.spell
	end
	return trigger.spell
end

local function RequestItem(itemId)
	if itemId and not C_Item.GetItemNameByID(itemId) then
		C_Item.RequestLoadItemDataByID(itemId)
	end
end

local function BuildLookup()
	castLookup, rows = {}, {}
	local DoesSpellExist = C_Spell.DoesSpellExist
	for _, row in ipairs(ns.GOOD_NEWS_ABILITIES or {}) do
		RequestItem(row.labelItem)
		local usable = not (row.detect == DETECT.RESURRECT and ns.FLAVOR == "Camelot")
		local info = { row = row, watchedIds = {}, spellIds = {}, itemIds = {} }
		for _, trigger in ipairs(usable and row.triggers or {}) do
			local watched = WatchedId(row, trigger)
			-- A rank or variant this client lacks is dropped; a row with none left is skipped.
			if DoesSpellExist(trigger.spell) or DoesSpellExist(watched) then
				info.watchedIds[#info.watchedIds + 1] = watched
				info.spellIds[#info.spellIds + 1] = trigger.spell
				if trigger.item then
					info.itemIds[#info.itemIds + 1] = trigger.item
					RequestItem(trigger.item)
				end
				castLookup[trigger.spell] = {
					info = info,
					watchedId = watched,
					itemId = trigger.item,
					--[[
					    Nothing to read for a cast that leaves no aura, or for a
					    buff spent by an event rather than by time (noDuration):
					    no auraId is what leaves the duration out of the whisper.
					]]
					auraId = (row.detect == DETECT.AURA and not row.noDuration) and watched or nil,
				}
			end
		end
		if #info.watchedIds > 0 then
			rows[#rows + 1] = info
		end
	end
end

-- Run once from Core's login sequence.
function ns.SetupGoodNews()
	if not castLookup then
		BuildLookup()
	end
end

-- Every row this client can cast, for the Tracked Abilities panel.
function ns.GetGoodNewsRows()
	if not rows then
		BuildLookup()
	end
	return rows
end

local function GetCastRecord(spellID)
	if not castLookup then
		BuildLookup()
	end
	return castLookup[spellID]
end

-- A row with no saved choice is ticked.
function ns.IsGoodNewsWatched(watchedId)
	return ns.db.profile.goodNews.watched[watchedId] ~= false
end

--------------------------------------------------------------------------------
-- Recipient
--------------------------------------------------------------------------------

--[[
    UNIT_SPELLCAST_SENT names who you cast at, but gives neither unit nor GUID.
    The name is mapped back to a unit we hold, which is what proves the
    recipient is a player (a whisper to a pet bounces) and lets the buff's
    length be read off them afterwards. Checked in the order people cast: at
    the target, through a mouseover or focus macro, then a group member.

    A unit whose identity is secret (WoW Forever, in combat) is skipped, since
    its name can't be compared. WoW Forever names are "First Last" with no
    realm, which Ambiguate leaves as they are.
]]
local CAST_AT_UNITS = { "target", "mouseover", "focus" }

local function ResolveUnitByName(name)
	local short = Ambiguate(name, "short")
	local function Matches(unit)
		if not UnitExists(unit) or ns.IsUnitIdentitySecret(unit) then
			return false
		end
		local unitName = GetUnitName(unit, true)
		if not unitName or not ns.IsPlain(unitName) then
			return false
		end
		return unitName == name or Ambiguate(unitName, "short") == short
	end

	for _, unit in ipairs(CAST_AT_UNITS) do
		if Matches(unit) then
			return unit
		end
	end
	local prefix, count = "party", 4
	if IsInRaid() then
		prefix, count = "raid", 40
	end
	for i = 1, count do
		local unit = prefix .. i
		if Matches(unit) then
			return unit
		end
	end
	return nil
end

-- Your party or raid; a battleground is a raid. A secret answer counts as no, the side that whispers fewer people.
local function IsGroupMember(unit)
	local inParty, inRaid = UnitInParty(unit), UnitInRaid(unit)
	if ns.IsPlain(inParty) and inParty then
		return true
	end
	return ns.IsPlain(inRaid) and inRaid ~= nil
end

--------------------------------------------------------------------------------
-- Pending Casts
--------------------------------------------------------------------------------

local pending = {} -- castGUID -> the recipient captured at UNIT_SPELLCAST_SENT
local recent = {} -- "guid:spellID" -> when we last whispered them about it

local PENDING_TTL = 15 -- a SENT whose SUCCEEDED never comes (the cast was interrupted)
local REPEAT_GAP = 10 -- a quick recast on the same player doesn't whisper twice
local AURA_SETTLE = 0.1 -- the aura lands a moment after the cast succeeds

local function Sweep()
	local now = GetTime()
	for castGUID, cast in pairs(pending) do
		if cast.at < now - PENDING_TTL then
			pending[castGUID] = nil
		end
	end
	for key, at in pairs(recent) do
		if at < now - REPEAT_GAP then
			recent[key] = nil
		end
	end
end

-- The link the whisper names: the item for an item row (a scroll, a soulstone), else the spell.
local function AbilityLink(record, spellID)
	if record.itemId then
		local _, itemLink = C_Item.GetItemInfo(record.itemId)
		if itemLink then
			return itemLink
		end
	end
	return ns.GetBuffLink(spellID)
end

local function Announce(cast)
	local key = cast.guid .. ":" .. cast.spellID
	if recent[key] then
		return
	end
	recent[key] = GetTime()

	--[[
	    The aura lands a beat after the cast succeeds, so it is read a tick later,
	    off a unit that still holds the recipient's GUID: they may have been
	    untargeted meanwhile. A secret aura, a secret duration and a cast with no
	    aura all send the whisper without a duration.
	]]
	C_Timer.After(AURA_SETTLE, function()
		local seconds
		if cast.auraId and not ns.AreAurasSecret() and not ns.IsUnitIdentitySecret(cast.unit) then
			if ns.UnitHasGUID(cast.unit, cast.guid) then
				local ok, duration = pcall(ns.GetBuffDuration, cast.unit, cast.auraId)
				if ok and ns.IsPlain(duration) and type(duration) == "number" then
					seconds = duration
				end
			end
		end
		ns:WhisperGoodNews(cast.name, cast.link, seconds)
	end)
end

--[[
    Your cast, or your pet's: Battle Squawk is cast by the Battle Chicken, never
    by you, and crediting its owner is the point. Core registers these events
    for "player" and "pet" only, and "pet" means yours, so nobody else's casts
    reach here.
]]
local function OnUnitSpellcastSent(_, target, castGUID, spellID)
	if not ns.db or not ns.IsBuffTrackingReady() then
		return
	end
	local settings = ns.db.profile.goodNews
	if not settings.enabled then
		return
	end
	-- On WoW Forever a recipient whose identity is secret arrives as a secret name, which can't be compared.
	if not (ns.IsPlain(target) and ns.IsPlain(castGUID) and ns.IsPlain(spellID)) then
		return
	end
	if not target or target == "" or not castGUID then
		return
	end

	local record = GetCastRecord(spellID)
	if not record or not ns.IsGoodNewsWatched(record.watchedId) then
		return
	end

	--[[
	    Players only, never yourself. A name we can't match to a unit is dropped
	    rather than guessed at: nothing proves it isn't a pet.
	]]
	local unit = ResolveUnitByName(target)
	local guid = unit and UnitGUID(unit)
	if not guid or not ns.IsPlain(guid) or guid:sub(1, 7) ~= "Player-" or ns.UnitHasGUID("player", guid) then
		return
	end
	local fullName = GetUnitName(unit, true)
	if not fullName or not ns.IsPlain(fullName) or fullName == "" then
		return
	end

	-- Anything but ALWAYS means group members only, so a stale saved value whispers fewer people, not more.
	if settings.scope ~= "ALWAYS" and not IsGroupMember(unit) then
		return
	end

	Sweep()
	pending[castGUID] = {
		name = fullName,
		guid = guid,
		unit = unit,
		spellID = spellID,
		auraId = record.auraId,
		resurrect = record.info.row.detect == DETECT.RESURRECT,
		link = AbilityLink(record, spellID),
		at = GetTime(),
	}
end

--[[
    The cast went off. A RESURRECT cast stays parked: Jumper Cables succeed
    whether or not the target gets up, so the whisper waits for
    ns.ClaimGoodNewsResurrect, and Sweep discards it if no revive comes.
]]
local function OnUnitSpellcastSucceeded(_, castGUID)
	if not ns.IsPlain(castGUID) or not castGUID then
		return
	end
	local cast = pending[castGUID]
	if cast and not cast.resurrect then
		pending[castGUID] = nil
		Announce(cast)
	end
end

--[[
    Buff-Tracking calls this for a SPELL_RESURRECT of yours, which only a
    working jolt produces. Matched on recipient and spell, since the combat log
    carries no castGUID. Swept first, so a failed jolt's stale record can't be
    claimed by a later revive of the same player. Never called on WoW Forever.
]]
function ns.ClaimGoodNewsResurrect(destGUID, spellID)
	if not destGUID then
		return
	end
	Sweep()
	for castGUID, cast in pairs(pending) do
		if cast.resurrect and cast.guid == destGUID and cast.spellID == spellID then
			pending[castGUID] = nil
			Announce(cast)
			return
		end
	end
end

ns.SetEventHandler("UNIT_SPELLCAST_SENT", OnUnitSpellcastSent)
ns.SetEventHandler("UNIT_SPELLCAST_SUCCEEDED", OnUnitSpellcastSucceeded)
