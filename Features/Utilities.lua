local _, ns = ...
local Data = ns.Data

--------------------------------------------------------------------------------
-- Color Accessor
--------------------------------------------------------------------------------

-- Derived from the raw hex palette in Data.lua; |cff prefixed for point-of-use.
local COLOR_PREFIX = "|cff"

local COLORS = {}
for key, hex in pairs(Data.COLORS) do
    COLORS[key] = COLOR_PREFIX .. hex
end

function ns.GetColor(key)
    return COLORS[key] or COLORS.TEXT
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
local NativeGetSpellLink = (C_Spell and C_Spell.GetSpellLink) or GetSpellLink
function ns.GetSpellLink(spellId)
    local name = ns.GetSpellName(spellId)
    if name then
        return ("|cff71d5ff|Hspell:%d:0|h[%s]|h|r"):format(spellId, name)
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
-- Aura API Compatibility
--------------------------------------------------------------------------------

--[[
    Duration of a HELPFUL aura on `unit` whose spell id is `spellId`, or nil when
    no such buff is present. A live buff can legitimately report 0 (no timer), so
    callers must nil-check the result, not test it for truthiness on the number.

    Prefers the modern per-index reader C_UnitAuras.GetBuffDataByIndex -- the same
    data source AuraUtil.ForEachAura packs, chosen over ForEachAura because it ships
    in the same API generation (so it adds no coverage) while avoiding ForEachAura's
    packed/unpacked callback ambiguity. Falls back to the legacy UnitAura scan on
    clients that predate C_UnitAuras. 40 is the aura cap the client exposes.
]]
if C_UnitAuras and C_UnitAuras.GetBuffDataByIndex then
    ns.GetBuffDuration = function(unit, spellId)
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
else
    ns.GetBuffDuration = function(unit, spellId)
        for i = 1, 40 do
            local name, _, _, _, duration, _, _, _, _, auraSpellId = UnitAura(unit, i, "HELPFUL")
            if not name then
                return nil
            end
            if auraSpellId == spellId then
                return duration or 0
            end
        end
        return nil
    end
end
