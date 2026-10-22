local ADDON_NAME, ns = ...
ns.L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
ns.Data = {}

local Data = ns.Data
local L = ns.L

-- The SavedVariables global the TOC declares; Diagnostics dumps it by this name.
ns.SAVED_VARIABLES_NAME = "TFTBDB"

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

--[[
    Classes through Wrath only; DEATHKNIGHT is deliberate forward-prep for when
    Anniversary progresses (Era/TBC clients simply never look the key up).
]]
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

--[[
    Who a Buff Window buff is offered to, one choice per buff.
    BUFF_AUDIENCE_ORDER is the dropdown's order; the labels come from the locale
    (BUFF_WINDOW_AUDIENCE_*).
]]
Data.BUFF_AUDIENCE = {
	OFF = "OFF",
	TANK = "TANK",
	HEALER = "HEALER",
	ALL = "ALL",
}
Data.BUFF_AUDIENCE_ORDER = { "OFF", "TANK", "HEALER", "ALL" }

--[[
    Classes with nothing to gain from melee attack power, so a Buff Window row
    marked noCasters (Blessing of Might) skips them.
]]
Data.CASTER_CLASSES = {
	MAGE = true,
	PRIEST = true,
	WARLOCK = true,
}

-- Classes with no mana, so a Buff Window row marked manaOnly skips them.
Data.NO_MANA_CLASSES = {
	DEATHKNIGHT = true,
	ROGUE = true,
	WARRIOR = true,
}

--------------------------------------------------------------------------------
-- Options Registry
--------------------------------------------------------------------------------

-- Keys match each panel's file suffix.
ns.OPTIONS_REGISTRY = {
	General = ADDON_NAME .. "_General",
	StrangerBuffs = ADDON_NAME .. "_StrangerBuffs",
	TeammateBuffs = ADDON_NAME .. "_TeammateBuffs",
	TeammateBuffsTracked = ADDON_NAME .. "_TeammateBuffsTracked",
	SendGoodNews = ADDON_NAME .. "_SendGoodNews",
	SendGoodNewsTracked = ADDON_NAME .. "_SendGoodNewsTracked",
	ServiceAlerts = ADDON_NAME .. "_ServiceAlerts",
	ServiceAlertsTracked = ADDON_NAME .. "_ServiceAlertsTracked",
	PeerPressure = ADDON_NAME .. "_PeerPressure", -- TEMPORARY: see Options/Options-Peer-Pressure.lua
	ThankYouButton = ADDON_NAME .. "_ThankYouButton",
	BuffWindow = ADDON_NAME .. "_BuffWindow",
	BuffWindowBuffs = ADDON_NAME .. "_BuffWindowBuffs",
	BuffWindowSelfBuffs = ADDON_NAME .. "_BuffWindowSelfBuffs",
	BuffWindowWeaponBuffs = ADDON_NAME .. "_BuffWindowWeaponBuffs",
	Profiles = ADDON_NAME .. "_Profiles",
	FeedbackSupport = ADDON_NAME .. "_FeedbackSupport",
	Diagnostics = ADDON_NAME .. "_Diagnostics",
}

--------------------------------------------------------------------------------
-- Options Layout
--------------------------------------------------------------------------------

-- The label-beside-control grid: a label plus its control always total the row width.
ns.OPTIONS_ROW_WIDTH = 3.4
ns.OPTIONS_LABEL_WIDTH = 2.1
ns.OPTIONS_CONTROL_WIDTH = ns.OPTIONS_ROW_WIDTH - ns.OPTIONS_LABEL_WIDTH

