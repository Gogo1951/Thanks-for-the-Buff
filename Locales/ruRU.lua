local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "ruRU")
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
	"Версия %s. Настройки (включая возможность отключить это сообщение) находятся в меню Настройки > Модификации > Thanks for the Buff. Нравится аддон? Расскажите о нем друзьям! (="

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s накладывает на вас %s!"
L["MSG_GAVE_YOU"] = "%s передает вам %s!"
L["MSG_GAVE_GROUP"] = "%s передает вашей группе %s!"
L["MSG_USED_ITEM"] = "%s использует %s %s на вас!"
L["MSG_USED_SPELL"] = "%s применяет %s на вас!"
L["MSG_SET_OUT"] = "%s ставит %s!"
L["MSG_OPENED"] = "%s открывает %s!"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "Спасибо за %s!"
L["MSG_GOODNEWS_DURATION"] = "Хорошие новости! У вас %s на %s!"
L["MSG_GOODNEWS"] = "Хорошие новости! У вас %s!"
L["MSG_PEER_PRESSURE"] = "%s применяет %s!"
L["MSG_PEER_PRESSURE_TARGET"] = "%s применяет %s к %s!"
L["MSG_SELECT_PLAYER"] = "Выберите игрока для благодарности."
L["MSG_CANT_THANK_SELF"] = "Вы не можете благодарить себя!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MSG_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "его"
L["PRONOUN_HER"] = "ее"
L["PRONOUN_THEIR"] = "их"
L["UNKNOWN_SPELL"] = "Неизвестное заклинание"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Включить приветственное сообщение"
L["OPTIONS_WELCOME_DESC"] = "Выводит сообщение в чат при входе в игру."
L["OPTIONS_DESCRIPTION"] =
	"Автоматически благодарите игроков, которые вас баффают, с помощью эмоций, личных сообщений и уведомлений в чате, будь то незнакомец в открытом мире или способность товарища по команде вроде Power Infusion или Innervate. Получайте уведомления о пиршествах, порталах и способностях вашего класса."
L["OPTIONS_SUPPORT"] = "Отзывы и поддержка"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Открывает настройки Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] =
	"Применяет эмоцию и отправляет личное сообщение вашей текущей цели."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Баффы от незнакомцев"
L["STRANGERS_DESC"] =
	"Бафф на вас от игрока вне вашей группы (в открытом мире)."
L["STRANGERS_COOLDOWN"] = "Время восстановления (в секундах)"
L["STRANGERS_COOLDOWN_DESC"] =
	"Как часто отправлять эмоцию одному и тому же игроку.\n\nНе влияет на сообщения; они отправляются при каждом баффе."
L["STRANGERS_MIN_DURATION"] = "Минимальная длительность баффа (в секундах)"
L["STRANGERS_MIN_DURATION_DESC"] =
	"Минимальное время, в течение которого должен действовать бафф, чтобы вызвать благодарность.\n\nИгнорирует короткие исцеления, такие как Обновление или Омоложение."

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Баффы от товарищей по команде"
L["TEAMMATES_DESC"] =
	"Бафф или способность с временем восстановления, примененная к вам членом группы или рейда."

-- Group Services
L["TAB_SERVICES"] = "Групповые услуги"
L["SERVICES_DESC"] =
	"Помощь для всего рейда от члена группы или рейда: пиршества, колодцы душ, порталы, ремонтные боты."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Хорошие новости"
L["GOOD_NEWS_DESC"] =
	"Автоматически отправляет игрокам, которых вы баффнули, личное сообщение о наложенных вами боевых баффах."
L["GOOD_NEWS_WHISPER_ENABLE"] = 'Включить "Хорошие новости"'
L["GOOD_NEWS_WHISPER_DESC"] =
	"Отправлять игроку, которого вы усилили, личное сообщение о том, что он получил и на какое время."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Любой, кого вы баффнули"
L["GOOD_NEWS_SCOPE_GROUP"] = "Только участники группы"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Peer Pressure"
L["PEER_PRESSURE_DESC"] =
	"Получайте уведомления, когда другие игроки вашего класса используют свои способности, чтобы поддаться Peer Pressure."
L["PEER_PRESSURE_ENABLE"] = "Включить Peer Pressure"
L["PEER_PRESSURE_PRINT_DESC"] =
	"Выводить сообщение в ваш собственный чат, когда используется способность вашего класса. Видите только вы."
