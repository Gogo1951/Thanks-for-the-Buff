local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "zhCN")
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
	"版本 %s。设置（包括关闭此消息的选项）位于 选项 > 插件 > Thanks for the Buff (TFTB)。喜欢这个插件吗？告诉你的朋友，在 CurseForge 上收藏它，或在 GitHub 上点个 Star。(="
L["CHAT_OPTIONS_IN_COMBAT"] = "出于安全考虑，战斗中无法打开选项界面。"

-- Buff print out
L["MESSAGE_BUFFED"] = "%s 给你施放了 %s！"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "感谢你的 %s"
L["MESSAGE_SELECT_PLAYER"] = "请先以一名玩家为目标。"
L["MESSAGE_CANT_THANK_SELF"] = "你不能感谢自己！"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "未知法术"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "启用欢迎信息"
L["OPTIONS_WELCOME_DESCRIPTION"] = "登录时显示一条只有你能看到的信息。"
L["OPTIONS_DESCRIPTION"] =
	"自动通过密语或表情感谢每一位为你施加增益的玩家，还能点一下感谢宏，亲手感谢任何人。礼数周到，全自动。"
L["OPTIONS_FEATURES_HEADER"] = "功能"
L["OPTIONS_FEATURES_DESCRIPTION"] = "在此处或各功能自己的面板中开启或关闭每项功能。"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "打开此插件的选项界面。"
L["SAMPLE_EXAMPLE"] = "示例：%s"

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "在找其他功能吗？"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"部分功能已移到我们的新插件 Good to Go 中。可在 CurseForge 或 Wago 上找到它。"

--------------------------------------------------------------------------------
-- Options: Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "帮助 Thanks for the Buff (TFTB) 升级"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"这个插件由热爱这款游戏、希望让每个人都尽可能玩得开心的玩家打造。我们永远不会请求捐款。真正的满足感来自于知道我们的工作让你的游戏变得更好一点。如果确实如此，我们很想听听你的感受！"
L["OPTIONS_LEVEL_UP_WAYS"] = "以下几种方式可以帮助我们触及更多玩家。"
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• 分享反馈：发现了错误或有新想法？请在 Discord 上告诉我们。你的反馈能帮助我们改进插件，也随时欢迎提交拉取请求。"
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• 告诉朋友：认识可能会喜欢这个插件的人吗？跟他们说说吧。口口相传能帮助更多玩家发现优秀的插件。"
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	"• 在 CurseForge 上收藏：打开下方的 CurseForge 链接，登录后点击 Download 按钮下方的星标。收藏能帮助更多玩家发现这个插件。"
L["OPTIONS_LEVEL_UP_GITHUB"] =
	"• 在 GitHub 上点 Star：打开下方的 GitHub 链接，登录后点击右上角的 Star。Star 能帮助项目获得更多免费开发者工具的使用资格。"
L["OPTIONS_LEVEL_UP_THANKS"] = "感谢你选择 Thanks for the Buff (TFTB)！"

L["OPTIONS_FEEDBACK"] = "反馈与支持"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "反馈与支持链接"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "要复制链接，请点击对应的输入框，然后按 Ctrl+A 和 Ctrl+C。"
L["OPTIONS_VERSION"] = "版本 %s"

--------------------------------------------------------------------------------
-- Options: Stranger Buffs
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- Options: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers the Stranger Buffs panel is built from: what the
    other player sees, then what only you get. Key prefixes match the header
    the control appears under.
]]
L["PRAISE_HEADER"] = "感谢密语与表情"
L["NOTIFICATIONS_HEADER"] = "通知"
L["PRAISE_DESCRIPTION"] = "对方玩家看到的内容：一条感谢密语、一个表情，或两者兼有。"
L["NOTIFICATIONS_DESCRIPTION"] = "只有你会收到的内容：一条文字提示、一段音效，或两者兼有。"

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

L["NOTIFICATIONS_PRINT_ENABLE"] = "启用文字提示"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "获得增益时，显示一条只有你能看到的信息。"
L["NOTIFICATIONS_SOUND_ENABLE"] = "启用音效"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "获得增益时播放音效。只有你能听到。"
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "播放该音效，让你在开启前先试听。"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "感谢按钮"
L["BUTTON_DESCRIPTION"] = "一次按键即可对目标发送密语和表情。让礼貌自动完成。"
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "感谢按钮 %d"
L["BUTTON_EMOTE"] = "表情"
L["BUTTON_EMOTE_DESCRIPTION"] = "设置此按钮对你的目标使用的表情，选择'无'则不使用表情。"
L["BUTTON_EMOTE_NONE"] = "无"
L["BUTTON_ICON"] = "图标"
L["BUTTON_ICON_DESCRIPTION"] = "设置此按钮的宏在宏列表和动作条上显示的图标。"
-- The Icon dropdown's first choice, the macros' own icon; every other choice is a picture alone.
L["BUTTON_ICON_DEFAULT"] = "默认"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = '启用宏 "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "创建一个名为 %s 的宏，关闭此项时会将其删除。"
L["BUTTON_WHISPER_DESCRIPTION"] = "设置此按钮向你的目标发送的密语。留空则不发送密语。"

-- Each button's whisper box
L["WHISPER_MESSAGE"] = "密语信息"
L["WHISPER_MESSAGE_RESET"] = "重置"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "将密语信息恢复为默认文本。"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "谢谢，你最棒了！(="

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
