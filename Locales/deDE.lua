local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "deDE")
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
	"Version %s. Einstellungen (einschließlich der Option, diese Nachricht zu deaktivieren) findet Ihr unter Optionen > AddOns > Thanks for the Buff (TFTB). Gefällt Euch dieses Add-on? Erzählt einem Freund davon, markiert es auf CurseForge als Favorit oder vergebt auf GitHub einen Star. (="
L["CHAT_OPTIONS_IN_COMBAT"] =
	"Aus Sicherheitsgründen kann das Optionsmenü während des Kampfes nicht geöffnet werden."

-- Buff print out
L["MESSAGE_BUFFED"] = "%s hat Euch mit %s gebufft!"

-- Thank You Button
L["MESSAGE_SELECT_PLAYER"] = "Nehmt zuerst einen Spieler ins Ziel."
L["MESSAGE_CANT_THANK_SELF"] = "Ihr könnt Euch nicht selbst danken!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Unbekannter Zauber"
L["SAMPLE_EXAMPLE"] = "Beispiel: %s"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Willkommensnachricht aktivieren"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Gibt beim Einloggen eine Nachricht aus, die nur Ihr seht."
L["OPTIONS_DESCRIPTION"] =
	"Bedankt Euch automatisch per Emote oder Flüstern bei Spielern, die Euch buffen, sagt Spielern, was Ihr gerade auf sie gewirkt habt, grüßt Freunde und Gildenmitglieder im Vorbeigehen mit einem Winken und dankt mit einem Klick auf Eure Dankeschön-Makros jedem, den Ihr anvisiert."
L["OPTIONS_FEATURES_HEADER"] = "Funktionen"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Schaltet jede Funktion hier oder auf ihrer eigenen Seite ein oder aus."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Öffnet das Optionsmenü dieses Add-ons."

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "Sucht Ihr andere Funktionen?"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"Einige Funktionen sind in unser neues Add-on Good to Go umgezogen. Ihr findet es auf CurseForge oder Wago."

--------------------------------------------------------------------------------
-- Options: Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "Helft Thanks for the Buff (TFTB) beim Stufenaufstieg"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"Dieses Add-on wurde von Spielern entwickelt, die dieses Spiel lieben und es für alle so unterhaltsam wie möglich machen wollen. Wir werden niemals um Spenden bitten. Die wahre Genugtuung liegt im Wissen, dass unsere Arbeit Euch das Spiel ein wenig besser macht. Wenn das so ist, würden wir gern davon hören!"
L["OPTIONS_LEVEL_UP_WAYS"] = "Hier sind ein paar Möglichkeiten, wie Ihr uns helfen könnt, mehr Spieler zu erreichen."
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• Feedback geben: Einen Fehler gefunden oder eine Idee? Sagt es uns auf Discord. Euer Feedback hilft uns, das Add-on zu verbessern, und Pull Requests sind jederzeit willkommen."
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• Einem Freund erzählen: Kennt Ihr jemanden, dem dieses Add-on gefallen könnte? Erzählt ihm davon. Mundpropaganda hilft mehr Spielern, großartige Add-ons zu entdecken."
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	"• Auf CurseForge favorisieren: Öffnet unten den CurseForge-Link, meldet Euch an und klickt auf den Stern unter dem Download-Button. Favoriten helfen mehr Spielern, das Add-on zu entdecken."
L["OPTIONS_LEVEL_UP_GITHUB"] =
	"• Star auf GitHub: Öffnet unten den GitHub-Link, meldet Euch an und klickt oben rechts auf Star. Stars helfen dem Projekt, sich für weitere kostenlose Entwicklerwerkzeuge zu qualifizieren."
L["OPTIONS_LEVEL_UP_THANKS"] = "Danke, dass Ihr Euch für Thanks for the Buff (TFTB) entschieden habt!"

L["OPTIONS_FEEDBACK"] = "Feedback & Unterstützung"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "Links für Feedback & Unterstützung"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "Um einen Link zu kopieren, klickt in sein Feld und drückt dann Strg+A und Strg+C."
L["OPTIONS_VERSION"] = "Version %s"

--------------------------------------------------------------------------------
-- Options: Give Thanks
--------------------------------------------------------------------------------

