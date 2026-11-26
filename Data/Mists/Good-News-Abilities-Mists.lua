local _, ns = ...
local Data = ns.Data

local AURA, CAST, RESURRECT = Data.GOOD_NEWS_DETECT.AURA, Data.GOOD_NEWS_DETECT.CAST, Data.GOOD_NEWS_DETECT.RESURRECT

-- { class, detect, labelItem, noDuration, triggers = { { spell, aura, item } } }, -- Name
ns.GOOD_NEWS_ABILITIES = {
	-- Death Knight --------------------------------------------------------------
	{
		class = "DEATHKNIGHT",
		detect = AURA,
		triggers = {
			{ spell = 49016 },
		},
	}, -- Unholy Frenzy
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
		},
	}, -- Rebirth
	-- Hunter --------------------------------------------------------------------
	{
		class = "HUNTER",
		detect = AURA,
		triggers = {
			{ spell = 53271 },
		},
	}, -- Master's Call
	{
		class = "HUNTER",
		detect = AURA,
		noDuration = true,
		triggers = {
			{ spell = 34477, aura = 35079 },
		},
	}, -- Misdirection
	{
		class = "HUNTER",
		detect = AURA,
		triggers = {
			{ spell = 53480 },
		},
	}, -- Roar of Sacrifice
	-- Paladin -------------------------------------------------------------------
	{
		class = "PALADIN",
		detect = AURA,
		triggers = {
			{ spell = 53563 },
		},
	}, -- Beacon of Light
	{
		class = "PALADIN",
		detect = AURA,
		triggers = {
			{ spell = 1044 },
		},
	}, -- Hand of Freedom
	{
		class = "PALADIN",
		detect = AURA,
		triggers = {
			{ spell = 1022 },
		},
	}, -- Hand of Protection
	{
		class = "PALADIN",
		detect = AURA,
		triggers = {
			{ spell = 6940 },
		},
	}, -- Hand of Sacrifice
	{
		class = "PALADIN",
		detect = CAST,
		triggers = {
			{ spell = 633 },
		},
	}, -- Lay on Hands
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
			{ spell = 47788 },
		},
	}, -- Guardian Spirit
	{
		class = "PRIEST",
		detect = AURA,
		triggers = {
			{ spell = 33206 },
		},
	}, -- Pain Suppression
	{
		class = "PRIEST",
		detect = AURA,
		triggers = {
			{ spell = 10060 },
		},
	}, -- Power Infusion
	-- Rogue ---------------------------------------------------------------------
	{
		class = "ROGUE",
		detect = AURA,
		noDuration = true,
		triggers = {
			{ spell = 57934, aura = 57933 },
		},
	}, -- Tricks of the Trade
	-- Shaman --------------------------------------------------------------------
	{
		class = "SHAMAN",
		detect = AURA,
		triggers = {
			{ spell = 2825 },
		},
	}, -- Bloodlust
	{
		class = "SHAMAN",
		detect = AURA,
		triggers = {
			{ spell = 32182 },
		},
	}, -- Heroism
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
			{ spell = 3411 },
		},
	}, -- Intervene
	{
		class = "WARRIOR",
		detect = AURA,
		triggers = {
			{ spell = 114030 },
			{ spell = 122710 },
		},
	}, -- Vigilance
	-- Items ---------------------------------------------------------------------
	{
		detect = AURA,
		triggers = {
			{ spell = 35476, item = 29529 },
		},
	}, -- Drums of Battle
	{
		detect = AURA,
		triggers = {
			{ spell = 35478, item = 29531 },
		},
	}, -- Drums of Restoration
	{
		detect = AURA,
		triggers = {
			{ spell = 35477, item = 29530 },
		},
	}, -- Drums of Speed
	{
		detect = AURA,
		triggers = {
			{ spell = 35475, item = 29528 },
		},
	}, -- Drums of War
	{
		detect = AURA,
		triggers = {
			{ spell = 351355, item = 185848 },
		},
	}, -- Greater Drums of Battle
	{
		detect = AURA,
		triggers = {
			{ spell = 351358, item = 185850 },
		},
	}, -- Greater Drums of Restoration
	{
		detect = AURA,
		triggers = {
			{ spell = 351359, item = 185851 },
		},
	}, -- Greater Drums of Speed
	{
		detect = AURA,
		triggers = {
			{ spell = 351360, item = 185852 },
		},
	}, -- Greater Drums of War
	-- Warlock -------------------------------------------------------------------
	{
		class = "WARLOCK",
		detect = AURA,
		triggers = {
			{ spell = 20707 },
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
			{ spell = 33080, item = 27501 },
			{ spell = 43197, item = 33460 },
			{ spell = 48103, item = 37097 },
			{ spell = 48104, item = 37098 },
			{ spell = 89342, item = 63307 },
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
			{ spell = 33081, item = 27502 },
			{ spell = 43198, item = 33461 },
			{ spell = 48101, item = 37093 },
			{ spell = 48102, item = 37094 },
			{ spell = 89345, item = 63306 },
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
			{ spell = 33082, item = 27503 },
			{ spell = 43199, item = 33462 },
			{ spell = 58448, item = 43465 },
			{ spell = 58449, item = 43466 },
			{ spell = 89346, item = 63304 },
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
			{ spell = 33079, item = 27500 },
			{ spell = 43196, item = 33459 },
			{ spell = 58452, item = 43467 },
			{ spell = 58453, item = 43468 },
			{ spell = 89344, item = 63308 },
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
			{ spell = 33078, item = 27499 },
			{ spell = 43195, item = 33458 },
			{ spell = 48099, item = 37091 },
			{ spell = 48100, item = 37092 },
			{ spell = 89347, item = 63305 },
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
			{ spell = 33077, item = 27498 },
			{ spell = 43194, item = 33457 },
			{ spell = 58450, item = 43463 },
			{ spell = 58451, item = 43464 },
			{ spell = 89343, item = 63303 },
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
			{ spell = 54732, item = 40772 },
		},
	}, -- Goblin Jumper Cables
}

