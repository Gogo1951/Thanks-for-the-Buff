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

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Спасибо за %s"
L["MESSAGE_SELECT_PLAYER"] = "Сначала выберите игрока в качестве цели."
L["MESSAGE_CANT_THANK_SELF"] = "Вы не можете благодарить себя!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Неизвестное заклинание"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Включить приветственное сообщение"
L["OPTIONS_WELCOME_DESCRIPTION"] =
	"Выводит сообщение, которое видите только вы, при входе в игру."
L["OPTIONS_DESCRIPTION"] =
	"Автоматически благодарите шепотом или эмоцией каждого игрока, который накладывает на вас бафф, и благодарите кого угодно вручную одним щелчком по макросам благодарности. Вежливость на автомате."
L["OPTIONS_FEATURES_HEADER"] = "Функции"
L["OPTIONS_FEATURES_DESCRIPTION"] =
	"Включайте и отключайте каждую функцию здесь или на ее собственной панели."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Открывает окно настроек этого аддона."
L["SAMPLE_EXAMPLE"] = "Пример: %s"

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
-- Options: Stranger Buffs
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Баффы от незнакомцев"
L["STRANGERS_ENABLE"] = "Включить благодарности за баффы от незнакомцев"
L["STRANGERS_ENABLE_DESCRIPTION"] =
	"Включает благодарности за баффы от игроков вне вашей группы."
L["STRANGERS_DESCRIPTION"] =
	"Благодарите игроков вне вашей группы, когда они накладывают на вас баффы в открытом мире."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "Задержка между благодарностями"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Задает задержку между одним раундом благодарностей и следующим, кто бы ни наложил на вас бафф. Установите ноль, чтобы благодарить за каждый бафф."
L["STRANGERS_SOURCE_COOLDOWN"] = "Задержка благодарности тому же игроку"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Задает задержку между благодарностями одному и тому же игроку. Установите ноль, чтобы благодарить за каждый бафф."
L["STRANGERS_MIN_DURATION"] = "Минимальная длительность баффа"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Игнорирует баффы короче этого значения. Установите ноль, чтобы реагировать на каждый бафф."

--------------------------------------------------------------------------------
-- Options: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers the Stranger Buffs panel is built from: what the
    other player sees, then what only you get. Key prefixes match the header
    the control appears under.
]]
L["PRAISE_HEADER"] = "Благодарственный шепот и эмоции"
L["NOTIFICATIONS_HEADER"] = "Уведомления"
L["PRAISE_DESCRIPTION"] =
	"Что видит другой игрок: благодарственный шепот, эмоцию или и то, и другое."
L["NOTIFICATIONS_DESCRIPTION"] =
	"Что получаете только вы: текстовое сообщение, звук или и то, и другое."

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "Выбор эмоций"

L["PRAISE_WHISPER_ENABLE"] = "Включить благодарственный шепот"
L["PRAISE_WHISPER_DESCRIPTION"] =
	"Отправляет благодарность шепотом игроку, который наложил на вас бафф."
L["PRAISE_EMOTES_ENABLE"] = "Включить эмоции"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Выражает вашу благодарность эмоцией. Во время боя эмоции откладываются."
L["PRAISE_DELAY_ENABLE"] = "Включить задержку благодарности"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Ненадолго откладывает шепот и эмоцию, чтобы благодарность не пришла в тот же миг, что и бафф. На уведомления это не влияет."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] =
	"Задает время ожидания перед отправкой шепота и эмоции."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Включить текстовые сообщения"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Выводит сообщение, которое видите только вы, при получении баффа."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Включить звуковые эффекты"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] =
	"Воспроизводит звук при получении баффа. Слышите его только вы."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] =
	"Воспроизводит звук, чтобы вы могли услышать его до включения."

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Кнопка благодарности"
L["BUTTON_DESCRIPTION"] =
	"Отправляйте цели личное сообщение и эмоцию одним нажатием. Вежливость на автомате."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Кнопка благодарности %d"
L["BUTTON_EMOTE"] = "Эмоция"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Задает эмоцию, которую эта кнопка адресует вашей цели. Вариант Нет отключает эмоцию."
L["BUTTON_EMOTE_NONE"] = "Нет"
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
	"Задает текст личного сообщения, которое эта кнопка отправляет вашей цели. Оставьте поле пустым, чтобы не отправлять сообщение."

-- Each button's whisper box
L["WHISPER_MESSAGE"] = "Текст личного сообщения"
L["WHISPER_MESSAGE_RESET"] = "Сбросить"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] =
	"Возвращает текст личного сообщения к стандартному."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Спасибо, ты супер! (="

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
