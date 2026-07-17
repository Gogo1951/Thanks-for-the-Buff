local ADDON_NAME, ns = ...
ns.L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
ns.Data = {}

local Data = ns.Data
local L = ns.L

--------------------------------------------------------------------------------
-- Colors (UI Palette)
--------------------------------------------------------------------------------

--[[
    Raw hex palette only. The derived COLORS table (with the |cff escape prefix)
    and the ns.GetColor accessor live in Features/Utilities.lua, because data
    files hold no logic.
]]
ns.PALETTE = {
	TITLE = "FFD100", -- Gold: Titles, Headers, Section Names, Field Titles
	INFO = "00BBFF", -- Blue: Interactions, Toggles, Links, Keybinds, Slash Commands
	BODY = "FFFFFF", -- White: Descriptions, Options Body Text
	HELP = "CCCCCC", -- Silver: Pro Tips, Helper Text
	TEXT = "FFFFFF", -- White: Messages, Values, Spell Names
	ON = "33CC33", -- Green: On
	OFF = "CC3333", -- Red: Off
	SEPARATOR = "AAAAAA", -- Gray: Separators, Dividers
	MUTED = "808080", -- Dark Gray: Meta-data, Version Numbers
}

--------------------------------------------------------------------------------
-- Class Colors
--------------------------------------------------------------------------------

-- Classes through Wrath only; DEATHKNIGHT is deliberate forward-prep for when
-- Anniversary progresses (Era/TBC clients simply never look the key up).
Data.CLASS_COLORS = {
	DEATHKNIGHT = "C41E3A",
	DRUID = "FF7C0A",
	HUNTER = "AAD372",
	MAGE = "3FC7EB",
	PALADIN = "F48CBA",
	PRIEST = "FFFFFF",
	ROGUE = "FFF468",
	SHAMAN = "0070DD",
	WARLOCK = "8788EE",
	WARRIOR = "C69B6D",
}

--------------------------------------------------------------------------------
-- Options Registry
--------------------------------------------------------------------------------

ns.OPTIONS_REGISTRY = {
	General = ADDON_NAME,
	Strangers = ADDON_NAME .. "_Strangers",
	Teammates = ADDON_NAME .. "_Teammates",
	Services = ADDON_NAME .. "_Services",
	GoodNews = ADDON_NAME .. "_GoodNews",
	PeerPressure = ADDON_NAME .. "_PeerPressure",
	ThankYou = ADDON_NAME .. "_ThankYou",
	Profiles = ADDON_NAME .. "_Profiles",
	Diagnostics = ADDON_NAME .. "_Diagnostics",
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
Data.WAGO_URL = "https://addons.wago.io/addons/thanks-for-the-buff"

--------------------------------------------------------------------------------
-- Tracking Codes
--------------------------------------------------------------------------------

-- How the thank-you reads, and which panel the toggle lives on.
Data.BUFF = {
	SOLO = "SOLO", -- cast on you            -> "gave you ..."        (Buffs from Teammates)
	GROUP = "GROUP", -- party/raid-wide        -> "gave your group ..." (Buffs from Teammates)
	SERVICE = "SERVICE", -- set out for the group  -> "set out a ..."       (Group Services)
}

-- How the combat log is matched.
Data.DETECT = {
	AURA = "AURA", -- SPELL_AURA_APPLIED lands on you
	CAST = "CAST", -- SPELL_CAST_SUCCESS fires
}

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

Data.EMOTES = {
	{ cmd = "CHEER", displayName = "/cheer", desc = L["EMOTE_CHEER_DESC"] },
	{ cmd = "DRINK", displayName = "/drink", desc = L["EMOTE_DRINK_DESC"] },
	{ cmd = "FLEX", displayName = "/flex", desc = L["EMOTE_FLEX_DESC"] },
	{ cmd = "GRIN", displayName = "/grin", desc = L["EMOTE_GRIN_DESC"] },
	{ cmd = "HIGHFIVE", displayName = "/highfive", desc = L["EMOTE_HIGHFIVE_DESC"] },
	{ cmd = "PRAISE", displayName = "/praise", desc = L["EMOTE_PRAISE_DESC"] },
	{ cmd = "SALUTE", displayName = "/salute", desc = L["EMOTE_SALUTE_DESC"] },
	{ cmd = "SMILE", displayName = "/smile", desc = L["EMOTE_SMILE_DESC"] },
	{ cmd = "THANK", displayName = "/thank", desc = L["EMOTE_THANK_DESC"] },
	{ cmd = "WHOA", displayName = "/whoa", desc = L["EMOTE_WHOA_DESC"] },
	{ cmd = "WINK", displayName = "/wink", desc = L["EMOTE_WINK_DESC"] },
	{ cmd = "YES", displayName = "/yes", desc = L["EMOTE_YES_DESC"] },
}
