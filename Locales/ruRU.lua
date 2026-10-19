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
-- Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"Версия %s. Настройки (включая возможность отключить это сообщение) находятся в меню Настройки > Модификации > Thanks for the Buff (TFTB). Нравится этот аддон? Расскажите о нем другу, добавьте его в избранное на CurseForge или поставьте Star на GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] =
	"В целях безопасности окно настроек нельзя открыть во время боя."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s накладывает на вас %s!"
L["MESSAGE_GAVE_YOU"] = "%s передает вам %s!"
L["MESSAGE_GAVE_GROUP"] = "%s передает вашей группе %s!"
L["MESSAGE_USED_ITEM"] = "%s использует %s на вас!"
L["MESSAGE_USED_SPELL"] = "%s применяет %s на вас!"
L["MESSAGE_SET_OUT"] = "%s ставит %s!"
L["MESSAGE_OPENED"] = "%s открывает %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Спасибо за %s"
L["MESSAGE_SELECT_PLAYER"] = "Сначала выберите игрока в качестве цели."
L["MESSAGE_CANT_THANK_SELF"] = "Вы не можете благодарить себя!"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "%s применяет %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s применяет %s к %s!"

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
	"Благодарите шепотом или эмоцией каждого игрока, который накладывает на вас бафф, и смотрите, кому не хватает ваших рейдовых баффов, в трекере баффов, где их можно наложить одним щелчком. А еще получайте оповещения о пиршествах, порталах, призывах, колодцах душ и способностях игроков вашего класса. Вежливость на автомате."
L["OPTIONS_FEATURES_HEADER"] = "Функции"
L["OPTIONS_FEATURES_DESCRIPTION"] =
	"Включайте и отключайте каждую функцию здесь или на ее собственной панели."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Открывает окно настроек этого аддона."
L["OPTIONS_EXAMPLE"] = "Пример: %s"

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
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Stranger Buffs
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

-- Teammate Buffs
L["TAB_TEAMMATES"] = "Баффы от товарищей по команде"
L["TEAMMATES_ENABLE"] =
	"Включить благодарности за баффы от товарищей по команде"
L["TEAMMATES_ENABLE_DESCRIPTION"] =
	"Включает благодарности за баффы и способности, которые участники вашей группы или рейда применяют к вам."
L["TEAMMATES_DESCRIPTION"] =
	"Благодарите участников группы и рейда за баффы и способности, которые они применяют к вам."

-- Service Alerts
L["TAB_SERVICES"] = "Оповещения об услугах"
L["SERVICES_ENABLE"] = "Включить оповещения об услугах"
L["SERVICES_ENABLE_DESCRIPTION"] =
	"Включает оповещения о пиршествах, колодцах душ, порталах и другой помощи, предоставленной вашей группе."
L["SERVICES_DESCRIPTION"] =
	"Реагируйте, когда кто-то выставляет помощь для вашей группы: пиршества, колодцы душ, порталы и ремонтные боты."

-- Send Good News
L["TAB_GOOD_NEWS"] = "Отправка хороших новостей"
L["GOOD_NEWS_DESCRIPTION"] =
	"Сообщайте игрокам, которых вы усилили, что вы на них наложили и как долго это продлится."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Включить хорошие новости"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Отправляет игроку, которого вы усилили, личное сообщение о том, что он получил и на какое время."
L["GOOD_NEWS_SCOPE"] = "Получатели"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Любой, кого вы усилили"
L["GOOD_NEWS_SCOPE_GROUP"] = "Только участники группы"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Задает, кто получает личное сообщение с хорошими новостями: любой, кого вы усилили, или только участники вашей группы."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Сообщение с хорошими новостями"
L["GOOD_NEWS_MESSAGES_DESCRIPTION"] =
	"Личное сообщение, которое получают игроки, на которых вы накладываете баффы."
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
	"Получайте уведомления, когда другие игроки вашего класса используют свои способности, и поддавайтесь групповому давлению."
