local addonName, ns = ...
ns.L = LibStub("AceLocale-3.0"):GetLocale("TFTB")
ns.Data = {}

local Data = ns.Data

--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------

Data.COLORS = {
    -- UI Palette
    TITLE    = "FFD100",
    BRAND    = "00BBFF",
    INFO     = "00BBFF",
    DESC     = "CCCCCC",
    TEXT     = "FFFFFF",
    SUCCESS  = "33CC33",
    DISABLED = "CC3333",
    SEP      = "AAAAAA",
    MUTED    = "808080",
    -- Class Colors
    DEATHKNIGHT = "C41E3A",
    DEMONHUNTER = "A330C9",
    DRUID       = "FF7C0A",
    EVOKER      = "33937F",
    HUNTER      = "AAD372",
    MAGE        = "3FC7EB",
    MONK        = "00FF96",
    PALADIN     = "F48CBA",
    PRIEST      = "FFFFFF",
    ROGUE       = "FFF468",
    SHAMAN      = "0070DD",
    WARLOCK     = "8788EE",
    WARRIOR     = "C69B6D",
    -- Special
    ITEMS       = "A335EE"
}

--------------------------------------------------------------------------------
-- Color Helper
--------------------------------------------------------------------------------

local COLOR_PREFIX = "|cff"

function ns.GetColor(key)
    local hex = Data.COLORS[key]
    if hex then
        return COLOR_PREFIX .. hex
    end
    return COLOR_PREFIX .. "FFFFFF"
end

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

Data.SAFETY_PAUSE  = 3
Data.MACRO_NAME    = "- Thank"
Data.ADDON_TITLE   = "Thanks for the Buff"

Data.DISCORD_URL    = "https://discord.gg/eh8hKq992Q"
Data.GITHUB_URL     = "https://github.com/Gogo1951/Thanks-for-the-Buff"
Data.CURSEFORGE_URL = "https://www.curseforge.com/wow/addons/thanks-for-the-buff-revisited"

--------------------------------------------------------------------------------
-- Spell List
--------------------------------------------------------------------------------

-- { name, ids (aura IDs on the player), noAura, category, itemId }
--
-- ids        = the spell IDs that fire in SPELL_AURA_APPLIED on the player.
-- noAura     = true means the spell has no buff aura on the target; track via
--              SPELL_CAST_SUCCESS instead (resurrects, grips, direct heals).
-- category   = "PARTY_ITEM" for item-use buffs. Defaults to "CLASS".
-- itemId     = source item ID, used for tooltip lookups on item-based buffs.

