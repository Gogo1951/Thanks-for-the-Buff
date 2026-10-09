local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "zhCN")
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
	"版本 %s。设置（包括关闭此消息的选项）可以在 选项 > 插件 > Thanks for the Buff (TFTB) 中找到。喜欢这个插件吗？告诉你的朋友吧！(="
L["CHAT_OPTIONS_IN_COMBAT"] = "出于安全考虑，战斗中无法打开选项界面。"

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s 给你施放了 %s！"
L["MESSAGE_GAVE_YOU"] = "%s 给了你 %s！"
L["MESSAGE_GAVE_GROUP"] = "%s 给你的队伍提供了 %s！"
L["MESSAGE_USED_ITEM"] = "%s 对你使用了 %s！"
L["MESSAGE_USED_SPELL"] = "%s 对你施放了 %s！"
L["MESSAGE_SET_OUT"] = "%s 摆放了 %s！"
L["MESSAGE_OPENED"] = "%s 开启了 %s！"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "感谢你的 %s"
L["MESSAGE_SELECT_PLAYER"] = "选择一位玩家来表达感谢。"
L["MESSAGE_CANT_THANK_SELF"] = "你不能感谢自己！"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "%s 使用了 %s！"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s 使用了 %s，目标是 %s！"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "未知法术"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "启用欢迎信息"
L["OPTIONS_WELCOME_DESCRIPTION"] = "登录时在聊天框中显示一条信息。"
L["OPTIONS_DESCRIPTION"] =
	"通过密语或表情，自动感谢为你施加增益的玩家，并通报你施放的增益，例如能量灌注、激活和灵魂石。还会提醒你大餐、传送门、召唤、灵魂之井和同职业的冷却技能。礼数周到，全自动。"
L["OPTIONS_SUPPORT"] = "反馈与支持"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_VERSION"] = "版本 %s"
L["OPTIONS_FEATURES_HEADER"] = "功能"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "打开此插件的选项界面。"

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Stranger Buffs
L["TAB_STRANGERS"] = "来自陌生人的增益"
L["STRANGERS_ENABLE"] = "启用对陌生人增益的感谢"
L["STRANGERS_ENABLE_DESCRIPTION"] = "开启对队伍外玩家所施增益的感谢。"
L["STRANGERS_DESCRIPTION"] = "在开放世界中，感谢队伍外的玩家为你施放的增益。"
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "感谢冷却时间"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"设置两轮感谢之间的间隔，无论增益来自谁。设为零则对每个增益都表示感谢。"
L["STRANGERS_SOURCE_COOLDOWN"] = "同一玩家感谢冷却时间"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"设置对同一名玩家两次感谢之间的间隔。设为零则对每个增益都表示感谢。"
L["STRANGERS_MIN_DURATION"] = "最短增益持续时间"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"忽略持续时间短于此值的增益。设为零则对每个增益都作出反应。"

-- Teammate Buffs
L["TAB_TEAMMATES"] = "来自队友的增益"
L["TEAMMATES_ENABLE"] = "启用对队友增益的感谢"
L["TEAMMATES_ENABLE_DESCRIPTION"] = "开启对小队或团队成员为你施放的增益和冷却技能的感谢。"
L["TEAMMATES_DESCRIPTION"] = "感谢小队和团队成员对你施放的增益与冷却技能。"

-- Service Alerts
L["TAB_SERVICES"] = "服务提醒"
L["SERVICES_ENABLE"] = "启用服务提醒"
L["SERVICES_ENABLE_DESCRIPTION"] =
	"开启对大餐、灵魂之井、传送门以及其他为你的队伍摆放的帮助的提醒。"
L["SERVICES_DESCRIPTION"] =
	"对队伍提供的全团帮助作出反应：大餐、灵魂之井、传送门和修理机器人。"

-- Send Good News
L["TAB_GOOD_NEWS"] = "发送好消息"
L["GOOD_NEWS_DESCRIPTION"] =
	"让被你施加增益的玩家知道你为他们施放了什么，以及能持续多久。"
