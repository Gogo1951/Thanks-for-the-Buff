local addonName, ns = ...
local Data = ns.Data

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local function Header(text, order)
    return {
        type  = "header",
        name  = ns.GetColor("TITLE") .. text .. "|r",
        order = order
    }
end

local function Desc(text, order)
    return {
        type     = "description",
        name     = text,
        fontSize = "medium",
        order    = order
    }
end

local function Spacer(order)
    return {
        type  = "description",
        name  = " ",
        order = order
    }
end

--------------------------------------------------------------------------------
-- Main Options Table
--------------------------------------------------------------------------------
local function GetMainOptions()
    local TFTB = ns.TFTB

    return {
        name = "Thanks for the Buff!",
        type = "group",
        args = {
            -- General Settings
            headerGen = Header("General Settings", 10),
            enableWelcome = {
                type  = "toggle",
                name  = "Enable Welcome Message",
                desc  = "Print a message to chat when you log in.",
                width = "full",
                order = 11,
                get   = function() return TFTB.db.profile.global.welcomeMessage end,
                set   = function(_, val) TFTB.db.profile.global.welcomeMessage = val end
            },

            -- Reset
            spaceReset0 = Spacer(59),
            headerReset = Header("Reset", 60),
            spaceReset1 = Spacer(61),
            resetAll = {
                type        = "execute",
                name        = "Reset All Settings",
                desc        = "Restore every option to its default value.",
                order       = 62,
                width       = "normal",
                confirm     = true,
                confirmText = "Are you sure you want to reset all settings to their defaults?",
                func        = function()
                    TFTB.db:ResetProfile()
                    TFTB:PopulateWatchedBuffs()
                    TFTB:BuildSpellLookup()
                    TFTB:PrintMsg("All settings have been reset to defaults.")
                end
            },

            -- Help & Support
            spaceLinks0 = Spacer(69),
            headerLinks = Header("Help & Support", 70),
            spaceLinks1 = Spacer(71),

            discordLabel = Desc(ns.GetColor("TITLE") .. "Discord" .. "|r", 72),
            discordURL = {
                type  = "input",
                name  = "",
                order = 73,
                width = "double",
                get   = function() return Data.DISCORD_URL end,
                set   = function() end
            },
            spaceLinks2 = Spacer(74),

            githubLabel = Desc(ns.GetColor("TITLE") .. "GitHub" .. "|r", 75),
            githubURL = {
                type  = "input",
                name  = "",
                order = 76,
                width = "double",
                get   = function() return Data.GITHUB_URL end,
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

    -- Main panel
    AC:RegisterOptionsTable("TFTB", GetMainOptions())
    ACD:AddToBlizOptions("TFTB", "Thanks for the Buff")

    -- Sub-panels
    if ns.GetStrangersOptions then
        AC:RegisterOptionsTable("TFTB_Strangers", ns.GetStrangersOptions())
        ACD:AddToBlizOptions("TFTB_Strangers", "Buffs from Strangers", "Thanks for the Buff")
    end

    if ns.GetCombatBuffsOptions then
        AC:RegisterOptionsTable("TFTB_CombatBuffs", ns.GetCombatBuffsOptions())
        ACD:AddToBlizOptions("TFTB_CombatBuffs", "Combat Buffs", "Thanks for the Buff")
    end

    if ns.GetThankYouButtonOptions then
        AC:RegisterOptionsTable("TFTB_ThankYou", ns.GetThankYouButtonOptions())
        ACD:AddToBlizOptions("TFTB_ThankYou", "Thank You Button", "Thanks for the Buff")
    end

    -- Profiles (AceDBOptions)
    local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(TFTB.db)
    AC:RegisterOptionsTable("TFTB_Profiles", profiles)
    ACD:AddToBlizOptions("TFTB_Profiles", "Profiles", "Thanks for the Buff")

    -- Slash command
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