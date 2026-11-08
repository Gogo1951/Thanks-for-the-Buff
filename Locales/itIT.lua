local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "itIT")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff (TFTB)" -- Full Name
L["ADDON_SHORT_NAME"] = "TFTB" -- Short Name

--------------------------------------------------------------------------------
-- Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"Versione %s. Le impostazioni (inclusa l'opzione per disabilitare questo messaggio) si trovano in Opzioni > AddOn > Thanks for the Buff (TFTB). Ti piace questo add-on? Dillo a un amico, aggiungilo ai preferiti su CurseForge o lasciagli una Star su GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] =
	"Per precauzione, l'interfaccia delle opzioni non può essere aperta durante il combattimento."

-- Buff print out
L["MESSAGE_BUFFED"] = "%s ti ha potenziato con %s!"

-- Thank You Button
L["MESSAGE_SELECT_PLAYER"] = "Prima prendi un giocatore come bersaglio."
L["MESSAGE_CANT_THANK_SELF"] = "Non puoi ringraziare te stesso!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Incantesimo sconosciuto"
L["SAMPLE_EXAMPLE"] = "Esempio: %s"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Abilita messaggio di benvenuto"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Mostra un messaggio visibile solo a te quando accedi."
L["OPTIONS_DESCRIPTION"] =
	"Ringrazia automaticamente con un'emote o un sussurro i giocatori che ti potenziano. Gli sconosciuti che ti lanciano Fortitude, Arcane Intellect o Mark of the Wild vengono ringraziati all'istante, e un clic sulle tue macro di ringraziamento ringrazia chiunque tu abbia come bersaglio."
L["OPTIONS_FEATURES_HEADER"] = "Funzionalità"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Attiva o disattiva ogni funzionalità qui o nel suo pannello."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Apre l'interfaccia delle opzioni di questo add-on."

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "Cerchi altre funzionalità?"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"Alcune funzionalità sono state spostate nel nostro nuovo add-on, Good to Go. Lo trovi su CurseForge o Wago."

--------------------------------------------------------------------------------
-- Options: Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "Aiuta Thanks for the Buff (TFTB) a salire di livello"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"Questo add-on è stato creato da giocatori che amano questo gioco e vogliono renderlo il più divertente possibile per tutti. Non chiederemo mai donazioni. La vera soddisfazione è sapere che il nostro lavoro rende il gioco un po' migliore per te. Se è così, ci farebbe piacere saperlo!"
L["OPTIONS_LEVEL_UP_WAYS"] = "Ecco alcuni modi in cui puoi aiutarci a raggiungere più giocatori."
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• Condividi un feedback: hai trovato un bug o hai un'idea? Faccelo sapere su Discord. Il tuo feedback ci aiuta a migliorare l'add-on e le pull request sono sempre benvenute."
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• Dillo a un amico: conosci qualcuno a cui potrebbe piacere questo add-on? Parlagliene. Il passaparola aiuta più giocatori a scoprire ottimi add-on."
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	"• Aggiungilo ai preferiti su CurseForge: apri il link di CurseForge qui sotto, accedi e clicca sulla stella sotto il pulsante Download. I preferiti aiutano più giocatori a scoprire l'add-on."
L["OPTIONS_LEVEL_UP_GITHUB"] =
	"• Lascia una Star su GitHub: apri il link di GitHub qui sotto, accedi e clicca su Star in alto a destra. Le Star aiutano il progetto a ottenere l'accesso a più strumenti di sviluppo gratuiti."
L["OPTIONS_LEVEL_UP_THANKS"] = "Grazie per aver scelto Thanks for the Buff (TFTB)!"

L["OPTIONS_FEEDBACK"] = "Feedback e supporto"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "Link per feedback e supporto"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "Per copiare un link, clicca nel suo riquadro, poi premi Ctrl+A e Ctrl+C."
L["OPTIONS_VERSION"] = "Versione %s"

--------------------------------------------------------------------------------
-- Options: Give Thanks
--------------------------------------------------------------------------------

L["TAB_GIVE_THANKS"] = "Ringraziamenti"
L["GIVE_THANKS_ENABLE"] = "Abilita i ringraziamenti"
L["GIVE_THANKS_ENABLE_DESCRIPTION"] =
	"Attiva i ringraziamenti per i potenziamenti ricevuti da giocatori fuori dal tuo gruppo."
L["GIVE_THANKS_DESCRIPTION"] = "Ringrazia i giocatori fuori dal tuo gruppo quando ti potenziano nel mondo aperto."

-- Praise Limits
L["PRAISE_HEADER"] = "Limiti dei ringraziamenti"
L["PRAISE_DESCRIPTION"] =
	"Queste impostazioni trattengono sia l'emote sia il sussurro, così un'ondata di potenziamenti non diventa mai spam."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["GIVE_THANKS_OVERALL_COOLDOWN"] = "Recupero dei ringraziamenti"
L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Imposta il ritardo tra un giro di ringraziamenti e il successivo, chiunque ti abbia potenziato. Con zero si ringrazia per ogni potenziamento."
L["GIVE_THANKS_SOURCE_COOLDOWN"] = "Recupero dei ringraziamenti allo stesso giocatore"
L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Imposta il ritardo tra i ringraziamenti rivolti allo stesso giocatore. Con zero si ringrazia per ogni potenziamento."
L["GIVE_THANKS_MIN_DURATION"] = "Durata minima del potenziamento"
L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"] =
	"Ignora i potenziamenti più brevi di questo valore. Con zero si reagisce a ogni potenziamento."
