local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "frFR")
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
	"Version %s. Les paramètres (y compris l'option pour désactiver ce message) se trouvent dans Options > AddOns > Thanks for the Buff (TFTB). Vous aimez l'add-on ? Parlez-en à un ami ! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Par précaution, l'interface des options ne peut pas être ouverte pendant le combat."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s vous a amélioré avec %s !"
L["MESSAGE_GAVE_YOU"] = "%s vous a donné %s !"
L["MESSAGE_GAVE_GROUP"] = "%s a donné %s à votre groupe !"
L["MESSAGE_USED_ITEM"] = "%s a utilisé %s sur vous !"
L["MESSAGE_USED_SPELL"] = "%s a lancé %s sur vous !"
L["MESSAGE_SET_OUT"] = "%s a déployé %s !"
L["MESSAGE_OPENED"] = "%s a ouvert %s !"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Merci pour %s"
L["MESSAGE_SELECT_PLAYER"] = "Sélectionnez un joueur à remercier."
L["MESSAGE_CANT_THANK_SELF"] = "Vous ne pouvez pas vous remercier vous-même !"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "%s a utilisé %s !"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s a utilisé %s sur %s !"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Sort inconnu"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Activer le message de bienvenue"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Affiche un message dans la discussion lorsque vous vous connectez."
L["OPTIONS_DESCRIPTION"] =
	"Remerciez automatiquement d'un chuchotement ou d'une emote les joueurs qui vous améliorent, et annoncez les améliorations que vous lancez, comme Infusion de puissance, Innervation et Pierre d'âme. Soyez aussi averti des festins, portails, invocations, puits des âmes et temps de recharge de votre classe. La politesse, en automatique."
L["OPTIONS_SUPPORT"] = "Commentaires et assistance"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_VERSION"] = "Version %s"
L["OPTIONS_FEATURES_HEADER"] = "Fonctionnalités"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Ouvre l'interface des options de cet add-on."

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Stranger Buffs
L["TAB_STRANGERS"] = "Améliorations d'inconnus"
L["STRANGERS_ENABLE"] = "Activer les remerciements pour les améliorations d'inconnus"
L["STRANGERS_ENABLE_DESCRIPTION"] =
	"Active les remerciements pour les améliorations reçues de joueurs hors de votre groupe."
L["STRANGERS_DESCRIPTION"] = "Remerciez les joueurs hors de votre groupe quand ils vous améliorent en monde ouvert."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "Délai entre deux remerciements"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Définit le délai entre une série de remerciements et la suivante, quel que soit le joueur qui vous a amélioré. Réglez sur zéro pour remercier chaque amélioration."
L["STRANGERS_SOURCE_COOLDOWN"] = "Délai de remerciement pour un même joueur"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Définit le délai entre deux remerciements adressés au même joueur. Réglez sur zéro pour remercier chaque amélioration."
L["STRANGERS_MIN_DURATION"] = "Durée minimale de l'amélioration"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Ignore les améliorations plus courtes que cette durée. Réglez sur zéro pour réagir à chaque amélioration."

-- Teammate Buffs
L["TAB_TEAMMATES"] = "Améliorations de coéquipiers"
L["TEAMMATES_ENABLE"] = "Activer les remerciements pour les améliorations de coéquipiers"
L["TEAMMATES_ENABLE_DESCRIPTION"] =
	"Active les remerciements pour les améliorations et les capacités à temps de recharge que les membres de votre groupe ou de votre raid vous lancent."
L["TEAMMATES_DESCRIPTION"] =
	"Remerciez les membres du groupe et du raid pour les améliorations et les capacités à temps de recharge qu'ils vous lancent."

-- Service Alerts
L["TAB_SERVICES"] = "Alertes de services"
L["SERVICES_ENABLE"] = "Activer les alertes de services"
L["SERVICES_ENABLE_DESCRIPTION"] =
	"Active les alertes pour les festins, les puits des âmes, les portails et toute autre aide déployée pour votre groupe."
L["SERVICES_DESCRIPTION"] =
	"Réagissez à l'aide à l'échelle du raid de votre groupe : festins, puits des âmes, portails et robots de réparation."

