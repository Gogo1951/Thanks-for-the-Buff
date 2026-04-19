local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "esES") or LibStub("AceLocale-3.0"):NewLocale("TFTB", "esMX")
if not L then return end

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["MSG_ENABLED"] = "Habilitado. Usa /tftb para ajustar tus opciones, incluyendo desactivar este mensaje. (="
L["MSG_DB_ERROR"] = "Error: No se pudieron cargar los valores predeterminados de la base de datos. Restablece tu perfil a través de /tftb."
L["MSG_RESET"] = "Todas las opciones han sido restablecidas a sus valores predeterminados."
L["MSG_BUFFED"] = "¡%s te ha dado %s!"
L["MSG_HIT"] = "¡%s te ha golpeado con %s!"
L["MSG_PARTY_ITEM"] = "¡%s usó %s para tu grupo!"
L["MSG_WHISPER_THANKS"] = "¡Gracias por %s!"
L["MSG_SELECT_PLAYER"] = "Selecciona a un jugador para agradecerle."
L["MSG_CANT_THANK_SELF"] = "¡No puedes agradecerte a ti mismo!"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_GENERAL"] = "Ajustes Generales"
L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensaje de bienvenida"
L["OPTIONS_WELCOME_DESC"] = "Imprime un mensaje en el chat cuando inicias sesión."
L["OPTIONS_RESET"] = "Restablecer"
L["OPTIONS_RESET_ALL"] = "Restablecer todos los ajustes"
L["OPTIONS_RESET_ALL_DESC"] = "Restaura cada opción a su valor predeterminado."
L["OPTIONS_RESET_CONFIRM"] = "¿Estás seguro de que quieres restablecer todas las opciones a sus valores predeterminados?"
L["OPTIONS_DESCRIPTION"] = "Expresa felicidad automáticamente con un emote cada vez que recibes un nuevo beneficio."
L["OPTIONS_SUPPORT"] = "Comentarios y Soporte"
L["OPTIONS_CMD_TFTB_DESC"] = "Abre la interfaz de opciones de Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU_DESC"] = "Realiza un emote y susurra al jugador objetivo."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "Beneficios de Desconocidos"
L["STRANGERS_ENABLE"] = "Reaccionar a beneficios de desconocidos"
L["STRANGERS_COOLDOWN"] = "Tiempo de reutilización (Segundos)"
L["STRANGERS_COOLDOWN_DESC"] = "Con qué frecuencia máxima se agradecerá al mismo jugador."
L["STRANGERS_MIN_DURATION"] = "Duración mínima del beneficio (Segundos)"
L["STRANGERS_MIN_DURATION_DESC"] = "Duración mínima que debe durar el beneficio para activar un agradecimiento.\n\nFiltra sanaciones cortas en el tiempo como Renovar o Rejuvenecimiento."
L["STRANGERS_MESSAGING"] = "Mensajes"
L["STRANGERS_EMOTES_ENABLE"] = "Habilitar Emotes"
L["STRANGERS_EMOTES_DESC"] = "Muestra tu aprecio por los beneficios de desconocidos con emotes."
L["STRANGERS_EMOTES_SELECT"] = "Seleccionar Emotes"

--------------------------------------------------------------------------------
-- Options: Combat Buffs
--------------------------------------------------------------------------------

L["COMBAT_TITLE"] = "Beneficios de Combate"
L["COMBAT_MESSAGING"] = "Mensajes"
L["COMBAT_TRACKED"] = "Habilidades rastreadas:"
L["COMBAT_TOGGLE_TRACKING"] = "Alternar rastreo para %s"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Botón de Agradecimiento"
L["BUTTON_CREATE_MACRO"] = "Crear Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Se creará automáticamente una macro llamada %s al iniciar sesión."
L["BUTTON_WHISPER"] = "Mensaje de Susurro"
L["BUTTON_RESET"] = "Restablecer"
L["BUTTON_RESET_DESC"] = "Restablece el mensaje de susurro al texto predeterminado."
L["BUTTON_EMOTES_HEADER"] = "Emotes del Botón de Agradecimiento:"
L["BUTTON_EMOTES_SELECT"] = "Seleccionar Emotes"

--------------------------------------------------------------------------------
-- Shared: Messaging Dropdown
--------------------------------------------------------------------------------

L["MESSAGING_NONE"] = "Ningún mensaje"
L["MESSAGING_NONE_DEFAULT"] = "Ningún mensaje (Predeterminado)"
L["MESSAGING_PRINT"] = "Mensaje impreso (Solo para ti)"
L["MESSAGING_WHISPER"] = "Mensaje de Susurro"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "¡Gracias, eres el mejor! (="