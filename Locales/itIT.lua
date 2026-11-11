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
	"Ringrazia automaticamente con un'emote o un sussurro i giocatori che ti potenziano, saluta con la mano amici e compagni di gilda quando gli passi accanto, e ringrazia chiunque tu abbia come bersaglio con un clic sulle tue macro di ringraziamento."
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
-- TRANSLATORS: keep {spell} and {name} exactly as written; they are the tokens players type into the whisper.
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"Imposta cosa sussurra TFTB al giocatore che ti ha potenziato. {spell} viene sostituito dal potenziamento e {name} dal suo nome. Se il campo resta vuoto, non viene inviato alcun sussurro."

-- Notifications
L["NOTIFICATIONS_HEADER"] = "Notifiche"
L["NOTIFICATIONS_DESCRIPTION"] = "Ciò che ricevi solo tu: un messaggio di testo, un suono o entrambi."
L["NOTIFICATIONS_PRINT_ENABLE"] = "Abilita messaggi di testo"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Mostra un messaggio visibile solo a te quando ricevi un potenziamento."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Abilita effetti sonori"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Riproduce un suono quando ricevi un potenziamento. Lo senti solo tu."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Riproduce il suono così puoi ascoltarlo prima di attivarlo."

--------------------------------------------------------------------------------
-- Options: Emotes List
--------------------------------------------------------------------------------

L["TAB_EMOTES_LIST"] = "Elenco emote"
L["EMOTES_GRID_DESCRIPTION"] =
	"Seleziona le emote tra cui la funzione Ringraziamenti può scegliere quando un giocatore fuori dal tuo gruppo ti potenzia; ne usa una a caso. Le emote vengono trattenute mentre sei in combattimento."

--[[
    The emote checklist, shared by this panel and Wave to Friends' Friends and
    Guilds tabs. Its group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS
    entry, upper-cased.
]]
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
-- Options: Wave to Friends
--------------------------------------------------------------------------------

L["TAB_WAVE_TO_FRIENDS"] = "Saluto agli amici"
L["WAVE_ENABLE"] = "Abilita il saluto agli amici"
L["WAVE_ENABLE_DESCRIPTION"] = "Attiva un'emote per amici e compagni di gilda quando passi il mouse sopra di loro."
L["WAVE_DESCRIPTION"] =
	"Saluta amici e compagni di gilda con un'emote quando passi il mouse sopra di loro in giro per il mondo."
L["WAVE_RULES"] = "Mai il tuo gruppo o la tua incursione, e mai in combattimento."
L["WAVE_RESTING_ENABLE"] = "Solo durante il riposo"
L["WAVE_RESTING_ENABLE_DESCRIPTION"] = "Saluta solo mentre riposi, in una città o in una locanda."
L["WAVE_COOLDOWN"] = "Recupero per lo stesso giocatore"
L["WAVE_COOLDOWN_DESCRIPTION"] =
	"Imposta quanto tempo deve passare prima che lo stesso giocatore possa essere salutato di nuovo."
L["WAVE_COOLDOWN_ONCE_PER_SESSION"] = "Una volta per sessione"
-- %s is the default emotes' slash commands, as the client names them.
L["WAVE_EMOTES_RESET_DEFAULTS_DESCRIPTION"] = "Riporta l'elenco solo a %s."

-- Custom List
L["WAVE_TAB_CUSTOM"] = "Elenco personalizzato"
L["WAVE_CUSTOM_DESCRIPTION"] =
	"Giocatori che ricevono sempre la propria emote, anche prima di Amici e Gilde. Scegli Nessuna per non rivolgere mai un'emote a qualcuno."
-- One of these two follows WAVE_CUSTOM_DESCRIPTION: realm clients, then WoW Forever, which has no realms.
L["WAVE_CUSTOM_NAMES_REALM"] =
	"Nome-Reame corrisponde solo a quel reame; un nome da solo corrisponde a qualsiasi reame."
L["WAVE_CUSTOM_NAMES_FOREVER"] =
	"Un nome completo corrisponde a un solo personaggio; un nome proprio da solo corrisponde a tutti quelli che lo portano."
