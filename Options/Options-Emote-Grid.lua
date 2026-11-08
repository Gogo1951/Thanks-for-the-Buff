local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--[[
    The Give Thanks emote checklist: every emote this client offers, grouped
    by kind (Text, Voice, Gesture, Pose), four checkboxes to a line under a
    yellow header per group.

    Each group is ONE custom AceGUI widget, not one AceConfig toggle per emote.
    AceConfig rebuilds every widget on the page after each click, and ~255
    toggles made every checkbox freeze the screen for a second. The widget makes
    its checkboxes once and keeps them: AceGUI hands the same widget back on
    every page build, a redraw only re-reads the checked states, and a click
    writes straight to the profile without asking AceConfig for a rebuild.
]]

local COLUMNS = 4
local COLUMN_PX = ns.OPTIONS_ROW_WIDTH * 170 / COLUMNS -- 170: AceConfigDialog's pixels per width unit
-- 24, off the spacing scale on purpose: AceGUI's own CheckBox size, fitted to the game's checkbox art.
local CHECK_SIZE = 24
local ROW_HEIGHT = 24
local HEADER_HEIGHT = 24
local BOTTOM_PADDING = 8

-- Set by ns.DefineEmoteGrid; the widget only reads it.
local model

local DEFAULT_EMOTES = {}
for _, data in ipairs(Data.EMOTES) do
	DEFAULT_EMOTES[data.token] = true
end

--------------------------------------------------------------------------------
-- Checklist Widget
--------------------------------------------------------------------------------

local AceGUI = LibStub("AceGUI-3.0")
local WIDGET_TYPE, WIDGET_VERSION = "TFTB-EmoteChecklist", 1

local function HeaderText(group)
	local key = "EMOTE_GROUP_" .. group:upper()
	local picked, total = model.CountPicked(group)
	return GetColor("TITLE")
		.. L["EMOTE_GROUP_COUNT"]:format(L[key], picked, total)
		.. "|r  "
		.. GetColor("HELP")
		.. L[key .. "_DESCRIPTION"]
		.. "|r"
end

-- The same textures AceGUI's own CheckBox uses, so it matches on every client.
local function CreateCheck(widget)
	local check = CreateFrame("CheckButton", nil, widget.frame)
	check:SetSize(CHECK_SIZE, CHECK_SIZE)
	check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight", "ADD")
	check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	-- The label is part of the button, so clicking the command ticks it too.
	check:SetHitRectInsets(0, -(COLUMN_PX - CHECK_SIZE - 8), 0, 0)

	check.label = check:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	check.label:SetPoint("LEFT", check, "RIGHT", 2, 0)
	check.label:SetWidth(COLUMN_PX - CHECK_SIZE - 8)
	check.label:SetJustifyH("LEFT")
	check.label:SetWordWrap(false)

	check:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and 856 or 857)
		model.SetChecked(self.entry.token, checked)
		widget.header:SetText(HeaderText(widget.group))
	end)
	return check
end

local methods = {}

function methods:OnAcquire()
	self.group = nil
end

--[[
    AceConfigDialog treats the widget as a description and hands it the
    option's name, which is the group to show. It does so on every page build,
    so this is also the redraw.
]]
function methods:SetText(group)
	self.group = group
	self:Refresh()
end
function methods:SetFontObject() end
function methods:SetImage() end
function methods:SetImageSize() end

function methods:Refresh()
	local entries = self.group and model and model.GetEntries(self.group) or {}
	for index, entry in ipairs(entries) do
		local check = self.checks[index] or CreateCheck(self)
		self.checks[index] = check
		local column = (index - 1) % COLUMNS
		local row = math.floor((index - 1) / COLUMNS)
		check:ClearAllPoints()
		check:SetPoint("TOPLEFT", column * COLUMN_PX, -(HEADER_HEIGHT + row * ROW_HEIGHT))
		check.entry = entry
		check.label:SetText(entry.command)
		check:SetChecked(model.IsChecked(entry.token))
		check:Show()
	end
	for index = #entries + 1, #self.checks do
		self.checks[index]:Hide()
	end
	self.header:SetText(self.group and model and HeaderText(self.group) or "")
	local rows = math.ceil(#entries / COLUMNS)
	self.frame:SetHeight(HEADER_HEIGHT + rows * ROW_HEIGHT + BOTTOM_PADDING)
end

local function Constructor()
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:Hide()
	frame:SetHeight(HEADER_HEIGHT)

	local widget = { frame = frame, type = WIDGET_TYPE, checks = {} }
	for name, method in pairs(methods) do
		widget[name] = method
	end

	widget.header = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	widget.header:SetPoint("TOPLEFT", 0, -2)
	widget.header:SetPoint("RIGHT")
	widget.header:SetJustifyH("LEFT")

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(WIDGET_TYPE, Constructor, WIDGET_VERSION)

--------------------------------------------------------------------------------
-- Checklist Options
--------------------------------------------------------------------------------

--[[
    Adds the emote checklist straight into a panel's args, at `order` ..
    `order + 0.1`. `settings` returns ns.db.profile.strangers.
]]
function ns.DefineEmoteGrid(args, settings, order)
	-- Each group's emotes, in the catalog's slash-command order.
	local byGroup = {}
	for _, group in ipairs(Data.EMOTE_GROUPS) do
		byGroup[group] = {}
	end
	for _, entry in ipairs(ns.GetEmoteCatalog()) do
		local group = ns.GetEmoteGroup(entry.token)
		if byGroup[group] then
			table.insert(byGroup[group], entry)
		end
	end

	model = {}

	function model.GetEntries(group)
		return byGroup[group] or {}
	end

	function model.IsChecked(token)
		local emotes = settings().emotes
		return emotes and emotes[token] and true or false
	end

	function model.CountPicked(group)
		local picked = 0
		for _, entry in ipairs(model.GetEntries(group)) do
			if model.IsChecked(entry.token) then
				picked = picked + 1
			end
		end
		return picked, #model.GetEntries(group)
	end

	function model.SetChecked(token, value)
		local emotes = settings().emotes
		--[[
		    An unticked default stores false: left nil, AceDB would fill the
		    default back in at the next login.
		]]
		if value then
			emotes[token] = true
		elseif DEFAULT_EMOTES[token] then
			emotes[token] = false
		else
			emotes[token] = nil
		end
	end

	args.emoteGridDesc = ns.OptionsDesc(L["EMOTES_GRID_DESCRIPTION"], order)
	args.emoteGridDescSpacer = ns.OptionsSpacer(order + 0.01)

	for index, group in ipairs(Data.EMOTE_GROUPS) do
		args["emoteGrid_" .. group] = {
			type = "description",
			name = group,
			dialogControl = WIDGET_TYPE,
			width = "full",
			order = order + 0.02 + index * 0.01,
			-- A flavor with no emotes of a kind shows no empty header for it.
			hidden = #byGroup[group] == 0,
		}
	end

	args.emoteGridReset = {
		type = "execute",
		name = L["EMOTES_RESET"],
		desc = L["EMOTES_RESET_DESCRIPTION"],
		order = order + 0.1,
		confirm = true,
		confirmText = L["EMOTES_RESET_CONFIRM"],
		func = function()
			local emotes = {}
			for token in pairs(DEFAULT_EMOTES) do
				emotes[token] = true
			end
			settings().emotes = emotes
			LibStub("AceConfigRegistry-3.0"):NotifyChange(ns.OPTIONS_REGISTRY.EmotesList)
		end,
	}
end
