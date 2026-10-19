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
-- Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"版本 %s。设置（包括关闭此消息的选项）位于 选项 > 插件 > Thanks for the Buff (TFTB)。喜欢这个插件吗？告诉你的朋友，在 CurseForge 上收藏它，或在 GitHub 上点个 Star。(="
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
L["MESSAGE_SELECT_PLAYER"] = "请先以一名玩家为目标。"
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
L["OPTIONS_WELCOME_DESCRIPTION"] = "登录时显示一条只有你能看到的信息。"
L["OPTIONS_DESCRIPTION"] =
	"通过密语或表情感谢每一位为你施加增益的玩家，并用一键施放的增益追踪器查看谁缺少你的团队增益。还会提醒你大餐、传送门、召唤、灵魂之井和同职业的冷却技能。礼数周到，全自动。"
L["OPTIONS_FEATURES_HEADER"] = "功能"
L["OPTIONS_FEATURES_DESCRIPTION"] = "在此处或各功能自己的面板中开启或关闭每项功能。"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "打开此插件的选项界面。"
L["OPTIONS_EXAMPLE"] = "示例：%s"

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
	"有人为你的队伍摆出帮助时作出反应：大餐、灵魂之井、传送门和修理机器人。"

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
	"设置谁会收到好消息密语：任何被你增益的人，或仅限你的队伍成员。"
L["GOOD_NEWS_MESSAGES_HEADER"] = "好消息信息"
L["GOOD_NEWS_MESSAGES_DESCRIPTION"] = "被你增益的玩家会收到的密语。"
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
	"有同职业冷却技能被使用时，显示一条只有你能看到的信息。"
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
-- Options: Buff Duty
--------------------------------------------------------------------------------

L["TAB_BUFF_WINDOW"] = "增益值班"
L["BUFF_WINDOW_DESCRIPTION"] = "显示谁缺少你的增益。点击图标即可施放。"
L["BUFF_WINDOW_ENABLE"] = "启用增益值班"
L["BUFF_WINDOW_ENABLE_DESCRIPTION"] =
	"开启增益值班，即列出缺少你可施放增益的队伍成员的窗口。"
L["BUFF_WINDOW_NO_BUFFS"] =
	"你的职业没有此列表中的增益，因此该窗口在这个角色上永远不会出现。"
L["BUFF_WINDOW_HEADER"] = "窗口"
L["BUFF_WINDOW_WINDOW_DESCRIPTION"] = "让窗口留在你放置的位置，或在战斗中不挡视线。"
L["BUFF_WINDOW_LOCK"] = "锁定窗口"
L["BUFF_WINDOW_LOCK_DESCRIPTION"] = "使窗口无法移动。解锁后，可拖动其背景来移动窗口。"
L["BUFF_WINDOW_HIDE_IN_COMBAT"] = "战斗中隐藏"
L["BUFF_WINDOW_HIDE_IN_COMBAT_DESCRIPTION"] =
	"在战斗中隐藏窗口。战斗中列表无法更新，因此保持显示的窗口会停留在最后的状态，直到战斗结束。"
L["BUFF_WINDOW_SHOW_HEADER"] = "在窗口中显示"
L["BUFF_WINDOW_SHOW_DESCRIPTION"] =
	"将你自己的增益、为你施放增益的陌生人以及你的目标加入窗口。"
L["BUFF_WINDOW_FAVOR_ENABLE"] = "礼尚往来"
L["BUFF_WINDOW_FAVOR_ENABLE_DESCRIPTION"] =
	"列出最近为你施放增益的陌生人，以及你可以回赠他们的增益。右键点击图标可将某人从列表中移除。"
L["BUFF_WINDOW_FAVOR_SECONDS_DESCRIPTION"] =
	"设置陌生人在最后一次施放增益后保留在列表中的时间。"
L["BUFF_WINDOW_TARGET_ENABLE"] = "你的目标"
L["BUFF_WINDOW_TARGET_ENABLE_DESCRIPTION"] =
	"当你的目标是缺少你可施放增益的队伍外玩家时，将其列出。"