L["TAB_GIVE_THANKS"] = "Danksagung"
L["GIVE_THANKS_ENABLE"] = "Danksagung aktivieren"
L["GIVE_THANKS_ENABLE_DESCRIPTION"] = "Aktiviert den Dank für Buffs von Spielern außerhalb Eurer Gruppe."
L["GIVE_THANKS_DESCRIPTION"] = "Dankt Spielern außerhalb Eurer Gruppe, wenn sie Euch in der offenen Welt buffen."

-- Praise Limits
L["PRAISE_HEADER"] = "Lob-Grenzen"
L["PRAISE_DESCRIPTION"] =
	"Diese Einstellungen halten Emote und Flüstern gleichermaßen zurück, damit aus einer Welle von Buffs nie Spam wird."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["GIVE_THANKS_OVERALL_COOLDOWN"] = "Lob-Abklingzeit"
L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Legt die Verzögerung zwischen einer Lobrunde und der nächsten fest, ganz gleich, wer Euch gebufft hat. Bei null wird jeder Buff gelobt."
L["GIVE_THANKS_SOURCE_COOLDOWN"] = "Lob-Abklingzeit für denselben Spieler"
L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Legt die Verzögerung fest, bevor derselbe Spieler erneut gelobt wird. Bei null wird jeder Buff gelobt."
L["GIVE_THANKS_MIN_DURATION"] = "Minimale Buff-Dauer"
L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"] =
	"Ignoriert Buffs, die kürzer als dieser Wert sind. Bei null wird auf jeden Buff reagiert."
L["PRAISE_DELAY_ENABLE"] = "Lob-Verzögerung aktivieren"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Wartet einen Moment vor dem Flüstern und dem Emote, damit Euer Dank nicht im selben Augenblick wie der Buff eintrifft. Benachrichtigungen bleiben unberührt."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Legt fest, wie lange gewartet wird, bevor Flüstern und Emote gesendet werden."

-- Give Thanks Whisper
L["GIVE_THANKS_WHISPER_HEADER"] = "Danksagungs-Flüstern"
L["GIVE_THANKS_WHISPER_ENABLE"] = "Danksagungs-Flüstern aktivieren"
L["PRAISE_WHISPER_DESCRIPTION"] = "Flüstert dem Spieler, der Euch gebufft hat, ein Dankeschön zu."
-- TRANSLATORS: keep {spell} and {name} exactly as written; they are the tokens players type into the whisper.
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"Legt fest, was TFTB dem Spieler zuflüstert, der Euch gebufft hat. {spell} wird durch den Buff ersetzt, {name} durch seinen Namen. Bleibt das Feld leer, wird nichts geflüstert."

-- Notifications
L["NOTIFICATIONS_HEADER"] = "Benachrichtigungen"
L["NOTIFICATIONS_DESCRIPTION"] = "Was nur Ihr bekommt: eine Textmeldung, einen Ton oder beides."
L["NOTIFICATIONS_PRINT_ENABLE"] = "Textmeldungen aktivieren"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Gibt eine Nachricht aus, die nur Ihr seht, wenn Ihr einen Buff erhaltet."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Soundeffekte aktivieren"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Spielt einen Ton ab, wenn Ihr einen Buff erhaltet. Nur Ihr hört ihn."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] =
	"Spielt den Ton ab, damit Ihr ihn hören könnt, bevor Ihr ihn aktiviert."

--------------------------------------------------------------------------------
-- Options: Good News
--------------------------------------------------------------------------------

L["TAB_GOOD_NEWS"] = "Gute Neuigkeiten"
L["GOOD_NEWS_ENABLE"] = "Gute Neuigkeiten aktivieren"
L["GOOD_NEWS_ENABLE_DESCRIPTION"] = "Aktiviert ein Flüstern, das Spielern sagt, was Ihr gerade auf sie gewirkt habt."
L["GOOD_NEWS_DESCRIPTION"] =
	"Lasst Spieler wissen, was Ihr gerade auf sie gewirkt habt und bei kurzen Buffs, wie lange es anhält, damit sie das Beste daraus machen können."
