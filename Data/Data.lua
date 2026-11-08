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
    Classes through Mists, so the table is the same on every flavor: a client
    without Death Knights or Monks simply never looks those keys up.
]]
Data.CLASS_COLORS = {
	DEATHKNIGHT = "C41E3A",
	DRUID = "FF7C0A",
	HUNTER = "AAD372",
	MAGE = "3FC7EB",
	MONK = "00FF98",
	PALADIN = "F48CBA",
	PRIEST = "FFFFFF",
	ROGUE = "FFF468",
	SHAMAN = "0070DD",
	WARLOCK = "8788EE",
	WARRIOR = "C69B6D",
}

--------------------------------------------------------------------------------
-- Example Lines
--------------------------------------------------------------------------------

-- The house roster the Example lines name, keyed by class token.
ns.SAMPLE_NAMES = {
	HUNTER = "Spek",
	PRIEST = "Katz",
	ROGUE = "Fathom",
	DRUID = "Aero",
	WARRIOR = "Prima",
	WARLOCK = "Greasy",
	PALADIN = "Aiek",
	MAGE = "Portalrico",
	SHAMAN = "Moondragon",
}

--------------------------------------------------------------------------------
-- Options Registry
--------------------------------------------------------------------------------

-- Keys match each panel's file suffix.
ns.OPTIONS_REGISTRY = {
	General = ADDON_NAME .. "_General",
	StrangerBuffs = ADDON_NAME .. "_StrangerBuffs",
	ThankYouButton = ADDON_NAME .. "_ThankYouButton",
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
ns.OPTIONS_REMOVE_ICON_WIDTH = 0.25 -- the item lists' remove column, sized to its icon
ns.OPTIONS_SUB_INDENT_WIDTH = 0.115 -- the blank cell a sub-option row leads with

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
    Praise Delay lengths, in seconds. Doubles as the dropdown's display order; the
    labels themselves come from the client's own duration strings at panel-build
    time (see DefinePraiseDelaySelect in Options/Options-Stranger-Buffs.lua).
]]
Data.PRAISE_DELAY_CHOICES = { 1, 2, 3, 4 }

--[[
    The seconds scale behind the cooldown and duration dropdowns.

    Straight Fibonacci, and every entry is labeled in SECONDS -- 144 stays 144,
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

-- Good to Go, the add-on several former TFTB features moved to.
ns.GOOD_TO_GO_LINKS = {
	CURSEFORGE = "https://www.curseforge.com/wow/addons/good-to-go",
	WAGO = "https://addons.wago.io/addons/good-to-go",
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
