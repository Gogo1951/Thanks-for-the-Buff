local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "deDE")
if not L then return end

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["MSG_ENABLED"] = "Aktiviert. Nutzt /tftb, um Eure Einstellungen anzupassen oder diese Nachricht zu deaktivieren. (="
L["MSG_DB_ERROR"] = "Fehler: Datenbank-Standardwerte konnten nicht geladen werden. Bitte setzt Euer Profil über /tftb zurück."
L["MSG_RESET"] = "Alle Einstellungen wurden auf die Standardwerte zurückgesetzt."
L["MSG_BUFFED"] = "%s hat Euch mit %s gebufft!"
L["MSG_HIT"] = "%s hat Euch mit %s getroffen!"
L["MSG_PARTY_ITEM"] = "%s hat %s für Eure Gruppe benutzt!"
L["MSG_WHISPER_THANKS"] = "Danke für %s!"
L["MSG_SELECT_PLAYER"] = "Wählt einen Spieler aus, dem Ihr danken wollt."
L["MSG_CANT_THANK_SELF"] = "Ihr könnt Euch nicht selbst danken!"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_TITLE"] = "Thanks for the Buff!"
L["OPTIONS_GENERAL"] = "Allgemeine Einstellungen"
L["OPTIONS_WELCOME_TOGGLE"] = "Willkommensnachricht aktivieren"
L["OPTIONS_WELCOME_DESC"] = "Gibt beim Einloggen eine Nachricht im Chat aus."
L["OPTIONS_RESET"] = "Zurücksetzen"
L["OPTIONS_RESET_ALL"] = "Alle Einstellungen zurücksetzen"
L["OPTIONS_RESET_ALL_DESC"] = "Setzt jede Option auf ihren Standardwert zurück."
L["OPTIONS_RESET_CONFIRM"] = "Seid Ihr sicher, dass Ihr alle Einstellungen auf die Standardwerte zurücksetzen wollt?"
L["OPTIONS_DESCRIPTION"] = "Drückt automatisch mit einem Emote Freude aus, wenn Ihr einen neuen Buff erhaltet."
L["OPTIONS_SUPPORT"] = "Feedback & Support"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Öffnet das Optionsmenü von Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Nutzt ein Emote und flüstert Euer anvisiertes Ziel an."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "Buffs von Fremden"
L["STRANGERS_ENABLE"] = "Auf Buffs von Fremden reagieren"
L["STRANGERS_COOLDOWN"] = "Abklingzeit (Sekunden)"
L["STRANGERS_COOLDOWN_DESC"] = "Wie oft dem gleichen Spieler maximal gedankt werden soll."
L["STRANGERS_MIN_DURATION"] = "Minimale Buff-Dauer (Sekunden)"
L["STRANGERS_MIN_DURATION_DESC"] = "Die Mindestdauer des Buffs, um ein Dankeschön auszulösen.\n\nFiltert kurze Heilungen über Zeit wie Erneuerung oder Verjüngung heraus."
L["STRANGERS_MESSAGING"] = "Nachrichten"
L["STRANGERS_EMOTES_ENABLE"] = "Emotes aktivieren"
L["STRANGERS_EMOTES_DESC"] = "Zeigt Eure Wertschätzung für Buffs von Fremden durch Emotes."
L["STRANGERS_EMOTES_SELECT"] = "Emotes auswählen"

--------------------------------------------------------------------------------
-- Options: Combat Buffs
--------------------------------------------------------------------------------

L["COMBAT_TITLE"] = "Kampf-Buffs"
L["COMBAT_MESSAGING"] = "Nachrichten"
L["COMBAT_TRACKED"] = "Verfolgte Fähigkeiten:"
L["COMBAT_TOGGLE_TRACKING"] = "Verfolgung umschalten für %s"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Dankeschön-Taste"
L["BUTTON_CREATE_MACRO"] = "Makro erstellen"
L["BUTTON_CREATE_MACRO_DESC"] = "Beim Einloggen wird automatisch ein Makro namens %s für Euch erstellt."
L["BUTTON_WHISPER"] = "Flüsternachricht"
L["BUTTON_RESET"] = "Zurücksetzen"
L["BUTTON_RESET_DESC"] = "Setzt die Flüsternachricht auf den Standardtext zurück."
L["BUTTON_EMOTES_HEADER"] = "Dankeschön-Taste Emotes:"
L["BUTTON_EMOTES_SELECT"] = "Emotes auswählen"

--------------------------------------------------------------------------------
-- Shared: Messaging Dropdown
--------------------------------------------------------------------------------

L["MESSAGING_NONE"] = "Keine Nachricht"
L["MESSAGING_NONE_DEFAULT"] = "Keine Nachricht (Standard)"
L["MESSAGING_PRINT"] = "Chat-Nachricht (Nur für mich)"
L["MESSAGING_WHISPER"] = "Flüsternachricht"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Danke, du bist der Beste! (="