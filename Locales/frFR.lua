local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "frFR")
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
	"Version %s. Les paramètres (y compris l'option pour désactiver ce message) se trouvent dans Options > AddOns > Thanks for the Buff (TFTB). Vous aimez cet add-on ? Parlez-en à un ami, ajoutez-le à vos favoris sur CurseForge ou donnez-lui une Star sur GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Par précaution, l'interface des options ne peut pas être ouverte pendant le combat."

-- Buff print out
L["MESSAGE_BUFFED"] = "%s vous a amélioré avec %s !"

-- Thank You Button
L["MESSAGE_SELECT_PLAYER"] = "Ciblez d'abord un joueur."
L["MESSAGE_CANT_THANK_SELF"] = "Vous ne pouvez pas vous remercier vous-même !"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Sort inconnu"
L["SAMPLE_EXAMPLE"] = "Exemple : %s"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Activer le message de bienvenue"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Affiche un message que vous seul pouvez voir lorsque vous vous connectez."
L["OPTIONS_DESCRIPTION"] =
	"Remerciez automatiquement d'une emote ou d'un chuchotement les joueurs qui vous améliorent. Les inconnus qui vous lancent Robustesse, Intelligence des arcanes ou Marque du fauve sont remerciés sur-le-champ, et un clic sur vos macros de remerciement remercie qui vous ciblez."
L["OPTIONS_FEATURES_HEADER"] = "Fonctionnalités"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Activez ou désactivez chaque fonctionnalité ici, ou dans son propre panneau."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Ouvre l'interface des options de cet add-on."

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "Vous cherchez d'autres fonctionnalités ?"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"Certaines fonctionnalités ont rejoint notre nouvel add-on, Good to Go. Retrouvez-le sur CurseForge ou Wago."

--------------------------------------------------------------------------------
-- Options: Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "Aidez Thanks for the Buff (TFTB) à monter de niveau"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"Cet add-on a été créé par des joueurs qui aiment ce jeu et veulent le rendre aussi amusant que possible pour tout le monde. Nous ne demanderons jamais de dons. La vraie satisfaction, c'est de savoir que notre travail rend le jeu un peu meilleur pour vous. Si c'est le cas, nous serions ravis de l'apprendre !"
L["OPTIONS_LEVEL_UP_WAYS"] = "Voici quelques façons de nous aider à toucher plus de joueurs."
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• Partagez vos commentaires : vous avez trouvé un bug ou vous avez une idée ? Dites-le-nous sur Discord. Vos retours nous aident à améliorer l'add-on, et les pull requests sont toujours les bienvenues."
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• Parlez-en à un ami : vous connaissez quelqu'un qui pourrait aimer cet add-on ? Parlez-lui-en. Le bouche-à-oreille aide davantage de joueurs à découvrir de super add-ons."
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	"• Ajoutez-le à vos favoris sur CurseForge : ouvrez le lien CurseForge ci-dessous, connectez-vous et cliquez sur l'étoile sous le bouton Download. Les favoris aident davantage de joueurs à découvrir l'add-on."
L["OPTIONS_LEVEL_UP_GITHUB"] =
	"• Donnez une Star sur GitHub : ouvrez le lien GitHub ci-dessous, connectez-vous et cliquez sur Star en haut à droite. Les stars aident le projet à accéder à davantage d'outils de développement gratuits."
L["OPTIONS_LEVEL_UP_THANKS"] = "Merci d'avoir choisi Thanks for the Buff (TFTB) !"

L["OPTIONS_FEEDBACK"] = "Commentaires et assistance"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "Liens de commentaires et d'assistance"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "Pour copier un lien, cliquez dans son champ, puis appuyez sur Ctrl+A et Ctrl+C."
L["OPTIONS_VERSION"] = "Version %s"

--------------------------------------------------------------------------------
-- Options: Give Thanks
--------------------------------------------------------------------------------

L["TAB_GIVE_THANKS"] = "Remerciements"
L["GIVE_THANKS_ENABLE"] = "Activer les remerciements"
L["GIVE_THANKS_ENABLE_DESCRIPTION"] =
	"Active les remerciements pour les améliorations reçues de joueurs hors de votre groupe."
L["GIVE_THANKS_DESCRIPTION"] = "Remerciez les joueurs hors de votre groupe quand ils vous améliorent en monde ouvert."

-- Praise Limits
L["PRAISE_HEADER"] = "Limites de remerciements"
L["PRAISE_DESCRIPTION"] =
	"Ces réglages retiennent à la fois l'emote et le chuchotement, pour qu'une vague d'améliorations ne tourne jamais au spam."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["GIVE_THANKS_OVERALL_COOLDOWN"] = "Délai entre deux remerciements"
L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Définit le délai entre une série de remerciements et la suivante, quel que soit le joueur qui vous a amélioré. Réglez sur zéro pour remercier chaque amélioration."
L["GIVE_THANKS_SOURCE_COOLDOWN"] = "Délai de remerciement pour un même joueur"
L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Définit le délai entre deux remerciements adressés au même joueur. Réglez sur zéro pour remercier chaque amélioration."
L["GIVE_THANKS_MIN_DURATION"] = "Durée minimale de l'amélioration"
L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"] =
	"Ignore les améliorations plus courtes que cette durée. Réglez sur zéro pour réagir à chaque amélioration."