L["PEER_PRESSURE_OWN_CASTS"] = "Срабатывать на свои заклинания"
L["PEER_PRESSURE_OWN_CASTS_DESC"] =
	"Уведомление срабатывает и тогда, когда способность используете вы сами, а не только другие игроки."
L["PEER_PRESSURE_SOUND_DESC"] =
	"Проигрывать звук, когда используется способность вашего класса. Слышите только вы."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Отслеживаемые способности"
L["COMBAT_GROUP_ITEMS"] = "Предметы"
L["COMBAT_TOGGLE_TRACKING"] = "Включить/выключить отслеживание для %s"
L["COMBAT_ITEM_PENDING"] = "Предмет #%d"
L["COMBAT_SPELL_PENDING"] = "Заклинание #%d"

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

-- Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
-- spells and items take their names from the client and need no key here.
L["GROUP_PORTALS"] = "Порталы"
L["GROUP_SOULSTONE"] = "Камень души"
L["GROUP_RESISTANCE_CAULDRONS"] = "Котлы сопротивления"
L["GROUP_SCROLL_OF_SPIRIT"] = "Свиток духа"
L["GROUP_SCROLL_OF_STAMINA"] = "Свиток выносливости"
L["GROUP_SCROLL_OF_STRENGTH"] = "Свиток силы"
L["GROUP_SCROLL_OF_PROTECTION"] = "Свиток защиты"
L["GROUP_SCROLL_OF_INTELLECT"] = "Свиток интеллекта"
L["GROUP_SCROLL_OF_AGILITY"] = "Свиток ловкости"
L["GROUP_REPAIR_BOTS"] = "Ремонтные боты"
L["GROUP_JUMPER_CABLES"] = "Стартеры"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Кнопка благодарности"
L["BUTTON_DESC"] =
	"Поблагодарите вашу текущую цель эмоцией и личным сообщением."
L["BUTTON_CREATE_MACRO"] = "Создать макрос"
L["BUTTON_CREATE_MACRO_DESC"] =
	"При входе в игру автоматически создает макрос с именем %s."
L["BUTTON_WHISPER"] = "Личное сообщение"
L["BUTTON_RESET"] = "Сброс"
L["BUTTON_RESET_DESC"] =
	"Сбрасывает текст личного сообщения к стандартному."

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_HEADER"] = "Сообщения"
L["MESSAGING_PRINT_ENABLE"] = "Включить сообщения в чате (Только для себя)"
L["MESSAGING_PRINT_DESC"] =
	"Выводить сообщение в ваш собственный чат при получении баффа. Видите только вы."
L["MESSAGING_WHISPER_ENABLE"] = "Включить сообщения с благодарностью"
L["MESSAGING_WHISPER_DESC"] =
	"Отправлять личное сообщение с благодарностью игроку, давшему бафф."
L["MESSAGING_EMOTES_ENABLE"] = "Включить эмоции (вне боя)"
L["MESSAGING_EMOTES_DESC"] =
	"Выражайте благодарность эмоцией. В бою эмоции задерживаются."
L["MESSAGING_EMOTES_SELECT"] = "Выбрать эмоции"
L["MESSAGING_SOUND_ENABLE"] = "Включить звуковой эффект"
L["MESSAGING_SOUND_DESC"] =
	"Проигрывать звук при получении баффа. Слышите только вы."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Спасибо, ты лучший! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESC"] = "Вы приветствуете <Target>."
L["EMOTE_DRINK_DESC"] = "Вы поднимаете бокал за <Target>."
L["EMOTE_FLEX_DESC"] = "Вы играете мускулами перед <Target>."
L["EMOTE_GRIN_DESC"] = "Вы злорадно ухмыляетесь, глядя на <Target>."
L["EMOTE_HIGHFIVE_DESC"] = "Вы даете пять <Target>."
L["EMOTE_PRAISE_DESC"] = "Вы восхваляете <Target>."
L["EMOTE_SALUTE_DESC"] = "Вы с уважением отдаете честь <Target>."
L["EMOTE_SMILE_DESC"] = "Вы улыбаетесь <Target>."
L["EMOTE_THANK_DESC"] = "Вы благодарите <Target>."
L["EMOTE_WHOA_DESC"] = "Вы смотрите на <Target> и восклицаете 'Ого!'"
L["EMOTE_WINK_DESC"] = "Вы подмигиваете <Target>."
L["EMOTE_YES_DESC"] = "Вы киваете <Target>."
