local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--[[
    The Buff Window's frames: draws the sections Features/Buff-Window.lua builds
    as a click-to-cast list. Every icon is a SecureActionButtonTemplate button,
    because casting a spell from a click is protected -- and that one fact shapes
    this file. A secure button's attributes, position and visibility can only
    change out of combat, so everything that lays the window out refuses to run
    in combat, and the caller redraws once combat ends. Mid-fight only alpha
    (the range fade), which the client allows on a protected frame, and the
    cooldown swipes, plain children of the buttons, still change.

    Two frames stack so combat visibility and our own never fight: the anchor
    belongs to a secure state driver (Hide in Combat), and the content inside it
    is shown and hidden by this file, out of combat only.
]]

--------------------------------------------------------------------------------
-- Layout
--------------------------------------------------------------------------------

local ICON_SIZE = Data.BUFF_WINDOW_ICON_SIZE
local ICON_GAP = 4
-- An icon plus the same 4-pixel gap between rows as between icons.
local ROW_HEIGHT = ICON_SIZE + ICON_GAP
--[[
    Extra room under each section (a party, Return the Favor, Target), so one
    party's last member doesn't crowd the next party's header.
]]
local SECTION_GAP = 4
--[[
    The name column fits the longest name on the list, between these bounds:
    never narrower than a short name needs to look tidy, and never so wide that a
    long title-and-realm string pushes the icons off across the screen.
]]
local MIN_NAME_WIDTH = 80
local MAX_NAME_WIDTH = 260
-- Room between the end of the longest name and the first icon.
local NAME_GAP = 8
local MEMBER_INDENT = 10
-- A pet sits one step further in, under its owner.
local PET_INDENT = 20
local PADDING = 7
local OUT_OF_RANGE_ALPHA = 0.35
local RANGE_INTERVAL = 0.5

--[[
    Where the window's top-left corner sits until it is first dragged: a little
    left of and above the middle of the screen.
]]
local DEFAULT_X, DEFAULT_Y = -110, 160

local BACKDROP = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	edgeSize = 12,
	insets = { left = 3, right = 3, top = 3, bottom = 3 },
}

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local anchor, content
local labels, icons = {}, {}
local usedLabels, usedIcons = 0, 0
local lastSignature
local rangeTicker

--------------------------------------------------------------------------------
-- Position
--------------------------------------------------------------------------------

local function RestorePosition()
	local point = ns.db.profile.buffWindow.point
	anchor:ClearAllPoints()
	if point then
		anchor:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", point[1], point[2])
	else
		anchor:SetPoint("TOPLEFT", UIParent, "CENTER", DEFAULT_X, DEFAULT_Y)
	end
end

--[[
    Saved as the top-left corner, so a window that grows or shrinks with the
    list keeps its top edge where the player put it.
]]
local function SavePosition()
	ns.db.profile.buffWindow.point = { anchor:GetLeft(), anchor:GetTop() }
end

--------------------------------------------------------------------------------
-- Icons
--------------------------------------------------------------------------------

local function OnIconEnter(self)
	local spec = self.spec
	if not spec then
		return
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetSpellByID(spec.spellId)
	GameTooltip:AddLine(" ")
	local hint = (spec.favorGUID and L["BUFF_WINDOW_TOOLTIP_FAVOR"])
		or (spec.isGroup and L["BUFF_WINDOW_TOOLTIP_GROUP"])
		or L["BUFF_WINDOW_TOOLTIP_CAST"]
	GameTooltip:AddLine(GetColor("INFO") .. hint:format(spec.targetName) .. "|r", 1, 1, 1, true)
	if spec.favorGUID then
		GameTooltip:AddLine(
			GetColor("INFO") .. L["BUFF_WINDOW_TOOLTIP_DISMISS"]:format(spec.targetName) .. "|r",
			1,
			1,
			1,
			true
		)
	end
	GameTooltip:Show()
end

local function OnIconLeave()
	GameTooltip:Hide()
end

--[[
    Right-click on a favor drops that stranger from the list. Buttons register
    both up and down (below), so this answers the up half only.
]]
local function OnIconPostClick(self, button, down)
	if button == "RightButton" and not down and self.spec and self.spec.favorGUID then
		ns.DismissFavor(self.spec.favorGUID)
	end
end

