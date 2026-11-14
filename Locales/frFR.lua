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
	"Remerciez automatiquement d'une emote ou d'un chuchotement les joueurs qui vous améliorent, dites aux joueurs ce que vous venez de leur lancer, saluez de la main vos amis et membres de guilde en passant près d'eux, et remerciez qui vous ciblez d'un clic sur vos macros de remerciement."
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

-- Give Thanks Whisper
L["GIVE_THANKS_WHISPER_HEADER"] = "Chuchotement de remerciement"
L["GIVE_THANKS_WHISPER_ENABLE"] = "Activer le chuchotement de remerciement"
L["PRAISE_WHISPER_DESCRIPTION"] = "Chuchote un remerciement au joueur qui vous a amélioré."
-- TRANSLATORS: keep {spell} and {name} exactly as written; they are the tokens players type into the whisper.
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"Définit ce que TFTB chuchote au joueur qui vous a amélioré. {spell} est remplacé par l'amélioration et {name} par son nom. Laissez vide pour n'envoyer aucun chuchotement."

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

--------------------------------------------------------------------------------
-- Options: Good News
--------------------------------------------------------------------------------

L["TAB_GOOD_NEWS"] = "Bonnes nouvelles"
L["GOOD_NEWS_ENABLE"] = "Activer les bonnes nouvelles"
L["GOOD_NEWS_ENABLE_DESCRIPTION"] = "Active un chuchotement qui indique aux joueurs ce que vous venez de leur lancer."
L["GOOD_NEWS_DESCRIPTION"] =
	"Faites savoir aux joueurs ce que vous venez de leur lancer et, pour les améliorations courtes, combien de temps cela dure, pour qu'ils en tirent le meilleur parti."
L["GOOD_NEWS_SCOPE"] = "Destinataires"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Définit qui reçoit un chuchotement Bonnes nouvelles : toute personne sur qui vous lancez une technique suivie, ou seulement votre groupe ou votre raid."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Tout le monde"
L["GOOD_NEWS_SCOPE_GROUP"] = "Membres du groupe uniquement"
L["GOOD_NEWS_WHISPER_HEADER"] = "Chuchotement de bonne nouvelle"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Ce que reçoit le joueur sur qui vous lancez. Seules les techniques cochées dans Techniques suivies en envoient un."
-- TRANSLATORS: keep {spell} and {name} exactly as written; they are the tokens players type into the whisper.
L["GOOD_NEWS_MESSAGE_DESCRIPTION"] =
	"Définit ce que TFTB chuchote au joueur sur qui vous lancez. {spell} est remplacé par ce que vous avez lancé, avec sa durée quand elle est inférieure à une minute, et {name} par son nom. Laissez vide pour n'envoyer aucun chuchotement."
-- TRANSLATORS: each %s is a token, {spell} then {name}, drawn in blue.
L["GOOD_NEWS_TOKENS"] = "Balises : %s ce que vous lancez, %s qui l'a reçu"

-- Tracked Abilities
L["TAB_GOOD_NEWS_ABILITIES"] = "Techniques suivies"
L["GOOD_NEWS_ABILITIES_DESCRIPTION"] =
	"Bonnes nouvelles chuchote au sujet des techniques cochées ici quand vous les lancez sur un autre joueur."
-- The heading over the rows no class owns: scrolls, and abilities cast by a trinket's pet.
L["GOOD_NEWS_ITEMS"] = "Objets"

--------------------------------------------------------------------------------
-- Options: Emotes List
--------------------------------------------------------------------------------

L["TAB_EMOTES_LIST"] = "Liste des emotes"
L["EMOTES_GRID_DESCRIPTION"] =
	"Cochez les emotes parmi lesquelles la fonction Remerciements peut choisir quand un joueur hors de votre groupe vous améliore ; elle en utilise une au hasard. Les emotes sont différées tant que vous êtes en combat, en train d'incanter ou de pêcher."

