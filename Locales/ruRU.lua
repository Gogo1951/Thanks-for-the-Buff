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
L["MESSAGE_BUFFED"] = "%s накладывает на вас %s!"
L["MESSAGE_GAVE_YOU"] = "%s передает вам %s!"
L["MESSAGE_GAVE_GROUP"] = "%s передает вашей группе %s!"
L["MESSAGE_USED_ITEM"] = "%s использует %s %s на вас!"
L["MESSAGE_USED_SPELL"] = "%s применяет %s на вас!"
L["MESSAGE_SET_OUT"] = "%s ставит %s!"
L["MESSAGE_OPENED"] = "%s открывает %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Спасибо за %s!"
L["MESSAGE_GOOD_NEWS_DURATION"] = "Хорошие новости! У вас %s на %s!"
L["MESSAGE_GOOD_NEWS"] = "Хорошие новости! У вас %s!"
L["MESSAGE_PEER_PRESSURE"] = "%s применяет %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s применяет %s к %s!"
L["MESSAGE_SELECT_PLAYER"] = "Выберите игрока для благодарности."
L["MESSAGE_CANT_THANK_SELF"] = "Вы не можете благодарить себя!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MESSAGE_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "его"
L["PRONOUN_HER"] = "ее"
L["PRONOUN_THEIR"] = "их"
L["UNKNOWN_SPELL"] = "Неизвестное заклинание"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Включить приветственное сообщение"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Выводит сообщение в чат при входе в игру."
L["OPTIONS_DESCRIPTION"] =
	"Автоматически благодарите игроков, которые вас баффают, с помощью эмоций, личных сообщений и уведомлений в чате, будь то незнакомец в открытом мире или способность товарища по команде вроде Power Infusion или Innervate. Получайте уведомления о пиршествах, порталах и способностях вашего класса."
L["OPTIONS_SUPPORT"] = "Отзывы и поддержка"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMAND_TFTB"] = "/tftb"
L["OPTIONS_COMMAND_TFTB_DESCRIPTION"] = "Открывает настройки Thanks for the Buff."
L["OPTIONS_COMMAND_THANKYOU"] = "/thankyou"
L["OPTIONS_COMMAND_THANKYOU_DESCRIPTION"] =
	"Применяет эмоцию и отправляет личное сообщение вашей текущей цели."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Баффы от незнакомцев"
L["STRANGERS_DESCRIPTION"] =
	"Бафф на вас от игрока вне вашей группы (в открытом мире)."
L["STRANGERS_OVERALL_COOLDOWN"] =
	"Время восстановления благодарностей (в секундах)"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Как часто вообще благодарить кого-либо, от кого бы ни пришел бафф.\n\nУстановите 0, чтобы отключить это ограничение. Не влияет на уведомления."
L["STRANGERS_SOURCE_COOLDOWN"] =
	"Время восстановления для одного игрока (в секундах)"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Как часто благодарить одного и того же игрока.\n\nНе влияет на уведомления."
L["STRANGERS_MIN_DURATION"] = "Минимальная длительность баффа (в секундах)"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Сколько должен действовать бафф, чтобы на него вообще стоило реагировать.\n\nИгнорирует короткие исцеления, такие как Обновление или Омоложение. Уведомления тоже затрагиваются: бафф короче указанного полностью игнорируется, без сообщения, звука, шепота и эмоции."

--------------------------------------------------------------------------------
-- Options: Combat Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Баффы от товарищей по команде"
L["TEAMMATES_DESCRIPTION"] =
	"Бафф или способность с временем восстановления, примененная к вам членом группы или рейда."

-- Group Services
L["TAB_SERVICES"] = "Групповые услуги"
L["SERVICES_DESCRIPTION"] =
	"Помощь для всего рейда от члена группы или рейда: пиршества, колодцы душ, порталы, ремонтные боты."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Хорошие новости"
L["GOOD_NEWS_DESCRIPTION"] =
	"Сообщайте игрокам, которых вы усилили, что вы на них наложили и как долго это продлится."
