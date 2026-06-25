local ADDON_NAME, ns = ...
ns.L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
ns.Data = {}

local Data = ns.Data
local L = ns.L

--------------------------------------------------------------------------------
-- Colors (UI Palette)
--------------------------------------------------------------------------------

Data.COLORS = {
    TITLE = "FFD100",
    INFO = "00BBFF",
    BODY = "CCCCCC",
    TEXT = "FFFFFF",
    ON = "33CC33",
    OFF = "CC3333",
    SEPARATOR = "AAAAAA",
    MUTED = "808080",
}

--------------------------------------------------------------------------------
-- Class Colors
--------------------------------------------------------------------------------

Data.CLASS_COLORS = {
    DEATHKNIGHT = "C41E3A",
    DEMONHUNTER = "A330C9",
    DRUID = "FF7C0A",
    EVOKER = "33937F",
    HUNTER = "AAD372",
    MAGE = "3FC7EB",
    MONK = "00FF96",
    PALADIN = "F48CBA",
    PRIEST = "FFFFFF",
    ROGUE = "FFF468",
    SHAMAN = "0070DD",
    WARLOCK = "8788EE",
    WARRIOR = "C69B6D"
}

--------------------------------------------------------------------------------
-- Item Quality Colors
--------------------------------------------------------------------------------

-- Epic / item-link purple. Not a class color, kept separate.
Data.ITEM_QUALITY_COLORS = {
    EPIC = "A335EE"
}

--------------------------------------------------------------------------------
-- Options Registry
--------------------------------------------------------------------------------

ns.OPTIONS_REGISTRY = {
    General = ADDON_NAME,
    Strangers = ADDON_NAME .. "_Strangers",
    Teammates = ADDON_NAME .. "_Teammates",
    Services = ADDON_NAME .. "_Services",
    ThankYou = ADDON_NAME .. "_ThankYou",
    Diagnostics = ADDON_NAME .. "_Diagnostics"
}

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

Data.SAFETY_PAUSE = 3
Data.MACRO_NAME = "- Thank"

--[[
    {rt1} Star, {rt2} Circle, {rt3} Diamond, {rt4} Triangle,
    {rt5} Moon, {rt6} Square, {rt7} Cross, {rt8} Skull
]]
ns.TARGET_MARKER = "{rt1}" -- Star

Data.DISCORD_URL = "https://discord.gg/eh8hKq992Q"
Data.GITHUB_URL = "https://github.com/Gogo1951/Thanks-for-the-Buff"
Data.CURSEFORGE_URL = "https://www.curseforge.com/wow/addons/thanks-for-the-buff-revisited"

--------------------------------------------------------------------------------
-- Tracking Codes
--------------------------------------------------------------------------------

-- How the thank-you reads, and which panel the toggle lives on.
Data.BUFF = {
    SOLO = "SOLO", -- cast on you            -> "gave you ..."        (Buffs from Teammates)
    GROUP = "GROUP", -- party/raid-wide        -> "gave your group ..." (Buffs from Teammates)
    SERVICE = "SERVICE" -- set out for the group  -> "set out a ..."       (Group Services)
}

-- How the combat log is matched.
Data.DETECT = {
    AURA = "AURA", -- SPELL_AURA_APPLIED lands on you
    CAST = "CAST" -- SPELL_CAST_SUCCESS fires
}

--------------------------------------------------------------------------------
-- Tracked Reactions
--------------------------------------------------------------------------------

--[[
    One entry == one checkbox in the options panel. Everything about that toggle
    lives in the entry; nothing merges across rows.

      name      display label. Omit to use the (localized) name of the first
                trigger -- set it only for a group whose members differ (Portals).
      class     class bucket for the Buffs-from-Teammates panel. Omit for the
                generic Items / Group Services lists.
      type      Data.BUFF.SOLO | GROUP | SERVICE
      detect    Data.DETECT.AURA | CAST
      triggers  the rank(s) / variant(s) this one toggle covers. Each is:
                  {spell = id}              a tracked spell
                  {spell = id, aura = id}   aura id differs from the cast id
                  {item = id, spell = id}   an item: shows its icon/name, and the
                                            tooltip lists every item in the group
]]
local BUFF, DETECT = Data.BUFF, Data.DETECT

