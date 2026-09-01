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
-- Options Layout
--------------------------------------------------------------------------------

-- The label-beside-control grid: a label plus its control always total the row width.
ns.OPTIONS_ROW_WIDTH = 2.6
ns.OPTIONS_LABEL_WIDTH = 1.3
ns.OPTIONS_CONTROL_WIDTH = ns.OPTIONS_ROW_WIDTH - ns.OPTIONS_LABEL_WIDTH

-- The item lists' remove column, sized to its icon rather than a caption.
ns.OPTIONS_REMOVE_ICON_WIDTH = 0.25

-- The blank cell a sub-option row leads with.
ns.OPTIONS_SUB_INDENT_WIDTH = 0.115

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

Data.SAFETY_PAUSE = 3

-- SendChatMessage rejects a longer body outright, and the ceiling is bytes: a
-- non-Latin locale spends 2-3 of them per character.
ns.CHAT_MESSAGE_MAX_LENGTH = 255
--[[
    The Thank You buttons. One row each: the settings key it stores under, the
    macro it offers to create, and the slash command that macro runs.

    Everything else about a button -- its options section, its macro, its command
    -- is generated from this list, so the count is a property of the data rather
    than of five copied blocks. Button 1 is the original and keeps its "- Thank"
    macro name (the leading dash sorts it to the top of the macro list) and its
    on-by-default settings; 2 through 5 were added later and start switched off,
    so nobody's existing behaviour changes. They share the leading-dash naming so
    the whole family sorts together at the top of the macro list.
]]
Data.THANK_YOU_BUTTONS = {
	-- singleEmote: the button fires ONE chosen emote, picked from a dropdown,
	-- instead of a random one from a checklist. It changes the stored shape too --
	-- `emote` (a single token) rather than `emotes` (a set) -- which is what the
	-- options panel and RunThankYou branch on. Button 1 keeps the original
	-- pick-a-random-one-from-your-selection behaviour.
	{ profileKey = "slash", macroName = "- Thank", command = "/thankyou" },
	{ profileKey = "slash2", macroName = "- TFTB 2", command = "/thankyou2", singleEmote = true },
	{ profileKey = "slash3", macroName = "- TFTB 3", command = "/thankyou3", singleEmote = true },
	{ profileKey = "slash4", macroName = "- TFTB 4", command = "/thankyou4", singleEmote = true },
	{ profileKey = "slash5", macroName = "- TFTB 5", command = "/thankyou5", singleEmote = true },
}

-- Praise Delay lengths, in seconds. Doubles as the dropdown's display order; the
-- labels themselves come from the client's own duration strings at panel-build
-- time (see ns.DefinePraiseDelaySelect).
Data.PRAISE_DELAY_CHOICES = { 1, 2, 3, 4 }

--[[
    The seconds scale behind the cooldown and duration dropdowns.

    Straight Fibonacci, and every entry is labelled in SECONDS -- 144 stays 144,
    not "2 Minutes". Mixing units inside one list makes two adjacent options look
    like different kinds of thing, and the reader has to convert to compare them.

    The point of the curve is resolution where the choice matters: the difference
    between 1 and 2 seconds is a real decision, the difference between 88 and 89
    is not, and a slider spent 145 steps pretending otherwise.
]]
Data.SECONDS_CHOICES = { 0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144 }

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
	-- SPELL_RESURRECT fires. For the ones that can FAIL: a cast succeeding only
	-- means the attempt happened, so the cast event proves nothing worth saying.
	RESURRECT = "RESURRECT",
}

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

Data.EMOTES = {
	{ cmd = "CHEER", displayName = "/cheer", desc = L["EMOTE_CHEER_DESCRIPTION"] },
	{ cmd = "DRINK", displayName = "/drink", desc = L["EMOTE_DRINK_DESCRIPTION"] },
	{ cmd = "FLEX", displayName = "/flex", desc = L["EMOTE_FLEX_DESCRIPTION"] },
	{ cmd = "GRIN", displayName = "/grin", desc = L["EMOTE_GRIN_DESCRIPTION"] },
	{ cmd = "HIGHFIVE", displayName = "/highfive", desc = L["EMOTE_HIGHFIVE_DESCRIPTION"] },
	{ cmd = "PRAISE", displayName = "/praise", desc = L["EMOTE_PRAISE_DESCRIPTION"] },
	{ cmd = "SALUTE", displayName = "/salute", desc = L["EMOTE_SALUTE_DESCRIPTION"] },
	{ cmd = "SMILE", displayName = "/smile", desc = L["EMOTE_SMILE_DESCRIPTION"] },
	{ cmd = "THANK", displayName = "/thank", desc = L["EMOTE_THANK_DESCRIPTION"] },
	{ cmd = "WHOA", displayName = "/whoa", desc = L["EMOTE_WHOA_DESCRIPTION"] },
	{ cmd = "WINK", displayName = "/wink", desc = L["EMOTE_WINK_DESCRIPTION"] },
	-- Token is NOD, not YES: /yes is one of NOD's command aliases, and there is no
	-- YES token on any client (verified against a full EMOTE<n>_TOKEN dump). The
	-- displayName stays /yes because that is the command players know.
	{ cmd = "NOD", displayName = "/yes", desc = L["EMOTE_YES_DESCRIPTION"] },
}