L["PEER_PRESSURE_ENABLE"] = "Включить групповое давление"
L["PEER_PRESSURE_ENABLE_DESCRIPTION"] =
	"Включает оповещения, когда другой игрок вашего класса использует отслеживаемую способность."
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Выводит сообщение, которое видите только вы, когда используется способность вашего класса."
L["PEER_PRESSURE_OWN_CASTS"] = "Срабатывать на свои заклинания"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Также срабатывает, когда свои способности используете вы сами, а не только другие игроки."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Воспроизводит звук, когда используется способность вашего класса. Слышите его только вы."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Отслеживаемые способности"
L["TRACKED_GROUP_ITEMS"] = "Предметы"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Включает или выключает отслеживание для %s."
L["TRACKED_ITEM_PENDING"] = "Предмет #%d"
L["TRACKED_SPELL_PENDING"] = "Заклинание #%d"

-- Shared by Send Good News and the Thank You Button
L["WHISPER_MESSAGE"] = "Текст личного сообщения"
L["WHISPER_MESSAGE_RESET"] = "Сбросить"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] =
	"Возвращает текст личного сообщения к стандартному."

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
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
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups that no single game record names
    (Data/{Game}/Tracked-Abilities-{Game}.lua). Single spells and items, and a
    group named after one of its own items, take their names from the client.
]]
L["GROUP_PORTALS"] = "Порталы"
L["GROUP_RESISTANCE_CAULDRONS"] = "Котлы сопротивления"
L["GROUP_REPAIR_BOTS"] = "Ремонтные боты"

--------------------------------------------------------------------------------
-- Options: Buff Duty
--------------------------------------------------------------------------------

L["TAB_BUFF_WINDOW"] = "Дежурство по баффам"
L["BUFF_WINDOW_DESCRIPTION"] =
	"Показывает, кому не хватает ваших баффов. Нажмите на значок, чтобы применить."
L["BUFF_WINDOW_ENABLE"] = "Включить дежурство по баффам"
L["BUFF_WINDOW_ENABLE_DESCRIPTION"] =
	"Включает дежурство по баффам: окно с участниками группы, которым не хватает баффа, доступного вам."
L["BUFF_WINDOW_NO_BUFFS"] =
	"У вашего класса нет баффов из этого списка, поэтому на этом персонаже окно никогда не появится."
L["BUFF_WINDOW_HEADER"] = "Окно"
L["BUFF_WINDOW_WINDOW_DESCRIPTION"] =
	"Оставьте окно там, где вы его поставили, или уберите его с глаз в бою."
L["BUFF_WINDOW_LOCK"] = "Закрепить окно"
L["BUFF_WINDOW_LOCK_DESCRIPTION"] =
	"Не дает перемещать окно. Когда оно откреплено, перетаскивайте его за фон."
L["BUFF_WINDOW_HIDE_IN_COMBAT"] = "Скрывать в бою"
L["BUFF_WINDOW_HIDE_IN_COMBAT_DESCRIPTION"] =
	"Скрывает окно во время боя. В бою список не может обновляться, поэтому оставленное на экране окно сохраняет последнее состояние до конца боя."
L["BUFF_WINDOW_SHOW_HEADER"] = "Показывать в окне"
L["BUFF_WINDOW_SHOW_DESCRIPTION"] =
	"Добавьте в окно свои баффы, незнакомцев, наложивших на вас баффы, и вашу цель."
L["BUFF_WINDOW_FAVOR_ENABLE"] = "Ответная любезность"
L["BUFF_WINDOW_FAVOR_ENABLE_DESCRIPTION"] =
	"Показывает незнакомцев, недавно наложивших на вас баффы, и баффы, которыми вы можете им ответить. Щелкните правой кнопкой мыши по значку, чтобы убрать игрока из списка."
L["BUFF_WINDOW_FAVOR_SECONDS_DESCRIPTION"] =
	"Задает, как долго незнакомец остается в списке после своего последнего баффа."
L["BUFF_WINDOW_TARGET_ENABLE"] = "Ваша цель"
L["BUFF_WINDOW_TARGET_ENABLE_DESCRIPTION"] =
	"Показывает вашу цель, если это игрок вне вашей группы, которому не хватает баффа, доступного вам."
L["BUFF_WINDOW_REFRESH"] = "Обновлять, если осталось меньше"
L["BUFF_WINDOW_REFRESH_DESCRIPTION"] =
	"Задает, при каком оставшемся времени бафф считается отсутствующим, чтобы вы успели обновить его до того, как он спадет. Бафф, который длится не дольше этого времени, учитывается только после того, как спадет."
