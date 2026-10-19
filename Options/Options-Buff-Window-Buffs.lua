local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--[[
    "Tracked Abilities" panel, under Buff Duty: who each buff you can give to others is
    offered to, and when a buff counts as missing. Lists every class, like Peer
    Pressure, because the default profile is shared account-wide. Not hidden
    behind the Buff Duty switch: these are choices worth making before
    turning the window on, and the parent panel says whether it is.
]]
function ns.BuildBuffWindowBuffsOptions()
	local function Settings()
		return ns.db.profile.buffWindow
	end

	local options = {
		name = ns.SubPanelTitle(L["TAB_BUFF_WINDOW"], L["TRACKED_HEADER"]),
		type = "group",
		args = {
			--[[
			    "Tanks" and "Healers" need saying once for every dropdown below,
			    rather than in each one's tooltip.
			]]
			descBuffs = ns.OptionsDesc(L["BUFF_WINDOW_BUFFS_DESCRIPTION"], 1),
			space0 = ns.OptionsSpacer(2),
		},
	}
	--[[
	    Labelled with the client's own duration string, so "5 Minutes" reads right
	    in every locale without a string of ours.
	]]
	local refreshValues = {}
	for _, minutes in ipairs(Data.BUFF_WINDOW_REFRESH_CHOICES) do
		refreshValues[minutes] = D_MINUTES:format(minutes)
	end
	options.args.refreshLabel =
		ns.OptionsRowLabel(GetColor("TITLE") .. L["BUFF_WINDOW_REFRESH"] .. "|r", 26, ns.OPTIONS_ALIGNED_LABEL_WIDTH)
	options.args.refreshMinutes = {
		type = "select",
		name = "",
		desc = L["BUFF_WINDOW_REFRESH_DESCRIPTION"],
		values = refreshValues,
		sorting = Data.BUFF_WINDOW_REFRESH_CHOICES,
		width = ns.OPTIONS_CONTROL_WIDTH,
		order = 27,
		get = function()
			return Settings().refreshMinutes
		end,
		set = function(_, value)
			Settings().refreshMinutes = value
			ns.RefreshBuffWindow()
		end,
	}
	options.args.spacePetsAsTanks = ns.OptionsSpacer(28)
	--[[
	    A toggle and its "when" on one row; the dropdown appears only while the
	    toggle is on.
	]]
	options.args.petsAsTanks = {
		type = "toggle",
		name = L["BUFF_WINDOW_PETS_AS_TANKS"],
		desc = L["BUFF_WINDOW_PETS_AS_TANKS_DESCRIPTION"],
		-- Lined up with the boxed buff dropdowns below, not the panel's edge.
		width = ns.OPTIONS_ALIGNED_LABEL_WIDTH,
		order = 29,
		get = function()
			return Settings().petsAsTanks
		end,
		set = function(_, value)
			Settings().petsAsTanks = value
			ns.RefreshBuffWindow()
		end,
	}
	local petsAsTanksValues = {}
	for _, value in ipairs(Data.PETS_AS_TANKS_ORDER) do
		petsAsTanksValues[value] = L["BUFF_WINDOW_PETS_AS_TANKS_" .. value]
	end
	options.args.petsAsTanksWhen = {
		type = "select",
		name = "",
		desc = L["BUFF_WINDOW_PETS_AS_TANKS_WHEN_DESCRIPTION"],
		values = petsAsTanksValues,
		sorting = Data.PETS_AS_TANKS_ORDER,
		width = ns.OPTIONS_CONTROL_WIDTH,
		order = 30,
		hidden = function()
			return not Settings().petsAsTanks
		end,
		get = function()
			return Settings().petsAsTanksWhen
		end,
		set = function(_, value)
			Settings().petsAsTanksWhen = value
			ns.RefreshBuffWindow()
		end,
	}
	options.args.space10 = ns.OptionsSpacer(31)

	local audienceValues = {}
	for _, value in ipairs(Data.BUFF_AUDIENCE_ORDER) do
		audienceValues[value] = L["BUFF_WINDOW_AUDIENCE_" .. value]
	end

	local categoryOrder = 40
	for _, category in ipairs(ns.BuffWindowCategories or {}) do
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
			ns.DefineSpellSelectRow(
				options.args[groupKey].args,
				entry,
				entryOrder,
				L["BUFF_WINDOW_AUDIENCE_DESCRIPTION"]:format(entry.spellName),
				{
					values = audienceValues,
					sorting = Data.BUFF_AUDIENCE_ORDER,
					get = function()
						return Settings().audience[entry.key]
					end,
					set = function(_, value)
						Settings().audience[entry.key] = value
						ns.RefreshBuffWindow()
					end,
				}
			)
			entryOrder = entryOrder + 1
		end

		categoryOrder = categoryOrder + 1
	end

	return options
end
