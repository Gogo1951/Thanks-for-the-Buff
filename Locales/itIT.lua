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
	"Versione %s. Le impostazioni (inclusa l'opzione per disabilitare questo messaggio) si trovano in Opzioni > AddOn > Thanks for the Buff. Ti piace l'add-on? Dillo a un amico! (="

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s ti ha potenziato con %s!"
L["MESSAGE_GAVE_YOU"] = "%s ti ha dato %s!"
L["MESSAGE_GAVE_GROUP"] = "%s ha dato al tuo gruppo %s!"
L["MESSAGE_USED_ITEM"] = "%s ha usato %s %s su di te!"
L["MESSAGE_USED_SPELL"] = "%s ha usato %s su di te!"
L["MESSAGE_SET_OUT"] = "%s ha posizionato %s!"
L["MESSAGE_OPENED"] = "%s ha aperto %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Grazie per %s!"
L["MESSAGE_GOOD_NEWS_DURATION"] = "Buone notizie! Hai %s per %s!"
L["MESSAGE_GOOD_NEWS"] = "Buone notizie! Hai %s!"
L["MESSAGE_PEER_PRESSURE"] = "%s ha usato %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s ha usato %s su %s!"
L["MESSAGE_SELECT_PLAYER"] = "Seleziona un giocatore da ringraziare."
L["MESSAGE_CANT_THANK_SELF"] = "Non puoi ringraziare te stesso!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MESSAGE_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "il suo"
L["PRONOUN_HER"] = "la sua"
L["PRONOUN_THEIR"] = "il loro"
L["UNKNOWN_SPELL"] = "Incantesimo Sconosciuto"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Abilita Messaggio di Benvenuto"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Stampa un messaggio in chat quando accedi."
L["OPTIONS_DESCRIPTION"] =
	"Ringrazia automaticamente con emote, sussurri e notifiche in chat i giocatori che ti potenziano, che sia uno sconosciuto nel mondo aperto o il tempo di recupero di un compagno come Power Infusion o Innervate. Ricevi anche un avviso per banchetti, portali e cooldown della tua classe."
L["OPTIONS_SUPPORT"] = "Feedback e Supporto"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMAND_TFTB"] = "/tftb"
L["OPTIONS_COMMAND_TFTB_DESCRIPTION"] = "Apre l'interfaccia delle opzioni di Thanks for the Buff."
L["OPTIONS_COMMAND_THANKYOU"] = "/thankyou"
L["OPTIONS_COMMAND_THANKYOU_DESCRIPTION"] = "Esegue un'emote e sussurra al tuo bersaglio attuale."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Potenziamenti da Sconosciuti"
L["STRANGERS_DESCRIPTION"] = "Un potenziamento su di te da parte di un giocatore fuori dal tuo gruppo (mondo aperto)."
L["STRANGERS_COOLDOWN"] = "Tempo di Recupero (Secondi)"
L["STRANGERS_COOLDOWN_DESCRIPTION"] =
	"Con quale frequenza massima eseguire un'emote verso lo stesso giocatore.\n\nI messaggi non sono influenzati; vengono inviati per ogni potenziamento."
L["STRANGERS_MIN_DURATION"] = "Durata Minima del Potenziamento (Secondi)"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"La durata minima che il potenziamento deve avere per attivare un ringraziamento.\n\nFiltra cure brevi nel tempo come Rinnovamento o Ringiovanimento."

--------------------------------------------------------------------------------
-- Options: Combat Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Potenziamenti dai Compagni di Squadra"
L["TEAMMATES_DESCRIPTION"] =
	"Un potenziamento o un tempo di recupero di un membro del gruppo o dell'incursione lanciato su di te."

-- Group Services
L["TAB_SERVICES"] = "Servizi di Gruppo"
L["SERVICES_DESCRIPTION"] =
	"Aiuto per l'intera incursione da parte di un membro del gruppo o dell'incursione: banchetti, pozzi delle anime, portali, bot di riparazione."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Buone Notizie"