L["GOOD_NEWS_WHISPER_ENABLE"] = 'Включить "Хорошие новости"'
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Отправлять игроку, которого вы усилили, личное сообщение о том, что он получил и на какое время."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Любой, кого вы баффнули"
L["GOOD_NEWS_SCOPE_GROUP"] = "Только участники группы"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Групповое давление"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Получайте уведомления, когда другие игроки вашего класса используют свои способности, чтобы поддаться групповому давлению."
L["PEER_PRESSURE_ENABLE"] = "Включить Peer Pressure"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Выводить сообщение в ваш собственный чат, когда используется способность вашего класса. Видите только вы."
L["PEER_PRESSURE_OWN_CASTS"] = "Срабатывать на свои заклинания"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Уведомление срабатывает и тогда, когда способность используете вы сами, а не только другие игроки."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Проигрывать звук, когда используется способность вашего класса. Слышите только вы."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Отслеживаемые способности"
L["COMBAT_GROUP_ITEMS"] = "Предметы"
L["COMBAT_TOGGLE_TRACKING"] = "Включить/выключить отслеживание для %s"
L["COMBAT_ITEM_PENDING"] = "Предмет #%d"
L["COMBAT_SPELL_PENDING"] = "Заклинание #%d"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

-- The two section headers every buff panel is built from: what the other player
-- sees, then what only you get. Peer Pressure sends nothing outward, so it
-- carries the Notifications header alone. Key prefixes match the header the
-- control appears under.
L["PRAISE_HEADER"] = "Благодарности и эмоции"
L["NOTIFICATIONS_HEADER"] = "Уведомления"

L["PRAISE_WHISPER_ENABLE"] = "Включить благодарственный шепот"
L["PRAISE_WHISPER_DESCRIPTION"] =
	"Отправлять личное сообщение с благодарностью игроку, давшему бафф."
L["PRAISE_EMOTES_ENABLE"] = "Включить эмоции (вне боя)"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Выражайте благодарность эмоцией. В бою эмоции задерживаются."
L["PRAISE_EMOTES_SELECT"] = "Выбрать эмоции"
L["PRAISE_DELAY_ENABLE"] = "Включить задержку благодарности"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Немного подождать перед шепотом и эмоцией, чтобы благодарность не пришла в тот же миг, что и бафф.\n\nНе влияет на уведомления."
L["PRAISE_DELAY_LENGTH"] = "Задержка"
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] =
	"Сколько ждать перед тем, как поблагодарить игрока, давшего бафф."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Включить сообщения в чате"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Выводить сообщение в ваш собственный чат при получении баффа. Видите только вы."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Включить звуковые эффекты"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] =
	"Проигрывать звук при получении баффа. Слышите только вы."

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
L["BUTTON_DESCRIPTION"] =
	"Поблагодарите вашу текущую цель эмоцией и личным сообщением."
L["BUTTON_CREATE_MACRO"] = "Создать макрос"
L["BUTTON_CREATE_MACRO_DESCRIPTION"] =
	"При входе в игру автоматически создает макрос с именем %s."
L["BUTTON_WHISPER"] = "Личное сообщение"
L["BUTTON_RESET"] = "Сброс"
L["BUTTON_RESET_DESCRIPTION"] =
	"Сбрасывает текст личного сообщения к стандартному."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Спасибо, ты лучший! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "Вы приветствуете <Target>."
L["EMOTE_DRINK_DESCRIPTION"] = "Вы поднимаете бокал за <Target>."
L["EMOTE_FLEX_DESCRIPTION"] = "Вы играете мускулами перед <Target>."
L["EMOTE_GRIN_DESCRIPTION"] = "Вы злорадно ухмыляетесь, глядя на <Target>."
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "Вы даете пять <Target>."
L["EMOTE_PRAISE_DESCRIPTION"] = "Вы восхваляете <Target>."
L["EMOTE_SALUTE_DESCRIPTION"] = "Вы с уважением отдаете честь <Target>."
L["EMOTE_SMILE_DESCRIPTION"] = "Вы улыбаетесь <Target>."
L["EMOTE_THANK_DESCRIPTION"] = "Вы благодарите <Target>."
L["EMOTE_WHOA_DESCRIPTION"] = "Вы восклицаете 'Ого!', глядя на <Target>."
L["EMOTE_WINK_DESCRIPTION"] = "Вы подмигиваете <Target>."
L["EMOTE_YES_DESCRIPTION"] = "Вы киваете <Target>."
