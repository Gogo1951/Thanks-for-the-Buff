local _, ns = ...

-- [constant] = spell id, -- Spell Name
ns.GAME_IDS = {
	SAMPLE_BUFF_SPELL_ID = 1459, -- Arcane Intellect
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
		{ 1126, 5232, 6756, 5234, 8907, 9884, 9885, 26990 }, -- Mark of the Wild
		{ 21849, 21850, 26991 }, -- Gift of the Wild
		{ 467, 782, 1075, 8914, 9756, 9910, 26992 }, -- Thorns
	},
	MAGE = {
		{ 1459, 1460, 1461, 10156, 10157, 27126 }, -- Arcane Intellect
		{ 23028, 27127 }, -- Arcane Brilliance
	},
	PALADIN = {
		{ 19740, 19834, 19835, 19836, 19837, 19838, 25291, 27140 }, -- Blessing of Might
		{ 19742, 19850, 19852, 19853, 19854, 25290, 27142 }, -- Blessing of Wisdom
		{ 20217 }, -- Blessing of Kings
		{ 1038 }, -- Blessing of Salvation
		{ 19977, 19978, 19979, 27144 }, -- Blessing of Light
		{ 20911, 20912, 20913, 20914, 27168 }, -- Blessing of Sanctuary
		{ 25782, 25916, 27141 }, -- Greater Blessing of Might
		{ 25894, 25918, 27143 }, -- Greater Blessing of Wisdom
		{ 25898 }, -- Greater Blessing of Kings
		{ 25895 }, -- Greater Blessing of Salvation
		{ 25890, 27145 }, -- Greater Blessing of Light
		{ 25899, 27169 }, -- Greater Blessing of Sanctuary
	},
	PRIEST = {
		{ 1243, 1244, 1245, 2791, 10937, 10938, 25389 }, -- Power Word: Fortitude
		{ 21562, 21564, 25392 }, -- Prayer of Fortitude
		{ 14752, 14818, 14819, 27841, 25312 }, -- Divine Spirit
		{ 27681, 32999 }, -- Prayer of Spirit
		{ 976, 10957, 10958, 25433 }, -- Shadow Protection
		{ 27683, 39374 }, -- Prayer of Shadow Protection
	},
	SHAMAN = {
		{ 974, 32593, 32594 }, -- Earth Shield
		{ 131 }, -- Water Breathing
		{ 546 }, -- Water Walking
	},
	WARLOCK = {
		{ 5697 }, -- Unending Breath
		{ 132 }, -- Detect Invisibility
	},
}

--[[
How We Got the Data

Last Validated
	2026-11-26, wago.tools, TBC Anniversary 2.5.6.70577

Notes
	- Spell IDs that feature code needs by name rather than from a list: the sample spells the options panels use for their preview messages.
	- THANK_YOU_MACRO_ICONS are the icons a Thank You Button macro can wear (Options/Options-Thank-You-Button.lua): bold, distinct item art nobody keeps on a bar, so a Thank You macro stands out. Each is a texture file ID present under the same ID on Classic Era, TBC Anniversary and WoW Forever. The client gives an icon no name, so the Icon dropdown shows each one as its picture alone, in this order. The second field is the button that starts on it, so buttons 2 through 5 each start on their own icon.
	- RETURN_BUFF_SPELLS are the everyday buffs each class can cast back with Return Buff (Features/Buff-Back.lua), beside that class's Good News buffs. One row is one buff: its rank IDs, lowest learn level first, named after the first. The macro casts by name, and on clients with ranks picks the rank the last buffer's level can take (ns.GetBuffBackRank). Only IDs this client's SpellName holds are listed, and a class with none has no entry.
	- On this client 132 is named Detect Invisibility. Earth Shield's 379, also on the shaman skill line, is the heal it triggers, never cast, so it is left out.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/ManifestInterfaceData?build=2.5.6.70577
	https://wago.tools/db2/SpellName?build=2.5.6.70577
	https://wago.tools/db2/Spell?build=2.5.6.70577
	https://wago.tools/db2/SpellLevels?build=2.5.6.70577
	https://wago.tools/db2/SkillLineAbility?build=2.5.6.70577
	https://wago.tools/db2/SkillLine?build=2.5.6.70577

QuestieDB
	None.
]]
