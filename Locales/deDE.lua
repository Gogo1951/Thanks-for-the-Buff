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
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"Version %s. Einstellungen (einschließlich der Option, diese Nachricht zu deaktivieren) finden sich unter Optionen > AddOns > Thanks for the Buff (TFTB). Gefällt das Add-on? Erzählt einem Freund davon! (="
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
L["MESSAGE_SELECT_PLAYER"] = "Wählt einen Spieler aus, dem Ihr danken wollt."
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
L["OPTIONS_WELCOME_DESCRIPTION"] = "Gibt beim Einloggen eine Nachricht im Chat aus."
L["OPTIONS_DESCRIPTION"] =
	"Bedankt Euch automatisch per Flüstern oder Emote bei Spielern, die Euch buffen, und kündigt Eure eigenen Buffs an, etwa Seele der Macht, Anregen und Seelenstein. Lasst Euch außerdem bei Festmählern, Portalen, Beschwörungen, Seelenbrunnen und Abklingzeiten Eurer Klasse benachrichtigen. Gute Manieren, automatisiert."
L["OPTIONS_SUPPORT"] = "Feedback & Unterstützung"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_VERSION"] = "Version %s"
L["OPTIONS_FEATURES_HEADER"] = "Funktionen"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Öffnet das Optionsmenü dieses Add-ons."

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
	"Reagiert auf schlachtzugweite Hilfe Eurer Gruppe: Festmähler, Seelenbrunnen, Portale und Reparaturbots."

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
	"Legt fest, wer die Guten Neuigkeiten zugeflüstert bekommt: jeder, den Ihr bufft, oder nur Eure Gruppe oder Euer Schlachtzug."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Nachricht für Gute Neuigkeiten"
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
	"Gibt eine Nachricht in Eurem eigenen Chat aus, wenn eine Abklingzeit Eurer Klasse eingesetzt wird. Nur Ihr seht sie."
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
L["PRAISE_HEADER"] = "Lobnachrichten & Emotes"
L["NOTIFICATIONS_HEADER"] = "Benachrichtigungen"

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

L["NOTIFICATIONS_PRINT_ENABLE"] = "Chat-Nachrichten aktivieren"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Gibt eine Nachricht in Eurem eigenen Chat aus, wenn Ihr einen Buff erhaltet. Nur Ihr seht sie."
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
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Dankeschön-Knopf"
L["BUTTON_DESCRIPTION"] =
	"Höflichkeit, automatisiert. Jeder Knopf flüstert Eurem aktuellen Ziel zu und kann es auch mit einem Emote bedenken: einen Magier um Wasser bitten, jemandem für ein Portal danken, einen Freund mitten im Kampf für den schnellen Spott loben. Schreibt die Nachricht einmal, danach ist sie nur noch einen Tastendruck entfernt."
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
