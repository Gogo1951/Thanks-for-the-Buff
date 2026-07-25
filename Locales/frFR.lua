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
L["MESSAGE_BUFFED"] = "%s vous a amélioré avec %s !"
L["MESSAGE_GAVE_YOU"] = "%s vous a donné %s !"
L["MESSAGE_GAVE_GROUP"] = "%s a donné %s à votre groupe !"
L["MESSAGE_USED_ITEM"] = "%s a utilisé %s %s sur vous !"
L["MESSAGE_USED_SPELL"] = "%s a utilisé %s sur vous !"
L["MESSAGE_SET_OUT"] = "%s a déployé %s !"
L["MESSAGE_OPENED"] = "%s a ouvert %s !"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Merci pour %s !"
L["MESSAGE_GOOD_NEWS_DURATION"] = "Bonne nouvelle ! Vous avez %s pendant %s !"
L["MESSAGE_GOOD_NEWS"] = "Bonne nouvelle ! Vous avez %s !"
L["MESSAGE_PEER_PRESSURE"] = "%s a utilisé %s !"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s a utilisé %s sur %s !"
L["MESSAGE_SELECT_PLAYER"] = "Sélectionnez un joueur à remercier."
L["MESSAGE_CANT_THANK_SELF"] = "Vous ne pouvez pas vous remercier vous-même !"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MESSAGE_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "son"
L["PRONOUN_HER"] = "son"
L["PRONOUN_THEIR"] = "leur"
L["UNKNOWN_SPELL"] = "Sort inconnu"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Activer le message de bienvenue"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Affiche un message dans la discussion à la connexion."
L["OPTIONS_DESCRIPTION"] =
	"Remerciez automatiquement les joueurs qui vous améliorent avec des emotes, des chuchotements et des notifications, que ce soit un inconnu dans le monde ouvert ou le temps de recharge d'un coéquipier comme Power Infusion ou Innervate. Soyez aussi averti des festins, des portails et des cooldowns de votre classe."
L["OPTIONS_SUPPORT"] = "Commentaires et Assistance"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMAND_TFTB"] = "/tftb"
L["OPTIONS_COMMAND_TFTB_DESCRIPTION"] = "Ouvre l'interface des options de Thanks for the Buff."
L["OPTIONS_COMMAND_THANKYOU"] = "/thankyou"
L["OPTIONS_COMMAND_THANKYOU_DESCRIPTION"] = "Fait une emote et chuchote à votre cible actuelle."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Améliorations d'Inconnus"
L["STRANGERS_DESCRIPTION"] = "Une amélioration sur vous d'un joueur en dehors de votre groupe (monde ouvert)."
L["STRANGERS_OVERALL_COOLDOWN"] = "Temps de recharge des remerciements (Secondes)"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Fréquence maximale à laquelle remercier qui que ce soit, quelle que soit la provenance de l'amélioration.\n\nMettez 0 pour désactiver cette limite. Les notifications ne sont pas affectées."
L["STRANGERS_SOURCE_COOLDOWN"] = "Temps de recharge par joueur (Secondes)"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Fréquence maximale à laquelle remercier le même joueur.\n\nLes notifications ne sont pas affectées."
L["STRANGERS_MIN_DURATION"] = "Durée minimale de l'amélioration (Secondes)"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Durée minimale que l'amélioration doit avoir pour mériter une réaction.\n\nFiltre les soins sur la durée courts comme Rénovation ou Récupération. Les notifications sont également affectées ; une amélioration en dessous de ce seuil est entièrement ignorée, sans message, son, chuchotement ni emote."

--------------------------------------------------------------------------------
-- Options: Combat Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Améliorations de Coéquipiers"
L["TEAMMATES_DESCRIPTION"] =
	"Une amélioration ou un temps de recharge d'un membre du groupe ou du raid lancé sur vous."

-- Group Services
L["TAB_SERVICES"] = "Services de Groupe"
L["SERVICES_DESCRIPTION"] =
	"Aide à l'échelle du raid d'un membre du groupe ou du raid : festins, puits des âmes, portails, robots de réparation."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Bonne Nouvelle"
L["GOOD_NEWS_DESCRIPTION"] = "Informez les joueurs que vous améliorez de ce que vous leur avez lancé et de sa durée."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Activer Bonne Nouvelle"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Chuchote au joueur que vous avez amélioré pour lui dire ce qu'il a reçu et pour combien de temps."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Quiconque vous améliorez"
L["GOOD_NEWS_SCOPE_GROUP"] = "Membres du groupe uniquement"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Pression Sociale"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Soyez averti quand d'autres joueurs de votre classe utilisent leurs temps de recharge, pour céder à la pression sociale."
L["PEER_PRESSURE_ENABLE"] = "Activer Peer Pressure"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Affiche un message dans votre propre discussion quand un temps de recharge de votre classe est utilisé. Vous seul le voyez."
L["PEER_PRESSURE_OWN_CASTS"] = "Déclencher sur vos propres sorts"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Déclenche l'alerte aussi lorsque vous utilisez vos propres temps de recharge, pas seulement ceux des autres joueurs."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Joue un son quand un temps de recharge de votre classe est utilisé. Vous seul l'entendez."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Capacités suivies"
L["COMBAT_GROUP_ITEMS"] = "Objets"
L["COMBAT_TOGGLE_TRACKING"] = "Basculer le suivi pour %s"
L["COMBAT_ITEM_PENDING"] = "Objet #%d"
L["COMBAT_SPELL_PENDING"] = "Sort #%d"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

-- The two section headers every buff panel is built from: what the other player
-- sees, then what only you get. Peer Pressure sends nothing outward, so it
-- carries the Notifications header alone. Key prefixes match the header the
-- control appears under.
L["PRAISE_HEADER"] = "Messages de remerciement et emotes"
L["NOTIFICATIONS_HEADER"] = "Notifications"

L["PRAISE_WHISPER_ENABLE"] = "Activer les chuchotements de remerciement"
L["PRAISE_WHISPER_DESCRIPTION"] = "Chuchote un remerciement au joueur qui vous a amélioré."
L["PRAISE_EMOTES_ENABLE"] = "Activer les Emotes (Hors combat)"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Exprimez votre appréciation par une emote. Les emotes sont retenues pendant que vous êtes en combat."
L["PRAISE_EMOTES_SELECT"] = "Sélectionner des Emotes"
L["PRAISE_DELAY_ENABLE"] = "Activer le délai de remerciement"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Attend un instant avant le chuchotement et l'emote, afin que votre remerciement n'arrive pas au même instant que l'amélioration.\n\nLes notifications ne sont pas affectées."
L["PRAISE_DELAY_LENGTH"] = "Délai"
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Combien de temps attendre avant de remercier le joueur qui vous a amélioré."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Activer les messages imprimés"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Affiche un message dans votre propre discussion lorsque vous recevez une amélioration. Vous seul le voyez."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Activer les effets sonores"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Joue un son lorsque vous recevez une amélioration. Vous seul l'entendez."

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
L["BUTTON_DESCRIPTION"] = "Remerciez votre cible actuelle avec une emote et un chuchotement."
L["BUTTON_CREATE_MACRO"] = "Créer une Macro"
L["BUTTON_CREATE_MACRO_DESCRIPTION"] = "Crée automatiquement une macro nommée %s à la connexion."
L["BUTTON_WHISPER"] = "Message de Chuchotement"
L["BUTTON_RESET"] = "Réinitialiser"
L["BUTTON_RESET_DESCRIPTION"] = "Réinitialise le message de chuchotement au texte par défaut."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Merci, t'es le meilleur ! (="

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
