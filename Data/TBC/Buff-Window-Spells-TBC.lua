local _, ns = ...
local Data = ns.Data

local ALL, TANK, OFF = Data.BUFF_AUDIENCE.ALL, Data.BUFF_AUDIENCE.TANK, Data.BUFF_AUDIENCE.OFF
local BLESSING = "BLESSING"
local ASPECT, MAGE_ARMOR, PALADIN_AURA = "ASPECT", "MAGE_ARMOR", "PALADIN_AURA"
local SHAMAN_SHIELD, WARLOCK_ARMOR = "SHAMAN_SHIELD", "WARLOCK_ARMOR"
local MISSING = Data.SELF_REFRESH_MISSING

-- { class, single = { { spell id, level learned } }, group = { spell ids }, greater = { spell ids }, exclusive, manaOnly, noCasters, default }, -- Name
ns.BUFF_WINDOW_SPELLS = {
	-- Druid ---------------------------------------------------------------------
	{
		class = "DRUID",
		single = {
			{ 1126, 1 },
			{ 5232, 10 },
			{ 6756, 20 },
			{ 5234, 30 },
			{ 8907, 40 },
			{ 9884, 50 },
			{ 9885, 60 },
			{ 26990, 70 },
		},
		group = { 21849, 21850, 26991 },
		default = ALL,
	}, -- Mark of the Wild
	{
		class = "DRUID",
		single = { { 467, 6 }, { 782, 14 }, { 1075, 24 }, { 8914, 34 }, { 9756, 44 }, { 9910, 54 }, { 26992, 64 } },
		default = TANK,
	}, -- Thorns
	-- Mage ----------------------------------------------------------------------
	{
		class = "MAGE",
		single = { { 1459, 1 }, { 1460, 14 }, { 1461, 28 }, { 10156, 42 }, { 10157, 56 }, { 27126, 70 } },
		group = { 23028, 27127 },
		manaOnly = true,
		default = ALL,
	}, -- Arcane Intellect
	{
		class = "MAGE",
		single = { { 1008, 18 }, { 8455, 30 }, { 10169, 42 }, { 10170, 54 }, { 27130, 63 }, { 33946, 69 } },
		default = OFF,
	}, -- Amplify Magic
	{
		class = "MAGE",
		single = { { 604, 12 }, { 8450, 24 }, { 8451, 36 }, { 10173, 48 }, { 10174, 60 }, { 33944, 67 } },
		default = OFF,
	}, -- Dampen Magic
	-- Paladin -------------------------------------------------------------------
	{
		class = "PALADIN",
		single = { { 20217, 20 } },
		greater = { 25898 },
		exclusive = BLESSING,
		default = ALL,
	}, -- Blessing of Kings
	{
		class = "PALADIN",
		single = {
			{ 19742, 14 },
			{ 19850, 24 },
			{ 19852, 34 },
			{ 19853, 44 },
			{ 19854, 54 },
			{ 25290, 60 },
			{ 27142, 65 },
		},
		greater = { 25894, 25918, 27143 },
		exclusive = BLESSING,
		manaOnly = true,
		default = ALL,
	}, -- Blessing of Wisdom
	{
		class = "PALADIN",
		single = {
			{ 19740, 4 },
			{ 19834, 12 },
			{ 19835, 22 },
			{ 19836, 32 },
			{ 19837, 42 },
			{ 19838, 52 },
			{ 25291, 60 },
			{ 27140, 70 },
		},
		greater = { 25782, 25916, 27141 },
		exclusive = BLESSING,
		noCasters = true,
		default = ALL,
	}, -- Blessing of Might
	{
		class = "PALADIN",
		single = { { 1038, 26 } },
		greater = { 25895 },
		exclusive = BLESSING,
		default = OFF,
	}, -- Blessing of Salvation
	{
		class = "PALADIN",
		single = { { 19977, 40 }, { 19978, 50 }, { 19979, 60 }, { 27144, 69 } },
		greater = { 25890, 27145 },
		exclusive = BLESSING,
		default = OFF,
	}, -- Blessing of Light
	{
		class = "PALADIN",
		single = { { 20911, 30 }, { 20912, 40 }, { 20913, 50 }, { 20914, 60 }, { 27168, 70 } },
		greater = { 25899, 27169 },
		exclusive = BLESSING,
		default = OFF,
	}, -- Blessing of Sanctuary
	-- Priest --------------------------------------------------------------------
	{
		class = "PRIEST",
		single = { { 1243, 1 }, { 1244, 12 }, { 1245, 24 }, { 2791, 36 }, { 10937, 48 }, { 10938, 60 }, { 25389, 70 } },
		group = { 21562, 21564, 25392 },
		default = ALL,
	}, -- Power Word: Fortitude
	{
		class = "PRIEST",
		single = { { 14752, 30 }, { 14818, 40 }, { 14819, 50 }, { 27841, 60 }, { 25312, 70 } },
		group = { 27681, 32999 },
		manaOnly = true,
		default = ALL,
	}, -- Divine Spirit
	{
		class = "PRIEST",
		single = { { 976, 30 }, { 10957, 42 }, { 10958, 56 }, { 25433, 68 } },
		group = { 27683, 39374 },
		default = OFF,
	}, -- Shadow Protection
	{
		class = "PRIEST",
		single = { { 6346, 20 } },
		default = TANK,
	}, -- Fear Ward
	-- Shaman --------------------------------------------------------------------
	{
		class = "SHAMAN",
		single = { { 974, 50 }, { 32593, 60 }, { 32594, 70 } },
		default = OFF,
	}, -- Earth Shield
	{
		class = "SHAMAN",
		single = { { 131, 22 } },
		default = OFF,
	}, -- Water Breathing
	{
		class = "SHAMAN",
		single = { { 546, 28 } },
		default = OFF,
	}, -- Water Walking
	-- Warlock -------------------------------------------------------------------
	{
		class = "WARLOCK",
		single = { { 5697, 16 } },
		default = OFF,
	}, -- Unending Breath
	{
		class = "WARLOCK",
		single = { { 132, 26 } },
		default = OFF,
	}, -- Detect Invisibility
}

