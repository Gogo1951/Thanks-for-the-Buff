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

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Grazie per %s"
L["MESSAGE_SELECT_PLAYER"] = "Prima prendi un giocatore come bersaglio."
L["MESSAGE_CANT_THANK_SELF"] = "Non puoi ringraziare te stesso!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Incantesimo sconosciuto"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Abilita messaggio di benvenuto"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Mostra un messaggio visibile solo a te quando accedi."
L["OPTIONS_DESCRIPTION"] =
	"Ringrazia automaticamente con un sussurro o un'emote ogni giocatore che ti potenzia, e ringrazia chiunque a mano con un clic sulle tue macro di ringraziamento. Buone maniere, in automatico."
L["OPTIONS_FEATURES_HEADER"] = "Funzionalità"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Attiva o disattiva ogni funzionalità qui o nel suo pannello."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Apre l'interfaccia delle opzioni di questo add-on."
L["SAMPLE_EXAMPLE"] = "Esempio: %s"

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
-- Options: Stranger Buffs
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- Options: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers the Stranger Buffs panel is built from: what the
    other player sees, then what only you get. Key prefixes match the header
    the control appears under.
]]
L["PRAISE_HEADER"] = "Sussurri di ringraziamento ed emote"
L["NOTIFICATIONS_HEADER"] = "Notifiche"
L["PRAISE_DESCRIPTION"] = "Ciò che vede l'altro giocatore: un sussurro di ringraziamento, un'emote o entrambi."
L["NOTIFICATIONS_DESCRIPTION"] = "Ciò che ricevi solo tu: un messaggio di testo, un suono o entrambi."

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

L["NOTIFICATIONS_PRINT_ENABLE"] = "Abilita messaggi di testo"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Mostra un messaggio visibile solo a te quando ricevi un potenziamento."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Abilita effetti sonori"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Riproduce un suono quando ricevi un potenziamento. Lo senti solo tu."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Riproduce il suono così puoi ascoltarlo prima di attivarlo."

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

-- Each button's whisper box
L["WHISPER_MESSAGE"] = "Messaggio sussurrato"
L["WHISPER_MESSAGE_RESET"] = "Ripristina"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Ripristina il testo predefinito del messaggio sussurrato."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Grazie, sei un mito! (="

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
