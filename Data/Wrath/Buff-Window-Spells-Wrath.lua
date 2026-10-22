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
    Weapon Buffs panel group it's listed under ("OIL", "STONE" or "LURE").
]]
-- { item id, level required, enchant id, weapon types, kind, item level, zones }, -- Name
ns.BUFF_WINDOW_WEAPON_ITEMS = {}

-- The Soulstone reminder; nil until this client's stones are listed.
ns.BUFF_WINDOW_SOULSTONE = nil

-- { class, ranks = { spell ids } }: the Buff Key's resurrection on a dead target
ns.BUFF_WINDOW_RESURRECTIONS = {}

--[[
How We Got the Data

Last Validated
	Never.

Notes
	- Declared empty until this flavor's buffs are picked: no TOC ships this folder yet, and the Vanilla and TBC rows don't carry over (the ranks differ, and later expansions merge or rename these buffs).
	- With no rows, the Buff Window never has anything to show on this client.
	- BUFF_WINDOW_PET_ICONS picks the icon in front of a pet's name: a warlock demon wears its own summoning spell's icon, found by the creature ID inside the pet's GUID, and any other pet wears Call Pet's. Only the spell IDs are stored; the icons come from the client.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	None.
]]
