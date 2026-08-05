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
L["MESSAGE_USED_ITEM"] = "%s 對你使用了%s的 %s！"
L["MESSAGE_USED_SPELL"] = "%s 對你使用了 %s！"
L["MESSAGE_SET_OUT"] = "%s 擺放了 %s！"
L["MESSAGE_OPENED"] = "%s 開啟了 %s！"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "感謝你的 %s！"
L["MESSAGE_GOOD_NEWS_DURATION"] = "好消息！你獲得了%s，持續%s！"
L["MESSAGE_GOOD_NEWS"] = "好消息！你獲得了%s！"
L["MESSAGE_PEER_PRESSURE"] = "%s 使用了 %s！"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s 使用了 %s，目標是 %s！"
L["MESSAGE_SELECT_PLAYER"] = "選擇一位玩家來表達感謝。"
L["MESSAGE_CANT_THANK_SELF"] = "你不能感謝自己！"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MESSAGE_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "他"
L["PRONOUN_HER"] = "她"
L["PRONOUN_THEIR"] = "他們"
L["UNKNOWN_SPELL"] = "未知法術"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "啟用歡迎訊息"
L["OPTIONS_WELCOME_DESCRIPTION"] = "在你登入時向聊天視窗發送一則訊息。"
L["OPTIONS_DESCRIPTION"] =
	"無論是野外的陌生人，還是隊友使用的技能冷卻（如 Power Infusion 或 Innervate），都能透過表情、密語和聊天提示自動向為你提供增益的玩家表示感謝。還會提醒你大餐、傳送門和同職業的技能冷卻。"
L["OPTIONS_SUPPORT"] = "回饋與支援"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "打開此插件的選項介面。"
L["OPTIONS_COMMAND_THANKYOU"] = "/thankyou"
L["OPTIONS_COMMAND_THANKYOU_DESCRIPTION"] = "對你目前的目標發送表情和密語。"

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "來自陌生人的增益"
L["STRANGERS_DESCRIPTION"] = "來自隊伍外的玩家（開放世界）給你的增益。"
L["STRANGERS_OVERALL_COOLDOWN"] = "感謝冷卻時間（秒）"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"無論增益來自誰，向任何人表示感謝的最高頻率。\n\n設為 0 可關閉此限制。通知不受此影響。"
L["STRANGERS_SOURCE_COOLDOWN"] = "同一玩家感謝冷卻時間（秒）"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"對同一名玩家表示感謝的最高頻率。\n\n通知不受此影響。"
L["STRANGERS_MIN_DURATION"] = "最低增益持續時間（秒）"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"增益需要持續多久才值得作出反應。\n\n過濾掉恢復或回春術等短時間持續治療。通知同樣受影響；低於此時長的增益會被完全忽略，不會有訊息、音效、密語或表情。"

--------------------------------------------------------------------------------
-- Options: Combat Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "來自隊友的增益"
L["TEAMMATES_DESCRIPTION"] = "小隊或團隊成員對你施放的增益或冷卻技能。"

-- Group Services
L["TAB_SERVICES"] = "隊伍服務"
L["SERVICES_DESCRIPTION"] =
	"小隊或團隊成員提供的全團幫助：大餐、靈魂石井、傳送門、修理機器人。"

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "好消息"
L["GOOD_NEWS_DESCRIPTION"] = "讓你增益的玩家知道你為其施放了什麼，以及持續多久。"
L["GOOD_NEWS_WHISPER_ENABLE"] = "啟用好消息"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] = "密語你增益的玩家，告訴他們獲得了什麼增益以及持續時間。"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "你增益的任何人"
L["GOOD_NEWS_SCOPE_GROUP"] = "僅隊伍或團隊成員"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "同儕壓力"
L["PEER_PRESSURE_DESCRIPTION"] =
	"當你的同職業玩家使用技能冷卻時收到通知，讓你也屈服於同儕壓力。"
L["PEER_PRESSURE_ENABLE"] = "啟用 Peer Pressure"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"當同職業技能被使用時，在你的聊天視窗輸出一則訊息。只有你能看到。"
L["PEER_PRESSURE_OWN_CASTS"] = "自己施放時也觸發"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"當你自己使用技能冷卻時也觸發提醒，而不僅限於其他玩家。"
L["PEER_PRESSURE_SOUND_DESCRIPTION"] = "當同職業技能被使用時播放音效。只有你能聽到。"

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "追蹤的技能"
L["COMBAT_GROUP_ITEMS"] = "物品"
L["COMBAT_TOGGLE_TRACKING"] = "切換對 %s 的追蹤。"
L["COMBAT_ITEM_PENDING"] = "物品 #%d"
L["COMBAT_SPELL_PENDING"] = "法術 #%d"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

-- The two section headers every buff panel is built from: what the other player
-- sees, then what only you get. Peer Pressure sends nothing outward, so it
-- carries the Notifications header alone. Key prefixes match the header the
-- control appears under.
L["PRAISE_HEADER"] = "感謝訊息與表情"
L["NOTIFICATIONS_HEADER"] = "通知"

L["PRAISE_WHISPER_ENABLE"] = "啟用感謝密語"
L["PRAISE_WHISPER_DESCRIPTION"] = "向給你增益的玩家密語感謝。"
L["PRAISE_EMOTES_ENABLE"] = "啟用表情（脫戰時）"
L["PRAISE_EMOTES_DESCRIPTION"] = "用表情表達你的感謝。戰鬥中會暫緩發送表情。"
L["PRAISE_EMOTES_SELECT"] = "選擇表情"
L["PRAISE_DELAY_ENABLE"] = "啟用感謝延遲"
L["PRAISE_DELAY_DESCRIPTION"] =
	"在密語和表情之前稍作等待，讓你的感謝不會與增益同時出現。\n\n通知不受此影響。"
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "在感謝給你增益的玩家之前等待多久。"

L["NOTIFICATIONS_PRINT_ENABLE"] = "啟用聊天視窗訊息"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"當收到增益時，在你的聊天視窗輸出一則訊息。只有你能看到。"
L["NOTIFICATIONS_SOUND_ENABLE"] = "啟用音效"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "當收到增益時播放音效。只有你能聽到。"

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
L["BUTTON_DESCRIPTION"] = "使用表情和密語感謝你目前的目標。"
L["BUTTON_CREATE_MACRO"] = "建立巨集"
L["BUTTON_CREATE_MACRO_DESCRIPTION"] = "登入時自動為你建立一個名為 %s 的巨集。"
L["BUTTON_WHISPER"] = "密語訊息"
L["BUTTON_RESET"] = "重置"
L["BUTTON_RESET_DESCRIPTION"] = "將密語訊息重置為預設文字。"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "謝謝，你最棒了！(="

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
