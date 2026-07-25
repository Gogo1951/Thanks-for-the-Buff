local _, ns = ...
local Data = ns.Data

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
-- Database Defaults
--------------------------------------------------------------------------------

--[[
    The AceDB-3.0 defaults table. Every user setting lives under `profile`; AceDB
    applies these via metatables (no hand-rolled merge). `global` is reserved for
    profile-independent, account-wide state -- this add-on has no minimap button,
    so it stays empty.
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
			printEnabled = false,
			whisperEnabled = false,
			praiseDelayEnabled = false,
			praiseDelay = 2,
			praiseCooldown = 0,
			cooldown = 3,
			minBuffDuration = 25,
			emotesEnabled = true,
			soundEnabled = false,
			emotes = GetDefaultEmoteSettings(),
		},
		slash = {
			createMacro = true,
			message = ns.L["DEFAULT_WHISPER"],
			emotes = GetDefaultEmoteSettings(),
		},
		-- Buffs from Teammates (party/raid buffs & cooldowns cast on you) and Group
		-- Services (no-aura raid help) each own their messaging settings, like
		-- strangers above. The watched-buff list is shared (ids never overlap) and
		-- seeds from the per-flavor `received` columns in Data/Tracked-Abilities.lua.
		-- Teammates offers the same Praise Delay as strangers, but no cooldowns: a
		-- teammate's cooldown is worth acknowledging every single time it lands.
		teammates = {
			printEnabled = true,
			whisperEnabled = true,
			praiseDelayEnabled = false,
			praiseDelay = 2,
			emotesEnabled = false,
			soundEnabled = false,
			emotes = GetDefaultEmoteSettings(),
		},
		-- Services carries the same Praise Delay and sound as teammates, and no
		-- cooldowns for the same reason. Its sound ships off: a feast or a portal
		-- is ambient group help rather than something aimed at you, so it earns a
		-- chat line by default and nothing louder.
		services = {
			printEnabled = true,
			whisperEnabled = false,
			praiseDelayEnabled = false,
			praiseDelay = 2,
			emotesEnabled = false,
			soundEnabled = false,
			emotes = GetDefaultEmoteSettings(),
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
	global = {},
}
