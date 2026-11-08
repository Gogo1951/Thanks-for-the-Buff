local ADDON_NAME, ns = ...

--------------------------------------------------------------------------------
-- Color Accessor
--------------------------------------------------------------------------------

-- Derived from the raw hex palette in Data.lua; |cff prefixed for point-of-use.
local COLOR_PREFIX = "|cff"

local COLORS = {}
for key, hex in pairs(ns.PALETTE) do
	COLORS[key] = COLOR_PREFIX .. hex
end

function ns.GetColor(key)
	return COLORS[key] or COLORS.TEXT
end

--------------------------------------------------------------------------------
-- Client Emote Catalog
--------------------------------------------------------------------------------

--[[
    Every emote the RUNNING client can perform, read from its own EMOTE<n>_TOKEN
    and EMOTE<n>_CMD<n> globals rather than from a list kept in this add-on.

    Deliberately not a data file. The set differs per expansion, so a
    hand-maintained copy would be correct on exactly one client and quietly wrong
    on the others -- and it is a long list to get wrong. Reading the client means
    a dropdown built from this offers precisely what this build can perform, and
    Diagnostics can export the same list from any flavor without a code change.

    Two traps the scan has to respect. Indices are SPARSE (Era jumps 171 -> 304),
    so it cannot stop at the first gap. And a few tokens appear twice under
    different indices (INCOMING, FLEE), so tokens are deduped -- the dropdown
    should not offer the same emote twice.

    Sorted by the slash command players recognize, not by token or index. Built
    once on demand; these globals do not change during a session.
]]
local EMOTE_SCAN_CEILING = 1000 -- backstop only, for a client without MAXEMOTEINDEX

-- Placeholders the client lists among its emotes that do nothing worth picking.
local SKIPPED_EMOTE_TOKENS = {
	UNUSED = true,
}

local emoteCatalog, emoteTokens

