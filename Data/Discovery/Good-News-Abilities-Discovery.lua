local _, ns = ...
local Data = ns.Data

if not ns.IS_DISCOVERY then
	return
end

local AURA, CAST, RESURRECT = Data.GOOD_NEWS_DETECT.AURA, Data.GOOD_NEWS_DETECT.CAST, Data.GOOD_NEWS_DETECT.RESURRECT

-- { class, detect, labelItem, noDuration, triggers = { { spell, aura, item } } }, -- Name
ns.GOOD_NEWS_ABILITIES = {
	-- Druid ---------------------------------------------------------------------
	{
		class = "DRUID",
		detect = AURA,
		triggers = {
			{ spell = 29166 },
		},
	}, -- Innervate
	{
		class = "DRUID",
		detect = CAST,
		triggers = {
			{ spell = 20484 },
			{ spell = 20739 },
			{ spell = 20742 },
			{ spell = 20747 },
			{ spell = 20748 },
		},
	}, -- Rebirth
	-- Mage ----------------------------------------------------------------------
	{
		class = "MAGE",
		detect = AURA,
		triggers = {
			{ spell = 1008 },
			{ spell = 8455 },
			{ spell = 10169 },
			{ spell = 10170 },
		},
	}, -- Amplify Magic
	{
		class = "MAGE",
		detect = AURA,
		triggers = {
			{ spell = 604 },
			{ spell = 8450 },
			{ spell = 8451 },
			{ spell = 10173 },
			{ spell = 10174 },
		},
	}, -- Dampen Magic
	-- Paladin -------------------------------------------------------------------
	{
		class = "PALADIN",
		detect = AURA,
		triggers = {
			{ spell = 19752 },
		},
	}, -- Divine Intervention
	{
		class = "PALADIN",
		detect = AURA,
		triggers = {
			{ spell = 1044 },
		},
	}, -- Blessing of Freedom
	{
		class = "PALADIN",
		detect = AURA,
		triggers = {
			{ spell = 1022 },
			{ spell = 5599 },
			{ spell = 10278 },
		},
	}, -- Blessing of Protection
	{
		class = "PALADIN",
		detect = AURA,
		triggers = {
			{ spell = 6940 },
			{ spell = 20729 },
		},
	}, -- Blessing of Sacrifice
	{
		class = "PALADIN",
		detect = CAST,
		triggers = {
			{ spell = 633 },
			{ spell = 2800 },
			{ spell = 10310 },
		},
	}, -- Lay on Hands
	{
		class = "PALADIN",
		detect = AURA,
		triggers = {
			{ spell = 407613 },
		},
	}, -- Beacon of Light
	-- Priest --------------------------------------------------------------------
	{
		class = "PRIEST",
		detect = AURA,
		noDuration = true,
		triggers = {
			{ spell = 6346 },
		},
	}, -- Fear Ward
	{
		class = "PRIEST",
		detect = AURA,
		triggers = {
			{ spell = 10060 },
		},
	}, -- Power Infusion
	{
		class = "PRIEST",
		detect = AURA,
		triggers = {
			{ spell = 402004 },
		},
	}, -- Pain Suppression
	-- Shaman --------------------------------------------------------------------
	{
		class = "SHAMAN",
		detect = AURA,
		triggers = {
			{ spell = 131 },
		},
	}, -- Water Breathing
	{
		class = "SHAMAN",
		detect = AURA,
		triggers = {
			{ spell = 546 },
		},
	}, -- Water Walking
	-- Warlock -------------------------------------------------------------------
	{
		class = "WARLOCK",
		detect = AURA,
		triggers = {
			{ spell = 5697 },
		},
	}, -- Unending Breath
	-- Warrior -------------------------------------------------------------------
	{
		class = "WARRIOR",
		detect = AURA,
		noDuration = true,
		triggers = {
			{ spell = 403338 },
		},
	}, -- Intervene
	-- Warlock -------------------------------------------------------------------
	{
		class = "WARLOCK",
		detect = AURA,
		labelItem = 16893,
		triggers = {
			{ spell = 20764, item = 16895 },
			{ spell = 20762, item = 16892 },
			{ spell = 20765, item = 16896 },
			{ spell = 20763, item = 16893 },
			{ spell = 20707, item = 5232 },
		},
	}, -- Soulstone
	-- Items ---------------------------------------------------------------------
	{
		detect = AURA,
		labelItem = 1181,
		triggers = {
			{ spell = 8112, item = 1181 },
			{ spell = 8113, item = 1712 },
			{ spell = 8114, item = 4424 },
			{ spell = 12177, item = 10306 },
		},
	}, -- Scroll of Spirit
	{
		detect = AURA,
		labelItem = 1180,
		triggers = {
			{ spell = 8099, item = 1180 },
			{ spell = 8100, item = 1711 },
			{ spell = 8101, item = 4422 },
			{ spell = 12178, item = 10307 },
		},
	}, -- Scroll of Stamina
	{
		detect = AURA,
		labelItem = 954,
		triggers = {
			{ spell = 8118, item = 954 },
			{ spell = 8119, item = 2289 },
			{ spell = 8120, item = 4426 },
			{ spell = 12179, item = 10310 },
		},
	}, -- Scroll of Strength
	{
		detect = AURA,
		labelItem = 3013,
		triggers = {
			{ spell = 8091, item = 3013 },
			{ spell = 8094, item = 1478 },
			{ spell = 8095, item = 4421 },
			{ spell = 12175, item = 10305 },
		},
	}, -- Scroll of Protection
	{
		detect = AURA,
		labelItem = 955,
		triggers = {
			{ spell = 8096, item = 955 },
			{ spell = 8097, item = 2290 },
			{ spell = 8098, item = 4419 },
			{ spell = 12176, item = 10308 },
		},
	}, -- Scroll of Intellect
	{
		detect = AURA,
		labelItem = 3012,
		triggers = {
			{ spell = 8115, item = 3012 },
			{ spell = 8116, item = 1477 },
			{ spell = 8117, item = 4425 },
			{ spell = 12174, item = 10309 },
		},
	}, -- Scroll of Agility
	{
		detect = AURA,
		triggers = {
			{ spell = 23060 },
		},
	}, -- Battle Squawk
	{
		detect = RESURRECT,
		labelItem = 7148,
		triggers = {
			{ spell = 8342, item = 7148 },
			{ spell = 22999, item = 18587 },
		},
	}, -- Goblin Jumper Cables
}

