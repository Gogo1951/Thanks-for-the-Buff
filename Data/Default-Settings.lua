local _, ns = ...
local Data = ns.Data

--------------------------------------------------------------------------------
-- Default Emote Settings
--------------------------------------------------------------------------------

--[[
    `enabled` is explicit at every call site rather than defaulted, because the
    two answers are both real: the praise panels seed every emote on, the extra
    Thank You buttons seed every emote off.
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
		-- LibDBIcon's own table: the button's position, and `hide` for Enable Mini-map Button.
		minimap = {},
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
			emotesEnabled = true,
			soundEnabled = false,
			emotes = GetDefaultEmoteSettings(true),
		},
		slash = {
			createMacro = true,
			-- The texture file ID the macro wears: its own icon, or one from ns.THANK_YOU_MACRO_ICONS.
			macroIcon = Data.THANK_YOU_DEFAULT_ICON,
			message = ns.L["DEFAULT_WHISPER"],
			emotes = GetDefaultEmoteSettings(true),
		},
		--[[
		    Teammate Buffs (party/raid buffs & cooldowns cast on you) and Service
		    Alerts (no-aura raid help) each own their messaging settings, like
		    strangers above. The watched-buff list is shared (ids never overlap) and
		    seeds from the `received` defaults in this client's Tracked-Abilities file.
		    Teammates offers the same Praise Delay as strangers, but no cooldowns: a
		    teammate's cooldown is worth acknowledging every single time it lands.
		]]
		teammates = {
			-- Master switch for the whole panel. On by default, like strangers.
			enabled = true,
			printEnabled = true,
			whisperEnabled = true,
			praiseDelayEnabled = false,
			praiseDelay = 2,
			emotesEnabled = false,
			soundEnabled = false,
			emotes = GetDefaultEmoteSettings(true),
		},
		--[[
		    Services carries the same Praise Delay and sound as teammates, and no
		    cooldowns for the same reason. Its sound ships off: a feast or a portal
		    is ambient group help rather than something aimed at you, so it earns a
		    chat line by default and nothing louder.
		]]
		services = {
			-- Master switch for the whole panel. On by default, like teammates.
			enabled = true,
			printEnabled = true,
			whisperEnabled = false,
			praiseDelayEnabled = false,
			praiseDelay = 2,
			emotesEnabled = false,
			soundEnabled = false,
			emotes = GetDefaultEmoteSettings(true),
		},
		--[[
		    Good News: whispers for buffs YOU cast on other players.
		    `watched` is its own list (seeded from the `given` defaults in this
		    client's Tracked-Abilities file) because its ids are the same teammate buff
		    ids -- one shared table couldn't hold independent "thank for it" and
		    "announce it" choices.
		]]
		goodNews = {
			-- The panel's master switch. On by default, like teammates.
			whisperEnabled = true,
			--[[
			    Who gets the whisper: ALWAYS (anyone you buff) or GROUP (your
			    party/raid -- a battleground is a raid). Anything unrecognized
			    fails closed into the group check.
			]]
			scope = "ALWAYS",
			--[[
			    The editable body of the whisper. ONE token, %a, substituted by
			    ns:BuildGoodNewsMessage with the ability link plus -- for a short
			    enough buff -- its duration clause. That call also adds the star
			    marker (left off on WoW Forever) and the " // TFTB" sign-off, and
			    trims the body's closing punctuation; neither is editable.
			]]
			message = ns.L["DEFAULT_GOOD_NEWS"],
			watched = {},
		},
		--[[
		    Peer Pressure: alert when another player of your class pops
		    a cooldown from ns.PEER_PRESSURE_ABILITIES -- or you do, while triggerOnOwnCasts is on.
		    Self-only reactions, so they default on -- except own casts, which are
		    opt-in: you already know what you just pressed, and the point of the
		    feature is what everyone else is doing. The watched list seeds from
		    the default digits in this client's Peer-Pressure-Abilities file.
		]]
		peerPressure = {
			enabled = true,
			printEnabled = true,
			triggerOnOwnCasts = false,
			soundEnabled = true,
			watched = {},
		},
		--[[
		    Buff Window: the click-to-cast list of group members missing a buff
		    you can give. On by default, like Peer Pressure: it is self-only, and it
		    only appears when there is something you can fix. `audience` holds who
		    each buff is offered to (Data.BUFF_AUDIENCE), keyed by the row's first
		    single-target id, and seeds from the row defaults in this client's
		    Buff-Window-Spells file. `point` is nil until the window is first
		    dragged, and until then its top-left corner sits a little left of and
		    above the middle of the screen.
		]]
		buffWindow = {
			enabled = true,
			locked = false,
			hideInCombat = true,
			--[[
			    Minutes left under which a buff counts as missing; one of
			    Data.BUFF_WINDOW_REFRESH_CHOICES.
			]]
			refreshMinutes = 5,
			--[[
			    When each class, and pets (Data.TANK_WHEN_PET), take Tanks buffs
			    (Thorns) without a role of their own: one of Data.TANK_WHEN, keyed
			    by class token. A class with no entry is NEVER; the classes that
			    can fight in melee, and pets, start SOLO.
			]]
			tankWhen = {
				DRUID = "SOLO",
				PALADIN = "SOLO",
				ROGUE = "SOLO",
				SHAMAN = "SOLO",
				WARRIOR = "SOLO",
				PET = "SOLO",
			},
			--[[
			    The Self Buffs row's master switch, and when each self buff shows
			    (one of Data.SELF_REFRESH_CHOICES), keyed by the row's first rank
			    id and seeded from this client's BUFF_WINDOW_SELF_SPELLS defaults.
			]]
			selfEnabled = true,
			selfRefresh = {},
			--[[
			    Whether each poison or imbue is ticked for each hand, keyed
			    "ROGUE_MAIN" and so on, then by the BUFF_WINDOW_WEAPON_ENCHANTS
			    row's first id. Unset reads as ticked.
			]]
			weaponPicks = {},
			--[[
			    The Weapon Buffs switch, its one Reapply timing (one of
			    Data.WEAPON_REFRESH_CHOICES), and whether each oil, stone or
			    lure is ticked for each hand ("MAIN" or "OFF", then the item
			    id; unset reads as ticked).
			]]
			weaponEnabled = true,
			weaponRefresh = 3,
			weaponItems = {},
			favorEnabled = true,
			-- One of Data.BUFF_WINDOW_FAVOR_CHOICES.
			favorSeconds = 40,
			targetEnabled = true,
			audience = {},
		},
		watchedBuffs = {},
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
