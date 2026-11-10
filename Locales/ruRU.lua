local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "ruRU")
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
	"Версия %s. Настройки (включая возможность отключить это сообщение) находятся в меню Настройки > Модификации > Thanks for the Buff (TFTB). Нравится этот аддон? Расскажите о нем другу, добавьте его в избранное на CurseForge или поставьте Star на GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] =
	"В целях безопасности окно настроек нельзя открыть во время боя."

-- Buff print out
L["MESSAGE_BUFFED"] = "%s накладывает на вас %s!"

-- Thank You Button
L["MESSAGE_SELECT_PLAYER"] = "Сначала выберите игрока в качестве цели."
L["MESSAGE_CANT_THANK_SELF"] = "Вы не можете благодарить себя!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Неизвестное заклинание"
L["SAMPLE_EXAMPLE"] = "Пример: %s"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Включить приветственное сообщение"
L["OPTIONS_WELCOME_DESCRIPTION"] =
	"Выводит сообщение, которое видите только вы, при входе в игру."
L["OPTIONS_DESCRIPTION"] =
	"Автоматически благодарите эмоцией или шепотом игроков, которые накладывают на вас баффы, приветствуйте друзей и согильдийцев взмахом руки, проходя мимо, и благодарите любого, кто у вас в цели, одним щелчком по макросам благодарности."
L["OPTIONS_FEATURES_HEADER"] = "Функции"
L["OPTIONS_FEATURES_DESCRIPTION"] =
	"Включайте и отключайте каждую функцию здесь или на ее собственной панели."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Открывает окно настроек этого аддона."

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "Ищете другие функции?"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"Некоторые функции переехали в наш новый аддон Good to Go. Его можно найти на CurseForge или Wago."

--------------------------------------------------------------------------------
-- Options: Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "Помогите Thanks for the Buff (TFTB) повысить уровень"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"Этот аддон создали игроки, которые любят эту игру и хотят сделать ее как можно интереснее для всех. Мы никогда не попросим пожертвований. Настоящее удовлетворение нам приносит знание того, что наша работа делает игру для вас немного лучше. Если это так, мы будем рады об этом услышать!"
L["OPTIONS_LEVEL_UP_WAYS"] =
	"Вот несколько способов помочь нам охватить больше игроков."
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• Поделитесь отзывом: нашли ошибку или есть идея? Сообщите нам в Discord. Ваши отзывы помогают нам улучшать аддон, а пул-реквесты всегда приветствуются."
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• Расскажите другу: знаете кого-то, кому может понравиться этот аддон? Расскажите ему о нем. Сарафанное радио помогает большему числу игроков находить отличные аддоны."
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	"• Добавьте в избранное на CurseForge: откройте ссылку на CurseForge ниже, войдите в аккаунт и нажмите на звездочку под кнопкой Download. Избранное помогает большему числу игроков находить аддон."
L["OPTIONS_LEVEL_UP_GITHUB"] =
	"• Поставьте Star на GitHub: откройте ссылку на GitHub ниже, войдите в аккаунт и нажмите Star в правом верхнем углу. Звезды помогают проекту получить доступ к большему числу бесплатных инструментов для разработчиков."
L["OPTIONS_LEVEL_UP_THANKS"] = "Спасибо, что выбрали Thanks for the Buff (TFTB)!"

L["OPTIONS_FEEDBACK"] = "Отзывы и поддержка"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "Ссылки для отзывов и поддержки"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] =
	"Чтобы скопировать ссылку, щелкните по ее полю, затем нажмите Ctrl+A и Ctrl+C."
L["OPTIONS_VERSION"] = "Версия %s"

--------------------------------------------------------------------------------
-- Options: Give Thanks
--------------------------------------------------------------------------------

L["TAB_GIVE_THANKS"] = "Благодарности"
L["GIVE_THANKS_ENABLE"] = "Включить благодарности"
L["GIVE_THANKS_ENABLE_DESCRIPTION"] =
	"Включает благодарности за баффы от игроков вне вашей группы."