--[[
How We Got the Data

Last Validated
	2026-10-22, Season of Discovery 1.15.9.70003

Notes
	- The spells and items you cast on another player that Good News can whisper them about (Features/Good-News.lua). One entry is one checkbox on the Tracked Abilities panel. Hand-picked, not queried: each is a buff, cooldown or rescue cast on one other player, where knowing who gave it is worth a whisper.
	- The name after each entry is for people; the panel takes names, icons and tooltips from the game. StyLua spreads long entries over several lines, so find one by the name on its closing brace.
	- class is the class heading on the Tracked Abilities panel. Without one the row sits in the Items list.
	- labelItem is an item whose game name labels a group named after one of its own items (Soulstone, the stat scrolls), so the label is the game's own in every locale.
	- detect is AURA, CAST or RESURRECT, from Data.GOOD_NEWS_DETECT in Data/Data.lua. AURA reads the buff's length off the player you cast it on; CAST is a one-shot with nothing to time (Rebirth, Lay on Hands). RESURRECT is for a cast that can fail: Jumper Cables report a successful cast for every jolt, revived or not, so the whisper waits for the combat log's resurrection event, which only a working jolt produces.
	- noDuration marks a buff spent by an event rather than by time, so the whisper leaves out its length: Fear Ward lasts until the next fear. It matters most on short buffs, which would otherwise slip under the under-a-minute cap and whisper a countdown that means nothing.
	- triggers lists the ranks or variants one checkbox covers: a spell alone, a spell with an aura where the aura's ID differs from the cast's (no row here needs one), or an item with the spell it casts, which shows the item's icon and name. UNIT_SPELLCAST_SENT carries the spell ID, so that is what each trigger is matched on.
	- Jumper Cables takes its label from item 7148's client name (labelItem), because every cable casts a spell named Defibrillate; only the item names differ.
	- Battle Squawk is cast by the Battle Chicken, not by you, so it reaches Good News through your pet's cast events. It carries no item on purpose: item 10725 would label the checkbox as a second Gnomish Battle Chicken.
	- Every row starts ticked. A player's own choice is saved in goodNews.watched under each ID the row watches (a trigger's aura when it names one, else its spell), and is never overwritten. A save from before Good News moved to Good to Go used the same keys, so it still applies.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/SpellName?build=1.15.9.70003
	https://wago.tools/db2/SkillLineAbility?build=1.15.9.70003
	https://wago.tools/db2/SkillLine?build=1.15.9.70003
	https://wago.tools/db2/SpellEffect?build=1.15.9.70003
	https://wago.tools/db2/ItemSparse?build=1.15.9.70003
	https://wago.tools/db2/ItemEffect?build=1.15.9.70003
	https://wago.tools/db2/SpellLevels?build=1.15.9.70003
	https://wago.tools/db2/Talent?build=1.15.9.70003

QuestieDB
	None.
]]
