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

-- Thank You Button
L["MESSAGE_SELECT_PLAYER"] = "请先以一名玩家为目标。"
L["MESSAGE_CANT_THANK_SELF"] = "你不能感谢自己！"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "未知法术"
L["SAMPLE_EXAMPLE"] = "示例：%s"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "启用欢迎消息"
L["OPTIONS_WELCOME_DESCRIPTION"] = "登录时显示一条只有你能看到的消息。"
L["OPTIONS_DESCRIPTION"] =
	"自动用表情或密语感谢为你施加增益的玩家，告诉玩家你刚刚对他们施放了什么，路过好友和公会成员时向他们挥手问候，点一下感谢宏就能感谢你选中的任何人。"
L["OPTIONS_FEATURES_HEADER"] = "功能"
L["OPTIONS_FEATURES_DESCRIPTION"] = "在此处或各功能自己的面板中开启或关闭每项功能。"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "打开此插件的选项界面。"

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
-- Options: Give Thanks
--------------------------------------------------------------------------------

L["TAB_GIVE_THANKS"] = "致谢"
L["GIVE_THANKS_ENABLE"] = "启用致谢"
L["GIVE_THANKS_ENABLE_DESCRIPTION"] = "开启对队伍外玩家所施增益的感谢。"
L["GIVE_THANKS_DESCRIPTION"] = "在开放世界中，感谢队伍外的玩家为你施放的增益。"

-- Praise Limits
L["PRAISE_HEADER"] = "感谢限制"
L["PRAISE_DESCRIPTION"] = "这些设置会同时限制表情和密语，即使增益接踵而至也不会刷屏。"
-- The dropdown values carry the unit, so these labels do not repeat it.
L["GIVE_THANKS_OVERALL_COOLDOWN"] = "感谢冷却时间"
L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"设置两轮感谢之间的间隔，无论增益来自谁。设为零则对每个增益都表示感谢。"
L["GIVE_THANKS_SOURCE_COOLDOWN"] = "同一玩家感谢冷却时间"
L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"设置对同一名玩家两次感谢之间的间隔。设为零则对每个增益都表示感谢。"
L["GIVE_THANKS_MIN_DURATION"] = "最短增益持续时间"
L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"] =
	"忽略持续时间短于此值的增益。设为零则对每个增益都作出反应。"
L["PRAISE_DELAY_ENABLE"] = "启用感谢延迟"
L["PRAISE_DELAY_DESCRIPTION"] =
	"在发送密语和表情前稍作等待，避免你的感谢与增益在同一瞬间出现。通知不受影响。"
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "设置发送密语和表情前的等待时长。"

-- Give Thanks Whisper
L["GIVE_THANKS_WHISPER_HEADER"] = "致谢密语"
L["GIVE_THANKS_WHISPER_ENABLE"] = "启用致谢密语"
L["PRAISE_WHISPER_DESCRIPTION"] = "向为你施加增益的玩家密语致谢。"
-- TRANSLATORS: keep {spell} and {name} exactly as written; they are the tokens players type into the whisper.
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"设置 TFTB 向为你施加增益的玩家发送的密语。{spell} 会替换为该增益，{name} 会替换为该玩家的名字。留空则不发送密语。"

-- Notifications
L["NOTIFICATIONS_HEADER"] = "通知"
L["NOTIFICATIONS_DESCRIPTION"] = "只有你会收到的内容：一条文字提示、一段音效，或两者兼有。"
L["NOTIFICATIONS_PRINT_ENABLE"] = "启用文字提示"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "获得增益时，显示一条只有你能看到的消息。"
L["NOTIFICATIONS_SOUND_ENABLE"] = "启用音效"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "获得增益时播放音效。只有你能听到。"
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "播放该音效，让你在开启前先试听。"

--------------------------------------------------------------------------------
-- Options: Good News
--------------------------------------------------------------------------------

L["TAB_GOOD_NEWS"] = "好消息"
L["GOOD_NEWS_ENABLE"] = "启用好消息"
L["GOOD_NEWS_ENABLE_DESCRIPTION"] = "开启一条密语，告诉玩家你刚刚对他们施放了什么。"
L["GOOD_NEWS_DESCRIPTION"] =
	"告诉玩家你刚刚对他们施放了什么，短时增益还会告知持续多久，让他们充分利用。"
L["GOOD_NEWS_SCOPE"] = "接收者"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"设置谁会收到好消息密语：你对其施放追踪技能的任何人，或仅限你的小队或团队。"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "任何人"
L["GOOD_NEWS_SCOPE_GROUP"] = "仅小队或团队成员"
L["GOOD_NEWS_WHISPER_HEADER"] = "好消息密语"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"你的施放对象收到的内容。只有在追踪的技能中勾选的技能才会发送密语。"
-- TRANSLATORS: keep {spell} and {name} exactly as written; they are the tokens players type into the whisper.
L["GOOD_NEWS_MESSAGE_DESCRIPTION"] =
	"设置 TFTB 向你的施放对象发送的密语。{spell} 会替换为你施放的内容，持续时间不足一分钟时还会附上持续时间，{name} 会替换为该玩家的名字。留空则不发送密语。"
