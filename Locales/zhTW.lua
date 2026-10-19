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
-- Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"版本 %s。設定（包括關閉此訊息的選項）位於 選項 > 插件 > Thanks for the Buff (TFTB)。喜歡這個插件嗎？告訴你的朋友，在 CurseForge 上收藏它，或在 GitHub 上點個 Star。(="
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
L["MESSAGE_WHISPER_THANKS"] = "感謝你的 %s"
L["MESSAGE_SELECT_PLAYER"] = "請先以一名玩家為目標。"
L["MESSAGE_CANT_THANK_SELF"] = "你不能感謝自己！"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "%s 使用了 %s！"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s 使用了 %s，目標是 %s！"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "未知法術"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "啟用歡迎訊息"
L["OPTIONS_WELCOME_DESCRIPTION"] = "登入時顯示一則只有你能看到的訊息。"
L["OPTIONS_DESCRIPTION"] =
	"透過密語或表情感謝每一位為你施加增益的玩家，並用一鍵施放的增益追蹤器查看誰缺少你的團隊增益。還會提醒你大餐、傳送門、召喚、靈魂之井和同職業的冷卻技能。禮數周到，全自動。"
L["OPTIONS_FEATURES_HEADER"] = "功能"
L["OPTIONS_FEATURES_DESCRIPTION"] = "在此處或各功能自己的面板中開啟或關閉每項功能。"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "打開此插件的選項介面。"
L["OPTIONS_EXAMPLE"] = "範例：%s"

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
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Stranger Buffs
L["TAB_STRANGERS"] = "來自陌生人的增益"
L["STRANGERS_ENABLE"] = "啟用對陌生人增益的感謝"
L["STRANGERS_ENABLE_DESCRIPTION"] = "開啟對隊伍外玩家所施增益的感謝。"
L["STRANGERS_DESCRIPTION"] = "在開放世界中，感謝隊伍外的玩家為你施放的增益。"
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "感謝冷卻時間"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"設定兩輪感謝之間的間隔，無論增益來自誰。設為零則對每個增益都表示感謝。"
L["STRANGERS_SOURCE_COOLDOWN"] = "同一玩家感謝冷卻時間"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"設定對同一名玩家兩次感謝之間的間隔。設為零則對每個增益都表示感謝。"
L["STRANGERS_MIN_DURATION"] = "最短增益持續時間"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"忽略持續時間短於此值的增益。設為零則對每個增益都作出反應。"

-- Teammate Buffs
L["TAB_TEAMMATES"] = "來自隊友的增益"
L["TEAMMATES_ENABLE"] = "啟用對隊友增益的感謝"
L["TEAMMATES_ENABLE_DESCRIPTION"] = "開啟對隊伍或團隊成員為你施放的增益和冷卻技能的感謝。"
L["TEAMMATES_DESCRIPTION"] = "感謝隊伍和團隊成員對你施放的增益與冷卻技能。"

-- Service Alerts
L["TAB_SERVICES"] = "服務提醒"
L["SERVICES_ENABLE"] = "啟用服務提醒"
L["SERVICES_ENABLE_DESCRIPTION"] =
	"開啟對大餐、靈魂之井、傳送門以及其他為你的隊伍擺放的幫助的提醒。"
L["SERVICES_DESCRIPTION"] =
	"有人為你的隊伍擺出幫助時作出反應：大餐、靈魂之井、傳送門和修理機器人。"

-- Send Good News
L["TAB_GOOD_NEWS"] = "發送好消息"
L["GOOD_NEWS_DESCRIPTION"] =
	"讓被你施加增益的玩家知道你為他們施放了什麼，以及能持續多久。"
L["GOOD_NEWS_WHISPER_ENABLE"] = "啟用好消息"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"密語被你施加增益的玩家，告訴對方獲得了什麼增益以及持續多久。"
L["GOOD_NEWS_SCOPE"] = "接收者"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "任何被你增益的人"
L["GOOD_NEWS_SCOPE_GROUP"] = "僅隊伍或團隊成員"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"設定誰會收到好消息密語：任何被你增益的人，或僅限你的隊伍成員。"
L["GOOD_NEWS_MESSAGES_HEADER"] = "好消息訊息"
L["GOOD_NEWS_MESSAGES_DESCRIPTION"] = "被你增益的玩家會收到的密語。"
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
L["PEER_PRESSURE_ENABLE_DESCRIPTION"] = "開啟其他同職業玩家使用追蹤的冷卻技能時的提醒。"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"有同職業冷卻技能被使用時，顯示一則只有你能看到的訊息。"
L["PEER_PRESSURE_OWN_CASTS"] = "自己施放時也觸發"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"你自己使用冷卻技能時也會觸發，而不僅限於其他玩家使用時。"
L["PEER_PRESSURE_SOUND_DESCRIPTION"] = "有同職業冷卻技能被使用時播放音效。只有你能聽到。"

