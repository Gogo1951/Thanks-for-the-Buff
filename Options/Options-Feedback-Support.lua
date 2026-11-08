local _, ns = ...
local L = ns.L

local GetColor = ns.GetColor

--------------------------------------------------------------------------------
-- Feedback & Support Panel
--------------------------------------------------------------------------------

-- The Level Up note, one paragraph per key, in display order.
local PARAGRAPHS = {
	"OPTIONS_LEVEL_UP_INTRO",
	"OPTIONS_LEVEL_UP_WAYS",
	"OPTIONS_LEVEL_UP_FEEDBACK",
	"OPTIONS_LEVEL_UP_FRIEND",
	"OPTIONS_LEVEL_UP_CURSEFORGE",
	"OPTIONS_LEVEL_UP_GITHUB",
	"OPTIONS_LEVEL_UP_THANKS",
}

-- { captionKey, linkKey }, in display order.
local LINKS = {
	{ "OPTIONS_DISCORD", "DISCORD" },
	{ "OPTIONS_CURSEFORGE", "CURSEFORGE" },
	{ "OPTIONS_WAGO", "WAGO" },
	{ "OPTIONS_GITHUB", "GITHUB" },
}

function ns.BuildFeedbackSupportOptions()
	local args = {}
	local order = 1

	for index, key in ipairs(PARAGRAPHS) do
		if index > 1 then
			args["space" .. key] = ns.OptionsSpacer(order)
			order = order + 1
		end
		args[key] = ns.OptionsDesc(L[key], order)
		order = order + 1
	end

	args.spaceLinks0 = ns.OptionsSpacer(order)
	args.headerLinks = ns.OptionsHeader(L["OPTIONS_FEEDBACK_LINKS_HEADER"], order + 1)
	order = order + 2

	-- A spacer before every row, so the boxes don't sit flush against each other.
	for _, link in ipairs(LINKS) do
		local captionKey, linkKey = link[1], link[2]
		args["space" .. linkKey] = ns.OptionsSpacer(order)
		order = order + 1
		ns.OptionsLinkRow(args, linkKey, L[captionKey], ns.LINKS[linkKey], order)
		order = order + 2
	end

	args.spaceCopyLink = ns.OptionsSpacer(order)
	args.copyCaption = ns.OptionsDesc(GetColor("HELP") .. L["OPTIONS_COPY_LINK"] .. "|r", order + 1)

	args.spaceVersion = {
		type = "description",
		name = " ",
		width = "full",
		order = 998,
	}
	args.versionLine = {
		type = "description",
		name = GetColor("INFO") .. L["OPTIONS_VERSION"]:format(ns.Version) .. "|r",
		fontSize = "medium",
		order = 999,
	}

	return {
		name = L["OPTIONS_LEVEL_UP_TITLE"],
		type = "group",
		args = args,
	}
end
