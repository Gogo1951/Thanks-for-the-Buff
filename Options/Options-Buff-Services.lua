local _, ns = ...
local L = ns.L

--[[
    "Group Services" panel -- raid-wide help with no aura on you (feasts, soulwells,
    portals, repair bots). The controls and tracked-list helpers come from
    Options-Utilities.lua (ns.Define* / ns.SortedEntries / ns.DefineEntryToggle).

    Same shape as Buffs from Teammates -- the Praise / Notifications split, the
    same headers, the same controls -- minus the cooldown sliders, which only
    Strangers carries. The tracked list is one flat category, so there are no
    inner headers either.
]]

function ns.BuildServicesOptions()
	local function settings()
		return ns.db.profile.services
	end

	local options = {
		name = L["TAB_SERVICES"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["SERVICES_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),

			headerPraise = ns.OptionsHeader(L["PRAISE_HEADER"], 3),
			space1 = ns.OptionsSpacer(4),
			emotes = ns.DefineEmotesToggle(settings, 5),
			emoteSpacer = { type = "description", name = " ", order = 6, hidden = ns.EmotesHidden(settings) },
			emoteGroup = ns.DefineEmoteGroup(settings, 7),
			space2 = ns.OptionsSpacer(8),
			whisper = ns.DefineWhisperToggle(settings, 9),
			space3 = ns.OptionsSpacer(10),
			praiseDelay = ns.DefinePraiseDelayToggle(settings, 11),
			praiseDelayLength = ns.DefinePraiseDelaySelect(settings, 12),
			space4 = ns.OptionsSpacer(13),

			headerNotifications = ns.OptionsHeader(L["NOTIFICATIONS_HEADER"], 14),
			space5 = ns.OptionsSpacer(15),
			printOut = ns.DefinePrintToggle(settings, 16),
			space6 = ns.OptionsSpacer(17),
			sound = ns.DefineSoundToggle(settings, 18),
			soundPreview = ns.DefineSoundPreview(ns.PlayBuffSound, 19),
			space7 = ns.OptionsSpacer(20),

			headerTracked = ns.OptionsHeader(L["COMBAT_TRACKED"], 21),
			space8 = ns.OptionsSpacer(22),
		},
	}

	local entryOrder = 30
	for _, entry in ipairs(ns.SortedEntries(ns.ServiceEntries or {})) do
		options.args["entry_" .. entry.ids[1]] = ns.DefineEntryToggle(entry, entryOrder)
		entryOrder = entryOrder + 1
	end

	return options
end
