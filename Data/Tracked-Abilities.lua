local _, ns = ...
local Data = ns.Data
local L = ns.L

--[[
    Tracked reactions: the buffs, cooldowns, and services other players spend on
    you, powering the Buffs from Teammates, Group Services, and Good News
    panels. (Buffs from Strangers is deliberately list-free -- any helpful buff
    from a player outside your group qualifies.)

    One entry == one checkbox in the options panel. StyLua owns the formatting
    (long entries span several lines); find an entry by the trailing "-- Name"
    comment on its closing brace, then tune its digits.

      name      display label, a locale string (L["GROUP_*"]). Omit to use the
                (localized) name of the first trigger -- set it only for a
                group whose members differ (Portals).
      class     class bucket for the Buffs-from-Teammates panel. Omit for the
                generic Items / Group Services lists.
      type      SOLO | GROUP | SERVICE (locals for Data.BUFF.*)
      detect    AURA | CAST | RESURRECT (locals for Data.DETECT.*). RESURRECT
                is for a cast that can FAIL: goblin jumper cables emit
                SPELL_CAST_SUCCESS for every jolt, revived or not, so only the
                SPELL_RESURRECT that a working jolt produces is worth a message.
      opened    SERVICE only: announce as "opened" (portals, summons) instead of
                the default "set out" (feasts, soulwells, repair bots).
      noDuration  the buff is spent by an event, not by time, so its remaining
                duration says nothing useful -- Fear Ward lasts until the next
                fear, Misdirection until the next few attacks. Set it and the
                Good News message drops its duration clause. It earns its keep on
                the SHORT ones (Misdirection, Tricks of the Trade, Intervene),
                which would otherwise clear the under-a-minute cap and whisper a
                countdown that means nothing; a long one like Fear Ward is caught
                by that cap regardless, and carries the flag because it is true.
      received  { Era, TBC, Wrath } default for the shared thank-you list
                (watchedBuffs) behind the Teammates and Group Services panels:
                  1   tracked, checkbox seeds checked
                  0   tracked, checkbox seeds unchecked
                  "-" does not exist on this flavor: no checkbox, never fires.
                A user's own checkbox choice is never overwritten, and anything
                past Wrath reads the Wrath slot. "-" exists because Blizzard
                REUSES spell ids across flavors for entirely different
                abilities, which DoesSpellExist can't detect (see
                Data/Peer-Pressure-Abilities.lua for worked examples).
      given     { Era, TBC, Wrath } default for the independent Good News list
                (goodNews.watched), digits 1/0 with the same meaning; the
                row-level "-" lives only in received. Omitted on SERVICE
                entries -- a service has no per-person recipient, so it never
                reaches Good News.
      triggers  the rank(s) / variant(s) this one toggle covers. Each is:
                  { spell = id }              a tracked spell
                  { spell = id, aura = id }   aura id differs from the cast id
                  { item = id, spell = id }   an item: shows its icon/name, and
                                              the tooltip lists every item in
                                              the group

    The name at the end of a row is a comment for humans; the panels pull names,
    icons, and tooltips from the game. This file is deliberately self-contained
    data -- tune a default by editing digits here without touching any other
    file.
]]
local SOLO, GROUP, SERVICE = Data.BUFF.SOLO, Data.BUFF.GROUP, Data.BUFF.SERVICE
local AURA, CAST, RESURRECT = Data.DETECT.AURA, Data.DETECT.CAST, Data.DETECT.RESURRECT