L["PRAISE_DELAY_ENABLE"] = "Abilita ritardo del ringraziamento"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Attende un momento prima del sussurro e dell'emote, così il tuo ringraziamento non arriva nello stesso istante del potenziamento. Le notifiche non vengono influenzate."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Imposta quanto attendere prima di inviare il sussurro e l'emote."

-- Thank-You Whispers
L["WHISPERS_HEADER"] = "Sussurri di ringraziamento"
L["PRAISE_WHISPER_ENABLE"] = "Abilita sussurri di ringraziamento"
L["PRAISE_WHISPER_DESCRIPTION"] = "Sussurra un ringraziamento al giocatore che ti ha potenziato."
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"Imposta cosa sussurra TFTB al giocatore che ti ha potenziato. {spell} viene sostituito dal potenziamento. Se il campo resta vuoto, non viene inviato alcun sussurro."

-- Notifications
L["NOTIFICATIONS_HEADER"] = "Notifiche"
L["NOTIFICATIONS_DESCRIPTION"] = "Ciò che ricevi solo tu: un messaggio di testo, un suono o entrambi."
L["NOTIFICATIONS_PRINT_ENABLE"] = "Abilita messaggi di testo"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Mostra un messaggio visibile solo a te quando ricevi un potenziamento."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Abilita effetti sonori"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Riproduce un suono quando ricevi un potenziamento. Lo senti solo tu."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Riproduce il suono così puoi ascoltarlo prima di attivarlo."

-- Emotes: the grid's group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS entry, upper-cased.
L["TAB_EMOTES_LIST"] = "Elenco emote"
L["EMOTES_GRID_DESCRIPTION"] =
	"Seleziona le emote tra cui la funzione Ringraziamenti può scegliere quando un giocatore fuori dal tuo gruppo ti potenzia; ne usa una a caso. Le emote vengono trattenute mentre sei in combattimento."
L["EMOTE_GROUP_COUNT"] = "%s (%d di %d selezionate)"
L["EMOTE_GROUP_TEXT"] = "Testo"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "Mostra solo la riga dell'emote."
L["EMOTE_GROUP_VOICE"] = "Voce"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "Riproduce una battuta parlata."
L["EMOTE_GROUP_GESTURE"] = "Gesto"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "Riproduce una breve animazione."
L["EMOTE_GROUP_POSE"] = "Posa"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "Dura finché non ti muovi."
L["EMOTES_RESET"] = "Ripristina le emote"
L["EMOTES_RESET_DESCRIPTION"] = "Riporta l'elenco alle emote di ringraziamento predefinite."
L["EMOTES_RESET_CONFIRM"] = "Ripristinare l'elenco delle emote ai valori predefiniti?"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "Potenziamenti ignorati"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"I potenziamenti in questo elenco non ricevono mai un ringraziamento, chiunque li lanci. Ricevi comunque il tuo messaggio di testo e il suono."
L["IGNORED_BUFFS_ADD_CURRENT"] = "Ignora potenziamento attuale"
L["IGNORED_BUFFS_ADD_CURRENT_DESCRIPTION"] = "Aggiunge uno dei potenziamenti che hai addosso in questo momento."
L["IGNORED_BUFFS_ADD"] = "Aggiungi potenziamento"
L["IGNORED_BUFFS_ADD_DESCRIPTION"] =
	"Digita un ID incantesimo, oppure fai Maiusc-clic sul link di un potenziamento per inserirlo nel campo, poi premi Invio."
L["IGNORED_BUFFS_EMPTY"] = "Nessun potenziamento ignorato per ora. Aggiungine uno qui sopra."
L["IGNORED_BUFFS_REMOVE"] = "Rimuove questo potenziamento dall'elenco."
L["IGNORED_BUFFS_NOT_FOUND"] = "Nessun potenziamento trovato per %s."
L["IGNORED_BUFFS_ALL_CHARACTERS"] = "Tutti i personaggi"
L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"] =
	"Sposta questo potenziamento nell'elenco Tutti i personaggi, così non viene ringraziato su nessun personaggio."

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Pulsante di ringraziamento"
L["BUTTON_DESCRIPTION"] =
	"Sussurra al tuo bersaglio e rivolgigli un'emote con un solo tasto. Buone maniere, automatizzate."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Pulsante di ringraziamento %d"
L["BUTTON_EMOTE"] = "Emote"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Imposta l'emote che questo pulsante esegue sul tuo bersaglio, oppure Nessuna per non usare alcuna emote."
L["BUTTON_EMOTE_NONE"] = "Nessuna"
-- Titles Thank You Button 1's emote checklist.
L["EMOTES_SELECT"] = "Seleziona le emote"
L["BUTTON_ICON"] = "Icona"
L["BUTTON_ICON_DESCRIPTION"] =
	"Imposta l'icona che la macro di questo pulsante mostra nell'elenco delle macro e sulle barre delle azioni."
-- The Icon dropdown's first choice, the macros' own icon; every other choice is a picture alone.
L["BUTTON_ICON_DEFAULT"] = "Predefinita"
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
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks and each Thank You Button.
L["WHISPER_MESSAGE"] = "Messaggio sussurrato"
L["WHISPER_MESSAGE_RESET"] = "Ripristina"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Ripristina il testo predefinito del messaggio sussurrato."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Grazie, sei un mito! (="
-- TRANSLATORS: keep {spell} exactly as written; TFTB swaps in the buff's link.
L["DEFAULT_GIVE_THANKS_WHISPER"] = "Grazie per {spell}"
