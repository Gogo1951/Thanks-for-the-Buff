local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "zhCN")
if not L then return end

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["MSG_ENABLED"] = "已启用。使用 /tftb 来调整您的设置，包括关闭此消息。(="
L["MSG_DB_ERROR"] = "错误：未能加载数据库默认值。请通过 /tftb 重置您的配置文件。"
L["MSG_RESET"] = "所有设置已恢复为默认值。"
L["MSG_BUFFED"] = "%s 给您施放了 %s！"
L["MSG_HIT"] = "%s 用 %s 命中了您！"
L["MSG_PARTY_ITEM"] = "%s 为您的队伍使用了 %s！"
L["MSG_WHISPER_THANKS"] = "感谢您的 %s！"
L["MSG_SELECT_PLAYER"] = "选择一位玩家来表达感谢。"
L["MSG_CANT_THANK_SELF"] = "您不能感谢自己！"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_TITLE"] = "Thanks for the Buff!"
L["OPTIONS_GENERAL"] = "常规设置"
L["OPTIONS_WELCOME_TOGGLE"] = "启用欢迎信息"
L["OPTIONS_WELCOME_DESC"] = "在您登录时向聊天框发送一条信息。"
L["OPTIONS_RESET"] = "重置"
L["OPTIONS_RESET_ALL"] = "重置所有设置"
L["OPTIONS_RESET_ALL_DESC"] = "将每个选项恢复为其默认值。"
L["OPTIONS_RESET_CONFIRM"] = "您确定要将所有设置重置为默认值吗？"
L["OPTIONS_DESCRIPTION"] = "每当收到新的增益效果时，自动使用表情来表达开心。"
L["OPTIONS_SUPPORT"] = "反馈与支持"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "打开 Thanks for the Buff 的选项界面。"
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "对您的目标玩家发送表情和密语。"

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "来自陌生人的增益"
L["STRANGERS_ENABLE"] = "对陌生人的增益做出反应"
L["STRANGERS_COOLDOWN"] = "冷却时间（秒）"
L["STRANGERS_COOLDOWN_DESC"] = "对同一名玩家表达感谢的最高频率。"
L["STRANGERS_MIN_DURATION"] = "最低增益持续时间（秒）"
L["STRANGERS_MIN_DURATION_DESC"] = "增益效果必须持续的最短时间才能触发感谢。\n\n过滤掉恢复或回春术等短时间持续治疗。"
L["STRANGERS_MESSAGING"] = "消息设置"
L["STRANGERS_EMOTES_ENABLE"] = "启用表情"
L["STRANGERS_EMOTES_DESC"] = "对陌生人提供的增益表示感谢。"
L["STRANGERS_EMOTES_SELECT"] = "选择表情"

--------------------------------------------------------------------------------
-- Options: Combat Buffs
--------------------------------------------------------------------------------

L["COMBAT_TITLE"] = "战斗增益"
L["COMBAT_MESSAGING"] = "消息设置"
L["COMBAT_TRACKED"] = "追踪的技能："
L["COMBAT_TOGGLE_TRACKING"] = "切换对 %s 的追踪"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "感谢按钮"
L["BUTTON_CREATE_MACRO"] = "创建宏"
L["BUTTON_CREATE_MACRO_DESC"] = "登录时将自动为您创建一个名为 %s 的宏。"
L["BUTTON_WHISPER"] = "密语信息"
L["BUTTON_RESET"] = "重置"
L["BUTTON_RESET_DESC"] = "将密语信息重置为默认文本。"
L["BUTTON_EMOTES_HEADER"] = "感谢按钮表情："
L["BUTTON_EMOTES_SELECT"] = "选择表情"

--------------------------------------------------------------------------------
-- Shared: Messaging Dropdown
--------------------------------------------------------------------------------

L["MESSAGING_NONE"] = "无信息"
L["MESSAGING_NONE_DEFAULT"] = "无信息（默认）"
L["MESSAGING_PRINT"] = "聊天框信息（仅自己可见）"
L["MESSAGING_WHISPER"] = "密语信息"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "谢谢，你最棒了！(="