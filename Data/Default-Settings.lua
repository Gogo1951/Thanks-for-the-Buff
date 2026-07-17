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
		strangers = {
			printEnabled = false,
			whisperEnabled = false,
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
		teammates = {
			printEnabled = true,
			whisperEnabled = true,
			emotesEnabled = false,
			soundEnabled = false,
			emotes = GetDefaultEmoteSettings(),
		},
		services = {
			printEnabled = true,
			whisperEnabled = false,
			emotesEnabled = false,
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
		-- Self-only reactions, so everything defaults on; the watched list
		-- seeds from the per-flavor digits in Data/Peer-Pressure-Abilities.lua.
		peerPressure = {
			enabled = true,
			printEnabled = true,
			triggerOnOwnCasts = true,
			soundEnabled = true,
			watched = {},
		},
		watchedBuffs = {},
	},
	global = {},
}
