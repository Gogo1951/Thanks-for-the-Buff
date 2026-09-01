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
L["MESSAGE_USED_ITEM"] = "%s hat %s auf Euch benutzt!"
L["MESSAGE_USED_SPELL"] = "%s hat %s auf Euch gewirkt!"
L["MESSAGE_SET_OUT"] = "%s hat %s aufgestellt!"
L["MESSAGE_OPENED"] = "%s hat %s geöffnet!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Danke für %s!"
L["MESSAGE_PEER_PRESSURE"] = "%s hat %s eingesetzt!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s hat %s auf %s eingesetzt!"
L["MESSAGE_SELECT_PLAYER"] = "Wählt einen Spieler aus, dem Ihr danken wollt."
L["MESSAGE_CANT_THANK_SELF"] = "Ihr könnt Euch nicht selbst danken!"

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
	"Bedankt Euch automatisch mit Emotes, Flüsternachrichten und Chat-Hinweisen bei Spielern, die Euch buffen, egal ob ein Fremder in der offenen Welt oder die Abklingzeit eines Teammitglieds wie Seele der Macht oder Anregen. Werdet auch bei Festmählern, Portalen und Abklingzeiten Eurer eigenen Klasse benachrichtigt."
L["OPTIONS_SUPPORT"] = "Feedback & Unterstützung"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Öffnet das Optionsmenü dieses Add-ons."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Buffs von Fremden"
L["STRANGERS_ENABLE"] = "Dank für Buffs von Fremden aktivieren"
L["STRANGERS_DESCRIPTION"] = "Dankt Spielern außerhalb Eurer Gruppe, wenn sie Euch in der offenen Welt buffen."
--[[
    The dropdown values carry the unit, so these labels do not repeat it. Each
    description is one line because it renders as visible help under its control
    rather than behind a hover.
]]
L["STRANGERS_OVERALL_COOLDOWN"] = "Lob-Abklingzeit"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Verzögerung zwischen einem Lob und dem nächsten, ganz gleich wer Euch gebufft hat. Auf null gesetzt wird jeder Buff gelobt."
L["STRANGERS_SOURCE_COOLDOWN"] = "Lob-Abklingzeit für denselben Spieler"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Verzögerung zwischen Lob, das an denselben Spieler geht. Auf null gesetzt wird jeder Buff gelobt."
L["STRANGERS_MIN_DURATION"] = "Minimale Buff-Dauer"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Ignoriert Buffs, die kürzer sind als dies. Auf null gesetzt wird auf jeden Buff reagiert."

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Buffs von Teammitgliedern"
L["TEAMMATES_ENABLE"] = "Dank für Buffs von Teammitgliedern aktivieren"
L["TEAMMATES_DESCRIPTION"] =
	"Dankt Gruppen- und Schlachtzugsmitgliedern für Buffs und Abklingzeiten, die sie auf Euch wirken."

-- Service Alerts
L["TAB_SERVICES"] = "Dienst-Hinweise"
L["SERVICES_ENABLE"] = "Dienst-Hinweise aktivieren"
L["SERVICES_DESCRIPTION"] =
	"Reagiert auf schlachtzugweite Hilfe Eurer Gruppe: Festmähler, Seelenbrunnen, Portale, Reparaturbots."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Gute Neuigkeiten senden"
L["GOOD_NEWS_DESCRIPTION"] =
	"Lasst die Spieler, die Ihr bufft, wissen, was Ihr auf sie gewirkt habt und wie lange es anhält."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Gute Neuigkeiten aktivieren"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] = "Flüstert dem gebufften Spieler zu, was er erhalten hat und wie lange es anhält."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Jeder, den Ihr bufft"
L["GOOD_NEWS_SCOPE_GROUP"] = "Nur Gruppenmitglieder"
L["GOOD_NEWS_MESSAGES_HEADER"] = "Nachrichten für Gute Neuigkeiten"
L["GOOD_NEWS_MESSAGE"] = "Flüsternachricht"
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
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Gibt eine Nachricht in Eurem eigenen Chat aus, wenn eine Fähigkeit Eurer Klasse eingesetzt wird. Nur Ihr seht sie."
L["PEER_PRESSURE_OWN_CASTS"] = "Bei eigenen Zaubern auslösen"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Löst auch aus, wenn Ihr Eure eigenen Abklingzeiten einsetzt, nicht nur bei anderen Spielern."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Spielt einen Ton ab, wenn eine Fähigkeit Eurer Klasse eingesetzt wird. Nur Ihr hört ihn."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Verfolgte Fähigkeiten"
L["TRACKED_GROUP_ITEMS"] = "Gegenstände"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Verfolgung umschalten für %s."
L["TRACKED_ITEM_PENDING"] = "Gegenstand #%d"
L["TRACKED_SPELL_PENDING"] = "Zauber #%d"

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

L["PRAISE_WHISPER_ENABLE"] = "Dankesflüstern aktivieren"
L["PRAISE_WHISPER_DESCRIPTION"] = "Flüstert dem Spieler, der Euch gebufft hat, ein Dankeschön zu."
L["PRAISE_EMOTES_ENABLE"] = "Emotes aktivieren"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Drückt Eure Wertschätzung durch Emotes aus. Emotes werden zurückgehalten, solange Ihr im Kampf seid."
L["PRAISE_EMOTES_SELECT"] = "Emotes auswählen"
L["PRAISE_DELAY_ENABLE"] = "Lob-Verzögerung aktivieren"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Wartet einen Moment vor dem Flüstern und dem Emote, damit Euer Dank nicht im selben Augenblick wie der Buff eintrifft. Benachrichtigungen bleiben unberührt."
L["PRAISE_DELAY_HELP"] = "Wartet vor dem Lob, damit Euer Dank nicht im selben Augenblick wie der Buff eintrifft."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Chat-Nachrichten aktivieren"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Gibt eine Nachricht in Eurem eigenen Chat aus, wenn Ihr einen Buff erhaltet. Nur Ihr seht sie."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Soundeffekte aktivieren"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Spielt einen Ton ab, wenn Ihr einen Buff erhaltet. Nur Ihr hört ihn."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
    spells and items take their names from the client and need no key here.
]]
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
L["BUTTON_DESCRIPTION"] =
	"Höflichkeit, automatisiert. Jeder Knopf flüstert Eurem aktuellen Ziel zu und kann es auch mit einem Emote bedenken: einen Magier um Wasser bitten, jemandem für ein Portal danken, einen Freund mitten im Kampf für den schnellen Spott loben. Schreibt die Nachricht einmal, danach ist sie nur noch einen Tastendruck entfernt."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "TFTB Knopf %d"
L["BUTTON_EMOTE"] = "Emote"
L["BUTTON_EMOTE_NONE"] = "Keine"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Makro "%s" aktivieren'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] =
	"Erstellt ein Makro namens %s und löscht es wieder, sobald Ihr dies ausschaltet."
L["BUTTON_WHISPER"] = "Flüsternachricht"
L["BUTTON_RESET"] = "Zurücksetzen"
L["BUTTON_RESET_DESCRIPTION"] = "Setzt die Flüsternachricht auf den Standardtext zurück."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Danke, du bist spitze! (="
--[[
    The star marker and "TFTB // " prefix are added by the builder and are not
    part of the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "Ihr habt %a!"

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
