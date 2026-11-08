local ADDON_NAME, ns = ...
ns.L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
ns.Data = {}

local Data = ns.Data

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

--[[
    The client's own spell-link blue, verbatim. Not a palette role, so it is kept
    separate; the exact literal is preserved because ns.GetSpellLink hands it to
    SendChatMessage's hyperlink validator.
]]
ns.SPELL_LINK_COLOR = "71d5ff"

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
	GiveThanks = ADDON_NAME .. "_GiveThanks",
	EmotesList = ADDON_NAME .. "_EmotesList",
	IgnoredBuffs = ADDON_NAME .. "_IgnoredBuffs",
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

-- The Ignored Buffs rows' promote column, sized to hold "All Characters" without truncating.
ns.OPTIONS_PROMOTE_WIDTH = 0.9

--[[
    A tree panel's sidebar eats into the pane its rows are laid out in, so rows
    inside one spend a shorter budget than ns.OPTIONS_ROW_WIDTH. AceGUI's tree
    defaults to 175px; this is a hair wider, enough for a long realm name. The
    tree stays drag-resizable, and a drag wins over this seed.
]]
ns.OPTIONS_TREE_WIDTH = 180
ns.OPTIONS_TREE_ROW_WIDTH = 2.5

--[[
    The Ignored Buffs panel names one scope per list. Every scope but one is an
    AceDB char key ("Name - Realm", never localized), so the account-wide list
    needs a key no character can collide with -- hence the asterisks, which no
    character or realm name can contain.
]]
ns.LIST_SCOPE_GLOBAL = "**global**"

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
    time (see DefinePraiseDelaySelect in Options/Options-Give-Thanks.lua).
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

--[[
    The emote groups, in the order the Give Thanks panel lists them. Each
    flavor's Data/<Flavor>/Emote-Groups-<Flavor>.lua sorts its tokens into them.
]]
Data.EMOTE_GROUPS = { "Text", "Gesture", "Voice", "Pose" }

--[[
    The curated praise emotes: the ones Give Thanks starts with checked, and
    the whole list Thank You Button 1 offers. Only tokens: the client performs
    each emote and writes its line in the player's own language, so TFTB never
    carries a copy of that text.
]]
Data.EMOTES = {
	{ token = "CHEER" },
	{ token = "DRINK" },
	{ token = "FLEX" },
	{ token = "GRIN" },
	{ token = "HIGHFIVE" },
	{ token = "PRAISE" },
	{ token = "SALUTE" },
	{ token = "SMILE" },
	{ token = "THANK" },
	{ token = "WHOA" },
	{ token = "WINK" },
	-- Token is NOD: /yes is one of its command aliases, and no client has a YES token.
	{ token = "NOD" },
}
