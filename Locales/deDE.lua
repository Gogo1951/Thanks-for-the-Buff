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
	"Version %s. Einstellungen (einschließlich der Option, diese Nachricht zu deaktivieren) finden sich unter Optionen > AddOns > Thanks for the Buff. Gefällt das Add-on? Erzählt einem Freund davon! (="

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s hat Euch mit %s gebufft!"
L["MSG_GAVE_YOU"] = "%s hat Euch %s gegeben!"
L["MSG_GAVE_GROUP"] = "%s hat Eurer Gruppe %s gegeben!"
L["MSG_USED_ITEM"] = "%s hat %s %s auf Euch benutzt!"
L["MSG_USED_SPELL"] = "%s hat %s auf Euch benutzt!"
L["MSG_SET_OUT"] = "%s hat %s aufgestellt!"
L["MSG_OPENED"] = "%s hat %s geöffnet!"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "Danke für %s!"
L["MSG_GOODNEWS_DURATION"] = "Gute Neuigkeiten! Ihr habt %s für %s!"
L["MSG_GOODNEWS"] = "Gute Neuigkeiten! Ihr habt %s!"
L["MSG_PEER_PRESSURE"] = "%s hat %s eingesetzt!"
L["MSG_PEER_PRESSURE_TARGET"] = "%s hat %s auf %s eingesetzt!"
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
L["OPTIONS_DESCRIPTION"] =
	"Bedankt Euch automatisch mit Emotes, Flüsternachrichten und Chat-Hinweisen bei Spielern, die Euch buffen, egal ob ein Fremder in der offenen Welt oder ein Teammitglied mit einem Cooldown wie Power Infusion oder Innervate. Werdet auch bei Festmählern, Portalen und Cooldowns Eurer Klasse benachrichtigt."
L["OPTIONS_SUPPORT"] = "Feedback & Unterstützung"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Öffnet das Optionsmenü von Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Nutzt ein Emote und flüstert Eurem aktuellen Ziel zu."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Buffs von Fremden"
L["STRANGERS_DESC"] = "Ein Buff auf Euch von einem Spieler außerhalb Eurer Gruppe (offene Welt)."
L["STRANGERS_COOLDOWN"] = "Abklingzeit (Sekunden)"
L["STRANGERS_COOLDOWN_DESC"] =
	"Wie oft dem gleichen Spieler maximal mit Emotes gedankt werden soll.\n\nNachrichten sind davon nicht betroffen; sie werden für jeden Buff ausgelöst."
L["STRANGERS_MIN_DURATION"] = "Minimale Buff-Dauer (Sekunden)"
L["STRANGERS_MIN_DURATION_DESC"] =
	"Die Mindestdauer des Buffs, um ein Dankeschön auszulösen.\n\nFiltert kurze Heilungen über Zeit wie Erneuerung oder Verjüngung heraus."

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Buffs von Teammitgliedern"
L["TEAMMATES_DESC"] = "Ein Buff oder Cooldown, den ein Gruppen- oder Schlachtzugsmitglied auf Euch wirkt."

-- Group Services
L["TAB_SERVICES"] = "Gruppendienste"
L["SERVICES_DESC"] =
	"Die schlachtzugweite Hilfe eines Gruppen- oder Schlachtzugsmitglieds: Festmähler, Seelenbrunnen, Portale, Reparaturbots."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Gute Neuigkeiten"
L["GOOD_NEWS_DESC"] =
	"Flüstert den Spielern, die Ihr bufft, automatisch zu, welche Kampf-Buffs Ihr auf sie gewirkt habt."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Gute Neuigkeiten aktivieren"
L["GOOD_NEWS_WHISPER_DESC"] =
	"Flüstert dem Spieler, den Ihr gebufft habt, zu, was er erhalten hat und wie lange es anhält."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Jeder, den Ihr bufft"
L["GOOD_NEWS_SCOPE_GROUP"] = "Nur Gruppenmitglieder"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Peer Pressure"
L["PEER_PRESSURE_DESC"] =
	"Werdet benachrichtigt, wenn andere Spieler Eurer Klasse ihre Cooldowns einsetzen, damit Ihr dem Peer Pressure nachgeben könnt."
