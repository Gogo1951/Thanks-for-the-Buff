local _, ns = ...
local Data = ns.Data
local L = ns.L
local Kit = ns.OptionsKit

local GetColor = ns.GetColor

--[[
    The whisper, emote and icon rows: a caption-sized label and the control
    taking the rest of the row, so a full sentence stays readable while it is
    being edited. Reset sits on its own row under the box.
]]
local CAPTION_WIDTH = 0.9
local CONTROL_WIDTH = Kit.ROW_WIDTH - CAPTION_WIDTH

-- The player the Thank You Examples thank: the house Priest.
local SAMPLE_TARGET = ns.SAMPLE_NAMES.PRIEST

--[[
    A macro's switch with Pick Up Macro beside it while the macro exists: it
    puts the macro on the cursor to drop on an action bar, so nobody has to dig
    through the macro window for it. Gray in combat, when the game won't let a
    macro be picked up and placed.
]]
function ns.MacroToggleRow(order, toggle, macroName)
	local pickUp = {
		type = "execute",
		desc = L["BUTTON_PICKUP_DESCRIPTION"]:format(Kit.Color("TITLE", macroName)),
		disabled = function()
			return InCombatLockdown() or GetMacroIndexByName(macroName) == 0
		end,
		func = function()
			local macroIndex = GetMacroIndexByName(macroName)
			if macroIndex > 0 and not InCombatLockdown() then
				PickupMacro(macroIndex)
			end
		end,
	}
	local row = Kit.ToggleRow(order, toggle, { control = pickUp })
	-- ToggleRow blanks a control's caption; a button keeps its own.
	pickUp.name = L["BUTTON_PICKUP"]
	return row
end

-- A caption and its control, the control taking the rest of the row.
local function CaptionRow(order, hidden, caption, control)
	control.name = ""
	control.width = CONTROL_WIDTH
	return Kit.Row(order, hidden, { Kit.Label(caption, nil, CAPTION_WIDTH, control.desc), control })
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