--[[
    The emote checklist, shared by this panel and Wave to Friends' Friends and
    Guilds tabs. Its group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS
    entry, upper-cased.
]]
L["EMOTE_GROUP_COUNT"] = "%s (%d sur %d cochées)"
L["EMOTE_GROUP_TEXT"] = "Texte"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "Affiche uniquement la ligne de l'emote."
L["EMOTE_GROUP_GESTURE"] = "Geste"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "Joue une courte animation."
L["EMOTE_GROUP_VOICE"] = "Voix"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "Joue une réplique vocale."
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
L["IGNORED_BUFFS_ADD_RECENT"] = "Ignorer une amélioration récente"
L["IGNORED_BUFFS_ADD_RECENT_DESCRIPTION"] =
	"Ajoute une amélioration active sur vous en ce moment, ou une qu'un autre joueur vous a donnée depuis votre connexion."
-- The first %s is the buff's icon and name, the second the player who cast it.
L["IGNORED_BUFFS_RECENT_FROM"] = "%s, de %s"
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
-- Options: Wave to Friends
--------------------------------------------------------------------------------

L["TAB_WAVE_TO_FRIENDS"] = "Salut aux amis"
L["WAVE_ENABLE"] = "Activer le salut aux amis"
L["WAVE_ENABLE_DESCRIPTION"] =
	"Active une emote pour vos amis et membres de guilde quand vous les survolez avec la souris."
L["WAVE_DESCRIPTION"] =
	"Saluez vos amis et membres de guilde d'une emote quand vous les survolez avec la souris en parcourant le monde."
L["WAVE_RULES"] =
	"Jamais votre groupe ou votre raid, et jamais quand vous êtes en combat, en train d'incanter ou de pêcher."
L["WAVE_RESTING_ENABLE"] = "Uniquement au repos"
L["WAVE_RESTING_ENABLE_DESCRIPTION"] = "Ne salue que lorsque vous êtes au repos, dans une ville ou une auberge."
L["WAVE_COOLDOWN"] = "Délai pour un même joueur"
L["WAVE_COOLDOWN_DESCRIPTION"] = "Définit le délai avant que le même joueur puisse être salué à nouveau."
L["WAVE_COOLDOWN_ONCE_PER_SESSION"] = "Une fois par session"
-- %s is the default emotes' slash commands, as the client names them.
L["WAVE_EMOTES_RESET_DEFAULTS_DESCRIPTION"] = "Remet la liste sur %s uniquement."

-- Custom List
L["WAVE_TAB_CUSTOM"] = "Liste personnalisée"
L["WAVE_CUSTOM_DESCRIPTION"] =
	"Les joueurs qui reçoivent toujours leur propre emote, même avant Amis et Guildes. Choisissez Aucune pour ne jamais adresser d'emote à quelqu'un."
-- One of these two follows WAVE_CUSTOM_DESCRIPTION: realm clients, then WoW Forever, which has no realms.
L["WAVE_CUSTOM_NAMES_REALM"] =
	"Nom-Royaume ne correspond qu'à ce royaume ; un nom seul correspond à n'importe quel royaume."
L["WAVE_CUSTOM_NAMES_FOREVER"] =
	"Un nom complet correspond à un seul personnage ; un prénom seul correspond à tous ceux qui le portent."
L["WAVE_CUSTOM_ENABLE"] = "Activer la liste personnalisée"
L["WAVE_CUSTOM_ENABLE_DESCRIPTION"] = "Utilise les noms ci-dessous avant Amis et Guildes."
L["WAVE_CUSTOM_OFF_WARNING"] =
	"La liste personnalisée est désactivée, donc personne ci-dessous ne reçoit son emote."
L["WAVE_CUSTOM_ADD"] = "Ajouter un joueur"
L["WAVE_CUSTOM_ADD_DESCRIPTION"] =
	"Saisissez un nom ou Nom-Royaume, puis appuyez sur Entrée. Séparez plusieurs noms par des virgules."
