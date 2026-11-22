local _, ns = ...
local Data = ns.Data
local L = ns.L
local Kit = ns.OptionsKit

--[[
    "Return Buff", a sub-panel of Give Thanks: a per-character macro that casts
    one of your buffs back on the last player outside your group who buffed you
    (Features/Buff-Back.lua). It follows strangers' buffs whether or not Give
    Thanks is on, so no status line says it waits on Give Thanks.
]]

-- The Example's stand-in until a stranger has buffed this character.
local SAMPLE_TARGET = ns.SAMPLE_NAMES.PRIEST

function ns.BuildReturnBuffOptions()
	local function settings()
		return ns.db.profile.buffBack
	end
	local function off()
		return not settings().enabled
	end
	-- The buff picked, kept per character since each class has its own buffs.
	local function pickedSpell()
		local spellId = ns.db.char.buffBackSpell
		return spellId and (ns.GetBuffBackChoices())[spellId] and spellId or nil
	end
	local function knowsNone()
		return #select(2, ns.GetBuffBackChoices()) == 0
	end
	local macro = Kit.Color("TITLE", Data.BUFF_BACK_MACRO)

	local options = {
		name = Kit.SubPanelTitle(L["TAB_GIVE_THANKS"], L["TAB_RETURN_BUFF"]),
		type = "group",
		args = {
			descIntro = Kit.Desc(L["RETURN_BUFF_DESCRIPTION"]:format(macro), 1),
			space0 = Kit.Spacer(2),
			enable = ns.MacroToggleRow(3, {
				type = "toggle",
				name = string.format(L["BUTTON_MACRO_ENABLE"], Data.BUFF_BACK_MACRO),
				desc = L["RETURN_BUFF_ENABLE_DESCRIPTION"]:format(macro),
				get = function()
					return settings().enabled
				end,
				set = function(_, value)
					settings().enabled = value
					ns.ReconcileBuffBack()
					ns.RefreshSettings()
				end,
			}, Data.BUFF_BACK_MACRO),
			-- With nothing this character can cast, the switch can't make a macro; say why.
			none = Kit.WarningLine(L["RETURN_BUFF_NONE"], function()
				return not off() and knowsNone()
			end, 4),
			-- The macro can't be made while the account's macro slots are full; Pick Up Macro stays gray until then.
			full = Kit.WarningLine(function()
				return L["RETURN_BUFF_MACROS_FULL"]:format(Data.MAX_GLOBAL_MACROS, Data.BUFF_BACK_MACRO)
			end, ns.IsBuffBackBlockedByMacroCap, 4.5),
			space1 = Kit.Spacer(5, off),
			spell = Kit.LabelRow(
				6,
				function()
					return off() or knowsNone()
				end,
				L["RETURN_BUFF_SPELL"],
				{
					type = "select",
					desc = L["RETURN_BUFF_SPELL_DESCRIPTION"],
					values = function()
						return (ns.GetBuffBackChoices())
					end,
					sorting = function()
						return select(2, ns.GetBuffBackChoices())
					end,
					get = pickedSpell,
					set = function(_, value)
						ns.db.char.buffBackSpell = value
						ns.ReconcileBuffBack()
						ns.RefreshSettings()
					end,
				}
			),
			-- Who the macro would cast on: the last stranger who buffed you, or the house Priest before anyone has.
			example = Kit.Example(7, function()
				return off() or not pickedSpell()
			end, function()
				local target = ns.GetBuffBackTarget()
				local name = target and Ambiguate(target, "short") or SAMPLE_TARGET
				if not target then
					name = Kit.Color(Kit.ClassColor("PRIEST"), name)
				end
				-- The rank the macro casts at that player's level, named after the link when it isn't your highest.
				local rankId, rankText = ns.GetBuffBackRank(pickedSpell())
				local link = (ns.GetSpellLink(rankId) or "") .. (rankText and (" (" .. rankText .. ")") or "")
				local level = target and ns.GetBuffBackTargetLevel()
				if level then
					return Kit.Tint("TEXT", L["RETURN_BUFF_EXAMPLE_LEVEL"]:format(name, level, link))
				end
				return Kit.Tint("TEXT", L["RETURN_BUFF_EXAMPLE"]:format(name, link))
			end),
			space2 = Kit.Spacer(8),
			help = Kit.Desc(Kit.Color("HELP", L["RETURN_BUFF_HELP"]), 9),
			-- Only clients with spell ranks (Wrath and earlier) pick one by level.
			rankHelp = Kit.Desc(Kit.Color("HELP", L["RETURN_BUFF_RANK_HELP"]), 10, function()
				return (ns.EXPANSION or 1) > 3
			end),
		},
	}

	return options
end
