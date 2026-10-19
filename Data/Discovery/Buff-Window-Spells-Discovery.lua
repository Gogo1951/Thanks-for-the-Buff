local _, ns = ...
local Data = ns.Data

if not ns.IS_DISCOVERY then
	return
end

local ALL, TANK, OFF = Data.BUFF_AUDIENCE.ALL, Data.BUFF_AUDIENCE.TANK, Data.BUFF_AUDIENCE.OFF
local BLESSING = "BLESSING"
local ASPECT, MAGE_ARMOR, PALADIN_AURA = "ASPECT", "MAGE_ARMOR", "PALADIN_AURA"
local SHAMAN_IMBUE, SHAMAN_SHIELD, WARLOCK_ARMOR = "SHAMAN_IMBUE", "SHAMAN_SHIELD", "WARLOCK_ARMOR"
local MISSING = Data.SELF_REFRESH_MISSING

-- { class, single = { { spell id, level learned } }, group = { spell ids }, greater = { spell ids }, exclusive, manaOnly, noCasters, default }, -- Name
ns.BUFF_WINDOW_SPELLS = {
	-- Druid ---------------------------------------------------------------------
	{
		class = "DRUID",
		single = { { 1126, 1 }, { 5232, 10 }, { 6756, 20 }, { 5234, 30 }, { 8907, 40 }, { 9884, 50 }, { 9885, 60 } },
		group = { 21849, 21850 },
		default = ALL,
	}, -- Mark of the Wild
	{
		class = "DRUID",
		single = { { 467, 6 }, { 782, 14 }, { 1075, 24 }, { 8914, 34 }, { 9756, 44 }, { 9910, 54 } },
		default = TANK,
	}, -- Thorns
	-- Mage ----------------------------------------------------------------------
	{
		class = "MAGE",
		single = { { 1459, 1 }, { 1460, 14 }, { 1461, 28 }, { 10156, 42 }, { 10157, 56 } },
		group = { 23028 },
		manaOnly = true,
		default = ALL,
	}, -- Arcane Intellect
	{
		class = "MAGE",
		single = { { 1008, 18 }, { 8455, 30 }, { 10169, 42 }, { 10170, 54 } },
		default = OFF,
	}, -- Amplify Magic
	{
		class = "MAGE",
		single = { { 604, 12 }, { 8450, 24 }, { 8451, 36 }, { 10173, 48 }, { 10174, 60 } },
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
		single = { { 19742, 14 }, { 19850, 24 }, { 19852, 34 }, { 19853, 44 }, { 19854, 54 }, { 25290, 60 } },
		greater = { 25894, 25918 },
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
		},
		greater = { 25782, 25916 },
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
		single = { { 19977, 40 }, { 19978, 50 }, { 19979, 60 } },
		greater = { 25890 },
		exclusive = BLESSING,
		default = OFF,
	}, -- Blessing of Light
	{
		class = "PALADIN",
		single = { { 20911, 30 }, { 20912, 40 }, { 20913, 50 }, { 20914, 60 } },
		greater = { 25899 },
		exclusive = BLESSING,
		default = OFF,
	}, -- Blessing of Sanctuary
	{
		class = "PALADIN",
		single = { { 407613, 1 } },
		default = OFF,
	}, -- Beacon of Light
	-- Priest --------------------------------------------------------------------
	{
		class = "PRIEST",
		single = { { 1243, 1 }, { 1244, 12 }, { 1245, 24 }, { 2791, 36 }, { 10937, 48 }, { 10938, 60 } },
		group = { 21562, 21564 },
		default = ALL,
	}, -- Power Word: Fortitude
	{
		class = "PRIEST",
		single = { { 14752, 30 }, { 14818, 40 }, { 14819, 50 }, { 27841, 60 } },
		group = { 27681 },
		manaOnly = true,
		default = ALL,
	}, -- Divine Spirit
	{
		class = "PRIEST",
		single = { { 976, 30 }, { 10957, 42 }, { 10958, 56 } },
		group = { 27683 },
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
		single = { { 131, 22 } },
		default = OFF,
	}, -- Water Breathing
	{
		class = "SHAMAN",
		single = { { 546, 28 } },
		default = OFF,
	}, -- Water Walking
	{
		class = "SHAMAN",
		single = { { 408514, 1 } },
		default = OFF,
	}, -- Earth Shield
	{
		class = "SHAMAN",
		single = { { 408696, 1 } },
		default = OFF,
	}, -- Spirit of the Alpha
	-- Warlock -------------------------------------------------------------------
	{
		class = "WARLOCK",
		single = { { 5697, 16 } },
		default = OFF,
	}, -- Unending Breath
	{
		class = "WARLOCK",
		single = { { 132, 26 }, { 2970, 38 }, { 11743, 50 } },
		default = OFF,
	}, -- Detect Greater Invisibility, Detect Invisibility, Detect Lesser Invisibility
}