-- TRANSLATORS: each %s is a token, {spell} then {name}, drawn in blue.
L["GOOD_NEWS_TOKENS"] = "占位符：%s 你施放的内容，%s 接收者"

-- Tracked Abilities
L["TAB_GOOD_NEWS_ABILITIES"] = "追踪的技能"
L["GOOD_NEWS_ABILITIES_DESCRIPTION"] =
	"当你对其他玩家施放此处勾选的技能时，好消息会发送密语告知。"
-- The heading over the rows no class owns: scrolls, and abilities cast by a trinket's pet.
L["GOOD_NEWS_ITEMS"] = "物品"

--------------------------------------------------------------------------------
-- Options: Emotes List
--------------------------------------------------------------------------------

L["TAB_EMOTES_LIST"] = "表情列表"
L["EMOTES_GRID_DESCRIPTION"] =
	"勾选队伍外玩家为你施加增益时致谢功能可以使用的表情，它会随机选用一个。战斗中、施法或钓鱼时会暂缓发送表情。"

--[[
    The emote checklist, shared by this panel and Wave to Friends' Friends and
    Guilds tabs. Its group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS
    entry, upper-cased.
]]
L["EMOTE_GROUP_COUNT"] = "%s（已勾选 %d/%d）"
L["EMOTE_GROUP_TEXT"] = "文字"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "只显示表情文字。"
L["EMOTE_GROUP_GESTURE"] = "动作"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "播放一个简短动作。"
L["EMOTE_GROUP_VOICE"] = "语音"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "播放一句语音。"
L["EMOTE_GROUP_POSE"] = "姿态"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "持续到你移动为止。"
L["EMOTES_RESET"] = "重置表情"
L["EMOTES_RESET_DESCRIPTION"] = "将列表恢复为默认的感谢表情。"
L["EMOTES_RESET_CONFIRM"] = "将表情列表重置为默认值？"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "忽略的增益"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"此列表中的增益无论由谁施放，都不会发送感谢。你仍会收到文字提示和音效。"
L["IGNORED_BUFFS_ADD_RECENT"] = "忽略近期增益"
L["IGNORED_BUFFS_ADD_RECENT_DESCRIPTION"] =
	"添加你身上当前的一个增益，或你登录后其他玩家给你的一个增益。"
-- The first %s is the buff's icon and name, the second the player who cast it.
L["IGNORED_BUFFS_RECENT_FROM"] = "%s，来自 %s"
L["IGNORED_BUFFS_ADD"] = "添加增益"
L["IGNORED_BUFFS_ADD_DESCRIPTION"] =
	"输入法术 ID，或按住 Shift 点击增益链接将其放入输入框，然后按回车键。"
L["IGNORED_BUFFS_EMPTY"] = "尚未忽略任何增益。请在上方添加。"
L["IGNORED_BUFFS_REMOVE"] = "从列表中移除此增益。"
L["IGNORED_BUFFS_NOT_FOUND"] = "未找到与 %s 对应的增益。"
L["IGNORED_BUFFS_ALL_CHARACTERS"] = "所有角色"
L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"] =
	"将此增益移到'所有角色'列表，这样任何角色都不会为它发送感谢。"

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
-- Titles Thank You Button 1's emote checklist.
L["EMOTES_SELECT"] = "选择表情"
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

--------------------------------------------------------------------------------
-- Options: Wave to Friends
--------------------------------------------------------------------------------

L["TAB_WAVE_TO_FRIENDS"] = "好友问候"
L["WAVE_ENABLE"] = "启用好友问候"
L["WAVE_ENABLE_DESCRIPTION"] = "鼠标指向好友和公会成员时，对其使用表情。"
L["WAVE_DESCRIPTION"] = "在野外鼠标指向好友和公会成员时，用表情向他们问候。"
L["WAVE_RULES"] = "不会对你的小队或团队成员使用，战斗中、施法或钓鱼时也不会使用。"
L["WAVE_RESTING_ENABLE"] = "仅在休息时"
L["WAVE_RESTING_ENABLE_DESCRIPTION"] = "仅在你于城镇或旅店中休息时挥手。"
L["WAVE_COOLDOWN"] = "同一玩家冷却时间"
L["WAVE_COOLDOWN_DESCRIPTION"] = "设置同一名玩家要隔多久才能再次被问候。"
L["WAVE_COOLDOWN_ONCE_PER_SESSION"] = "每次登录一次"
-- %s is the default emotes' slash commands, as the client names them.
L["WAVE_EMOTES_RESET_DEFAULTS_DESCRIPTION"] = "将列表恢复为只勾选 %s。"

