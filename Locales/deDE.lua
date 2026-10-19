local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "deDE")
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
	"Version %s. Einstellungen (einschließlich der Option, diese Nachricht zu deaktivieren) findet Ihr unter Optionen > AddOns > Thanks for the Buff (TFTB). Gefällt Euch dieses Add-on? Erzählt einem Freund davon, markiert es auf CurseForge als Favorit oder vergebt auf GitHub einen Star. (="
L["CHAT_OPTIONS_IN_COMBAT"] =
	"Aus Sicherheitsgründen kann das Optionsmenü während des Kampfes nicht geöffnet werden."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s hat Euch mit %s gebufft!"
L["MESSAGE_GAVE_YOU"] = "%s hat Euch %s gegeben!"
L["MESSAGE_GAVE_GROUP"] = "%s hat Eurer Gruppe %s gegeben!"
L["MESSAGE_USED_ITEM"] = "%s hat %s bei Euch benutzt!"
L["MESSAGE_USED_SPELL"] = "%s hat %s auf Euch gewirkt!"
L["MESSAGE_SET_OUT"] = "%s hat %s aufgestellt!"
L["MESSAGE_OPENED"] = "%s hat %s geöffnet!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Danke für %s"
L["MESSAGE_SELECT_PLAYER"] = "Nehmt zuerst einen Spieler ins Ziel."
L["MESSAGE_CANT_THANK_SELF"] = "Ihr könnt Euch nicht selbst danken!"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "%s hat %s eingesetzt!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s hat %s auf %s eingesetzt!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Unbekannter Zauber"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Willkommensnachricht aktivieren"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Gibt beim Einloggen eine Nachricht aus, die nur Ihr seht."
L["OPTIONS_DESCRIPTION"] =
	"Bedankt Euch per Flüstern oder Emote bei jedem Spieler, der Euch bufft, und seht in einem Buff-Tracker, wem Eure Schlachtzugsbuffs fehlen, und wirkt sie per Klick. Dazu Benachrichtigungen für Festmähler, Portale, Beschwörungen, Seelenbrunnen und Abklingzeiten Eurer Klasse. Gute Manieren, automatisiert."
L["OPTIONS_FEATURES_HEADER"] = "Funktionen"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Schaltet jede Funktion hier oder auf ihrer eigenen Seite ein oder aus."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Öffnet das Optionsmenü dieses Add-ons."
L["OPTIONS_EXAMPLE"] = "Beispiel: %s"

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
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Stranger Buffs
L["TAB_STRANGERS"] = "Buffs von Fremden"
L["STRANGERS_ENABLE"] = "Dank für Buffs von Fremden aktivieren"
L["STRANGERS_ENABLE_DESCRIPTION"] = "Aktiviert den Dank für Buffs von Spielern außerhalb Eurer Gruppe."
L["STRANGERS_DESCRIPTION"] = "Dankt Spielern außerhalb Eurer Gruppe, wenn sie Euch in der offenen Welt buffen."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "Lob-Abklingzeit"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Legt die Verzögerung zwischen einer Lobrunde und der nächsten fest, ganz gleich, wer Euch gebufft hat. Bei null wird jeder Buff gelobt."
L["STRANGERS_SOURCE_COOLDOWN"] = "Lob-Abklingzeit für denselben Spieler"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Legt die Verzögerung fest, bevor derselbe Spieler erneut gelobt wird. Bei null wird jeder Buff gelobt."
L["STRANGERS_MIN_DURATION"] = "Minimale Buff-Dauer"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Ignoriert Buffs, die kürzer als dieser Wert sind. Bei null wird auf jeden Buff reagiert."

-- Teammate Buffs
L["TAB_TEAMMATES"] = "Buffs von Teammitgliedern"
L["TEAMMATES_ENABLE"] = "Dank für Buffs von Teammitgliedern aktivieren"
L["TEAMMATES_ENABLE_DESCRIPTION"] =
	"Aktiviert den Dank für Buffs und Abklingzeiten, die Eure Gruppen- oder Schlachtzugsmitglieder auf Euch wirken."
L["TEAMMATES_DESCRIPTION"] =
	"Dankt Gruppen- und Schlachtzugsmitgliedern für Buffs und Abklingzeiten, die sie auf Euch wirken."

-- Service Alerts
L["TAB_SERVICES"] = "Dienst-Hinweise"
L["SERVICES_ENABLE"] = "Dienst-Hinweise aktivieren"
L["SERVICES_ENABLE_DESCRIPTION"] =
	"Aktiviert Hinweise zu Festmählern, Seelenbrunnen, Portalen und anderer Hilfe, die für Eure Gruppe aufgestellt wird."
L["SERVICES_DESCRIPTION"] =
	"Reagiert, wenn jemand Hilfe für Eure Gruppe aufstellt: Festmähler, Seelenbrunnen, Portale und Reparaturbots."

