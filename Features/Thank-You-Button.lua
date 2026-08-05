local _, ns = ...
local Data = ns.Data
local L = ns.L

--[[
    The manual thank-you feature: an auto-created macro and the /thankyou command
    that emotes at and whispers your current target. Core's login sequence calls
    CreateAutoMacro; Options/Options.lua registers the slash command against
    RunThankYou.
]]

--------------------------------------------------------------------------------
-- Auto Macro
--------------------------------------------------------------------------------

function ns:CreateAutoMacro()
	if InCombatLockdown() then
		return
	end

	if not ns.db or not ns.db.profile.slash or not ns.db.profile.slash.createMacro then
		return
	end

	local macroIndex = GetMacroIndexByName(Data.MACRO_NAME)
	if macroIndex == 0 then
		local numGlobal = GetNumMacros()
		if numGlobal < 120 then
			CreateMacro(Data.MACRO_NAME, 134411, "/thankyou", nil)
		end
	end
end

--------------------------------------------------------------------------------
-- Thank You Command
--------------------------------------------------------------------------------

-- Body of the /thankyou slash command; the registration lives in Options/Options.lua.
function ns.RunThankYou()
	if not UnitExists("target") or not UnitIsPlayer("target") then
		ns:PrintMessage(L["MESSAGE_SELECT_PLAYER"])
		return
	end
	if UnitIsUnit("target", "player") then
		ns:PrintMessage(L["MESSAGE_CANT_THANK_SELF"])
		return
	end

	local db = ns.db and ns.db.profile.slash
	if not db then
		return
	end

	ns:DoRandomEmote(db.emotes, "target")

	if UnitFactionGroup("player") == UnitFactionGroup("target") and db.message and db.message ~= "" then
		ns:Whisper(GetUnitName("target", true), db.message)
	end
end
