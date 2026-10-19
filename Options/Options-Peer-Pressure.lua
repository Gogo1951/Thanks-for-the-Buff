local _, ns = ...
local L = ns.L

--[[
    "Peer Pressure" panel -- the same-class cooldown alert (Features/Peer-Pressure.lua,
    data in this client's Data/{Game}/Peer-Pressure-Abilities-{Game}.lua). The
    tracked list lives in its own sub-panel (Options-Peer-Pressure-Tracked.lua).
    The enable switch at the top, twinned in the General
    panel's Features section, is the master; with both the print and the sound
    off, nothing fires either.
]]

function ns.BuildPeerPressureOptions()
	--[[
	    The enable toggle is the panel's master switch: everything below it hides
	    outright when Peer Pressure is off.
	]]
	local function PeerPressureHidden()
		return not ns.db.profile.peerPressure.enabled
	end
	--[[
	    The sample illustrates the PRINT, so it follows that toggle as well as the
	    master: showing an example of a message that is switched off reads as a
	    promise the add-on is not keeping.
	]]
	local function SampleHidden()
		return PeerPressureHidden() or not ns.db.profile.peerPressure.printEnabled
	end

	local options = {
		name = L["TAB_PEER_PRESSURE"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["PEER_PRESSURE_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),
			enable = ns.OptionsFeatureToggle(ns.GetFeatureSwitch("peerPressure"), 3),
			space1 = ns.OptionsSpacer(4, PeerPressureHidden),

			headerNotifications = ns.OptionsHeader(L["NOTIFICATIONS_HEADER"], 5, PeerPressureHidden),
			space2 = ns.OptionsSpacer(6, PeerPressureHidden),
			descNotifications = ns.OptionsDesc(L["NOTIFICATIONS_DESCRIPTION"], 6.3, PeerPressureHidden),
			spaceNotifications = ns.OptionsSpacer(6.6, PeerPressureHidden),
			printOut = {
				type = "toggle",
				name = L["NOTIFICATIONS_PRINT_ENABLE"],
				desc = L["PEER_PRESSURE_PRINT_DESCRIPTION"],
				width = "full",
				order = 7,
				hidden = PeerPressureHidden,
				get = function()
					return ns.db.profile.peerPressure.printEnabled
				end,
				set = function(_, value)
					ns.db.profile.peerPressure.printEnabled = value
				end,
			},
			sampleSpacer = ns.OptionsSpacer(8, SampleHidden),
			--[[
                An Example line for the alert, built by the SAME pipeline as the
                real print (prefix, class color, spell link), so it can never
                drift from what actually shows in chat: rogue-colored body,
                link-blue spell link.

                Sits under the PRINT toggle, not the master enable, because the
                print is the only setting it illustrates.
            ]]
			sampleMessage = ns.OptionsExample(function()
				return ns.GetPrintPrefix()
					.. ns:BuildPeerPressureMessage("ROGUE", "Expektor", ns.GAME_IDS.SAMPLE_PEER_PRESSURE_SPELL_ID, nil)
			end, 9, SampleHidden),
			space3 = ns.OptionsSpacer(10, PeerPressureHidden),
			ownCasts = {
				type = "toggle",
				name = L["PEER_PRESSURE_OWN_CASTS"],
				desc = L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"],
				width = "full",
				order = 11,
				hidden = PeerPressureHidden,
				get = function()
					return ns.db.profile.peerPressure.triggerOnOwnCasts
				end,
				set = function(_, value)
					ns.db.profile.peerPressure.triggerOnOwnCasts = value
				end,
			},
			space4 = ns.OptionsSpacer(12, PeerPressureHidden),
			-- Not full-width: the preview speaker sits on the same row.
			sound = {
				type = "toggle",
				name = L["NOTIFICATIONS_SOUND_ENABLE"],
				desc = L["PEER_PRESSURE_SOUND_DESCRIPTION"],
				order = 13,
				hidden = PeerPressureHidden,
				get = function()
					return ns.db.profile.peerPressure.soundEnabled
				end,
				set = function(_, value)
					ns.db.profile.peerPressure.soundEnabled = value
				end,
			},
			soundPreview = ns.DefineSoundPreview(ns.PlayPeerPressureSound, 14, PeerPressureHidden),
		},
	}

	return options
end
