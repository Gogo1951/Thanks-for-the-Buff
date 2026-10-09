local _, ns = ...

-- [constant] = spell id, -- Spell Name
ns.GAME_IDS = {
	SAMPLE_GOOD_NEWS_SPELL_ID = 10060, -- Power Infusion
	SAMPLE_PEER_PRESSURE_SPELL_ID = 13877, -- Blade Flurry
}

--[[
How We Got the Data

Last Validated
	2026-10-08, WoW Forever 1.60.1.70291

Notes
	- Spell IDs that feature code needs by name rather than from a list: the sample spells the options panels use for their preview messages.
	- SAMPLE_GOOD_NEWS_SPELL_ID (Power Infusion) is the spell linked in the Good News sample whisper (Options/Options-Send-Good-News.lua).
	- SAMPLE_PEER_PRESSURE_SPELL_ID (Blade Flurry) is the cooldown in the Peer Pressure sample alert (Options/Options-Peer-Pressure.lua). It must be a rogue spell, since the sample names a rogue.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	None.
]]