Data.SPELL_LIST = {
    ["DEATHKNIGHT"] = {
        {name = "Unholy Frenzy", ids = {49016}}
    },
    ["DRUID"] = {
        {name = "Innervate",  ids = {29166}},
        {name = "Ironbark",   ids = {102342}},
        {name = "Rebirth",    ids = {20484, 20739, 20742, 20747, 20748, 26994, 48477}, noAura = true}
    },
    ["HUNTER"] = {
        {name = "Master's Call",     ids = {53271}},
        {name = "Misdirection",      ids = {35079}},
        {name = "Roar of Sacrifice", ids = {53480}}
    },
    ["MAGE"] = {
        {name = "Amplify Magic", ids = {1008, 604, 8450, 8451, 10169, 10170, 27130, 43017}},
        {name = "Dampen Magic",  ids = {603, 1581, 10173, 10174, 27128, 43015}},
        {name = "Focus Magic",   ids = {54646}}
    },
    ["PALADIN"] = {
        {name = "Beacon of Light",    ids = {53563}},
        {name = "Divine Intervention", ids = {19752}},
        {name = "Hand of Freedom",    ids = {1044}},
        {name = "Hand of Protection", ids = {1022, 5599, 10278}},
        {name = "Hand of Sacrifice",  ids = {6940, 20729, 27147, 27148}},
        {name = "Lay on Hands",       ids = {633, 2800, 10310, 27154, 48788}, noAura = true}
    },
    ["PRIEST"] = {
        {name = "Fear Ward",        ids = {6346}},
        {name = "Guardian Spirit",  ids = {47788}},
        {name = "Leap of Faith",    ids = {73325}, noAura = true},
        {name = "Pain Suppression", ids = {33206}},
        {name = "Power Infusion",   ids = {10060}}
    },
    ["ROGUE"] = {
        {name = "Tricks of the Trade", ids = {57934}}
    },
    ["SHAMAN"] = {
        {name = "Bloodlust",       ids = {2825}},
        {name = "Heroism",         ids = {32182}},
        {name = "Water Breathing", ids = {131}},
        {name = "Water Walking",   ids = {546}}
    },
    ["WARLOCK"] = {
        {name = "Soulstone",       ids = {20707, 20762, 20763, 20764, 20765, 27239, 47883}},
        {name = "Unending Breath", ids = {5697}}
    },
    ["WARRIOR"] = {
        {name = "Intervene",  ids = {3411}},
        {name = "Vigilance",  ids = {50720}}
    },
    -- itemId = source item; ids = buff aura on the player
    ["ITEMS"] = {
        {name = "Drums of Battle",              itemId = 29529,  ids = {35476},  category = "PARTY_ITEM"},
        {name = "Drums of Restoration",         itemId = 29531,  ids = {35478},  category = "PARTY_ITEM"},
        {name = "Drums of Speed",               itemId = 29530,  ids = {35477},  category = "PARTY_ITEM"},
        {name = "Drums of War",                 itemId = 29528,  ids = {35475},  category = "PARTY_ITEM"},
        {name = "Greater Drums of Battle",      itemId = 185848, ids = {351355}, category = "PARTY_ITEM"},
        {name = "Greater Drums of Restoration", itemId = 185850, ids = {351358}, category = "PARTY_ITEM"},
        {name = "Greater Drums of Speed",       itemId = 185851, ids = {351359}, category = "PARTY_ITEM"},
        {name = "Greater Drums of War",         itemId = 185852, ids = {351360}, category = "PARTY_ITEM"}
    }
}

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

Data.EMOTES = {
    {cmd = "CHEER",    displayName = "/cheer",    desc = "You cheer at <Target>."},
    {cmd = "DRINK",    displayName = "/drink",    desc = "You raise a drink to <Target>."},
    {cmd = "FLEX",     displayName = "/flex",     desc = "You flex at <Target>."},
    {cmd = "GRIN",     displayName = "/grin",     desc = "You grin wickedly at <Target>."},
    {cmd = "HIGHFIVE", displayName = "/highfive", desc = "You high-five <Target>."},
    {cmd = "PRAISE",   displayName = "/praise",   desc = "You praise <Target>."},
    {cmd = "SALUTE",   displayName = "/salute",   desc = "You salute <Target> with respect."},
    {cmd = "SMILE",    displayName = "/smile",    desc = "You smile at <Target>."},
    {cmd = "THANK",    displayName = "/thank",    desc = "You thank <Target>."},
    {cmd = "WHOA",     displayName = "/whoa",     desc = "You look at <Target> and exclaim 'Whoa!'"},
    {cmd = "WINK",     displayName = "/wink",     desc = "You wink at <Target>."},
    {cmd = "YES",      displayName = "/yes",      desc = "You nod at <Target>."}
}

--------------------------------------------------------------------------------
-- Default Emote Settings
--------------------------------------------------------------------------------

local function GetDefaultEmoteSettings()
    local emotes = {}
    for _, data in ipairs(Data.EMOTES) do
        emotes[data.cmd] = true
    end
    return emotes
end

--------------------------------------------------------------------------------
-- Saved Variable Defaults
--------------------------------------------------------------------------------

Data.DEFAULTS = {
    profile = {
        lastRunVersion = "0.0.0",
        global = {
            welcomeMessage = true
        },
        strangers = {
            enabled         = true,
            messaging       = "NONE",
            cooldown        = 3,
            minBuffDuration = 25,
            emotesEnabled   = true,
            emotes          = GetDefaultEmoteSettings()
        },
        slash = {
            createMacro = true,
            message     = "Thanks, you're the best! (=",
            emotes      = GetDefaultEmoteSettings()
        },
        groupBuffs = {
            messaging    = "PRINT",
            watchedBuffs = {}
        }
    }
}