L["PEER_PRESSURE_ENABLE"] = "Peer Pressure aktivieren"
L["PEER_PRESSURE_PRINT_DESC"] =
	"Gibt eine Nachricht in Eurem eigenen Chat aus, wenn ein Cooldown Eurer Klasse eingesetzt wird. Nur Ihr seht sie."
L["PEER_PRESSURE_OWN_CASTS"] = "Bei eigenen Zaubern auslösen"
L["PEER_PRESSURE_OWN_CASTS_DESC"] =
	"Löst die Benachrichtigung auch bei Euren eigenen Cooldowns aus, nicht nur bei denen anderer Spieler."
L["PEER_PRESSURE_SOUND_DESC"] =
	"Spielt einen Ton ab, wenn ein Cooldown Eurer Klasse eingesetzt wird. Nur Ihr hört ihn."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Verfolgte Fähigkeiten"
L["COMBAT_GROUP_ITEMS"] = "Gegenstände"
L["COMBAT_TOGGLE_TRACKING"] = "Verfolgung umschalten für %s"
L["COMBAT_ITEM_PENDING"] = "Gegenstand #%d"
L["COMBAT_SPELL_PENDING"] = "Zauber #%d"

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

-- Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
-- spells and items take their names from the client and need no key here.
L["GROUP_PORTALS"] = "Portale"
L["GROUP_SOULSTONE"] = "Seelenstein"
L["GROUP_RESISTANCE_CAULDRONS"] = "Widerstandskessel"
L["GROUP_SCROLL_OF_SPIRIT"] = "Rolle der Willenskraft"
L["GROUP_SCROLL_OF_STAMINA"] = "Rolle der Ausdauer"
L["GROUP_SCROLL_OF_STRENGTH"] = "Rolle der Stärke"
L["GROUP_SCROLL_OF_PROTECTION"] = "Rolle des Schutzes"
L["GROUP_SCROLL_OF_INTELLECT"] = "Rolle der Intelligenz"
L["GROUP_SCROLL_OF_AGILITY"] = "Rolle der Beweglichkeit"
L["GROUP_REPAIR_BOTS"] = "Reparaturbots"
L["GROUP_JUMPER_CABLES"] = "Starthilfekabel"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Dankeschön-Knopf"
L["BUTTON_DESC"] = "Dankt Eurem aktuellen Ziel mit einem Emote und einer Flüsternachricht."
L["BUTTON_CREATE_MACRO"] = "Makro erstellen"
L["BUTTON_CREATE_MACRO_DESC"] = "Erstellt beim Einloggen automatisch ein Makro namens %s."
L["BUTTON_WHISPER"] = "Flüsternachricht"
L["BUTTON_RESET"] = "Zurücksetzen"
L["BUTTON_RESET_DESC"] = "Setzt die Flüsternachricht auf den Standardtext zurück."

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_HEADER"] = "Nachrichten"
L["MESSAGING_PRINT_ENABLE"] = "Chat-Nachrichten aktivieren (Nur für Euch)"
L["MESSAGING_PRINT_DESC"] =
	"Gibt eine Nachricht in Eurem eigenen Chat aus, wenn Ihr einen Buff erhaltet. Nur Ihr seht sie."
L["MESSAGING_WHISPER_ENABLE"] = "Dankesnachrichten aktivieren"
L["MESSAGING_WHISPER_DESC"] = "Flüstert dem Spieler, der Euch gebufft hat, ein Dankeschön zu."
L["MESSAGING_EMOTES_ENABLE"] = "Emotes aktivieren (Außerhalb des Kampfes)"
L["MESSAGING_EMOTES_DESC"] =
	"Drückt Eure Wertschätzung durch Emotes aus. Emotes werden zurückgehalten, solange Ihr Euch im Kampf befindet."
L["MESSAGING_EMOTES_SELECT"] = "Emotes auswählen"
L["MESSAGING_SOUND_ENABLE"] = "Soundeffekt aktivieren"
L["MESSAGING_SOUND_DESC"] = "Spielt einen Ton ab, wenn Ihr einen Buff erhaltet. Nur Ihr hört ihn."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Danke, du bist spitze! (="

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
