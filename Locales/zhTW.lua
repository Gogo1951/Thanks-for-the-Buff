local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "zhTW")
if not L then return end

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["MSG_ENABLED"] = "已啟用。使用 /tftb 來調整您的設定，包括關閉此訊息。(="
L["MSG_DB_ERROR"] = "錯誤：未能載入資料庫預設值。請透過 /tftb 重置您的設定檔。"
L["MSG_RESET"] = "所有設定已恢復為預設值。"
L["MSG_BUFFED"] = "%s 給您施放了 %s！"
L["MSG_HIT"] = "%s 用 %s 擊中了您！"
L["MSG_PARTY_ITEM"] = "%s 為您的隊伍使用了 %s！"
L["MSG_WHISPER_THANKS"] = "感謝您的 %s！"
L["MSG_SELECT_PLAYER"] = "選擇一位玩家來表達感謝。"
L["MSG_CANT_THANK_SELF"] = "您不能感謝自己！"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_TITLE"] = "Thanks for the Buff!"
L["OPTIONS_GENERAL"] = "一般設定"
L["OPTIONS_WELCOME_TOGGLE"] = "啟用歡迎訊息"
L["OPTIONS_WELCOME_DESC"] = "在您登入時向聊天視窗發送一則訊息。"
L["OPTIONS_RESET"] = "重置"
L["OPTIONS_RESET_ALL"] = "重置所有設定"
L["OPTIONS_RESET_ALL_DESC"] = "將每個選項恢復為其預設值。"
L["OPTIONS_RESET_CONFIRM"] = "您確定要將所有設定重置為預設值嗎？"
L["OPTIONS_DESCRIPTION"] = "每當收到新的增益效果時，自動使用表情來表達開心。"
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
L["STRANGERS_ENABLE"] = "對陌生人的增益做出反應"
L["STRANGERS_COOLDOWN"] = "冷卻時間（秒）"
L["STRANGERS_COOLDOWN_DESC"] = "對同一名玩家表達感謝的最高頻率。"
L["STRANGERS_MIN_DURATION"] = "最低增益持續時間（秒）"
L["STRANGERS_MIN_DURATION_DESC"] = "增益效果必須持續的最短時間才能觸發感謝。\n\n過濾掉恢復或回春術等短時間持續治療。"
L["STRANGERS_MESSAGING"] = "訊息設定"
L["STRANGERS_EMOTES_ENABLE"] = "啟用表情"
L["STRANGERS_EMOTES_DESC"] = "對陌生人提供的增益表示感謝。"
L["STRANGERS_EMOTES_SELECT"] = "選擇表情"

--------------------------------------------------------------------------------
-- Options: Combat Buffs
--------------------------------------------------------------------------------

L["COMBAT_TITLE"] = "戰鬥增益"
L["COMBAT_MESSAGING"] = "訊息設定"
L["COMBAT_TRACKED"] = "追蹤的技能："
L["COMBAT_TOGGLE_TRACKING"] = "切換對 %s 的追蹤"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "感謝按鈕"
L["BUTTON_CREATE_MACRO"] = "建立巨集"
L["BUTTON_CREATE_MACRO_DESC"] = "登入時將自動為您建立一個名為 %s 的巨集。"
L["BUTTON_WHISPER"] = "密語訊息"
L["BUTTON_RESET"] = "重置"
L["BUTTON_RESET_DESC"] = "將密語訊息重置為預設文字。"
L["BUTTON_EMOTES_HEADER"] = "感謝按鈕表情："
L["BUTTON_EMOTES_SELECT"] = "選擇表情"

--------------------------------------------------------------------------------
-- Shared: Messaging Dropdown
--------------------------------------------------------------------------------

L["MESSAGING_NONE"] = "無訊息"
L["MESSAGING_NONE_DEFAULT"] = "無訊息（預設）"
L["MESSAGING_PRINT"] = "聊天視窗訊息（僅自己可見）"
L["MESSAGING_WHISPER"] = "密語訊息"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "謝謝，你最棒了！(="