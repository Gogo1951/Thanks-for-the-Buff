local _, ns = ...

--[[
    Wave to Friends: mouse over a character you know and greet them with an
    emote. Who counts, first match wins:

      1. Custom List   -- a name you typed, with its own emote (None = never)
      2. Friends       -- your friends list, Battle.net friends optional
      3. Guilds        -- your own guild, plus any guild names you typed

    Fires only on UPDATE_MOUSEOVER_UNIT with the mouse over the 3D world (a
    character, never a unit frame), never at someone in your party or raid, never
    in combat, only while resting unless you turn that off, and at most once per
    player per cooldown.
]]

--------------------------------------------------------------------------------
-- Cooldowns
--------------------------------------------------------------------------------

--[[
    [guid] = time the cooldown runs out. In memory only; a /reload clears it,
    which is also what ends a Once per Session cooldown (stored as math.huge).
]]
local waveCooldowns = {}

local function IsOnCooldown(guid)
	local expiresAt = waveCooldowns[guid]
	return expiresAt ~= nil and expiresAt > GetTime()
end

local function SetCooldown(guid, duration)
	local now = GetTime()
	-- Sweep lapsed entries so a long session in a capital can't grow the table without bound.
	for key, expiresAt in pairs(waveCooldowns) do
		if expiresAt <= now then
			waveCooldowns[key] = nil
		end
	end
	-- 0 is Once per Session: the entry never lapses, so the sweep above never drops it.
	waveCooldowns[guid] = duration == 0 and math.huge or now + duration
end

--------------------------------------------------------------------------------
-- Names
--------------------------------------------------------------------------------

local function Trim(text)
	return (text or ""):match("^%s*(.-)%s*$")
end

--[[
    Realms compare with their spaces, hyphens and apostrophes dropped: the
    client hands out "AzjolNerub" where a player types "Azjol-Nerub".
]]
local function NormalizeRealm(realm)
	return (realm or ""):gsub("[%s%-']", ""):lower()
end

--[[
    WoW Forever has no realms: a character is "First Last", and UnitName hands
    back the two halves separately (name, surname) where a realm client hands
    back (name, realm). So on Forever a typed name keeps its space, and a
    hyphen is read as that space too.
]]
local REALM_FREE = ns.FLAVOR == "Camelot"

--[[
    The lookup key for a typed name. Realm clients: "katz" for a bare name,
    which matches that name on any realm, or "katz-ashkandi" for Name-Realm,
    which matches only there. WoW Forever: "quanah starhouse" for a full name,
    or "quanah" for a first name, which matches every Quanah. nil for a blank
    entry.
]]
function ns.NormalizeWaveName(text)
	text = Trim(text)
	if text == "" then
		return nil
	end
	if REALM_FREE then
		return Trim((text:gsub("[%s%-]+", " "))):lower()
	end
	local name, realm = text:match("^([^%-]+)%-(.+)$")
	if not name then
		return text:lower()
	end
	name = Trim(name):lower()
	realm = NormalizeRealm(realm)
	if realm == "" then
		return name
	end
	return name .. "-" .. realm
end

-- Guild names keep their inner spaces; only case and runs of spaces are folded.
function ns.NormalizeGuildName(text)
	text = Trim(text):gsub("%s+", " ")
	if text == "" then
		return nil
	end
	return text:lower()
end

--[[
    The unit's short key (first name) and full key: "name-realm" on a realm
    client, "first last" on WoW Forever. Either can be nil.
]]
local function ReadName(getName, unit)
	if not getName then
		return nil
	end
	local name, second = getName(unit)
	if not name or not ns.IsPlain(name) or (second ~= nil and not ns.IsPlain(second)) then
		return nil
	end
	return name, second
end