L["GOOD_NEWS_SCOPE"] = "Wer es bekommt"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Legt fest, wer ein Flüstern von Gute Neuigkeiten bekommt: jeder, auf den Ihr eine verfolgte Fähigkeit wirkt, oder nur Eure Gruppe oder Euer Schlachtzug."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Jeder"
L["GOOD_NEWS_SCOPE_GROUP"] = "Nur Gruppenmitglieder"
L["GOOD_NEWS_WHISPER_HEADER"] = "Flüstern für Gute Neuigkeiten"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Was der Spieler erhält, auf den Ihr wirkt. Nur die unter Verfolgte Fähigkeiten angehakten Fähigkeiten senden eines."
-- TRANSLATORS: keep {spell} and {name} exactly as written; they are the tokens players type into the whisper.
L["GOOD_NEWS_MESSAGE_DESCRIPTION"] =
	"Legt fest, was TFTB dem Spieler zuflüstert, auf den Ihr wirkt. {spell} wird durch das Gewirkte ersetzt, samt Dauer, wenn sie unter einer Minute liegt, {name} durch seinen Namen. Bleibt das Feld leer, wird nichts geflüstert."
-- TRANSLATORS: each %s is a token, {spell} then {name}, drawn in blue.
L["GOOD_NEWS_TOKENS"] = "Platzhalter: %s was Ihr wirkt, %s wer es bekommen hat"

-- Tracked Abilities
L["TAB_GOOD_NEWS_ABILITIES"] = "Verfolgte Fähigkeiten"
L["GOOD_NEWS_ABILITIES_DESCRIPTION"] =
	"Gute Neuigkeiten flüstert über die hier angehakten Fähigkeiten, wenn Ihr sie auf einen anderen Spieler wirkt."
-- The heading over the rows no class owns: scrolls, and abilities cast by a trinket's pet.
L["GOOD_NEWS_ITEMS"] = "Gegenstände"

--------------------------------------------------------------------------------
-- Options: Emotes List
--------------------------------------------------------------------------------

L["TAB_EMOTES_LIST"] = "Emote-Liste"
L["EMOTES_GRID_DESCRIPTION"] =
	"Hakt die Emotes an, aus denen die Danksagung wählen darf, wenn Euch ein Spieler außerhalb Eurer Gruppe bufft; sie nimmt jeweils eines zufällig. Emotes werden zurückgehalten, solange Ihr im Kampf seid, zaubert oder angelt."

--[[
    The emote checklist, shared by this panel and Wave to Friends' Friends and
    Guilds tabs. Its group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS
    entry, upper-cased.
]]
L["EMOTE_GROUP_COUNT"] = "%s (%d von %d ausgewählt)"
L["EMOTE_GROUP_TEXT"] = "Text"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "Zeigt nur die Emote-Zeile."
L["EMOTE_GROUP_GESTURE"] = "Geste"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "Spielt eine kurze Animation ab."
L["EMOTE_GROUP_VOICE"] = "Stimme"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "Spielt eine Sprachzeile ab."
L["EMOTE_GROUP_POSE"] = "Pose"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "Bleibt, bis Ihr Euch bewegt."
L["EMOTES_RESET"] = "Emotes zurücksetzen"
L["EMOTES_RESET_DESCRIPTION"] = "Setzt die Liste auf die Standard-Dankesemotes zurück."
L["EMOTES_RESET_CONFIRM"] = "Die Emote-Liste auf die Standardwerte zurücksetzen?"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "Ignorierte Buffs"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"Für Buffs auf dieser Liste gibt es nie ein Dankeschön, ganz gleich, wer sie wirkt. Eure Textmeldung und Euren Ton bekommt Ihr trotzdem."
L["IGNORED_BUFFS_ADD_RECENT"] = "Kürzlichen Buff ignorieren"
L["IGNORED_BUFFS_ADD_RECENT_DESCRIPTION"] =
	"Fügt einen Buff hinzu, der gerade auf Euch wirkt oder den Euch seit dem Einloggen ein anderer Spieler gegeben hat."
-- The first %s is the buff's icon and name, the second the player who cast it.
L["IGNORED_BUFFS_RECENT_FROM"] = "%s, von %s"
L["IGNORED_BUFFS_ADD"] = "Buff hinzufügen"
L["IGNORED_BUFFS_ADD_DESCRIPTION"] =
	"Gebt eine Zauber-ID ein oder fügt den Link eines Buffs per Shift-Klick in das Feld ein und drückt dann die Eingabetaste."
L["IGNORED_BUFFS_EMPTY"] = "Noch keine Buffs ignoriert. Fügt oben einen hinzu."
L["IGNORED_BUFFS_REMOVE"] = "Entfernt diesen Buff von der Liste."
L["IGNORED_BUFFS_NOT_FOUND"] = "Kein Buff für %s gefunden."
L["IGNORED_BUFFS_ALL_CHARACTERS"] = "Alle Charaktere"
L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"] =
	'Verschiebt diesen Buff in die Liste "Alle Charaktere", sodass er auf keinem Charakter mehr ein Dankeschön bekommt.'

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Dankeschön-Knopf"
L["BUTTON_DESCRIPTION"] =
	"Flüstert Eurem Ziel zu und bedenkt es mit einem Emote, alles mit einem einzigen Tastendruck. Höflichkeit, automatisiert."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Dankeschön-Knopf %d"
