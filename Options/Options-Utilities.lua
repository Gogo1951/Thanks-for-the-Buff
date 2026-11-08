local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--------------------------------------------------------------------------------
-- Shared Options Helpers
--------------------------------------------------------------------------------

--[[
    Every section header in the add-on is a real AceConfig "header" -- the ruled
    line with the title set into it -- and no panel draws its own out of a colored
    description. `hidden` is optional (a function or a boolean) here and on
    OptionsDesc and OptionsSpacer, for the panels whose whole section collapses
    behind a master switch.
]]
function ns.OptionsHeader(text, order, hidden)
	return { type = "header", name = GetColor("TITLE") .. text .. "|r", order = order, hidden = hidden }
end

function ns.OptionsDesc(text, order, hidden)
	return { type = "description", name = text, fontSize = "medium", order = order, hidden = hidden }
end

function ns.OptionsSpacer(order, hidden)
	return { type = "description", name = " ", order = order, hidden = hidden }
end

--[[
    The left half of a label-beside-control row: the control that follows carries
    name = "" and ns.OPTIONS_CONTROL_WIDTH, so the two total one row and flow onto
    the same line. A row whose control needs more room passes its own width here.
]]
function ns.OptionsRowLabel(text, order, width, hidden)
	return {
		type = "description",
		name = text,
		fontSize = "medium",
		width = width or ns.OPTIONS_LABEL_WIDTH,
		order = order,
		--[[
		    A label has no state of its own, so nothing hides it unless it is told
		    to: on a panel behind a master switch, one left out is the caption that
		    stays floating after everything it described has gone.
		]]
		hidden = hidden,
	}
end

--[[
    A copyable link: a short caption beside a read-only box holding the full URL.
    The caption is one short word, so it takes less than the usual label width
    and the box the rest of the row. Fills `order` and `order + 1`.
]]
local LINK_LABEL_WIDTH = 0.6

function ns.OptionsLinkRow(args, key, caption, url, order)
	args["label" .. key] = ns.OptionsRowLabel(GetColor("TITLE") .. caption .. "|r", order, LINK_LABEL_WIDTH)
	args["url" .. key] = {
		type = "input",
		name = "",
		order = order + 1,
		width = ns.OPTIONS_ROW_WIDTH - LINK_LABEL_WIDTH,
		get = function()
			return url
		end,
		set = function() end,
	}
end

--------------------------------------------------------------------------------
-- Feature Switches
--------------------------------------------------------------------------------

--[[
    Every feature's on/off switch, built once here and placed twice: at the top
    of the feature's own panel and in the General panel's Features section. Both
    copies bind the same setting and carry the same caption and tooltip, and
    flipping either repaints every panel so the other copy and the settings it
    hides follow at once.
]]
ns.FEATURE_SWITCHES = {
	--[[
	    key: the profile subtable, setting: its on/off field, name/desc: locale keys,
	    onChange: present only for a feature that must react the moment either copy flips.
	]]
	{ key = "strangers", setting = "enabled", name = "STRANGERS_ENABLE", desc = "STRANGERS_ENABLE_DESCRIPTION" },
}

local function NotifyAllPanels()
	local registry = LibStub("AceConfigRegistry-3.0")
	for _, name in pairs(ns.OPTIONS_REGISTRY) do
		registry:NotifyChange(name)
	end
end

function ns.OptionsFeatureToggle(feature, order, width)
	return {
		type = "toggle",
		name = L[feature.name],
		desc = L[feature.desc],
		width = width or "full",
		order = order,
		get = function()
			return ns.db.profile[feature.key][feature.setting]
		end,
		set = function(_, value)
			ns.SetFeatureSwitch(feature.key, value)
		end,
	}
end

function ns.GetFeatureSwitch(key)
	for _, feature in ipairs(ns.FEATURE_SWITCHES) do
		if feature.key == key then
			return feature
		end
	end
	return nil
end

function ns.IsFeatureOn(key)
	local feature = ns.GetFeatureSwitch(key)
	return ns.db.profile[key][feature.setting] and true or false
end

--[[
    Flips a feature from either copy of its toggle, so each one reacts and
    every open panel repaints the same way.
]]
function ns.SetFeatureSwitch(key, value)
	local feature = ns.GetFeatureSwitch(key)
	ns.db.profile[key][feature.setting] = value
	if feature.onChange then
		feature.onChange()
	end
	NotifyAllPanels()
end

--[[
    Lays toggles out two to a line, each pair in its own unnamed inline group so
    every pair pins its own row. The widths leave slack under
    ns.OPTIONS_ROW_WIDTH: a row summing exactly to the pane sits on the wrap
    boundary and can drop its second toggle onto a line of its own.
]]
local TOGGLE_PAIR_WIDTH = (ns.OPTIONS_ROW_WIDTH - 0.2) / 2

function ns.OptionsTogglePairs(args, keyPrefix, startOrder, toggles)
	for index = 1, #toggles, 2 do
		local pair = {}
		for offset = 0, 1 do
			local toggle = toggles[index + offset]
			if toggle then
				toggle.width = TOGGLE_PAIR_WIDTH
				toggle.order = offset + 1
				pair["toggle" .. (offset + 1)] = toggle
			end
		end
		args[keyPrefix .. index] = {
			type = "group",
			name = "",
			inline = true,
			order = startOrder + index,
			args = pair,
		}
	end
end

--------------------------------------------------------------------------------
-- Emote Picker
--------------------------------------------------------------------------------

--[[
    Shared by the emote picker and the blank line above it, so both disappear
    together when the panel's emotes are switched off.
]]
function ns.EmotesHidden(settings)
	return function()
		return not settings().emotesEnabled
	end
end

--[[
    The emote picker: one half-width toggle per entry in Data.EMOTES, inline under
    the panel's Enable Emotes toggle and hidden along with it. Stranger Buffs and
    Thank You Button 1 both draw it; a button overrides `hidden`, since it has no
    Enable Emotes toggle.
]]
function ns.DefineEmoteGroup(settings, order)
	local group = {
		type = "group",
		name = L["EMOTES_SELECT"],
		order = order,
		inline = true,
		hidden = ns.EmotesHidden(settings),
		args = {},
	}

	for i, emoteData in ipairs(Data.EMOTES) do
		local emote = emoteData.token
		group.args[emote] = {
			type = "toggle",
			name = ns.GetEmoteCommand(emote),
			desc = emoteData.desc,
			order = i,
			width = "half",
			get = function()
				return settings().emotes[emote]
			end,
			set = function(_, value)
				settings().emotes[emote] = value
			end,
		}
	end

	return group
end