-- Shared across the buff panels
L["TRACKED_HEADER"] = "追蹤的技能"
L["TRACKED_GROUP_ITEMS"] = "物品"
L["TRACKED_TOGGLE_DESCRIPTION"] = "開啟或關閉對 %s 的追蹤。"
L["TRACKED_ITEM_PENDING"] = "物品 #%d"
L["TRACKED_SPELL_PENDING"] = "法術 #%d"

-- Shared by Send Good News and the Thank You Button
L["WHISPER_MESSAGE"] = "密語訊息"
L["WHISPER_MESSAGE_RESET"] = "重設"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "將密語訊息恢復為預設文字。"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "感謝密語與表情"
L["NOTIFICATIONS_HEADER"] = "通知"
L["PRAISE_DESCRIPTION"] = "對方玩家看到的內容：一則感謝密語、一個表情，或兩者兼有。"
L["NOTIFICATIONS_DESCRIPTION"] = "只有你會收到的內容：一則文字提示、一段音效，或兩者兼有。"

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "選擇表情"

L["PRAISE_WHISPER_ENABLE"] = "啟用感謝密語"
L["PRAISE_WHISPER_DESCRIPTION"] = "向為你施加增益的玩家密語致謝。"
L["PRAISE_EMOTES_ENABLE"] = "啟用表情"
L["PRAISE_EMOTES_DESCRIPTION"] = "用表情表達你的謝意。戰鬥中會暫緩發送表情。"
L["PRAISE_DELAY_ENABLE"] = "啟用感謝延遲"
L["PRAISE_DELAY_DESCRIPTION"] =
	"在發送密語和表情前稍作等待，避免你的感謝與增益在同一瞬間出現。通知不受影響。"
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "設定發送密語和表情前的等待時間。"

L["NOTIFICATIONS_PRINT_ENABLE"] = "啟用文字提示"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "獲得增益時，顯示一則只有你能看到的訊息。"
L["NOTIFICATIONS_SOUND_ENABLE"] = "啟用音效"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "獲得增益時播放音效。只有你能聽到。"
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "播放該音效，讓你在開啟前先試聽。"

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups that no single game record names
    (Data/{Game}/Tracked-Abilities-{Game}.lua). Single spells and items, and a
    group named after one of its own items, take their names from the client.
]]
L["GROUP_PORTALS"] = "傳送門"
L["GROUP_RESISTANCE_CAULDRONS"] = "抗性大鍋"
L["GROUP_REPAIR_BOTS"] = "修理機器人"

--------------------------------------------------------------------------------
-- Options: Buff Duty
--------------------------------------------------------------------------------

L["TAB_BUFF_WINDOW"] = "增益值班"
L["BUFF_WINDOW_DESCRIPTION"] = "顯示誰缺少你的增益。點擊圖示即可施放。"
L["BUFF_WINDOW_ENABLE"] = "啟用增益值班"
L["BUFF_WINDOW_ENABLE_DESCRIPTION"] =
	"開啟增益值班，即列出缺少你可施放增益的隊伍成員的視窗。"
L["BUFF_WINDOW_NO_BUFFS"] =
	"你的職業沒有此列表中的增益，因此該視窗在這個角色上永遠不會出現。"
L["BUFF_WINDOW_HEADER"] = "視窗"
L["BUFF_WINDOW_WINDOW_DESCRIPTION"] = "讓視窗留在你放置的位置，或在戰鬥中不擋視線。"
L["BUFF_WINDOW_LOCK"] = "鎖定視窗"
L["BUFF_WINDOW_LOCK_DESCRIPTION"] = "使視窗無法移動。解鎖後，可拖曳其背景來移動視窗。"
L["BUFF_WINDOW_HIDE_IN_COMBAT"] = "戰鬥中隱藏"
L["BUFF_WINDOW_HIDE_IN_COMBAT_DESCRIPTION"] =
	"在戰鬥中隱藏視窗。戰鬥中列表無法更新，因此保持顯示的視窗會停留在最後的狀態，直到戰鬥結束。"
L["BUFF_WINDOW_SHOW_HEADER"] = "在視窗中顯示"
L["BUFF_WINDOW_SHOW_DESCRIPTION"] =
	"將你自己的增益、為你施放增益的陌生人以及你的目標加入視窗。"
L["BUFF_WINDOW_FAVOR_ENABLE"] = "禮尚往來"
L["BUFF_WINDOW_FAVOR_ENABLE_DESCRIPTION"] =
	"列出最近為你施放增益的陌生人，以及你可以回贈他們的增益。右鍵點擊圖示可將某人從列表中移除。"
L["BUFF_WINDOW_FAVOR_SECONDS_DESCRIPTION"] =
	"設定陌生人在最後一次施放增益後保留在列表中的時間。"