L["PRAISE_DELAY_ENABLE"] = "Activer le délai de remerciement"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Attend un instant avant le chuchotement et l'emote, afin que vos remerciements n'arrivent pas au même moment que l'amélioration. Les notifications ne sont pas affectées."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Définit le temps d'attente avant l'envoi du chuchotement et de l'emote."

-- Thank-You Whispers
L["WHISPERS_HEADER"] = "Chuchotements de remerciement"
L["PRAISE_WHISPER_ENABLE"] = "Activer les chuchotements de remerciement"
L["PRAISE_WHISPER_DESCRIPTION"] = "Chuchote un remerciement au joueur qui vous a amélioré."
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"Définit ce que TFTB chuchote au joueur qui vous a amélioré. {spell} est remplacé par l'amélioration. Laissez vide pour n'envoyer aucun chuchotement."

-- Notifications
L["NOTIFICATIONS_HEADER"] = "Notifications"
L["NOTIFICATIONS_DESCRIPTION"] = "Ce que vous seul recevez : un message texte, un son, ou les deux."
L["NOTIFICATIONS_PRINT_ENABLE"] = "Activer les messages texte"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Affiche un message que vous seul pouvez voir lorsque vous recevez une amélioration."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Activer les effets sonores"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] =
	"Joue un son lorsque vous recevez une amélioration. Vous êtes seul à l'entendre."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Joue le son pour que vous puissiez l'écouter avant de l'activer."

-- Emotes: the grid's group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS entry, upper-cased.
L["TAB_EMOTES_LIST"] = "Liste des emotes"
L["EMOTES_GRID_DESCRIPTION"] =
	"Cochez les emotes parmi lesquelles la fonction Remerciements peut choisir quand un joueur hors de votre groupe vous améliore ; elle en utilise une au hasard. Les emotes sont différées tant que vous êtes en combat."
L["EMOTE_GROUP_COUNT"] = "%s (%d sur %d cochées)"
L["EMOTE_GROUP_TEXT"] = "Texte"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "Affiche uniquement la ligne de l'emote."
L["EMOTE_GROUP_VOICE"] = "Voix"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "Joue une réplique vocale."
L["EMOTE_GROUP_GESTURE"] = "Geste"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "Joue une courte animation."
L["EMOTE_GROUP_POSE"] = "Posture"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "Dure jusqu'à ce que vous bougiez."
L["EMOTES_RESET"] = "Réinitialiser les emotes"
L["EMOTES_RESET_DESCRIPTION"] = "Remet la liste sur les emotes de remerciement par défaut."
L["EMOTES_RESET_CONFIRM"] = "Réinitialiser la liste des emotes aux valeurs par défaut ?"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "Améliorations ignorées"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"Les améliorations de cette liste ne reçoivent jamais de remerciement, quel que soit le lanceur. Vous recevez toujours votre message texte et votre son."
L["IGNORED_BUFFS_ADD_CURRENT"] = "Ignorer une amélioration active"
L["IGNORED_BUFFS_ADD_CURRENT_DESCRIPTION"] = "Ajoute l'une des améliorations actives sur vous en ce moment."
L["IGNORED_BUFFS_ADD"] = "Ajouter une amélioration"
L["IGNORED_BUFFS_ADD_DESCRIPTION"] =
	"Saisissez un ID de sort, ou faites Maj-clic sur le lien d'une amélioration pour l'insérer dans le champ, puis appuyez sur Entrée."
L["IGNORED_BUFFS_EMPTY"] = "Aucune amélioration ignorée pour l'instant. Ajoutez-en une ci-dessus."
L["IGNORED_BUFFS_REMOVE"] = "Retire cette amélioration de la liste."
L["IGNORED_BUFFS_NOT_FOUND"] = "Aucune amélioration trouvée pour %s."
L["IGNORED_BUFFS_ALL_CHARACTERS"] = "Tous les personnages"
L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"] =
	"Déplace cette amélioration dans la liste Tous les personnages, pour qu'elle ne soit remerciée sur aucun personnage."

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Bouton de remerciement"
L["BUTTON_DESCRIPTION"] =
	"Chuchotez à votre cible et adressez-lui une emote d'une seule touche. La courtoisie, automatisée."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Bouton de remerciement %d"
L["BUTTON_EMOTE"] = "Emote"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Définit l'emote que ce bouton adresse à votre cible, ou Aucune pour ne faire aucune emote."
L["BUTTON_EMOTE_NONE"] = "Aucune"
-- Titles Thank You Button 1's emote checklist.
L["EMOTES_SELECT"] = "Sélectionner les emotes"
L["BUTTON_ICON"] = "Icône"
L["BUTTON_ICON_DESCRIPTION"] =
	"Définit l'icône que la macro de ce bouton affiche dans votre liste de macros et sur vos barres d'action."
-- The Icon dropdown's first choice, the macros' own icon; every other choice is a picture alone.
L["BUTTON_ICON_DEFAULT"] = "Par défaut"
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
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks and each Thank You Button.
L["WHISPER_MESSAGE"] = "Message chuchoté"
L["WHISPER_MESSAGE_RESET"] = "Réinitialiser"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Rétablit le texte par défaut du message chuchoté."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Merci, t'es au top ! (="
-- TRANSLATORS: keep {spell} exactly as written; TFTB swaps in the buff's link.
L["DEFAULT_GIVE_THANKS_WHISPER"] = "Merci pour {spell}"
