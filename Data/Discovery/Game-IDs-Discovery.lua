local _, ns = ...

if not ns.IS_DISCOVERY then
	return
end

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
		{ 1126, 5232, 6756, 5234, 8907, 9884, 9885 }, -- Mark of the Wild
		{ 21849, 21850 }, -- Gift of the Wild
		{ 467, 782, 1075, 8914, 9756, 9910 }, -- Thorns
	},
	MAGE = {
		{ 1459, 1460, 1461, 10156, 10157 }, -- Arcane Intellect
		{ 23028 }, -- Arcane Brilliance
	},
	PALADIN = {
		{ 19740, 19834, 19835, 19836, 19837, 19838, 25291 }, -- Blessing of Might
		{ 19742, 19850, 19852, 19853, 19854, 25290 }, -- Blessing of Wisdom
		{ 20217 }, -- Blessing of Kings
		{ 1038 }, -- Blessing of Salvation
		{ 19977, 19978, 19979 }, -- Blessing of Light
		{ 20911, 20912, 20913, 20914 }, -- Blessing of Sanctuary
		{ 25782, 25916 }, -- Greater Blessing of Might
		{ 25894, 25918 }, -- Greater Blessing of Wisdom
		{ 25898 }, -- Greater Blessing of Kings
		{ 25895 }, -- Greater Blessing of Salvation
		{ 25890 }, -- Greater Blessing of Light
		{ 25899 }, -- Greater Blessing of Sanctuary
	},
	PRIEST = {
		{ 1243, 1244, 1245, 2791, 10937, 10938 }, -- Power Word: Fortitude
		{ 21562, 21564 }, -- Prayer of Fortitude
		{ 14752, 14818, 14819, 27841 }, -- Divine Spirit
		{ 27681 }, -- Prayer of Spirit
		{ 976, 10957, 10958 }, -- Shadow Protection
		{ 27683 }, -- Prayer of Shadow Protection
	},
	SHAMAN = {
		{ 408514, 974 }, -- Earth Shield
		{ 131 }, -- Water Breathing
		{ 546 }, -- Water Walking
	},
	WARLOCK = {
		{ 5697 }, -- Unending Breath
		{ 132 }, -- Detect Lesser Invisibility
	},
}

--[[
How We Got the Data

Last Validated
	2026-11-26, wago.tools, Classic Era 1.15.9.70576

Notes
	- Spell IDs that feature code needs by name rather than from a list: the sample spells the options panels use for their preview messages.
	- THANK_YOU_MACRO_ICONS are the icons a Thank You Button macro can wear (Options/Options-Thank-You-Button.lua): bold, distinct item art nobody keeps on a bar, so a Thank You macro stands out. Each is a texture file ID present under the same ID on Classic Era, TBC Anniversary and WoW Forever. The client gives an icon no name, so the Icon dropdown shows each one as its picture alone, in this order. The second field is the button that starts on it, so buttons 2 through 5 each start on their own icon.
	- RETURN_BUFF_SPELLS are the everyday buffs each class can cast back with Return Buff (Features/Buff-Back.lua), beside that class's Good News buffs. One row is one buff: its rank IDs, lowest learn level first, named after the first. The macro casts by name, and on clients with ranks picks the rank the last buffer's level can take (ns.GetBuffBackRank). Only IDs this client's SpellName holds are listed, and a class with none has no entry.
	- Earth Shield lists the Season of Discovery rune spell 408514 first (learned at level 1), then 974. The rune's other ID, 408519, is the heal it triggers ("Healed by Earth Shield"), never cast, so it is left out.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/ManifestInterfaceData?build=1.15.9.70576
	https://wago.tools/db2/SpellName?build=1.15.9.70576
	https://wago.tools/db2/Spell?build=1.15.9.70576
	https://wago.tools/db2/SpellLevels?build=1.15.9.70576
	https://wago.tools/db2/SkillLineAbility?build=1.15.9.70576
	https://wago.tools/db2/SkillLine?build=1.15.9.70576

QuestieDB
	None.
]]
