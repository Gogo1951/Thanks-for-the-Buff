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

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Merci pour %s"
L["MESSAGE_SELECT_PLAYER"] = "Ciblez d'abord un joueur."
L["MESSAGE_CANT_THANK_SELF"] = "Vous ne pouvez pas vous remercier vous-même !"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Sort inconnu"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Activer le message de bienvenue"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Affiche un message que vous seul pouvez voir lorsque vous vous connectez."
L["OPTIONS_DESCRIPTION"] =
	"Remerciez automatiquement d'un chuchotement ou d'une emote chaque joueur qui vous améliore, et remerciez qui vous voulez à la main d'un clic sur vos macros de remerciement. La politesse, en automatique."
L["OPTIONS_FEATURES_HEADER"] = "Fonctionnalités"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Activez ou désactivez chaque fonctionnalité ici, ou dans son propre panneau."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Ouvre l'interface des options de cet add-on."
L["SAMPLE_EXAMPLE"] = "Exemple : %s"

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
-- Options: Stranger Buffs
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- Options: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers the Stranger Buffs panel is built from: what the
    other player sees, then what only you get. Key prefixes match the header
    the control appears under.
]]
L["PRAISE_HEADER"] = "Chuchotements de remerciement et emotes"
L["NOTIFICATIONS_HEADER"] = "Notifications"
L["PRAISE_DESCRIPTION"] = "Ce que voit l'autre joueur : un chuchotement de remerciement, une emote, ou les deux."
L["NOTIFICATIONS_DESCRIPTION"] = "Ce que vous seul recevez : un message texte, un son, ou les deux."

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

L["NOTIFICATIONS_PRINT_ENABLE"] = "Activer les messages texte"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Affiche un message que vous seul pouvez voir lorsque vous recevez une amélioration."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Activer les effets sonores"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] =
	"Joue un son lorsque vous recevez une amélioration. Vous êtes seul à l'entendre."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Joue le son pour que vous puissiez l'écouter avant de l'activer."

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

-- Each button's whisper box
L["WHISPER_MESSAGE"] = "Message chuchoté"
L["WHISPER_MESSAGE_RESET"] = "Réinitialiser"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Rétablit le texte par défaut du message chuchoté."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Merci, t'es au top ! (="

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