local function BuildEmoteCatalog()
	emoteCatalog, emoteTokens = {}, {}

	--[[
	    The client's own list of emotes that play a voice line. Absent on some
	    builds, in which case the voice column simply reads unknown.
	]]
	local voice = {}
	if type(TextEmoteSpeechList) == "table" then
		for _, entry in pairs(TextEmoteSpeechList) do
			voice[tostring(entry)] = true
		end
	end

	for index = 1, (MAXEMOTEINDEX or EMOTE_SCAN_CEILING) do
		local token = _G["EMOTE" .. index .. "_TOKEN"]
		if token and not emoteTokens[token] and not SKIPPED_EMOTE_TOKENS[token] then
			--[[
			    CMD1 is the primary; the rest are aliases, and the client repeats the
			    whole set once per locale, so exact repeats are dropped.
			]]
			local aliases, seen = {}, {}
			for c = 1, 8 do
				local command = _G["EMOTE" .. index .. "_CMD" .. c]
				if command and command ~= "" and not seen[command] then
					seen[command] = true
					aliases[#aliases + 1] = command
				end
			end
			local entry = {
				index = index,
				token = token,
				command = aliases[1] or ("/" .. token:lower()),
				aliases = table.concat(aliases, " "),
				voice = voice[token] == true,
			}
			emoteTokens[token] = entry
			emoteCatalog[#emoteCatalog + 1] = entry
		end
	end

	-- Case-insensitive, so a locale that capitalizes some commands still reads A to Z.
	table.sort(emoteCatalog, function(a, b)
		return a.command:lower() < b.command:lower()
	end)
end

-- Every client emote, sorted by slash command.
function ns.GetEmoteCatalog()
	if not emoteCatalog then
		BuildEmoteCatalog()
	end
	return emoteCatalog
end

-- Is this token something the running client can actually perform?
function ns.IsClientEmote(token)
	if not emoteTokens then
		BuildEmoteCatalog()
	end
	return token ~= nil and emoteTokens[token] ~= nil
end

-- The slash command this client gives an emote token, in its own language.
function ns.GetEmoteCommand(token)
	if not emoteTokens then
		BuildEmoteCatalog()
	end
	local entry = emoteTokens[token]
	return entry and entry.command or ("/" .. token:lower())
end

--[[
    Which Data.EMOTE_GROUPS group an emote belongs to on this flavor, from
    Data/<Flavor>/Emote-Groups-<Flavor>.lua. A token that file does not list
    is a Text emote.
]]
function ns.GetEmoteGroup(token)
	return (ns.EMOTE_GROUP_BY_TOKEN and ns.EMOTE_GROUP_BY_TOKEN[token]) or "Text"
end

--------------------------------------------------------------------------------
-- Secret Values
--------------------------------------------------------------------------------

-- True when a value is safe to compare, concatenate, or send; secret values error on all three.
function ns.IsPlain(value)
	return not (issecretvalue and issecretvalue(value))
end

--[[
    On WoW Forever, unit identity and aura data go secret in combat. Ask these
    before reading either; both are always false on the other flavors.
]]
function ns.IsUnitIdentitySecret(unit)
	return ns.FLAVOR == "Camelot" and C_Secrets.ShouldUnitIdentityBeSecret(unit)
end

function ns.AreAurasSecret()
	return ns.FLAVOR == "Camelot" and C_Secrets.ShouldAurasBeSecret()
end

--------------------------------------------------------------------------------
-- Spell Links
--------------------------------------------------------------------------------

--[[
    Chat-safe spell link, built by hand the way Control Freak does. We deliberately
    do NOT prefer the native GetSpellLink: on Classic it returns a link WITHOUT the
    trailing ":0" glyph field, which renders fine in a local tooltip or print, but
    SendChatMessage's hyperlink validator strips a link without it and leaves only
    the bare spell name. Building "Hspell:<id>:0"
    ourselves passes that validator and works in both chat and local prints.

    Native is only a last resort, for the rare spell whose name won't resolve (so we
    can't build the link text ourselves) -- at least it gives something on screen.
]]
local C_SPELL_LINK = ns.SPELL_LINK_COLOR

function ns.GetSpellLink(spellId)
	local name = C_Spell.GetSpellName(spellId)
	if name then
		return ("|cff" .. C_SPELL_LINK .. "|Hspell:%d:0|h[%s]|h|r"):format(spellId, name)
	end
	local link = C_Spell.GetSpellLink(spellId)
	if link and link ~= "" then
		return link
	end
	return nil
end

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
function ns.IsPlayerGUID(guid)
	return type(guid) == "string" and guid:sub(1, 7) == "Player-"
end

--------------------------------------------------------------------------------
-- Sound
--------------------------------------------------------------------------------

--[[
    The sound plays on the Master channel so it stays audible for players who
    run with game sound effects turned down. The file name must match
    Includes/Sounds/ exactly.
]]
local SOUND_ROOT = "Interface/AddOns/" .. ADDON_NAME .. "/Includes/Sounds/"

-- Played when a stranger's buff lands on you.
function ns.PlayBuffSound()
	PlaySoundFile(SOUND_ROOT .. "Buff.ogg", "Master")
end

--------------------------------------------------------------------------------
-- Aura API Compatibility
--------------------------------------------------------------------------------

--[[
    Duration of a HELPFUL aura on `unit` for `spellId`, or nil when absent. A live
    buff can legitimately report 0 (no timer), so callers must nil-check the result,
    not test it for truthiness. 40 is the aura cap the client exposes.
]]
function ns.GetBuffDuration(unit, spellId)
	for i = 1, 40 do
		local data = C_UnitAuras.GetBuffDataByIndex(unit, i, "HELPFUL")
		if not data then
			return nil
		end
		if ns.IsPlain(data.spellId) and data.spellId == spellId then
			return data.duration or 0
		end
	end
	return nil
end

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
-- Unit Resolution
--------------------------------------------------------------------------------

--[[
    A usable emote target must be a live unit token: C_ChatInfo.PerformEmote
    only directs "you cheer at X" at a real unit, and a combat-log name is not
    one -- cross-realm sources arrive as "Name-Realm" and never resolve. Map the
    buffer's GUID to a unit we actually have (the player, a group member, or the
    current target / focus / mouseover) and return nil when none matches; the
    emote caller then falls back to the bare name, which still degrades to the
    undirected emote when the client can't resolve it.
]]
local POINTED_UNITS = { "target", "focus", "mouseover" }

-- Does this unit carry this GUID? A secret GUID (WoW Forever) never matches, since comparing one errors.
function ns.UnitHasGUID(unit, guid)
	local unitGUID = UnitGUID(unit)
	return unitGUID ~= nil and ns.IsPlain(unitGUID) and unitGUID == guid
end

function ns.GetUnitByGUID(guid)
	if not guid then
		return nil
	end
	if ns.UnitHasGUID("player", guid) then
		return "player"
	end
	local prefix, count = "party", 4
	if IsInRaid() then
		prefix, count = "raid", 40
	end
	for i = 1, count do
		local unit = prefix .. i
		if UnitExists(unit) and ns.UnitHasGUID(unit, guid) then
			return unit
		end
	end
	for _, unit in ipairs(POINTED_UNITS) do
		if UnitExists(unit) and ns.UnitHasGUID(unit, guid) then
			return unit
		end
	end
	return nil
end