-- { beast = spell id, demons = { [npc id] = spell id } }: the icon a pet's row wears, from its summoning spell
ns.BUFF_WINDOW_PET_ICONS = {
	beast = 883, -- Call Pet
	demons = {
		[416] = 688, -- Imp: Summon Imp
		[1860] = 697, -- Voidwalker: Summon Voidwalker
		[1863] = 712, -- Succubus: Summon Succubus
		[417] = 691, -- Felhunter: Summon Felhunter
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
		ranks = { { 19506, 40 }, { 20905, 50 }, { 20906, 60 } },
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
		ranks = { { 20043, 46 }, { 20190, 56 } },
		exclusive = ASPECT,
		default = OFF,
	}, -- Aspect of the Wild
	{
		class = "HUNTER",
		ranks = { { 415423, 1 } },
		exclusive = ASPECT,
		default = OFF,
	}, -- Aspect of the Viper
	{
		class = "HUNTER",
		ranks = { { 469145, 60 } },
		exclusive = ASPECT,
		default = OFF,
	}, -- Aspect of the Falcon
	{
		class = "HUNTER",
		ranks = { { 409580, 1 } },
		default = MISSING,
	}, -- Heart of the Lion
	-- Mage ----------------------------------------------------------------------
	{
		class = "MAGE",
		ranks = { { 168, 1 }, { 7300, 10 }, { 7301, 20 }, { 7302, 30 }, { 7320, 40 }, { 10219, 50 }, { 10220, 60 } },
		exclusive = MAGE_ARMOR,
		default = 5,
	}, -- Frost Armor, Ice Armor
	{
		class = "MAGE",
		ranks = { { 6117, 34 }, { 22782, 46 }, { 22783, 58 } },
		exclusive = MAGE_ARMOR,
		default = 5,
	}, -- Mage Armor
	-- Paladin -------------------------------------------------------------------
	{
		class = "PALADIN",
		ranks = { { 465, 1 }, { 10290, 10 }, { 643, 20 }, { 10291, 30 }, { 1032, 40 }, { 10292, 50 }, { 10293, 60 } },
		exclusive = PALADIN_AURA,
		default = MISSING,
	}, -- Devotion Aura
	{
		class = "PALADIN",
		ranks = { { 7294, 16 }, { 10298, 26 }, { 10299, 36 }, { 10300, 46 }, { 10301, 56 } },
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
		ranks = { { 19876, 28 }, { 19895, 40 }, { 19896, 52 } },
		exclusive = PALADIN_AURA,
		default = OFF,
	}, -- Shadow Resistance Aura
	{
		class = "PALADIN",
		ranks = { { 19888, 32 }, { 19897, 44 }, { 19898, 56 } },
		exclusive = PALADIN_AURA,
		default = OFF,
	}, -- Frost Resistance Aura
	{
		class = "PALADIN",
		ranks = { { 19891, 36 }, { 19899, 48 }, { 19900, 60 } },
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
		ranks = { { 25780, 16 }, { 407627, 1 } },
		default = OFF,
	}, -- Righteous Fury
	-- Priest --------------------------------------------------------------------
	{
		class = "PRIEST",
		ranks = { { 588, 12 }, { 7128, 20 }, { 602, 30 }, { 1006, 40 }, { 10951, 50 }, { 10952, 60 } },
		default = 5,
	}, -- Inner Fire
	{
		class = "PRIEST",
		ranks = { { 18137, 20 }, { 19308, 28 }, { 19309, 36 }, { 19310, 44 }, { 19311, 52 }, { 19312, 60 } },
		default = 5,
	}, -- Shadowguard
	{
		class = "PRIEST",
		ranks = { { 2652, 10 }, { 19261, 20 }, { 19262, 30 }, { 19264, 40 }, { 19265, 50 }, { 19266, 60 } },
		default = 5,
	}, -- Touch of Weakness
	-- Shaman --------------------------------------------------------------------
	{
		class = "SHAMAN",
		ranks = { { 324, 8 }, { 325, 16 }, { 905, 24 }, { 945, 32 }, { 8134, 40 }, { 10431, 48 }, { 10432, 56 } },
		exclusive = SHAMAN_SHIELD,
		default = 5,
	}, -- Lightning Shield
	{
		class = "SHAMAN",
		ranks = { { 408510, 1 } },
		exclusive = SHAMAN_SHIELD,
		default = 5,
	}, -- Water Shield
	{
		class = "SHAMAN",
		ranks = { { 8017, 1 }, { 8018, 8 }, { 8019, 16 }, { 10399, 24 }, { 16314, 34 }, { 16315, 44 }, { 16316, 54 } },
		enchants = { 29, 6, 1, 503, 1663, 683, 1664 },
		exclusive = SHAMAN_IMBUE,
		default = 5,
	}, -- Rockbiter Weapon
	{
		class = "SHAMAN",
		ranks = { { 8024, 10 }, { 8027, 18 }, { 8030, 26 }, { 16339, 36 }, { 16341, 46 }, { 16342, 56 } },
		enchants = { 5, 4, 3, 523, 1665, 1666 },
		exclusive = SHAMAN_IMBUE,
		default = 5,
	}, -- Flametongue Weapon
	{
		class = "SHAMAN",
		ranks = { { 8033, 20 }, { 8038, 28 }, { 10456, 38 }, { 16355, 48 }, { 16356, 58 } },
		enchants = { 2, 12, 524, 1667, 1668 },
		exclusive = SHAMAN_IMBUE,
		default = OFF,
	}, -- Frostbrand Weapon
	{
		class = "SHAMAN",
		ranks = { { 8232, 30 }, { 8235, 40 }, { 10486, 50 }, { 16362, 60 } },
		enchants = { 283, 284, 525, 1669 },
		exclusive = SHAMAN_IMBUE,
		default = 5,
	}, -- Windfury Weapon
	-- Warlock -------------------------------------------------------------------
	{
		class = "WARLOCK",
		ranks = { { 687, 1 }, { 696, 10 }, { 706, 20 }, { 1086, 30 }, { 11733, 40 }, { 11734, 50 }, { 11735, 60 } },
		exclusive = WARLOCK_ARMOR,
		default = 5,
	}, -- Demon Skin, Demon Armor
	{
		class = "WARLOCK",
		ranks = { { 403619, 1 } },
		exclusive = WARLOCK_ARMOR,
		default = 5,
	}, -- Fel Armor
}

