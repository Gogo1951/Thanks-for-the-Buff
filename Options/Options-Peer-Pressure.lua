local _, ns = ...
local L = ns.L

local GetColor = ns.GetColor

--[[
    TEMPORARY -- delete on or after 2026-11-21 (30 days after the release that
    moved Peer Pressure to Control Freak). To delete: remove this file and its
    line in TFTB_Vanilla.toc and TFTB_TBC.toc, the "if ns.BuildPeerPressureOptions"
    block in Options/Options.lua, the PeerPressure key in ns.OPTIONS_REGISTRY
    and ns.CONTROL_FREAK_URL (Data/Data.lua), the TAB_PEER_PRESSURE and
    PEER_PRESSURE_MOVED keys from all 11 Locales/*.lua files, and the
    PEER_PRESSURE_CONTROL_FREAK key from every Locales/*.lua file that has it.
    Nothing else references it. Any pass that
    finds this date in the past deletes it, no question asked.

    "Peer Pressure" panel, kept where the feature's panel used to sit so its
    players find where it went: the notice, and a box holding Control Freak's
    link to copy. The Camelot TOC leaves this file out: WoW Forever never had
    Peer Pressure and doesn't run Control Freak.
]]

-- The caption is the add-on's name, so the label takes a little more than the Feedback panel's.
local LINK_LABEL_WIDTH = 0.9

function ns.BuildPeerPressureOptions()
	return {
		name = L["TAB_PEER_PRESSURE"],
		type = "group",
		args = {
			descMoved = ns.OptionsDesc(GetColor("INFO") .. L["PEER_PRESSURE_MOVED"] .. "|r", 1),
			space0 = ns.OptionsSpacer(2),
			labelLink = ns.OptionsRowLabel(
				GetColor("TITLE") .. L["PEER_PRESSURE_CONTROL_FREAK"] .. "|r",
				3,
				LINK_LABEL_WIDTH
			),
			urlLink = {
				type = "input",
				name = "",
				order = 4,
				width = ns.OPTIONS_ROW_WIDTH - LINK_LABEL_WIDTH,
				get = function()
					return ns.CONTROL_FREAK_URL
				end,
				set = function() end,
			},
			copyCaption = ns.OptionsDesc(GetColor("HELP") .. L["OPTIONS_COPY_LINK"] .. "|r", 5),
		},
	}
end
