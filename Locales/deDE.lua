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
L["MESSAGE_BUFFED"] = "%s hat Euch mit %s gebufft!"
L["MESSAGE_GAVE_YOU"] = "%s hat Euch %s gegeben!"
L["MESSAGE_GAVE_GROUP"] = "%s hat Eurer Gruppe %s gegeben!"
L["MESSAGE_USED_ITEM"] = "%s hat %s %s auf Euch benutzt!"
L["MESSAGE_USED_SPELL"] = "%s hat %s auf Euch benutzt!"
L["MESSAGE_SET_OUT"] = "%s hat %s aufgestellt!"
L["MESSAGE_OPENED"] = "%s hat %s geöffnet!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Danke für %s!"
L["MESSAGE_GOOD_NEWS_DURATION"] = "Gute Neuigkeiten! Ihr habt %s für %s!"
L["MESSAGE_GOOD_NEWS"] = "Gute Neuigkeiten! Ihr habt %s!"
L["MESSAGE_PEER_PRESSURE"] = "%s hat %s eingesetzt!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s hat %s auf %s eingesetzt!"
L["MESSAGE_SELECT_PLAYER"] = "Wählt einen Spieler aus, dem Ihr danken wollt."
L["MESSAGE_CANT_THANK_SELF"] = "Ihr könnt Euch nicht selbst danken!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MESSAGE_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "sein"
L["PRONOUN_HER"] = "ihr"
L["PRONOUN_THEIR"] = "ihr"
L["UNKNOWN_SPELL"] = "Unbekannter Zauber"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Willkommensnachricht aktivieren"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Gibt beim Einloggen eine Nachricht im Chat aus."
L["OPTIONS_DESCRIPTION"] =
	"Bedankt Euch automatisch mit Emotes, Flüsternachrichten und Chat-Hinweisen bei Spielern, die Euch buffen, egal ob ein Fremder in der offenen Welt oder ein Teammitglied mit einem Cooldown wie Power Infusion oder Innervate. Werdet auch bei Festmählern, Portalen und Cooldowns Eurer Klasse benachrichtigt."
L["OPTIONS_SUPPORT"] = "Feedback & Unterstützung"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMAND_TFTB"] = "/tftb"
L["OPTIONS_COMMAND_TFTB_DESCRIPTION"] = "Öffnet das Optionsmenü von Thanks for the Buff."
L["OPTIONS_COMMAND_THANKYOU"] = "/thankyou"
L["OPTIONS_COMMAND_THANKYOU_DESCRIPTION"] = "Nutzt ein Emote und flüstert Eurem aktuellen Ziel zu."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Buffs von Fremden"
L["STRANGERS_DESCRIPTION"] = "Ein Buff auf Euch von einem Spieler außerhalb Eurer Gruppe (offene Welt)."
L["STRANGERS_COOLDOWN"] = "Abklingzeit (Sekunden)"
L["STRANGERS_COOLDOWN_DESCRIPTION"] =
	"Wie oft dem gleichen Spieler maximal mit Emotes gedankt werden soll.\n\nNachrichten sind davon nicht betroffen; sie werden für jeden Buff ausgelöst."
L["STRANGERS_MIN_DURATION"] = "Minimale Buff-Dauer (Sekunden)"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Die Mindestdauer des Buffs, um ein Dankeschön auszulösen.\n\nFiltert kurze Heilungen über Zeit wie Erneuerung oder Verjüngung heraus."

--------------------------------------------------------------------------------
-- Options: Combat Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Buffs von Teammitgliedern"
L["TEAMMATES_DESCRIPTION"] = "Ein Buff oder Cooldown, den ein Gruppen- oder Schlachtzugsmitglied auf Euch wirkt."

-- Group Services
L["TAB_SERVICES"] = "Gruppendienste"
L["SERVICES_DESCRIPTION"] =
	"Die schlachtzugweite Hilfe eines Gruppen- oder Schlachtzugsmitglieds: Festmähler, Seelenbrunnen, Portale, Reparaturbots."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Gute Neuigkeiten"
L["GOOD_NEWS_DESCRIPTION"] =
	"Lasst die Spieler, die Ihr bufft, wissen, was Ihr auf sie gewirkt habt und wie lange es anhält."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Gute Neuigkeiten aktivieren"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Flüstert dem Spieler, den Ihr gebufft habt, zu, was er erhalten hat und wie lange es anhält."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Jeder, den Ihr bufft"
L["GOOD_NEWS_SCOPE_GROUP"] = "Nur Gruppenmitglieder"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Gruppenzwang"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Werdet benachrichtigt, wenn andere Spieler Eurer Klasse ihre Cooldowns einsetzen, damit Ihr dem Gruppenzwang nachgeben könnt."
L["PEER_PRESSURE_ENABLE"] = "Peer Pressure aktivieren"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Gibt eine Nachricht in Eurem eigenen Chat aus, wenn ein Cooldown Eurer Klasse eingesetzt wird. Nur Ihr seht sie."
L["PEER_PRESSURE_OWN_CASTS"] = "Bei eigenen Zaubern auslösen"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Löst die Benachrichtigung auch bei Euren eigenen Cooldowns aus, nicht nur bei denen anderer Spieler."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
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
L["BUTTON_DESCRIPTION"] = "Dankt Eurem aktuellen Ziel mit einem Emote und einer Flüsternachricht."
L["BUTTON_CREATE_MACRO"] = "Makro erstellen"
L["BUTTON_CREATE_MACRO_DESCRIPTION"] = "Erstellt beim Einloggen automatisch ein Makro namens %s."
L["BUTTON_WHISPER"] = "Flüsternachricht"
L["BUTTON_RESET"] = "Zurücksetzen"
L["BUTTON_RESET_DESCRIPTION"] = "Setzt die Flüsternachricht auf den Standardtext zurück."

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_HEADER"] = "Nachrichten"
L["MESSAGING_PRINT_ENABLE"] = "Chat-Nachrichten aktivieren"
L["MESSAGING_PRINT_DESCRIPTION"] =
	"Gibt eine Nachricht in Eurem eigenen Chat aus, wenn Ihr einen Buff erhaltet. Nur Ihr seht sie."
L["MESSAGING_WHISPER_ENABLE"] = "Dankesflüstern aktivieren"
L["MESSAGING_WHISPER_DESCRIPTION"] = "Flüstert dem Spieler, der Euch gebufft hat, ein Dankeschön zu."
L["MESSAGING_EMOTES_ENABLE"] = "Emotes aktivieren (Außerhalb des Kampfes)"
L["MESSAGING_EMOTES_DESCRIPTION"] =
	"Drückt Eure Wertschätzung durch Emotes aus. Emotes werden zurückgehalten, solange Ihr Euch im Kampf befindet."
L["MESSAGING_EMOTES_SELECT"] = "Emotes auswählen"
L["MESSAGING_SOUND_ENABLE"] = "Soundeffekt aktivieren"
L["MESSAGING_SOUND_DESCRIPTION"] = "Spielt einen Ton ab, wenn Ihr einen Buff erhaltet. Nur Ihr hört ihn."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Danke, du bist spitze! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "Ihr jubelt <Target> zu."
L["EMOTE_DRINK_DESCRIPTION"] = "Ihr erhebt ein Getränk auf <Target>."
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
