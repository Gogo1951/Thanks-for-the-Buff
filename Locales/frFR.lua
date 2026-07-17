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
	"Version %s. Les paramètres (y compris l'option pour désactiver ce message) se trouvent dans Options > AddOns > Thanks for the Buff. Vous aimez l'add-on ? Parlez-en à un ami ! (="

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s vous a amélioré avec %s !"
L["MSG_GAVE_YOU"] = "%s vous a donné %s !"
L["MSG_GAVE_GROUP"] = "%s a donné %s à votre groupe !"
L["MSG_USED_ITEM"] = "%s a utilisé %s %s sur vous !"
L["MSG_USED_SPELL"] = "%s a utilisé %s sur vous !"
L["MSG_SET_OUT"] = "%s a déployé %s !"
L["MSG_OPENED"] = "%s a ouvert %s !"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "Merci pour %s !"
L["MSG_GOODNEWS_DURATION"] = "Bonne nouvelle ! Vous avez %s pendant %s !"
L["MSG_GOODNEWS"] = "Bonne nouvelle ! Vous avez %s !"
L["MSG_PEER_PRESSURE"] = "%s a utilisé %s !"
L["MSG_PEER_PRESSURE_TARGET"] = "%s a utilisé %s sur %s !"
L["MSG_SELECT_PLAYER"] = "Sélectionnez un joueur à remercier."
L["MSG_CANT_THANK_SELF"] = "Vous ne pouvez pas vous remercier vous-même !"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MSG_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "son"
L["PRONOUN_HER"] = "son"
L["PRONOUN_THEIR"] = "leur"
L["UNKNOWN_SPELL"] = "Sort inconnu"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Activer le message de bienvenue"
L["OPTIONS_WELCOME_DESC"] = "Affiche un message dans la discussion à la connexion."
L["OPTIONS_DESCRIPTION"] =
	"Remerciez automatiquement les joueurs qui vous améliorent avec des emotes, des chuchotements et des notifications, que ce soit un inconnu dans le monde ouvert ou le temps de recharge d'un coéquipier comme Power Infusion ou Innervate. Soyez aussi averti des festins, des portails et des cooldowns de votre classe."
L["OPTIONS_SUPPORT"] = "Commentaires et Assistance"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Ouvre l'interface des options de Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Fait une emote et chuchote à votre cible actuelle."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Améliorations d'Inconnus"
L["STRANGERS_DESC"] = "Une amélioration sur vous d'un joueur en dehors de votre groupe (monde ouvert)."
L["STRANGERS_COOLDOWN"] = "Temps de recharge (Secondes)"
L["STRANGERS_COOLDOWN_DESC"] =
	"Fréquence maximale d'utilisation d'une emote envers le même joueur.\n\nLes messages ne sont pas affectés ; ils se déclenchent pour chaque amélioration."
L["STRANGERS_MIN_DURATION"] = "Durée minimale de l'amélioration (Secondes)"
L["STRANGERS_MIN_DURATION_DESC"] =
	"Durée minimale pendant laquelle l'amélioration doit persister pour déclencher un remerciement.\n\nFiltre les soins sur la durée courts comme Rénovation ou Récupération."

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Améliorations de Coéquipiers"
L["TEAMMATES_DESC"] = "Une amélioration ou un temps de recharge d'un membre du groupe ou du raid lancé sur vous."

-- Group Services
L["TAB_SERVICES"] = "Services de Groupe"
L["SERVICES_DESC"] =
	"Aide à l'échelle du raid d'un membre du groupe ou du raid : festins, puits des âmes, portails, robots de réparation."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Bonne Nouvelle"
L["GOOD_NEWS_DESC"] =
	"Chuchote automatiquement aux joueurs que vous améliorez les améliorations de combat que vous leur lancez."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Activer Bonne Nouvelle"
L["GOOD_NEWS_WHISPER_DESC"] =
	"Chuchote au joueur que vous avez amélioré pour lui dire ce qu'il a reçu et pour combien de temps."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Quiconque vous améliorez"
