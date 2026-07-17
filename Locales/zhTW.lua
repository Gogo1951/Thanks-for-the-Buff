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
	"版本 %s。設定（包括關閉此訊息的選項）可以在 選項 > 插件 > Thanks for the Buff 中找到。喜歡這個插件嗎？告訴你的朋友吧！(="

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s 給你施放了 %s！"
L["MSG_GAVE_YOU"] = "%s 給了你 %s！"
L["MSG_GAVE_GROUP"] = "%s 給你的隊伍提供了 %s！"
L["MSG_USED_ITEM"] = "%s 對你使用了%s的 %s！"
L["MSG_USED_SPELL"] = "%s 對你使用了 %s！"
L["MSG_SET_OUT"] = "%s 擺放了 %s！"
L["MSG_OPENED"] = "%s 開啟了 %s！"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "感謝你的 %s！"
L["MSG_GOODNEWS_DURATION"] = "好消息！你獲得了%s，持續%s！"
L["MSG_GOODNEWS"] = "好消息！你獲得了%s！"
L["MSG_PEER_PRESSURE"] = "%s 使用了 %s！"
L["MSG_PEER_PRESSURE_TARGET"] = "%s 使用了 %s，目標是 %s！"
L["MSG_SELECT_PLAYER"] = "選擇一位玩家來表達感謝。"
L["MSG_CANT_THANK_SELF"] = "你不能感謝自己！"

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
L["OPTIONS_WELCOME_DESC"] = "在你登入時向聊天視窗發送一則訊息。"
L["OPTIONS_DESCRIPTION"] =
	"無論是野外的陌生人，還是隊友使用的技能冷卻（如 Power Infusion 或 Innervate），都能透過表情、密語和聊天提示自動向為你提供增益的玩家表示感謝。還會提醒你大餐、傳送門和同職業的技能冷卻。"
L["OPTIONS_SUPPORT"] = "回饋與支援"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "打開 Thanks for the Buff 的選項介面。"
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "對你目前的目標發送表情和密語。"

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "來自陌生人的增益"
L["STRANGERS_DESC"] = "來自隊伍外的玩家（開放世界）給你的增益。"
L["STRANGERS_COOLDOWN"] = "冷卻時間（秒）"
L["STRANGERS_COOLDOWN_DESC"] =
	"對同一名玩家發送表情的最高頻率。\n\n訊息不受此影響；它們會在每個增益觸發。"
L["STRANGERS_MIN_DURATION"] = "最低增益持續時間（秒）"
L["STRANGERS_MIN_DURATION_DESC"] =
	"增益效果必須持續的最短時間才能觸發感謝。\n\n過濾掉恢復或回春術等短時間持續治療。"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "來自隊友的增益"
L["TEAMMATES_DESC"] = "小隊或團隊成員對你施放的增益或冷卻技能。"

-- Group Services
L["TAB_SERVICES"] = "隊伍服務"
L["SERVICES_DESC"] =
	"小隊或團隊成員提供的全團幫助：大餐、靈魂石井、傳送門、修理機器人。"

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "好消息"
L["GOOD_NEWS_DESC"] = "自動密語你增益的玩家，告知你為其施放的戰鬥增益。"
L["GOOD_NEWS_WHISPER_ENABLE"] = "啟用好消息"
L["GOOD_NEWS_WHISPER_DESC"] = "密語你增益的玩家，告訴他們獲得了什麼增益以及持續時間。"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "你增益的任何人"
L["GOOD_NEWS_SCOPE_GROUP"] = "僅隊伍或團隊成員"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Peer Pressure"
L["PEER_PRESSURE_DESC"] =
	"當你的同職業玩家使用技能冷卻時收到通知，讓你也屈服於 Peer Pressure。"
L["PEER_PRESSURE_ENABLE"] = "啟用 Peer Pressure"
L["PEER_PRESSURE_PRINT_DESC"] =
	"當同職業技能被使用時，在你的聊天視窗輸出一則訊息。只有你能看到。"
L["PEER_PRESSURE_OWN_CASTS"] = "自己施放時也觸發"
L["PEER_PRESSURE_OWN_CASTS_DESC"] = "當你自己使用技能冷卻時也觸發提醒，而不僅限於其他玩家。"
L["PEER_PRESSURE_SOUND_DESC"] = "當同職業技能被使用時播放音效。只有你能聽到。"

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "追蹤的技能"
L["COMBAT_GROUP_ITEMS"] = "物品"
L["COMBAT_TOGGLE_TRACKING"] = "切換對 %s 的追蹤"
L["COMBAT_ITEM_PENDING"] = "物品 #%d"
L["COMBAT_SPELL_PENDING"] = "法術 #%d"

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

-- Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
-- spells and items take their names from the client and need no key here.
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
L["BUTTON_DESC"] = "使用表情和密語感謝你目前的目標。"
L["BUTTON_CREATE_MACRO"] = "建立巨集"
L["BUTTON_CREATE_MACRO_DESC"] = "登入時自動為你建立一個名為 %s 的巨集。"
L["BUTTON_WHISPER"] = "密語訊息"
L["BUTTON_RESET"] = "重置"
L["BUTTON_RESET_DESC"] = "將密語訊息重置為預設文字。"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_HEADER"] = "訊息設定"
L["MESSAGING_PRINT_ENABLE"] = "啟用聊天視窗訊息（僅自己可見）"
L["MESSAGING_PRINT_DESC"] = "當收到增益時，在你的聊天視窗輸出一則訊息。只有你能看到。"
L["MESSAGING_WHISPER_ENABLE"] = "啟用感謝訊息"
L["MESSAGING_WHISPER_DESC"] = "向給你增益的玩家密語感謝。"
L["MESSAGING_EMOTES_ENABLE"] = "啟用表情（脫戰時）"
L["MESSAGING_EMOTES_DESC"] = "用表情表達你的感謝。戰鬥中會暫緩發送表情。"
L["MESSAGING_EMOTES_SELECT"] = "選擇表情"
L["MESSAGING_SOUND_ENABLE"] = "啟用音效"
L["MESSAGING_SOUND_DESC"] = "當收到增益時播放音效。只有你能聽到。"

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
L["EMOTE_WHOA_DESC"] = "你看著<Target>，驚嘆道'哇！'"
L["EMOTE_WINK_DESC"] = "你向<Target>眨眼。"
L["EMOTE_YES_DESC"] = "你向<Target>點頭。"
