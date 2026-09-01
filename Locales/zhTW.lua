local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "zhTW")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff (TFTB)"
L["ADDON_SHORT"] = "TFTB"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"版本 %s。設定（包括關閉此訊息的選項）可以在 選項 > 插件 > Thanks for the Buff (TFTB) 中找到。喜歡這個插件嗎？告訴你的朋友吧！(="
L["CHAT_OPTIONS_IN_COMBAT"] = "基於安全考量，戰鬥中無法打開選項介面。"

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s 給你施放了 %s！"
L["MESSAGE_GAVE_YOU"] = "%s 給了你 %s！"
L["MESSAGE_GAVE_GROUP"] = "%s 給你的隊伍提供了 %s！"
L["MESSAGE_USED_ITEM"] = "%s 對你使用了 %s！"
L["MESSAGE_USED_SPELL"] = "%s 對你施放了 %s！"
L["MESSAGE_SET_OUT"] = "%s 擺放了 %s！"
L["MESSAGE_OPENED"] = "%s 開啟了 %s！"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "感謝你的 %s！"
L["MESSAGE_PEER_PRESSURE"] = "%s 使用了 %s！"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s 使用了 %s，目標是 %s！"
L["MESSAGE_SELECT_PLAYER"] = "選擇一位玩家來表達感謝。"
L["MESSAGE_CANT_THANK_SELF"] = "你不能感謝自己！"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "未知法術"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "啟用歡迎訊息"
L["OPTIONS_WELCOME_DESCRIPTION"] = "在你登入時向聊天視窗發送一則訊息。"
L["OPTIONS_DESCRIPTION"] =
	"無論是野外的陌生人，還是隊友使用的冷卻技能（如能量灌注或激活），都能透過表情、密語和聊天提示自動向為你提供增益的玩家表示感謝。還會提醒你大餐、傳送門和同職業的冷卻技能。"
L["OPTIONS_SUPPORT"] = "回饋與支援"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "打開此插件的選項介面。"

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "來自陌生人的增益"
L["STRANGERS_ENABLE"] = "啟用對陌生人增益的感謝"
L["STRANGERS_DESCRIPTION"] = "在開放世界中，感謝隊伍外的玩家為你施放的增益。"
--[[
    The dropdown values carry the unit, so these labels do not repeat it. Each
    description is one line because it renders as visible help under its control
    rather than behind a hover.
]]
L["STRANGERS_OVERALL_COOLDOWN"] = "感謝冷卻時間"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"兩次感謝之間的間隔，無論是誰給你增益。設為零則對每個增益都表示感謝。"
L["STRANGERS_SOURCE_COOLDOWN"] = "同一玩家感謝冷卻時間"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"針對同一名玩家的兩次感謝之間的間隔。設為零則對每個增益都表示感謝。"
L["STRANGERS_MIN_DURATION"] = "最低增益持續時間"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"忽略短於此時長的增益。設為零則對每個增益都作出反應。"

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "來自隊友的增益"
L["TEAMMATES_ENABLE"] = "啟用對隊友增益的感謝"
L["TEAMMATES_DESCRIPTION"] = "感謝小隊和團隊成員對你施放的增益與冷卻技能。"