L["GIVE_THANKS_DESCRIPTION"] =
	"Благодарите игроков вне вашей группы, когда они накладывают на вас баффы в открытом мире."

-- Praise Limits
L["PRAISE_HEADER"] = "Ограничения благодарностей"
L["PRAISE_DESCRIPTION"] =
	"Эти настройки сдерживают и эмоцию, и шепот, чтобы волна баффов никогда не превратилась в спам."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["GIVE_THANKS_OVERALL_COOLDOWN"] = "Задержка между благодарностями"
L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Задает задержку между одним раундом благодарностей и следующим, кто бы ни наложил на вас бафф. Установите ноль, чтобы благодарить за каждый бафф."
L["GIVE_THANKS_SOURCE_COOLDOWN"] = "Задержка благодарности тому же игроку"
L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Задает задержку между благодарностями одному и тому же игроку. Установите ноль, чтобы благодарить за каждый бафф."
L["GIVE_THANKS_MIN_DURATION"] = "Минимальная длительность баффа"
L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"] =
	"Игнорирует баффы короче этого значения. Установите ноль, чтобы реагировать на каждый бафф."
L["PRAISE_DELAY_ENABLE"] = "Включить задержку благодарности"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Ненадолго откладывает шепот и эмоцию, чтобы благодарность не пришла в тот же миг, что и бафф. На уведомления это не влияет."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] =
	"Задает время ожидания перед отправкой шепота и эмоции."

-- Thank-You Whispers
L["WHISPERS_HEADER"] = "Благодарственный шепот"
L["PRAISE_WHISPER_ENABLE"] = "Включить благодарственный шепот"
L["PRAISE_WHISPER_DESCRIPTION"] =
	"Шепчет благодарность игроку, который дал вам бафф."
-- TRANSLATORS: keep {spell} exactly as written; it is the token players type into the whisper.
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"Задает, что TFTB шепчет игроку, который дал вам бафф. {spell} заменяется на бафф. Оставьте поле пустым, чтобы ничего не шептать."

-- Notifications
L["NOTIFICATIONS_HEADER"] = "Уведомления"
L["NOTIFICATIONS_DESCRIPTION"] =
	"Что получаете только вы: текстовое сообщение, звук или и то, и другое."
L["NOTIFICATIONS_PRINT_ENABLE"] = "Включить текстовые сообщения"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Выводит сообщение, которое видите только вы, при получении баффа."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Включить звуковые эффекты"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] =
	"Воспроизводит звук при получении баффа. Слышите его только вы."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] =
	"Воспроизводит звук, чтобы вы могли услышать его до включения."

--------------------------------------------------------------------------------
-- Options: Emotes List
--------------------------------------------------------------------------------

L["TAB_EMOTES_LIST"] = "Список эмоций"
L["EMOTES_GRID_DESCRIPTION"] =
	"Отметьте эмоции, из которых функция Благодарности может выбирать, когда игрок вне вашей группы дает вам бафф; она использует одну наугад. Во время боя эмоции откладываются."

--[[
    The emote checklist, shared by this panel and Wave to Friends' Friends and
    Guilds tabs. Its group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS
    entry, upper-cased.
]]
L["EMOTE_GROUP_COUNT"] = "%s (отмечено %d из %d)"
L["EMOTE_GROUP_TEXT"] = "Текст"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "Показывает только строку эмоции."
L["EMOTE_GROUP_VOICE"] = "Голос"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "Проигрывает голосовую реплику."
L["EMOTE_GROUP_GESTURE"] = "Жест"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "Проигрывает короткую анимацию."
L["EMOTE_GROUP_POSE"] = "Поза"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "Держится, пока вы не двинетесь."
L["EMOTES_RESET"] = "Сбросить эмоции"
L["EMOTES_RESET_DESCRIPTION"] =
	"Возвращает в списке благодарственные эмоции по умолчанию."
