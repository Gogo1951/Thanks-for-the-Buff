local _, ns = ...

-- [constant] = spell id, -- Spell Name
ns.GAME_IDS = {
	PHASE_SHIFT_SPELL_ID = 4511, -- Phase Shift
	SAMPLE_BUFF_SPELL_ID = 1459, -- Arcane Intellect
	SAMPLE_GOOD_NEWS_SPELL_ID = 10060, -- Power Infusion
	SAMPLE_SERVICE_SPELL_ID = 10059, -- Portal: Stormwind
}

-- { texture file ID, button it starts on }, -- Icon File Name
ns.THANK_YOU_MACRO_ICONS = {
	{ 135453, 2 }, -- inv_valentinescard01
	{ 134141, 3 }, -- inv_misc_gift_02
	{ 134927, 4 }, -- inv_rosebouquet01
	{ 133783, 5 }, -- inv_misc_celebrationcake_01
	{ 135767 }, -- spell_brokenheart
	{ 133939 }, -- inv_misc_flower_02
	{ 135263 }, -- inv_summerfest_fireflower
	{ 133196 }, -- inv_holiday_beerfestpretzel01
	{ 133201 }, -- inv_holiday_brewfestbuff_01
	{ 134505 }, -- inv_misc_toy_01
	{ 135448 }, -- inv_valentinepinkrocket
	{ 132387 }, -- inv_ammo_snowball
	{ 133785 }, -- inv_misc_coin_02
	{ 134237 }, -- inv_misc_key_03
	{ 133471 }, -- inv_letter_15
	{ 134481 }, -- inv_misc_ticket_darkmoon_01
	{ 134333 }, -- inv_misc_orb_01
	{ 133730 }, -- inv_misc_bone_humanskull_01
	{ 134153 }, -- inv_misc_head_dragon_01
	{ 132834 }, -- inv_egg_03
}

--[[
How We Got the Data

Last Validated
	2026-10-22, TBC Anniversary 2.5.6.70006

Notes
	- Spell IDs that feature code needs by name rather than from a list: the sample spells the options panels use for their preview messages.
	- SAMPLE_GOOD_NEWS_SPELL_ID (Power Infusion) is the spell linked in the Good News sample whisper (Options/Options-Send-Good-News.lua).
	- THANK_YOU_MACRO_ICONS are the icons a Thank You Button macro can wear (Options/Options-Thank-You-Button.lua): bold, distinct item art nobody keeps on a bar, so a Thank You macro stands out. Each is a texture file ID present under the same ID on Classic Era, TBC Anniversary and WoW Forever. The client gives an icon no name, so the Icon dropdown shows each one as its picture alone, in this order. The second field is the button that starts on it, so buttons 2 through 5 each start on their own icon.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/ManifestInterfaceData?build=2.5.6.70006

QuestieDB
	None.
]]
