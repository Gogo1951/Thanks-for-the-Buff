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
	"版本 %s。设置（包括关闭此消息的选项）可以在 选项 > 插件 > Thanks for the Buff 中找到。喜欢这个插件吗？告诉你的朋友吧！(="

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s 给你施放了 %s！"
L["MSG_GAVE_YOU"] = "%s 给了你 %s！"
L["MSG_GAVE_GROUP"] = "%s 给你的队伍提供了 %s！"
L["MSG_USED_ITEM"] = "%s 对你使用了%s的 %s！"
L["MSG_USED_SPELL"] = "%s 对你使用了 %s！"
L["MSG_SET_OUT"] = "%s 摆放了 %s！"
L["MSG_OPENED"] = "%s 开启了 %s！"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "感谢你的 %s！"
L["MSG_GOODNEWS_DURATION"] = "好消息！你获得了%s，持续%s！"
L["MSG_GOODNEWS"] = "好消息！你获得了%s！"
L["MSG_PEER_PRESSURE"] = "%s 使用了 %s！"
L["MSG_PEER_PRESSURE_TARGET"] = "%s 使用了 %s，目标是 %s！"
L["MSG_SELECT_PLAYER"] = "选择一位玩家来表达感谢。"
L["MSG_CANT_THANK_SELF"] = "你不能感谢自己！"

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
L["OPTIONS_WELCOME_DESC"] = "在你登录时向聊天框发送一条信息。"
L["OPTIONS_DESCRIPTION"] =
	"无论是野外的陌生人，还是队友使用的技能冷却（如 Power Infusion 或 Innervate），都能通过表情、密语和聊天提示自动向为你提供增益的玩家表示感谢。还会提醒你大餐、传送门和同职业的技能冷却。"
L["OPTIONS_SUPPORT"] = "反馈与支持"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "打开 Thanks for the Buff 的选项界面。"
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "对你当前的目标发送表情和密语。"

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "来自陌生人的增益"
L["STRANGERS_DESC"] = "来自队伍外的玩家（开放世界）给你的增益。"
L["STRANGERS_COOLDOWN"] = "冷却时间（秒）"
L["STRANGERS_COOLDOWN_DESC"] =
	"对同一名玩家发送表情的最高频率。\n\n消息不受此影响；它们会在每个增益触发。"
L["STRANGERS_MIN_DURATION"] = "最低增益持续时间（秒）"
L["STRANGERS_MIN_DURATION_DESC"] =
	"增益效果必须持续的最短时间才能触发感谢。\n\n过滤掉恢复或回春术等短时间持续治疗。"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "来自队友的增益"
L["TEAMMATES_DESC"] = "小队或团队成员对你施放的增益或冷却技能。"

-- Group Services
L["TAB_SERVICES"] = "队伍服务"
L["SERVICES_DESC"] =
	"小队或团队成员提供的全团帮助：大餐、灵魂石井、传送门、修理机器人。"

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "好消息"
L["GOOD_NEWS_DESC"] = "自动密语你增益的玩家，告知你为其施放的战斗增益。"
L["GOOD_NEWS_WHISPER_ENABLE"] = "启用好消息"
L["GOOD_NEWS_WHISPER_DESC"] = "密语你增益的玩家，告诉他们获得了什么增益以及持续时间。"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "你增益的任何人"
L["GOOD_NEWS_SCOPE_GROUP"] = "仅小队或团队成员"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Peer Pressure"
L["PEER_PRESSURE_DESC"] =
	"当你的同职业玩家使用技能冷却时收到通知，让你也屈服于 Peer Pressure。"
L["PEER_PRESSURE_ENABLE"] = "启用 Peer Pressure"
L["PEER_PRESSURE_PRINT_DESC"] =
	"当同职业技能被使用时，在你的聊天框输出一条信息。只有你能看到。"
L["PEER_PRESSURE_OWN_CASTS"] = "自己施放时也触发"
L["PEER_PRESSURE_OWN_CASTS_DESC"] = "当你自己使用技能冷却时也触发提醒，而不仅限于其他玩家。"
L["PEER_PRESSURE_SOUND_DESC"] = "当同职业技能被使用时播放音效。只有你能听到。"

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "追踪的技能"
L["COMBAT_GROUP_ITEMS"] = "物品"
L["COMBAT_TOGGLE_TRACKING"] = "切换对 %s 的追踪"
L["COMBAT_ITEM_PENDING"] = "物品 #%d"
L["COMBAT_SPELL_PENDING"] = "法术 #%d"

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

-- Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
-- spells and items take their names from the client and need no key here.
L["GROUP_PORTALS"] = "传送门"
L["GROUP_SOULSTONE"] = "灵魂石"
L["GROUP_RESISTANCE_CAULDRONS"] = "抗性大锅"
L["GROUP_SCROLL_OF_SPIRIT"] = "精神卷轴"
L["GROUP_SCROLL_OF_STAMINA"] = "耐力卷轴"
L["GROUP_SCROLL_OF_STRENGTH"] = "力量卷轴"
L["GROUP_SCROLL_OF_PROTECTION"] = "保护卷轴"
L["GROUP_SCROLL_OF_INTELLECT"] = "智力卷轴"
L["GROUP_SCROLL_OF_AGILITY"] = "敏捷卷轴"
L["GROUP_REPAIR_BOTS"] = "修理机器人"
L["GROUP_JUMPER_CABLES"] = "跨接电缆"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "感谢按钮"
L["BUTTON_DESC"] = "使用表情和密语感谢你当前的目标。"
L["BUTTON_CREATE_MACRO"] = "创建宏"
L["BUTTON_CREATE_MACRO_DESC"] = "登录时自动为你创建一个名为 %s 的宏。"
L["BUTTON_WHISPER"] = "密语信息"
L["BUTTON_RESET"] = "重置"
L["BUTTON_RESET_DESC"] = "将密语信息重置为默认文本。"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_HEADER"] = "消息设置"
L["MESSAGING_PRINT_ENABLE"] = "启用聊天框信息（仅自己可见）"
L["MESSAGING_PRINT_DESC"] = "当收到增益时，在你的聊天框输出一条信息。只有你能看到。"
L["MESSAGING_WHISPER_ENABLE"] = "启用感谢消息"
L["MESSAGING_WHISPER_DESC"] = "向给你增益的玩家密语感谢。"
L["MESSAGING_EMOTES_ENABLE"] = "启用表情（脱战时）"
L["MESSAGING_EMOTES_DESC"] = "用表情表达你的感谢。战斗中会暂缓发送表情。"
L["MESSAGING_EMOTES_SELECT"] = "选择表情"
L["MESSAGING_SOUND_ENABLE"] = "启用音效"
L["MESSAGING_SOUND_DESC"] = "当收到增益时播放音效。只有你能听到。"

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
L["EMOTE_WHOA_DESC"] = "你看着<Target>，惊叹道'哇！'"
L["EMOTE_WINK_DESC"] = "你向<Target>眨眼。"
L["EMOTE_YES_DESC"] = "你向<Target>点头。"
