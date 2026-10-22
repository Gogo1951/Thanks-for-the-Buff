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
-- Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"Versione %s. Le impostazioni (inclusa l'opzione per disabilitare questo messaggio) si trovano in Opzioni > AddOn > Thanks for the Buff (TFTB). Ti piace questo add-on? Dillo a un amico, aggiungilo ai preferiti su CurseForge o lasciagli una Star su GitHub. (="
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
L["MESSAGE_SELECT_PLAYER"] = "Prima prendi un giocatore come bersaglio."
L["MESSAGE_CANT_THANK_SELF"] = "Non puoi ringraziare te stesso!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Incantesimo sconosciuto"

--------------------------------------------------------------------------------
-- Mini-map Button
--------------------------------------------------------------------------------

L["MINIMAP_OPTIONS"] = "Opzioni di Thanks for the Buff (TFTB)"
L["LEFT_CLICK"] = "Clic sinistro"
L["RIGHT_CLICK"] = "Clic destro"
L["SHIFT_LEFT_CLICK"] = "Maiusc + Clic sinistro"
L["SHIFT_RIGHT_CLICK"] = "Maiusc + Clic destro"
L["SHIFT_MIDDLE_CLICK"] = "Maiusc + Clic centrale"
L["ACTION_TOGGLE"] = "Attiva/Disattiva"
L["ENABLED"] = "Attivato"
L["DISABLED"] = "Disattivato"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Abilita messaggio di benvenuto"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Mostra un messaggio visibile solo a te quando accedi."
L["OPTIONS_ENABLE_MINIMAP"] = "Abilita pulsante della minimappa"
L["OPTIONS_ENABLE_MINIMAP_DESCRIPTION"] =
	"Mostra il pulsante di TFTB sulla minimappa, che attiva e disattiva le funzioni con un clic."
L["OPTIONS_DESCRIPTION"] =
	"Ringrazia automaticamente con un sussurro o un'emote ogni giocatore che ti potenzia e non lasciare mai senza potenziamenti la tua incursione, te e le tue armi, grazie a un promemoria dei potenziamenti mancanti dove basta un clic per lanciarli. In più, avvisi per banchetti, portali, evocazioni e pozzi delle anime. Buone maniere, in automatico."
L["OPTIONS_FEATURES_HEADER"] = "Funzionalità"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Attiva o disattiva ogni funzionalità qui o nel suo pannello."
L["OPTIONS_FEATURES_NOTE"] =
	'Alcune delle nostre funzionalità più recenti, come "%s", vanno oltre l\'ambito tradizionale di "Thanks for the Buff". Sentiti libero di disattivare tutto ciò che non ti serve. Queste funzionalità potrebbero passare al nostro altro add-on, "Connoisseur & Restocker", oppure tutto potrebbe confluire in un add-on più grande, magari "Buttons, Buffs, & Bags". Facci sapere cosa ne pensi su Discord, CurseForge o GitHub. Grazie!'
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Apre l'interfaccia delle opzioni di questo add-on."
L["OPTIONS_EXAMPLE"] = "Esempio: %s"

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
	"Reagisci quando qualcuno mette a disposizione un aiuto per il tuo gruppo: banchetti, pozzi delle anime, portali e robot di riparazione."

-- Send Good News
L["TAB_GOOD_NEWS"] = "Invia buone notizie"
L["GOOD_NEWS_DESCRIPTION"] =
	"Informa i giocatori che potenzi di ciò che hai lanciato su di loro e, per i potenziamenti brevi, di quanto dura."
L["GOOD_NEWS_ENABLE"] = "Abilita buone notizie"
L["GOOD_NEWS_ENABLE_DESCRIPTION"] =
	"Attiva un sussurro che comunica ai giocatori che potenzi ciò che hai lanciato su di loro."
