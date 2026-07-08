local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "zhTW")
if not L then return end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff (TFTB)"
L["ADDON_SHORT"] = "TFTB"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] = "版本 %s。設定（包括關閉此訊息的選項）可以在「選項 > 插件 > Thanks for the Buff」中找到。喜歡這個插件嗎？告訴您的朋友吧！(="
L["MSG_RESET"] = "所有設定已恢復為預設值。"

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s 給您施放了 %s！"
L["MSG_GAVE_YOU"] = "%s 給了你 %s！"
L["MSG_GAVE_GROUP"] = "%s 給你的隊伍提供了 %s！"
L["MSG_USED_ITEM"] = "%s 對你使用了%s的 %s！"
L["MSG_USED_SPELL"] = "%s 對你使用了 %s！"
L["MSG_SET_OUT"] = "%s 擺放了 %s！"
L["MSG_OPENED"] = "%s 開啟了 %s！"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "感謝您的 %s！"
L["MSG_SELECT_PLAYER"] = "選擇一位玩家來表達感謝。"
L["MSG_CANT_THANK_SELF"] = "您不能感謝自己！"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MSG_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "他"
L["PRONOUN_HER"] = "她"
L["PRONOUN_THEIR"] = "他們"
L["UNKNOWN_SPELL"] = "未知法術"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "啟用歡迎訊息"
L["OPTIONS_WELCOME_DESC"] = "在您登入時向聊天視窗發送一則訊息。"
L["OPTIONS_RESET_ALL_PROFILES"] = "重置所有設定檔"
L["OPTIONS_RESET_ALL_PROFILES_DESCRIPTION"] = "將此帳號上的所有設定檔恢復為預設設定。"
L["OPTIONS_RESET_ALL_PROFILES_CONFIRM"] = "這將把您帳號上的所有設定檔恢復為預設設定——包括每個角色。此操作無法復原。是否繼續？"
L["OPTIONS_DESCRIPTION"] = "每當收到增益效果時，自動透過表情和訊息表達感謝——無論是野外陌生人給你的增益，還是戰鬥中隊友為你開啟的大招。"
L["OPTIONS_SUPPORT"] = "回饋與支援"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "打開 Thanks for the Buff 的選項介面。"
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "對您的目標玩家發送表情和密語。"

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "來自陌生人的增益"
L["STRANGERS_DESC"] = "來自隊伍外的玩家（開放世界）給你的增益。"
L["STRANGERS_COOLDOWN"] = "冷卻時間（秒）"
L["STRANGERS_COOLDOWN_DESC"] = "對同一名玩家發送表情的最高頻率。\n\n訊息不受此影響；它們會在每個增益觸發。"
L["STRANGERS_MIN_DURATION"] = "最低增益持續時間（秒）"
L["STRANGERS_MIN_DURATION_DESC"] = "增益效果必須持續的最短時間才能觸發感謝。\n\n過濾掉恢復或回春術等短時間持續治療。"
L["STRANGERS_MESSAGING"] = "訊息設定"
L["STRANGERS_EMOTES_SELECT"] = "選擇表情"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

L["TEAMMATES_TITLE"] = "來自隊友的增益"
L["TEAMMATES_DESC"] = "小隊或團隊成員對你施放的增益或冷卻技能。"
L["SERVICES_TITLE"] = "隊伍服務"
L["SERVICES_DESC"] = "小隊或團隊成員提供的全團幫助——大餐、靈魂石井、傳送門、修理機器人。"
L["COMBAT_MESSAGING"] = "訊息設定"
L["COMBAT_EMOTES_SELECT"] = "選擇表情"
L["COMBAT_TRACKED"] = "追蹤的技能："
L["COMBAT_TOGGLE_TRACKING"] = "切換對 %s 的追蹤"
L["COMBAT_GROUP_ITEMS"] = "物品"
L["COMBAT_ITEM_PENDING"] = "物品 #%d"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "感謝按鈕"
L["BUTTON_DESC"] = "使用表情和密語感謝你目前的目標。"
L["BUTTON_CREATE_MACRO"] = "建立巨集"
L["BUTTON_CREATE_MACRO_DESC"] = "登入時將自動為您建立一個名為 %s 的巨集。"
L["BUTTON_WHISPER"] = "密語訊息"
L["BUTTON_RESET"] = "重置"
L["BUTTON_RESET_DESC"] = "將密語訊息重置為預設文字。"
L["BUTTON_EMOTES_SELECT"] = "選擇表情"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_PRINT_ENABLE"] = "啟用聊天視窗訊息（僅自己可見）"
L["MESSAGING_PRINT_DESC"] = "當收到增益時，在你的聊天視窗輸出一則訊息。只有你能看到。"
L["MESSAGING_WHISPER_ENABLE"] = "啟用感謝訊息"
L["MESSAGING_WHISPER_DESC"] = "向給你增益的玩家密語感謝。"
L["MESSAGING_EMOTES_ENABLE"] = "啟用表情（脫戰時）"
L["MESSAGING_EMOTES_DESC"] = "用表情表達你的感謝。戰鬥中會暫緩發送表情。"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "謝謝，你最棒了！(="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESC"] = "你向<Target>歡呼。"
L["EMOTE_DRINK_DESC"] = "你向<Target>舉杯致意。"
L["EMOTE_FLEX_DESC"] = "你向<Target>展示肌肉。"
L["EMOTE_GRIN_DESC"] = "你對著<Target>壞笑。"
L["EMOTE_HIGHFIVE_DESC"] = "你與<Target>擊掌。"
L["EMOTE_PRAISE_DESC"] = "你讚美了<Target>。"
L["EMOTE_SALUTE_DESC"] = "你恭敬地向<Target>致敬。"
L["EMOTE_SMILE_DESC"] = "你對<Target>微笑。"
L["EMOTE_THANK_DESC"] = "你向<Target>表示感謝。"
L["EMOTE_WHOA_DESC"] = "你看著<Target>，驚嘆道「哇！」"
L["EMOTE_WINK_DESC"] = "你向<Target>眨眼。"
L["EMOTE_YES_DESC"] = "你向<Target>點頭。"
