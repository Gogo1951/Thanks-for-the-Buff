local _, ns = ...
local L = ns.L

--[[
    "Buffs from Teammates" panel -- party/raid buffs & cooldowns cast on you. Two
    sections, as on Buffs from Strangers: Praise (what the teammate sees) and
    Notifications (the chat line and sound only you get), then one inline group of
    tracked abilities per class category, built at login. The controls come from
    the shared factories in Options-Utilities.lua (ns.Define* / ns.SortedEntries /
    ns.DefineEntryToggle).

    No cooldown sliders here, unlike Strangers: a teammate's cooldown is worth
    acknowledging every single time it lands, so only the outgoing whisper is
    rate-limited, and that happens in the engine rather than as a setting.
]]

function ns.BuildTeammatesOptions()
	local function settings()
		return ns.db.profile.teammates
	end

	local options = {
		name = L["TAB_TEAMMATES"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["TEAMMATES_DESCRIPTION"], 1),
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

	-- One inline group per category (each class, then Items), built at login.
	local categoryOrder = 30
	for _, category in ipairs(ns.TeammateCategories or {}) do
		local groupKey = "cat_" .. category.id
		options.args[groupKey] = {
			type = "group",
			name = category.name,
			order = categoryOrder,
			inline = true,
			args = {},
		}

		local entryOrder = 1
		for _, entry in ipairs(ns.SortedEntries(category.entries)) do
			options.args[groupKey].args["entry_" .. entry.ids[1]] = ns.DefineEntryToggle(entry, entryOrder)
			entryOrder = entryOrder + 1
		end

		categoryOrder = categoryOrder + 1
	end

	return options
end
