local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "zhTW")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff (TFTB)" -- Full Name
L["ADDON_SHORT_NAME"] = "TFTB" -- Short Name

--------------------------------------------------------------------------------
-- Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"版本 %s。設定（包括關閉此訊息的選項）位於 選項 > 插件 > Thanks for the Buff (TFTB)。喜歡這個插件嗎？告訴你的朋友，在 CurseForge 上收藏它，或在 GitHub 上點個 Star。(="
L["CHAT_OPTIONS_IN_COMBAT"] = "基於安全考量，戰鬥中無法打開選項介面。"

-- Buff print out
L["MESSAGE_BUFFED"] = "%s 給你施放了 %s！"

-- Thank You Button
L["MESSAGE_SELECT_PLAYER"] = "請先以一名玩家為目標。"
L["MESSAGE_CANT_THANK_SELF"] = "你不能感謝自己！"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "未知法術"
L["SAMPLE_EXAMPLE"] = "範例：%s"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "啟用歡迎訊息"
L["OPTIONS_WELCOME_DESCRIPTION"] = "登入時顯示一則只有你能看到的訊息。"
L["OPTIONS_DESCRIPTION"] =
	"自動用表情或密語感謝為你施加增益的玩家。陌生人為你施放真言術：韌、秘法智慧或野性印記時會當場收到感謝，點一下感謝巨集，就能感謝你選取的任何人。"
L["OPTIONS_FEATURES_HEADER"] = "功能"
L["OPTIONS_FEATURES_DESCRIPTION"] = "在此處或各功能自己的面板中開啟或關閉每項功能。"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "打開此插件的選項介面。"

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "在找其他功能嗎？"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"部分功能已移到我們的新插件 Good to Go 中。可在 CurseForge 或 Wago 上找到它。"

--------------------------------------------------------------------------------
-- Options: Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "幫助 Thanks for the Buff (TFTB) 升級"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"這個插件由熱愛這款遊戲、希望讓每個人都盡可能玩得開心的玩家打造。我們永遠不會請求捐款。真正的滿足感來自於知道我們的成果讓你的遊戲變得更好一點。如果確實如此，我們很想聽聽你的感受！"
L["OPTIONS_LEVEL_UP_WAYS"] = "以下幾種方式可以幫助我們接觸更多玩家。"
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• 分享回饋：發現了錯誤或有新點子？請在 Discord 上告訴我們。你的回饋能幫助我們改進插件，也隨時歡迎提交拉取請求。"
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• 告訴朋友：認識可能會喜歡這個插件的人嗎？跟他們說說吧。口耳相傳能幫助更多玩家發現優秀的插件。"
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	"• 在 CurseForge 上收藏：開啟下方的 CurseForge 連結，登入後點擊 Download 按鈕下方的星號。收藏能幫助更多玩家發現這個插件。"
L["OPTIONS_LEVEL_UP_GITHUB"] =
	"• 在 GitHub 上點 Star：開啟下方的 GitHub 連結，登入後點擊右上角的 Star。Star 能幫助專案取得更多免費開發者工具的使用資格。"
L["OPTIONS_LEVEL_UP_THANKS"] = "感謝你選擇 Thanks for the Buff (TFTB)！"

L["OPTIONS_FEEDBACK"] = "回饋與支援"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "回饋與支援連結"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "要複製連結，請點擊對應的輸入框，然後按 Ctrl+A 和 Ctrl+C。"
L["OPTIONS_VERSION"] = "版本 %s"

--------------------------------------------------------------------------------
-- Options: Give Thanks
--------------------------------------------------------------------------------

L["TAB_GIVE_THANKS"] = "致謝"
L["GIVE_THANKS_ENABLE"] = "啟用致謝"
L["GIVE_THANKS_ENABLE_DESCRIPTION"] = "開啟對隊伍外玩家所施增益的感謝。"
L["GIVE_THANKS_DESCRIPTION"] = "在開放世界中，感謝隊伍外的玩家為你施放的增益。"

-- Praise Limits
L["PRAISE_HEADER"] = "感謝限制"
L["PRAISE_DESCRIPTION"] = "這些設定會同時限制表情和密語，即使增益接踵而至也不會洗頻。"
-- The dropdown values carry the unit, so these labels do not repeat it.
L["GIVE_THANKS_OVERALL_COOLDOWN"] = "感謝冷卻時間"
L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"設定兩輪感謝之間的間隔，無論增益來自誰。設為零則對每個增益都表示感謝。"
L["GIVE_THANKS_SOURCE_COOLDOWN"] = "同一玩家感謝冷卻時間"
L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"設定對同一名玩家兩次感謝之間的間隔。設為零則對每個增益都表示感謝。"
L["GIVE_THANKS_MIN_DURATION"] = "最短增益持續時間"
L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"] =
	"忽略持續時間短於此值的增益。設為零則對每個增益都作出反應。"
