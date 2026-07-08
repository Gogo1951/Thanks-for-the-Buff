local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "itIT")
if not L then return end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff (TFTB)"
L["ADDON_SHORT"] = "TFTB"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] = "Versione %s. Le impostazioni (inclusa l'opzione per disabilitare questo messaggio) si trovano in Opzioni > AddOn > Thanks for the Buff. Ti piace l'add-on? Dillo a un amico! (="
L["MSG_RESET"] = "Tutte le impostazioni sono state ripristinate ai valori predefiniti."

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s ti ha potenziato con %s!"
L["MSG_GAVE_YOU"] = "%s ti ha dato %s!"
L["MSG_GAVE_GROUP"] = "%s ha dato al tuo gruppo %s!"
L["MSG_USED_ITEM"] = "%s ha usato %s %s su di te!"
L["MSG_USED_SPELL"] = "%s ha usato %s su di te!"
L["MSG_SET_OUT"] = "%s ha posizionato %s!"
L["MSG_OPENED"] = "%s ha aperto %s!"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "Grazie per %s!"
L["MSG_SELECT_PLAYER"] = "Seleziona un giocatore da ringraziare."
L["MSG_CANT_THANK_SELF"] = "Non puoi ringraziare te stesso!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MSG_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "il suo"
L["PRONOUN_HER"] = "la sua"
L["PRONOUN_THEIR"] = "il loro"
L["UNKNOWN_SPELL"] = "Incantesimo Sconosciuto"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Abilita Messaggio di Benvenuto"
L["OPTIONS_WELCOME_DESC"] = "Stampa un messaggio in chat quando accedi."
L["OPTIONS_RESET_ALL_PROFILES"] = "Ripristina Tutti i Profili"
L["OPTIONS_RESET_ALL_PROFILES_DESCRIPTION"] = "Ripristina tutti i profili di questo account alle impostazioni predefinite."
L["OPTIONS_RESET_ALL_PROFILES_CONFIRM"] = "Questo ripristinerà TUTTI i profili del tuo account alle impostazioni predefinite, ogni personaggio. L'operazione è irreversibile. Continuare?"
L["OPTIONS_DESCRIPTION"] = "Esprimi automaticamente apprezzamento con emote e messaggi ogni volta che ricevi un potenziamento, che si tratti di uno sconosciuto nel mondo aperto o di un compagno di squadra che usa un tempo di recupero per te in combattimento."
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
L["STRANGERS_DESC"] = "Un potenziamento su di te da parte di un giocatore fuori dal tuo gruppo (mondo aperto)."
L["STRANGERS_COOLDOWN"] = "Tempo di Recupero (Secondi)"
L["STRANGERS_COOLDOWN_DESC"] = "Con quale frequenza massima eseguire un'emote verso lo stesso giocatore.\n\nI messaggi non sono influenzati; vengono inviati per ogni potenziamento."
L["STRANGERS_MIN_DURATION"] = "Durata Minima del Potenziamento (Secondi)"
L["STRANGERS_MIN_DURATION_DESC"] = "La durata minima che il potenziamento deve avere per attivare un ringraziamento.\n\nFiltra cure brevi nel tempo come Rinnovamento o Ringiovanimento."
L["STRANGERS_MESSAGING"] = "Messaggistica"
L["STRANGERS_EMOTES_SELECT"] = "Seleziona Emote"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

L["TEAMMATES_TITLE"] = "Potenziamenti dai Compagni di Squadra"
L["TEAMMATES_DESC"] = "Un potenziamento o un tempo di recupero di un membro del gruppo o dell'incursione lanciato su di te."
L["SERVICES_TITLE"] = "Servizi di Gruppo"
L["SERVICES_DESC"] = "Aiuto per l'intera incursione da parte di un membro del gruppo o dell'incursione: banchetti, pozzi delle anime, portali, bot di riparazione."
L["COMBAT_MESSAGING"] = "Messaggistica"
L["COMBAT_EMOTES_SELECT"] = "Seleziona Emote"
L["COMBAT_TRACKED"] = "Abilità Tracciate:"
L["COMBAT_TOGGLE_TRACKING"] = "Attiva/Disattiva tracciamento per %s"
L["COMBAT_GROUP_ITEMS"] = "Oggetti"
L["COMBAT_ITEM_PENDING"] = "Oggetto #%d"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Pulsante di Ringraziamento"
L["BUTTON_DESC"] = "Ringrazia il tuo bersaglio attuale con un'emote e un sussurro."
L["BUTTON_CREATE_MACRO"] = "Crea Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Una macro chiamata %s verrà creata automaticamente per te all'accesso."
L["BUTTON_WHISPER"] = "Messaggio di Sussurro"
L["BUTTON_RESET"] = "Ripristina"
L["BUTTON_RESET_DESC"] = "Ripristina il messaggio di sussurro al testo predefinito."
L["BUTTON_EMOTES_SELECT"] = "Seleziona Emote"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_PRINT_ENABLE"] = "Abilita Messaggi Stampati (Solo per te)"
L["MESSAGING_PRINT_DESC"] = "Stampa un messaggio nella tua chat quando ricevi un potenziamento. Lo vedi solo tu."
L["MESSAGING_WHISPER_ENABLE"] = "Abilita Messaggi di Ringraziamento"
L["MESSAGING_WHISPER_DESC"] = "Sussurra un ringraziamento al giocatore che ti ha potenziato."
L["MESSAGING_EMOTES_ENABLE"] = "Abilita Emote (Fuori dal Combattimento)"
L["MESSAGING_EMOTES_DESC"] = "Mostra il tuo apprezzamento con un'emote. Le emote vengono trattenute mentre sei in combattimento."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Grazie, sei il migliore! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESC"] = "Fai il tifo per <Target>."
L["EMOTE_DRINK_DESC"] = "Alzi un bicchiere a <Target>."
L["EMOTE_FLEX_DESC"] = "Mostri i muscoli a <Target>."
L["EMOTE_GRIN_DESC"] = "Sorridi maliziosamente a <Target>."
L["EMOTE_HIGHFIVE_DESC"] = "Dai il cinque a <Target>."
L["EMOTE_PRAISE_DESC"] = "Lodi <Target>."
L["EMOTE_SALUTE_DESC"] = "Saluti <Target> con rispetto."
L["EMOTE_SMILE_DESC"] = "Sorridi a <Target>."
L["EMOTE_THANK_DESC"] = "Ringrazi <Target>."
L["EMOTE_WHOA_DESC"] = "Guardi <Target> ed esclami 'Wow!'"
L["EMOTE_WINK_DESC"] = "Fai l'occhiolino a <Target>."
L["EMOTE_YES_DESC"] = "Annuisci a <Target>."
