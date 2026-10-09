local _, ns = ...

--[[
    Peer Pressure: the class cooldowns that sound
    the alert when ANOTHER player of YOUR class uses one.

    One row == one checkbox on the Peer Pressure panel:

        { "CLASS", { spell ids }, default }, -- Name

    CLASS        caster class token; a row only fires when it matches YOUR class.
    spell ids    every rank/variant the one toggle covers, shown under the first
                 live id's name. Ids missing on the running client are dropped at
                 login.
    default      1 seeds the checkbox checked, 0 unchecked. A user's own
                 checkbox choice is never overwritten.

    The name at the end of each row is a comment for humans; the panel pulls
    names, icons, and tooltips from the game. This file is deliberately
    self-contained data -- edit rows without touching any other file.
]]
ns.PEER_PRESSURE_ABILITIES = {
	-- Death Knight ------------------------------------------------------------
	{ "DEATHKNIGHT", { 42650 }, 1 }, -- Army of the Dead
	{ "DEATHKNIGHT", { 48743 }, 0 }, -- Death Pact
	{ "DEATHKNIGHT", { 47568 }, 1 }, -- Empower Rune Weapon
	{ "DEATHKNIGHT", { 48792 }, 0 }, -- Icebound Fortitude
	{ "DEATHKNIGHT", { 49039 }, 1 }, -- Lichborne
	{ "DEATHKNIGHT", { 61999 }, 1 }, -- Raise Ally
	{ "DEATHKNIGHT", { 49016 }, 1 }, -- Unholy Frenzy
	-- Druid ---------------------------------------------------------------------
	{ "DRUID", { 50334 }, 1 }, -- Berserk
	{ "DRUID", { 22842, 22895, 22896, 26999 }, 0 }, -- Frenzied Regeneration
	{ "DRUID", { 29166 }, 1 }, -- Innervate
	{ "DRUID", { 61336 }, 0 }, -- Survival Instincts
	-- Hunter --------------------------------------------------------------------
	{ "HUNTER", { 19574 }, 1 }, -- Bestial Wrath
	{ "HUNTER", { 34477 }, 1 }, -- Misdirection
	{ "HUNTER", { 3045 }, 1 }, -- Rapid Fire
	{ "HUNTER", { 23989 }, 1 }, -- Readiness
	-- Mage ----------------------------------------------------------------------
	{ "MAGE", { 12042 }, 1 }, -- Arcane Power
	{ "MAGE", { 11958 }, 1 }, -- Cold Snap (TBC/Wrath id; same id is Ice Block on Era)
	{ "MAGE", { 29977, 11129 }, 1 }, -- Combustion
	{ "MAGE", { 12051 }, 0 }, -- Evocation
	{ "MAGE", { 45438, 27619 }, 0 }, -- Ice Block (TBC/Wrath ids)
	{ "MAGE", { 12472 }, 1 }, -- Icy Veins (TBC/Wrath; same id is Cold Snap on Era)
	{ "MAGE", { 55342 }, 1 }, -- Mirror Image
	{ "MAGE", { 12043 }, 0 }, -- Presence of Mind
	-- Paladin -------------------------------------------------------------------
	{ "PALADIN", { 31821 }, 1 }, -- Aura Mastery
	{ "PALADIN", { 31884 }, 1 }, -- Avenging Wrath
	{ "PALADIN", { 20216 }, 0 }, -- Divine Favor
	{ "PALADIN", { 31842 }, 1 }, -- Divine Illumination
	{ "PALADIN", { 19752 }, 1 }, -- Divine Intervention
	{ "PALADIN", { 64205 }, 1 }, -- Divine Sacrifice
	{ "PALADIN", { 642, 1020, 63148 }, 1 }, -- Divine Shield
	{ "PALADIN", { 1022, 5599, 10278 }, 1 }, -- Hand of Protection
	{ "PALADIN", { 6940, 20729, 27147, 27148 }, 1 }, -- Hand of Sacrifice
	{ "PALADIN", { 1038 }, 1 }, -- Hand of Salvation (Wrath; same id is Blessing of Salvation before)
	{ "PALADIN", { 633, 2800, 10310, 27154, 48788 }, 1 }, -- Lay on Hands
	-- Priest --------------------------------------------------------------------
	{ "PRIEST", { 13908, 19236, 19238, 19240, 19241, 19242, 19243, 25437, 48172, 48173 }, 0 }, -- Desperate Prayer
	{ "PRIEST", { 47585 }, 0 }, -- Dispersion
	{ "PRIEST", { 64843 }, 1 }, -- Divine Hymn
	{ "PRIEST", { 6346 }, 1 }, -- Fear Ward
	{ "PRIEST", { 47788 }, 1 }, -- Guardian Spirit
	{ "PRIEST", { 64901 }, 1 }, -- Hymn of Hope
	{ "PRIEST", { 33206 }, 1 }, -- Pain Suppression
	{ "PRIEST", { 10060 }, 1 }, -- Power Infusion
	-- Rogue ---------------------------------------------------------------------
	{ "ROGUE", { 13750 }, 1 }, -- Adrenaline Rush
	{ "ROGUE", { 13877 }, 1 }, -- Blade Flurry
	{ "ROGUE", { 14177 }, 0 }, -- Cold Blood
	{ "ROGUE", { 5277, 26669 }, 0 }, -- Evasion
	{ "ROGUE", { 51690 }, 1 }, -- Killing Spree
	{ "ROGUE", { 14185 }, 1 }, -- Preparation
	{ "ROGUE", { 57934 }, 1 }, -- Tricks of the Trade
	{ "ROGUE", { 1856, 1857, 27617, 26889, 44290 }, 0 }, -- Vanish
	-- Shaman --------------------------------------------------------------------
	{ "SHAMAN", { 2825 }, 1 }, -- Bloodlust
	{ "SHAMAN", { 16166 }, 0 }, -- Elemental Mastery
	{ "SHAMAN", { 32182 }, 1 }, -- Heroism
	{ "SHAMAN", { 55198 }, 0 }, -- Tidal Force
	-- Warlock -------------------------------------------------------------------
	{ "WARLOCK", { 18708 }, 0 }, -- Fel Domination
	{ "WARLOCK", { 47241 }, 0 }, -- Metamorphosis
	-- Warrior -------------------------------------------------------------------
	{ "WARRIOR", { 12292 }, 1 }, -- Death Wish (Wrath id; same id is Sweeping Strikes before)
	{ "WARRIOR", { 55694 }, 0 }, -- Enraged Regeneration
	{ "WARRIOR", { 12975 }, 0 }, -- Last Stand
	{ "WARRIOR", { 1719 }, 1 }, -- Recklessness
	{ "WARRIOR", { 20230 }, 1 }, -- Retaliation
	{ "WARRIOR", { 871 }, 1 }, -- Shield Wall
}