L["PRAISE_DELAY_ENABLE"] = "啟用感謝延遲"
L["PRAISE_DELAY_DESCRIPTION"] =
	"在發送密語和表情前稍作等待，避免你的感謝與增益在同一瞬間出現。通知不受影響。"
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "設定發送密語和表情前的等待時間。"

-- Thank-You Whispers
L["WHISPERS_HEADER"] = "感謝密語"
L["PRAISE_WHISPER_ENABLE"] = "啟用感謝密語"
L["PRAISE_WHISPER_DESCRIPTION"] = "向為你施加增益的玩家密語致謝。"
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"設定 TFTB 向為你施加增益的玩家發送的密語。{spell} 會替換為該增益。留空則不發送密語。"

-- Notifications
L["NOTIFICATIONS_HEADER"] = "通知"
L["NOTIFICATIONS_DESCRIPTION"] = "只有你會收到的內容：一則文字提示、一段音效，或兩者兼有。"
L["NOTIFICATIONS_PRINT_ENABLE"] = "啟用文字提示"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "獲得增益時，顯示一則只有你能看到的訊息。"
L["NOTIFICATIONS_SOUND_ENABLE"] = "啟用音效"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "獲得增益時播放音效。只有你能聽到。"
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "播放該音效，讓你在開啟前先試聽。"

-- Emotes: the grid's group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS entry, upper-cased.
L["TAB_EMOTES_LIST"] = "表情列表"
L["EMOTES_GRID_DESCRIPTION"] =
	"勾選隊伍外玩家為你施加增益時致謝功能可以使用的表情，它會隨機選用一個。戰鬥中會暫緩發送表情。"
L["EMOTE_GROUP_COUNT"] = "%s（已勾選 %d/%d）"
L["EMOTE_GROUP_TEXT"] = "文字"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "只顯示表情文字。"
L["EMOTE_GROUP_VOICE"] = "語音"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "播放一句語音。"
L["EMOTE_GROUP_GESTURE"] = "動作"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "播放一個簡短動作。"
L["EMOTE_GROUP_POSE"] = "姿態"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "持續到你移動為止。"
L["EMOTES_RESET"] = "重設表情"
L["EMOTES_RESET_DESCRIPTION"] = "將清單恢復為預設的感謝表情。"
L["EMOTES_RESET_CONFIRM"] = "將表情清單重設為預設值？"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "忽略的增益"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"此清單中的增益無論由誰施放，都不會發送感謝。你仍會收到文字提示和音效。"
L["IGNORED_BUFFS_ADD_CURRENT"] = "忽略目前增益"
L["IGNORED_BUFFS_ADD_CURRENT_DESCRIPTION"] = "新增你身上目前的一個增益。"
L["IGNORED_BUFFS_ADD"] = "新增增益"
L["IGNORED_BUFFS_ADD_DESCRIPTION"] =
	"輸入法術 ID，或按住 Shift 點擊增益連結將其放入輸入框，然後按 Enter 鍵。"
L["IGNORED_BUFFS_EMPTY"] = "尚未忽略任何增益。請在上方新增。"
L["IGNORED_BUFFS_REMOVE"] = "從清單中移除此增益。"
L["IGNORED_BUFFS_NOT_FOUND"] = "找不到與 %s 對應的增益。"
L["IGNORED_BUFFS_ALL_CHARACTERS"] = "所有角色"
L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"] =
	"將此增益移到「所有角色」清單，這樣任何角色都不會為它發送感謝。"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "感謝按鈕"
L["BUTTON_DESCRIPTION"] = "一次按鍵即可對目標發送密語和表情。讓禮貌自動完成。"
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "感謝按鈕 %d"
L["BUTTON_EMOTE"] = "表情"
L["BUTTON_EMOTE_DESCRIPTION"] = "設定此按鈕對你的目標使用的表情，選擇'無'則不使用表情。"
L["BUTTON_EMOTE_NONE"] = "無"
-- Titles Thank You Button 1's emote checklist.
L["EMOTES_SELECT"] = "選擇表情"
L["BUTTON_ICON"] = "圖示"
L["BUTTON_ICON_DESCRIPTION"] = "設定此按鈕的巨集在巨集清單和快捷列上顯示的圖示。"
-- The Icon dropdown's first choice, the macros' own icon; every other choice is a picture alone.
L["BUTTON_ICON_DEFAULT"] = "預設"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = '啟用巨集 "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "建立一個名為 %s 的巨集，關閉此項時會將其刪除。"
L["BUTTON_WHISPER_DESCRIPTION"] = "設定此按鈕向你的目標發送的密語。留空則不發送密語。"

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks and each Thank You Button.
L["WHISPER_MESSAGE"] = "密語訊息"
L["WHISPER_MESSAGE_RESET"] = "重設"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "將密語訊息恢復為預設文字。"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "謝謝，你最棒了！(="
-- TRANSLATORS: keep {spell} exactly as written; TFTB swaps in the buff's link.
L["DEFAULT_GIVE_THANKS_WHISPER"] = "感謝你的 {spell}"