L["BUFF_WINDOW_PETS_AS_TANKS"] = "Считать питомцев танками"
L["BUFF_WINDOW_PETS_AS_TANKS_DESCRIPTION"] =
	"Предлагает питомцам баффы, назначенные танкам, например Шипы, а также баффы для всех."
L["BUFF_WINDOW_PETS_AS_TANKS_WHEN_DESCRIPTION"] =
	"Задает, когда питомцы считаются танками."
L["BUFF_WINDOW_PETS_AS_TANKS_SOLO"] = "Когда вы не в группе"
L["BUFF_WINDOW_PETS_AS_TANKS_ALWAYS"] = "Всегда"
-- Who each buff is offered to: one dropdown per buff, these four choices.
L["BUFF_WINDOW_AUDIENCE_OFF"] = "Выкл."
L["BUFF_WINDOW_AUDIENCE_TANK"] = "Танки"
L["BUFF_WINDOW_AUDIENCE_HEALER"] = "Лекари"
L["BUFF_WINDOW_AUDIENCE_ALL"] = "Все"
-- The dropdown's tooltip when the client has no description for the spell yet.
L["BUFF_WINDOW_AUDIENCE_DESCRIPTION"] = "Задает, кому предлагать %s."
L["BUFF_WINDOW_BUFFS_DESCRIPTION"] =
	"Выберите, кому предлагать каждый бафф. Танки и лекари определяются по роли в группе, а если роль не задана, по классу."

L["BUFF_WINDOW_SELF_DESCRIPTION"] =
	"Ваши собственные баффы, закрепленные вверху окна."
--[[
    Muted note after a class name on the Self-Buffs panel, for a family of self
    buffs only one of which can be up at a time. Keyed by the family.
]]
L["BUFF_WINDOW_SELF_NOTE_ASPECT"] = "подойдет любой дух"
L["BUFF_WINDOW_SELF_NOTE_MAGE_ARMOR"] = "подойдет любая броня"
L["BUFF_WINDOW_SELF_NOTE_PALADIN_AURA"] = "подойдет любая аура"
L["BUFF_WINDOW_SELF_NOTE_SHAMAN_IMBUE"] = "подойдет любое улучшение оружия"
L["BUFF_WINDOW_SELF_NOTE_SHAMAN_SHIELD"] = "подойдет любой щит"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_ARMOR"] = "подойдет любая броня"
L["BUFF_WINDOW_SELF_REFRESH_OFF"] = "Выкл."
L["BUFF_WINDOW_SELF_REFRESH_MISSING"] = "Если нет"
-- %s is a duration from the client, like "5 Minutes".
L["BUFF_WINDOW_SELF_REFRESH_UNDER"] = "Меньше, чем %s"
L["BUFF_WINDOW_SELF_REFRESH_DESCRIPTION"] =
	"Задает, когда показывать %s: никогда, после окончания действия или когда осталось меньше этого времени."
L["BUFF_WINDOW_SELF_ENABLE"] = "Ваши баффы на себя"
L["BUFF_WINDOW_SELF_ENABLE_DESCRIPTION"] =
	"Показывает вверху окна баффы, которые вы можете наложить только на себя, например броню или Внутренний огонь, когда их нет или они скоро закончатся. Выберите нужные в разделе Баффы на себя."

-- The window itself
L["BUFF_WINDOW_SELF_HEADER"] = "Баффы на себя"
L["BUFF_WINDOW_FAVOR_HEADER"] = "Ответная любезность"
L["BUFF_WINDOW_TARGET_HEADER"] = "Цель"
L["BUFF_WINDOW_TOOLTIP_CAST"] = "Нажмите, чтобы применить к игроку %s."
L["BUFF_WINDOW_TOOLTIP_GROUP"] =
	"Нажмите, чтобы применить к игроку %s и его группе."
L["BUFF_WINDOW_TOOLTIP_FAVOR"] =
	"Нажмите, чтобы выбрать игрока %s целью и применить."
L["BUFF_WINDOW_TOOLTIP_DISMISS"] = "Правый клик, чтобы убрать игрока %s из списка."

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

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Спасибо, ты супер! (="
--[[
    The star marker (left off on WoW Forever) and " // TFTB" sign-off are added
    by the builder, which also drops the closing punctuation; neither is part of
    the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "У вас %a"

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
