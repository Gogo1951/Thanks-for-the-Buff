local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "itIT")
if not L then return end

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["MSG_ENABLED"] = "Abilitato. Usa /tftb per modificare le tue impostazioni, incluso lo spegnimento di questo messaggio. (="
L["MSG_DB_ERROR"] = "Errore: Impossibile caricare le impostazioni predefinite del database. Ripristina il tuo profilo tramite /tftb."
L["MSG_RESET"] = "Tutte le impostazioni sono state ripristinate ai valori predefiniti."
L["MSG_BUFFED"] = "%s ti ha potenziato con %s!"
L["MSG_HIT"] = "%s ti ha colpito con %s!"
L["MSG_PARTY_ITEM"] = "%s ha usato %s per il tuo gruppo!"
L["MSG_WHISPER_THANKS"] = "Grazie per %s!"
L["MSG_SELECT_PLAYER"] = "Seleziona un giocatore da ringraziare."
L["MSG_CANT_THANK_SELF"] = "Non puoi ringraziare te stesso!"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_TITLE"] = "Thanks for the Buff!"
L["OPTIONS_GENERAL"] = "Impostazioni Generali"
L["OPTIONS_WELCOME_TOGGLE"] = "Abilita Messaggio di Benvenuto"
L["OPTIONS_WELCOME_DESC"] = "Stampa un messaggio in chat quando accedi."
L["OPTIONS_RESET"] = "Ripristina"
L["OPTIONS_RESET_ALL"] = "Ripristina Tutte le Impostazioni"
L["OPTIONS_RESET_ALL_DESC"] = "Ripristina ogni opzione al suo valore predefinito."
L["OPTIONS_RESET_CONFIRM"] = "Sei sicuro di voler ripristinare tutte le impostazioni ai valori predefiniti?"
L["OPTIONS_DESCRIPTION"] = "Esprimi automaticamente felicità con un'emote ogni volta che ricevi un nuovo potenziamento."
L["OPTIONS_SUPPORT"] = "Feedback e Supporto"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Apre l'interfaccia delle opzioni di Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Esegue un'emote e sussurra al giocatore che hai selezionato come bersaglio."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "Potenziamenti da Sconosciuti"
L["STRANGERS_ENABLE"] = "Reagisci ai Potenziamenti da Sconosciuti"
L["STRANGERS_COOLDOWN"] = "Tempo di Recupero (Secondi)"
L["STRANGERS_COOLDOWN_DESC"] = "Con quale frequenza massima ringraziare lo stesso giocatore."
L["STRANGERS_MIN_DURATION"] = "Durata Minima del Potenziamento (Secondi)"
L["STRANGERS_MIN_DURATION_DESC"] = "La durata minima che il potenziamento deve avere per attivare un ringraziamento.\n\nFiltra cure brevi nel tempo come Rinnovamento o Ringiovanimento."
L["STRANGERS_MESSAGING"] = "Messaggistica"
L["STRANGERS_EMOTES_ENABLE"] = "Abilita Emote"
L["STRANGERS_EMOTES_DESC"] = "Usa le emote per apprezzare i potenziamenti ricevuti da sconosciuti."
L["STRANGERS_EMOTES_SELECT"] = "Seleziona Emote"

--------------------------------------------------------------------------------
-- Options: Combat Buffs
--------------------------------------------------------------------------------

L["COMBAT_TITLE"] = "Potenziamenti di Combattimento"
L["COMBAT_MESSAGING"] = "Messaggistica"
L["COMBAT_TRACKED"] = "Abilità Tracciate:"
L["COMBAT_TOGGLE_TRACKING"] = "Attiva/Disattiva tracciamento per %s"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Pulsante di Ringraziamento"
L["BUTTON_CREATE_MACRO"] = "Crea Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Una macro chiamata %s verrà creata automaticamente per te all'accesso."
L["BUTTON_WHISPER"] = "Messaggio di Sussurro"
L["BUTTON_RESET"] = "Ripristina"
L["BUTTON_RESET_DESC"] = "Ripristina il messaggio di sussurro al testo predefinito."
L["BUTTON_EMOTES_HEADER"] = "Emote del Pulsante di Ringraziamento:"
L["BUTTON_EMOTES_SELECT"] = "Seleziona Emote"

--------------------------------------------------------------------------------
-- Shared: Messaging Dropdown
--------------------------------------------------------------------------------

L["MESSAGING_NONE"] = "Nessun Messaggio"
L["MESSAGING_NONE_DEFAULT"] = "Nessun Messaggio (Predefinito)"
L["MESSAGING_PRINT"] = "Messaggio Stampato (Solo per te)"
L["MESSAGING_WHISPER"] = "Messaggio di Sussurro"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Grazie, sei il migliore! (="