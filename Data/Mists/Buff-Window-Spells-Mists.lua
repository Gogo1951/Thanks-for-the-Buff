local _, ns = ...

-- { class, single = { { spell id, level learned } }, group = { spell ids }, greater = { spell ids }, exclusive, manaOnly, noCasters, default }, -- Name
ns.BUFF_WINDOW_SPELLS = {}

-- { beast = spell id, demons = { [npc id] = spell id } }: the icon a pet's row wears, from its summoning spell
ns.BUFF_WINDOW_PET_ICONS = { demons = {} }

-- { class, ranks = { { spell id, level learned } }, auras, exclusive, needsPet, default }, -- Name
ns.BUFF_WINDOW_SELF_SPELLS = {}

-- { class, ranks = { { spell id, level learned, enchant id } } or items = { { item id, level required, enchant id } } }, -- Name
ns.BUFF_WINDOW_WEAPON_ENCHANTS = {}

-- The weapons each class keeps a poison or imbue on.
ns.BUFF_WINDOW_WEAPON_HANDS = {}

--[[
    Every other temporary weapon enchant, for any class: oils, sharpening
    stones, weightstones, fishing lures. weapon types is the item spell's
    weapon-subclass mask (0 for any weapon but a fishing pole); kind is the
    Weapon Buffs panel group it's listed under, and item level ranks it there
    and in the window, strongest first.
]]
local OIL, STONE, LURE = "OIL", "STONE", "LURE"

-- { item id, level required, enchant id, weapon types, kind, item level }, -- Name
ns.BUFF_WINDOW_WEAPON_ITEMS = {
	{ 23529, 60, 2713, 33219, STONE, 70 }, -- Adamantite Sharpening Stone
	{ 28421, 60, 2955, 9264, STONE, 70 }, -- Adamantite Weightstone
	{ 6533, 0, 266, 1048576, LURE, 30 }, -- Aquadynamic Fish Attractor
	{ 6811, 0, 264, 1048576, LURE, 20 }, -- Aquadynamic Fish Lens
	{ 34538, 70, 3265, 0, OIL, 70 }, -- Blessed Weapon Coating
	{ 23123, 50, 3592, 0, OIL, 55 }, -- Blessed Wizard Oil
	{ 31535, 0, 3102, 173555, OIL, 105 }, -- Bloodboil Poison
	{ 6532, 0, 265, 1048576, LURE, 30 }, -- Bright Baubles
	{ 20748, 45, 2629, 0, OIL, 55 }, -- Brilliant Mana Oil
	{ 20749, 45, 2628, 0, OIL, 55 }, -- Brilliant Wizard Oil
	{ 2863, 5, 13, 33219, STONE, 15 }, -- Coarse Sharpening Stone
	{ 3240, 5, 20, 9264, STONE, 15 }, -- Coarse Weightstone
	{ 23122, 50, 3593, 1097203, STONE, 55 }, -- Consecrated Sharpening Stone
	{ 69907, 1, 263, 1048576, LURE, 1 }, -- Corpse Worm
	{ 12404, 35, 1643, 33219, STONE, 45 }, -- Dense Sharpening Stone
	{ 12643, 35, 1703, 9264, STONE, 45 }, -- Dense Weightstone
	{ 18262, 50, 2506, 41411, STONE, 60 }, -- Elemental Sharpening Stone
	{ 36899, 72, 3298, 0, OIL, 80 }, -- Exceptional Mana Oil
	{ 62673, 0, 266, 1048576, LURE, 80 }, -- Feathered Lure
	{ 23528, 50, 2712, 33219, STONE, 60 }, -- Fel Sharpening Stone
	{ 28420, 50, 2954, 9264, STONE, 60 }, -- Fel Weightstone
	{ 7307, 0, 265, 1048576, LURE, 30 }, -- Flesh Eating Worm
	{ 3829, 30, 26, 173555, OIL, 40 }, -- Frost Oil
	{ 67404, 0, 4264, 1048576, LURE, 1 }, -- Glass Fishing Bobber
	{ 46006, 0, 3868, 1048576, LURE, 30 }, -- Glow Worm
	{ 68049, 0, 4225, 1048576, LURE, 81 }, -- Heat-Treated Spinning Lure
	{ 2871, 15, 14, 33219, STONE, 25 }, -- Heavy Sharpening Stone
	{ 3241, 15, 21, 9264, STONE, 25 }, -- Heavy Weightstone
	{ 20747, 40, 2625, 0, OIL, 50 }, -- Lesser Mana Oil
	{ 20746, 30, 2626, 0, OIL, 40 }, -- Lesser Wizard Oil
	{ 20745, 20, 2624, 0, OIL, 30 }, -- Minor Mana Oil
	{ 20744, 5, 2623, 0, OIL, 15 }, -- Minor Wizard Oil
	{ 6530, 0, 264, 1048576, LURE, 20 }, -- Nightcrawlers
	{ 34539, 70, 3266, 0, OIL, 70 }, -- Righteous Weapon Coating
	{ 2862, 1, 40, 33219, STONE, 5 }, -- Rough Sharpening Stone
	{ 3239, 1, 19, 9264, STONE, 5 }, -- Rough Weightstone
	{ 3824, 24, 25, 173555, OIL, 34 }, -- Shadow Oil
	{ 34861, 0, 266, 1048576, LURE, 30 }, -- Sharpened Fish Hook
	{ 6529, 0, 263, 1048576, LURE, 10 }, -- Shiny Bauble
	{ 7964, 25, 483, 33219, STONE, 35 }, -- Solid Sharpening Stone
	{ 7965, 25, 484, 9264, STONE, 35 }, -- Solid Weightstone
	{ 22521, 52, 2677, 0, OIL, 62 }, -- Superior Mana Oil
	{ 22522, 58, 2678, 0, OIL, 68 }, -- Superior Wizard Oil
	{ 20750, 40, 2627, 0, OIL, 50 }, -- Wizard Oil
}

