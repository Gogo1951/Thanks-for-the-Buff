local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

function ns.GetGeneralOptions()
    return {
        name = L["ADDON_TITLE"],
        type = "group",
        args = {
            -- Brief Description
            descIntro = ns.OptionsDesc(L["OPTIONS_DESCRIPTION"], 1),
            space0 = ns.OptionsSpacer(2),
            enableWelcome = {
                type = "toggle",
                name = L["OPTIONS_WELCOME_TOGGLE"],
                desc = L["OPTIONS_WELCOME_DESC"],
                width = "full",
                order = 4,
                get = function()
                    return ns.db.profile.showWelcome
                end,
                set = function(_, val)
                    ns.db.profile.showWelcome = val
                end
            },
            -- /Commands
            spaceCommands0 = ns.OptionsSpacer(5),
            headerCommands = ns.OptionsHeader("/Commands", 6),
            spaceCommands1 = ns.OptionsSpacer(7),
            descCommands = ns.OptionsDesc(
                GetColor("INFO") .. L["OPTIONS_CMD_TFTB"] .. "|r" .. "  " .. L["OPTIONS_CMD_TFTB_DESC"] ..
                    "\n\n" ..
                    GetColor("INFO") .. L["OPTIONS_CMD_THANKYOU"] .. "|r" .. "  " .. L["OPTIONS_CMD_THANKYOU_DESC"],
                8
            ),
            -- Feedback & Support
            spaceLinks0 = ns.OptionsSpacer(69),
            headerLinks = ns.OptionsHeader(L["OPTIONS_SUPPORT"], 70),
            spaceLinks1 = ns.OptionsSpacer(71),
            curseforgeLabel = ns.OptionsDesc(GetColor("TITLE") .. L["OPTIONS_CURSEFORGE"] .. "|r", 72),
            curseforgeURL = {
                type = "input",
                name = "",
                order = 73,
                width = "double",
                get = function()
                    return Data.CURSEFORGE_URL
                end,
                set = function()
                end
            },
            spaceLinks2 = ns.OptionsSpacer(74),
            githubLabel = ns.OptionsDesc(GetColor("TITLE") .. L["OPTIONS_GITHUB"] .. "|r", 75),
            githubURL = {
                type = "input",
                name = "",
                order = 76,
                width = "double",
                get = function()
                    return Data.GITHUB_URL
                end,
                set = function()
                end
            },
            spaceLinks3 = ns.OptionsSpacer(77),
            discordLabel = ns.OptionsDesc(GetColor("TITLE") .. L["OPTIONS_DISCORD"] .. "|r", 78),
            discordURL = {
                type = "input",
                name = "",
                order = 79,
                width = "double",
                get = function()
                    return Data.DISCORD_URL
                end,
                set = function()
                end
            },
            -- Version
            spaceVersion0 = {
                type = "description",
                name = " ",
                width = "full",
                order = 998
            },
            versionLine = {
                type = "description",
                name = GetColor("MUTED") .. "Version " .. ns.Version .. "|r",
                fontSize = "medium",
                order = 999
            }
        }
    }
end