-- { beast = spell id, demons = { [npc id] = spell id } }: the icon a pet's row wears, from its summoning spell
ns.BUFF_WINDOW_PET_ICONS = {
	beast = 883, -- Call Pet
	demons = {
		[416] = 688, -- Imp: Summon Imp
		[1860] = 697, -- Voidwalker: Summon Voidwalker
		[1863] = 712, -- Succubus: Summon Succubus
		[417] = 691, -- Felhunter: Summon Felhunter
		[17252] = 30146, -- Felguard: Summon Felguard
	},
}

-- { class, ranks = { { spell id, level learned } }, exclusive, default (minutes left, MISSING or OFF) }, -- Name
ns.BUFF_WINDOW_SELF_SPELLS = {
	-- Druid ---------------------------------------------------------------------
	{
		class = "DRUID",
		ranks = { { 16864, 20 } },
		default = 5,
	}, -- Omen of Clarity
	-- Hunter --------------------------------------------------------------------
	{
		class = "HUNTER",
		ranks = { { 19506, 40 }, { 20905, 50 }, { 20906, 60 }, { 27066, 70 } },
		default = 5,
	}, -- Trueshot Aura
	{
		class = "HUNTER",
		ranks = {
			{ 13165, 10 },
			{ 14318, 18 },
			{ 14319, 28 },
			{ 14320, 38 },
			{ 14321, 48 },
			{ 14322, 58 },
			{ 25296, 60 },
			{ 27044, 68 },
		},
		exclusive = ASPECT,
		default = MISSING,
	}, -- Aspect of the Hawk
	{
		class = "HUNTER",
		ranks = { { 13163, 4 } },
		exclusive = ASPECT,
		default = OFF,
	}, -- Aspect of the Monkey
	{
		class = "HUNTER",
		ranks = { { 5118, 20 } },
		exclusive = ASPECT,
		default = OFF,
	}, -- Aspect of the Cheetah
	{
		class = "HUNTER",
		ranks = { { 13161, 30 } },
		exclusive = ASPECT,
		default = OFF,
	}, -- Aspect of the Beast
	{
		class = "HUNTER",
		ranks = { { 13159, 40 } },
		exclusive = ASPECT,
		default = OFF,
	}, -- Aspect of the Pack
	{
		class = "HUNTER",
		ranks = { { 20043, 46 }, { 20190, 56 }, { 27045, 68 } },
		exclusive = ASPECT,
		default = OFF,
	}, -- Aspect of the Wild
	{
		class = "HUNTER",
		ranks = { { 34074, 64 } },
		exclusive = ASPECT,
		default = OFF,
	}, -- Aspect of the Viper
	-- Mage ----------------------------------------------------------------------
	{
		class = "MAGE",
		ranks = {
			{ 168, 1 },
			{ 7300, 10 },
			{ 7301, 20 },
			{ 7302, 30 },
			{ 7320, 40 },
			{ 10219, 50 },
			{ 10220, 60 },
			{ 27124, 69 },
		},
		exclusive = MAGE_ARMOR,
		default = 5,
	}, -- Frost Armor, Ice Armor
	{
		class = "MAGE",
		ranks = { { 6117, 34 }, { 22782, 46 }, { 22783, 58 }, { 27125, 69 } },
		exclusive = MAGE_ARMOR,
		default = 5,
	}, -- Mage Armor
	{
		class = "MAGE",
		ranks = { { 30482, 62 } },
		exclusive = MAGE_ARMOR,
		default = 5,
	}, -- Molten Armor
	-- Paladin -------------------------------------------------------------------
	{
		class = "PALADIN",
		ranks = {
			{ 465, 1 },
			{ 10290, 10 },
			{ 643, 20 },
			{ 10291, 30 },
			{ 1032, 40 },
			{ 10292, 50 },
			{ 10293, 60 },
			{ 27149, 70 },
		},
		exclusive = PALADIN_AURA,
		default = MISSING,
	}, -- Devotion Aura
	{
		class = "PALADIN",
		ranks = { { 7294, 16 }, { 10298, 26 }, { 10299, 36 }, { 10300, 46 }, { 10301, 56 }, { 27150, 66 } },
		exclusive = PALADIN_AURA,
		default = MISSING,
	}, -- Retribution Aura
	{
		class = "PALADIN",
		ranks = { { 19746, 22 } },
		exclusive = PALADIN_AURA,
		default = MISSING,
	}, -- Concentration Aura
	{
		class = "PALADIN",
		ranks = { { 19876, 28 }, { 19895, 40 }, { 19896, 52 }, { 27151, 63 } },
		exclusive = PALADIN_AURA,
		default = OFF,
	}, -- Shadow Resistance Aura
	{
		class = "PALADIN",
		ranks = { { 19888, 32 }, { 19897, 44 }, { 19898, 56 }, { 27152, 68 } },
		exclusive = PALADIN_AURA,
		default = OFF,
	}, -- Frost Resistance Aura
	{
		class = "PALADIN",
		ranks = { { 19891, 36 }, { 19899, 48 }, { 19900, 60 }, { 27153, 70 } },
		exclusive = PALADIN_AURA,
		default = OFF,
	}, -- Fire Resistance Aura
	{
		class = "PALADIN",
		ranks = { { 20218, 30 } },
		exclusive = PALADIN_AURA,
		default = MISSING,
	}, -- Sanctity Aura
	{
		class = "PALADIN",
		ranks = { { 32223, 62 } },
		exclusive = PALADIN_AURA,
		default = OFF,
	}, -- Crusader Aura
	{
		class = "PALADIN",
		ranks = { { 25780, 16 } },
		default = OFF,
	}, -- Righteous Fury
	-- Priest --------------------------------------------------------------------
	{
		class = "PRIEST",
		ranks = { { 588, 12 }, { 7128, 20 }, { 602, 30 }, { 1006, 40 }, { 10951, 50 }, { 10952, 60 }, { 25431, 69 } },
		default = 5,
	}, -- Inner Fire
	{
		class = "PRIEST",
		ranks = {
			{ 18137, 20 },
			{ 19308, 28 },
			{ 19309, 36 },
			{ 19310, 44 },
			{ 19311, 52 },
			{ 19312, 60 },
			{ 25477, 68 },
		},
		default = 5,
	}, -- Shadowguard
	{
		class = "PRIEST",
		ranks = {
			{ 2652, 10 },
			{ 19261, 20 },
			{ 19262, 30 },
			{ 19264, 40 },
			{ 19265, 50 },
			{ 19266, 60 },
			{ 25461, 70 },
		},
		default = 5,
	}, -- Touch of Weakness
	-- Shaman --------------------------------------------------------------------
	{
		class = "SHAMAN",
		ranks = {
			{ 324, 8 },
			{ 325, 16 },
			{ 905, 24 },
			{ 945, 32 },
			{ 8134, 40 },
			{ 10431, 48 },
			{ 10432, 56 },
			{ 25469, 63 },
			{ 25472, 70 },
		},
		exclusive = SHAMAN_SHIELD,
		default = 5,
	}, -- Lightning Shield
	{
		class = "SHAMAN",
		ranks = { { 24398, 62 }, { 33736, 69 } },
		exclusive = SHAMAN_SHIELD,
		default = 5,
	}, -- Water Shield
	-- Warlock -------------------------------------------------------------------
	{
		class = "WARLOCK",
		ranks = {
			{ 687, 1 },
			{ 696, 10 },
			{ 706, 20 },
			{ 1086, 30 },
			{ 11733, 40 },
			{ 11734, 50 },
			{ 11735, 60 },
			{ 27260, 70 },
		},
		exclusive = WARLOCK_ARMOR,
		default = 5,
	}, -- Demon Skin, Demon Armor
	{
		class = "WARLOCK",
		ranks = { { 28176, 62 }, { 28189, 69 } },
		exclusive = WARLOCK_ARMOR,
		default = 5,
	}, -- Fel Armor
}

