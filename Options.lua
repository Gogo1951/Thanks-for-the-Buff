local addonName, ns = ...
local Data = ns.Data
local L = ns.L

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

local function Header(text, order)
    return {type = "header", name = ns.GetColor("TITLE") .. text .. "|r", order = order}
end

local function Desc(text, order)
    return {type = "description", name = text, fontSize = "medium", order = order}
end

local function Spacer(order)
    return {type = "description", name = " ", order = order}
end

--------------------------------------------------------------------------------
-- Main Options Table
--------------------------------------------------------------------------------

local function GetMainOptions()
    local TFTB = ns.TFTB

    return {
        name = L["OPTIONS_TITLE"],
        type = "group",
        args = {
            -- Brief Description
            descIntro = Desc(L["OPTIONS_DESCRIPTION"], 1),
            space0 = Spacer(2),

            -- /Commands
            headerCommands = Header("/Commands", 3),
            spaceCommands1 = Spacer(4),
            descCommands = Desc(
                ns.GetColor("INFO") .. "/tftb|r" .. "  " .. L["OPTIONS_CMD_TFTB_DESC"] .. "\n" ..
                ns.GetColor("INFO") .. "/thankyou|r" .. "  " .. L["OPTIONS_CMD_THANKYOU_DESC"],
                5
            ),
            spaceCommands2 = Spacer(6),

            -- General Settings
            headerGen = Header(L["OPTIONS_GENERAL"], 10),
            enableWelcome = {
                type  = "toggle",
                name  = L["OPTIONS_WELCOME_TOGGLE"],
                desc  = L["OPTIONS_WELCOME_DESC"],
                width = "full",
                order = 11,
                get   = function() return TFTB.db.profile.global.welcomeMessage end,
                set   = function(_, val) TFTB.db.profile.global.welcomeMessage = val end
            },

            -- Reset
            spaceReset0 = Spacer(59),
            headerReset = Header(L["OPTIONS_RESET"], 60),
            spaceReset1 = Spacer(61),
            resetAll = {
                type        = "execute",
                name        = L["OPTIONS_RESET_ALL"],
                desc        = L["OPTIONS_RESET_ALL_DESC"],
                order       = 62,
                width       = "normal",
                confirm     = true,
                confirmText = L["OPTIONS_RESET_CONFIRM"],
                func        = function()
                    TFTB.db:ResetProfile()
                    TFTB:PopulateWatchedBuffs()
                    TFTB:BuildSpellLookup()
                    TFTB:PrintMsg(L["MSG_RESET"])
                end
            },

            -- Feedback & Support
            spaceLinks0 = Spacer(69),
            headerLinks = Header(L["OPTIONS_SUPPORT"], 70),
            spaceLinks1 = Spacer(71),

            curseforgeLabel = Desc(ns.GetColor("TITLE") .. L["OPTIONS_CURSEFORGE"] .. "|r", 72),
            curseforgeURL = {
                type  = "input",
                name  = "",
                order = 73,
                width = "double",
                get   = function() return Data.CURSEFORGE_URL end,
                set   = function() end
            },
            spaceLinks2 = Spacer(74),

            githubLabel = Desc(ns.GetColor("TITLE") .. L["OPTIONS_GITHUB"] .. "|r", 75),
            githubURL = {
                type  = "input",
                name  = "",
                order = 76,
                width = "double",
                get   = function() return Data.GITHUB_URL end,
                set   = function() end
            },
            spaceLinks3 = Spacer(77),

            discordLabel = Desc(ns.GetColor("TITLE") .. L["OPTIONS_DISCORD"] .. "|r", 78),
            discordURL = {
                type  = "input",
                name  = "",
                order = 79,
                width = "double",
                get   = function() return Data.DISCORD_URL end,
                set   = function() end
            }
        }
    }
end

--------------------------------------------------------------------------------
-- Registration
--------------------------------------------------------------------------------

function ns.SetupOptions()
    local TFTB = ns.TFTB
    local AC   = LibStub("AceConfig-3.0")
    local ACD  = LibStub("AceConfigDialog-3.0")

    AC:RegisterOptionsTable("TFTB", GetMainOptions())
    ACD:AddToBlizOptions("TFTB", "Thanks for the Buff")

    if ns.GetStrangersOptions then
        AC:RegisterOptionsTable("TFTB_Strangers", ns.GetStrangersOptions())
        ACD:AddToBlizOptions("TFTB_Strangers", L["STRANGERS_TITLE"], "Thanks for the Buff")
    end

    if ns.GetCombatBuffsOptions then
        AC:RegisterOptionsTable("TFTB_CombatBuffs", ns.GetCombatBuffsOptions())
        ACD:AddToBlizOptions("TFTB_CombatBuffs", L["COMBAT_TITLE"], "Thanks for the Buff")
    end

    if ns.GetThankYouButtonOptions then
        AC:RegisterOptionsTable("TFTB_ThankYou", ns.GetThankYouButtonOptions())
        ACD:AddToBlizOptions("TFTB_ThankYou", L["BUTTON_TITLE"], "Thanks for the Buff")
    end

    local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(TFTB.db)
    AC:RegisterOptionsTable("TFTB_Profiles", profiles)
    ACD:AddToBlizOptions("TFTB_Profiles", "Profiles", "Thanks for the Buff")

    SLASH_TFTB_CONFIG1 = "/tftb"
    SlashCmdList.TFTB_CONFIG = function()
        ns.OpenOptions()
    end
end

function ns.OpenOptions()
    if Settings and Settings.GetCategory then
        local category = Settings.GetCategory("Thanks for the Buff")
        if category then
            Settings.OpenToCategory(category.ID)
            return
        end
    end
    if InterfaceOptionsFrame_OpenToCategory then
        InterfaceOptionsFrame_OpenToCategory("Thanks for the Buff")
        InterfaceOptionsFrame_OpenToCategory("Thanks for the Buff")
        return
    end
    LibStub("AceConfigDialog-3.0"):Open("TFTB")
end