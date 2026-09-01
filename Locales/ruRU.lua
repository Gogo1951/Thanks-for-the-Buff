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
	"Версия %s. Настройки (включая возможность отключить это сообщение) находятся в меню Настройки > Модификации > Thanks for the Buff (TFTB). Нравится аддон? Расскажите о нем друзьям! (="
L["CHAT_OPTIONS_IN_COMBAT"] =
	"В целях безопасности настройки нельзя открыть во время боя."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s накладывает на вас %s!"
L["MESSAGE_GAVE_YOU"] = "%s передает вам %s!"
L["MESSAGE_GAVE_GROUP"] = "%s передает вашей группе %s!"
L["MESSAGE_USED_ITEM"] = "%s использует %s на вас!"
L["MESSAGE_USED_SPELL"] = "%s применяет %s на вас!"
L["MESSAGE_SET_OUT"] = "%s ставит %s!"
L["MESSAGE_OPENED"] = "%s открывает %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Спасибо за %s!"
L["MESSAGE_PEER_PRESSURE"] = "%s применяет %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s применяет %s к %s!"
L["MESSAGE_SELECT_PLAYER"] = "Выберите игрока для благодарности."
L["MESSAGE_CANT_THANK_SELF"] = "Вы не можете благодарить себя!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Неизвестное заклинание"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Включить приветственное сообщение"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Выводит сообщение в чат при входе в игру."
L["OPTIONS_DESCRIPTION"] =
	"Автоматически благодарите игроков, которые вас баффают, с помощью эмоций, личных сообщений и уведомлений в чате, будь то незнакомец в открытом мире или способность товарища по команде вроде Придания сил или Озарения. Получайте уведомления о пиршествах, порталах и способностях игроков вашего класса."
L["OPTIONS_SUPPORT"] = "Отзывы и поддержка"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Открывает настройки этого аддона."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Баффы от незнакомцев"
L["STRANGERS_ENABLE"] = "Включить благодарности за баффы от незнакомцев"
L["STRANGERS_DESCRIPTION"] =
	"Благодарите игроков вне вашей группы, когда они накладывают на вас баффы в открытом мире."
--[[
    The dropdown values carry the unit, so these labels do not repeat it. Each
    description is one line because it renders as visible help under its control
    rather than behind a hover.
]]
L["STRANGERS_OVERALL_COOLDOWN"] = "Задержка между благодарностями"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Задержка между одной благодарностью и следующей, кто бы вас ни усилил. Установите ноль, чтобы благодарить за каждый бафф."
L["STRANGERS_SOURCE_COOLDOWN"] = "Задержка благодарности тому же игроку"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Задержка между благодарностями, адресованными одному и тому же игроку. Установите ноль, чтобы благодарить за каждый бафф."
L["STRANGERS_MIN_DURATION"] = "Минимальная длительность баффа"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Игнорировать баффы короче этого значения. Установите ноль, чтобы реагировать на каждый бафф."

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Баффы от товарищей по команде"
L["TEAMMATES_ENABLE"] =
	"Включить благодарности за баффы от товарищей по команде"
L["TEAMMATES_DESCRIPTION"] =
	"Благодарите членов группы и рейда за баффы и способности, примененные к вам."

-- Service Alerts
L["TAB_SERVICES"] = "Оповещения об услугах"
L["SERVICES_ENABLE"] = "Включить оповещения об услугах"
L["SERVICES_DESCRIPTION"] =
	"Реагируйте на помощь для всего рейда от вашей группы: пиршества, колодцы душ, порталы, ремонтные боты."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Отправка хороших новостей"
L["GOOD_NEWS_DESCRIPTION"] =
	"Сообщайте игрокам, которых вы усилили, что вы на них наложили и как долго это продлится."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Включить хорошие новости"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Отправлять игроку, которого вы усилили, личное сообщение о том, что он получил и на какое время."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Любой, кого вы усилили"
L["GOOD_NEWS_SCOPE_GROUP"] = "Только участники группы"
L["GOOD_NEWS_MESSAGES_HEADER"] = "Сообщения хороших новостей"
L["GOOD_NEWS_MESSAGE"] = "Текст личного сообщения"
--[[
    Two halves so the number stays authoritative: LIMIT's %d is a real placeholder
    and gets formatted, TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_LIMIT"] = "Максимальная длина: %d."
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a заменяется ссылкой на способность."
--[[
    Appended to the ability link inside %a when the buff has a readable duration.
    A whole clause rather than a bare number so it can be reworded per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "на %s"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Групповое давление"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Получайте уведомления, когда другие игроки вашего класса используют свои способности, чтобы поддаться групповому давлению."
L["PEER_PRESSURE_ENABLE"] = "Включить групповое давление"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Выводить сообщение в ваш собственный чат, когда используется способность вашего класса. Видите только вы."
L["PEER_PRESSURE_OWN_CASTS"] = "Срабатывать на свои заклинания"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Срабатывает и тогда, когда способность используете вы сами, а не только другие игроки."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Проигрывать звук, когда используется способность вашего класса. Слышите только вы."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Отслеживаемые способности"
L["TRACKED_GROUP_ITEMS"] = "Предметы"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Включить или выключить отслеживание для %s."
L["TRACKED_ITEM_PENDING"] = "Предмет #%d"
L["TRACKED_SPELL_PENDING"] = "Заклинание #%d"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "Благодарности и эмоции"
L["NOTIFICATIONS_HEADER"] = "Уведомления"

L["PRAISE_WHISPER_ENABLE"] = "Включить благодарственный шепот"
L["PRAISE_WHISPER_DESCRIPTION"] =
	"Отправлять личное сообщение с благодарностью игроку, давшему бафф."
L["PRAISE_EMOTES_ENABLE"] = "Включить эмоции"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Выражайте благодарность эмоцией. В бою эмоции задерживаются."
L["PRAISE_EMOTES_SELECT"] = "Выбрать эмоции"
L["PRAISE_DELAY_ENABLE"] = "Включить задержку благодарности"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Немного подождать перед шепотом и эмоцией, чтобы благодарность не пришла в тот же миг, что и бафф. На уведомления это не влияет."
L["PRAISE_DELAY_HELP"] =
	"Подождите перед благодарностью, чтобы она не пришла в тот же миг, что и бафф."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Включить сообщения в чате"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Выводить сообщение в ваш собственный чат при получении баффа. Видите только вы."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Включить звуковые эффекты"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] =
	"Проигрывать звук при получении баффа. Слышите только вы."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
    spells and items take their names from the client and need no key here.
]]
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
	"Вежливость на автомате. Каждая кнопка отправляет личное сообщение вашей текущей цели и может добавить эмоцию: попросить воды у мага, поблагодарить за портал, похвалить друга прямо в бою за своевременную провокацию. Напишите сообщение один раз, и дальше все сводится к одному нажатию."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Кнопка TFTB %d"
L["BUTTON_EMOTE"] = "Эмоция"
L["BUTTON_EMOTE_NONE"] = "Нет"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Включить макрос "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] =
	"Создает макрос с именем %s и удаляет его снова, когда вы это отключите."
L["BUTTON_WHISPER"] = "Текст личного сообщения"
L["BUTTON_RESET"] = "Сброс"
L["BUTTON_RESET_DESCRIPTION"] =
	"Сбрасывает текст личного сообщения к стандартному."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Спасибо, ты лучший! (="
--[[
    The star marker and "TFTB // " prefix are added by the builder and are not
    part of the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "У вас %a!"

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
