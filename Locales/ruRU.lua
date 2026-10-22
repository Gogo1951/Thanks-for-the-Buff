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

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Неизвестное заклинание"

--------------------------------------------------------------------------------
-- Mini-map Button
--------------------------------------------------------------------------------

L["MINIMAP_OPTIONS"] = "Настройки Thanks for the Buff (TFTB)"
L["LEFT_CLICK"] = "Левый клик"
L["RIGHT_CLICK"] = "Правый клик"
L["SHIFT_LEFT_CLICK"] = "Shift + Левый клик"
L["SHIFT_RIGHT_CLICK"] = "Shift + Правый клик"
L["SHIFT_MIDDLE_CLICK"] = "Shift + Средний клик"
L["ACTION_TOGGLE"] = "Переключить"
L["ENABLED"] = "Включено"
L["DISABLED"] = "Выключено"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Включить приветственное сообщение"
L["OPTIONS_WELCOME_DESCRIPTION"] =
	"Выводит сообщение, которое видите только вы, при входе в игру."
L["OPTIONS_ENABLE_MINIMAP"] = "Включить кнопку у миникарты"
L["OPTIONS_ENABLE_MINIMAP_DESCRIPTION"] =
	"Показывает кнопку TFTB у миникарты, которая включает и выключает функции одним щелчком."
L["OPTIONS_DESCRIPTION"] =
	"Автоматически благодарите шепотом или эмоцией каждого игрока, который накладывает на вас бафф, и держите под баффами свой рейд, себя и свое оружие с помощью напоминания о недостающих баффах, где их можно наложить одним щелчком. А еще получайте оповещения о пиршествах, порталах, призывах и колодцах душ. Вежливость на автомате."
L["OPTIONS_FEATURES_HEADER"] = "Функции"
L["OPTIONS_FEATURES_DESCRIPTION"] =
	"Включайте и отключайте каждую функцию здесь или на ее собственной панели."
L["OPTIONS_FEATURES_NOTE"] =
	'Некоторые наши новые функции, например "%s", выходят за привычные рамки "Thanks for the Buff". Смело отключайте всё, что вам не нужно. Эти функции могут переехать в наш другой аддон, "Connoisseur & Restocker", или всё может объединиться в один большой аддон, например "Buttons, Buffs, & Bags". Поделитесь мнением в Discord, на CurseForge или GitHub. Спасибо!'
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
	"Сообщайте игрокам, которых вы усилили, что вы на них наложили, а для коротких баффов и как долго это продлится."
L["GOOD_NEWS_ENABLE"] = "Включить хорошие новости"
L["GOOD_NEWS_ENABLE_DESCRIPTION"] =
	"Включает личное сообщение игрокам, которых вы усилили, о том, что вы на них наложили."
L["GOOD_NEWS_SCOPE"] = "Получатели"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Любой, кого вы усилили"
L["GOOD_NEWS_SCOPE_GROUP"] = "Только участники группы"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Задает, кто получает личное сообщение с хорошими новостями: любой, кого вы усилили, или только участники вашей группы."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Сообщение с хорошими новостями"
L["GOOD_NEWS_MESSAGES_DESCRIPTION"] =
	"Личное сообщение, которое получают игроки, на которых вы накладываете баффы."
