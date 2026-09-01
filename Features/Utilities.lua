local _, ns = ...

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
    Diagnostics can export the same list from any flavour without a code change.

    Two traps the scan has to respect. Indices are SPARSE (Era jumps 171 -> 304),
    so it cannot stop at the first gap. And a few tokens appear twice under
    different indices (INCOMING, FLEE), so tokens are deduped -- the dropdown
    should not offer the same emote twice.

    Sorted by the slash command players recognise, not by token or index. Built
    once on demand; these globals do not change during a session.
]]
local EMOTE_SCAN_CEILING = 1000 -- backstop only, for a client without MAXEMOTEINDEX

local emoteCatalog, emoteTokens

local function BuildEmoteCatalog()
	emoteCatalog, emoteTokens = {}, {}

	-- The client's own list of emotes that play a voice line. Absent on some
	-- builds, in which case the voice column simply reads unknown.
	local voice = {}
	if type(TextEmoteSpeechList) == "table" then
		for _, entry in pairs(TextEmoteSpeechList) do
			voice[tostring(entry)] = true
		end
	end

	for index = 1, (MAXEMOTEINDEX or EMOTE_SCAN_CEILING) do
		local token = _G["EMOTE" .. index .. "_TOKEN"]
		if token and not emoteTokens[token] then
			-- CMD1 is the primary; the rest are aliases, and the client repeats the
			-- whole set once per locale, so exact repeats are dropped.
			local aliases, seen = {}, {}
			for c = 1, 8 do
				local cmd = _G["EMOTE" .. index .. "_CMD" .. c]
				if cmd and cmd ~= "" and not seen[cmd] then
					seen[cmd] = true
					aliases[#aliases + 1] = cmd
				end
			end
			emoteTokens[token] = true
			emoteCatalog[#emoteCatalog + 1] = {
				index = index,
				token = token,
				command = aliases[1] or ("/" .. token:lower()),
				aliases = table.concat(aliases, " "),
				voice = voice[token] == true,
			}
		end
	end

	table.sort(emoteCatalog, function(a, b)
		return a.command < b.command
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
	return token ~= nil and emoteTokens[token] == true
end

--------------------------------------------------------------------------------
-- Spell API Compatibility
--------------------------------------------------------------------------------

-- Resolve each spell API to a single function by availability, then call once.

ns.GetSpellDescription = (C_Spell and C_Spell.GetSpellDescription) or GetSpellDescription
ns.GetSpellTexture = (C_Spell and C_Spell.GetSpellTexture) or GetSpellTexture

-- Rank-agnostic spell name, used to collapse spell ranks into one tracked group.
if C_Spell and C_Spell.GetSpellName then
	ns.GetSpellName = C_Spell.GetSpellName
elseif C_Spell and C_Spell.GetSpellInfo then
	ns.GetSpellName = function(spellId)
		local info = C_Spell.GetSpellInfo(spellId)
		return info and info.name
	end
else
	ns.GetSpellName = function(spellId)
		if not GetSpellInfo then
			return nil
		end
		return (GetSpellInfo(spellId))
	end
end

--[[
    Ask the client to stream in a spell's tooltip text. Classic keeps description
    data only for spells the character has actually known, which is why a panel
    listing all nine classes' cooldowns reads blank for eight of them -- the id is
    valid and GetSpellName answers fine, but GetSpellDescription returns "".

    Fire and forget: the data arrives asynchronously and the next tooltip draw
    picks it up. Absent on any client that never gained the API, in which case
    callers keep whatever fallback text they already had.
]]
local RequestLoadSpellData = C_Spell and C_Spell.RequestLoadSpellData
function ns.RequestSpellData(ids)
	if not RequestLoadSpellData or not ids then
		return
	end
	for i = 1, #ids do
		RequestLoadSpellData(ids[i])
	end
end

if C_Spell and C_Spell.DoesSpellExist then
	ns.DoesSpellExist = C_Spell.DoesSpellExist
else
	local GetSpellInfo = (C_Spell and C_Spell.GetSpellInfo) or GetSpellInfo
	ns.DoesSpellExist = function(spellId)
		return GetSpellInfo(spellId) ~= nil
	end
end

--[[
    Chat-safe spell link, built by hand the way Control Freak does. We deliberately
    do NOT prefer the native GetSpellLink: on Classic it returns a link WITHOUT the
    trailing ":0" glyph field, which renders fine in a local tooltip or print but
    SendChatMessage's hyperlink validator strips on send -- so whispers arrived with
    the link gone and only the bare spell name left. Building "Hspell:<id>:0"
    ourselves passes that validator and works in both chat and local prints.

    Native is only a last resort, for the rare spell whose name won't resolve (so we
    can't build the link text ourselves) -- at least it gives something on screen.
]]
-- The client's own spell-link blue, verbatim. Not a palette role, so it is kept
-- separate; the exact literal is preserved because this string is handed to
-- SendChatMessage's hyperlink validator (see ns.GetSpellLink below).
local C_SPELL_LINK = "71d5ff"

local NativeGetSpellLink = (C_Spell and C_Spell.GetSpellLink) or GetSpellLink
function ns.GetSpellLink(spellId)
	local name = ns.GetSpellName(spellId)
	if name then
		return ("|cff" .. C_SPELL_LINK .. "|Hspell:%d:0|h[%s]|h|r"):format(spellId, name)
	end
	local link = NativeGetSpellLink and NativeGetSpellLink(spellId)
	if link and link ~= "" then
		return link
	end
	return nil
end

--------------------------------------------------------------------------------
-- Item API Compatibility
--------------------------------------------------------------------------------

-- Both return the same values as the legacy globals, so resolve each to a single
-- function by availability (mirrors the C_Spell shims above).
ns.GetItemInfo = (C_Item and C_Item.GetItemInfo) or GetItemInfo
ns.GetItemIcon = (C_Item and C_Item.GetItemIconByID) or GetItemIcon

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

-- Both sounds play on the Master channel so they stay audible for players who
-- run with game sound effects turned down. File names must match
-- Includes/Sounds/ exactly.
local SOUND_ROOT = "Interface/AddOns/TFTB/Includes/Sounds/"

-- Any buff landing on you shares this one, stranger or teammate alike.
function ns.PlayBuffSound()
	PlaySoundFile(SOUND_ROOT .. "Buff.ogg", "Master")
end

function ns.PlayPeerPressureSound()
	PlaySoundFile(SOUND_ROOT .. "Thunder.ogg", "Master")
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
		if data.spellId == spellId then
			return data.duration or 0
		end
	end
	return nil
end

--------------------------------------------------------------------------------
-- Game Flavor
--------------------------------------------------------------------------------

--[[
    Which per-flavor default column applies on this client: 1 = Classic Era,
    2 = TBC, 3 = Wrath, with anything past Wrath reading the Wrath slot. Shared
    by every data table that carries {Era, TBC, Wrath} columns (Data.TRACKED,
    Data.PEER_PRESSURE).
]]
local tocVersion = select(4, GetBuildInfo())
ns.FLAVOR_INDEX = (tocVersion < 20000 and 1) or (tocVersion < 30000 and 2) or 3
