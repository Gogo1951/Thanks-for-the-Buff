local _, ns = ...

--------------------------------------------------------------------------------
-- Profiles Panel
--------------------------------------------------------------------------------

--[[
    The stock AceDBOptions-3.0 profiles table -- picker, Copy From, Delete a
    Profile, and Reset Profile (active profile only), all pre-wired to ns.db and
    already translated -- returned as-is: nothing added, nothing removed.
    Registered second-to-last, directly above Diagnostic Tools.
]]
function ns.BuildProfilesOptions()
	return LibStub("AceDBOptions-3.0"):GetOptionsTable(ns.db)
end
