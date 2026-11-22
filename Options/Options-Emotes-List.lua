local _, ns = ...
local L = ns.L
local Kit = ns.OptionsKit

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
		name = Kit.SubPanelTitle(L["TAB_GIVE_THANKS"], L["TAB_EMOTES_LIST"]),
		type = "group",
		args = {
			-- With Give Thanks off, the checklist still looks live, so say what it waits on.
			status = Kit.StatusLine(function()
				if settings().enabled then
					return nil
				end
				return L["GIVE_THANKS_LIST_OFF"]:format(L["TAB_GIVE_THANKS"], L["GIVE_THANKS_ENABLE"])
			end, 0.5),
		},
	}

	-- Orders 1 through 1.1 belong to the emote checklist.
	ns.DefineEmoteGrid(options.args, settings, 1)

	return options
end