L["GOOD_NEWS_SCOPE"] = "Destinatari"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Chiunque potenzi"
L["GOOD_NEWS_SCOPE_GROUP"] = "Solo membri del gruppo"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Imposta chi riceve il sussurro delle buone notizie: chiunque potenzi, oppure solo i membri del tuo gruppo."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Messaggio delle buone notizie"
L["GOOD_NEWS_MESSAGES_DESCRIPTION"] = "Il sussurro che ricevono i giocatori che potenzi."
--[[
    The message box's tooltip, in three parts. LIMIT's %d is a real placeholder
    and gets formatted; TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_INPUT_DESCRIPTION"] =
	"Imposta cosa dice il sussurro. Lascialo vuoto per usare il testo predefinito."
L["GOOD_NEWS_MESSAGE_LIMIT"] = "Lunghezza massima: %d."
L["GOOD_NEWS_MESSAGE_TOKENS"] =
	"%a diventa il collegamento all'abilità, con la sua durata quando è inferiore a un minuto."
--[[
    Appended to the ability link inside %a when the buff has a readable duration
    under a minute. A whole clause rather than a bare number so it can be reworded
    per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "per %s"

-- Peer Pressure (TEMPORARY: delete on or after 2026-11-21, with Options/Options-Peer-Pressure.lua)
L["TAB_PEER_PRESSURE"] = "Pressione sociale"
L["PEER_PRESSURE_CONTROL_FREAK"] = "Control Freak"
L["PEER_PRESSURE_MOVED"] =
	'WoW Forever non permette agli add-on di leggere il registro di combattimento, quindi stiamo riorganizzando i nostri add-on perché funzionino allo stesso modo in ogni versione del gioco. "Pressione sociale" si è spostata nel nostro altro add-on, "Control Freak". Installalo per continuare a ricevere avvisi quando i giocatori della tua classe usano i loro tempi di recupero.'

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Abilità tracciate"
L["TRACKED_GROUP_ITEMS"] = "Oggetti"
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
    sees, then what only you get. Key prefixes match the header the control
    appears under.
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
-- Options: Buff Duty
--------------------------------------------------------------------------------

L["TAB_BUFF_WINDOW"] = "Turno dei potenziamenti"
L["BUFF_WINDOW_DESCRIPTION"] = "Mostra a chi mancano i tuoi potenziamenti. Clicca su un'icona per lanciarlo."
L["BUFF_WINDOW_ENABLE"] = "Abilita turno dei potenziamenti"
L["BUFF_WINDOW_ENABLE_DESCRIPTION"] =
	"Attiva il turno dei potenziamenti, la finestra dei membri del gruppo a cui manca un potenziamento che puoi lanciare."
L["BUFF_WINDOW_NO_BUFFS"] =
	"La tua classe non ha potenziamenti in questa lista, quindi la finestra non compare mai con questo personaggio."
-- When to Show: Solo and In Group, each with Always or In Instance, then the classes.
L["BUFF_WINDOW_WHEN_HEADER"] = "Quando mostrare"
L["BUFF_WINDOW_WHEN_DESCRIPTION"] = "Scegli quando la finestra può apparire."
L["BUFF_WINDOW_WHEN_SOLO"] = "Da solo"
L["BUFF_WINDOW_WHEN_SOLO_DESCRIPTION"] = "Mostra la finestra quando non sei in un gruppo o in un'incursione."
L["BUFF_WINDOW_WHEN_GROUP"] = "In gruppo"
L["BUFF_WINDOW_WHEN_GROUP_DESCRIPTION"] = "Mostra la finestra quando sei in un gruppo o in un'incursione."
L["BUFF_WINDOW_WHERE_DESCRIPTION"] =
	"Imposta dove appare la finestra: ovunque, o solo in spedizioni, incursioni, campi di battaglia e arene."
L["BUFF_WINDOW_WHERE_ALWAYS"] = "Sempre"
L["BUFF_WINDOW_WHERE_INSTANCE"] = "In istanza"
L["BUFF_WINDOW_CLASSES_DESCRIPTION"] = "Mostra la finestra quando giochi queste classi."
L["BUFF_WINDOW_CLASS_DESCRIPTION"] = "Mostra la finestra quando giochi questa classe."
L["BUFF_WINDOW_HEADER"] = "Finestra"
L["BUFF_WINDOW_WINDOW_DESCRIPTION"] = "Tieni la finestra dove l'hai messa, o toglila di mezzo in combattimento."
L["BUFF_WINDOW_LOCK"] = "Blocca la finestra"
L["BUFF_WINDOW_LOCK_DESCRIPTION"] = "Impedisce di spostare la finestra. Quando è sbloccata, trascinala dallo sfondo."
L["BUFF_WINDOW_HIDE_IN_COMBAT"] = "Nascondi in combattimento"
L["BUFF_WINDOW_HIDE_IN_COMBAT_DESCRIPTION"] =
	"Nasconde la finestra durante il combattimento. In combattimento la lista non può aggiornarsi, quindi una finestra lasciata visibile mantiene il suo ultimo stato fino alla fine del combattimento."
L["BUFF_WINDOW_SHOW_HEADER"] = "Mostra nella finestra"
L["BUFF_WINDOW_SHOW_DESCRIPTION"] =
	"Aggiungi alla finestra i tuoi potenziamenti, gli sconosciuti che ti hanno potenziato e il tuo bersaglio."
L["BUFF_WINDOW_FAVOR_ENABLE"] = "Ricambia il favore"
L["BUFF_WINDOW_FAVOR_ENABLE_DESCRIPTION"] =
	"Elenca gli sconosciuti che ti hanno potenziato di recente, con i potenziamenti che puoi restituire loro. Clic destro su un'icona per togliere qualcuno dalla lista."
L["BUFF_WINDOW_FAVOR_SECONDS_DESCRIPTION"] =
	"Imposta per quanto tempo uno sconosciuto resta nella lista dopo il suo ultimo potenziamento."
L["BUFF_WINDOW_TARGET_ENABLE"] = "Il tuo bersaglio"
L["BUFF_WINDOW_TARGET_ENABLE_DESCRIPTION"] =
	"Elenca il tuo bersaglio quando è un giocatore fuori dal tuo gruppo a cui manca un potenziamento che puoi lanciare."
L["BUFF_WINDOW_REFRESH"] = "Rinnova sotto"
L["BUFF_WINDOW_REFRESH_DESCRIPTION"] =
	"Imposta sotto quale tempo residuo un potenziamento viene considerato mancante, così puoi rinnovarlo prima che svanisca. Un potenziamento che non dura più di questo tempo conta solo quando è svanito."
-- Count as Tanks: one dropdown per class, then Pets, each with these three choices.
L["BUFF_WINDOW_TANKS_HEADER"] = "Considera come difensori"
L["BUFF_WINDOW_TANKS_DESCRIPTION"] =
	"Chi riceve i potenziamenti che offri ai Difensori, come Thorns, quando non ha un ruolo proprio."
L["BUFF_WINDOW_TANKS_CLASS_DESCRIPTION"] =
	"Imposta quando i giocatori di questa classe contano come difensori. Un ruolo da difensore o guaritore che abbiano ha sempre la precedenza."
L["BUFF_WINDOW_TANKS_PETS"] = "Famigli"
L["BUFF_WINDOW_TANKS_PETS_DESCRIPTION"] =
	"Imposta quando i famigli contano come difensori. I famigli ricevono anche i potenziamenti che offri a Tutti."
L["BUFF_WINDOW_TANKS_NEVER"] = "Mai"
L["BUFF_WINDOW_TANKS_SOLO"] = "Quando non sei in gruppo"
L["BUFF_WINDOW_TANKS_ALWAYS"] = "Sempre"
-- Who each buff is offered to: one dropdown per buff, these four choices.
L["BUFF_WINDOW_AUDIENCE_OFF"] = "Disattivato"
L["BUFF_WINDOW_AUDIENCE_TANK"] = "Difensori"
L["BUFF_WINDOW_AUDIENCE_HEALER"] = "Guaritori"
L["BUFF_WINDOW_AUDIENCE_ALL"] = "Tutti"
-- Each buff's dropdown tooltip; hovering the buff's name shows the spell itself.
L["BUFF_WINDOW_AUDIENCE_DESCRIPTION"] = "Imposta a chi offrire %s."
L["BUFF_WINDOW_BUFFS_DESCRIPTION"] =
	"Scegli a chi offrire ogni potenziamento. Difensori e Guaritori si basano sul ruolo nel gruppo; chi non ne ha uno conta come Danno, a meno che Considera come difensori qui sotto non indichi altrimenti."

L["BUFF_WINDOW_SELF_DESCRIPTION"] = "I tuoi potenziamenti, fissati in cima alla finestra."
--[[
    Muted note after a class name on the Self-Buffs panel, for a family of self
    buffs only one of which can be up at a time. Keyed by the family.
]]
L["BUFF_WINDOW_SELF_NOTE_ASPECT"] = "vale un aspetto qualsiasi"
L["BUFF_WINDOW_SELF_NOTE_MAGE_ARMOR"] = "vale un'armatura qualsiasi"
L["BUFF_WINDOW_SELF_NOTE_PALADIN_AURA"] = "vale un'aura qualsiasi"
L["BUFF_WINDOW_SELF_NOTE_SHAMAN_SHIELD"] = "vale uno scudo qualsiasi"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_ARMOR"] = "vale un'armatura qualsiasi"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_DEMON"] = "vale uno qualsiasi dei due potenziamenti demoniaci"
L["BUFF_WINDOW_SELF_REFRESH_OFF"] = "Disattivato"
L["BUFF_WINDOW_SELF_REFRESH_MISSING"] = "Se manca"
-- %s is a duration from the client, like "5 Minutes".
L["BUFF_WINDOW_SELF_REFRESH_UNDER"] = "Meno di %s"
L["BUFF_WINDOW_SELF_REFRESH_DESCRIPTION"] =
	"Imposta quando compare %s: mai, quando l'effetto è finito, o quando ne resta meno di questo tempo."
-- The Weapon Buffs panel, under Buff Duty after Self-Buffs.
L["BUFF_WINDOW_WEAPON_PANEL_HEADER"] = "Potenziamenti delle armi"
L["BUFF_WINDOW_WEAPON_DESCRIPTION"] =
	"Spunta cosa deve avere ogni arma. La finestra lo propone quando manca o sta per scadere, se è nelle tue borse ed è adatto all'arma."
-- The one timing for every weapon buff, at the top of the panel.
L["BUFF_WINDOW_WEAPON_REFRESH"] = "Riapplica"
L["BUFF_WINDOW_WEAPON_REFRESH_DESCRIPTION"] =
	"Imposta quando un potenziamento dell'arma viene proposto di nuovo: quando l'effetto è finito, o quando ne resta meno di questo tempo."
-- The boxes for the weapon items any class can use, after the rogue and shaman boxes.
L["BUFF_WINDOW_WEAPON_KIND_OIL"] = "Oli"
L["BUFF_WINDOW_WEAPON_KIND_STONE"] = "Pietre"
L["BUFF_WINDOW_WEAPON_KIND_LURE"] = "Esche"
--[[
    One choice's checkbox under one hand. The first %s is the poison, imbue,
    oil, stone or lure, the second the client's "Main Hand" or "Off Hand".
]]
L["BUFF_WINDOW_WEAPON_PICK_DESCRIPTION"] =
	"Offre %s per la tua arma (%s). Finché l'arma non ha nessuna delle scelte spuntate, viene offerta ognuna di quelle che possiedi."
L["BUFF_WINDOW_SELF_ENABLE"] = "I tuoi potenziamenti personali"
L["BUFF_WINDOW_SELF_ENABLE_DESCRIPTION"] =
	"Mostra in cima alla finestra i potenziamenti che solo tu puoi lanciare su te stesso, come un'armatura o Inner Fire, quando mancano o stanno per scadere. Scegli quali in Potenziamenti personali."
L["BUFF_WINDOW_WEAPON_ENABLE"] = "I tuoi potenziamenti delle armi"
L["BUFF_WINDOW_WEAPON_ENABLE_DESCRIPTION"] =
	"Mostra i veleni, le infusioni, gli oli, le pietre e le esche che mancano alle tue armi o stanno per scadere, insieme ai tuoi potenziamenti personali in cima alla finestra. Cliccane uno per applicarlo. Scegli quali in Potenziamenti delle armi."

-- The window itself
L["BUFF_WINDOW_SELF_HEADER"] = "Potenziamenti personali"
L["BUFF_WINDOW_FAVOR_HEADER"] = "Ricambia il favore"
L["BUFF_WINDOW_TARGET_HEADER"] = "Bersaglio"
L["BUFF_WINDOW_TOOLTIP_CAST"] = "Clicca per lanciarlo su %s."
-- %s is the client's "Main Hand" or "Off Hand".
L["BUFF_WINDOW_TOOLTIP_WEAPON"] = "Clicca per applicarlo alla tua arma (%s)."
L["BUFF_WINDOW_TOOLTIP_USE"] = "Nessuno nel tuo gruppo ha una Pietra dell'Anima. Clicca per usarne una su %s."
L["BUFF_WINDOW_TOOLTIP_CREATE"] = "Nessuno nel tuo gruppo ha una Pietra dell'Anima. Clicca per crearne una."
L["BUFF_WINDOW_TOOLTIP_GROUP"] = "Clicca per lanciarlo su %s e sul suo gruppo."
L["BUFF_WINDOW_TOOLTIP_FAVOR"] = "Clicca per selezionare %s come bersaglio e lanciarlo."
L["BUFF_WINDOW_TOOLTIP_DISMISS"] = "Clic destro per togliere %s dalla lista."
-- The window's close button: the class name in its color, then the options command.
L["BUFF_WINDOW_CLOSED"] =
	"Turno dei potenziamenti è disattivato per la classe %s. Per riattivarlo, usa Maiusc + Clic destro sul pulsante della minimappa o digita %s."

-- The Buff Key (Key Bindings, and the Keybinds section of Buff Duty)
L["BUFF_KEYS_HEADER"] = "Tasti rapidi"
L["BUFF_KEYS_DESCRIPTION"] =
	"Lancia il prossimo potenziamento della tua lista con un tasto o una macro, fuori dal combattimento. I potenziamenti delle armi restano un clic sulla finestra."
L["BUFF_KEY"] = "Pulsante potenziamento"
L["BUFF_KEY_DESCRIPTION"] =
	"Lancia il tuo prossimo potenziamento mancante, uno per pressione: una resurrezione sul tuo bersaglio morto, poi sui morti del tuo gruppo (sacerdoti, paladini e sciamani), poi i tuoi potenziamenti personali, Ricambia il favore, il tuo bersaglio e il tuo gruppo. Un gruppo riceve il potenziamento di gruppo quando costa meno mana che potenziare uno alla volta tutti quelli a portata."
L["BUFF_KEY_SKIP_COOLDOWNS"] = "Salta i potenziamenti con tempo di recupero"
L["BUFF_KEY_SKIP_COOLDOWNS_DESCRIPTION"] =
	"Salta i potenziamenti con un tempo di recupero, come Fear Ward, e passa al successivo."
-- %s is a player's name.
L["BUFF_KEY_WAITING"] = "In attesa che %s sia a portata."
L["BUFF_KEY_DONE"] = "Niente più da potenziare."
-- The caption beside the read-only box that holds a Buff Key's macro line.
L["BUFF_KEY_MACRO_CAPTION"] = "Macro"

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
