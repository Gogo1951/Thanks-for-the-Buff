local _, ns = ...
local L = ns.L

--[[
    "Tracked Abilities" panel, under Peer Pressure: one class-colored group per
    class with live entries (ns.PeerPressureCategories, built at login), toggles
    bound to peerPressure.watched. Every class is listed, not just yours,
    because the default profile is shared account-wide. Not hidden behind the
    Peer Pressure switch, like Buff Duty's sub-panels: the parent panel says
    whether it is on.
]]
function ns.BuildPeerPressureTrackedOptions()
	local function PeerPressureWatched()
		return ns.db.profile.peerPressure.watched
	end

	local options = {
		name = ns.SubPanelTitle(L["TAB_PEER_PRESSURE"], L["TRACKED_HEADER"]),
		type = "group",
		args = {},
	}

	local categoryOrder = 1
	for _, category in ipairs(ns.PeerPressureCategories or {}) do
		local groupKey = "cat_" .. category.id
		options.args[groupKey] = {
			type = "group",
			name = category.name,
			order = categoryOrder,
			inline = true,
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