--[[
    The Icon dropdown: the macros' own icon as Default first, then this
    client's ns.THANK_YOU_MACRO_ICONS in list order, each its picture alone, since
    the client gives an icon no name. Values are texture file IDs, the same number
    the macro is created with. Cached: the list can't change during a session.
]]
local iconValues, iconSorting
local function IconChoices()
	if not iconValues then
		local function Picture(texture)
			return "|T" .. texture .. ":16|t"
		end
		local default = Data.THANK_YOU_DEFAULT_ICON
		iconValues = { [default] = Picture(default) .. " " .. L["BUTTON_ICON_DEFAULT"] }
		iconSorting = { default }
		for _, icon in ipairs(ns.THANK_YOU_MACRO_ICONS) do
			iconValues[icon[1]] = Picture(icon[1])
			iconSorting[#iconSorting + 1] = icon[1]
		end
	end
	return iconValues, iconSorting
end

--[[
    One section per entry in Data.THANK_YOU_BUTTONS, all built from the same
    block. Orders are spaced a hundred apart so a section owns its own range and
    adding a control to one never renumbers the next.

    Every control binds through the button's own profile key, and Reset restores
    that button's declared default rather than a hard-coded string -- which is
    what keeps button 1 resetting to the friendly default text while buttons 2
    through 5 reset to empty, with the defaults file remaining the only place
    that decides.
]]
local function AddButtonSection(args, button, index)
	local key = button.profileKey
	local base = index * 100

	local function config()
		return ns.db.profile[key]
	end

	--[[
	    Everything below the macro toggle follows it, so a switched-off button
	    collapses to one line instead of five rows nobody is currently using. The
	    settings are hidden, not disabled: this button's slash command still fires
	    with whatever is stored, macro or no macro.
	]]
	local function sectionHidden()
		return not config().createMacro
	end

	--[[
	    Spacer on BOTH sides of the header: below it separates the rule from the
	    first control, above it keeps the rule off the previous section's emote box
	    (and, for button 1, off the panel description).
	]]
	args["space_top" .. index] = Kit.Spacer(base)
	args["header" .. index] = Kit.Header(string.format(L["BUTTON_SECTION"], index), base + 1)
	args["space_a" .. index] = Kit.Spacer(base + 2)

	args["createMacro" .. index] = ns.MacroToggleRow(base + 3, {
		type = "toggle",
		--[[
		    The macro's name is in the label, not just the tooltip: with five of
		    these stacked, "which macro is this one?" should not need a hover.
		]]
		name = string.format(L["BUTTON_MACRO_ENABLE"], button.macroName),
		desc = string.format(L["BUTTON_MACRO_ENABLE_DESCRIPTION"], GetColor("TITLE") .. button.macroName .. "|r"),
		get = function()
			return config().createMacro
		end,
		set = function(_, value)
			config().createMacro = value
			--[[
			    The toggle owns the macro's existence in both directions: ticking it
			    creates the macro now rather than next login, unticking removes it.
			    Leaving a switched-off button's macro sitting on the bars would make
			    the checkbox a lie.
			]]
			if value then
				if ns.CreateAutoMacro then
					ns:CreateAutoMacro()
				end
			elseif ns.DeleteAutoMacro then
				ns:DeleteAutoMacro(button)
			end
			ns.RefreshSettings()
		end,
	}, button.macroName)

	args["space_b" .. index] = Kit.Spacer(base + 4, sectionHidden)
	args["whisperMsg" .. index] = CaptionRow(base + 5, sectionHidden, L["WHISPER_MESSAGE"], {
		type = "input",
		desc = L["BUTTON_WHISPER_DESCRIPTION"],
		get = function()
			return config().message
		end,
		set = function(_, value)
			config().message = ns.TrimToBytes(value or "", ns.CHAT_MESSAGE_MAX_LENGTH)
			ns.RefreshSettings()
		end,
	})
	-- What the box understands, under it.
	args["whisperTokens" .. index] = Kit.Row(base + 5.5, sectionHidden, {
		Kit.Label(" ", nil, CAPTION_WIDTH),
		Kit.Label(
			Kit.Color("HELP", L["BUTTON_TOKENS"]:format(GetColor("INFO") .. "{name}" .. GetColor("HELP"))),
			nil,
			CONTROL_WIDTH
		),
	})
	-- Reset, on its own row under the box, gray while the box holds this button's default.
	local function defaultMessage()
		return ns.DATABASE_DEFAULTS.profile[key].message
	end
	args["resetMsg" .. index] = Kit.ResetRow(
		base + 6,
		sectionHidden,
		" ",
		L["WHISPER_MESSAGE_RESET_DESCRIPTION"],
		function()
			return config().message == defaultMessage()
		end,
		function()
			config().message = defaultMessage()
		end
	)

	-- The whisper as your target receives it, on its own line, built as RunThankYou sends it.
	args["whisperExample" .. index] = Kit.Example(base + 7, function()
		return sectionHidden() or (config().message or "") == ""
	end, function()
		return ns.SampleWhisper(ns.FillThankYouWhisper(config().message or "", SAMPLE_TARGET))
	end)

	args["space_c" .. index] = Kit.Spacer(base + 8, sectionHidden)

	-- The icon row closes the section, under the emote row or grid.
	args["space_d" .. index] = Kit.Spacer(base + 11, sectionHidden)
	local choices, choiceOrder = IconChoices()
	args["iconSelect" .. index] = CaptionRow(base + 12, sectionHidden, L["BUTTON_ICON"], {
		type = "select",
		desc = L["BUTTON_ICON_DESCRIPTION"],
		values = choices,
		sorting = choiceOrder,
		get = function()
			-- What the macro actually wears: an icon this client's list lacks shows as Default rather than blank.
			return ns.GetThankYouIcon(config())
		end,
		set = function(_, value)
			config().macroIcon = value
			ns.ReconcileMacros()
			ns.RefreshSettings()
		end,
	})

	--[[
	    A single-emote button gets one dropdown instead of the checklist: there is
	    nothing to randomize between, so a grid of checkboxes would be the wrong
	    control for the choice being made.
	]]
	if button.singleEmote then
		local values, sorting = ns.GetEmoteSelectChoices()
		args["emoteSelect" .. index] = CaptionRow(base + 9, sectionHidden, L["BUTTON_EMOTE"], {
			type = "select",
			desc = L["BUTTON_EMOTE_DESCRIPTION"],
			values = values,
			sorting = sorting,
			get = function()
				--[[
				    A token this client does not have shows as "none" rather than
				    blank: profiles travel between flavors, and an emote that only
				    exists on a later one would otherwise leave the box empty and
				    unexplained.
				]]
				local current = config().emote
				return (current and ns.IsClientEmote(current)) and current or ""
			end,
			set = function(_, value)
				config().emote = value
				ns.RefreshSettings()
			end,
		})
		return
	end

	-- The emote checklist follows the macro toggle.
	local emoteGroup = ns.DefineEmoteGroup(config, base + 9)
	emoteGroup.hidden = sectionHidden
	args["emoteGroup" .. index] = emoteGroup
end

function ns.BuildThankYouButtonOptions()
	local options = {
		name = L["TAB_THANK_YOU_BUTTON"],
		type = "group",
		args = {
			descIntro = Kit.Desc(L["BUTTON_DESCRIPTION"], 1),
		},
	}

	for index, button in ipairs(Data.THANK_YOU_BUTTONS) do
		AddButtonSection(options.args, button, index)
	end

	return options
end
