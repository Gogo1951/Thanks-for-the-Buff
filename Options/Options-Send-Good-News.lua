local _, ns = ...
local L = ns.L

-- The message row mirrors the Thank You Button's: a caption-sized label, the
-- edit box, and the Reset button, together one row, so a whole sentence stays
-- readable.
local MESSAGE_LABEL_WIDTH = 0.9
local RESET_WIDTH = 0.5
local MESSAGE_INPUT_WIDTH = ns.OPTIONS_ROW_WIDTH - MESSAGE_LABEL_WIDTH - RESET_WIDTH

--[[
    "Good News" panel -- whispers for tracked buffs YOU cast on other players
    (settings live under goodNews). It renders its own class categories
    (ns.GoodNewsCategories: the teammate list plus any row this client can't
    see landing on you; services have no per-person recipient and are absent
    by construction), and its toggles bind to the independent goodNews.watched
    list, so "thank for it" and "announce it" stay separate choices on the same
    ids. Registered as a function, like
    Teammates, so the tracked list is rebuilt on open once lazily-loaded item
    names are cached.
]]

local MESSAGE_MAX = 120

-- Joined rather than merged into one locale string: TOKENS carries the literal
-- %a a player is meant to copy, so it must never reach string.format -- only the
-- limit line, whose %d is a real placeholder, does.
local function MessageHelp()
	return string.format(L["GOOD_NEWS_MESSAGE_LIMIT"], MESSAGE_MAX) .. " " .. L["GOOD_NEWS_MESSAGE_TOKENS"]
end

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
			descIntro = ns.OptionsDesc(L["GOOD_NEWS_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),
			enable = ns.OptionsFeatureToggle(ns.GetFeatureSwitch("goodNews"), 3),
			spaceScope = ns.OptionsSpacer(3.5, GoodNewsHidden),
			-- Who gets whispered, on its own label-beside-control row.
			scopeLabel = ns.OptionsRowLabel(L["GOOD_NEWS_SCOPE"], 3.6, nil, GoodNewsHidden),
			scope = {
				type = "select",
				name = "",
				desc = L["GOOD_NEWS_SCOPE_DESCRIPTION"],
				width = ns.OPTIONS_CONTROL_WIDTH,
				order = 4,
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
			space1 = ns.OptionsSpacer(5, GoodNewsHidden),
			headerMessages = ns.OptionsHeader(L["GOOD_NEWS_MESSAGES_HEADER"], 6, GoodNewsHidden),
			space2 = ns.OptionsSpacer(7, GoodNewsHidden),
			messageLabel = ns.OptionsRowLabel(L["WHISPER_MESSAGE"], 8, MESSAGE_LABEL_WIDTH, GoodNewsHidden),
			--[[
                The editable body only. The star marker (left off on WoW Forever)
                and the " // TFTB" sign-off are added by ns:BuildGoodNewsMessage and
                are deliberately out of reach: they are how a recipient recognizes
                where the whisper came from.

                Emptying the box restores the default rather than sending a
                prefix with nothing after it -- turning the feature off is what
                the enable toggle above is for.
            ]]
			messageInput = {
				type = "input",
				name = "",
				desc = MessageHelp(),
				width = MESSAGE_INPUT_WIDTH,
				order = 9,
				hidden = GoodNewsHidden,
				get = function()
					return ns.db.profile.goodNews.message
				end,
				set = function(_, val)
					val = ns.TrimToBytes(val or "", MESSAGE_MAX)
					if val:match("^%s*$") then
						val = L["DEFAULT_GOOD_NEWS"]
					end
					ns.db.profile.goodNews.message = val
				end,
			},
			-- Same row as the label and box, same "half" width and shared wording
			-- as the Thank You Button's: the two panels offer the identical
			-- affordance and should not look like two different features.
			resetMessage = {
				type = "execute",
				name = L["WHISPER_MESSAGE_RESET"],
				desc = L["WHISPER_MESSAGE_RESET_DESCRIPTION"],
				width = RESET_WIDTH,
				order = 10,
				hidden = GoodNewsHidden,
				func = function()
					ns.db.profile.goodNews.message = L["DEFAULT_GOOD_NEWS"]
				end,
			},
			--[[
                A sample of the outgoing whisper, built by the SAME pipeline that
                sends the real one (their template, spell link, localized
                duration), so it can never drift from what recipients actually
                get -- and so an edit above is visible here immediately. Only the
                {rt1} chat marker is swapped for its texture, where the flavor
                sends one: chat renders the marker as the Star icon, but
                options-panel text does not.
            ]]
			sampleSpacer = ns.OptionsSpacer(12, GoodNewsHidden),
			sampleMessage = {
				type = "description",
				name = function()
					local link = ns.GetSpellLink(ns.GAME_IDS.SAMPLE_GOOD_NEWS_SPELL_ID) or ""
					local message = ns:BuildGoodNewsMessage(link, 15)
					return "   "
						.. message:gsub(ns.TARGET_MARKER, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:14|t", 1)
						.. "\n"
				end,
				fontSize = "medium",
				order = 13,
				hidden = GoodNewsHidden,
			},
			space3 = ns.OptionsSpacer(14, GoodNewsHidden),
			headerTracked = ns.OptionsHeader(L["TRACKED_HEADER"], 15, GoodNewsHidden),
			space4 = ns.OptionsSpacer(16, GoodNewsHidden),
		},
	}

	local categoryOrder = 20
	for _, category in ipairs(ns.GoodNewsCategories or {}) do
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
