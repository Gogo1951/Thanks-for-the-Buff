local ADDON_NAME, ns = ...
local Data = ns.Data
local L = ns.L
local GetColor = ns.GetColor

local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")

--[[
    The mini-map button: a launcher of feature switches. Each click flips one
    feature through ns.SetFeatureSwitch, the same path as its options toggle,
    Buff Duty's only for the class you're playing, and Shift + Middle-Click
    opens the options panel. Wears the Thank You macro's ribbon.
]]

--------------------------------------------------------------------------------
-- Features
--------------------------------------------------------------------------------

--[[
    One tooltip block per click, in tooltip order. key is the feature's
    ns.FEATURE_SWITCHES key; name and desc are its panel's locale keys.
]]
local FEATURE_CLICKS = {
	{ key = "strangers", name = "TAB_STRANGERS", desc = "STRANGERS_DESCRIPTION", click = "LEFT_CLICK" },
	{ key = "teammates", name = "TAB_TEAMMATES", desc = "TEAMMATES_DESCRIPTION", click = "RIGHT_CLICK" },
	{ key = "goodNews", name = "TAB_GOOD_NEWS", desc = "GOOD_NEWS_DESCRIPTION", click = "SHIFT_LEFT_CLICK" },
	{ key = "buffWindow", name = "TAB_BUFF_WINDOW", desc = "BUFF_WINDOW_DESCRIPTION", click = "SHIFT_RIGHT_CLICK" },
}

-- The feature each mouse button flips, with Shift and without.
local CLICK_FEATURES = {
	LeftButton = { plain = "strangers", shift = "goodNews" },
	RightButton = { plain = "teammates", shift = "buffWindow" },
}

--[[
    Buff Duty's click is per class, like the window's close button: off
    leaves the window up on your other classes, and on ticks your class.
]]
local function IsOn(key)
	if key == "buffWindow" and ns.IsBuffDutyOnForClass then
		return ns.IsBuffDutyOnForClass()
	end
	return ns.IsFeatureOn(key)
end

local function Toggle(key)
	if key == "buffWindow" and ns.SetBuffDutyForClass then
		ns.SetBuffDutyForClass(not IsOn(key))
	else
		ns.SetFeatureSwitch(key, not IsOn(key))
	end
end

--------------------------------------------------------------------------------
-- Tooltip
--------------------------------------------------------------------------------

local function RefreshTooltip(anchor)
	local tooltip = GameTooltip

	tooltip:SetOwner(anchor, "ANCHOR_BOTTOMLEFT")
	tooltip:ClearLines()

	tooltip:AddDoubleLine(GetColor("TITLE") .. L["ADDON_TITLE"] .. "|r", GetColor("MUTED") .. ns.Version .. "|r")
	tooltip:AddLine(" ")
	tooltip:AddLine(" ")

	for _, feature in ipairs(FEATURE_CLICKS) do
		local state = IsOn(feature.key) and (GetColor("ON") .. L["ENABLED"] .. "|r")
			or (GetColor("OFF") .. L["DISABLED"] .. "|r")
		tooltip:AddDoubleLine(GetColor("TITLE") .. L[feature.name] .. "|r", state)
		tooltip:AddLine(GetColor("BODY") .. L[feature.desc] .. "|r", 1, 1, 1, true)
		tooltip:AddDoubleLine(
			GetColor("INFO") .. L[feature.click] .. "|r",
			GetColor("INFO") .. L["ACTION_TOGGLE"] .. "|r"
		)
		tooltip:AddLine(" ")
	end

	tooltip:AddLine(GetColor("TITLE") .. L["MINIMAP_OPTIONS"] .. "|r")
	tooltip:AddLine(GetColor("INFO") .. L["SHIFT_MIDDLE_CLICK"] .. "|r")

	tooltip:Show()
end

--------------------------------------------------------------------------------
-- LDB Data Object
--------------------------------------------------------------------------------

ns.dataBrokerObject = LibDataBroker:NewDataObject(ADDON_NAME, {
	type = "launcher",
	text = L["ADDON_SHORT"],
	icon = Data.THANK_YOU_DEFAULT_ICON,

	OnClick = function(self, button)
		if IsShiftKeyDown() and button == "MiddleButton" then
			ns:OpenOptionsPanel()
			return
		end

		local features = CLICK_FEATURES[button]
		if not features or not ns.db then
			return
		end
		local key = IsShiftKeyDown() and features.shift or features.plain
		Toggle(key)

		if GameTooltip:GetOwner() == self then
			RefreshTooltip(self)
		end
	end,

	OnEnter = function(self)
		RefreshTooltip(self)
	end,

	OnLeave = function()
		GameTooltip:Hide()
	end,
})

--------------------------------------------------------------------------------
-- Button Registration
--------------------------------------------------------------------------------

-- Called from Core's login sequence once ns.db exists, since the button's position lives in ns.db.profile.minimap.
function ns.RegisterMinimapButton()
	LibDBIcon:Register(ADDON_NAME, ns.dataBrokerObject, ns.db.profile.minimap)

	if ns.FLAVOR == "Camelot" or ns.FLAVOR == "Mainline" then
		--[[
		    Size and anchor the icon directly rather than through
		    SetButtonIcon: that first runs LibDBIcon's ResetButtonIcon, which
		    calls icon:UpdateCoord() and errors when another add-on has
		    rebuilt or replaced the button's icon without that method.
		]]
		local button = LibDBIcon:GetMinimapButton(ADDON_NAME)
		if button and button.icon then
			button.icon:SetSize(20, 20)
			button.icon:ClearAllPoints()
			button.icon:SetPoint("CENTER", 1, -0.35)
			local mask = button:CreateMaskTexture()
			mask:SetTexture(130924, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE") -- Interface\CharacterFrame\TempPortraitAlphaMask
			mask:SetAllPoints(button.icon)
			button.icon:AddMaskTexture(mask)
		end
	end
end

--[[
    Shows or hides the button from the saved `hide` flag, and re-points it at
    the active profile's table after a profile switch, copy or reset.
]]
function ns.RefreshMinimapButton()
	LibDBIcon:Refresh(ADDON_NAME, ns.db.profile.minimap)
end