L["BUTTON_EMOTE"] = "Emote"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Legt das Emote fest, das dieser Knopf bei Eurem Ziel ausführt, oder Keine für kein Emote."
L["BUTTON_EMOTE_NONE"] = "Keine"
-- Titles Thank You Button 1's emote checklist.
L["EMOTES_SELECT"] = "Emotes auswählen"
L["BUTTON_ICON"] = "Symbol"
L["BUTTON_ICON_DESCRIPTION"] =
	"Legt das Symbol fest, das das Makro dieses Knopfes in Eurer Makroliste und auf Euren Aktionsleisten zeigt."
-- The Icon dropdown's first choice, the macros' own icon; every other choice is a picture alone.
L["BUTTON_ICON_DEFAULT"] = "Standard"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Makro "%s" aktivieren'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] =
	"Erstellt ein Makro namens %s und löscht es wieder, sobald Ihr dies ausschaltet."
L["BUTTON_WHISPER_DESCRIPTION"] =
	"Legt fest, was dieser Knopf Eurem Ziel zuflüstert. Bleibt das Feld leer, wird nichts geflüstert."

--------------------------------------------------------------------------------
-- Options: Wave to Friends
--------------------------------------------------------------------------------

L["TAB_WAVE_TO_FRIENDS"] = "Freundesgruß"
L["WAVE_ENABLE"] = "Freundesgruß aktivieren"
L["WAVE_ENABLE_DESCRIPTION"] =
	"Aktiviert ein Emote für Freunde und Gildenmitglieder, wenn Ihr mit der Maus über sie fahrt."
L["WAVE_DESCRIPTION"] =
	"Grüßt Freunde und Gildenmitglieder draußen in der Welt mit einem Emote, wenn Ihr mit der Maus über sie fahrt."
L["WAVE_RULES"] = "Nie Eure Gruppe oder Euren Schlachtzug, und nie, solange Ihr im Kampf seid, zaubert oder angelt."
L["WAVE_RESTING_ENABLE"] = "Nur beim Ausruhen"
L["WAVE_RESTING_ENABLE_DESCRIPTION"] = "Winkt nur, während Ihr Euch ausruht, in einer Stadt oder einem Gasthaus."
L["WAVE_COOLDOWN"] = "Abklingzeit für denselben Spieler"
L["WAVE_COOLDOWN_DESCRIPTION"] = "Legt fest, wie lange es dauert, bis derselbe Spieler erneut begrüßt werden kann."
L["WAVE_COOLDOWN_ONCE_PER_SESSION"] = "Einmal pro Sitzung"
-- %s is the default emotes' slash commands, as the client names them.
L["WAVE_EMOTES_RESET_DEFAULTS_DESCRIPTION"] = "Setzt die Liste auf ausschließlich %s zurück."

-- Custom List
L["WAVE_TAB_CUSTOM"] = "Eigene Liste"
L["WAVE_CUSTOM_DESCRIPTION"] =
	"Spieler, die immer ihr eigenes Emote bekommen, sogar vor Freunden und Gilden. Wählt Keine, um jemanden nie mit einem Emote zu bedenken."
-- One of these two follows WAVE_CUSTOM_DESCRIPTION: realm clients, then WoW Forever, which has no realms.
L["WAVE_CUSTOM_NAMES_REALM"] = "Name-Realm passt nur auf diesen Realm; ein Name ohne Realm passt auf jeden Realm."
L["WAVE_CUSTOM_NAMES_FOREVER"] =
	"Ein vollständiger Name passt auf einen Charakter; ein Vorname allein passt auf alle, die ihn tragen."
L["WAVE_CUSTOM_ENABLE"] = "Eigene Liste aktivieren"
L["WAVE_CUSTOM_ENABLE_DESCRIPTION"] = "Verwendet die Namen unten vor Freunden und Gilden."
L["WAVE_CUSTOM_OFF_WARNING"] = "Die eigene Liste ist aus, daher bekommt niemand unten sein Emote."
L["WAVE_CUSTOM_ADD"] = "Spieler hinzufügen"
L["WAVE_CUSTOM_ADD_DESCRIPTION"] =
	"Gebt einen Namen oder Name-Realm ein und drückt dann die Eingabetaste. Trennt mehrere Namen mit Kommas."
