local _, ns = ...
local Data = ns.Data
local L = ns.L

local GetColor = ns.GetColor
local GetSpellName = ns.GetSpellName
local GetSpellDescription = ns.GetSpellDescription
local GetSpellTexture = ns.GetSpellTexture

--------------------------------------------------------------------------------
-- Shared Options Helpers
--------------------------------------------------------------------------------

function ns.OptionsHeader(text, order)
    return {type = "header", name = GetColor("TITLE") .. text .. "|r", order = order}
end

function ns.OptionsDesc(text, order)
    return {type = "description", name = text, fontSize = "medium", order = order}
end

function ns.OptionsSpacer(order)
    return {type = "description", name = " ", order = order}
end

function ns.OptionsSubHeader(text, order, hidden)
    return {type = "description", name = "\n" .. GetColor("TITLE") .. text .. "|r", fontSize = "medium", order = order, hidden = hidden}
end

--------------------------------------------------------------------------------
-- Shared Buff-Panel Builders
--------------------------------------------------------------------------------

--[[
    Scaffold shared by the Buffs-from-Teammates and Group-Services panels
    (Options-Buffs-from-Teammates.lua / Options-Buff-Services.lua). Both panels have the same
    shape -- description, messaging toggles, emote picker, tracked list -- and
    differ only in their text, which settings table they bind to
    (ns.db.teammates / ns.db.services), and which tracked entries they list. The
    watched-buff list is shared (ns.db.watchedBuffs); a given id only ever appears
    on one of the two panels.
]]