--[[
How We Got the Data

Last Validated
	2026-11-26, wago.tools, MoP Classic 5.5.4.71089

Notes
	- The spells and items you cast on another player that Good News can whisper them about (Features/Good-News.lua). One entry is one checkbox on the Tracked Abilities panel. Hand-picked, not queried: each is a buff, cooldown or rescue cast on one other player, where knowing who gave it is worth a whisper.
	- The name after each entry is for people; the panel takes names, icons and tooltips from the game. StyLua spreads long entries over several lines, so find one by the name on its closing brace.
	- class is the class heading on the Tracked Abilities panel. Without one the row sits in the Items list.
	- labelItem is an item whose game name labels a group named after one of its own items (the stat scrolls, Jumper Cables), so the label is the game's own in every locale.
	- detect is AURA, CAST or RESURRECT, from Data.GOOD_NEWS_DETECT in Data/Data.lua. AURA reads the buff's length off the player you cast it on; CAST is a one-shot with nothing to time (Rebirth, Lay on Hands). RESURRECT is for a cast that can fail: Jumper Cables report a successful cast for every jolt, revived or not, so the whisper waits for the combat log's resurrection event, which only a working jolt produces.
	- noDuration marks a buff spent by an event rather than by time, so the whisper leaves out its length: Fear Ward lasts until the next fear; Misdirection and Tricks of the Trade carry it too. It matters most on short buffs, which would otherwise slip under the under-a-minute cap and whisper a countdown that means nothing.
	- triggers lists the ranks or variants one checkbox covers: a spell alone, a spell with an aura where the aura's ID differs from the cast's (Misdirection, Tricks of the Trade), or an item with the spell it casts, which shows the item's icon and name. UNIT_SPELLCAST_SENT carries the spell ID, so that is what each trigger is matched on.
	- This client has no ranks for most class spells, so each class row lists only the IDs its SpellName holds. Vigilance lists both warrior spells of that name cast on a party or raid member (114030, 122710). Soulstone is the warlock's own spell here (20707), cast straight on another player rather than made into an item, so it carries no item or labelItem.
	- The stat scrolls run from the first rank to IX (63303 to 63308, each made by a spell of its own name, 89368 to 89373), each scroll with the spell it casts.
	- Jumper Cables takes its label from item 7148's client name (labelItem), because every cable, and the Gnomish Army Knife, casts a spell named Defibrillate; only the item names differ.
	- Battle Squawk is cast by the Battle Chicken, not by you, so it reaches Good News through your pet's cast events. It carries no item on purpose: item 10725 would label the checkbox as a second Gnomish Battle Chicken.
	- Not tracked: Amplify Magic, Dampen Magic, Focus Magic, Divine Intervention and the shaman's Water Breathing, which this client doesn't have; the stat elixirs that cast the same spells as the scrolls, which buff whoever drinks them; the drum patterns, which teach a drum rather than beat it; Beacon of Light's 53652, the heal it passes on, never cast; and Gorzeeki's Jumper Cables, which only revive one quest NPC.
	- Every row starts ticked. A player's own choice is saved in goodNews.watched under each ID the row watches (a trigger's aura when it names one, else its spell), and is never overwritten. A save from before Good News moved to Good to Go used the same keys, so it still applies.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/SpellName?build=5.5.4.71089
	https://wago.tools/db2/Spell?build=5.5.4.71089
	https://wago.tools/db2/SpellLevels?build=5.5.4.71089
	https://wago.tools/db2/SkillLineAbility?build=5.5.4.71089
	https://wago.tools/db2/SkillLine?build=5.5.4.71089
	https://wago.tools/db2/SpellEffect?build=5.5.4.71089
	https://wago.tools/db2/Item?build=5.5.4.71089
	https://wago.tools/db2/ItemSparse?build=5.5.4.71089
	https://wago.tools/db2/ItemEffect?build=5.5.4.71089

QuestieDB
	https://raw.githubusercontent.com/Questie/QuestieDB/master/data/MoP/mopItemDB.lua
]]