-- Send Good News
L["TAB_GOOD_NEWS"] = "Envoyer une bonne nouvelle"
L["GOOD_NEWS_DESCRIPTION"] = "Informez les joueurs que vous améliorez de ce que vous leur avez lancé et de sa durée."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Activer les bonnes nouvelles"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Chuchote au joueur que vous avez amélioré pour lui indiquer ce qu'il a reçu et pour combien de temps."
L["GOOD_NEWS_SCOPE"] = "Destinataires"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Tous ceux que vous améliorez"
L["GOOD_NEWS_SCOPE_GROUP"] = "Membres du groupe uniquement"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Définit qui reçoit un chuchotement de bonne nouvelle : tous ceux que vous améliorez, ou uniquement votre groupe ou votre raid."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Message de bonne nouvelle"
--[[
    Two halves so the number stays authoritative: LIMIT's %d is a real placeholder
    and gets formatted, TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_LIMIT"] = "Longueur maximale : %d."
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a devient le lien de la capacité."
--[[
    Appended to the ability link inside %a when the buff has a readable duration.
    A whole clause rather than a bare number so it can be reworded per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "pendant %s"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Pression sociale"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Soyez averti quand d'autres joueurs de votre classe utilisent leurs capacités à temps de recharge, pour pouvoir céder à la pression sociale."
L["PEER_PRESSURE_ENABLE"] = "Activer la pression sociale"
L["PEER_PRESSURE_ENABLE_DESCRIPTION"] =
	"Active les alertes quand un autre joueur de votre classe utilise une capacité à temps de recharge suivie."
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Affiche un message dans votre propre discussion quand une capacité à temps de recharge de votre classe est utilisée. Vous êtes seul à le voir."
L["PEER_PRESSURE_OWN_CASTS"] = "Déclencher sur vos propres sorts"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Se déclenche aussi lorsque vous utilisez vos propres capacités à temps de recharge, pas seulement lorsque d'autres joueurs le font."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Joue un son quand une capacité à temps de recharge de votre classe est utilisée. Vous êtes seul à l'entendre."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Capacités suivies"
L["TRACKED_GROUP_ITEMS"] = "Objets"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Active ou désactive le suivi de %s."
L["TRACKED_ITEM_PENDING"] = "Objet #%d"
L["TRACKED_SPELL_PENDING"] = "Sort #%d"

-- Shared by Send Good News and the Thank You Button
L["WHISPER_MESSAGE"] = "Message chuchoté"
L["WHISPER_MESSAGE_RESET"] = "Réinitialiser"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Rétablit le texte par défaut du message chuchoté."

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "Messages de remerciement et emotes"
L["NOTIFICATIONS_HEADER"] = "Notifications"

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "Sélectionner les emotes"

L["PRAISE_WHISPER_ENABLE"] = "Activer les chuchotements de remerciement"
L["PRAISE_WHISPER_DESCRIPTION"] = "Chuchote un remerciement au joueur qui vous a amélioré."
L["PRAISE_EMOTES_ENABLE"] = "Activer les emotes"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Exprime votre reconnaissance par une emote. Les emotes sont différées tant que vous êtes en combat."
L["PRAISE_DELAY_ENABLE"] = "Activer le délai de remerciement"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Attend un instant avant le chuchotement et l'emote, afin que vos remerciements n'arrivent pas au même moment que l'amélioration. Les notifications ne sont pas affectées."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Définit le temps d'attente avant l'envoi du chuchotement et de l'emote."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Activer les messages de discussion"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Affiche un message dans votre propre discussion lorsque vous recevez une amélioration. Vous êtes seul à le voir."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Activer les effets sonores"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] =
	"Joue un son lorsque vous recevez une amélioration. Vous êtes seul à l'entendre."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Joue le son pour que vous puissiez l'écouter avant de l'activer."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups that no single game record names
    (Data/{Game}/Tracked-Abilities-{Game}.lua). Single spells and items, and a
    group named after one of its own items, take their names from the client.
]]
L["GROUP_PORTALS"] = "Portails"
L["GROUP_RESISTANCE_CAULDRONS"] = "Chaudrons de résistance"
L["GROUP_REPAIR_BOTS"] = "Robots de réparation"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Bouton de remerciement"
L["BUTTON_DESCRIPTION"] =
	"La courtoisie, automatisée. Chaque bouton chuchote à votre cible actuelle et peut aussi lui adresser une emote : demander de l'eau à un mage, remercier quelqu'un pour un portail, féliciter un ami en plein combat pour une provocation bien placée. Écrivez le message une fois et il ne vous reste plus qu'une touche à presser."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Bouton de remerciement %d"
L["BUTTON_EMOTE"] = "Emote"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Définit l'emote que ce bouton adresse à votre cible, ou Aucune pour ne faire aucune emote."
L["BUTTON_EMOTE_NONE"] = "Aucune"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Activer la macro "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "Crée une macro nommée %s et la supprime quand vous désactivez cette option."
L["BUTTON_WHISPER_DESCRIPTION"] =
	"Définit ce que ce bouton chuchote à votre cible. Laissez vide pour n'envoyer aucun chuchotement."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Merci, t'es au top ! (="
--[[
    The star marker (left off on WoW Forever) and " // TFTB" sign-off are added
    by the builder, which also drops the closing punctuation; neither is part of
    the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "Vous avez %a"

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "Vous acclamez <Target>."
L["EMOTE_DRINK_DESCRIPTION"] = "Vous portez un toast à <Target>."
L["EMOTE_FLEX_DESCRIPTION"] = "Vous montrez vos muscles à <Target>."
L["EMOTE_GRIN_DESCRIPTION"] = "Vous faites un sourire malicieux à <Target>."
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "Vous tapez dans la main de <Target>."
L["EMOTE_PRAISE_DESCRIPTION"] = "Vous faites l'éloge de <Target>."
L["EMOTE_SALUTE_DESCRIPTION"] = "Vous saluez <Target> avec respect."
L["EMOTE_SMILE_DESCRIPTION"] = "Vous souriez à <Target>."
L["EMOTE_THANK_DESCRIPTION"] = "Vous remerciez <Target>."
L["EMOTE_WHOA_DESCRIPTION"] = "Vous vous exclamez 'Waouh !' devant <Target>."
L["EMOTE_WINK_DESCRIPTION"] = "Vous faites un clin d'œil à <Target>."
L["EMOTE_YES_DESCRIPTION"] = "Vous faites un signe de tête approbateur à <Target>."
