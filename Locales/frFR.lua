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
L["MESSAGE_WHISPER_THANKS"] = "Merci pour %s !"
L["MESSAGE_PEER_PRESSURE"] = "%s a utilisé %s !"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s a utilisé %s sur %s !"
L["MESSAGE_SELECT_PLAYER"] = "Sélectionnez un joueur à remercier."
L["MESSAGE_CANT_THANK_SELF"] = "Vous ne pouvez pas vous remercier vous-même !"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Sort inconnu"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Activer le message de bienvenue"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Affiche un message dans la discussion à la connexion."
L["OPTIONS_DESCRIPTION"] =
	"Remerciez automatiquement les joueurs qui vous améliorent avec des emotes, des chuchotements et des notifications, que ce soit un inconnu dans le monde ouvert ou le temps de recharge d'un coéquipier comme Infusion de puissance ou Innervation. Soyez aussi averti des festins, des portails et des temps de recharge de votre propre classe."
L["OPTIONS_SUPPORT"] = "Commentaires et assistance"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Ouvre l'interface des options de cet add-on."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Améliorations d'inconnus"
L["STRANGERS_ENABLE"] = "Activer les remerciements pour les améliorations d'inconnus"
L["STRANGERS_DESCRIPTION"] = "Remerciez les joueurs hors de votre groupe quand ils vous améliorent en monde ouvert."
--[[
    The dropdown values carry the unit, so these labels do not repeat it. Each
    description is one line because it renders as visible help under its control
    rather than behind a hover.
]]
L["STRANGERS_OVERALL_COOLDOWN"] = "Délai entre deux remerciements"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Délai entre un remerciement et le suivant, quel que soit celui qui vous a amélioré. Mettez zéro pour remercier chaque amélioration."
L["STRANGERS_SOURCE_COOLDOWN"] = "Délai de remerciement pour un même joueur"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Délai entre les remerciements destinés au même joueur. Mettez zéro pour remercier chaque amélioration."
L["STRANGERS_MIN_DURATION"] = "Durée minimale de l'amélioration"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Ignore les améliorations plus courtes que ceci. Mettez zéro pour réagir à chaque amélioration."

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Améliorations de coéquipiers"
L["TEAMMATES_ENABLE"] = "Activer les remerciements pour les améliorations de coéquipiers"
L["TEAMMATES_DESCRIPTION"] =
	"Remerciez les membres du groupe et du raid pour les améliorations et capacités qu'ils vous lancent."

-- Service Alerts
L["TAB_SERVICES"] = "Alertes de services"
L["SERVICES_ENABLE"] = "Activer les alertes de services"
L["SERVICES_DESCRIPTION"] =
	"Réagissez à l'aide à l'échelle du raid de votre groupe : festins, puits des âmes, portails, robots de réparation."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Envoyer une bonne nouvelle"
L["GOOD_NEWS_DESCRIPTION"] = "Informez les joueurs que vous améliorez de ce que vous leur avez lancé et de sa durée."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Activer les bonnes nouvelles"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Chuchote au joueur que vous avez amélioré pour lui dire ce qu'il a reçu et pour combien de temps."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Quiconque vous améliorez"
L["GOOD_NEWS_SCOPE_GROUP"] = "Membres du groupe uniquement"
L["GOOD_NEWS_MESSAGES_HEADER"] = "Messages de bonne nouvelle"
L["GOOD_NEWS_MESSAGE"] = "Message chuchoté"
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
	"Soyez averti quand d'autres joueurs de votre classe utilisent leurs capacités à temps de recharge, pour céder à la pression sociale."
L["PEER_PRESSURE_ENABLE"] = "Activer la pression sociale"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Affiche un message dans votre propre discussion quand une capacité de votre classe est utilisée. Vous seul le voyez."
L["PEER_PRESSURE_OWN_CASTS"] = "Déclencher sur vos propres sorts"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Se déclenche aussi lorsque vous utilisez vos propres capacités, pas seulement celles des autres joueurs."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Joue un son quand une capacité de votre classe est utilisée. Vous seul l'entendez."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Capacités suivies"
L["TRACKED_GROUP_ITEMS"] = "Objets"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Basculer le suivi pour %s."
L["TRACKED_ITEM_PENDING"] = "Objet #%d"
L["TRACKED_SPELL_PENDING"] = "Sort #%d"

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

L["PRAISE_WHISPER_ENABLE"] = "Activer les chuchotements de remerciement"
L["PRAISE_WHISPER_DESCRIPTION"] = "Chuchote un remerciement au joueur qui vous a amélioré."
L["PRAISE_EMOTES_ENABLE"] = "Activer les emotes"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Exprimez votre reconnaissance par une emote. Les emotes sont retenues tant que vous êtes en combat."
L["PRAISE_EMOTES_SELECT"] = "Sélectionner des emotes"
L["PRAISE_DELAY_ENABLE"] = "Activer le délai de remerciement"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Attend un instant avant le chuchotement et l'emote, afin que votre remerciement n'arrive pas au même instant que l'amélioration. Les notifications ne sont pas affectées."
L["PRAISE_DELAY_HELP"] =
	"Attendez avant de remercier, afin que votre remerciement n'arrive pas au même instant que l'amélioration."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Activer les messages de discussion"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Affiche un message dans votre propre discussion lorsque vous recevez une amélioration. Vous seul le voyez."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Activer les effets sonores"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Joue un son lorsque vous recevez une amélioration. Vous seul l'entendez."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
    spells and items take their names from the client and need no key here.
]]
L["GROUP_PORTALS"] = "Portails"
L["GROUP_SOULSTONE"] = "Pierre d'âme"
L["GROUP_RESISTANCE_CAULDRONS"] = "Chaudrons de résistance"
L["GROUP_SCROLL_OF_SPIRIT"] = "Parchemin d'esprit"
L["GROUP_SCROLL_OF_STAMINA"] = "Parchemin d'endurance"
L["GROUP_SCROLL_OF_STRENGTH"] = "Parchemin de force"
L["GROUP_SCROLL_OF_PROTECTION"] = "Parchemin de protection"
L["GROUP_SCROLL_OF_INTELLECT"] = "Parchemin d'intelligence"
L["GROUP_SCROLL_OF_AGILITY"] = "Parchemin d'agilité"
L["GROUP_REPAIR_BOTS"] = "Robots de réparation"
L["GROUP_JUMPER_CABLES"] = "Câbles de démarrage"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Bouton de remerciement"
L["BUTTON_DESCRIPTION"] =
	"La courtoisie, automatisée. Chaque bouton chuchote à votre cible actuelle et peut aussi lui adresser une emote : demander de l'eau à un mage, remercier quelqu'un pour un portail, féliciter un ami en plein combat pour une provocation bien placée. Écrivez le message une fois et il ne vous reste plus qu'une touche à presser."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Bouton TFTB %d"
L["BUTTON_EMOTE"] = "Emote"
L["BUTTON_EMOTE_NONE"] = "Aucune"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Activer la macro "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] =
	"Crée une macro nommée %s, et la supprime de nouveau quand vous désactivez ceci."
L["BUTTON_WHISPER"] = "Message chuchoté"
L["BUTTON_RESET"] = "Réinitialiser"
L["BUTTON_RESET_DESCRIPTION"] = "Réinitialise le message chuchoté au texte par défaut."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Merci, t'es le meilleur ! (="
--[[
    The star marker and "TFTB // " prefix are added by the builder and are not
    part of the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "Vous avez %a !"

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
L["EMOTE_YES_DESCRIPTION"] = "Vous opinez du chef à <Target>."