local function AcquireIcon()
	usedIcons = usedIcons + 1
	local button = icons[usedIcons]
	if not button then
		button = CreateFrame("Button", nil, content, "SecureActionButtonTemplate")
		button:SetSize(ICON_SIZE, ICON_SIZE)
		--[[
		    Both halves: the secure template acts on the one ActionButtonUseKeyDown
		    names and ignores the other, so registering only "AnyUp" leaves the
		    button dead for anyone casting on key down.
		]]
		button:RegisterForClicks("AnyUp", "AnyDown")
		button.icon = button:CreateTexture(nil, "ARTWORK")
		button.icon:SetAllPoints()
		-- Trims the baked-in border every spell icon carries.
		button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		--[[
		    The action bar's own swipe and countdown, so a buff still on cooldown
		    reads exactly as it would on a bar (OmniCC and friends pick it up too).
		    A plain child of the secure button, so it updates freely in combat.
		]]
		button.cooldown = CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate")
		button.cooldown:SetAllPoints()
		button.cooldown:SetHideCountdownNumbers(false)
		-- The template's numbers are sized for a 36-pixel bar button; ours is 20.
		if button.cooldown.SetCountdownFont then
			button.cooldown:SetCountdownFont("GameFontHighlightSmallOutline")
		end
		button:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square", "ADD")
		button:SetScript("OnEnter", OnIconEnter)
		button:SetScript("OnLeave", OnIconLeave)
		button:SetScript("PostClick", OnIconPostClick)
		icons[usedIcons] = button
	end
	return button
end

--[[
    Left button only ("type1"): a right-click finds no "type2" and no bare
    "type" to fall back on, so it casts nothing and is free for dismissing a
    favor. Every attribute is written on every use, nil included, because a
    pooled button still carries whatever its last spec set.
]]
local function SetIcon(button, spec)
	button.spec = spec
	button.icon:SetTexture(C_Spell.GetSpellTexture(spec.spellId))
	if spec.macrotext then
		button:SetAttribute("type1", "macro")
		button:SetAttribute("spell", nil)
		button:SetAttribute("unit", nil)
		button:SetAttribute("macrotext", spec.macrotext)
	else
		button:SetAttribute("type1", "spell")
		--[[
		    Rank text ("Name(Rank 2)") casts that exact rank through the secure
		    template's CastSpellByName; a bare name casts your highest. Not a spell
		    ID: the template hands a number to CastSpellByID, and on Classic Era a
		    lower rank's ID cast nothing. Group buffs pass the bare name.
		]]
		button:SetAttribute("spell", spec.castSpell or spec.spellName)
		button:SetAttribute("unit", spec.unit)
		button:SetAttribute("macrotext", nil)
	end
	button:Show()
end

--------------------------------------------------------------------------------
-- Labels
--------------------------------------------------------------------------------

local function AcquireLabel()
	usedLabels = usedLabels + 1
	local label = labels[usedLabels]
	if not label then
		label = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		label:SetJustifyH("LEFT")
		label:SetWordWrap(false)
		labels[usedLabels] = label
	end
	return label
end

--------------------------------------------------------------------------------
-- Cooldowns
--------------------------------------------------------------------------------

local function GetCooldown(spellId)
	local info = C_Spell.GetSpellCooldown(spellId)
	if info then
		return info.startTime, info.duration, info.modRate
	end
	return nil
end

--[[
    Draws each icon's cooldown the way an action button does, global cooldown
    included. Every rank shares one cooldown, so the spec's own id is enough. A
    value the client keeps secret leaves the swipe as it was rather than
    erroring; the next update after combat corrects it.
]]
local function UpdateCooldowns()
	if not content or not content:IsVisible() then
		return
	end
	for i = 1, usedIcons do
		local button = icons[i]
		local spec = button.spec
		local start, duration, modRate
		if spec then
			start, duration, modRate = GetCooldown(spec.spellId)
		end
		if ns.IsPlain(start) and ns.IsPlain(duration) then
			if start and duration and duration > 0 then
				button.cooldown:SetCooldown(start, duration, modRate or 1)
			else
				button.cooldown:Clear()
			end
		end
	end
end

local function OnSpellUpdateCooldown()
	UpdateCooldowns()
end

ns.SetEventHandler("SPELL_UPDATE_COOLDOWN", OnSpellUpdateCooldown)

--------------------------------------------------------------------------------
-- Range
--------------------------------------------------------------------------------