L["GOOD_NEWS_WHISPER_ENABLE"] = "启用好消息"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"密语被你施加增益的玩家，告诉对方获得了什么增益以及持续多久。"
L["GOOD_NEWS_SCOPE"] = "接收者"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "任何被你增益的人"
L["GOOD_NEWS_SCOPE_GROUP"] = "仅小队或团队成员"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"设置谁会收到好消息密语：任何被你增益的人，或仅限你的小队或团队成员。"
L["GOOD_NEWS_MESSAGES_HEADER"] = "好消息信息"
--[[
    Two halves so the number stays authoritative: LIMIT's %d is a real placeholder
    and gets formatted, TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_LIMIT"] = "最大长度：%d。"
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a 会变成技能链接。"
--[[
    Appended to the ability link inside %a when the buff has a readable duration.
    A whole clause rather than a bare number so it can be reworded per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "持续 %s"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "同伴压力"
L["PEER_PRESSURE_DESCRIPTION"] =
	"当你的同职业玩家使用冷却技能时收到通知，让你也屈服于同伴压力。"
L["PEER_PRESSURE_ENABLE"] = "启用同伴压力"
L["PEER_PRESSURE_ENABLE_DESCRIPTION"] = "开启其他同职业玩家使用追踪的冷却技能时的提醒。"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"有同职业冷却技能被使用时，在你自己的聊天框中显示一条信息。只有你能看到。"
L["PEER_PRESSURE_OWN_CASTS"] = "自己施放时也触发"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"你自己使用冷却技能时也会触发，而不仅限于其他玩家使用时。"
L["PEER_PRESSURE_SOUND_DESCRIPTION"] = "有同职业冷却技能被使用时播放音效。只有你能听到。"

-- Shared across the buff panels
L["TRACKED_HEADER"] = "追踪的技能"
L["TRACKED_GROUP_ITEMS"] = "物品"
L["TRACKED_TOGGLE_DESCRIPTION"] = "开启或关闭对 %s 的追踪。"
L["TRACKED_ITEM_PENDING"] = "物品 #%d"
L["TRACKED_SPELL_PENDING"] = "法术 #%d"

-- Shared by Send Good News and the Thank You Button
L["WHISPER_MESSAGE"] = "密语信息"
L["WHISPER_MESSAGE_RESET"] = "重置"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "将密语信息恢复为默认文本。"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "感谢信息与表情"
L["NOTIFICATIONS_HEADER"] = "通知"

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "选择表情"

L["PRAISE_WHISPER_ENABLE"] = "启用感谢密语"
L["PRAISE_WHISPER_DESCRIPTION"] = "向为你施加增益的玩家密语致谢。"
L["PRAISE_EMOTES_ENABLE"] = "启用表情"
L["PRAISE_EMOTES_DESCRIPTION"] = "用表情表达你的谢意。战斗中会暂缓发送表情。"
L["PRAISE_DELAY_ENABLE"] = "启用感谢延迟"
L["PRAISE_DELAY_DESCRIPTION"] =
	"在发送密语和表情前稍作等待，避免你的感谢与增益在同一瞬间出现。通知不受影响。"
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "设置发送密语和表情前的等待时长。"

L["NOTIFICATIONS_PRINT_ENABLE"] = "启用聊天信息"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"获得增益时，在你自己的聊天框中显示一条信息。只有你能看到。"
L["NOTIFICATIONS_SOUND_ENABLE"] = "启用音效"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "获得增益时播放音效。只有你能听到。"
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "播放该音效，让你在开启前先试听。"

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups that no single game record names
    (Data/{Game}/Tracked-Abilities-{Game}.lua). Single spells and items, and a
    group named after one of its own items, take their names from the client.
]]
L["GROUP_PORTALS"] = "传送门"
L["GROUP_RESISTANCE_CAULDRONS"] = "抗性大锅"
L["GROUP_REPAIR_BOTS"] = "修理机器人"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "感谢按钮"
L["BUTTON_DESCRIPTION"] =
	"让礼貌自动完成。每个按钮都会密语你当前的目标，还能顺便发个表情：向法师要水、为传送门道谢、在战斗中夸奖朋友那记及时的嘲讽。信息只写一次，之后就只是一次按键的事。"
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "感谢按钮 %d"
L["BUTTON_EMOTE"] = "表情"
L["BUTTON_EMOTE_DESCRIPTION"] = "设置此按钮对你的目标使用的表情，选择'无'则不使用表情。"
L["BUTTON_EMOTE_NONE"] = "无"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = '启用宏 "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "创建一个名为 %s 的宏，关闭此项时会将其删除。"
L["BUTTON_WHISPER_DESCRIPTION"] = "设置此按钮向你的目标发送的密语。留空则不发送密语。"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "谢谢，你最棒了！(="
--[[
    The star marker (left off on WoW Forever) and " // TFTB" sign-off are added
    by the builder, which also drops the closing punctuation; neither is part of
    the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "你获得了 %a"

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "你向<Target>欢呼。"
L["EMOTE_DRINK_DESCRIPTION"] = "你向<Target>举杯致意。"
L["EMOTE_FLEX_DESCRIPTION"] = "你向<Target>展示肌肉。"
L["EMOTE_GRIN_DESCRIPTION"] = "你对着<Target>坏笑。"
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "你与<Target>击掌。"
L["EMOTE_PRAISE_DESCRIPTION"] = "你赞美了<Target>。"
L["EMOTE_SALUTE_DESCRIPTION"] = "你恭敬地向<Target>致敬。"
L["EMOTE_SMILE_DESCRIPTION"] = "你对<Target>微笑。"
L["EMOTE_THANK_DESCRIPTION"] = "你向<Target>表示感谢。"
L["EMOTE_WHOA_DESCRIPTION"] = "你对<Target>惊叹道'哇！'。"
L["EMOTE_WINK_DESCRIPTION"] = "你向<Target>眨眼。"
L["EMOTE_YES_DESCRIPTION"] = "你向<Target>点头。"
