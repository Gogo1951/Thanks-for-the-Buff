local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

-- The whisper row: a caption-sized label, so the message box keeps the rest of the
-- row and a full sentence stays readable while it is being edited.
local WHISPER_LABEL_WIDTH = 0.9
local WHISPER_INPUT_WIDTH = ns.OPTIONS_ROW_WIDTH - WHISPER_LABEL_WIDTH

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

--[[
    The dropdown's contents: every emote the client has, plus an explicit "none",
    ordered by slash command. Built from ns.GetEmoteCatalog rather than
    Data.EMOTES -- these buttons are a free choice from the whole client set, not
    from the twelve the praise panels curate.

    Cached: the catalog cannot change during a session, and this table is rebuilt
    on every panel open otherwise.
]]
local emoteValues, emoteSorting
local function EmoteChoices()
	if not emoteValues then
		emoteValues = { [""] = L["BUTTON_EMOTE_NONE"] }
		emoteSorting = { "" }
		for _, emote in ipairs(ns.GetEmoteCatalog()) do
			emoteValues[emote.token] = emote.command
			emoteSorting[#emoteSorting + 1] = emote.token
		end
	end
	return emoteValues, emoteSorting
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

	-- Everything below the macro toggle follows it, so a switched-off button
	-- collapses to one line instead of five rows nobody is currently using. The
	-- settings are hidden, not disabled: this button's slash command still fires
	-- with whatever is stored, macro or no macro.
	local function sectionHidden()
		return not config().createMacro
	end

	-- Spacer on BOTH sides of the header: below it separates the rule from the
	-- first control, above it keeps the rule off the previous section's emote box
	-- (and, for button 1, off the panel description).
	args["space_top" .. index] = ns.OptionsSpacer(base)
	args["header" .. index] = ns.OptionsHeader(string.format(L["BUTTON_SECTION"], index), base + 1)
	args["space_a" .. index] = ns.OptionsSpacer(base + 2)

	args["createMacro" .. index] = {
		type = "toggle",
		-- The macro's name is in the label, not just the tooltip: with five of
		-- these stacked, "which macro is this one?" should not need a hover.
		name = string.format(L["BUTTON_MACRO_ENABLE"], button.macroName),
		desc = string.format(L["BUTTON_MACRO_ENABLE_DESCRIPTION"], GetColor("TITLE") .. button.macroName .. "|r"),
		width = "full",
		order = base + 3,
		get = function()
			return config().createMacro
		end,
		set = function(_, val)
			config().createMacro = val
			-- The toggle owns the macro's existence in both directions: ticking it
			-- creates the macro now rather than next login, unticking removes it.
			-- Leaving a switched-off button's macro sitting on the bars would make
			-- the checkbox a lie.
			if val then
				if ns.CreateAutoMacro then
					ns:CreateAutoMacro()
				end
			elseif ns.DeleteAutoMacro then
				ns:DeleteAutoMacro(button)
			end
		end,
	}

	args["space_b" .. index] = ns.OptionsSpacer(base + 4)
	args["space_b" .. index].hidden = sectionHidden
	args["whisperLabel" .. index] =
		ns.OptionsRowLabel(L["BUTTON_WHISPER"], base + 5, WHISPER_LABEL_WIDTH, sectionHidden)
	args["whisperMsg" .. index] = {
		type = "input",
		name = "",
		width = WHISPER_INPUT_WIDTH,
		order = base + 6,
		hidden = sectionHidden,
		get = function()
			return config().message
		end,
		set = function(_, val)
			config().message = ns.TrimToBytes(val or "", ns.CHAT_MESSAGE_MAX_LENGTH)
		end,
	}
	args["resetMsg" .. index] = {
		type = "execute",
		name = L["BUTTON_RESET"],
		desc = L["BUTTON_RESET_DESCRIPTION"],
		width = "half",
		order = base + 7,
		hidden = sectionHidden,
		func = function()
			config().message = ns.DATABASE_DEFAULTS.profile[key].message
		end,
	}

	args["space_c" .. index] = ns.OptionsSpacer(base + 8)
	args["space_c" .. index].hidden = sectionHidden

	-- A single-emote button gets one dropdown instead of the checklist: there is
	-- nothing to randomise between, so a grid of checkboxes would be the wrong
	-- control for the choice being made.
	if button.singleEmote then
		local values, sorting = EmoteChoices()
		args["emoteLabel" .. index] =
			ns.OptionsRowLabel(L["BUTTON_EMOTE"], base + 9, WHISPER_LABEL_WIDTH, sectionHidden)
		args["emoteSelect" .. index] = {
			type = "select",
			name = "",
			width = WHISPER_INPUT_WIDTH,
			order = base + 10,
			hidden = sectionHidden,
			values = values,
			sorting = sorting,
			get = function()
				-- A token this client does not have shows as "none" rather than
				-- blank: profiles travel between flavours, and an emote that only
				-- exists on a later one would otherwise leave the box empty and
				-- unexplained.
				local current = config().emote
				return (current and ns.IsClientEmote(current)) and current or ""
			end,
			set = function(_, val)
				config().emote = val
			end,
		}
		return
	end

	local emoteGroup = {
		type = "group",
		name = L["PRAISE_EMOTES_SELECT"],
		order = base + 9,
		inline = true,
		hidden = sectionHidden,
		args = {},
	}
	for i, emoteData in ipairs(Data.EMOTES) do
		local emote = emoteData.cmd
		emoteGroup.args[emote] = {
			type = "toggle",
			name = emoteData.displayName,
			desc = emoteData.desc,
			order = i,
			width = "half",
			get = function()
				return config().emotes[emote]
			end,
			set = function(_, val)
				config().emotes[emote] = val
			end,
		}
	end
	args["emoteGroup" .. index] = emoteGroup
end

function ns.BuildThankYouButtonOptions()
	local options = {
		name = L["TAB_THANK_YOU_BUTTON"],
		type = "group",
		args = {
			descIntro = ns.OptionsDesc(L["BUTTON_DESCRIPTION"], 1),
		},
	}

	for index, button in ipairs(Data.THANK_YOU_BUTTONS) do
		AddButtonSection(options.args, button, index)
	end

	return options
end
