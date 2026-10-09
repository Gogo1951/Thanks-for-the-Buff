local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "itIT")
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
	"Versione %s. Le impostazioni (inclusa l'opzione per disabilitare questo messaggio) si trovano in Opzioni > AddOn > Thanks for the Buff (TFTB). Ti piace l'add-on? Dillo a un amico! (="
L["CHAT_OPTIONS_IN_COMBAT"] =
	"Per precauzione, l'interfaccia delle opzioni non può essere aperta durante il combattimento."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s ti ha potenziato con %s!"
L["MESSAGE_GAVE_YOU"] = "%s ti ha dato %s!"
L["MESSAGE_GAVE_GROUP"] = "%s ha dato %s al tuo gruppo!"
L["MESSAGE_USED_ITEM"] = "%s ha usato %s su di te!"
L["MESSAGE_USED_SPELL"] = "%s ha lanciato %s su di te!"
L["MESSAGE_SET_OUT"] = "%s ha posizionato %s!"
L["MESSAGE_OPENED"] = "%s ha aperto %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Grazie per %s"
L["MESSAGE_SELECT_PLAYER"] = "Seleziona un giocatore da ringraziare."
L["MESSAGE_CANT_THANK_SELF"] = "Non puoi ringraziare te stesso!"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "%s ha usato %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s ha usato %s su %s!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Incantesimo sconosciuto"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Abilita messaggio di benvenuto"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Mostra un messaggio in chat quando accedi."
L["OPTIONS_DESCRIPTION"] =
	"Ringrazia automaticamente con un sussurro o un'emote i giocatori che ti potenziano e annuncia i potenziamenti che lanci, come Infusione di Potere, Innervazione e Pietra dell'Anima. Ricevi anche avvisi per banchetti, portali, evocazioni, pozzi delle anime e tempi di recupero della tua classe. Buone maniere, in automatico."
L["OPTIONS_SUPPORT"] = "Feedback e supporto"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_VERSION"] = "Versione %s"
L["OPTIONS_FEATURES_HEADER"] = "Funzionalità"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Apre l'interfaccia delle opzioni di questo add-on."

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Stranger Buffs
L["TAB_STRANGERS"] = "Potenziamenti da sconosciuti"
L["STRANGERS_ENABLE"] = "Abilita i ringraziamenti per i potenziamenti da sconosciuti"
L["STRANGERS_ENABLE_DESCRIPTION"] =
	"Attiva i ringraziamenti per i potenziamenti ricevuti da giocatori fuori dal tuo gruppo."
L["STRANGERS_DESCRIPTION"] = "Ringrazia i giocatori fuori dal tuo gruppo quando ti potenziano nel mondo aperto."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "Recupero dei ringraziamenti"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Imposta il ritardo tra un giro di ringraziamenti e il successivo, chiunque ti abbia potenziato. Con zero si ringrazia per ogni potenziamento."
L["STRANGERS_SOURCE_COOLDOWN"] = "Recupero dei ringraziamenti allo stesso giocatore"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Imposta il ritardo tra i ringraziamenti rivolti allo stesso giocatore. Con zero si ringrazia per ogni potenziamento."
L["STRANGERS_MIN_DURATION"] = "Durata minima del potenziamento"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Ignora i potenziamenti più brevi di questo valore. Con zero si reagisce a ogni potenziamento."

-- Teammate Buffs
L["TAB_TEAMMATES"] = "Potenziamenti dai compagni"
L["TEAMMATES_ENABLE"] = "Abilita i ringraziamenti per i potenziamenti dai compagni"
L["TEAMMATES_ENABLE_DESCRIPTION"] =
	"Attiva i ringraziamenti per i potenziamenti e le capacità con tempo di recupero che i membri del tuo gruppo o della tua incursione lanciano su di te."
L["TEAMMATES_DESCRIPTION"] =
	"Ringrazia i membri del gruppo e dell'incursione per i potenziamenti e le capacità con tempo di recupero che lanciano su di te."

-- Service Alerts
L["TAB_SERVICES"] = "Avvisi sui servizi"
L["SERVICES_ENABLE"] = "Abilita gli avvisi sui servizi"
L["SERVICES_ENABLE_DESCRIPTION"] =
	"Attiva gli avvisi per banchetti, pozzi delle anime, portali e altri aiuti messi a disposizione del tuo gruppo."
L["SERVICES_DESCRIPTION"] =
	"Reagisci all'aiuto per l'intera incursione del tuo gruppo: banchetti, pozzi delle anime, portali e robot di riparazione."

