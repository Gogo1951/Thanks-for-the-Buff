local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "frFR")
if not L then return end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] = "Version %s. Les paramètres (y compris l'option pour désactiver ce message) se trouvent dans Options > AddOns > Thanks for the Buff. Vous aimez l'add-on ? Parlez-en à un ami ! (="
L["MSG_RESET"] = "Tous les paramètres ont été réinitialisés aux valeurs par défaut."

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s vous a amélioré avec %s !"
L["MSG_GAVE_YOU"] = "%s vous a donné %s !"
L["MSG_GAVE_GROUP"] = "%s a donné %s à votre groupe !"
L["MSG_USED_ITEM"] = "%s a utilisé %s %s sur vous !"
L["MSG_USED_SPELL"] = "%s a utilisé %s sur vous !"
L["MSG_SET_OUT"] = "%s a déployé %s !"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "Merci pour %s !"
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
L["OPTIONS_RESET"] = "Réinitialiser"
L["OPTIONS_RESET_ALL"] = "Réinitialiser tous les paramètres"
L["OPTIONS_RESET_ALL_DESC"] = "Restaure toutes les options à leurs valeurs par défaut."
L["OPTIONS_RESET_CONFIRM"] = "Êtes-vous sûr de vouloir réinitialiser tous les paramètres à leurs valeurs par défaut ?"
L["OPTIONS_DESCRIPTION"] = "Exprimez automatiquement votre gratitude avec des emotes et des messages chaque fois que vous recevez une amélioration — que ce soit un inconnu dans le monde ouvert ou un coéquipier qui utilise un temps de recharge pour vous en combat."
L["OPTIONS_SUPPORT"] = "Commentaires et Assistance"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Ouvre l'interface des options de Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Exécute une emote et chuchote à votre joueur ciblé."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "Améliorations d'Inconnus"
L["STRANGERS_DESC"] = "Une amélioration sur vous d'un joueur en dehors de votre groupe (monde ouvert)."
L["STRANGERS_COOLDOWN"] = "Temps de recharge (Secondes)"
L["STRANGERS_COOLDOWN_DESC"] = "Fréquence maximale d'utilisation d'une emote envers le même joueur.\n\nLes messages ne sont pas affectés ; ils se déclenchent pour chaque amélioration."
L["STRANGERS_MIN_DURATION"] = "Durée minimale de l'amélioration (Secondes)"
L["STRANGERS_MIN_DURATION_DESC"] = "Durée minimale pendant laquelle l'amélioration doit persister pour déclencher un remerciement.\n\nFiltre les soins sur la durée courts comme Rénovation ou Récupération."
L["STRANGERS_MESSAGING"] = "Messagerie"
L["STRANGERS_EMOTES_SELECT"] = "Sélectionner des Emotes"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

L["TEAMMATES_TITLE"] = "Améliorations de Coéquipiers"
L["TEAMMATES_DESC"] = "Une amélioration ou un temps de recharge d'un membre du groupe ou du raid lancé sur vous."
L["SERVICES_TITLE"] = "Services de Groupe"
L["SERVICES_DESC"] = "Aide à l'échelle du raid d'un membre du groupe ou du raid — festins, puits des âmes, portails, robots de réparation."
L["COMBAT_MESSAGING"] = "Messagerie"
L["COMBAT_EMOTES_SELECT"] = "Sélectionner des Emotes"
L["COMBAT_TRACKED"] = "Capacités suivies :"
L["COMBAT_TOGGLE_TRACKING"] = "Basculer le suivi pour %s"
L["COMBAT_GROUP_ITEMS"] = "Objets"
L["COMBAT_ITEM_PENDING"] = "Objet #%d"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Bouton de Remerciement"
L["BUTTON_DESC"] = "Remerciez votre cible actuelle avec une emote et un chuchotement."
L["BUTTON_CREATE_MACRO"] = "Créer une Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Une macro nommée %s sera automatiquement créée pour vous à la connexion."
L["BUTTON_WHISPER"] = "Message de Chuchotement"
L["BUTTON_RESET"] = "Réinitialiser"
L["BUTTON_RESET_DESC"] = "Réinitialise le message de chuchotement au texte par défaut."
L["BUTTON_EMOTES_SELECT"] = "Sélectionner des Emotes"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_PRINT_ENABLE"] = "Activer les messages imprimés (Vous uniquement)"
L["MESSAGING_PRINT_DESC"] = "Affiche un message dans votre propre discussion lorsque vous recevez une amélioration. Vous seul le voyez."
L["MESSAGING_WHISPER_ENABLE"] = "Activer les messages de remerciement"
L["MESSAGING_WHISPER_DESC"] = "Chuchote un remerciement au joueur qui vous a amélioré."
L["MESSAGING_EMOTES_ENABLE"] = "Activer les Emotes (Hors combat)"
L["MESSAGING_EMOTES_DESC"] = "Exprimez votre appréciation par une emote. Les emotes sont retenues pendant que vous êtes en combat."

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
