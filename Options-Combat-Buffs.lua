local addonName, ns = ...
local Data = ns.Data
local L = ns.L

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

local function Desc(text, order)
    return {type = "description", name = text, fontSize = "medium", order = order}
end

local function Spacer(order)
    return {type = "description", name = " ", order = order}
end

local function DefineSpellGroupToggle(spellData, order)
    local TFTB = ns.TFTB
    local name = spellData.name
    local ids  = spellData.ids

    local desc = string.format(L["COMBAT_TOGGLE_TRACKING"], name)
    if ids and ids[1] then
        local spellDesc = C_Spell.GetSpellDescription(ids[1])
        if spellDesc and spellDesc ~= "" then
            desc = spellDesc
        end
    end

    return {
        type  = "toggle",
        name  = name,
        desc  = desc,
        order = order,
        width = "full",
        get   = function()
            if ids and ids[1] then
                return TFTB.db.profile.groupBuffs.watchedBuffs[ids[1]]
            end
            return false
        end,
        set   = function(_, val)
            if ids then
                for _, id in ipairs(ids) do
                    TFTB.db.profile.groupBuffs.watchedBuffs[id] = val
                end
            end
        end
    }
end

--------------------------------------------------------------------------------
-- Options Table
--------------------------------------------------------------------------------

function ns.GetCombatBuffsOptions()
    local TFTB = ns.TFTB

    local options = {
        name = L["COMBAT_TITLE"],
        type = "group",
        args = {
            messagingCombat = {
                type   = "select",
                name   = L["COMBAT_MESSAGING"],
                style  = "dropdown",
                width  = "double",
                order  = 10,
                values = {
                    ["NONE"]    = L["MESSAGING_NONE"],
                    ["PRINT"]   = L["MESSAGING_PRINT"],
                    ["WHISPER"] = L["MESSAGING_WHISPER"]
                },
                get = function() return TFTB.db.profile.groupBuffs.messaging end,
                set = function(_, val) TFTB.db.profile.groupBuffs.messaging = val end
            },
            space1 = Spacer(11),

            headerTracked = Desc(
                "\n" .. ns.GetColor("TEXT") .. L["COMBAT_TRACKED"] .. "|r",
                12
            ),
            space2 = Spacer(13)
        }
    }

    if Data.SPELL_LIST then
        local classOrder = 20
        local classList = {}
        local hasItems = false

        for class, _ in pairs(Data.SPELL_LIST) do
            if class == "ITEMS" then
                hasItems = true
            else
                table.insert(classList, class)
            end
        end

        table.sort(classList)

        if hasItems then
            table.insert(classList, "ITEMS")
        end

        for _, class in ipairs(classList) do
            local spellGroups = Data.SPELL_LIST[class]
            local hasVisibleSpells = false

            for _, spellData in ipairs(spellGroups) do
                for _, id in ipairs(spellData.ids) do
                    if C_Spell.DoesSpellExist(id) then
                        hasVisibleSpells = true
                        break
                    end
                end
                if hasVisibleSpells then
                    break
                end
            end

            if hasVisibleSpells then
                local color = (class == "ITEMS") and Data.COLORS.TITLE
                    or (Data.COLORS[class] or "FFFFFF")
                local groupName = "|cff" .. color
                    .. class:sub(1, 1) .. class:sub(2):lower() .. "|r"

                options.args["class_" .. class] = {
                    type   = "group",
                    name   = groupName,
                    order  = classOrder,
                    inline = true,
                    args   = {}
                }

                local spellOrder = 1
                for _, spellData in ipairs(spellGroups) do
                    local spellExists = false
                    for _, id in ipairs(spellData.ids) do
                        if C_Spell.DoesSpellExist(id) then
                            spellExists = true
                            break
                        end
                    end
                    if spellExists then
                        local key = "spell_" .. spellData.name:gsub(" ", "_")
                        options.args["class_" .. class].args[key] =
                            DefineSpellGroupToggle(spellData, spellOrder)
                        spellOrder = spellOrder + 1
                    end
                end
                classOrder = classOrder + 1
            end
        end
    end

    return options
end