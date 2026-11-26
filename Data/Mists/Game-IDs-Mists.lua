local _, ns = ...

-- [constant] = spell id, -- Spell Name
ns.GAME_IDS = {
	SAMPLE_BUFF_SPELL_ID = 1459, -- Arcane Brilliance
	SAMPLE_GOOD_NEWS_SPELL_ID = 10060, -- Power Infusion
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

-- [class token] = { { rank spell ids, lowest first }, -- Spell Name }
ns.RETURN_BUFF_SPELLS = {
	DRUID = {
		{ 1126 }, -- Mark of the Wild
	},
	MAGE = {
		{ 1459 }, -- Arcane Brilliance
		{ 61316 }, -- Dalaran Brilliance
	},
	MONK = {
		{ 115921 }, -- Legacy of the Emperor
		{ 116781 }, -- Legacy of the White Tiger
	},
	PALADIN = {
		{ 19740 }, -- Blessing of Might
		{ 20217 }, -- Blessing of Kings
		{ 1038 }, -- Hand of Salvation
	},
	PRIEST = {
		{ 21562 }, -- Power Word: Fortitude
	},
	SHAMAN = {
		{ 974 }, -- Earth Shield
		{ 546 }, -- Water Walking
	},
	WARLOCK = {
		{ 5697 }, -- Unending Breath
		{ 109773 }, -- Dark Intent
	},
}

--[[
How We Got the Data

Last Validated
	2026-11-26, wago.tools, MoP Classic 5.5.4.71089

Notes
	- Spell IDs that feature code needs by name rather than from a list: the sample spells the options panels use for their preview messages.
	- THANK_YOU_MACRO_ICONS are the icons a Thank You Button macro can wear (Options/Options-Thank-You-Button.lua): bold, distinct item art nobody keeps on a bar, so a Thank You macro stands out. Each is a texture file ID present under the same ID on Classic Era, TBC Anniversary, WoW Forever and MoP Classic. The client gives an icon no name, so the Icon dropdown shows each one as its picture alone, in this order. The second field is the button that starts on it, so buttons 2 through 5 each start on their own icon.
	- RETURN_BUFF_SPELLS are the everyday buffs each class can cast back with Return Buff (Features/Buff-Back.lua), beside that class's Good News buffs. One row is one buff: its rank IDs, lowest learn level first, named after the first. The macro casts by name, and on clients with ranks picks the rank the last buffer's level can take (ns.GetBuffBackRank). Only IDs this client's SpellName holds are listed, and a class with none has no entry.
	- This client has no ranks, so each buff is one ID, and some IDs carry later names here: 1459 is Arcane Brilliance, 21562 Power Word: Fortitude, 1038 Hand of Salvation. Earth Shield's 379, also on the shaman skill line, is the heal it triggers, never cast, so it is left out.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/ManifestInterfaceData?build=5.5.4.71089
	https://wago.tools/db2/SpellName?build=5.5.4.71089
	https://wago.tools/db2/Spell?build=5.5.4.71089
	https://wago.tools/db2/SpellLevels?build=5.5.4.71089
	https://wago.tools/db2/SkillLineAbility?build=5.5.4.71089
	https://wago.tools/db2/SkillLine?build=5.5.4.71089

QuestieDB
	None.
]]
