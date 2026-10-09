local _, ns = ...

-- { class, { spell ids }, default }, -- Name
ns.PEER_PRESSURE_ABILITIES = {
	-- Druid ---------------------------------------------------------------------
	{ "DRUID", { 417141 }, 1 }, -- Berserk (Forever talent id)
	{ "DRUID", { 22842 }, 0 }, -- Frenzied Regeneration
	{ "DRUID", { 29166 }, 1 }, -- Innervate
	-- Hunter --------------------------------------------------------------------
	{ "HUNTER", { 19574 }, 1 }, -- Bestial Wrath
	{ "HUNTER", { 3045 }, 1 }, -- Rapid Fire
	{ "HUNTER", { 23989 }, 1 }, -- Readiness
	-- Mage ----------------------------------------------------------------------
	{ "MAGE", { 12042 }, 1 }, -- Arcane Power
	{ "MAGE", { 12472 }, 1 }, -- Cold Snap
	{ "MAGE", { 11129 }, 1 }, -- Combustion
	{ "MAGE", { 12051 }, 0 }, -- Evocation
	{ "MAGE", { 11958 }, 0 }, -- Ice Block
	{ "MAGE", { 12043 }, 0 }, -- Presence of Mind
	-- Paladin -------------------------------------------------------------------
	{ "PALADIN", { 1022, 5599, 10278 }, 1 }, -- Blessing of Protection
	{ "PALADIN", { 6940, 20729 }, 1 }, -- Blessing of Sacrifice
	{ "PALADIN", { 20216 }, 0 }, -- Divine Favor
	{ "PALADIN", { 19752 }, 1 }, -- Divine Intervention
	{ "PALADIN", { 642, 1020 }, 1 }, -- Divine Shield
	{ "PALADIN", { 633, 2800, 10310 }, 1 }, -- Lay on Hands
	-- Priest --------------------------------------------------------------------
	{ "PRIEST", { 1277462, 1277634, 1277638, 1277639, 1277640 }, 1 }, -- Contingency Plan (Forever)
	{ "PRIEST", { 13908, 19236, 19238, 19240, 19241, 19242, 19243 }, 0 }, -- Desperate Prayer
	{ "PRIEST", { 6346 }, 1 }, -- Fear Ward
	{ "PRIEST", { 10060 }, 1 }, -- Power Infusion
	-- Rogue ---------------------------------------------------------------------
	{ "ROGUE", { 13750 }, 1 }, -- Adrenaline Rush
	{ "ROGUE", { 13877 }, 1 }, -- Blade Flurry
	{ "ROGUE", { 14177 }, 0 }, -- Cold Blood
	{ "ROGUE", { 5277 }, 0 }, -- Evasion
	{ "ROGUE", { 14185 }, 1 }, -- Preparation
	{ "ROGUE", { 1856, 1857, 27617 }, 0 }, -- Vanish
	-- Warlock -------------------------------------------------------------------
	{ "WARLOCK", { 18708 }, 0 }, -- Fel Domination
	-- Warrior -------------------------------------------------------------------
	{ "WARRIOR", { 12328 }, 1 }, -- Death Wish
	{ "WARRIOR", { 12975 }, 0 }, -- Last Stand
	{ "WARRIOR", { 1719 }, 1 }, -- Recklessness
	{ "WARRIOR", { 20230 }, 1 }, -- Retaliation
	{ "WARRIOR", { 871 }, 1 }, -- Shield Wall
}

--[[
How We Got the Data

Last Validated
	2026-10-08, WoW Forever 1.60.1.70291

Notes
	- The class cooldowns that sound the Peer Pressure alert when another player of your class uses one, or when you do while the own-casts option is on. Hand-picked, not queried.
	- One row is one checkbox on the Peer Pressure panel. The name after each row is for people; the panel takes names, icons and tooltips from the game.
	- class is the caster's class token. A row fires only when it matches your class.
	- spell ids are every rank or variant the one toggle covers, shown under the first live ID's name. IDs missing on the running client are dropped at login (BuildLookup in Features/Peer-Pressure.lua).
	- default is 1 to start the checkbox on, 0 off. A player's own choice is never overwritten.
	- Berserk is the Forever talent's ID, and Contingency Plan exists only on WoW Forever.
	- The file is self-contained: edit rows here without touching any other file.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	None.
]]