L["WAVE_CUSTOM_ADD_DESCRIPTION_FOREVER"] =
	"Gebt einen vollständigen Namen oder einen Vornamen ein und drückt dann die Eingabetaste. Trennt mehrere Namen mit Kommas."
L["WAVE_CUSTOM_EMPTY"] = "Noch keine Spieler. Fügt oben einen hinzu."
L["WAVE_CUSTOM_EMOTE_DESCRIPTION"] =
	"Legt das Emote für diesen Spieler fest, oder Keine, um ihn nie mit einem Emote zu bedenken."
L["WAVE_CUSTOM_REMOVE"] = "Entfernt diesen Spieler von der Liste."

-- Friends
L["WAVE_TAB_FRIENDS"] = "Freunde"
L["WAVE_FRIENDS_ENABLE"] = "Freunden zuwinken"
L["WAVE_FRIENDS_ENABLE_DESCRIPTION"] = "Grüßt Charaktere auf Eurer Freundesliste."
L["WAVE_BNET_ENABLE"] = "Battle.net-Freunde einbeziehen"
L["WAVE_BNET_ENABLE_DESCRIPTION"] = "Grüßt auch die Charaktere, die Eure Battle.net-Freunde gerade spielen."
L["WAVE_FRIENDS_EMOTES_DESCRIPTION"] =
	"Hakt die Emotes an, aus denen für Freunde gewählt wird; jeweils eines wird zufällig genommen."

-- Guilds
L["WAVE_TAB_GUILDS"] = "Gilden"
L["WAVE_MY_GUILD_ENABLE"] = "Meiner Gilde zuwinken"
L["WAVE_MY_GUILD_ENABLE_DESCRIPTION"] = "Grüßt Mitglieder der Gilde, in der Ihr seid."
L["WAVE_GUILD_ADD"] = "Gilde hinzufügen"
L["WAVE_GUILD_ADD_DESCRIPTION"] =
	"Gebt den Namen einer Gilde ein und drückt dann die Eingabetaste. Trennt mehrere Gilden mit Kommas. Groß- und Kleinschreibung spielt keine Rolle."
L["WAVE_GUILDS_EMPTY"] = "Noch keine anderen Gilden. Fügt oben eine hinzu."
L["WAVE_GUILD_REMOVE"] = "Entfernt diese Gilde von der Liste."
L["WAVE_GUILDS_EMOTES_DESCRIPTION"] =
	"Hakt die Emotes an, aus denen für Gildenmitglieder gewählt wird; jeweils eines wird zufällig genommen."

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks, Good News and each Thank You Button.
L["WHISPER_MESSAGE"] = "Flüsternachricht"
L["WHISPER_MESSAGE_RESET"] = "Zurücksetzen"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Setzt die Flüsternachricht auf den Standardtext zurück."

-- The whisper composer around every editable whisper's box, on Give Thanks and Good News.
L["SEND_MESSAGES_IN"] = "Nachrichten senden auf"
L["SEND_MESSAGES_IN_DESCRIPTION"] =
	"Legt fest, in welcher Sprache TFTB anderen Spielern schreibt. Bei einer anderen Sprache wird deren Standardtext eingesetzt, außer Ihr habt einen eigenen geschrieben."
L["WHISPER_SIGN_OFF_DESCRIPTION"] =
	"Wird an jede Nachricht von TFTB angehängt, damit andere Spieler erkennen, dass sie von einem Add-on stammt."
-- TRANSLATORS: each %s is a token, {spell} then {name}, drawn in blue.
L["WHISPER_TOKENS"] = "Platzhalter: %s der Buff, %s wer ihn gewirkt hat"
L["WHISPER_TOO_LONG"] = "Zu lang, daher wird stattdessen der Standardtext gesendet."
L["WHISPER_TEST"] = "Test an mich senden"
L["WHISPER_TEST_DESCRIPTION"] = "Flüstert Euch das Beispiel zu, damit Ihr es genau so seht wie andere Spieler."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

-- The Thank You Button whisper's default, in the client's own language; Give Thanks' and Good News' defaults live in Data/Message-Languages.lua.
L["DEFAULT_WHISPER"] = "Danke, du bist spitze! (="
