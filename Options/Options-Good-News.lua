local _, ns = ...
local L = ns.L

--[[
    "Good News" panel -- whispers for tracked buffs YOU cast on other players
    (settings live under goodNews). It renders the same class categories as
    Buffs from Teammates (ns.TeammateCategories -- services have no per-person
    recipient and are absent by construction), but its toggles bind to the
    independent goodNews.watched list, so "thank for it" and "announce it"
    stay separate choices on the same ids. Registered as a function, like
    Teammates, so the tracked list is rebuilt on open once lazily-loaded item
    names are cached.
]]

function ns.BuildGoodNewsOptions()
	local function GivenWatched()
		return ns.db.profile.goodNews.watched
	end
	-- The enable toggle is the panel's master switch: everything below it hides
	-- outright when Good News is off.
	local function GoodNewsHidden()
		return not ns.db.profile.goodNews.whisperEnabled
	end

	local options = {
		name = L["TAB_GOOD_NEWS"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["GOOD_NEWS_DESC"], 1),
			space0 = ns.OptionsSpacer(2),
			enable = {
				type = "toggle",
				name = L["GOOD_NEWS_WHISPER_ENABLE"],
				desc = L["GOOD_NEWS_WHISPER_DESC"],
				order = 5,
				get = function()
					return ns.db.profile.goodNews.whisperEnabled
				end,
				set = function(_, val)
					ns.db.profile.goodNews.whisperEnabled = val
				end,
			},
			-- Who gets whispered, on the master's row. Unlabeled on purpose --
			-- the values are self-describing and the mock keeps the row tight.
			scope = {
				type = "select",
				name = "",
				order = 6,
				hidden = GoodNewsHidden,
				values = {
					ALWAYS = L["GOOD_NEWS_SCOPE_ALWAYS"],
					GROUP = L["GOOD_NEWS_SCOPE_GROUP"],
				},
				sorting = { "ALWAYS", "GROUP" },
				get = function()
					-- Anything that isn't ALWAYS displays as GROUP, so a stale
					-- stored value can never leave the dropdown showing blank.
					return ns.db.profile.goodNews.scope == "ALWAYS" and "ALWAYS" or "GROUP"
				end,
				set = function(_, val)
					ns.db.profile.goodNews.scope = val
				end,
			},
			sampleSpacer = { type = "description", name = " ", order = 6.5, hidden = GoodNewsHidden },
			--[[
                A sample of the outgoing whisper, built by the SAME pipeline that
                sends the real one (template, spell link, localized duration), so
                it can never drift from what recipients actually get. Only the
                {rt1} chat marker is swapped for its texture -- chat renders the
                marker as the Star icon, but options-panel text does not.
            ]]
			sampleMessage = {
				type = "description",
				name = function()
					local link = ns.GetSpellLink(10060) or "" -- Power Infusion
					local message = ns:BuildAnnounceMessage("MSG_GOODNEWS_DURATION", link, ns.FormatDuration(15))
					return "   "
						.. message:gsub(ns.TARGET_MARKER, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:14|t", 1)
						.. "\n"
				end,
				fontSize = "medium",
				order = 7,
				hidden = GoodNewsHidden,
			},
			headerTracked = ns.OptionsSubHeader(L["COMBAT_TRACKED"], 12, GoodNewsHidden),
			space2 = { type = "description", name = " ", order = 13, hidden = GoodNewsHidden },
		},
	}

	local categoryOrder = 20
	for _, category in ipairs(ns.TeammateCategories or {}) do
		local groupKey = "cat_" .. category.id
		options.args[groupKey] = {
			type = "group",
			name = category.name,
			order = categoryOrder,
			inline = true,
			hidden = GoodNewsHidden,
			args = {},
		}

		local entryOrder = 1
		for _, entry in ipairs(ns.SortedEntries(category.entries)) do
			options.args[groupKey].args["entry_" .. entry.ids[1]] =
				ns.DefineEntryToggle(entry, entryOrder, GivenWatched)
			entryOrder = entryOrder + 1
		end

		categoryOrder = categoryOrder + 1
	end

	return options
end