-- The Soulstone reminder; nil until this client's stones are listed.
ns.BUFF_WINDOW_SOULSTONE = nil

-- { class, ranks = { spell ids } }: the Buff Keys' resurrection on a dead target
ns.BUFF_WINDOW_RESURRECTIONS = {}

--[[
How We Got the Data

Last Validated
	Never.

Notes
	- Declared empty until this flavor's buffs are picked: no TOC ships this folder yet, and the Vanilla and TBC rows don't carry over (the ranks differ, and later expansions merge or rename these buffs). BUFF_WINDOW_WEAPON_ITEMS is the one list filled in ahead, from the IDs supplied on 2026-10-19.
	- BUFF_WINDOW_PET_ICONS picks the icon in front of a pet's name: a warlock demon wears its own summoning spell's icon, found by the creature ID inside the pet's GUID, and any other pet wears Call Pet's. Only the spell IDs are stored; the icons come from the client.
	- BUFF_WINDOW_WEAPON_ITEMS is every other temporary weapon enchant, offered to any class: each item with the level it requires, the enchant id it puts on (SpellEffect's ENCHANT_ITEM_TEMPORARY misc value, through ItemEffect), and the weapon types its spell takes (SpellEquippedItems' EquippedItemSubclass mask, 0 for any weapon). kind files it under Oils, Stones or Lures on the Weapon Buffs panel: LURE for a fishing pole's, STONE for a sharpening stone or weightstone, OIL for the rest (oils, coatings, Bloodboil Poison, Scourgebane, the Weapon Cleaning Cloth). item level (ItemSparse) ranks them, strongest first: it orders a line Rough to Dense where the required level can't (every lure needs level 0). Fishing lures take only a fishing pole, a sharpening stone only a bladed weapon, a weightstone only a blunt one. Picked from the IDs supplied on 2026-10-19, keeping only items whose spell enchants a hand weapon or fishing pole. Left out: rogue-only poisons (the rogue rows above), armor runes and other enchants that go on armor, shield coatings, and test or placeholder items.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/ItemSparse?build=5.5.4.70449
	https://wago.tools/db2/ItemEffect?build=5.5.4.70449
	https://wago.tools/db2/SpellEffect?build=5.5.4.70449
	https://wago.tools/db2/SpellEquippedItems?build=5.5.4.70449
]]
