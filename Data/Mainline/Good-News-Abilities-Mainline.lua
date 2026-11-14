local _, ns = ...
local Data = ns.Data

local AURA, CAST, RESURRECT = Data.GOOD_NEWS_DETECT.AURA, Data.GOOD_NEWS_DETECT.CAST, Data.GOOD_NEWS_DETECT.RESURRECT

-- { class, detect, labelItem, noDuration, triggers = { { spell, aura, item } } }, -- Name
ns.GOOD_NEWS_ABILITIES = {
	-- Items ---------------------------------------------------------------------
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
			{ spell = 20739 },
			{ spell = 20742 },
			{ spell = 20747 },
			{ spell = 20748 },
			{ spell = 26994 },
			{ spell = 48477 },
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
	-- Mage ----------------------------------------------------------------------
	{
		class = "MAGE",
		detect = AURA,
		triggers = {
			{ spell = 1008 },
			{ spell = 8455 },
			{ spell = 10169 },
			{ spell = 10170 },
			{ spell = 27130 },
			{ spell = 43017 },
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
			{ spell = 33944 },
			{ spell = 43015 },
		},
	}, -- Dampen Magic
	{
		class = "MAGE",
		detect = AURA,
		triggers = {
			{ spell = 54646 },
		},
	}, -- Focus Magic
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
			{ spell = 19752 },
		},
	}, -- Divine Intervention
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
			{ spell = 5599 },
			{ spell = 10278 },
		},
	}, -- Hand of Protection
	{
		class = "PALADIN",
		detect = AURA,
		triggers = {
			{ spell = 6940 },
			{ spell = 20729 },
			{ spell = 27147 },
			{ spell = 27148 },
		},
	}, -- Hand of Sacrifice
	{
		class = "PALADIN",
		detect = CAST,
		triggers = {
			{ spell = 633 },
			{ spell = 2800 },
			{ spell = 10310 },
			{ spell = 27154 },
			{ spell = 48788 },
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
			{ spell = 3411 },
		},
	}, -- Intervene
	{
		class = "WARRIOR",
		detect = AURA,
		triggers = {
			{ spell = 50720 },
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
		labelItem = 16893,
		triggers = {
			{ spell = 20764, item = 16895 },
			{ spell = 20762, item = 16892 },
			{ spell = 20765, item = 16896 },
			{ spell = 27239, item = 22116 },
			{ spell = 20763, item = 16893 },
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
			{ spell = 164729, item = 114943 },
		},
	}, -- Jumper Cables
}
