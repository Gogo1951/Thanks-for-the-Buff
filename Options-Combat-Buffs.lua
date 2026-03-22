local addonName, ns = ...
local Data = ns.Data

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
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

local function DefineSpellGroupToggle(spellData, order)
    local TFTB = ns.TFTB
    local name = spellData.name
    local ids  = spellData.ids

    local desc = "Toggle tracking for " .. name
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
        name = "Combat Buffs",
        type = "group",
        args = {
            messagingCombat = {
                type   = "select",
                name   = "Messaging",
                style  = "dropdown",
                width  = "double",
                order  = 10,
                values = {
                    ["NONE"]    = "No Message",
                    ["PRINT"]   = "Print-out Message (Self Only)",
                    ["WHISPER"] = "Whisper Message"
                },
                get = function() return TFTB.db.profile.groupBuffs.messaging end,
                set = function(_, val) TFTB.db.profile.groupBuffs.messaging = val end
            },
            space1 = Spacer(11),

            headerTracked = Desc(
                "\n" .. ns.GetColor("TEXT") .. "Tracked Abilities:" .. "|r",
                12
            ),
            space2 = Spacer(13)
        }
    }

    -- Populate class/item spell toggles
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

        -- Append ITEMS at the bottom
        if hasItems then
            table.insert(classList, "ITEMS")
        end

        for _, class in ipairs(classList) do
            local spellGroups = Data.SPELL_LIST[class]
            local hasBuffs = false

            for _, spellData in ipairs(spellGroups) do
                for _, id in ipairs(spellData.ids) do
                    if C_Spell.DoesSpellExist(id) then
                        hasBuffs = true
                        break
                    end
                end
                if hasBuffs then
                    break
                end
            end

            if hasBuffs then
                -- Use title gold for the Items group instead of the class color
                local color = (class == "ITEMS") and Data.COLORS.TITLE or (Data.COLORS[class] or "FFFFFF")
                local groupName = "|cff" .. color .. class:sub(1, 1) .. class:sub(2):lower() .. "|r"

                options.args["class_" .. class] = {
                    type   = "group",
                    name   = groupName,
                    order  = classOrder,
                    inline = true,
                    args   = {}
                }

                local spellOrder = 1
                for _, spellData in ipairs(spellGroups) do
                    local groupExists = false
                    for _, id in ipairs(spellData.ids) do
                        if C_Spell.DoesSpellExist(id) then
                            groupExists = true
                            break
                        end
                    end
                    if groupExists then
                        local key = "spell_" .. spellData.name:gsub(" ", "_")
                        options.args["class_" .. class].args[key] = DefineSpellGroupToggle(spellData, spellOrder)
                        spellOrder = spellOrder + 1
                    end
                end
                classOrder = classOrder + 1
            end
        end
    end

    return options
end