local function UnitKeys(unit)
	if REALM_FREE then
		--[[
		    UnitNameUnmodified is the call that hands back the surname on WoW
		    Forever (AceDB builds its "First Last" keys from it); UnitName can
		    return the first name alone. Whichever answers with a surname wins.
		]]
		local name, surname = ReadName(UnitNameUnmodified, unit)
		if not surname or surname == "" then
			local fallbackName, fallbackSurname = ReadName(UnitName, unit)
			name = name or fallbackName
			if fallbackSurname and fallbackSurname ~= "" then
				surname = fallbackSurname
			end
		end
		if not name then
			return nil
		end
		local full = name
		if surname and surname ~= "" and not name:find(" ", 1, true) then
			full = name .. " " .. surname
		end
		full = Trim((full:gsub("%s+", " "))):lower()
		-- The first name alone, so an entry typed without the surname still matches.
		return full:match("^(%S+)"), full
	end
	local name, second = ReadName(UnitName, unit)
	if not name then
		return nil
	end
	local bare = name:lower()
	local realm = second
	if not realm or realm == "" then
		realm = GetNormalizedRealmName and GetNormalizedRealmName()
	end
	local full
	if realm and realm ~= "" then
		full = bare .. "-" .. NormalizeRealm(realm)
	end
	return bare, full
end

--------------------------------------------------------------------------------
-- Who Counts
--------------------------------------------------------------------------------

local function IsFriend(guid, settings)
	local isFriend = C_FriendList.IsFriend(guid)
	if ns.IsPlain(isFriend) and isFriend then
		return true
	end
	if settings.bnetFriends then
		local info = C_BattleNet.GetAccountInfoByGUID(guid)
		if type(info) == "table" and ns.IsPlain(info.isFriend) and info.isFriend then
			return true
		end
	end
	return false
end

local function IsWatchedGuild(unit, settings)
	local guildName = GetGuildInfo(unit)
	if not guildName or not ns.IsPlain(guildName) or guildName == "" then
		return false
	end
	local key = ns.NormalizeGuildName(guildName)
	if key and settings.guilds and settings.guilds[key] then
		return true
	end
	if settings.myGuildEnabled then
		local myGuild = GetGuildInfo("player")
		if myGuild and ns.IsPlain(myGuild) and myGuild == guildName then
			return true
		end
	end
	return false
end

--[[
    What to do for this unit: a single token (Custom List), a token set to
    pick from at random (Friends, Guilds), or nothing. A Custom List entry set
    to None returns "" -- a match that stops the lower tiers, so a name on that
    list is never waved at even when they are a friend or guildmate.
]]
local function PickGreeting(unit, guid, settings)
	if settings.customEnabled and settings.players then
		local bare, full = UnitKeys(unit)
		local entry = (full and settings.players[full]) or (bare and settings.players[bare])
		if type(entry) == "table" then
			return entry.emote or "", nil
		end
	end
	if settings.friendsEnabled and IsFriend(guid, settings) then
		return nil, settings.friendEmotes
	end
	if IsWatchedGuild(unit, settings) then
		return nil, settings.guildEmotes
	end
	return nil, nil
end

--------------------------------------------------------------------------------
-- Mouseover
--------------------------------------------------------------------------------

local function OnUpdateMouseoverUnit()
	local settings = ns.db and ns.db.profile.wave
	if not settings or not settings.enabled then
		return
	end
	if settings.restingOnly and not IsResting() then
		return
	end
	if InCombatLockdown() or not ns.IsMouseOverWorld() then
		return
	end

	local unit = "mouseover"
	if ns.IsUnitIdentitySecret(unit) then
		return
	end
	if not UnitExists(unit) or not UnitIsPlayer(unit) or UnitIsUnit(unit, "player") then
		return
	end
	if UnitInParty(unit) or UnitInRaid(unit) then
		return
	end

	local guid = UnitGUID(unit)
	if not guid or not ns.IsPlain(guid) or IsOnCooldown(guid) then
		return
	end

	local token, emotes = PickGreeting(unit, guid, settings)
	if token then
		-- A Custom List match, even one set to None, holds them for the whole cooldown.
		SetCooldown(guid, settings.cooldown)
		ns:DoEmoteToken(token, unit)
	elseif emotes and #ns.GetPickableEmotes(emotes) > 0 then
		SetCooldown(guid, settings.cooldown)
		ns:DoRandomEmote(emotes, unit)
	end
end

ns.SetEventHandler("UPDATE_MOUSEOVER_UNIT", OnUpdateMouseoverUnit)