-- Service Alerts
L["TAB_SERVICES"] = "服務提醒"
L["SERVICES_ENABLE"] = "啟用服務提醒"
L["SERVICES_DESCRIPTION"] =
	"對隊伍提供的全團幫助作出反應：大餐、靈魂石井、傳送門、修理機器人。"

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "發送好消息"
L["GOOD_NEWS_DESCRIPTION"] = "讓你增益的玩家知道你為其施放了什麼，以及持續多久。"
L["GOOD_NEWS_WHISPER_ENABLE"] = "啟用好消息"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] = "密語你增益的玩家，告訴他們獲得了什麼增益以及持續時間。"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "你增益的任何人"
L["GOOD_NEWS_SCOPE_GROUP"] = "僅隊伍或團隊成員"
L["GOOD_NEWS_MESSAGES_HEADER"] = "好消息訊息"
L["GOOD_NEWS_MESSAGE"] = "密語訊息"
--[[
    Two halves so the number stays authoritative: LIMIT's %d is a real placeholder
    and gets formatted, TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_LIMIT"] = "最大長度：%d。"
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a 會變成技能連結。"
--[[
    Appended to the ability link inside %a when the buff has a readable duration.
    A whole clause rather than a bare number so it can be reworded per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "持續 %s"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "同儕壓力"
L["PEER_PRESSURE_DESCRIPTION"] =
	"當你的同職業玩家使用冷卻技能時收到通知，讓你也屈服於同儕壓力。"
L["PEER_PRESSURE_ENABLE"] = "啟用同儕壓力"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"當同職業技能被使用時，在你的聊天視窗輸出一則訊息。只有你能看到。"
L["PEER_PRESSURE_OWN_CASTS"] = "自己施放時也觸發"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"當你自己使用冷卻技能時也觸發提醒，而不僅限於其他玩家。"
L["PEER_PRESSURE_SOUND_DESCRIPTION"] = "當同職業技能被使用時播放音效。只有你能聽到。"

-- Shared across the buff panels
L["TRACKED_HEADER"] = "追蹤的技能"
L["TRACKED_GROUP_ITEMS"] = "物品"
L["TRACKED_TOGGLE_DESCRIPTION"] = "切換對 %s 的追蹤。"
L["TRACKED_ITEM_PENDING"] = "物品 #%d"
L["TRACKED_SPELL_PENDING"] = "法術 #%d"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "感謝訊息與表情"
L["NOTIFICATIONS_HEADER"] = "通知"

L["PRAISE_WHISPER_ENABLE"] = "啟用感謝密語"
L["PRAISE_WHISPER_DESCRIPTION"] = "向給你增益的玩家密語感謝。"
L["PRAISE_EMOTES_ENABLE"] = "啟用表情"
L["PRAISE_EMOTES_DESCRIPTION"] = "用表情表達你的感謝。戰鬥中會暫緩發送表情。"
L["PRAISE_EMOTES_SELECT"] = "選擇表情"
L["PRAISE_DELAY_ENABLE"] = "啟用感謝延遲"
L["PRAISE_DELAY_DESCRIPTION"] =
	"在密語和表情之前稍作等待，讓你的感謝不會與增益同時出現。通知不受影響。"
L["PRAISE_DELAY_HELP"] = "感謝前稍作等待，讓你的感謝不會與增益同時出現。"

L["NOTIFICATIONS_PRINT_ENABLE"] = "啟用聊天訊息"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"當收到增益時，在你的聊天視窗輸出一則訊息。只有你能看到。"
L["NOTIFICATIONS_SOUND_ENABLE"] = "啟用音效"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "當收到增益時播放音效。只有你能聽到。"

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
    spells and items take their names from the client and need no key here.
]]
L["GROUP_PORTALS"] = "傳送門"
L["GROUP_SOULSTONE"] = "靈魂石"
L["GROUP_RESISTANCE_CAULDRONS"] = "抗性大鍋"
L["GROUP_SCROLL_OF_SPIRIT"] = "精神卷軸"
L["GROUP_SCROLL_OF_STAMINA"] = "耐力卷軸"
L["GROUP_SCROLL_OF_STRENGTH"] = "力量卷軸"
L["GROUP_SCROLL_OF_PROTECTION"] = "保護卷軸"
L["GROUP_SCROLL_OF_INTELLECT"] = "智力卷軸"
L["GROUP_SCROLL_OF_AGILITY"] = "敏捷卷軸"
L["GROUP_REPAIR_BOTS"] = "修理機器人"
L["GROUP_JUMPER_CABLES"] = "跨接電纜"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "感謝按鈕"
L["BUTTON_DESCRIPTION"] =
	"讓禮貌自動完成。每個按鈕都會密語你目前的目標，還能順便發個表情：向法師要水、為傳送門道謝、在戰鬥中誇獎朋友那記及時的嘲諷。訊息只寫一次，之後就只是一次按鍵的事。"
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "TFTB 按鈕 %d"
L["BUTTON_EMOTE"] = "表情"
L["BUTTON_EMOTE_NONE"] = "無"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = '啟用巨集 "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "建立一個名為 %s 的巨集，關閉此項時再將其刪除。"
L["BUTTON_WHISPER"] = "密語訊息"
L["BUTTON_RESET"] = "重置"
L["BUTTON_RESET_DESCRIPTION"] = "將密語訊息重置為預設文字。"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "謝謝，你最棒了！(="
--[[
    The star marker and "TFTB // " prefix are added by the builder and are not
    part of the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "你獲得了 %a！"

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "你向<Target>歡呼。"
L["EMOTE_DRINK_DESCRIPTION"] = "你向<Target>舉杯致意。"
L["EMOTE_FLEX_DESCRIPTION"] = "你向<Target>展示肌肉。"
L["EMOTE_GRIN_DESCRIPTION"] = "你對著<Target>壞笑。"
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "你與<Target>擊掌。"
L["EMOTE_PRAISE_DESCRIPTION"] = "你讚美了<Target>。"
L["EMOTE_SALUTE_DESCRIPTION"] = "你恭敬地向<Target>致敬。"
L["EMOTE_SMILE_DESCRIPTION"] = "你對<Target>微笑。"
L["EMOTE_THANK_DESCRIPTION"] = "你向<Target>表示感謝。"
L["EMOTE_WHOA_DESCRIPTION"] = "你對<Target>驚嘆道'哇！'。"
L["EMOTE_WINK_DESCRIPTION"] = "你向<Target>眨眼。"
L["EMOTE_YES_DESCRIPTION"] = "你向<Target>點頭。"