L["EMOTES_RESET_CONFIRM"] = "Сбросить список эмоций к значениям по умолчанию?"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "Игнорируемые баффы"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"За баффы из этого списка благодарность не отправляется, кто бы их ни наложил. Текстовое сообщение и звук вы по-прежнему получаете."
L["IGNORED_BUFFS_ADD_CURRENT"] = "Игнорировать текущий бафф"
L["IGNORED_BUFFS_ADD_CURRENT_DESCRIPTION"] =
	"Добавляет один из баффов, которые сейчас на вас."
L["IGNORED_BUFFS_ADD"] = "Добавить бафф"
L["IGNORED_BUFFS_ADD_DESCRIPTION"] =
	"Введите ID заклинания или вставьте в поле ссылку на бафф с помощью Shift-клика, затем нажмите Enter."
L["IGNORED_BUFFS_EMPTY"] = "Игнорируемых баффов пока нет. Добавьте бафф выше."
L["IGNORED_BUFFS_REMOVE"] = "Удаляет этот бафф из списка."
L["IGNORED_BUFFS_NOT_FOUND"] = "Бафф для %s не найден."
L["IGNORED_BUFFS_ALL_CHARACTERS"] = "Все персонажи"
L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"] =
	'Переносит этот бафф в список "Все персонажи", чтобы за него не благодарили ни на одном персонаже.'

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Кнопка благодарности"
L["BUTTON_DESCRIPTION"] =
	"Отправляйте цели шепот и эмоцию одним нажатием. Вежливость на автомате."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Кнопка благодарности %d"
L["BUTTON_EMOTE"] = "Эмоция"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Задает эмоцию, которую эта кнопка адресует вашей цели. Вариант Нет отключает эмоцию."
L["BUTTON_EMOTE_NONE"] = "Нет"
-- Titles Thank You Button 1's emote checklist.
L["EMOTES_SELECT"] = "Выбор эмоций"
L["BUTTON_ICON"] = "Значок"
L["BUTTON_ICON_DESCRIPTION"] =
	"Задает значок, который макрос этой кнопки показывает в списке макросов и на панелях команд."
-- The Icon dropdown's first choice, the macros' own icon; every other choice is a picture alone.
L["BUTTON_ICON_DEFAULT"] = "По умолчанию"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Включить макрос "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] =
	"Создает макрос с именем %s и снова удаляет его, когда вы отключаете этот параметр."
L["BUTTON_WHISPER_DESCRIPTION"] =
	"Задает, что эта кнопка шепчет вашей цели. Оставьте поле пустым, чтобы ничего не шептать."

--------------------------------------------------------------------------------
-- Options: Wave to Friends
--------------------------------------------------------------------------------

L["TAB_WAVE_TO_FRIENDS"] = "Приветствие друзей"
L["WAVE_ENABLE"] = "Включить приветствие друзей"
L["WAVE_ENABLE_DESCRIPTION"] =
	"Включает эмоцию для друзей и согильдийцев, когда вы наводите на них курсор."
L["WAVE_DESCRIPTION"] =
	"Приветствуйте друзей и согильдийцев эмоцией, когда наводите на них курсор в открытом мире."
L["WAVE_RULES"] = "Никогда для вашей группы или рейда и никогда в бою."
L["WAVE_RESTING_ENABLE"] = "Только во время отдыха"
L["WAVE_RESTING_ENABLE_DESCRIPTION"] =
	"Приветствует только во время отдыха, в городе или таверне."
L["WAVE_COOLDOWN"] = "Задержка для того же игрока"
L["WAVE_COOLDOWN_DESCRIPTION"] =
	"Задает, через какое время того же игрока можно поприветствовать снова."
L["WAVE_COOLDOWN_ONCE_PER_SESSION"] = "Раз за сеанс"
-- %s is the default emotes' slash commands, as the client names them.
L["WAVE_EMOTES_RESET_DEFAULTS_DESCRIPTION"] =
	"Оставляет в списке отмеченными только %s."

