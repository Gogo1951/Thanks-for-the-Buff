local _, ns = ...
local L = ns.L

local GetColor = ns.GetColor

-- The message row mirrors the Thank You Button's: a caption-sized label so the
-- edit box keeps the rest of the row and a whole sentence stays readable.
local MESSAGE_LABEL_WIDTH = 0.9
local MESSAGE_INPUT_WIDTH = ns.OPTIONS_ROW_WIDTH - MESSAGE_LABEL_WIDTH

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
			enable = {
				type = "toggle",
				name = L["GOOD_NEWS_WHISPER_ENABLE"],
				desc = L["GOOD_NEWS_WHISPER_DESCRIPTION"],
				width = ns.OPTIONS_LABEL_WIDTH,
				order = 3,
				get = function()
					return ns.db.profile.goodNews.whisperEnabled
				end,
				set = function(_, val)
					ns.db.profile.goodNews.whisperEnabled = val
				end,
			},
			-- Who gets whispered, on the master's row. Unlabeled on purpose: the
			-- values are self-describing, and the enable toggle beside it reads as
			-- the caption. Takes the control half of the row so neither value clips.
			scope = {
				type = "select",
				name = "",
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
			space1 = { type = "description", name = " ", order = 5, hidden = GoodNewsHidden },
			headerMessages = ns.OptionsHeader(L["GOOD_NEWS_MESSAGES_HEADER"], 6, GoodNewsHidden),
			space2 = { type = "description", name = " ", order = 7, hidden = GoodNewsHidden },
			messageLabel = ns.OptionsRowLabel(L["GOOD_NEWS_MESSAGE"], 8, MESSAGE_LABEL_WIDTH, GoodNewsHidden),
			--[[
                The editable body only. The star marker and the "TFTB // " prefix
                are added by ns:BuildGoodNewsMessage and are deliberately out of
                reach: they are how a recipient recognizes where the whisper came
                from.

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
				name = L["BUTTON_RESET"],
				desc = L["BUTTON_RESET_DESCRIPTION"],
				width = "half",
				order = 10,
				hidden = GoodNewsHidden,
				func = function()
					ns.db.profile.goodNews.message = L["DEFAULT_GOOD_NEWS"]
				end,
			},
			-- Silver, one line, below the row it explains: the palette's HELP is
			-- the addon's colour for exactly this kind of aside.
			messageHelp = {
				type = "description",
				name = GetColor("HELP") .. MessageHelp() .. "|r",
				fontSize = "medium",
				order = 11,
				hidden = GoodNewsHidden,
			},
			--[[
                A sample of the outgoing whisper, built by the SAME pipeline that
                sends the real one (their template, spell link, localized
                duration), so it can never drift from what recipients actually
                get -- and so an edit above is visible here immediately. Only the
                {rt1} chat marker is swapped for its texture: chat renders the
                marker as the Star icon, but options-panel text does not.
            ]]
			sampleSpacer = { type = "description", name = " ", order = 12, hidden = GoodNewsHidden },
			sampleMessage = {
				type = "description",
				name = function()
					local link = ns.GetSpellLink(10060) or "" -- Power Infusion
					local message = ns:BuildGoodNewsMessage(link, 15)
					return "   "
						.. message:gsub(ns.TARGET_MARKER, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:14|t", 1)
						.. "\n"
				end,
				fontSize = "medium",
				order = 13,
				hidden = GoodNewsHidden,
			},
			space3 = { type = "description", name = " ", order = 14, hidden = GoodNewsHidden },
			headerTracked = ns.OptionsHeader(L["TRACKED_HEADER"], 15, GoodNewsHidden),
			space4 = { type = "description", name = " ", order = 16, hidden = GoodNewsHidden },
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
