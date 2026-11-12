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
-- Emote Blockers
--------------------------------------------------------------------------------

--[[
    Why an emote TFTB would play on its own should be held back right now, or
    nil when nothing stops it. Every automatic emote (Give Thanks, Wave to
    Friends) asks this; the Thank You buttons do not, since pressing one is the
    player choosing to emote.

    - Combat: the promise is that an emote never plays while you are fighting.
    - Casting or channeling: an animated emote cancels a cast in progress, so a
      thank-you would cost you the hearth, the craft or the cast you were on.
    - A fishing pole in hand: fishing is a channel the emote would break, and
      between casts you are about to cast again. Read by item class rather than
      name, so it holds in every client language.

    A secret cast return (WoW Forever) counts as casting: something is there,
    and guessing "nothing" is the guess that breaks the cast.
]]
local MAIN_HAND_SLOT = INVSLOT_MAINHAND or 16
local WEAPON_CLASS = (Enum and Enum.ItemClass and Enum.ItemClass.Weapon) or 2
local FISHING_POLE_SUBCLASS = (Enum and Enum.ItemWeaponSubclass and Enum.ItemWeaponSubclass.Fishingpole) or 20

local function IsBusyCasting()
	for _, read in ipairs({ UnitCastingInfo, UnitChannelInfo }) do
		local spell = read and read("player")
		if not ns.IsPlain(spell) or spell ~= nil then
			return true
		end
	end
	return false
end

function ns.IsFishingPoleEquipped()
	local itemID = GetInventoryItemID("player", MAIN_HAND_SLOT)
	if not itemID or not ns.IsPlain(itemID) then
		return false
	end
	local _, _, _, _, _, classID, subclassID = C_Item.GetItemInfoInstant(itemID)
	return classID == WEAPON_CLASS and subclassID == FISHING_POLE_SUBCLASS
end

function ns.GetEmoteBlocker()
	if InCombatLockdown() then
		return "combat"
	end
	if IsBusyCasting() then
		return "casting"
	end
	if ns.IsFishingPoleEquipped() then
		return "fishing pole"
	end
	return nil
end

--------------------------------------------------------------------------------
-- Mouse Focus
--------------------------------------------------------------------------------

--[[
    True only when the cursor is on the 3D world. Mousing over a unit frame,
    a raid frame or a nameplate's health bar also fires UPDATE_MOUSEOVER_UNIT,
    and those are never a reason to wave. The API is chosen once at load,
    modern first.
]]
if GetMouseFoci then
	function ns.IsMouseOverWorld()
		local foci = GetMouseFoci()
		return type(foci) == "table" and foci[1] == WorldFrame
	end
elseif GetMouseFocus then
	function ns.IsMouseOverWorld()
		return GetMouseFocus() == WorldFrame
	end
else
	function ns.IsMouseOverWorld()
		return true
	end
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