L["WAVE_CUSTOM_ENABLE"] = "Abilita l'elenco personalizzato"
L["WAVE_CUSTOM_ENABLE_DESCRIPTION"] = "Usa i nomi qui sotto prima di Amici e Gilde."
L["WAVE_CUSTOM_OFF_WARNING"] = "L'elenco personalizzato è disattivato, quindi nessuno qui sotto riceve la sua emote."
L["WAVE_CUSTOM_ADD"] = "Aggiungi giocatore"
L["WAVE_CUSTOM_ADD_DESCRIPTION"] = "Digita un nome o Nome-Reame, poi premi Invio. Separa più nomi con delle virgole."
L["WAVE_CUSTOM_ADD_DESCRIPTION_FOREVER"] =
	"Digita un nome completo o un nome proprio, poi premi Invio. Separa più nomi con delle virgole."
L["WAVE_CUSTOM_EMPTY"] = "Ancora nessun giocatore. Aggiungine uno qui sopra."
L["WAVE_CUSTOM_EMOTE_DESCRIPTION"] =
	"Imposta l'emote per questo giocatore, oppure Nessuna per non rivolgergli mai un'emote."
L["WAVE_CUSTOM_REMOVE"] = "Rimuove questo giocatore dall'elenco."

-- Friends
L["WAVE_TAB_FRIENDS"] = "Amici"
L["WAVE_FRIENDS_ENABLE"] = "Saluta gli amici"
L["WAVE_FRIENDS_ENABLE_DESCRIPTION"] = "Saluta i personaggi nella tua lista amici."
L["WAVE_BNET_ENABLE"] = "Includi gli amici Battle.net"
L["WAVE_BNET_ENABLE_DESCRIPTION"] = "Saluta anche i personaggi con cui giocano i tuoi amici Battle.net."
L["WAVE_FRIENDS_EMOTES_DESCRIPTION"] = "Seleziona le emote tra cui scegliere per gli amici; ne viene usata una a caso."

-- Guilds
L["WAVE_TAB_GUILDS"] = "Gilde"
L["WAVE_MY_GUILD_ENABLE"] = "Saluta la mia gilda"
L["WAVE_MY_GUILD_ENABLE_DESCRIPTION"] = "Saluta i membri della gilda di cui fai parte."
L["WAVE_GUILD_ADD"] = "Aggiungi gilda"
L["WAVE_GUILD_ADD_DESCRIPTION"] =
	"Digita il nome di una gilda, poi premi Invio. Separa più gilde con delle virgole. Maiuscole e minuscole non contano."
L["WAVE_GUILDS_EMPTY"] = "Ancora nessun'altra gilda. Aggiungine una qui sopra."
L["WAVE_GUILD_REMOVE"] = "Rimuove questa gilda dall'elenco."
L["WAVE_GUILDS_EMOTES_DESCRIPTION"] =
	"Seleziona le emote tra cui scegliere per i membri della gilda; ne viene usata una a caso."

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks and each Thank You Button.
L["WHISPER_MESSAGE"] = "Messaggio sussurrato"
L["WHISPER_MESSAGE_RESET"] = "Ripristina"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Ripristina il testo predefinito del messaggio sussurrato."

-- The whisper composer around the Give Thanks message box.
L["SEND_MESSAGES_IN"] = "Invia messaggi in"
L["SEND_MESSAGES_IN_DESCRIPTION"] =
	"Imposta la lingua in cui TFTB scrive agli altri giocatori. Scegliendo un'altra lingua viene usato il suo messaggio predefinito, a meno che tu non abbia scritto il tuo."
L["WHISPER_SIGN_OFF_DESCRIPTION"] = "Aggiunto a ogni messaggio inviato da TFTB, così gli altri giocatori capiscono che viene da un add-on."
-- TRANSLATORS: each %s is a token, {spell} then {name}, drawn in blue.
L["WHISPER_TOKENS"] = "Segnaposto: %s il potenziamento, %s chi l'ha lanciato"
L["WHISPER_ROOM_LEFT"] = "Spazio rimasto: %d"
L["WHISPER_ROOM_LEFT_DESCRIPTION"] =
	"Quanto entra ancora nel sussurro, misurato con il potenziamento di esempio. Alcuni caratteri contano più di uno, e un potenziamento con un nome più lungo lascia meno spazio."
L["WHISPER_TOO_LONG"] = "Troppo lungo. TFTB invierà invece il messaggio predefinito."
L["WHISPER_TEST"] = "Invia una prova a me"
L["WHISPER_TEST_DESCRIPTION"] = "Ti sussurra l'esempio, così lo vedi esattamente come lo vedranno gli altri giocatori."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Grazie, sei un mito! (="