--[[
    The message box's tooltip, in three parts. LIMIT's %d is a real placeholder
    and gets formatted; TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_INPUT_DESCRIPTION"] =
	"Задает текст личного сообщения. Оставьте поле пустым, чтобы использовать стандартный текст."
L["GOOD_NEWS_MESSAGE_LIMIT"] = "Максимальная длина: %d."
L["GOOD_NEWS_MESSAGE_TOKENS"] =
	"%a заменяется ссылкой на способность, а также ее длительностью, если она меньше минуты."
--[[
    Appended to the ability link inside %a when the buff has a readable duration
    under a minute. A whole clause rather than a bare number so it can be reworded
    per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "на %s"

-- Peer Pressure (TEMPORARY: delete on or after 2026-11-21, with Options/Options-Peer-Pressure.lua)
L["TAB_PEER_PRESSURE"] = "Групповое давление"
L["PEER_PRESSURE_CONTROL_FREAK"] = "Control Freak"
L["PEER_PRESSURE_MOVED"] =
	'WoW Forever не позволяет аддонам читать журнал боя, поэтому мы перестраиваем наши аддоны, чтобы они одинаково работали во всех версиях игры. "Групповое давление" переехало в наш другой аддон, "Control Freak". Установите его, чтобы и дальше получать оповещения, когда игроки вашего класса используют свои способности с перезарядкой.'

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Отслеживаемые способности"
L["TRACKED_GROUP_ITEMS"] = "Предметы"
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
    sees, then what only you get. Key prefixes match the header the control
    appears under.
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
-- When to Show: Solo and In Group, each with Always or In Instance, then the classes.
L["BUFF_WINDOW_WHEN_HEADER"] = "Когда показывать"
L["BUFF_WINDOW_WHEN_DESCRIPTION"] = "Выберите, когда может появляться окно."
L["BUFF_WINDOW_WHEN_SOLO"] = "Соло"
L["BUFF_WINDOW_WHEN_SOLO_DESCRIPTION"] =
	"Показывает окно, когда вы не в группе или рейде."
L["BUFF_WINDOW_WHEN_GROUP"] = "В группе"
L["BUFF_WINDOW_WHEN_GROUP_DESCRIPTION"] =
	"Показывает окно, когда вы в группе или рейде."
L["BUFF_WINDOW_WHERE_DESCRIPTION"] =
	"Определяет, где показывается окно: везде или только в подземельях, рейдах, на полях боя и аренах."
L["BUFF_WINDOW_WHERE_ALWAYS"] = "Всегда"
L["BUFF_WINDOW_WHERE_INSTANCE"] = "В подземелье"
L["BUFF_WINDOW_CLASSES_DESCRIPTION"] =
	"Показывает окно, когда вы играете этими классами."
L["BUFF_WINDOW_CLASS_DESCRIPTION"] =
	"Показывает окно, когда вы играете этим классом."
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
-- Count as Tanks: one dropdown per class, then Pets, each with these three choices.
L["BUFF_WINDOW_TANKS_HEADER"] = "Считать танками"
L["BUFF_WINDOW_TANKS_DESCRIPTION"] =
	"Кто получает баффы, которые вы предлагаете танкам, например Шипы, если у игрока нет своей роли."
L["BUFF_WINDOW_TANKS_CLASS_DESCRIPTION"] =
	"Задает, когда игроки этого класса считаются танками. Роль танка или лекаря, если она у них есть, всегда важнее."
L["BUFF_WINDOW_TANKS_PETS"] = "Питомцы"
L["BUFF_WINDOW_TANKS_PETS_DESCRIPTION"] =
	"Задает, когда питомцы считаются танками. Питомцы также получают баффы, которые вы предлагаете всем."
L["BUFF_WINDOW_TANKS_NEVER"] = "Никогда"
L["BUFF_WINDOW_TANKS_SOLO"] = "Когда вы не в группе"
L["BUFF_WINDOW_TANKS_ALWAYS"] = "Всегда"
-- Who each buff is offered to: one dropdown per buff, these four choices.
L["BUFF_WINDOW_AUDIENCE_OFF"] = "Выкл."
L["BUFF_WINDOW_AUDIENCE_TANK"] = "Танки"
L["BUFF_WINDOW_AUDIENCE_HEALER"] = "Лекари"
L["BUFF_WINDOW_AUDIENCE_ALL"] = "Все"
-- Each buff's dropdown tooltip; hovering the buff's name shows the spell itself.
L["BUFF_WINDOW_AUDIENCE_DESCRIPTION"] = "Задает, кому предлагать %s."
L["BUFF_WINDOW_BUFFS_DESCRIPTION"] =
	"Выберите, кому предлагать каждый бафф. Танки и лекари определяются по роли в группе; все без роли считаются бойцами, если в разделе Считать танками ниже не указано иное."

L["BUFF_WINDOW_SELF_DESCRIPTION"] =
	"Ваши собственные баффы, закрепленные вверху окна."
--[[
    Muted note after a class name on the Self-Buffs panel, for a family of self
    buffs only one of which can be up at a time. Keyed by the family.
]]
L["BUFF_WINDOW_SELF_NOTE_ASPECT"] = "подойдет любой дух"
L["BUFF_WINDOW_SELF_NOTE_MAGE_ARMOR"] = "подойдет любая броня"
L["BUFF_WINDOW_SELF_NOTE_PALADIN_AURA"] = "подойдет любая аура"
L["BUFF_WINDOW_SELF_NOTE_SHAMAN_SHIELD"] = "подойдет любой щит"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_ARMOR"] = "подойдет любая броня"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_DEMON"] =
	"подойдет любой из двух демонических баффов"
L["BUFF_WINDOW_SELF_REFRESH_OFF"] = "Выкл."
L["BUFF_WINDOW_SELF_REFRESH_MISSING"] = "Если нет"
-- %s is a duration from the client, like "5 Minutes".
L["BUFF_WINDOW_SELF_REFRESH_UNDER"] = "Меньше, чем %s"
L["BUFF_WINDOW_SELF_REFRESH_DESCRIPTION"] =
	"Задает, когда показывать %s: никогда, после окончания действия или когда осталось меньше этого времени."
-- The Weapon Buffs panel, under Buff Duty after Self-Buffs.
L["BUFF_WINDOW_WEAPON_PANEL_HEADER"] = "Баффы оружия"
L["BUFF_WINDOW_WEAPON_DESCRIPTION"] =
	"Отметьте, что должно быть на каждом оружии. Окно предложит это, когда эффекта нет или он скоро закончится, если предмет есть в сумках и подходит к оружию."
-- The one timing for every weapon buff, at the top of the panel.
L["BUFF_WINDOW_WEAPON_REFRESH"] = "Наносить снова"
L["BUFF_WINDOW_WEAPON_REFRESH_DESCRIPTION"] =
	"Задает, когда бафф оружия предлагается снова: после окончания действия или когда осталось меньше этого времени."
-- The boxes for the weapon items any class can use, after the rogue and shaman boxes.
L["BUFF_WINDOW_WEAPON_KIND_OIL"] = "Масла"
L["BUFF_WINDOW_WEAPON_KIND_STONE"] = "Камни"
L["BUFF_WINDOW_WEAPON_KIND_LURE"] = "Приманки"
--[[
    One choice's checkbox under one hand. The first %s is the poison, imbue,
    oil, stone or lure, the second the client's "Main Hand" or "Off Hand".
]]
L["BUFF_WINDOW_WEAPON_PICK_DESCRIPTION"] =
	"Предлагает %s для оружия (%s). Пока на оружии нет ни одного из отмеченных вариантов, предлагается каждый, который у вас есть."
L["BUFF_WINDOW_SELF_ENABLE"] = "Ваши баффы на себя"
L["BUFF_WINDOW_SELF_ENABLE_DESCRIPTION"] =
	"Показывает вверху окна баффы, которые вы можете наложить только на себя, например броню или Внутренний огонь, когда их нет или они скоро закончатся. Выберите нужные в разделе Баффы на себя."
L["BUFF_WINDOW_WEAPON_ENABLE"] = "Ваши баффы оружия"
L["BUFF_WINDOW_WEAPON_ENABLE_DESCRIPTION"] =
	"Показывает яды, чары оружия, масла, камни и приманки, которых нет на вашем оружии или которые скоро закончатся, вместе с баффами на себя вверху окна. Нажмите на один из них, чтобы нанести его. Выберите нужные в разделе Баффы оружия."

-- The window itself
L["BUFF_WINDOW_SELF_HEADER"] = "Баффы на себя"
L["BUFF_WINDOW_FAVOR_HEADER"] = "Ответная любезность"
L["BUFF_WINDOW_TARGET_HEADER"] = "Цель"
L["BUFF_WINDOW_TOOLTIP_CAST"] = "Нажмите, чтобы применить к игроку %s."
-- %s is the client's "Main Hand" or "Off Hand".
L["BUFF_WINDOW_TOOLTIP_WEAPON"] = "Нажмите, чтобы нанести на оружие (%s)."
L["BUFF_WINDOW_TOOLTIP_USE"] =
	"Ни у кого в группе нет камня души. Нажмите, чтобы использовать его на игроке %s."
L["BUFF_WINDOW_TOOLTIP_CREATE"] =
	"Ни у кого в группе нет камня души. Нажмите, чтобы создать его."
L["BUFF_WINDOW_TOOLTIP_GROUP"] =
	"Нажмите, чтобы применить к игроку %s и его группе."
L["BUFF_WINDOW_TOOLTIP_FAVOR"] =
	"Нажмите, чтобы выбрать игрока %s целью и применить."
L["BUFF_WINDOW_TOOLTIP_DISMISS"] = "Правый клик, чтобы убрать игрока %s из списка."
-- The window's close button: the class name in its color, then the options command.
L["BUFF_WINDOW_CLOSED"] =
	"Дежурство по баффам выключено для класса %s. Чтобы включить его снова, нажмите Shift + Правый клик по кнопке у миникарты или введите %s."

-- The Buff Key (Key Bindings, and the Keybinds section of Buff Duty)
L["BUFF_KEYS_HEADER"] = "Клавиши"
L["BUFF_KEYS_DESCRIPTION"] =
	"Накладывайте следующий бафф из списка одной клавишей или макросом вне боя. Баффы оружия по-прежнему наносятся щелчком в окне."
L["BUFF_KEY"] = "Кнопка баффов"
L["BUFF_KEY_DESCRIPTION"] =
	"Накладывает следующий недостающий бафф, по одному за нажатие: воскрешение мертвой цели, затем мертвых в вашей группе (жрецы, паладины и шаманы), затем баффы на себя, Ответная любезность, ваша цель и ваша группа. Группа получает групповой бафф, если он стоит меньше маны, чем баффать по одному всех в радиусе действия."
L["BUFF_KEY_SKIP_COOLDOWNS"] = "Пропускать баффы с перезарядкой"
L["BUFF_KEY_SKIP_COOLDOWNS_DESCRIPTION"] =
	"Пропускает баффы с перезарядкой (например, Защита от страха) и переходит к следующему."
-- %s is a player's name.
L["BUFF_KEY_WAITING"] = "Ожидание, пока игрок %s окажется в радиусе действия."
L["BUFF_KEY_DONE"] = "Больше нечего накладывать."
-- The caption beside the read-only box that holds a Buff Key's macro line.
L["BUFF_KEY_MACRO_CAPTION"] = "Макрос"

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
