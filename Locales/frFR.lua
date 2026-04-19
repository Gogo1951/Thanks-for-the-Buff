local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "frFR")
if not L then return end

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["MSG_ENABLED"] = "Activé. Utilisez /tftb pour ajuster vos paramètres ; y compris pour désactiver ce message. (="
L["MSG_DB_ERROR"] = "Erreur : Échec du chargement des paramètres par défaut. Veuillez réinitialiser votre profil via /tftb."
L["MSG_RESET"] = "Tous les paramètres ont été réinitialisés aux valeurs par défaut."
L["MSG_BUFFED"] = "%s vous a amélioré avec %s !"
L["MSG_HIT"] = "%s vous a touché avec %s !"
L["MSG_PARTY_ITEM"] = "%s a utilisé %s pour votre groupe !"
L["MSG_WHISPER_THANKS"] = "Merci pour %s !"
L["MSG_SELECT_PLAYER"] = "Sélectionnez un joueur à remercier."
L["MSG_CANT_THANK_SELF"] = "Vous ne pouvez pas vous remercier vous-même !"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_GENERAL"] = "Paramètres Généraux"
L["OPTIONS_WELCOME_TOGGLE"] = "Activer le message de bienvenue"
L["OPTIONS_WELCOME_DESC"] = "Affiche un message dans la discussion à la connexion."
L["OPTIONS_RESET"] = "Réinitialiser"
L["OPTIONS_RESET_ALL"] = "Réinitialiser tous les paramètres"
L["OPTIONS_RESET_ALL_DESC"] = "Restaure toutes les options à leurs valeurs par défaut."
L["OPTIONS_RESET_CONFIRM"] = "Êtes-vous sûr de vouloir réinitialiser tous les paramètres à leurs valeurs par défaut ?"
L["OPTIONS_DESCRIPTION"] = "Exprime automatiquement de la joie avec une emote chaque fois que vous recevez une nouvelle amélioration."
L["OPTIONS_SUPPORT"] = "Commentaires et Assistance"
L["OPTIONS_CMD_TFTB_DESC"] = "Ouvre l'interface des options de Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU_DESC"] = "Exécute une emote et chuchote à votre joueur ciblé."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "Améliorations d'Inconnus"
L["STRANGERS_ENABLE"] = "Réagir aux améliorations d'inconnus"
L["STRANGERS_COOLDOWN"] = "Temps de recharge (Secondes)"
L["STRANGERS_COOLDOWN_DESC"] = "Fréquence maximale à laquelle remercier le même joueur."
L["STRANGERS_MIN_DURATION"] = "Durée minimale de l'amélioration (Secondes)"
L["STRANGERS_MIN_DURATION_DESC"] = "Durée minimale pendant laquelle l'amélioration doit persister pour déclencher un remerciement.\n\nFiltre les soins sur la durée courts comme Rénovation ou Récupération."
L["STRANGERS_MESSAGING"] = "Messagerie"
L["STRANGERS_EMOTES_ENABLE"] = "Activer les Emotes"
L["STRANGERS_EMOTES_DESC"] = "Montrez votre appréciation pour les améliorations d'inconnus avec des emotes."
L["STRANGERS_EMOTES_SELECT"] = "Sélectionner des Emotes"

--------------------------------------------------------------------------------
-- Options: Combat Buffs
--------------------------------------------------------------------------------

L["COMBAT_TITLE"] = "Améliorations de Combat"
L["COMBAT_MESSAGING"] = "Messagerie"
L["COMBAT_TRACKED"] = "Capacités suivies :"
L["COMBAT_TOGGLE_TRACKING"] = "Basculer le suivi pour %s"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Bouton de Remerciement"
L["BUTTON_CREATE_MACRO"] = "Créer une Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Une macro nommée %s sera automatiquement créée pour vous à la connexion."
L["BUTTON_WHISPER"] = "Message de Chuchotement"
L["BUTTON_RESET"] = "Réinitialiser"
L["BUTTON_RESET_DESC"] = "Réinitialise le message de chuchotement au texte par défaut."
L["BUTTON_EMOTES_HEADER"] = "Emotes du Bouton de Remerciement :"
L["BUTTON_EMOTES_SELECT"] = "Sélectionner des Emotes"

--------------------------------------------------------------------------------
-- Shared: Messaging Dropdown
--------------------------------------------------------------------------------

L["MESSAGING_NONE"] = "Aucun message"
L["MESSAGING_NONE_DEFAULT"] = "Aucun message (Défaut)"
L["MESSAGING_PRINT"] = "Message imprimé (Vous uniquement)"
L["MESSAGING_WHISPER"] = "Message de Chuchotement"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Merci, t'es le meilleur ! (="