local function UpdateRange()
	if not content:IsVisible() then
		return
	end
	for i = 1, usedIcons do
		local button = icons[i]
		local spec = button.spec
		local inRange = not spec or ns.IsBuffInRange(spec.unit, spec.spellName)
		button:SetAlpha(inRange and 1 or OUT_OF_RANGE_ALPHA)
	end
end

local function StartRangeTicker()
	if not rangeTicker then
		rangeTicker = C_Timer.NewTicker(RANGE_INTERVAL, UpdateRange)
	end
end

local function StopRangeTicker()
	if rangeTicker then
		rangeTicker:Cancel()
		rangeTicker = nil
	end
end

--------------------------------------------------------------------------------
-- Render
--------------------------------------------------------------------------------

--[[
    Everything a redraw would write, as one string, so an unchanged list (the
    usual result of a raid's constant aura traffic) skips the redraw entirely.
]]
local function Signature(sections)
	local parts = {}
	local function AddIcons(list)
		for _, spec in ipairs(list) do
			parts[#parts + 1] = spec.column
				.. ":"
				.. (spec.castSpell or spec.spellName)
				.. "@"
				.. (spec.unit or "")
				.. (spec.macrotext or "")
		end
	end
	for _, section in ipairs(sections) do
		parts[#parts + 1] = "#" .. (section.grid or "") .. section.label
		AddIcons(section.icons)
		for _, row in ipairs(section.rows) do
			parts[#parts + 1] = (row.pet and ">>" or ">") .. row.label
			AddIcons(row.icons)
		end
	end
	return table.concat(parts, "|")
end

--[[
    A width of 0 lets the text run unconstrained, so the measure is the whole
    name rather than whatever fit the last layout's column.
]]
local function MeasureLabel(text, indent)
	local label = AcquireLabel()
	label:SetWidth(0)
	label:SetText(text)
	return label, indent + label:GetStringWidth()
end

--[[
    How tall a line's content stands: an icon's height for a row with icons or a
    player's row (its role icon is one too), only the text's for a bare header.
    The window's top and bottom edges are measured from this, so a header on top
    leaves no more room above it than the sides do.
]]
local function ContentHeight(line)
	if #line.specs > 0 or line.indent > 0 then
		return ICON_SIZE
	end
	return line.label:GetStringHeight()
end

-- `slots` maps a buff's column to its place in the grid (1 = first icon). `y` is the row's middle.
local function PlaceRow(label, indent, specs, y, nameWidth, slots)
	label:ClearAllPoints()
	label:SetPoint("LEFT", content, "TOPLEFT", PADDING + indent, y)
	label:SetWidth(nameWidth - indent)
	label:Show()

	local left = PADDING + nameWidth + NAME_GAP
	for _, spec in ipairs(specs) do
		local button = AcquireIcon()
		button:ClearAllPoints()
		button:SetPoint("LEFT", content, "TOPLEFT", left + (slots[spec.column] - 1) * (ICON_SIZE + ICON_GAP), y)
		SetIcon(button, spec)
	end
end

--[[
    The icons sit in a grid: one column per buff, so a buff lines up down the
    whole window and a party's group buff sits over the single one it
    replaces. A member who doesn't need a buff leaves its cell empty. Only the
    columns some icon uses are kept, in buff order, so a buff nobody needs
    leaves no gap.

    A section can name its own grid (Self Buffs does): its columns are other
    buffs than the parties', so lining them up with the parties' would only
    push them right. Returns grid -> (column -> slot), and the widest grid's
    slot count.
]]
local MAIN_GRID = "main"

local function GridSlots(sections)
	local used = {}
	local function Mark(grid, list)
		used[grid] = used[grid] or {}
		for _, spec in ipairs(list) do
			used[grid][spec.column] = true
		end
	end
	for _, section in ipairs(sections) do
		local grid = section.grid or MAIN_GRID
		Mark(grid, section.icons)
		for _, row in ipairs(section.rows) do
			Mark(grid, row.icons)
		end
	end

	local slotsByGrid, widest = {}, 0
	for grid, columnSet in pairs(used) do
		local columns = {}
		for column in pairs(columnSet) do
			columns[#columns + 1] = column
		end
		table.sort(columns)
		local slots = {}
		for slot, column in ipairs(columns) do
			slots[column] = slot
		end
		slotsByGrid[grid] = slots
		widest = math.max(widest, #columns)
	end
	return slotsByGrid, widest
end

local function ReleaseAll()
	for i = 1, usedLabels do
		labels[i]:Hide()
	end
	for i = 1, usedIcons do
		icons[i]:Hide()
		icons[i].spec = nil
	end
	usedLabels, usedIcons = 0, 0
end

function ns.RenderBuffWindow(sections)
	if InCombatLockdown() or not content then
		return
	end

	local signature = Signature(sections)
	if signature ~= lastSignature then
		lastSignature = signature
		ReleaseAll()

		--[[
		    Two passes: every label is measured before any is placed, because the
		    icon column starts where the longest name ends.
		]]
		local lines = {}
		local nameWidth = MIN_NAME_WIDTH
		local function Measure(text, indent, specs, grid)
			local label, width = MeasureLabel(text, indent)
			lines[#lines + 1] = { label = label, indent = indent, specs = specs, grid = grid }
			nameWidth = math.max(nameWidth, width)
		end
		for _, section in ipairs(sections) do
			local grid = section.grid or MAIN_GRID
			Measure(GetColor("TITLE") .. section.label .. "|r", 0, section.icons, grid)
			for _, row in ipairs(section.rows) do
				Measure(row.label, row.pet and PET_INDENT or MEMBER_INDENT, row.icons, grid)
			end
			lines[#lines].sectionEnd = true
		end
		nameWidth = math.min(math.ceil(nameWidth), MAX_NAME_WIDTH)

		local slotsByGrid, slotCount = GridSlots(sections)
		--[[
		    Rows sit ROW_HEIGHT apart, middle to middle, but the first and last
		    are measured by what they show: PADDING from the window's edge to the
		    top of the first line's content and from the bottom of the last's,
		    the same as the sides.
		]]
		local y = -(PADDING + ContentHeight(lines[1]) / 2)
		for index, line in ipairs(lines) do
			PlaceRow(line.label, line.indent, line.specs, y, nameWidth, slotsByGrid[line.grid])
			if index < #lines then
				y = y - ROW_HEIGHT
				if line.sectionEnd then
					y = y - SECTION_GAP
				end
			end
		end

		local iconsWidth = math.max(slotCount, 1) * (ICON_SIZE + ICON_GAP) - ICON_GAP
		local height = -y + ContentHeight(lines[#lines]) / 2 + PADDING
		anchor:SetSize(PADDING * 2 + nameWidth + NAME_GAP + iconsWidth, height)
	end

	content:Show()
	UpdateCooldowns()
	UpdateRange()
	StartRangeTicker()
end

function ns.HideBuffWindow()
	if InCombatLockdown() or not content then
		return
	end
	content:Hide()
	StopRangeTicker()
end

--------------------------------------------------------------------------------
-- Settings
--------------------------------------------------------------------------------

--[[
    Applies Hide in Combat and the saved position. Returns false when combat
    blocks it -- the state driver and the anchor are both protected then -- so
    the caller can apply it again once combat ends.
]]
function ns.ApplyBuffWindowSettings()
	if InCombatLockdown() or not anchor then
		return false
	end
	if ns.db.profile.buffWindow.hideInCombat then
		RegisterStateDriver(anchor, "visibility", "[combat] hide; show")
	else
		UnregisterStateDriver(anchor, "visibility")
		anchor:Show()
	end
	RestorePosition()
	-- A profile switch can change the list's settings without changing its rows.
	lastSignature = nil
	return true
end

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function ns.CreateBuffWindowFrame()
	anchor = CreateFrame("Frame", nil, UIParent)
	anchor:SetSize(1, 1)
	anchor:SetMovable(true)
	anchor:SetClampedToScreen(true)
	anchor:SetFrameStrata("MEDIUM")

	content = CreateFrame("Frame", nil, anchor, "BackdropTemplate")
	content:SetAllPoints(anchor)
	content:SetBackdrop(BACKDROP)
	content:SetBackdropColor(0, 0, 0, 0.75)
	content:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
	content:EnableMouse(true)
	content:RegisterForDrag("LeftButton")
	content:SetScript("OnDragStart", function()
		if not ns.db.profile.buffWindow.locked and not InCombatLockdown() then
			anchor:StartMoving()
		end
	end)
	content:SetScript("OnDragStop", function()
		anchor:StopMovingOrSizing()
		SavePosition()
	end)
	content:Hide()
end