-- Send Good News
L["TAB_GOOD_NEWS"] = "Invia buone notizie"
L["GOOD_NEWS_DESCRIPTION"] = "Informa i giocatori che potenzi di ciò che hai lanciato su di loro e di quanto dura."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Abilita buone notizie"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] = "Sussurra al giocatore che hai potenziato cosa ha ricevuto e per quanto tempo."
L["GOOD_NEWS_SCOPE"] = "Destinatari"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Chiunque potenzi"
L["GOOD_NEWS_SCOPE_GROUP"] = "Solo membri del gruppo"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Imposta chi riceve il sussurro delle buone notizie: chiunque potenzi, oppure solo il tuo gruppo o la tua incursione."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Messaggio delle buone notizie"
--[[
    Two halves so the number stays authoritative: LIMIT's %d is a real placeholder
    and gets formatted, TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_LIMIT"] = "Lunghezza massima: %d."
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a diventa il collegamento all'abilità."
--[[
    Appended to the ability link inside %a when the buff has a readable duration.
    A whole clause rather than a bare number so it can be reworded per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "per %s"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Pressione sociale"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Ricevi una notifica quando altri giocatori della tua classe usano le loro capacità con tempo di recupero, così puoi cedere alla pressione sociale."
L["PEER_PRESSURE_ENABLE"] = "Abilita pressione sociale"
L["PEER_PRESSURE_ENABLE_DESCRIPTION"] =
	"Attiva gli avvisi quando un altro giocatore della tua classe usa una capacità con tempo di recupero tracciata."
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Mostra un messaggio nella tua chat quando viene usata una capacità con tempo di recupero della tua classe. Lo vedi solo tu."
L["PEER_PRESSURE_OWN_CASTS"] = "Attiva con i tuoi incantesimi"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Si attiva anche quando usi le tue capacità con tempo di recupero, non solo quando lo fanno gli altri giocatori."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Riproduce un suono quando viene usata una capacità con tempo di recupero della tua classe. Lo senti solo tu."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Abilità tracciate"
L["TRACKED_GROUP_ITEMS"] = "Oggetti"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Attiva o disattiva il tracciamento di %s."
L["TRACKED_ITEM_PENDING"] = "Oggetto #%d"
L["TRACKED_SPELL_PENDING"] = "Incantesimo #%d"

-- Shared by Send Good News and the Thank You Button
L["WHISPER_MESSAGE"] = "Messaggio sussurrato"
L["WHISPER_MESSAGE_RESET"] = "Ripristina"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Ripristina il testo predefinito del messaggio sussurrato."

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "Messaggi di ringraziamento ed emote"
L["NOTIFICATIONS_HEADER"] = "Notifiche"

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "Seleziona le emote"

L["PRAISE_WHISPER_ENABLE"] = "Abilita sussurri di ringraziamento"
L["PRAISE_WHISPER_DESCRIPTION"] = "Sussurra un ringraziamento al giocatore che ti ha potenziato."
L["PRAISE_EMOTES_ENABLE"] = "Abilita emote"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Mostra il tuo apprezzamento con un'emote. Le emote vengono trattenute mentre sei in combattimento."
L["PRAISE_DELAY_ENABLE"] = "Abilita ritardo del ringraziamento"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Attende un momento prima del sussurro e dell'emote, così il tuo ringraziamento non arriva nello stesso istante del potenziamento. Le notifiche non vengono influenzate."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Imposta quanto attendere prima di inviare il sussurro e l'emote."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Abilita messaggi in chat"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Mostra un messaggio nella tua chat quando ricevi un potenziamento. Lo vedi solo tu."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Abilita effetti sonori"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Riproduce un suono quando ricevi un potenziamento. Lo senti solo tu."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Riproduce il suono così puoi ascoltarlo prima di attivarlo."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups that no single game record names
    (Data/{Game}/Tracked-Abilities-{Game}.lua). Single spells and items, and a
    group named after one of its own items, take their names from the client.
]]
L["GROUP_PORTALS"] = "Portali"
L["GROUP_RESISTANCE_CAULDRONS"] = "Calderoni di resistenza"
L["GROUP_REPAIR_BOTS"] = "Robot di riparazione"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Pulsante di ringraziamento"
L["BUTTON_DESCRIPTION"] =
	"Buone maniere, automatizzate. Ogni pulsante sussurra al tuo bersaglio attuale e può anche rivolgergli un'emote: chiedere acqua a un mago, ringraziare qualcuno per un portale, lodare un amico in piena mischia per una provocazione tempestiva. Scrivi il messaggio una volta e da lì in poi ti basta un tasto."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Pulsante di ringraziamento %d"
L["BUTTON_EMOTE"] = "Emote"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Imposta l'emote che questo pulsante esegue sul tuo bersaglio, oppure Nessuna per non usare alcuna emote."
L["BUTTON_EMOTE_NONE"] = "Nessuna"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Abilita la macro "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] =
	"Crea una macro chiamata %s e la elimina di nuovo quando disattivi questa opzione."
L["BUTTON_WHISPER_DESCRIPTION"] =
	"Imposta cosa sussurra questo pulsante al tuo bersaglio. Se il campo resta vuoto, non viene inviato alcun sussurro."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Grazie, sei un mito! (="
--[[
    The star marker (left off on WoW Forever) and " // TFTB" sign-off are added
    by the builder, which also drops the closing punctuation; neither is part of
    the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "Hai %a"

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "Fai il tifo per <Target>."
L["EMOTE_DRINK_DESCRIPTION"] = "Brindi a <Target>."
L["EMOTE_FLEX_DESCRIPTION"] = "Mostri i muscoli a <Target>."
L["EMOTE_GRIN_DESCRIPTION"] = "Sorridi maliziosamente a <Target>."
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "Dai il cinque a <Target>."
L["EMOTE_PRAISE_DESCRIPTION"] = "Lodi <Target>."
L["EMOTE_SALUTE_DESCRIPTION"] = "Saluti <Target> con rispetto."
L["EMOTE_SMILE_DESCRIPTION"] = "Sorridi a <Target>."
L["EMOTE_THANK_DESCRIPTION"] = "Ringrazi <Target>."
L["EMOTE_WHOA_DESCRIPTION"] = "Esclami 'Wow!' verso <Target>."
L["EMOTE_WINK_DESCRIPTION"] = "Fai l'occhiolino a <Target>."
L["EMOTE_YES_DESCRIPTION"] = "Annuisci a <Target>."