L["GOOD_NEWS_DESCRIPTION"] = "Informa i giocatori che potenzi di ciò che hai lanciato su di loro e di quanto dura."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Abilita Buone Notizie"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Sussurra al giocatore che hai potenziato per dirgli cosa ha ricevuto e per quanto tempo."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Chiunque potenzi"
L["GOOD_NEWS_SCOPE_GROUP"] = "Solo membri del gruppo"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Pressione Sociale"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Ricevi una notifica quando altri giocatori della tua classe usano i loro tempi di recupero, così puoi cedere alla pressione sociale."
L["PEER_PRESSURE_ENABLE"] = "Abilita Peer Pressure"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Stampa un messaggio nella tua chat quando viene usato un tempo di recupero della tua classe. Lo vedi solo tu."
L["PEER_PRESSURE_OWN_CASTS"] = "Attiva con i tuoi incantesimi"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Attiva la notifica anche quando usi i tuoi tempi di recupero, non solo quelli degli altri giocatori."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Riproduce un suono quando viene usato un tempo di recupero della tua classe. Lo senti solo tu."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Abilità Tracciate"
L["COMBAT_GROUP_ITEMS"] = "Oggetti"
L["COMBAT_TOGGLE_TRACKING"] = "Attiva/Disattiva tracciamento per %s"
L["COMBAT_ITEM_PENDING"] = "Oggetto #%d"
L["COMBAT_SPELL_PENDING"] = "Incantesimo #%d"

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

-- Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
-- spells and items take their names from the client and need no key here.
L["GROUP_PORTALS"] = "Portali"
L["GROUP_SOULSTONE"] = "Pietra dell'Anima"
L["GROUP_RESISTANCE_CAULDRONS"] = "Calderoni di Resistenza"
L["GROUP_SCROLL_OF_SPIRIT"] = "Pergamena dello Spirito"
L["GROUP_SCROLL_OF_STAMINA"] = "Pergamena della Tempra"
L["GROUP_SCROLL_OF_STRENGTH"] = "Pergamena della Forza"
L["GROUP_SCROLL_OF_PROTECTION"] = "Pergamena della Protezione"
L["GROUP_SCROLL_OF_INTELLECT"] = "Pergamena dell'Intelletto"
L["GROUP_SCROLL_OF_AGILITY"] = "Pergamena dell'Agilità"
L["GROUP_REPAIR_BOTS"] = "Robot di Riparazione"
L["GROUP_JUMPER_CABLES"] = "Cavi Elettrici"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Pulsante di Ringraziamento"
L["BUTTON_DESCRIPTION"] = "Ringrazia il tuo bersaglio attuale con un'emote e un sussurro."
L["BUTTON_CREATE_MACRO"] = "Crea Macro"
L["BUTTON_CREATE_MACRO_DESCRIPTION"] = "Crea automaticamente una macro chiamata %s all'accesso."
L["BUTTON_WHISPER"] = "Messaggio di Sussurro"
L["BUTTON_RESET"] = "Ripristina"
L["BUTTON_RESET_DESCRIPTION"] = "Ripristina il messaggio di sussurro al testo predefinito."

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_HEADER"] = "Messaggistica"
L["MESSAGING_PRINT_ENABLE"] = "Abilita Messaggi Stampati"
L["MESSAGING_PRINT_DESCRIPTION"] = "Stampa un messaggio nella tua chat quando ricevi un potenziamento. Lo vedi solo tu."
L["MESSAGING_WHISPER_ENABLE"] = "Abilita Sussurri di Ringraziamento"
L["MESSAGING_WHISPER_DESCRIPTION"] = "Sussurra un ringraziamento al giocatore che ti ha potenziato."
L["MESSAGING_EMOTES_ENABLE"] = "Abilita Emote (Fuori dal Combattimento)"
L["MESSAGING_EMOTES_DESCRIPTION"] =
	"Mostra il tuo apprezzamento con un'emote. Le emote vengono trattenute mentre sei in combattimento."
L["MESSAGING_EMOTES_SELECT"] = "Seleziona Emote"
L["MESSAGING_SOUND_ENABLE"] = "Abilita Effetto Sonoro"
L["MESSAGING_SOUND_DESCRIPTION"] = "Riproduce un suono quando ricevi un potenziamento. Lo senti solo tu."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Grazie, sei il migliore! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "Fai il tifo per <Target>."
L["EMOTE_DRINK_DESCRIPTION"] = "Alzi un bicchiere a <Target>."
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
