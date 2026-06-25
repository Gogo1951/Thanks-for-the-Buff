local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "deDE")
if not L then return end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] = "Version %s. Einstellungen (einschließlich der Option, diese Nachricht zu deaktivieren) finden sich unter Optionen > AddOns > Thanks for the Buff. Gefällt das Add-on? Erzählt einem Freund davon! (="
L["MSG_RESET"] = "Alle Einstellungen wurden auf die Standardwerte zurückgesetzt."

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s hat Euch mit %s gebufft!"
L["MSG_GAVE_YOU"] = "%s hat Euch %s gegeben!"
L["MSG_GAVE_GROUP"] = "%s hat Eurer Gruppe %s gegeben!"
L["MSG_USED_ITEM"] = "%s hat %s %s auf Euch benutzt!"
L["MSG_USED_SPELL"] = "%s hat %s auf Euch benutzt!"
L["MSG_SET_OUT"] = "%s hat %s aufgestellt!"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "Danke für %s!"
L["MSG_SELECT_PLAYER"] = "Wählt einen Spieler aus, dem Ihr danken wollt."
L["MSG_CANT_THANK_SELF"] = "Ihr könnt Euch nicht selbst danken!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MSG_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "sein"
L["PRONOUN_HER"] = "ihr"
L["PRONOUN_THEIR"] = "ihr"
L["UNKNOWN_SPELL"] = "Unbekannter Zauber"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Willkommensnachricht aktivieren"
L["OPTIONS_WELCOME_DESC"] = "Gibt beim Einloggen eine Nachricht im Chat aus."
L["OPTIONS_RESET"] = "Zurücksetzen"
L["OPTIONS_RESET_ALL"] = "Alle TFTB-Einstellungen zurücksetzen"
L["OPTIONS_RESET_ALL_DESC"] = "Setzt jede Option auf ihren Standardwert zurück."
L["OPTIONS_RESET_CONFIRM"] = "Seid Ihr sicher, dass Ihr alle Einstellungen auf die Standardwerte zurücksetzen wollt?"
L["OPTIONS_DESCRIPTION"] = "Drückt automatisch mit Emotes und Nachrichten Eure Wertschätzung aus, wenn Ihr einen Buff erhaltet – egal ob Euch ein Fremder in der offenen Welt bufft oder ein Teammitglied im Kampf eine Abklingzeit für Euch nutzt."
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
L["STRANGERS_DESC"] = "Ein Buff auf Euch von einem Spieler außerhalb Eurer Gruppe (offene Welt)."
L["STRANGERS_COOLDOWN"] = "Abklingzeit (Sekunden)"
L["STRANGERS_COOLDOWN_DESC"] = "Wie oft dem gleichen Spieler maximal mit Emotes gedankt werden soll.\n\nNachrichten sind davon nicht betroffen; sie werden für jeden Buff ausgelöst."
L["STRANGERS_MIN_DURATION"] = "Minimale Buff-Dauer (Sekunden)"
L["STRANGERS_MIN_DURATION_DESC"] = "Die Mindestdauer des Buffs, um ein Dankeschön auszulösen.\n\nFiltert kurze Heilungen über Zeit wie Erneuerung oder Verjüngung heraus."
L["STRANGERS_MESSAGING"] = "Nachrichten"
L["STRANGERS_EMOTES_SELECT"] = "Emotes auswählen"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

L["TEAMMATES_TITLE"] = "Buffs von Teammitgliedern"
L["TEAMMATES_DESC"] = "Ein Buff oder eine Abklingzeit eines Gruppen- oder Schlachtzugsmitglieds, der/die auf Euch gewirkt wurde."
L["SERVICES_TITLE"] = "Gruppendienste"
L["SERVICES_DESC"] = "Die schlachtzugweite Hilfe eines Gruppen- oder Schlachtzugsmitglieds – Festmähler, Seelenbrunnen, Portale, Reparaturbots."
L["COMBAT_MESSAGING"] = "Nachrichten"
L["COMBAT_EMOTES_SELECT"] = "Emotes auswählen"
L["COMBAT_TRACKED"] = "Verfolgte Fähigkeiten:"
L["COMBAT_TOGGLE_TRACKING"] = "Verfolgung umschalten für %s"
L["COMBAT_GROUP_ITEMS"] = "Gegenstände"
L["COMBAT_ITEM_PENDING"] = "Gegenstand #%d"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Dankeschön-Taste"
L["BUTTON_DESC"] = "Dankt Eurem aktuellen Ziel mit einem Emote und einer Flüsternachricht."
L["BUTTON_CREATE_MACRO"] = "Makro erstellen"
L["BUTTON_CREATE_MACRO_DESC"] = "Beim Einloggen wird automatisch ein Makro namens %s für Euch erstellt."
L["BUTTON_WHISPER"] = "Flüsternachricht"
L["BUTTON_RESET"] = "Zurücksetzen"
L["BUTTON_RESET_DESC"] = "Setzt die Flüsternachricht auf den Standardtext zurück."
L["BUTTON_EMOTES_SELECT"] = "Emotes auswählen"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_PRINT_ENABLE"] = "Chat-Nachrichten aktivieren (Nur für mich)"
L["MESSAGING_PRINT_DESC"] = "Gibt eine Nachricht in Eurem eigenen Chat aus, wenn Ihr einen Buff erhaltet. Nur Ihr seht sie."
L["MESSAGING_WHISPER_ENABLE"] = "Dankesnachrichten aktivieren"
L["MESSAGING_WHISPER_DESC"] = "Flüstert dem Spieler, der Euch gebufft hat, ein Dankeschön zu."
L["MESSAGING_EMOTES_ENABLE"] = "Emotes aktivieren (Außerhalb des Kampfes)"
L["MESSAGING_EMOTES_DESC"] = "Drückt Eure Wertschätzung durch Emotes aus. Emotes werden zurückgehalten, solange Ihr Euch im Kampf befindet."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Danke, du bist der Beste! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESC"] = "Ihr jubelt <Target> zu."
L["EMOTE_DRINK_DESC"] = "Ihr erhebt ein Getränk auf <Target>."
L["EMOTE_FLEX_DESC"] = "Ihr lasst vor <Target> Eure Muskeln spielen."
L["EMOTE_GRIN_DESC"] = "Ihr grinst <Target> schelmisch an."
L["EMOTE_HIGHFIVE_DESC"] = "Ihr gebt <Target> ein High-Five."
L["EMOTE_PRAISE_DESC"] = "Ihr lobt <Target>."
L["EMOTE_SALUTE_DESC"] = "Ihr grüßt <Target> voller Respekt."
L["EMOTE_SMILE_DESC"] = "Ihr lächelt <Target> an."
L["EMOTE_THANK_DESC"] = "Ihr dankt <Target>."
L["EMOTE_WHOA_DESC"] = "Ihr seht <Target> an und ruft 'Boah!' aus."
L["EMOTE_WINK_DESC"] = "Ihr zwinkert <Target> zu."
L["EMOTE_YES_DESC"] = "Ihr nickt <Target> zu."
