local _, ns = ...
local L = ns.L

--[[
    "Emotes List", a sub-panel of Give Thanks: the emote checklist Give Thanks
    picks from, stored as ns.db.profile.strangers.emotes. The checklist runs to
    dozens of rows, so it has a panel of its own rather than burying everything
    under it on Give Thanks. The grid itself lives in Options-Emote-Grid.lua.
]]

function ns.BuildEmotesListOptions()
	local function settings()
		return ns.db.profile.strangers
	end

	local options = {
		name = L["TAB_EMOTES_LIST"],
		type = "group",
		args = {},
	}

	-- Orders 1 through 1.1 belong to the emote checklist.
	ns.DefineEmoteGrid(options.args, settings, 1)

	return options
end