--[[
    One toggle per tracked entry. Spell entries carry a resolved name (ranks were
    already collapsed at build time); item entries carry an itemId whose name and
    icon resolve lazily, so a cold item cache fills the label in by the time the
    panel is viewed. Grouped items (Soulstone ranks, Scroll of Agility ranks...)
    also carry an explicit `label` naming the whole group, since their per-rank
    item names differ. Either way the toggle flips every watched id in the entry
    and reads its state from the first.
]]
function ns.DefineEntryToggle(entry, order)
    local ids = entry.ids
    local primary = ids[1]

    local nameField, descField

    if entry.itemId then
        local itemId = entry.itemId
        local groupLabel = entry.label
        nameField = function()
            local shown = groupLabel or GetItemInfo(itemId) or L["COMBAT_ITEM_PENDING"]:format(itemId)
            local texture = GetItemIcon and GetItemIcon(itemId)
            if texture then
                return "|T" .. texture .. ":16|t " .. shown
            end
            return shown
        end
        descField = function()
            -- For a grouped toggle, list every member item (links) so the tooltip
            -- spells out exactly what the single checkbox covers.
            if entry.itemIds and #entry.itemIds > 1 then
                local lines = {}
                for _, id in ipairs(entry.itemIds) do
                    lines[#lines + 1] = (select(2, GetItemInfo(id))) or L["COMBAT_ITEM_PENDING"]:format(id)
                end
                return table.concat(lines, "\n")
            end
            return (select(2, GetItemInfo(itemId))) or ""
        end
    else
        local name = entry.spellName
        local displayName = name
        if primary then
            local texture = GetSpellTexture and GetSpellTexture(primary)
            if texture then
                displayName = "|T" .. texture .. ":16|t " .. name
            end
        end
        nameField = displayName

        if entry.spellIds and #entry.spellIds > 1 then
            -- Grouped spells (e.g. Portals): list the members alphabetically so the
            -- tooltip spells out exactly what the one checkbox covers.
            descField = function()
                local names = {}
                for _, id in ipairs(entry.spellIds) do
                    names[#names + 1] = GetSpellName(id) or ("Spell " .. id)
                end
                table.sort(names)
                return table.concat(names, "\n")
            end
        else
            local desc = string.format(L["COMBAT_TOGGLE_TRACKING"], name)
            if primary then
                local spellDesc = GetSpellDescription and GetSpellDescription(primary)
                if spellDesc and spellDesc ~= "" then
                    desc = spellDesc
                end
            end
            descField = desc
        end
    end

    return {
        type = "toggle",
        name = nameField,
        desc = descField,
        order = order,
        width = "full",
        get = function()
            return ns.db.watchedBuffs[primary]
        end,
        set = function(_, val)
            for _, id in ipairs(ids) do
                ns.db.watchedBuffs[id] = val
            end
        end
    }
end

-- The displayed name embeds an icon escape (|T...|t), so sorting by it would sort
-- by texture path. This returns the clean, lowercased name for comparison only.
local function EntrySortKey(entry)
    local name = entry.label or entry.spellName
    if not name and entry.itemId then
        name = GetItemInfo(entry.itemId)
    end
    return (name or ""):lower()
end

-- A copy of `entries` ordered alphabetically by display name, with the watched id
-- breaking ties for a stable result. Item names resolve lazily, which is why the
-- panels register their builders as functions (run on open, when the item cache
-- is warm) rather than as prebuilt tables.
function ns.SortedEntries(entries)
    local sorted = {}
    for i = 1, #entries do
        sorted[i] = entries[i]
    end
    table.sort(sorted, function(a, b)
        local ka, kb = EntrySortKey(a), EntrySortKey(b)
        if ka == kb then
            return (a.ids[1] or 0) < (b.ids[1] or 0)
        end
        return ka < kb
    end)
    return sorted
end

-- Title, description, messaging toggles, and the emote picker -- everything both
-- panels share. `settingsKey` is "teammates" or "services"; the caller appends
-- its own tracked list afterward.
function ns.BuildBuffPanel(titleKey, descKey, settingsKey)
    local function settings()
        return ns.db[settingsKey]
    end
    local function EmotesHidden()
        return not settings().emotesEnabled
    end

    local options = {
        name = L[titleKey],
        type = "group",
        args = {
            descIntro = ns.OptionsDesc(L[descKey], 1),
            space0 = ns.OptionsSpacer(2),
            headerMessaging = ns.OptionsSubHeader(L["COMBAT_MESSAGING"], 5),
            printOut = {
                type = "toggle",
                name = L["MESSAGING_PRINT_ENABLE"],
                desc = L["MESSAGING_PRINT_DESC"],
                width = "full",
                order = 6,
                get = function()
                    return settings().printEnabled
                end,
                set = function(_, val)
                    settings().printEnabled = val
                end
            },
            whisper = {
                type = "toggle",
                name = L["MESSAGING_WHISPER_ENABLE"],
                desc = L["MESSAGING_WHISPER_DESC"],
                width = "full",
                order = 7,
                get = function()
                    return settings().whisperEnabled
                end,
                set = function(_, val)
                    settings().whisperEnabled = val
                end
            },
            emotes = {
                type = "toggle",
                name = L["MESSAGING_EMOTES_ENABLE"],
                desc = L["MESSAGING_EMOTES_DESC"],
                width = "full",
                order = 8,
                get = function()
                    return settings().emotesEnabled
                end,
                set = function(_, val)
                    settings().emotesEnabled = val
                end
            },
            emoteSpacer = {type = "description", name = " ", order = 9, hidden = EmotesHidden},
            emoteGroup = {
                type = "group",
                name = L["COMBAT_EMOTES_SELECT"],
                order = 10,
                inline = true,
                hidden = EmotesHidden,
                args = {}
            },
            headerTracked = ns.OptionsSubHeader(L["COMBAT_TRACKED"], 12),
            space2 = ns.OptionsSpacer(13)
        }
    }

    for i, emoteData in ipairs(Data.EMOTES) do
        local emote = emoteData.cmd
        options.args.emoteGroup.args[emote] = {
            type = "toggle",
            name = emoteData.displayName,
            desc = emoteData.desc,
            order = i,
            width = "half",
            get = function()
                return settings().emotes[emote]
            end,
            set = function(_, val)
                settings().emotes[emote] = val
            end
        }
    end

    return options
end