Data.TRACKED = {
	-- Death Knight --------------------------------------------------------------
	{
		class = "DEATHKNIGHT",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 49016 } },
	}, -- Unholy Frenzy
	-- Druid ---------------------------------------------------------------------
	{
		class = "DRUID",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 29166 } },
	}, -- Innervate
	{
		class = "DRUID",
		type = SOLO,
		detect = CAST,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
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
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 53271 } },
	}, -- Master's Call
	{
		class = "HUNTER",
		type = SOLO,
		detect = AURA,
		noDuration = true,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 34477, aura = 35079 } },
	}, -- Misdirection
	{
		class = "HUNTER",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 53480 } },
	}, -- Roar of Sacrifice
	-- Mage ----------------------------------------------------------------------
	{
		class = "MAGE",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
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
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
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
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 54646 } },
	}, -- Focus Magic
	{
		class = "MAGE",
		type = SERVICE,
		detect = CAST,
		received = { 1, 1, 1 },
		triggers = { { spell = 43987 }, { spell = 58659 } },
	}, -- Ritual of Refreshment
	{
		name = L["GROUP_PORTALS"],
		class = "MAGE",
		type = SERVICE,
		detect = CAST,
		opened = true,
		received = { 1, 1, 1 },
		triggers = {
			{ spell = 10059 },
			{ spell = 11416 },
			{ spell = 11417 },
			{ spell = 11418 },
			{ spell = 11419 },
			{ spell = 11420 },
			{ spell = 32266 },
			{ spell = 32267 },
			{ spell = 33691 },
			{ spell = 35717 },
			{ spell = 49360 },
			{ spell = 49361 },
			{ spell = 53142 },
			{ spell = 28148 },
		},
	}, -- Portals
	-- Paladin -------------------------------------------------------------------
	{
		class = "PALADIN",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 53563 } },
	}, -- Beacon of Light
	{
		class = "PALADIN",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 19752 } },
	}, -- Divine Intervention
	{
		class = "PALADIN",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 1044 } },
	}, -- Hand of Freedom
	{
		class = "PALADIN",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 1022 }, { spell = 5599 }, { spell = 10278 } },
	}, -- Hand of Protection
	{
		class = "PALADIN",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 6940 }, { spell = 20729 }, { spell = 27147 }, { spell = 27148 } },
	}, -- Hand of Sacrifice
	{
		class = "PALADIN",
		type = SOLO,
		detect = CAST,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 633 }, { spell = 2800 }, { spell = 10310 }, { spell = 27154 }, { spell = 48788 } },
	}, -- Lay on Hands
	-- Priest --------------------------------------------------------------------
	{
		class = "PRIEST",
		type = SOLO,
		detect = AURA,
		noDuration = true,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 6346 } },
	}, -- Fear Ward
	{
		class = "PRIEST",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 47788 } },
	}, -- Guardian Spirit
	{
		class = "PRIEST",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 33206 } },
	}, -- Pain Suppression
	{
		class = "PRIEST",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 10060 } },
	}, -- Power Infusion
	-- Rogue ---------------------------------------------------------------------
	{
		class = "ROGUE",
		type = SOLO,
		detect = AURA,
		noDuration = true,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 57934, aura = 57933 } },
	}, -- Tricks of the Trade
	-- Shaman --------------------------------------------------------------------
	{
		class = "SHAMAN",
		type = GROUP,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 2825 } },
	}, -- Bloodlust
	{
		class = "SHAMAN",
		type = GROUP,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 32182 } },
	}, -- Heroism
	{
		class = "SHAMAN",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 131 } },
	}, -- Water Breathing
	{
		class = "SHAMAN",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 546 } },
	}, -- Water Walking
	-- Warlock -------------------------------------------------------------------
	{
		class = "WARLOCK",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 5697 } },
	}, -- Unending Breath
	{
		class = "WARLOCK",
		type = SERVICE,
		detect = CAST,
		received = { 1, 1, 1 },
		triggers = { { spell = 29893 }, { spell = 58887 } },
	}, -- Ritual of Souls
	{
		class = "WARLOCK",
		type = SERVICE,
		detect = CAST,
		opened = true,
		received = { 1, 1, 1 },
		triggers = { { spell = 698 } },
	}, -- Ritual of Summoning
	-- Warrior -------------------------------------------------------------------
	{
		class = "WARRIOR",
		type = SOLO,
		detect = AURA,
		noDuration = true,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 3411 } },
	}, -- Intervene
	{
		class = "WARRIOR",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 50720 } },
	}, -- Vigilance
	-- Drums (item) --------------------------------------------------------------
	{
		type = GROUP,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { item = 29529, spell = 35476 } },
	}, -- Drums of Battle
	{
		type = GROUP,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { item = 29531, spell = 35478 } },
	}, -- Drums of Restoration
	{
		type = GROUP,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { item = 29530, spell = 35477 } },
	}, -- Drums of Speed
	{
		type = GROUP,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { item = 29528, spell = 35475 } },
	}, -- Drums of War
	{
		type = GROUP,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { item = 185848, spell = 351355 } },
	}, -- Greater Drums of Battle
	{
		type = GROUP,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { item = 185850, spell = 351358 } },
	}, -- Greater Drums of Restoration
	{
		type = GROUP,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { item = 185851, spell = 351359 } },
	}, -- Greater Drums of Speed
	{
		type = GROUP,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { item = 185852, spell = 351360 } },
	}, -- Greater Drums of War
	-- Soulstone (item, Warlock) -------------------------------------------------
	{
		name = L["GROUP_SOULSTONE"],
		class = "WARLOCK",
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = {
			{ item = 16895, spell = 20764 },
			{ item = 16892, spell = 20762 },
			{ item = 16896, spell = 20765 },
			{ item = 22116, spell = 27239 },
			{ item = 16893, spell = 20763 },
		},
	}, -- Soulstone
	-- Feasts (item) -------------------------------------------------------------
	{ type = SERVICE, detect = CAST, received = { 1, 1, 1 }, triggers = { { item = 43015, spell = 57426 } } }, -- Fish Feast
	{ type = SERVICE, detect = CAST, received = { 1, 1, 1 }, triggers = { { item = 34753, spell = 57301 } } }, -- Great Feast
	{ type = SERVICE, detect = CAST, received = { 1, 1, 1 }, triggers = { { item = 43478, spell = 58465 } } }, -- Gigantic Feast
	{ type = SERVICE, detect = CAST, received = { 1, 1, 1 }, triggers = { { item = 46887, spell = 66476 } } }, -- Bountiful Feast
	{ type = SERVICE, detect = CAST, received = { 1, 1, 1 }, triggers = { { item = 33052, spell = 33258 } } }, -- Fisherman's Feast (TBC)
	-- Resistance Cauldrons (item) -----------------------------------------------
	{
		name = L["GROUP_RESISTANCE_CAULDRONS"],
		type = SERVICE,
		detect = CAST,
		received = { 1, 1, 1 },
		triggers = {
			{ item = 32839, spell = 41443 },
			{ item = 32849, spell = 41494 },
			{ item = 32850, spell = 41495 },
			{ item = 32851, spell = 41497 },
			{ item = 32852, spell = 41498 },
		},
	}, -- Resistance Cauldrons
	-- Stat Scrolls (item) -------------------------------------------------------
	{
		name = L["GROUP_SCROLL_OF_SPIRIT"],
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = {
			{ item = 1181, spell = 8112 },
			{ item = 1712, spell = 8113 },
			{ item = 4424, spell = 8114 },
			{ item = 10306, spell = 12177 },
			{ item = 27501, spell = 33080 },
			{ item = 33460, spell = 43197 },
			{ item = 37097, spell = 48103 },
			{ item = 37098, spell = 48104 },
		},
	}, -- Scroll of Spirit
	{
		name = L["GROUP_SCROLL_OF_STAMINA"],
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = {
			{ item = 1180, spell = 8099 },
			{ item = 1711, spell = 8100 },
			{ item = 4422, spell = 8101 },
			{ item = 10307, spell = 12178 },
			{ item = 27502, spell = 33081 },
			{ item = 33461, spell = 43198 },
			{ item = 37093, spell = 48101 },
			{ item = 37094, spell = 48102 },
		},
	}, -- Scroll of Stamina
	{
		name = L["GROUP_SCROLL_OF_STRENGTH"],
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = {
			{ item = 954, spell = 8118 },
			{ item = 2289, spell = 8119 },
			{ item = 4426, spell = 8120 },
			{ item = 10310, spell = 12179 },
			{ item = 27503, spell = 33082 },
			{ item = 33462, spell = 43199 },
			{ item = 43465, spell = 58448 },
			{ item = 43466, spell = 58449 },
		},
	}, -- Scroll of Strength
	{
		name = L["GROUP_SCROLL_OF_PROTECTION"],
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = {
			{ item = 3013, spell = 8091 },
			{ item = 1478, spell = 8094 },
			{ item = 4421, spell = 8095 },
			{ item = 10305, spell = 12175 },
			{ item = 27500, spell = 33079 },
			{ item = 33459, spell = 43196 },
			{ item = 43467, spell = 58452 },
			{ item = 43468, spell = 58453 },
		},
	}, -- Scroll of Protection
	{
		name = L["GROUP_SCROLL_OF_INTELLECT"],
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = {
			{ item = 955, spell = 8096 },
			{ item = 2290, spell = 8097 },
			{ item = 4419, spell = 8098 },
			{ item = 10308, spell = 12176 },
			{ item = 27499, spell = 33078 },
			{ item = 33458, spell = 43195 },
			{ item = 37091, spell = 48099 },
			{ item = 37092, spell = 48100 },
		},
	}, -- Scroll of Intellect
	{
		name = L["GROUP_SCROLL_OF_AGILITY"],
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = {
			{ item = 3012, spell = 8115 },
			{ item = 1477, spell = 8116 },
			{ item = 4425, spell = 8117 },
			{ item = 10309, spell = 12174 },
			{ item = 27498, spell = 33077 },
			{ item = 33457, spell = 43194 },
			{ item = 43463, spell = 58450 },
			{ item = 43464, spell = 58451 },
		},
	}, -- Scroll of Agility
	-- Repair & Utility (item) ---------------------------------------------------
	{
		name = L["GROUP_REPAIR_BOTS"],
		type = SERVICE,
		detect = CAST,
		received = { 1, 1, 1 },
		triggers = { { item = 34113, spell = 44389 }, { item = 18232, spell = 22700 }, { item = 49040, spell = 67826 } },
	}, -- Repair Bots
	{ type = SERVICE, detect = CAST, received = { 1, 1, 1 }, triggers = { { item = 40768, spell = 54710 } } }, -- MOLL-E
	{ type = SERVICE, detect = CAST, received = { 1, 1, 1 }, triggers = { { item = 10725, spell = 23133 } } }, -- Gnomish Battle Chicken
	--[[
        Battle Squawk is what the summoned chicken casts on people, as opposed
        to the Gnomish Battle Chicken row above, which is the trinket being used
        to set the chicken out. Two rows because they are two different events
        to two different audiences: the summon is a Group Service ("set out a
        ..."), the squawk is a buff that lands on one person.

        Deliberately carries no item id even though item 10725 is what starts
        the chain. An item id would relabel this toggle as the trinket -- a
        second "Gnomish Battle Chicken" checkbox -- and reword the message into
        "used their Gnomish Battle Chicken on you", which is not what happened:
        the chicken was already out, and it is the bird that cast this.

        The CASTER IS THE PET, not its owner. Credit reaches the owner through
        ResolveSource for a received buff, and through the pet branch of
        OnUnitSpellcastSent for Good News.
    ]]
	{
		type = SOLO,
		detect = AURA,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		triggers = { { spell = 23060 } },
	}, -- Battle Squawk
	{
		name = L["GROUP_JUMPER_CABLES"],
		type = SOLO,
		-- Not CAST: the cables fire SPELL_CAST_SUCCESS whether or not the target
		-- gets up, so tracking the cast thanked people for a failed jolt.
		detect = RESURRECT,
		received = { 1, 1, 1 },
		given = { 1, 1, 1 },
		-- All four cast a spell named "Defibrillate"; only the ITEM names differ,
		-- which is why this group carries an explicit name. 114943 / 164729 is far
		-- past Wrath and so exists on no supported client -- it is pruned at login
		-- like any other absent id, and is here so the set is complete.
		triggers = {
			{ item = 7148, spell = 8342 },
			{ item = 18587, spell = 22999 },
			{ item = 40772, spell = 54732 },
			{ item = 114943, spell = 164729 },
		},
	}, -- Jumper Cables
}