-- Custom List
L["WAVE_TAB_CUSTOM"] = "自定义列表"
L["WAVE_CUSTOM_DESCRIPTION"] =
	"这些玩家总是获得专属表情，优先于好友和公会。选择'无'则永远不对此人使用表情。"
-- One of these two follows WAVE_CUSTOM_DESCRIPTION: realm clients, then WoW Forever, which has no realms.
L["WAVE_CUSTOM_NAMES_REALM"] = "角色名-服务器只匹配该服务器；只写角色名则匹配所有服务器。"
L["WAVE_CUSTOM_NAMES_FOREVER"] =
	"完整姓名只匹配一个角色；只写名而不写姓，则匹配所有同名角色。"
L["WAVE_CUSTOM_ENABLE"] = "启用自定义列表"
L["WAVE_CUSTOM_ENABLE_DESCRIPTION"] = "优先于好友和公会使用下方的名字。"
L["WAVE_CUSTOM_OFF_WARNING"] = "自定义列表已关闭，因此下方的任何人都不会获得其表情。"
L["WAVE_CUSTOM_ADD"] = "添加玩家"
L["WAVE_CUSTOM_ADD_DESCRIPTION"] =
	"输入角色名或角色名-服务器，然后按回车键。多个名字用逗号分隔。"
L["WAVE_CUSTOM_ADD_DESCRIPTION_FOREVER"] =
	"输入完整姓名或只输入名，然后按回车键。多个名字用逗号分隔。"
L["WAVE_CUSTOM_EMPTY"] = "尚无玩家。请在上方添加。"
L["WAVE_CUSTOM_EMOTE_DESCRIPTION"] = "设置对此玩家使用的表情，选择'无'则永远不对其使用表情。"
L["WAVE_CUSTOM_REMOVE"] = "从列表中移除此玩家。"

-- Friends
L["WAVE_TAB_FRIENDS"] = "好友"
L["WAVE_FRIENDS_ENABLE"] = "向好友挥手"
L["WAVE_FRIENDS_ENABLE_DESCRIPTION"] = "问候你好友列表中的角色。"
L["WAVE_BNET_ENABLE"] = "包括战网好友"
L["WAVE_BNET_ENABLE_DESCRIPTION"] = "也问候你的战网好友正在玩的角色。"
L["WAVE_FRIENDS_EMOTES_DESCRIPTION"] = "勾选对好友可用的表情，每次随机选用一个。"

-- Guilds
L["WAVE_TAB_GUILDS"] = "公会"
L["WAVE_MY_GUILD_ENABLE"] = "向我的公会挥手"
L["WAVE_MY_GUILD_ENABLE_DESCRIPTION"] = "问候你所在公会的成员。"
L["WAVE_GUILD_ADD"] = "添加公会"
L["WAVE_GUILD_ADD_DESCRIPTION"] =
	"输入公会名称，然后按回车键。多个公会用逗号分隔。不区分大小写。"
L["WAVE_GUILDS_EMPTY"] = "尚无其他公会。请在上方添加。"
L["WAVE_GUILD_REMOVE"] = "从列表中移除此公会。"
L["WAVE_GUILDS_EMOTES_DESCRIPTION"] = "勾选对公会成员可用的表情，每次随机选用一个。"

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks, Good News and each Thank You Button.
L["WHISPER_MESSAGE"] = "密语消息"
L["WHISPER_MESSAGE_RESET"] = "重置"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "将密语消息恢复为默认文本。"

-- The whisper composer around every editable whisper's box, on Give Thanks and Good News.
L["SEND_MESSAGES_IN"] = "消息语言"
L["SEND_MESSAGES_IN_DESCRIPTION"] =
	"设置 TFTB 向其他玩家发送消息时使用的语言。切换语言时，如果你没有自己写过，会换成该语言的默认文本。"
L["WHISPER_SIGN_OFF_DESCRIPTION"] =
	"TFTB 发送的每条消息都会带上它，让其他玩家知道这是插件发送的。"
-- TRANSLATORS: each %s is a token, {spell} then {name}, drawn in blue.
L["WHISPER_TOKENS"] = "占位符：%s 增益，%s 施法者"
L["WHISPER_TOO_LONG"] = "太长了，因此会改为发送默认文本。"
L["WHISPER_TEST"] = "发送测试给我"
L["WHISPER_TEST_DESCRIPTION"] = "把示例密语发给你自己，让你看到和其他玩家完全一样的效果。"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

-- The Thank You Button whisper's default, in the client's own language; Give Thanks' and Good News' defaults live in Data/Message-Languages.lua.
L["DEFAULT_WHISPER"] = "谢谢，你最棒了！(="