--[[
How We Got the Data

Last Validated
	2026-10-19, TBC Anniversary 2.5.6.70006

Notes
	- Every buff one player can put on another that lasts more than two minutes: the ones worth keeping up on a group, and the ones a player may want to hand out on request. Only the rows for the player's own class are read, and only the ranks the player knows are cast.
	- Paladin blessings share exclusive = BLESSING: a target holds one blessing from each paladin, and a second replaces the first. So once one of yours is on a player, the window stops offering your others to them, and only offers that one again when it runs low. With none of yours on them, every blessing you turned on is offered and you pick.
	- greater lists every rank of a blessing's Greater version. It only counts toward "already has it" -- a Greater Blessing covers a class across the raid, not a party, so it is never offered as a party's group icon.
	- noCasters drops the buff for the classes in Data.CASTER_CLASSES, who get nothing from melee attack power (Blessing of Might).
	- Left out for lasting two minutes or less: Power Infusion, Innervate, Levitate, Slow Fall, Battle Shout. Left out for being item uses rather than spells: Soulstone and the stat scrolls.
	- single is every rank of the single-target buff, and group every rank of its party-wide version. A player counts as buffed by any rank of either, because each rank's aura carries its own ID.
	- Each single-target rank carries the level it is learned at, because Classic doesn't pick a rank for the target: casting a rank on a player more than 10 levels below its learn level fails with "Target is too low level". The button casts the highest known rank the target can take, by its rank text ("Name(Rank 2)"), and offers nothing when even rank 1 is too high. Group versions always cast their highest rank, by name.
	- The learn levels are the client's own, checked against the SPELL_LEVEL_LEARNED column of a Validate Data run from this client.
	- Earth Shield starts OFF even though it belongs on a tank: only one can be up per shaman, so offering it to every tank would offer it to some who can't have it.
	- manaOnly drops the buff for classes with no mana (Data.NO_MANA_CLASSES), where Intellect and Spirit do nothing worth a reagent or a global cooldown.
	- default is who the buff is offered to until the player picks: ALL, TANK, HEALER or OFF, from Data.BUFF_AUDIENCE in Data/Data.lua. The everyday raid buffs start on ALL (Kings, Wisdom and Might among them, since not every paladin has Kings), Thorns and Fear Ward on TANK, and the situational ones OFF. A player's own choice is never overwritten.
	- Amplify and Dampen Magic replace each other on the target, so turning both on offers each to everyone carrying the other.
	- The setting is keyed by the first single-target ID, the lowest rank.
	- BUFF_WINDOW_PET_ICONS picks the icon in front of a pet's name: a warlock demon wears its own summoning spell's icon, found by the creature ID inside the pet's GUID, and any other pet wears Call Pet's. Only the spell IDs are stored; the icons come from the client.
	- BUFF_WINDOW_SELF_SPELLS are the long buffs a player can only put on themselves, behind the window's Self Buffs row: armors, shields, Inner Fire, Omen of Clarity, Trueshot Aura, and the paladin auras and hunter aspects, which have no timer and only need to be up. Warriors and rogues have none worth listing (Battle Shout lasts two minutes; poisons are items).
	- ranks is every rank, with the level it is learned at; the row casts the highest one known. Where ranks change name (Frost Armor into Ice Armor, Demon Skin into Demon Armor) they share a row, since they are one line of the same buff.
	- exclusive groups the self buffs only one of which can be up at a time (an armor, a paladin aura, an aspect, a shaman shield): with any one of yours up, the rest of its family stop asking. Turn on every one you might use, and the window offers them all only when none is up.
	- default is when the self buff shows until the player picks: minutes left (5) to recast before it drops, MISSING for one with no timer (an aura or aspect is either up or not), or OFF. Every aspect but Hawk starts off: Cheetah and the rest are swapped in for a moment, and Hawk is the one to come back to. A player's own choice is never overwritten.
	- The self-buff learn levels are checked the same way.
	- Shadowguard (Troll) and Touch of Weakness (Undead) are priest racial self buffs. Only a priest of that race knows them, and a row offers only the ranks the player knows. Their learn levels come from SpellLevels.
	- Left out of the self buffs: tracking, stealth, mounts, pet spells, Feign Death, totems, and cooldowns spent on the next action (Presence of Mind, Nature's Swiftness, Inner Focus, Cold Blood, Divine Favor, Elemental Mastery, Combustion). Moonkin Aura is left out because Moonkin Form puts it up, not a cast.
	- Ancestral Healing and Inspiration are left out: they're talent procs that land after a heal, not casts.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/SpellName?build=2.5.6.70006
	https://wago.tools/db2/Spell?build=2.5.6.70006
	https://wago.tools/db2/SkillLineAbility?build=2.5.6.70006
	https://wago.tools/db2/SkillLine?build=2.5.6.70006
	https://wago.tools/db2/SpellLevels?build=2.5.6.70006
	https://wago.tools/db2/SpellEffect?build=2.5.6.70006
	https://wago.tools/db2/SpellMisc?build=2.5.6.70006
	https://wago.tools/db2/SpellDuration?build=2.5.6.70006

QuestieDB
	None.
]]
