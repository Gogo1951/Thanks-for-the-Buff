local _, ns = ...
local Data = ns.Data

--------------------------------------------------------------------------------
-- Default Emote Settings
--------------------------------------------------------------------------------

-- `enabled` is explicit at every call site rather than defaulted, because the
-- two answers are both real: the praise panels seed every emote on, the extra
-- Thank You buttons seed every emote off.
local function GetDefaultEmoteSettings(enabled)
	local emotes = {}
	for _, data in ipairs(Data.EMOTES) do
		emotes[data.cmd] = enabled and true or false
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
			-- Master switch for the whole panel. On by default: turning the add-on
			-- on and getting nothing would read as broken.
			enabled = true,
			printEnabled = false,
			whisperEnabled = false,
			praiseDelayEnabled = false,
			praiseDelay = 2,
			praiseCooldown = 0,
			cooldown = 3,
			-- 21, not 25: the nearest step on Data.SECONDS_CHOICES. A default that
			-- is not on the scale would show up snapped anyway, so storing the
			-- snapped value keeps what is saved and what is shown identical.
			minBuffDuration = 21,
			emotesEnabled = true,
			soundEnabled = false,
			emotes = GetDefaultEmoteSettings(true),
		},
		slash = {
			createMacro = true,
			message = ns.L["DEFAULT_WHISPER"],
			emotes = GetDefaultEmoteSettings(true),
		},
		-- Buffs from Teammates (party/raid buffs & cooldowns cast on you) and Group
		-- Services (no-aura raid help) each own their messaging settings, like
		-- strangers above. The watched-buff list is shared (ids never overlap) and
		-- seeds from the per-flavor `received` columns in Data/Tracked-Abilities.lua.
		-- Teammates offers the same Praise Delay as strangers, but no cooldowns: a
		-- teammate's cooldown is worth acknowledging every single time it lands.
		teammates = {
			-- Master switch for the whole panel. On by default: turning the add-on
			-- on and getting nothing would read as broken.
			enabled = true,
			printEnabled = true,
			whisperEnabled = true,
			praiseDelayEnabled = false,
			praiseDelay = 2,
			emotesEnabled = false,
			soundEnabled = false,
			emotes = GetDefaultEmoteSettings(true),
		},
		-- Services carries the same Praise Delay and sound as teammates, and no
		-- cooldowns for the same reason. Its sound ships off: a feast or a portal
		-- is ambient group help rather than something aimed at you, so it earns a
		-- chat line by default and nothing louder.
		services = {
			-- Master switch for the whole panel. On by default: turning the add-on
			-- on and getting nothing would read as broken.
			enabled = true,
			printEnabled = true,
			whisperEnabled = false,
			praiseDelayEnabled = false,
			praiseDelay = 2,
			emotesEnabled = false,
			soundEnabled = false,
			emotes = GetDefaultEmoteSettings(true),
		},
		-- Good News: whispers for buffs YOU cast on other players.
		-- `watched` is its own list (seeded from the per-flavor `given` columns in
		-- Data/Tracked-Abilities.lua) because its ids are the same teammate buff
		-- ids -- one shared table couldn't hold independent "thank for it" and
		-- "announce it" choices.
		goodNews = {
			whisperEnabled = true,
			-- Who gets the whisper: ALWAYS (anyone you buff) or GROUP (your
			-- party/raid -- a battleground is a raid). Anything unrecognized
			-- fails closed into the group check.
			scope = "ALWAYS",
			-- The editable body of the whisper. ONE token, %a, substituted by
			-- ns:BuildGoodNewsMessage with the ability link plus -- for a short
			-- enough buff -- its duration clause. That call also adds the star
			-- marker and "TFTB // " prefix; neither is editable.
			message = ns.L["DEFAULT_GOOD_NEWS"],
			watched = {},
		},
		-- Peer Pressure: alert when another player of your class pops
		-- a cooldown from Data.PEER_PRESSURE -- or you do, while triggerOnOwnCasts is on.
		-- Self-only reactions, so they default on -- except own casts, which are
		-- opt-in: you already know what you just pressed, and the point of the
		-- feature is what everyone else is doing. The watched list seeds from
		-- the per-flavor digits in Data/Peer-Pressure-Abilities.lua.
		peerPressure = {
			enabled = true,
			printEnabled = true,
			triggerOnOwnCasts = false,
			soundEnabled = true,
			watched = {},
		},
		watchedBuffs = {},
	},
}

--[[
    The extra Thank You buttons, generated from Data.THANK_YOU_BUTTONS rather
    than written out, so adding a sixth is a row in that list and nothing here.

    Button 1 is skipped: its `slash` defaults are declared above and are the
    original on-by-default ones. Every later button starts fully switched off --
    no macro, no whisper text, no emotes -- so a fresh install behaves exactly as
    it did before they existed, and each one only does something once its owner
    has filled it in. An empty message sends no whisper and an all-false emote
    table performs no emote, both by existing logic, so "off" needs no new guard.
]]
for index = 2, #Data.THANK_YOU_BUTTONS do
	local button = Data.THANK_YOU_BUTTONS[index]
	local buttonDefaults = { createMacro = false, message = "" }
	if button.singleEmote then
		-- One chosen token, "" meaning none. A checklist would be the wrong shape:
		-- there is nothing to choose randomly between.
		buttonDefaults.emote = ""
	else
		buttonDefaults.emotes = GetDefaultEmoteSettings(false)
	end
	ns.DATABASE_DEFAULTS.profile[button.profileKey] = buttonDefaults
end