-- Custom List
L["WAVE_TAB_CUSTOM"] = "Свой список"
L["WAVE_CUSTOM_DESCRIPTION"] =
	"Игроки, которые всегда получают свою эмоцию, даже раньше вкладок Друзья и Гильдии. Выберите Нет, чтобы никогда не адресовать кому-то эмоцию."
-- One of these two follows WAVE_CUSTOM_DESCRIPTION: realm clients, then WoW Forever, which has no realms.
L["WAVE_CUSTOM_NAMES_REALM"] =
	"Имя-Сервер подходит только для этого сервера; имя без сервера подходит для любого сервера."
L["WAVE_CUSTOM_NAMES_FOREVER"] =
	"Полное имя подходит одному персонажу; одно имя без фамилии подходит всем, у кого оно такое же."
L["WAVE_CUSTOM_ENABLE"] = "Включить свой список"
L["WAVE_CUSTOM_ENABLE_DESCRIPTION"] =
	"Использует имена ниже раньше вкладок Друзья и Гильдии."
L["WAVE_CUSTOM_OFF_WARNING"] =
	"Свой список выключен, поэтому никто ниже не получит свою эмоцию."
L["WAVE_CUSTOM_ADD"] = "Добавить игрока"
L["WAVE_CUSTOM_ADD_DESCRIPTION"] =
	"Введите имя или Имя-Сервер, затем нажмите Enter. Несколько имен разделяйте запятыми."
L["WAVE_CUSTOM_ADD_DESCRIPTION_FOREVER"] =
	"Введите полное имя или только имя без фамилии, затем нажмите Enter. Несколько имен разделяйте запятыми."
L["WAVE_CUSTOM_EMPTY"] = "Игроков пока нет. Добавьте игрока выше."
L["WAVE_CUSTOM_EMOTE_DESCRIPTION"] =
	"Задает эмоцию для этого игрока. Вариант Нет отключает для него эмоции."
L["WAVE_CUSTOM_REMOVE"] = "Удаляет этого игрока из списка."

-- Friends
L["WAVE_TAB_FRIENDS"] = "Друзья"
L["WAVE_FRIENDS_ENABLE"] = "Махать друзьям"
L["WAVE_FRIENDS_ENABLE_DESCRIPTION"] =
	"Приветствует персонажей из вашего списка друзей."
L["WAVE_BNET_ENABLE"] = "Включая друзей Battle.net"
L["WAVE_BNET_ENABLE_DESCRIPTION"] =
	"Также приветствует персонажей, за которых играют ваши друзья Battle.net."
L["WAVE_FRIENDS_EMOTES_DESCRIPTION"] =
	"Отметьте эмоции для друзей; используется одна наугад."

-- Guilds
L["WAVE_TAB_GUILDS"] = "Гильдии"
L["WAVE_MY_GUILD_ENABLE"] = "Махать своей гильдии"
L["WAVE_MY_GUILD_ENABLE_DESCRIPTION"] =
	"Приветствует членов гильдии, в которой вы состоите."
L["WAVE_GUILD_ADD"] = "Добавить гильдию"
L["WAVE_GUILD_ADD_DESCRIPTION"] =
	"Введите название гильдии, затем нажмите Enter. Несколько гильдий разделяйте запятыми. Регистр букв не важен."
L["WAVE_GUILDS_EMPTY"] = "Других гильдий пока нет. Добавьте гильдию выше."
L["WAVE_GUILD_REMOVE"] = "Удаляет эту гильдию из списка."
L["WAVE_GUILDS_EMOTES_DESCRIPTION"] =
	"Отметьте эмоции для согильдийцев; используется одна наугад."

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks and each Thank You Button.
L["WHISPER_MESSAGE"] = "Текст шепота"
L["WHISPER_MESSAGE_RESET"] = "Сбросить"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Возвращает текст шепота к стандартному."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Спасибо, ты супер! (="
-- TRANSLATORS: keep {spell} exactly as written; TFTB swaps in the buff's link.
L["DEFAULT_GIVE_THANKS_WHISPER"] = "Спасибо за {spell}"
