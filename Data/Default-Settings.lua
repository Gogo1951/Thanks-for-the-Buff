local _, ns = ...
local Data = ns.Data

--------------------------------------------------------------------------------
-- Default Emote Settings
--------------------------------------------------------------------------------

--[[
    `enabled` is explicit at every call site rather than defaulted, because the
    two answers are both real: Give Thanks and the first Thank You button seed
    every emote on, the extra Thank You buttons seed every emote off.
]]
local function GetDefaultEmoteSettings(enabled)
	local emotes = {}
	for _, data in ipairs(Data.EMOTES) do
		emotes[data.token] = enabled and true or false
	end
	return emotes
end

--------------------------------------------------------------------------------
-- Database Defaults
--------------------------------------------------------------------------------

--[[
    The AceDB-3.0 defaults table. Every user setting lives under `profile` -- the
    shared Default profile holds the whole database. AceDB applies these itself,
    copying them into the saved table and preserving an explicit false, so there is
    no hand-rolled merge.
]]
ns.DATABASE_DEFAULTS = {
	profile = {
		showWelcome = true,
		--[[
            Praise (the outgoing whisper and emote) carries its own throttles here:
            `praiseCooldown` is the gap between any two praises whoever buffed you,
            `cooldown` the gap between two praises of the SAME player. The overall
            one ships at 0 (off), so out of the box only the per-source limit
            applies. `praiseDelay` is only read while `praiseDelayEnabled` is set,
            and its values are the ones the dropdown offers (Data.PRAISE_DELAY_CHOICES).
        ]]
		strangers = {
			--[[
			    Master switch for the whole panel. On by default: turning the add-on
			    on and getting nothing would read as broken.
			]]
			enabled = true,
			printEnabled = false,
			whisperEnabled = false,
			-- What the thank-you whisper says; "{spell}" becomes the buff's link.
			whisperMessage = ns.L["DEFAULT_GIVE_THANKS_WHISPER"],
			praiseDelayEnabled = false,
			praiseDelay = 2,
			praiseCooldown = 0,
			cooldown = 3,
			--[[
			    21, not 25: the nearest step on Data.SECONDS_CHOICES. A default that
			    is not on the scale would show up snapped anyway, so storing the
			    snapped value keeps what is saved and what is shown identical.
			]]
			minBuffDuration = 21,
			soundEnabled = false,
			--[[
			    Any client emote, not just the curated defaults: a token set true is
			    one the random pick can land on. A curated default unticked is stored
			    as false, so AceDB does not fill it back in.
			]]
			emotes = GetDefaultEmoteSettings(true),
		},
		slash = {
			createMacro = true,
			-- The texture file ID the macro wears: its own icon, or one from ns.THANK_YOU_MACRO_ICONS.
			macroIcon = Data.THANK_YOU_DEFAULT_ICON,
			message = ns.L["DEFAULT_WHISPER"],
			emotes = GetDefaultEmoteSettings(true),
		},
	},
	--[[
	    Ignored Buffs live outside the profile, the way Magic Eraser's Erase List
	    does: an All Characters list in global and each character's own list in
	    char, both [spellId] = true. A profile switch or reset never touches them.
	    classToken is saved at every login so the panel's tree can show any
	    character on the account in its class color.
	]]
	char = {
		ignoredBuffs = {},
		classToken = false,
	},
	global = {
		ignoredBuffs = {},
	},
}

--[[
    The extra Thank You buttons, generated from Data.THANK_YOU_BUTTONS rather
    than written out, so adding a sixth is a row in that list and nothing here.

    Button 1 is skipped: its `slash` defaults are declared above and are on by
    default. Every later button starts fully switched off -- no macro, no
    whisper text, no emotes -- and only does something once its owner has
    filled it in. An empty message sends no whisper and an all-false emote
    table performs no emote, so "off" needs no guard of its own. Each starts on
    the icon in this client's ns.THANK_YOU_MACRO_ICONS that names its button,
    so the macros tell apart on a bar, or on the default icon where none does.
]]
local startingIcons = {}
for _, icon in ipairs(ns.THANK_YOU_MACRO_ICONS) do
	if icon[2] then
		startingIcons[icon[2]] = icon[1]
	end
end

for index = 2, #Data.THANK_YOU_BUTTONS do
	local button = Data.THANK_YOU_BUTTONS[index]
	local buttonDefaults = {
		createMacro = false,
		message = "",
		macroIcon = startingIcons[index] or Data.THANK_YOU_DEFAULT_ICON,
	}
	if button.singleEmote then
		--[[
		    One chosen token, "" meaning none. A checklist would be the wrong shape:
		    there is nothing to choose randomly between.
		]]
		buttonDefaults.emote = ""
	else
		buttonDefaults.emotes = GetDefaultEmoteSettings(false)
	end
	ns.DATABASE_DEFAULTS.profile[button.profileKey] = buttonDefaults
end
