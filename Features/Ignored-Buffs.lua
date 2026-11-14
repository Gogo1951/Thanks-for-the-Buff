local _, ns = ...

--------------------------------------------------------------------------------
-- Ignored Buffs
--------------------------------------------------------------------------------

--[[
    Two kinds of list, built to the shape of Magic Eraser's Erase List: an
    account-wide All Characters list in global, and each character's own list
    in char, AceDB's per-character scope, so it stays with the character
    whatever profile is active. Membership is additive: a buff on either list
    the character being played can see is never thanked.

    Every list is [spellId] = true and is looked up by the scope key the panel
    uses: ns.LIST_SCOPE_GLOBAL, the character being played (ns.db.keys.char),
    or any other character on the account. The character being played resolves
    through ns.db.char, so an edit lands on the very table the praise check
    reads. Every other character is read straight out of ns.db.sv.char, since
    AceDB only materializes the character you are on and strips empty tables at
    logout; a read returns nil there, and a write passes createIfMissing.
]]
local IGNORED_BUFFS_KEY = "ignoredBuffs"

local function GetOrCreateList(scope)
	local list = scope[IGNORED_BUFFS_KEY]
	if type(list) ~= "table" then
		list = {}
		scope[IGNORED_BUFFS_KEY] = list
	end
	return list
end

function ns.GetIgnoredBuffsForScope(scopeKey, createIfMissing)
	if not (ns.db and scopeKey) then
		return nil
	end
	if scopeKey == ns.LIST_SCOPE_GLOBAL then
		return GetOrCreateList(ns.db.global)
	end
	if scopeKey == ns.db.keys.char then
		return GetOrCreateList(ns.db.char)
	end

	local characters = ns.db.sv and ns.db.sv.char
	if type(characters) ~= "table" then
		return nil
	end
	local charData = characters[scopeKey]
	if type(charData) ~= "table" then
		if not createIfMissing then
			return nil
		end
		charData = {}
		characters[scopeKey] = charData
	end
	if type(charData[IGNORED_BUFFS_KEY]) ~= "table" and not createIfMissing then
		return nil
	end
	return GetOrCreateList(charData)
end

--[[
    Add or remove one buff in one scope. A buff joining All Characters comes off
    every character's own list, since All Characters already covers everyone: a
    per-character row could no longer change anything and would only clutter
    that character's pane. Removing from All Characters puts it back on no one,
    since there is no record of who held it.
]]
function ns.SetBuffIgnoredInScope(scopeKey, spellId, isIgnored)
	if not spellId then
		return
	end
	local list = ns.GetIgnoredBuffsForScope(scopeKey, isIgnored and true or false)
	if not list then
		return
	end
	list[spellId] = isIgnored and true or nil

	if isIgnored and scopeKey == ns.LIST_SCOPE_GLOBAL then
		for _, charData in pairs((ns.db.sv and ns.db.sv.char) or {}) do
			if type(charData) == "table" and type(charData[IGNORED_BUFFS_KEY]) == "table" then
				charData[IGNORED_BUFFS_KEY][spellId] = nil
			end
		end
		-- The live ns.db.char is the same table as its sv.char entry once AceDB has materialized it.
		GetOrCreateList(ns.db.char)[spellId] = nil
	end
end

-- True when All Characters or this character's own list carries the buff.
function ns.IsBuffIgnored(spellId)
	if not (ns.db and spellId) then
		return false
	end
	local globalList = ns.db.global[IGNORED_BUFFS_KEY]
	if type(globalList) == "table" and globalList[spellId] then
		return true
	end
	local charList = ns.db.char[IGNORED_BUFFS_KEY]
	return (type(charList) == "table" and charList[spellId]) and true or false
end

--[[
    Every character on the account that has per-character data, plus the one
    being played, as AceDB char keys sorted as plain strings. Characters live in
    the char scope, not in profiles: every character shares the Default profile,
    so profile names say nothing about who has a list.
]]
function ns.GetCharacterKeys()
	local keys, seen = {}, {}
	local current = ns.db and ns.db.keys and ns.db.keys.char
	if current then
		keys[1] = current
		seen[current] = true
	end
	for charKey in pairs((ns.db and ns.db.sv and ns.db.sv.char) or {}) do
		if type(charKey) == "string" and not seen[charKey] then
			seen[charKey] = true
			keys[#keys + 1] = charKey
		end
	end
	table.sort(keys)
	return keys
end

--[[
    A character key in its class color. The character being played answers from
    UnitClass; any other one from the classToken it saved at its last login. One
    that hasn't logged in since that was recorded keeps the default color.
]]
function ns.GetCharacterDisplayName(charKey)
	local classToken
	if ns.db and charKey == ns.db.keys.char then
		local _, token = UnitClass("player")
		classToken = token
	else
		local charData = ns.db and ns.db.sv and ns.db.sv.char and ns.db.sv.char[charKey]
		classToken = type(charData) == "table" and charData.classToken or nil
	end
	local hex = classToken and ns.Data.CLASS_COLORS[classToken]
	if not hex then
		return charKey
	end
	return "|cff" .. hex .. charKey .. "|r"
end

--------------------------------------------------------------------------------
-- Current Buffs
--------------------------------------------------------------------------------

-- The spell IDs of every helpful aura on you right now, for the Ignored Buffs picker.
function ns.GetPlayerBuffIds()
	local ids = {}
	-- An aura read throws while auras are secret (WoW Forever in combat), so the picker lists nothing then.
	if ns.AreAurasSecret() then
		return ids
	end
	for i = 1, 40 do
		local data = C_UnitAuras.GetBuffDataByIndex("player", i, "HELPFUL")
		if not data then
			break
		end
		if ns.IsPlain(data.spellId) then
			ids[#ids + 1] = data.spellId
		end
	end
	return ids
end

--------------------------------------------------------------------------------
-- Recent Buffs
--------------------------------------------------------------------------------

--[[
    The buffs strangers gave you since you logged in, so the Ignored Buffs
    picker can still offer one after it wears off: you usually decide to ignore
    a buff right after its thank-you, by when a short one is gone. Kept in
    memory only, newest first, one entry per spell (the latest caster wins),
    capped at RECENT_BUFFS_MAX.
]]
local RECENT_BUFFS_MAX = 20
local recentBuffs = {}

function ns.RecordRecentBuff(sourceGUID, sourceName, spellId)
	if not (ns.IsPlain(sourceGUID) and ns.IsPlain(sourceName) and ns.IsPlain(spellId)) then
		return
	end
	if not (sourceGUID and sourceName and sourceName ~= "" and spellId) then
		return
	end
	for i = #recentBuffs, 1, -1 do
		if recentBuffs[i].spellId == spellId then
			table.remove(recentBuffs, i)
		end
	end
	local _, classToken = GetPlayerInfoByGUID(sourceGUID)
	table.insert(recentBuffs, 1, {
		spellId = spellId,
		name = Ambiguate(sourceName, "short"),
		classToken = ns.IsPlain(classToken) and classToken or nil,
	})
	recentBuffs[RECENT_BUFFS_MAX + 1] = nil
end

-- Newest first: { spellId, name, classToken }.
function ns.GetRecentBuffs()
	return recentBuffs
end