Data.TRACKED = {
    -- Death Knight --------------------------------------------------------------
    {class = "DEATHKNIGHT", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 49016}}}, -- Unholy Frenzy
    -- Druid ---------------------------------------------------------------------
    {class = "DRUID", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 29166}}}, -- Innervate
    {
        class = "DRUID",
        type = BUFF.SOLO,
        detect = DETECT.CAST,
        triggers = {
            -- Rebirth
            {spell = 20484},
            {spell = 20739},
            {spell = 20742},
            {spell = 20747},
            {spell = 20748},
            {spell = 26994},
            {spell = 48477}
        }
    },
    -- Hunter --------------------------------------------------------------------
    {class = "HUNTER", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 53271}}}, -- Master's Call
    {class = "HUNTER", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 34477, aura = 35079}}}, -- Misdirection
    {class = "HUNTER", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 53480}}}, -- Roar of Sacrifice
    -- Mage ----------------------------------------------------------------------
    {
        class = "MAGE",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            -- Amplify Magic
            {spell = 1008},
            {spell = 8455},
            {spell = 10169},
            {spell = 10170},
            {spell = 27130},
            {spell = 43017}
        }
    },
    {
        class = "MAGE",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            -- Dampen Magic
            {spell = 604},
            {spell = 8450},
            {spell = 8451},
            {spell = 10173},
            {spell = 10174},
            {spell = 33944},
            {spell = 43015}
        }
    },
    {class = "MAGE", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 54646}}}, -- Focus Magic
    {
        class = "MAGE",
        type = BUFF.SERVICE,
        detect = DETECT.CAST,
        triggers = {
            -- Ritual of Refreshment
            {spell = 43987},
            {spell = 58659}
        }
    },
    {
        name = "Portals",
        class = "MAGE",
        type = BUFF.SERVICE,
        detect = DETECT.CAST,
        triggers = {
            {spell = 10059}, -- Stormwind
            {spell = 11416}, -- Ironforge
            {spell = 11417}, -- Orgrimmar
            {spell = 11418}, -- Undercity
            {spell = 11419}, -- Darnassus
            {spell = 11420}, -- Thunder Bluff
            {spell = 32266}, -- Exodar
            {spell = 32267}, -- Silvermoon
            {spell = 33691}, -- Shattrath (Alliance)
            {spell = 35717}, -- Shattrath (Horde)
            {spell = 49360}, -- Theramore (Alliance)
            {spell = 49361}, -- Stonard (Horde)
            {spell = 53142}, -- Dalaran
            {spell = 28148} -- Karazhan (Atiesh)
        }
    },
    -- Paladin -------------------------------------------------------------------
    {class = "PALADIN", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 53563}}}, -- Beacon of Light
    {class = "PALADIN", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 19752}}}, -- Divine Intervention
    {class = "PALADIN", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 1044}}}, -- Hand of Freedom
    {
        class = "PALADIN",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            -- Hand of Protection
            {spell = 1022},
            {spell = 5599},
            {spell = 10278}
        }
    },
    {
        class = "PALADIN",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            -- Hand of Sacrifice
            {spell = 6940},
            {spell = 20729},
            {spell = 27147},
            {spell = 27148}
        }
    },
    {
        class = "PALADIN",
        type = BUFF.SOLO,
        detect = DETECT.CAST,
        triggers = {
            -- Lay on Hands
            {spell = 633},
            {spell = 2800},
            {spell = 10310},
            {spell = 27154},
            {spell = 48788}
        }
    },
    -- Priest --------------------------------------------------------------------
    {class = "PRIEST", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 6346}}}, -- Fear Ward
    {class = "PRIEST", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 47788}}}, -- Guardian Spirit
    {class = "PRIEST", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 33206}}}, -- Pain Suppression
    {class = "PRIEST", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 10060}}}, -- Power Infusion
    -- Rogue ---------------------------------------------------------------------
    {class = "ROGUE", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 57934, aura = 57933}}}, -- Tricks of the Trade
    -- Shaman --------------------------------------------------------------------
    {class = "SHAMAN", type = BUFF.GROUP, detect = DETECT.AURA, triggers = {{spell = 2825}}}, -- Bloodlust
    {class = "SHAMAN", type = BUFF.GROUP, detect = DETECT.AURA, triggers = {{spell = 32182}}}, -- Heroism
    {class = "SHAMAN", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 131}}}, -- Water Breathing
    {class = "SHAMAN", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 546}}}, -- Water Walking
    -- Warlock -------------------------------------------------------------------
    {class = "WARLOCK", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 5697}}}, -- Unending Breath
    {
        class = "WARLOCK",
        type = BUFF.SERVICE,
        detect = DETECT.CAST,
        triggers = {
            -- Ritual of Souls
            {spell = 29893},
            {spell = 58887}
        }
    },
    {class = "WARLOCK", type = BUFF.SERVICE, detect = DETECT.CAST, triggers = {{spell = 698}}}, -- Ritual of Summoning
    -- Warrior -------------------------------------------------------------------
    {class = "WARRIOR", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 3411}}}, -- Intervene
    {class = "WARRIOR", type = BUFF.SOLO, detect = DETECT.AURA, triggers = {{spell = 50720}}}, -- Vigilance
    -- Drums (item) --------------------------------------------------------------
    {type = BUFF.GROUP, detect = DETECT.AURA, triggers = {{item = 29529, spell = 35476}}}, -- Drums of Battle
    {type = BUFF.GROUP, detect = DETECT.AURA, triggers = {{item = 29531, spell = 35478}}}, -- Drums of Restoration
    {type = BUFF.GROUP, detect = DETECT.AURA, triggers = {{item = 29530, spell = 35477}}}, -- Drums of Speed
    {type = BUFF.GROUP, detect = DETECT.AURA, triggers = {{item = 29528, spell = 35475}}}, -- Drums of War
    {type = BUFF.GROUP, detect = DETECT.AURA, triggers = {{item = 185848, spell = 351355}}}, -- Greater Drums of Battle
    {type = BUFF.GROUP, detect = DETECT.AURA, triggers = {{item = 185850, spell = 351358}}}, -- Greater Drums of Restoration
    {type = BUFF.GROUP, detect = DETECT.AURA, triggers = {{item = 185851, spell = 351359}}}, -- Greater Drums of Speed
    {type = BUFF.GROUP, detect = DETECT.AURA, triggers = {{item = 185852, spell = 351360}}}, -- Greater Drums of War
    -- Soulstone (item, Warlock) -------------------------------------------------
    {
        name = "Soulstone",
        class = "WARLOCK",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            {item = 16895, spell = 20764}, -- Greater Soulstone
            {item = 16892, spell = 20762}, -- Lesser Soulstone
            {item = 16896, spell = 20765}, -- Major Soulstone
            {item = 22116, spell = 27239}, -- Master Soulstone
            {item = 16893, spell = 20763} -- Soulstone
        }
    },
    -- Feasts (item) -------------------------------------------------------------
    {type = BUFF.SERVICE, detect = DETECT.CAST, triggers = {{item = 43015, spell = 57426}}}, -- Fish Feast
    {type = BUFF.SERVICE, detect = DETECT.CAST, triggers = {{item = 34753, spell = 57301}}}, -- Great Feast
    {type = BUFF.SERVICE, detect = DETECT.CAST, triggers = {{item = 43478, spell = 58465}}}, -- Gigantic Feast
    {type = BUFF.SERVICE, detect = DETECT.CAST, triggers = {{item = 46887, spell = 66476}}}, -- Bountiful Feast
    {type = BUFF.SERVICE, detect = DETECT.CAST, triggers = {{item = 33052, spell = 33258}}}, -- Fisherman's Feast (TBC)
    -- Resistance Cauldrons (item) -----------------------------------------------
    {
        name = "Resistance Cauldrons",
        type = BUFF.SERVICE,
        detect = DETECT.CAST,
        triggers = {
            {item = 32839, spell = 41443}, -- Major Arcane Protection
            {item = 32849, spell = 41494}, -- Major Fire Protection
            {item = 32850, spell = 41495}, -- Major Frost Protection
            {item = 32851, spell = 41497}, -- Major Nature Protection
            {item = 32852, spell = 41498} -- Major Shadow Protection
        }
    },
    -- Stat Scrolls (item) -------------------------------------------------------
    {
        name = "Scroll of Spirit",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            {item = 1181, spell = 8112},
            {item = 1712, spell = 8113},
            {item = 4424, spell = 8114},
            {item = 10306, spell = 12177},
            {item = 27501, spell = 33080},
            {item = 33460, spell = 43197},
            {item = 37097, spell = 48103},
            {item = 37098, spell = 48104}
        }
    },
    {
        name = "Scroll of Stamina",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            {item = 1180, spell = 8099},
            {item = 1711, spell = 8100},
            {item = 4422, spell = 8101},
            {item = 10307, spell = 12178},
            {item = 27502, spell = 33081},
            {item = 33461, spell = 43198},
            {item = 37093, spell = 48101},
            {item = 37094, spell = 48102}
        }
    },
    {
        name = "Scroll of Strength",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            {item = 954, spell = 8118},
            {item = 2289, spell = 8119},
            {item = 4426, spell = 8120},
            {item = 10310, spell = 12179},
            {item = 27503, spell = 33082},
            {item = 33462, spell = 43199},
            {item = 43465, spell = 58448},
            {item = 43466, spell = 58449}
        }
    },
    {
        name = "Scroll of Protection",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            {item = 3013, spell = 8091},
            {item = 1478, spell = 8094},
            {item = 4421, spell = 8095},
            {item = 10305, spell = 12175},
            {item = 27500, spell = 33079},
            {item = 33459, spell = 43196},
            {item = 43467, spell = 58452},
            {item = 43468, spell = 58453}
        }
    },
    {
        name = "Scroll of Intellect",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            {item = 955, spell = 8096},
            {item = 2290, spell = 8097},
            {item = 4419, spell = 8098},
            {item = 10308, spell = 12176},
            {item = 27499, spell = 33078},
            {item = 33458, spell = 43195},
            {item = 37091, spell = 48099},
            {item = 37092, spell = 48100}
        }
    },
    {
        name = "Scroll of Agility",
        type = BUFF.SOLO,
        detect = DETECT.AURA,
        triggers = {
            {item = 3012, spell = 8115},
            {item = 1477, spell = 8116},
            {item = 4425, spell = 8117},
            {item = 10309, spell = 12174},
            {item = 27498, spell = 33077},
            {item = 33457, spell = 43194},
            {item = 43463, spell = 58450},
            {item = 43464, spell = 58451}
        }
    },
    -- Repair & Utility (item) ---------------------------------------------------
    {
        name = "Repair Bots",
        type = BUFF.SERVICE,
        detect = DETECT.CAST,
        triggers = {
            {item = 34113, spell = 44389}, -- Field Repair Bot 110G
            {item = 18232, spell = 22700}, -- Field Repair Bot 74A
            {item = 49040, spell = 67826} -- Jeeves
        }
    },
    {type = BUFF.SERVICE, detect = DETECT.CAST, triggers = {{item = 40768, spell = 54710}}}, -- MOLL-E
    {type = BUFF.SERVICE, detect = DETECT.CAST, triggers = {{item = 10725, spell = 23133}}}, -- Gnomish Battle Chicken
    {
        name = "Jumper Cables",
        type = BUFF.SOLO,
        detect = DETECT.CAST,
        triggers = {
            {item = 7148, spell = 8342}, -- Goblin Jumper Cables
            {item = 18587, spell = 22999}, -- Goblin Jumper Cables XL
            {item = 40772, spell = 54732} -- Gnomish Army Knife
        }
    }
}

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