L["BUFF_WINDOW_TARGET_ENABLE"] = "你的目標"
L["BUFF_WINDOW_TARGET_ENABLE_DESCRIPTION"] =
	"當你的目標是缺少你可施放增益的隊伍外玩家時，將其列出。"
L["BUFF_WINDOW_REFRESH"] = "剩餘低於此值時補充"
L["BUFF_WINDOW_REFRESH_DESCRIPTION"] =
	"設定增益剩餘時間低於多少時視為缺失，方便你在增益消失前及時補上。持續時間不超過此值的增益，只有在消失後才會視為缺失。"
L["BUFF_WINDOW_PETS_AS_TANKS"] = "將寵物視為坦克"
L["BUFF_WINDOW_PETS_AS_TANKS_DESCRIPTION"] =
	"除了設為所有人的增益外，也為寵物提供設為坦克的增益，例如荊棘術。"
L["BUFF_WINDOW_PETS_AS_TANKS_WHEN_DESCRIPTION"] = "設定寵物何時視為坦克。"
L["BUFF_WINDOW_PETS_AS_TANKS_SOLO"] = "不在隊伍中時"
L["BUFF_WINDOW_PETS_AS_TANKS_ALWAYS"] = "總是"
-- Who each buff is offered to: one dropdown per buff, these four choices.
L["BUFF_WINDOW_AUDIENCE_OFF"] = "關閉"
L["BUFF_WINDOW_AUDIENCE_TANK"] = "坦克"
L["BUFF_WINDOW_AUDIENCE_HEALER"] = "治療者"
L["BUFF_WINDOW_AUDIENCE_ALL"] = "所有人"
-- The dropdown's tooltip when the client has no description for the spell yet.
L["BUFF_WINDOW_AUDIENCE_DESCRIPTION"] = "設定 %s 提供給誰。"
L["BUFF_WINDOW_BUFFS_DESCRIPTION"] =
	"選擇每個增益提供給誰。坦克和治療者依隊伍職責判定，未設定職責時依職業判定。"

L["BUFF_WINDOW_SELF_DESCRIPTION"] = "你自己的增益，固定在視窗頂部。"
--[[
    Muted note after a class name on the Self-Buffs panel, for a family of self
    buffs only one of which can be up at a time. Keyed by the family.
]]
L["BUFF_WINDOW_SELF_NOTE_ASPECT"] = "任意一種守護即可"
L["BUFF_WINDOW_SELF_NOTE_MAGE_ARMOR"] = "任意一種護甲即可"
L["BUFF_WINDOW_SELF_NOTE_PALADIN_AURA"] = "任意一種光環即可"
L["BUFF_WINDOW_SELF_NOTE_SHAMAN_SHIELD"] = "任意一種護盾即可"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_ARMOR"] = "任意一種護甲即可"
L["BUFF_WINDOW_SELF_REFRESH_OFF"] = "關閉"
L["BUFF_WINDOW_SELF_REFRESH_MISSING"] = "缺失時"
-- %s is a duration from the client, like "5 Minutes".
L["BUFF_WINDOW_SELF_REFRESH_UNDER"] = "剩餘不足%s"
L["BUFF_WINDOW_SELF_REFRESH_DESCRIPTION"] =
	"設定 %s 何時顯示：從不、消失後，或剩餘時間少於此值時。"
L["BUFF_WINDOW_SELF_ENABLE"] = "你的自身增益"
L["BUFF_WINDOW_SELF_ENABLE_DESCRIPTION"] =
	"當只能對自己施放的增益（例如護甲類法術或心靈之火）缺失或即將結束時，將其顯示在視窗頂部。可在自身增益中選擇要顯示哪些。"

-- The window itself
L["BUFF_WINDOW_SELF_HEADER"] = "自身增益"
L["BUFF_WINDOW_FAVOR_HEADER"] = "禮尚往來"
L["BUFF_WINDOW_TARGET_HEADER"] = "目標"
L["BUFF_WINDOW_TOOLTIP_CAST"] = "點擊對 %s 施放。"
L["BUFF_WINDOW_TOOLTIP_GROUP"] = "點擊對 %s 及其隊伍施放。"
L["BUFF_WINDOW_TOOLTIP_FAVOR"] = "點擊選取 %s 為目標並施放。"
L["BUFF_WINDOW_TOOLTIP_DISMISS"] = "右鍵點擊將 %s 從列表中移除。"

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
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = '啟用巨集 "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "建立一個名為 %s 的巨集，關閉此項時會將其刪除。"
L["BUTTON_WHISPER_DESCRIPTION"] = "設定此按鈕向你的目標發送的密語。留空則不發送密語。"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "謝謝，你最棒了！(="
--[[
    The star marker (left off on WoW Forever) and " // TFTB" sign-off are added
    by the builder, which also drops the closing punctuation; neither is part of
    the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "你獲得了 %a"

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
