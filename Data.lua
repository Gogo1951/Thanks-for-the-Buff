local addonName, ns = ...
ns.Data = {}

--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------
ns.Data.COLORS = {
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
function ns.GetColor(key)
    local hex = ns.Data.COLORS[key]
    if hex then
        return "|cff" .. hex
    end
    return "|cffFFFFFF"
end

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
ns.Data.SAFETY_PAUSE = 3
ns.Data.MACRO_NAME   = "- Thank"
ns.Data.ADDON_TITLE  = "Thanks for the Buff"

ns.Data.DISCORD_URL    = "https://discord.gg/eh8hKq992Q"
ns.Data.GITHUB_URL     = "https://github.com/Gogo1951/Thanks-for-the-Buff"
ns.Data.CURSEFORGE_URL = "https://www.curseforge.com/wow/addons/thanks-for-the-buff-revisited"

--[[
    AURA ID VERIFICATION TASK LIST
    ===============================
    Since we track SPELL_AURA_APPLIED, every ID here must be the BUFF/AURA
    spell ID (what shows up on the target's buff bar), NOT the cast spell ID.
    For most single-rank spells these are the same, but multi-rank and
    item-based spells can differ.

    VERIFY THESE IN-GAME (use: /dump C_UnitAuras.GetAuraDataBySpellName("player", "BuffName")):

    High-priority (known to sometimes differ between cast ID and aura ID):
      - Soulstone         : listed 20707,20710,20712,20714,20716,20718,47883
      - Lay on Hands      : listed 633,2800,10310,27154,48788
      - Divine Intervention: listed 19752
      - Misdirection      : listed 34477
      - Beacon of Light    : listed 53563

    Medium-priority (multi-rank spells — confirm highest rank aura IDs):
      - Amplify Magic      : listed 1008,604,8450,8451,10169,10170,27130,43017
      - Dampen Magic       : listed 603,1581,10173,10174,27128,43015
      - Hand of Protection : listed 1022,5599,10278
      - Hand of Sacrifice  : listed 6940,20729,27147,27148

    Item-based (confirm these are the BUFF aura IDs, not the item-use cast IDs):
      - Greater Drums of Battle      : listed 351355
      - Greater Drums of Restoration : listed 351358
      - Greater Drums of Speed       : listed 351359
      - Greater Drums of War         : listed 351360
      - Drums of Restoration         : listed 35478
      - Drums of Speed               : listed 35477
      - Drums of War                 : listed 35475

    Spells marked noAura = true track via SPELL_CAST_SUCCESS instead
    (they don't place a buff on the target):
      - Rebirth       (resurrect — no aura)
      - Leap of Faith (grip — no persistent aura)
]]

--------------------------------------------------------------------------------
-- Spell List
--------------------------------------------------------------------------------
ns.Data.SPELL_LIST = {
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
        {name = "Misdirection",      ids = {34477}},
        {name = "Roar of Sacrifice", ids = {53480}}
    },
    ["MAGE"] = {
        {name = "Amplify Magic", ids = {1008, 604, 8450, 8451, 10169, 10170, 27130, 43017}},
        {name = "Dampen Magic",  ids = {603, 1581, 10173, 10174, 27128, 43015}},
        {name = "Focus Magic",   ids = {54646}}
    },
    ["PALADIN"] = {
        {name = "Beacon of Light",     ids = {53563}},
        {name = "Divine Intervention",  ids = {19752}},
        {name = "Hand of Freedom",      ids = {1044}},
        {name = "Hand of Protection",   ids = {1022, 5599, 10278}},
        {name = "Hand of Sacrifice",    ids = {6940, 20729, 27147, 27148}},
        {name = "Lay on Hands",         ids = {633, 2800, 10310, 27154, 48788}}
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
        {name = "Bloodlust",      ids = {2825}},
        {name = "Heroism",        ids = {32182}},
        {name = "Water Breathing", ids = {131}},
        {name = "Water Walking",   ids = {546}}
    },
    ["WARLOCK"] = {
        {name = "Soulstone",      ids = {20707, 20710, 20712, 20714, 20716, 20718, 47883}},
        {name = "Unending Breath", ids = {5697}}
    },
    ["WARRIOR"] = {
        {name = "Intervene",  ids = {3411}},
        {name = "Vigilance",  ids = {50720}}
    },
    ["ITEMS"] = {
        {name = "Drums of Restoration",         ids = {35478},  category = "PARTY_ITEM"},
        {name = "Drums of Speed",               ids = {35477},  category = "PARTY_ITEM"},
        {name = "Drums of War",                 ids = {35475},  category = "PARTY_ITEM"},
        {name = "Greater Drums of Battle",      ids = {351355}, category = "PARTY_ITEM"},
        {name = "Greater Drums of Restoration", ids = {351358}, category = "PARTY_ITEM"},
        {name = "Greater Drums of Speed",       ids = {351359}, category = "PARTY_ITEM"},
        {name = "Greater Drums of War",         ids = {351360}, category = "PARTY_ITEM"}
    }
}

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------
ns.Data.EMOTES = {
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
    for _, data in ipairs(ns.Data.EMOTES) do
        emotes[data.cmd] = true
    end
    return emotes
end

--------------------------------------------------------------------------------
-- Saved Variable Defaults
--------------------------------------------------------------------------------
ns.Data.DEFAULTS = {
    profile = {
        lastRunVersion = "0.0.0",
        global = {
            welcomeMessage = true
        },
        strangers = {
            enabled        = true,
            messaging      = "NONE",
            cooldown       = 3,
            minBuffDuration = 25,
            emotesEnabled  = true,
            emotes         = GetDefaultEmoteSettings()
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