L["BUFF_WINDOW_REFRESH"] = "剩余低于此值时补充"
L["BUFF_WINDOW_REFRESH_DESCRIPTION"] =
	"设置增益剩余时间低于多少时视为缺失，方便你在增益消失前及时补上。持续时间不超过此值的增益，只有在消失后才会视为缺失。"
L["BUFF_WINDOW_PETS_AS_TANKS"] = "将宠物视为坦克"
L["BUFF_WINDOW_PETS_AS_TANKS_DESCRIPTION"] =
	"除了设为所有人的增益外，也为宠物提供设为坦克的增益，例如荆棘术。"
L["BUFF_WINDOW_PETS_AS_TANKS_WHEN_DESCRIPTION"] = "设置宠物何时视为坦克。"
L["BUFF_WINDOW_PETS_AS_TANKS_SOLO"] = "不在队伍中时"
L["BUFF_WINDOW_PETS_AS_TANKS_ALWAYS"] = "总是"
-- Who each buff is offered to: one dropdown per buff, these four choices.
L["BUFF_WINDOW_AUDIENCE_OFF"] = "关闭"
L["BUFF_WINDOW_AUDIENCE_TANK"] = "坦克"
L["BUFF_WINDOW_AUDIENCE_HEALER"] = "治疗"
L["BUFF_WINDOW_AUDIENCE_ALL"] = "所有人"
-- The dropdown's tooltip when the client has no description for the spell yet.
L["BUFF_WINDOW_AUDIENCE_DESCRIPTION"] = "设置 %s 提供给谁。"
L["BUFF_WINDOW_BUFFS_DESCRIPTION"] =
	"选择每个增益提供给谁。坦克和治疗按队伍职责判定，未设置职责时按职业判定。"

L["BUFF_WINDOW_SELF_DESCRIPTION"] = "你自己的增益，固定在窗口顶部。"
--[[
    Muted note after a class name on the Self-Buffs panel, for a family of self
    buffs only one of which can be up at a time. Keyed by the family.
]]
L["BUFF_WINDOW_SELF_NOTE_ASPECT"] = "任意一种守护即可"
L["BUFF_WINDOW_SELF_NOTE_MAGE_ARMOR"] = "任意一种护甲即可"
L["BUFF_WINDOW_SELF_NOTE_PALADIN_AURA"] = "任意一种光环即可"
L["BUFF_WINDOW_SELF_NOTE_SHAMAN_SHIELD"] = "任意一种护盾即可"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_ARMOR"] = "任意一种护甲即可"
L["BUFF_WINDOW_SELF_REFRESH_OFF"] = "关闭"
L["BUFF_WINDOW_SELF_REFRESH_MISSING"] = "缺失时"
-- %s is a duration from the client, like "5 Minutes".
L["BUFF_WINDOW_SELF_REFRESH_UNDER"] = "剩余不足%s"
L["BUFF_WINDOW_SELF_REFRESH_DESCRIPTION"] =
	"设置 %s 何时显示：从不、消失后，或剩余时间少于此值时。"
L["BUFF_WINDOW_SELF_ENABLE"] = "你的自身增益"
L["BUFF_WINDOW_SELF_ENABLE_DESCRIPTION"] =
	"当只能对自己施放的增益（例如护甲类法术或心灵之火）缺失或即将结束时，将其显示在窗口顶部。可在自身增益中选择要显示哪些。"

-- The window itself
L["BUFF_WINDOW_SELF_HEADER"] = "自身增益"
L["BUFF_WINDOW_FAVOR_HEADER"] = "礼尚往来"
L["BUFF_WINDOW_TARGET_HEADER"] = "目标"
L["BUFF_WINDOW_TOOLTIP_CAST"] = "点击对 %s 施放。"
L["BUFF_WINDOW_TOOLTIP_GROUP"] = "点击对 %s 及其小队施放。"
L["BUFF_WINDOW_TOOLTIP_FAVOR"] = "点击选中 %s 为目标并施放。"
L["BUFF_WINDOW_TOOLTIP_DISMISS"] = "右键点击将 %s 从列表中移除。"

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
