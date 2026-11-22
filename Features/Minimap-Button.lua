local ADDON_NAME, ns = ...
local Data = ns.Data
local L = ns.L

local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")

--[[
    The mini-map button: a launcher wearing the Thank You macro's ribbon.
    Hovering opens the menu (Features/Minimap-Menu.lua) and a click runs its
    job from the menu's click table; a Left-Click opens and holds the menu.
    OnEnter rather than OnTooltipShow, since LibDBIcon and every LDB display
    call it on hover, and the menu closes itself once the cursor leaves, so
    OnLeave has nothing to do.
]]
ns.dataBrokerObject = LibDataBroker:NewDataObject(ADDON_NAME, {
	type = "launcher",
	label = L["ADDON_TITLE"],
	icon = Data.THANK_YOU_DEFAULT_ICON,

	OnClick = function(self, button)
		if ns.minimapMenu then
			ns.minimapMenu:HandleClick(self, button)
		end
	end,

	OnEnter = function(self)
		if ns.minimapMenu then
			ns.minimapMenu:Show(self, "hover")
		end
	end,

	OnLeave = function() end,
})

--[[
    Called from Core's login sequence once ns.db exists. The button's position
    and its Enable Mini-map Button switch live in the profile, so a profile
    switch or reset moves it too (ns:ApplyMinimapButton).
]]
function ns:RegisterMinimapButton()
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

-- Puts the button where the active profile has it, shown or hidden as its switch says.
function ns:ApplyMinimapButton()
	if not ns.db then
		return
	end
	LibDBIcon:Refresh(ADDON_NAME, ns.db.profile.minimap)
end