L["GOOD_NEWS_SCOPE_GROUP"] = "Membres du groupe uniquement"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Peer Pressure"
L["PEER_PRESSURE_DESC"] =
	"Soyez averti quand d'autres joueurs de votre classe utilisent leurs temps de recharge, pour céder au Peer Pressure."
L["PEER_PRESSURE_ENABLE"] = "Activer Peer Pressure"
L["PEER_PRESSURE_PRINT_DESC"] =
	"Affiche un message dans votre propre discussion quand un temps de recharge de votre classe est utilisé. Vous seul le voyez."
L["PEER_PRESSURE_OWN_CASTS"] = "Déclencher sur vos propres sorts"
L["PEER_PRESSURE_OWN_CASTS_DESC"] =
	"Déclenche l'alerte aussi lorsque vous utilisez vos propres temps de recharge, pas seulement ceux des autres joueurs."
L["PEER_PRESSURE_SOUND_DESC"] =
	"Joue un son quand un temps de recharge de votre classe est utilisé. Vous seul l'entendez."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Capacités suivies"
L["COMBAT_GROUP_ITEMS"] = "Objets"
L["COMBAT_TOGGLE_TRACKING"] = "Basculer le suivi pour %s"
L["COMBAT_ITEM_PENDING"] = "Objet #%d"
L["COMBAT_SPELL_PENDING"] = "Sort #%d"

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

-- Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
-- spells and items take their names from the client and need no key here.
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

L["TAB_THANK_YOU_BUTTON"] = "Bouton de Remerciement"
L["BUTTON_DESC"] = "Remerciez votre cible actuelle avec une emote et un chuchotement."
L["BUTTON_CREATE_MACRO"] = "Créer une Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Crée automatiquement une macro nommée %s à la connexion."
L["BUTTON_WHISPER"] = "Message de Chuchotement"
L["BUTTON_RESET"] = "Réinitialiser"
L["BUTTON_RESET_DESC"] = "Réinitialise le message de chuchotement au texte par défaut."

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_HEADER"] = "Messagerie"
L["MESSAGING_PRINT_ENABLE"] = "Activer les messages imprimés (Vous uniquement)"
L["MESSAGING_PRINT_DESC"] =
	"Affiche un message dans votre propre discussion lorsque vous recevez une amélioration. Vous seul le voyez."
L["MESSAGING_WHISPER_ENABLE"] = "Activer les messages de remerciement"
L["MESSAGING_WHISPER_DESC"] = "Chuchote un remerciement au joueur qui vous a amélioré."
L["MESSAGING_EMOTES_ENABLE"] = "Activer les Emotes (Hors combat)"
L["MESSAGING_EMOTES_DESC"] =
	"Exprimez votre appréciation par une emote. Les emotes sont retenues pendant que vous êtes en combat."
L["MESSAGING_EMOTES_SELECT"] = "Sélectionner des Emotes"
L["MESSAGING_SOUND_ENABLE"] = "Activer l'effet sonore"
L["MESSAGING_SOUND_DESC"] = "Joue un son lorsque vous recevez une amélioration. Vous seul l'entendez."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Merci, t'es le meilleur ! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESC"] = "Vous acclamez <Target>."
L["EMOTE_DRINK_DESC"] = "Vous portez un toast à <Target>."
L["EMOTE_FLEX_DESC"] = "Vous montrez vos muscles à <Target>."
L["EMOTE_GRIN_DESC"] = "Vous faites un sourire malicieux à <Target>."
L["EMOTE_HIGHFIVE_DESC"] = "Vous tapez dans la main de <Target>."
L["EMOTE_PRAISE_DESC"] = "Vous faites l'éloge de <Target>."
L["EMOTE_SALUTE_DESC"] = "Vous saluez <Target> avec respect."
L["EMOTE_SMILE_DESC"] = "Vous souriez à <Target>."
L["EMOTE_THANK_DESC"] = "Vous remerciez <Target>."
L["EMOTE_WHOA_DESC"] = "Vous regardez <Target> et vous exclamez 'Waouh !'"
L["EMOTE_WINK_DESC"] = "Vous faites un clin d'œil à <Target>."
L["EMOTE_YES_DESC"] = "Vous opinez du chef à <Target>."