-- Send Good News
L["TAB_GOOD_NEWS"] = "Gute Neuigkeiten senden"
L["GOOD_NEWS_DESCRIPTION"] =
	"Lasst die Spieler, die Ihr bufft, wissen, was Ihr auf sie gewirkt habt und wie lange es anhält."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Gute Neuigkeiten aktivieren"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] = "Flüstert dem gebufften Spieler zu, was er erhalten hat und wie lange es anhält."
L["GOOD_NEWS_SCOPE"] = "Empfänger"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Jeder, den Ihr bufft"
L["GOOD_NEWS_SCOPE_GROUP"] = "Nur Gruppenmitglieder"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Legt fest, wer die Guten Neuigkeiten zugeflüstert bekommt: jeder, den Ihr bufft, oder nur Eure Gruppenmitglieder."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Nachricht für Gute Neuigkeiten"
L["GOOD_NEWS_MESSAGES_DESCRIPTION"] = "Das Flüstern, das die Spieler erhalten, die Ihr bufft."
--[[
    Two halves so the number stays authoritative: LIMIT's %d is a real placeholder
    and gets formatted, TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_LIMIT"] = "Maximale Länge: %d."
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a wird zum Fähigkeitslink."
--[[
    Appended to the ability link inside %a when the buff has a readable duration.
    A whole clause rather than a bare number so it can be reworded per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "für %s"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Gruppenzwang"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Werdet benachrichtigt, wenn andere Spieler Eurer Klasse ihre Abklingzeiten einsetzen, damit Ihr dem Gruppenzwang nachgeben könnt."
L["PEER_PRESSURE_ENABLE"] = "Gruppenzwang aktivieren"
L["PEER_PRESSURE_ENABLE_DESCRIPTION"] =
	"Aktiviert Hinweise, wenn ein anderer Spieler Eurer Klasse eine verfolgte Abklingzeit einsetzt."
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Gibt eine Nachricht aus, die nur Ihr seht, wenn eine Abklingzeit Eurer Klasse eingesetzt wird."
L["PEER_PRESSURE_OWN_CASTS"] = "Bei eigenen Zaubern auslösen"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Löst auch aus, wenn Ihr Eure eigenen Abklingzeiten einsetzt, nicht nur bei anderen Spielern."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Spielt einen Ton ab, wenn eine Abklingzeit Eurer Klasse eingesetzt wird. Nur Ihr hört ihn."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Verfolgte Fähigkeiten"
L["TRACKED_GROUP_ITEMS"] = "Gegenstände"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Schaltet die Verfolgung von %s ein oder aus."
L["TRACKED_ITEM_PENDING"] = "Gegenstand #%d"
L["TRACKED_SPELL_PENDING"] = "Zauber #%d"

-- Shared by Send Good News and the Thank You Button
L["WHISPER_MESSAGE"] = "Flüsternachricht"
L["WHISPER_MESSAGE_RESET"] = "Zurücksetzen"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Setzt die Flüsternachricht auf den Standardtext zurück."

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "Dankesflüstern & Emotes"
L["NOTIFICATIONS_HEADER"] = "Benachrichtigungen"
L["PRAISE_DESCRIPTION"] = "Was der andere Spieler sieht: ein Dankesflüstern, ein Emote oder beides."
L["NOTIFICATIONS_DESCRIPTION"] = "Was nur Ihr bekommt: eine Textmeldung, einen Ton oder beides."

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "Emotes auswählen"

L["PRAISE_WHISPER_ENABLE"] = "Dankesflüstern aktivieren"
L["PRAISE_WHISPER_DESCRIPTION"] = "Flüstert dem Spieler, der Euch gebufft hat, ein Dankeschön zu."
L["PRAISE_EMOTES_ENABLE"] = "Emotes aktivieren"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Zeigt Eure Wertschätzung mit einem Emote. Emotes werden zurückgehalten, solange Ihr im Kampf seid."
L["PRAISE_DELAY_ENABLE"] = "Lob-Verzögerung aktivieren"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Wartet einen Moment vor dem Flüstern und dem Emote, damit Euer Dank nicht im selben Augenblick wie der Buff eintrifft. Benachrichtigungen bleiben unberührt."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Legt fest, wie lange gewartet wird, bevor Flüstern und Emote gesendet werden."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Textmeldungen aktivieren"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Gibt eine Nachricht aus, die nur Ihr seht, wenn Ihr einen Buff erhaltet."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Soundeffekte aktivieren"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Spielt einen Ton ab, wenn Ihr einen Buff erhaltet. Nur Ihr hört ihn."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] =
	"Spielt den Ton ab, damit Ihr ihn hören könnt, bevor Ihr ihn aktiviert."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups that no single game record names
    (Data/{Game}/Tracked-Abilities-{Game}.lua). Single spells and items, and a
    group named after one of its own items, take their names from the client.
]]
L["GROUP_PORTALS"] = "Portale"
L["GROUP_RESISTANCE_CAULDRONS"] = "Widerstandskessel"
L["GROUP_REPAIR_BOTS"] = "Reparaturbots"

--------------------------------------------------------------------------------
-- Options: Buff Duty
--------------------------------------------------------------------------------

L["TAB_BUFF_WINDOW"] = "Buff-Dienst"
L["BUFF_WINDOW_DESCRIPTION"] = "Zeigt, wem Eure Buffs fehlen. Klickt auf ein Symbol, um zu wirken."
L["BUFF_WINDOW_ENABLE"] = "Buff-Dienst aktivieren"
L["BUFF_WINDOW_ENABLE_DESCRIPTION"] =
	"Aktiviert den Buff-Dienst, das Fenster mit den Gruppenmitgliedern, denen ein Buff fehlt, den Ihr geben könnt."
L["BUFF_WINDOW_NO_BUFFS"] =
	"Eure Klasse hat keine Buffs auf dieser Liste, daher erscheint das Fenster bei diesem Charakter nie."
L["BUFF_WINDOW_HEADER"] = "Fenster"
L["BUFF_WINDOW_WINDOW_DESCRIPTION"] =
	"Lasst das Fenster dort, wo Ihr es abgelegt habt, oder haltet es im Kampf aus dem Weg."
L["BUFF_WINDOW_LOCK"] = "Fenster sperren"
L["BUFF_WINDOW_LOCK_DESCRIPTION"] =
	"Verhindert, dass das Fenster verschoben wird. Entsperrt lässt es sich an seinem Hintergrund ziehen."
L["BUFF_WINDOW_HIDE_IN_COMBAT"] = "Im Kampf ausblenden"
L["BUFF_WINDOW_HIDE_IN_COMBAT_DESCRIPTION"] =
	"Blendet das Fenster während des Kampfes aus. Im Kampf kann die Liste nicht aktualisiert werden, daher behält ein sichtbar gelassenes Fenster seinen letzten Stand, bis der Kampf endet."
L["BUFF_WINDOW_SHOW_HEADER"] = "Im Fenster anzeigen"
L["BUFF_WINDOW_SHOW_DESCRIPTION"] =
	"Fügt dem Fenster Eure eigenen Buffs, die Fremden, die Euch gebufft haben, und Euer Ziel hinzu."
L["BUFF_WINDOW_FAVOR_ENABLE"] = "Gefallen erwidern"
L["BUFF_WINDOW_FAVOR_ENABLE_DESCRIPTION"] =
	"Listet die Fremden auf, die Euch kürzlich gebufft haben, samt den Buffs, die Ihr ihnen zurückgeben könnt. Rechtsklickt auf ein Symbol, um jemanden von der Liste zu nehmen."
L["BUFF_WINDOW_FAVOR_SECONDS_DESCRIPTION"] =
	"Legt fest, wie lange ein Fremder nach seinem letzten Buff auf der Liste bleibt."
L["BUFF_WINDOW_TARGET_ENABLE"] = "Euer Ziel"
L["BUFF_WINDOW_TARGET_ENABLE_DESCRIPTION"] =
	"Listet Euer Ziel auf, wenn es ein Spieler außerhalb Eurer Gruppe ist, dem ein Buff fehlt, den Ihr geben könnt."
L["BUFF_WINDOW_REFRESH"] = "Auffrischen unter"
L["BUFF_WINDOW_REFRESH_DESCRIPTION"] =
	"Legt fest, wie wenig Restzeit ein Buff haben darf, bevor er als fehlend gilt, damit Ihr ihn auffrischen könnt, bevor er ausläuft. Ein Buff, der nicht länger als diese Zeit hält, zählt erst, wenn er abgelaufen ist."
L["BUFF_WINDOW_PETS_AS_TANKS"] = "Begleiter als Tanks werten"
L["BUFF_WINDOW_PETS_AS_TANKS_DESCRIPTION"] =
	"Bietet Begleitern die Buffs an, die Ihr auf Tanks gestellt habt, etwa Dornen, zusätzlich zu denen für Alle."
L["BUFF_WINDOW_PETS_AS_TANKS_WHEN_DESCRIPTION"] = "Legt fest, wann Begleiter als Tanks gelten."
L["BUFF_WINDOW_PETS_AS_TANKS_SOLO"] = "Wenn nicht in einer Gruppe"
L["BUFF_WINDOW_PETS_AS_TANKS_ALWAYS"] = "Immer"
-- Who each buff is offered to: one dropdown per buff, these four choices.
L["BUFF_WINDOW_AUDIENCE_OFF"] = "Aus"
L["BUFF_WINDOW_AUDIENCE_TANK"] = "Tanks"
L["BUFF_WINDOW_AUDIENCE_HEALER"] = "Heiler"
L["BUFF_WINDOW_AUDIENCE_ALL"] = "Alle"
-- The dropdown's tooltip when the client has no description for the spell yet.
L["BUFF_WINDOW_AUDIENCE_DESCRIPTION"] = "Legt fest, wem %s angeboten wird."
L["BUFF_WINDOW_BUFFS_DESCRIPTION"] =
	"Wählt für jeden Buff, wem er angeboten wird. Tanks und Heiler richten sich nach der Gruppenrolle oder, wenn keine gesetzt ist, nach der Klasse."

L["BUFF_WINDOW_SELF_DESCRIPTION"] = "Eure eigenen Buffs, oben im Fenster angeheftet."
--[[
    Muted note after a class name on the Self-Buffs panel, for a family of self
    buffs only one of which can be up at a time. Keyed by the family.
]]
L["BUFF_WINDOW_SELF_NOTE_ASPECT"] = "ein beliebiger Aspekt genügt"
L["BUFF_WINDOW_SELF_NOTE_MAGE_ARMOR"] = "eine beliebige Rüstung genügt"
L["BUFF_WINDOW_SELF_NOTE_PALADIN_AURA"] = "eine beliebige Aura genügt"
L["BUFF_WINDOW_SELF_NOTE_SHAMAN_SHIELD"] = "ein beliebiger Schild genügt"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_ARMOR"] = "eine beliebige Rüstung genügt"
L["BUFF_WINDOW_SELF_REFRESH_OFF"] = "Aus"
L["BUFF_WINDOW_SELF_REFRESH_MISSING"] = "Bei Fehlen"
-- %s is a duration from the client, like "5 Minutes".
L["BUFF_WINDOW_SELF_REFRESH_UNDER"] = "Unter %s"
L["BUFF_WINDOW_SELF_REFRESH_DESCRIPTION"] =
	"Legt fest, wann %s angezeigt wird: nie, nach dem Ablaufen oder wenn weniger als diese Zeit übrig ist."
L["BUFF_WINDOW_SELF_ENABLE"] = "Eure Selbstbuffs"
L["BUFF_WINDOW_SELF_ENABLE_DESCRIPTION"] =
	"Zeigt oben im Fenster die Buffs, die nur Ihr Euch selbst geben könnt, etwa eine Rüstung oder Inneres Feuer, wenn sie fehlen oder bald ablaufen. Welche, legt Ihr unter Selbstbuffs fest."

-- The window itself
L["BUFF_WINDOW_SELF_HEADER"] = "Selbstbuffs"
L["BUFF_WINDOW_FAVOR_HEADER"] = "Gefallen erwidern"
L["BUFF_WINDOW_TARGET_HEADER"] = "Ziel"
L["BUFF_WINDOW_TOOLTIP_CAST"] = "Klicken, um auf %s zu wirken."
L["BUFF_WINDOW_TOOLTIP_GROUP"] = "Klicken, um auf %s samt Gruppe zu wirken."
L["BUFF_WINDOW_TOOLTIP_FAVOR"] = "Klicken, um %s ins Ziel zu nehmen und zu wirken."
L["BUFF_WINDOW_TOOLTIP_DISMISS"] = "Rechtsklick, um %s von der Liste zu nehmen."

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
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Danke, du bist spitze! (="
--[[
    The star marker (left off on WoW Forever) and " // TFTB" sign-off are added
    by the builder, which also drops the closing punctuation; neither is part of
    the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "Du hast %a"

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "Ihr jubelt <Target> zu."
L["EMOTE_DRINK_DESCRIPTION"] = "Ihr erhebt Euer Glas auf <Target>."
L["EMOTE_FLEX_DESCRIPTION"] = "Ihr lasst vor <Target> Eure Muskeln spielen."
L["EMOTE_GRIN_DESCRIPTION"] = "Ihr grinst <Target> schelmisch an."
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "Ihr gebt <Target> ein High-Five."
L["EMOTE_PRAISE_DESCRIPTION"] = "Ihr lobt <Target>."
L["EMOTE_SALUTE_DESCRIPTION"] = "Ihr grüßt <Target> voller Respekt."
L["EMOTE_SMILE_DESCRIPTION"] = "Ihr lächelt <Target> an."
L["EMOTE_THANK_DESCRIPTION"] = "Ihr dankt <Target>."
L["EMOTE_WHOA_DESCRIPTION"] = "Ihr ruft <Target> 'Boah!' zu."
L["EMOTE_WINK_DESCRIPTION"] = "Ihr zwinkert <Target> zu."
L["EMOTE_YES_DESCRIPTION"] = "Ihr nickt <Target> zu."
