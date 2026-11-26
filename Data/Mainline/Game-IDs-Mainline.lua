local _, ns = ...

-- [constant] = spell id, -- Spell Name
ns.GAME_IDS = {
	SAMPLE_BUFF_SPELL_ID = 1459, -- Arcane Intellect
	SAMPLE_GOOD_NEWS_SPELL_ID = 10060, -- Power Infusion
}

-- { texture file ID, button it starts on }, -- Icon File Name
ns.THANK_YOU_MACRO_ICONS = {}

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
		{ 61316 }, -- Dalaran Brilliance
	},
	MONK = {
		{ 115921 }, -- Legacy of the Emperor
		{ 116781 }, -- Legacy of the White Tiger
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
		{ 132 }, -- Detect Lesser Invisibility
		{ 109773 }, -- Dark Intent
	},
}
