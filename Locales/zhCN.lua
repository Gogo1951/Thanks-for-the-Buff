local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "zhCN")
if not L then return end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff (TFTB)"
L["ADDON_SHORT"] = "TFTB"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] = "版本 %s。设置（包括关闭此消息的选项）可以在“选项 > 插件 > Thanks for the Buff”中找到。喜欢这个插件吗？告诉您的朋友吧！(="
L["MSG_RESET"] = "所有设置已恢复为默认值。"

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s 给您施放了 %s！"
L["MSG_GAVE_YOU"] = "%s 给了你 %s！"
L["MSG_GAVE_GROUP"] = "%s 给你的队伍提供了 %s！"
L["MSG_USED_ITEM"] = "%s 对你使用了%s的 %s！"
L["MSG_USED_SPELL"] = "%s 对你使用了 %s！"
L["MSG_SET_OUT"] = "%s 摆放了 %s！"
L["MSG_OPENED"] = "%s 开启了 %s！"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "感谢您的 %s！"
L["MSG_SELECT_PLAYER"] = "选择一位玩家来表达感谢。"
L["MSG_CANT_THANK_SELF"] = "您不能感谢自己！"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MSG_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "他"
L["PRONOUN_HER"] = "她"
L["PRONOUN_THEIR"] = "他们"
L["UNKNOWN_SPELL"] = "未知法术"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "启用欢迎信息"
L["OPTIONS_WELCOME_DESC"] = "在您登录时向聊天框发送一条信息。"
L["OPTIONS_RESET_ALL_PROFILES"] = "重置所有配置文件"
L["OPTIONS_RESET_ALL_PROFILES_DESCRIPTION"] = "将此账号上的所有配置文件恢复为默认设置。"
L["OPTIONS_RESET_ALL_PROFILES_CONFIRM"] = "这将把您账号上的所有配置文件恢复为默认设置——包括每个角色。此操作无法撤销。是否继续？"
L["OPTIONS_DESCRIPTION"] = "每当收到增益效果时，自动通过表情和消息表达感谢——无论是野外陌生人给你的增益，还是战斗中队友为你开启的大技能。"
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
L["STRANGERS_DESC"] = "来自队伍外的玩家（开放世界）给你的增益。"
L["STRANGERS_COOLDOWN"] = "冷却时间（秒）"
L["STRANGERS_COOLDOWN_DESC"] = "对同一名玩家发送表情的最高频率。\n\n消息不受此影响；它们会在每个增益触发。"
L["STRANGERS_MIN_DURATION"] = "最低增益持续时间（秒）"
L["STRANGERS_MIN_DURATION_DESC"] = "增益效果必须持续的最短时间才能触发感谢。\n\n过滤掉恢复或回春术等短时间持续治疗。"
L["STRANGERS_MESSAGING"] = "消息设置"
L["STRANGERS_EMOTES_SELECT"] = "选择表情"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

L["TEAMMATES_TITLE"] = "来自队友的增益"
L["TEAMMATES_DESC"] = "小队或团队成员对你施放的增益或冷却技能。"
L["SERVICES_TITLE"] = "队伍服务"
L["SERVICES_DESC"] = "小队或团队成员提供的全团帮助——大餐、灵魂石井、传送门、修理机器人。"
L["COMBAT_MESSAGING"] = "消息设置"
L["COMBAT_EMOTES_SELECT"] = "选择表情"
L["COMBAT_TRACKED"] = "追踪的技能："
L["COMBAT_TOGGLE_TRACKING"] = "切换对 %s 的追踪"
L["COMBAT_GROUP_ITEMS"] = "物品"
L["COMBAT_ITEM_PENDING"] = "物品 #%d"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "感谢按钮"
L["BUTTON_DESC"] = "使用表情和密语感谢你当前的目标。"
L["BUTTON_CREATE_MACRO"] = "创建宏"
L["BUTTON_CREATE_MACRO_DESC"] = "登录时将自动为您创建一个名为 %s 的宏。"
L["BUTTON_WHISPER"] = "密语信息"
L["BUTTON_RESET"] = "重置"
L["BUTTON_RESET_DESC"] = "将密语信息重置为默认文本。"
L["BUTTON_EMOTES_SELECT"] = "选择表情"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_PRINT_ENABLE"] = "启用聊天框信息（仅自己可见）"
L["MESSAGING_PRINT_DESC"] = "当收到增益时，在你的聊天框输出一条信息。只有你能看到。"
L["MESSAGING_WHISPER_ENABLE"] = "启用感谢消息"
L["MESSAGING_WHISPER_DESC"] = "向给你增益的玩家密语感谢。"
L["MESSAGING_EMOTES_ENABLE"] = "启用表情（脱战时）"
L["MESSAGING_EMOTES_DESC"] = "用表情表达你的感谢。战斗中会暂缓发送表情。"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "谢谢，你最棒了！(="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESC"] = "你向<Target>欢呼。"
L["EMOTE_DRINK_DESC"] = "你向<Target>举杯致意。"
L["EMOTE_FLEX_DESC"] = "你向<Target>展示肌肉。"
L["EMOTE_GRIN_DESC"] = "你对着<Target>坏笑。"
L["EMOTE_HIGHFIVE_DESC"] = "你与<Target>击掌。"
L["EMOTE_PRAISE_DESC"] = "你赞美了<Target>。"
L["EMOTE_SALUTE_DESC"] = "你恭敬地向<Target>致敬。"
L["EMOTE_SMILE_DESC"] = "你对<Target>微笑。"
L["EMOTE_THANK_DESC"] = "你向<Target>表示感谢。"
L["EMOTE_WHOA_DESC"] = "你看着<Target>，惊叹道“哇！”"
L["EMOTE_WINK_DESC"] = "你向<Target>眨眼。"
L["EMOTE_YES_DESC"] = "你向<Target>点头。"