--[[
How We Got the Data

Last Validated
	2026-10-19, Season of Discovery 1.15.9.70003

Notes
	- Every buff one player can put on another that lasts more than two minutes: the ones worth keeping up on a group, and the ones a player may want to hand out on request. Only the rows for the player's own class are read, and only the ranks the player knows are cast.
	- Paladin blessings share exclusive = BLESSING: a target holds one blessing from each paladin, and a second replaces the first. So once one of yours is on a player, the window stops offering your others to them, and only offers that one again when it runs low. With none of yours on them, every blessing you turned on is offered and you pick.
	- greater lists every rank of a blessing's Greater version. It only counts toward "already has it" -- a Greater Blessing covers a class across the raid, not a party, so it is never offered as a party's group icon.
	- noCasters drops the buff for the classes in Data.CASTER_CLASSES, who get nothing from melee attack power (Blessing of Might).
	- Left out for lasting two minutes or less: Power Infusion, Innervate, Levitate, Slow Fall, Battle Shout. Left out for being item uses rather than spells: Soulstone and the stat scrolls.
	- single is every rank of the single-target buff, and group every rank of its party-wide version. A player counts as buffed by any rank of either, because each rank's aura carries its own ID.
	- Each single-target rank carries the level it is learned at, because Classic doesn't pick a rank for the target: casting a rank on a player more than 10 levels below its learn level fails with "Target is too low level". The button casts the highest known rank the target can take, by its rank text ("Name(Rank 2)"), and offers nothing when even rank 1 is too high. Group versions always cast their highest rank, by name.
	- The learn levels are the client's own, checked against the SPELL_LEVEL_LEARNED column of a Validate Data run from this client.
	- manaOnly drops the buff for classes with no mana (Data.NO_MANA_CLASSES), where Intellect and Spirit do nothing worth a reagent or a global cooldown.
	- default is who the buff is offered to until the player picks: ALL, TANK, HEALER or OFF, from Data.BUFF_AUDIENCE in Data/Data.lua. The everyday raid buffs start on ALL (Kings, Wisdom and Might among them, since not every paladin has Kings), Thorns and Fear Ward on TANK, and the situational ones OFF. A player's own choice is never overwritten.
	- Amplify and Dampen Magic replace each other on the target, so turning both on offers each to everyone carrying the other.
	- The setting is keyed by the first single-target ID, the lowest rank.
	- BUFF_WINDOW_PET_ICONS picks the icon in front of a pet's name: a warlock demon wears its own summoning spell's icon, found by the creature ID inside the pet's GUID, and any other pet wears Call Pet's. Only the spell IDs are stored; the icons come from the client.
	- BUFF_WINDOW_SELF_SPELLS are the long buffs a player can only put on themselves, behind the window's Self Buffs row: armors, shields, Inner Fire, Omen of Clarity, Trueshot Aura, and the paladin auras and hunter aspects, which have no timer and only need to be up. Warriors and rogues have none worth listing (Battle Shout lasts two minutes; poisons are items).
	- ranks is every rank, with the level it is learned at; the row casts the highest one known. Where ranks change name (Frost Armor into Ice Armor, Demon Skin into Demon Armor) they share a row, since they are one line of the same buff.
	- exclusive groups the self buffs only one of which can be up at a time (an armor, a paladin aura, an aspect, a shaman shield, a weapon imbue): with any one of yours up, the rest of its family stop asking. Turn on every one you might use, and the window offers them all only when none is up.
	- The shaman weapon imbues (Rockbiter, Flametongue, Frostbrand, Windfury) share exclusive = SHAMAN_IMBUE: a weapon holds one. They are enchants on the main hand, not auras, so each row also lists enchants, the SpellItemEnchantment ids its ranks put on the weapon (SpellEffect's EffectMiscValue for Effect ENCHANT_ITEM_TEMPORARY), read back with GetWeaponEnchantInfo. Frostbrand starts OFF: it is swapped in for kiting, not kept up. Only the main hand is checked.
	- default is when the self buff shows until the player picks: minutes left (5) to recast before it drops, MISSING for one with no timer (an aura or aspect is either up or not), or OFF. Every aspect but Hawk starts off: Cheetah and the rest are swapped in for a moment, and Hawk is the one to come back to. A player's own choice is never overwritten.
	- The self-buff learn levels are checked the same way.
	- Shadowguard (Troll) and Touch of Weakness (Undead) are priest racial self buffs. Only a priest of that race knows them, and a row offers only the ranks the player knows. Their learn levels come from SpellLevels.
	- Left out of the self buffs: tracking, stealth, mounts, pet spells, Feign Death, totems, and cooldowns spent on the next action (Presence of Mind, Nature's Swiftness, Inner Focus, Cold Blood, Divine Favor, Elemental Mastery, Combustion). Moonkin Aura is left out because Moonkin Form puts it up, not a cast.
	- Beacon of Light, Earth Shield and Spirit of the Alpha are Season of Discovery's rune buffs. Each holds on one target per caster, so like Earth Shield on TBC they start OFF rather than being offered to every tank. Runes have no trainer level, so each carries learn level 1, from SpellLevels.
	- Water Shield, Fel Armor, Aspect of the Viper, Aspect of the Falcon, Heart of the Lion and the second Righteous Fury (407627) are Season of Discovery's own self buffs. Their learn levels come from SpellLevels: 1 for the runes, 60 for Aspect of the Falcon. Heart of the Lion has no timer and isn't an aspect, so it starts MISSING and shares no exclusive group.
	- Commanding Shout is left out: it has no single-target version, and the window builds every row from one.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/SpellName?build=1.15.9.70003
	https://wago.tools/db2/Spell?build=1.15.9.70003
	https://wago.tools/db2/SkillLineAbility?build=1.15.9.70003
	https://wago.tools/db2/SkillLine?build=1.15.9.70003
	https://wago.tools/db2/SpellLevels?build=1.15.9.70003
	https://wago.tools/db2/SpellEffect?build=1.15.9.70003
	https://wago.tools/db2/SpellMisc?build=1.15.9.70003
	https://wago.tools/db2/SpellDuration?build=1.15.9.70003

QuestieDB
	None.
]]