--[[
    The same row inside an inline group (a class's box of buffs). The box insets
    its content 10 pixels -- in width units, where AceConfigDialog makes 1 unit
    170 pixels -- and its border takes room besides, so the label gives back 0.3
    or the control wraps under it. A row outside a box that should line up with
    the boxed ones below it uses the inset label width: same control, same x.
]]
ns.OPTIONS_INLINE_LABEL_WIDTH = ns.OPTIONS_LABEL_WIDTH - 0.3
ns.OPTIONS_INLINE_INSET_WIDTH = 10 / 170
ns.OPTIONS_ALIGNED_LABEL_WIDTH = ns.OPTIONS_INLINE_LABEL_WIDTH + ns.OPTIONS_INLINE_INSET_WIDTH

-- The item lists' remove column, sized to its icon rather than a caption.
ns.OPTIONS_REMOVE_ICON_WIDTH = 0.25

-- The blank cell a sub-option row leads with.
ns.OPTIONS_SUB_INDENT_WIDTH = 0.115

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

Data.SAFETY_PAUSE = 3

--[[
    SendChatMessage rejects a longer body outright, and the ceiling is bytes: a
    non-Latin locale spends 2-3 of them per character.
]]
ns.CHAT_MESSAGE_MAX_LENGTH = 255
--[[
    The Thank You buttons. One row each: the settings key it stores under, the
    macro it offers to create, and the slash command that macro runs.

    Everything else about a button -- its options section, its macro, its command
    -- is generated from this list, so the count is a property of the data.
    Button 1 keeps its "- Thank" macro name and its on-by-default settings; 2
    through 5 start switched off. Every name leads with a dash, so the whole
    family sorts together at the top of the macro list.
]]
Data.THANK_YOU_BUTTONS = {
	--[[
	    singleEmote: the button fires ONE chosen emote, picked from a dropdown,
	    instead of a random one from a checklist. It changes the stored shape too --
	    `emote` (a single token) rather than `emotes` (a set) -- which is what the
	    options panel and RunThankYou branch on. A button without it performs a
	    random emote from its checklist.
	]]
	{ profileKey = "slash", macroName = "- Thank", command = "/thankyou" },
	{ profileKey = "slash2", macroName = "- TFTB 2", command = "/thankyou2", singleEmote = true },
	{ profileKey = "slash3", macroName = "- TFTB 3", command = "/thankyou3", singleEmote = true },
	{ profileKey = "slash4", macroName = "- TFTB 4", command = "/thankyou4", singleEmote = true },
	{ profileKey = "slash5", macroName = "- TFTB 5", command = "/thankyou5", singleEmote = true },
}

-- The account-wide macro cap; TFTB stops creating Thank You macros once the list holds this many.
Data.MAX_GLOBAL_MACROS = 120

--[[
    The Thank You macros' own icon, a texture file ID (inv_misc_ribbon_01): the
    Icon dropdown's Default. ns.THANK_YOU_MACRO_ICONS holds the rest.
]]
Data.THANK_YOU_DEFAULT_ICON = 134411

--[[
    When a class, or pets, count as tanks on the Buff Window ("Count as
    Tanks"): NEVER, SOLO while you're not in a party or raid, or ALWAYS. Only
    for a player with no role of their own. TANK_WHEN_ORDER is the dropdown's
    order; the labels come from the locale (BUFF_WINDOW_TANKS_*). Pets are
    stored under TANK_WHEN_PET beside the class tokens.
]]
Data.TANK_WHEN = {
	NEVER = "NEVER",
	SOLO = "SOLO",
	ALWAYS = "ALWAYS",
}
Data.TANK_WHEN_ORDER = { "NEVER", "SOLO", "ALWAYS" }
Data.TANK_WHEN_PET = "PET"

--[[
    Where the Buff Window shows while Solo or In Group lets it show at all
    ("When to Show"): ALWAYS, or INSTANCE for inside a dungeon, raid,
    battleground or arena only. BUFF_WINDOW_WHERE_ORDER is the dropdown's
    order; the labels come from the locale (BUFF_WINDOW_WHERE_*).
]]
Data.BUFF_WINDOW_WHERE = {
	ALWAYS = "ALWAYS",
	INSTANCE = "INSTANCE",
}
Data.BUFF_WINDOW_WHERE_ORDER = { "ALWAYS", "INSTANCE" }

--[[
    When a self buff or the Soulstone shows on the Buff Window: OFF, MISSING
    (only once it's gone), or a number of minutes left. Doubles as the
    dropdown's order. The Weapon Buffs dropdown reuses MISSING for When
    Missing.
]]
Data.SELF_REFRESH_OFF = "OFF"
Data.SELF_REFRESH_MISSING = 0
Data.SELF_REFRESH_CHOICES = { "OFF", 0, 10, 5, 3 }

--[[
    The weapon hands a poison or imbue can go on, by the inventory slot each
    names. Which hands a class is offered is the data folder's call
    (BUFF_WINDOW_WEAPON_HANDS): a Classic Era shaman can't dual wield.
]]
Data.WEAPON_HAND_SLOTS = { MAIN = 16, OFF = 17 }
Data.WEAPON_HAND_ORDER = { "MAIN", "OFF" }

--[[
    The Weapon Buffs panel's one Reapply timing, for every poison, imbue,
    oil, stone and lure: When Missing, or minutes left. No Off: each choice
    has its own checkboxes for that.
]]
Data.WEAPON_REFRESH_CHOICES = { 0, 10, 5, 3 }
Data.WEAPON_REFRESH_DEFAULT = 3

-- The Weapon Buffs panel's boxes for the items any class can use, in order (BUFF_WINDOW_WEAPON_ITEMS' kind).
Data.WEAPON_ITEM_KINDS = { "OIL", "STONE", "LURE" }
-- A kind that only one hand can carry: a fishing pole is always two-handed, so a lure is main hand only.
Data.WEAPON_ITEM_KIND_HANDS = { LURE = { "MAIN" } }

--[[
    The Buff Window's "Refresh Under" choices, in minutes: a buff with
    less than this left is offered again.
]]
Data.BUFF_WINDOW_REFRESH_CHOICES = { 3, 5, 10 }

--[[
    How long a stranger who buffed you can stay on the Buff Window's Return the
    Favor list, in seconds (the player picks one), and how many of them it
    holds at once. Short on purpose: past a few seconds
    they have usually walked on.
]]
Data.BUFF_WINDOW_FAVOR_CHOICES = { 20, 40, 60 }
Data.BUFF_WINDOW_FAVOR_MAX = 5

-- The Buff Window's buff buttons, and the role icon in front of each name.
Data.BUFF_WINDOW_ICON_SIZE = 20

--[[
    Praise Delay lengths, in seconds. Doubles as the dropdown's display order; the
    labels themselves come from the client's own duration strings at panel-build
    time (see ns.DefinePraiseDelaySelect).
]]
Data.PRAISE_DELAY_CHOICES = { 1, 2, 3, 4 }

--[[
    The seconds scale behind the cooldown and duration dropdowns.

    Straight Fibonacci, and every entry is labelled in SECONDS -- 144 stays 144,
    not "2 Minutes". Mixing units inside one list makes two adjacent options look
    like different kinds of thing, and the reader has to convert to compare them.

    The point of the curve is resolution where the choice matters: the difference
    between 1 and 2 seconds is a real decision, the difference between 88 and 89
    is not.
]]
Data.SECONDS_CHOICES = { 0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144 }

--[[
    {rt1} Star, {rt2} Circle, {rt3} Diamond, {rt4} Triangle,
    {rt5} Moon, {rt6} Square, {rt7} Cross, {rt8} Skull
]]
ns.TARGET_MARKER = "{rt1}" -- Star

ns.LINKS = {
	CURSEFORGE = "https://www.curseforge.com/wow/addons/thanks-for-the-buff-revisited",
	GITHUB = "https://github.com/Gogo1951/Thanks-for-the-Buff",
	DISCORD = "https://discord.gg/eh8hKq992Q",
	WAGO = "https://addons.wago.io/addons/thanks-for-the-buff",
}
ns.CONTROL_FREAK_URL = "https://www.curseforge.com/wow/addons/control-freak" -- TEMPORARY: see Options/Options-Peer-Pressure.lua

--------------------------------------------------------------------------------
-- Tracking Codes
--------------------------------------------------------------------------------

-- How the thank-you reads, and which panel the toggle lives on.
Data.BUFF = {
	SOLO = "SOLO", -- cast on you            -> "gave you ..."        (Teammate Buffs)
	GROUP = "GROUP", -- party/raid-wide        -> "gave your group ..." (Teammate Buffs)
	SERVICE = "SERVICE", -- set out for the group  -> "set out a ..."       (Service Alerts)
}

-- How the combat log is matched.
Data.DETECT = {
	AURA = "AURA", -- SPELL_AURA_APPLIED lands on you
	CAST = "CAST", -- SPELL_CAST_SUCCESS fires
	--[[
	    SPELL_RESURRECT fires. For the ones that can FAIL: a cast succeeding only
	    means the attempt happened, so the cast event proves nothing worth saying.
	]]
	RESURRECT = "RESURRECT",
}

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

Data.EMOTES = {
	{ token = "CHEER", desc = L["EMOTE_CHEER_DESCRIPTION"] },
	{ token = "DRINK", desc = L["EMOTE_DRINK_DESCRIPTION"] },
	{ token = "FLEX", desc = L["EMOTE_FLEX_DESCRIPTION"] },
	{ token = "GRIN", desc = L["EMOTE_GRIN_DESCRIPTION"] },
	{ token = "HIGHFIVE", desc = L["EMOTE_HIGHFIVE_DESCRIPTION"] },
	{ token = "PRAISE", desc = L["EMOTE_PRAISE_DESCRIPTION"] },
	{ token = "SALUTE", desc = L["EMOTE_SALUTE_DESCRIPTION"] },
	{ token = "SMILE", desc = L["EMOTE_SMILE_DESCRIPTION"] },
	{ token = "THANK", desc = L["EMOTE_THANK_DESCRIPTION"] },
	{ token = "WHOA", desc = L["EMOTE_WHOA_DESCRIPTION"] },
	{ token = "WINK", desc = L["EMOTE_WINK_DESCRIPTION"] },
	-- Token is NOD: /yes is one of its command aliases, and no client has a YES token.
	{ token = "NOD", desc = L["EMOTE_YES_DESCRIPTION"] },
}