L["WAVE_CUSTOM_ADD_DESCRIPTION_FOREVER"] =
	"Saisissez un nom complet ou un prénom, puis appuyez sur Entrée. Séparez plusieurs noms par des virgules."
L["WAVE_CUSTOM_EMPTY"] = "Aucun joueur pour l'instant. Ajoutez-en un ci-dessus."
L["WAVE_CUSTOM_EMOTE_DESCRIPTION"] = "Définit l'emote pour ce joueur, ou Aucune pour ne jamais lui adresser d'emote."
L["WAVE_CUSTOM_REMOVE"] = "Retire ce joueur de la liste."

-- Friends
L["WAVE_TAB_FRIENDS"] = "Amis"
L["WAVE_FRIENDS_ENABLE"] = "Saluer les amis"
L["WAVE_FRIENDS_ENABLE_DESCRIPTION"] = "Salue les personnages de votre liste d'amis."
L["WAVE_BNET_ENABLE"] = "Inclure les amis Battle.net"
L["WAVE_BNET_ENABLE_DESCRIPTION"] = "Salue aussi les personnages que jouent vos amis Battle.net."
L["WAVE_FRIENDS_EMOTES_DESCRIPTION"] =
	"Cochez les emotes parmi lesquelles choisir pour vos amis ; une est utilisée au hasard."

-- Guilds
L["WAVE_TAB_GUILDS"] = "Guildes"
L["WAVE_MY_GUILD_ENABLE"] = "Saluer ma guilde"
L["WAVE_MY_GUILD_ENABLE_DESCRIPTION"] = "Salue les membres de la guilde dont vous faites partie."
L["WAVE_GUILD_ADD"] = "Ajouter une guilde"
L["WAVE_GUILD_ADD_DESCRIPTION"] =
	"Saisissez le nom d'une guilde, puis appuyez sur Entrée. Séparez plusieurs guildes par des virgules. Les majuscules n'ont pas d'importance."
L["WAVE_GUILDS_EMPTY"] = "Aucune autre guilde pour l'instant. Ajoutez-en une ci-dessus."
L["WAVE_GUILD_REMOVE"] = "Retire cette guilde de la liste."
L["WAVE_GUILDS_EMOTES_DESCRIPTION"] =
	"Cochez les emotes parmi lesquelles choisir pour les membres de guilde ; une est utilisée au hasard."

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks, Good News and each Thank You Button.
L["WHISPER_MESSAGE"] = "Message chuchoté"
L["WHISPER_MESSAGE_RESET"] = "Réinitialiser"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Rétablit le texte par défaut du message chuchoté."

-- The whisper composer around every editable whisper's box, on Give Thanks and Good News.
L["SEND_MESSAGES_IN"] = "Envoyer les messages en"
L["SEND_MESSAGES_IN_DESCRIPTION"] =
	"Définit la langue dans laquelle TFTB écrit aux autres joueurs. Choisir une autre langue utilise son texte par défaut, sauf si vous avez écrit le vôtre."
L["WHISPER_SIGN_OFF_DESCRIPTION"] =
	"Ajouté à chaque message envoyé par TFTB, pour que les autres joueurs sachent qu'il vient d'un add-on."
-- TRANSLATORS: each %s is a token, {spell} then {name}, drawn in blue.
L["WHISPER_TOKENS"] = "Balises : %s l'amélioration, %s qui l'a lancée"
L["WHISPER_TOO_LONG"] = "Trop long, le texte par défaut sera donc envoyé à la place."
L["WHISPER_TEST"] = "M'envoyer un test"
L["WHISPER_TEST_DESCRIPTION"] =
	"Vous chuchote l'exemple, pour que vous le voyiez exactement comme les autres joueurs le verront."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

-- The Thank You Button whisper's default, in the client's own language; Give Thanks' and Good News' defaults live in Data/Message-Languages.lua.
L["DEFAULT_WHISPER"] = "Merci, t'es au top ! (="
