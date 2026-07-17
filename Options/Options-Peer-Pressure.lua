local _, ns = ...
local L = ns.L

--[[
    "Peer Pressure" panel -- the same-class cooldown alert (Features/Peer-Pressure.lua,
    data in Data/Peer-Pressure-Abilities.lua). Renders one class-colored group per
    class with live entries (ns.PeerPressureCategories, built at login); toggles
    bind to peerPressure.watched. Only your own class's rows ever fire in play, but
    the default profile is shared account-wide, so every class is configurable
    from any character. The print / sound toggles are the enable -- with both
    off, nothing fires.
]]

function ns.BuildPeerPressureOptions()
	local function PeerPressureWatched()
		return ns.db.profile.peerPressure.watched
	end
	-- The enable toggle is the panel's master switch: everything below it hides
	-- outright when Peer Pressure is off.
	local function PeerPressureHidden()
		return not ns.db.profile.peerPressure.enabled
	end

	local options = {
		name = L["TAB_PEER_PRESSURE"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["PEER_PRESSURE_DESC"], 1),
			space0 = ns.OptionsSpacer(2),
			enable = {
				type = "toggle",
				name = L["PEER_PRESSURE_ENABLE"],
				width = "full",
				order = 4,
				get = function()
					return ns.db.profile.peerPressure.enabled
				end,
				set = function(_, val)
					ns.db.profile.peerPressure.enabled = val
				end,
			},
			headerMessaging = ns.OptionsSubHeader(L["MESSAGING_HEADER"], 5, PeerPressureHidden),
			printOut = {
				type = "toggle",
				name = L["MESSAGING_PRINT_ENABLE"],
				desc = L["PEER_PRESSURE_PRINT_DESC"],
				width = "full",
				order = 6,
				hidden = PeerPressureHidden,
				get = function()
					return ns.db.profile.peerPressure.printEnabled
				end,
				set = function(_, val)
					ns.db.profile.peerPressure.printEnabled = val
				end,
			},
			ownCasts = {
				type = "toggle",
				name = L["PEER_PRESSURE_OWN_CASTS"],
				desc = L["PEER_PRESSURE_OWN_CASTS_DESC"],
				width = "full",
				order = 6.5,
				hidden = PeerPressureHidden,
				get = function()
					return ns.db.profile.peerPressure.triggerOnOwnCasts
				end,
				set = function(_, val)
					ns.db.profile.peerPressure.triggerOnOwnCasts = val
				end,
			},
			-- Not full-width: the preview speaker sits on the same row.
			sound = {
				type = "toggle",
				name = L["MESSAGING_SOUND_ENABLE"],
				desc = L["PEER_PRESSURE_SOUND_DESC"],
				order = 7,
				hidden = PeerPressureHidden,
				get = function()
					return ns.db.profile.peerPressure.soundEnabled
				end,
				set = function(_, val)
					ns.db.profile.peerPressure.soundEnabled = val
				end,
			},
			soundPreview = ns.DefineSoundPreview(ns.PlayPeerPressureSound, 7.5, PeerPressureHidden),
			sampleSpacer = { type = "description", name = " ", order = 7.6, hidden = PeerPressureHidden },
			--[[
                A sample of the alert, built by the SAME pipeline as the real
                print (prefix, class color, spell link), so it can never drift
                from what actually shows in chat: rogue-colored body, link-blue
                spell link. Blade Flurry (13877) is live on every flavor.
            ]]
			sampleMessage = {
				type = "description",
				name = function()
					return "   "
						.. ns.GetPrintPrefix()
						.. ns:BuildPeerPressureMessage("ROGUE", "Expektor", 13877, nil)
						.. "\n"
				end,
				fontSize = "medium",
				order = 7.7,
				hidden = PeerPressureHidden,
			},
			headerTracked = ns.OptionsSubHeader(L["COMBAT_TRACKED"], 12, PeerPressureHidden),
			space2 = { type = "description", name = " ", order = 13, hidden = PeerPressureHidden },
		},
	}

	local categoryOrder = 20
	for _, category in ipairs(ns.PeerPressureCategories or {}) do
		local groupKey = "cat_" .. category.id
		options.args[groupKey] = {
			type = "group",
			name = category.name,
			order = categoryOrder,
			inline = true,
			hidden = PeerPressureHidden,
			args = {},
		}

		local entryOrder = 1
		for _, entry in ipairs(ns.SortedEntries(category.entries)) do
			options.args[groupKey].args["entry_" .. entry.ids[1]] =
				ns.DefineEntryToggle(entry, entryOrder, PeerPressureWatched)
			entryOrder = entryOrder + 1
		end

		categoryOrder = categoryOrder + 1
	end

	return options
end
