local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "esMX")
if not L then return end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff (TFTB)"
L["ADDON_SHORT"] = "TFTB"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] = "Versión %s. La configuración (incluida la opción para desactivar este mensaje) se encuentra en Opciones > AddOns > Thanks for the Buff. ¿Te gusta el add-on? ¡Cuéntaselo a un amigo! (="
L["MSG_RESET"] = "Todas las opciones han sido restablecidas a sus valores predeterminados."

-- Buff & gift announcements
L["MSG_BUFFED"] = "¡%s te ha dado %s!"
L["MSG_GAVE_YOU"] = "¡%s te ha dado %s!"
L["MSG_GAVE_GROUP"] = "¡%s le dio a tu grupo %s!"
L["MSG_USED_ITEM"] = "¡%s usó %s %s en ti!"
L["MSG_USED_SPELL"] = "¡%s usó %s en ti!"
L["MSG_SET_OUT"] = "¡%s puso %s!"
L["MSG_OPENED"] = "¡%s abrió %s!"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "¡Gracias por %s!"
L["MSG_SELECT_PLAYER"] = "Selecciona a un jugador para agradecerle."
L["MSG_CANT_THANK_SELF"] = "¡No puedes agradecerte a ti mismo!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MSG_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "su"
L["PRONOUN_HER"] = "su"
L["PRONOUN_THEIR"] = "su"
L["UNKNOWN_SPELL"] = "Hechizo desconocido"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensaje de bienvenida"
L["OPTIONS_WELCOME_DESC"] = "Imprime un mensaje en el chat cuando inicias sesión."
L["OPTIONS_RESET_ALL_PROFILES"] = "Restablecer todos los perfiles"
L["OPTIONS_RESET_ALL_PROFILES_DESCRIPTION"] = "Restablece todos los perfiles de esta cuenta a los ajustes predeterminados."
L["OPTIONS_RESET_ALL_PROFILES_CONFIRM"] = "Esto restablecerá TODOS los perfiles de tu cuenta a los ajustes predeterminados, en todos los personajes. No se puede deshacer. ¿Continuar?"
L["OPTIONS_DESCRIPTION"] = "Expresa automáticamente tu agradecimiento con gestos y mensajes cada vez que recibas un beneficio, ya sea de un desconocido en el mundo abierto o de un compañero de equipo que use un tiempo de reutilización para ti en combate."
L["OPTIONS_SUPPORT"] = "Comentarios y Soporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Abre la interfaz de opciones de Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Realiza un emote y susurra al jugador objetivo."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "Beneficios de Desconocidos"
L["STRANGERS_DESC"] = "Un beneficio sobre ti de un jugador fuera de tu grupo (mundo abierto)."
L["STRANGERS_COOLDOWN"] = "Tiempo de reutilización (Segundos)"
L["STRANGERS_COOLDOWN_DESC"] = "Con qué frecuencia máxima se enviará un emote al mismo jugador.\n\nLos mensajes no se ven afectados; se activan para cada beneficio."
L["STRANGERS_MIN_DURATION"] = "Duración mínima del beneficio (Segundos)"
L["STRANGERS_MIN_DURATION_DESC"] = "Duración mínima que debe durar el beneficio para activar un agradecimiento.\n\nFiltra sanaciones cortas en el tiempo como Renovar o Rejuvenecimiento."
L["STRANGERS_MESSAGING"] = "Mensajes"
L["STRANGERS_EMOTES_SELECT"] = "Seleccionar Emotes"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

L["TEAMMATES_TITLE"] = "Beneficios de Compañeros de Equipo"
L["TEAMMATES_DESC"] = "Un beneficio o tiempo de reutilización de un miembro del grupo o banda lanzado sobre ti."
L["SERVICES_TITLE"] = "Servicios de Grupo"
L["SERVICES_DESC"] = "Ayuda para toda la banda de un miembro del grupo o banda: festines, pozos de almas, portales, bots de reparación."
L["COMBAT_MESSAGING"] = "Mensajes"
L["COMBAT_EMOTES_SELECT"] = "Seleccionar Emotes"
L["COMBAT_TRACKED"] = "Habilidades rastreadas:"
L["COMBAT_TOGGLE_TRACKING"] = "Alternar rastreo para %s"
L["COMBAT_GROUP_ITEMS"] = "Objetos"
L["COMBAT_ITEM_PENDING"] = "Objeto #%d"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Botón de Agradecimiento"
L["BUTTON_DESC"] = "Agradece a tu objetivo actual con un emote y un susurro."
L["BUTTON_CREATE_MACRO"] = "Crear Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Se creará automáticamente una macro llamada %s al iniciar sesión."
L["BUTTON_WHISPER"] = "Mensaje de Susurro"
L["BUTTON_RESET"] = "Restablecer"
L["BUTTON_RESET_DESC"] = "Restablece el mensaje de susurro al texto predeterminado."
L["BUTTON_EMOTES_SELECT"] = "Seleccionar Emotes"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_PRINT_ENABLE"] = "Habilitar mensajes impresos (Solo para ti)"
L["MESSAGING_PRINT_DESC"] = "Imprime un mensaje en tu propio chat cuando recibes un beneficio. Solo tú lo ves."
L["MESSAGING_WHISPER_ENABLE"] = "Habilitar mensajes de agradecimiento"
L["MESSAGING_WHISPER_DESC"] = "Susurra un agradecimiento al jugador que te dio el beneficio."
L["MESSAGING_EMOTES_ENABLE"] = "Habilitar Emotes (Fuera de combate)"
L["MESSAGING_EMOTES_DESC"] = "Muestra tu aprecio con un emote. Los emotes se retienen mientras estás en combate."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "¡Gracias, eres el mejor! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESC"] = "Animas a <Target>."
L["EMOTE_DRINK_DESC"] = "Levantas una copa por <Target>."
L["EMOTE_FLEX_DESC"] = "Muestras tus músculos a <Target>."
L["EMOTE_GRIN_DESC"] = "Le sonríes con malicia a <Target>."
L["EMOTE_HIGHFIVE_DESC"] = "Chocas los cinco con <Target>."
L["EMOTE_PRAISE_DESC"] = "Elogias a <Target>."
L["EMOTE_SALUTE_DESC"] = "Saludas a <Target> con respeto."
L["EMOTE_SMILE_DESC"] = "Le sonríes a <Target>."
L["EMOTE_THANK_DESC"] = "Le das las gracias a <Target>."
L["EMOTE_WHOA_DESC"] = "Miras a <Target> y exclamas '¡Wow!'."
L["EMOTE_WINK_DESC"] = "Le guiñas un ojo a <Target>."
L["EMOTE_YES_DESC"] = "Asientes a <Target>."
