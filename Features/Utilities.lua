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