Data.EMOTES = {
    {cmd = "CHEER", displayName = "/cheer", desc = L["EMOTE_CHEER_DESC"]},
    {cmd = "DRINK", displayName = "/drink", desc = L["EMOTE_DRINK_DESC"]},
    {cmd = "FLEX", displayName = "/flex", desc = L["EMOTE_FLEX_DESC"]},
    {cmd = "GRIN", displayName = "/grin", desc = L["EMOTE_GRIN_DESC"]},
    {cmd = "HIGHFIVE", displayName = "/highfive", desc = L["EMOTE_HIGHFIVE_DESC"]},
    {cmd = "PRAISE", displayName = "/praise", desc = L["EMOTE_PRAISE_DESC"]},
    {cmd = "SALUTE", displayName = "/salute", desc = L["EMOTE_SALUTE_DESC"]},
    {cmd = "SMILE", displayName = "/smile", desc = L["EMOTE_SMILE_DESC"]},
    {cmd = "THANK", displayName = "/thank", desc = L["EMOTE_THANK_DESC"]},
    {cmd = "WHOA", displayName = "/whoa", desc = L["EMOTE_WHOA_DESC"]},
    {cmd = "WINK", displayName = "/wink", desc = L["EMOTE_WINK_DESC"]},
    {cmd = "YES", displayName = "/yes", desc = L["EMOTE_YES_DESC"]}
}
