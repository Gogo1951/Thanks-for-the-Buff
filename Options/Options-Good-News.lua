local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--[[
    "Good News" panel -- a whisper telling a player what you just cast on them
    (settings under goodNews). Sections in order: who gets it, then the
    whisper's composer. Which abilities count is a child panel of its own,
    Tracked Abilities (Options-Good-News-Abilities.lua).
]]

--------------------------------------------------------------------------------
-- Example Lines
--------------------------------------------------------------------------------

--[[
    The sample: Power Infusion, a Priest's, given to the house Mage for 15
    seconds, so the Example line, the Too Long check and Send Test to Me all
    measure and send the same message, duration clause included.
]]
local SAMPLE_RECIPIENT_CLASS = "MAGE"
local SAMPLE_SECONDS = 15

local function SampleLink()
	return ns.GetSpellLink(ns.GAME_IDS.SAMPLE_GOOD_NEWS_SPELL_ID) or ""
end

local function SampleRecipient()
	return ns.SAMPLE_NAMES[SAMPLE_RECIPIENT_CLASS]
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.BuildGoodNewsOptions()
	local function settings()
		return ns.db.profile.goodNews
	end

	local options = {
		name = L["TAB_GOOD_NEWS"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["GOOD_NEWS_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),

			--[[
			    Master switch: everything below it hides when off, and the feature
			    itself stops -- see the `enabled` gate in Features/Good-News.lua.
			    Its twin sits in the General panel's Features section.
			]]
			enable = ns.OptionsFeatureToggle(ns.GetFeatureSwitch("goodNews"), 3),
			enableSpacer = ns.OptionsSpacer(4),

			-- Who gets it, on its own label-beside-control row.
			scopeLabel = ns.OptionsRowLabel(L["GOOD_NEWS_SCOPE"], 5, nil, nil, L["GOOD_NEWS_SCOPE_DESCRIPTION"]),
			scope = {
				type = "select",
				name = "",
				desc = L["GOOD_NEWS_SCOPE_DESCRIPTION"],
				width = ns.OPTIONS_CONTROL_WIDTH,
				order = 5.1,
				values = {
					ALWAYS = L["GOOD_NEWS_SCOPE_ALWAYS"],
					GROUP = L["GOOD_NEWS_SCOPE_GROUP"],
				},
				sorting = Data.GOOD_NEWS_SCOPES,
				get = function()
					-- Anything but ALWAYS reads as GROUP, as the feature does, so a stale value never shows blank.
					return settings().scope == "ALWAYS" and "ALWAYS" or "GROUP"
				end,
				set = function(_, value)
					settings().scope = value
				end,
			},
			scopeSpacer = ns.OptionsSpacer(6),

			headerWhisper = ns.OptionsHeader(L["GOOD_NEWS_WHISPER_HEADER"], 10),
			spaceWhisper = ns.OptionsSpacer(10.5),
			descWhisper = ns.OptionsDesc(L["GOOD_NEWS_WHISPER_DESCRIPTION"], 10.6),
			spaceWhisperDesc = ns.OptionsSpacer(10.8),
			-- 11 through 11.36 belong to the whisper composer, added below.
			spaceAfterWhisper = ns.OptionsSpacer(12),
		},
	}

	ns.DefineWhisperComposer(options.args, {
		settings = settings,
		hidden = function()
			return false
		end,
		default = ns.GetDefaultGoodNewsWhisper,
		fill = function(text)
			return ns.FillGoodNewsWhisper(text, SampleLink(), SampleRecipient(), SAMPLE_SECONDS)
		end,
		build = function(text)
			return ns:BuildGoodNewsWhisper(text, SampleLink(), SampleRecipient(), SAMPLE_SECONDS)
		end,
		test = function(text)
			ns:WhisperGoodNewsTest(text, SampleLink(), SampleRecipient(), SAMPLE_SECONDS)
		end,
		tokens = function()
			local info, help = GetColor("INFO"), GetColor("HELP")
			return L["GOOD_NEWS_TOKENS"]:format(info .. "{spell}" .. help, info .. "{name}" .. help)
		end,
		description = L["GOOD_NEWS_MESSAGE_DESCRIPTION"],
	}, 11)

	-- Intro text and the switch itself stay; everything else follows the switch.
	ns.HideAllExcept(options.args, function()
		return not settings().enabled
	end, { descIntro = true, space0 = true, enable = true })

	return options
end
