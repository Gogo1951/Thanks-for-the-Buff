local strings = {}

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

strings["MSG_ENABLED"] = "Habilitado. Usa /tftb para ajustar tus opciones, incluyendo desactivar este mensaje. (="
strings["MSG_DB_ERROR"] = "Error: No se pudieron cargar los valores predeterminados de la base de datos. Restablece tu perfil a través de /tftb."
strings["MSG_RESET"] = "Todas las opciones han sido restablecidas a sus valores predeterminados."
strings["MSG_BUFFED"] = "¡%s te ha dado %s!"
strings["MSG_HIT"] = "¡%s te ha golpeado con %s!"
strings["MSG_PARTY_ITEM"] = "¡%s usó %s para tu grupo!"
strings["MSG_WHISPER_THANKS"] = "¡Gracias por %s!"
strings["MSG_SELECT_PLAYER"] = "Selecciona a un jugador para agradecerle."
strings["MSG_CANT_THANK_SELF"] = "¡No puedes agradecerte a ti mismo!"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

strings["OPTIONS_TITLE"] = "Thanks for the Buff!"
strings["OPTIONS_GENERAL"] = "Ajustes Generales"
strings["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensaje de bienvenida"
strings["OPTIONS_WELCOME_DESC"] = "Imprime un mensaje en el chat cuando inicias sesión."
strings["OPTIONS_RESET"] = "Restablecer"
strings["OPTIONS_RESET_ALL"] = "Restablecer todos los ajustes"
strings["OPTIONS_RESET_ALL_DESC"] = "Restaura cada opción a su valor predeterminado."
strings["OPTIONS_RESET_CONFIRM"] = "¿Estás seguro de que quieres restablecer todas las opciones a sus valores predeterminados?"
strings["OPTIONS_DESCRIPTION"] = "Expresa felicidad automáticamente con un emote cada vez que recibes un nuevo beneficio."
strings["OPTIONS_SUPPORT"] = "Comentarios y Soporte"
strings["OPTIONS_CURSEFORGE"] = "CurseForge"
strings["OPTIONS_GITHUB"] = "GitHub"
strings["OPTIONS_DISCORD"] = "Discord"
strings["OPTIONS_CMD_TFTB"] = "/tftb"
strings["OPTIONS_CMD_TFTB_DESC"] = "Abre la interfaz de opciones de Thanks for the Buff."
strings["OPTIONS_CMD_THANKYOU"] = "/thankyou"
strings["OPTIONS_CMD_THANKYOU_DESC"] = "Realiza un emote y susurra al jugador objetivo."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

strings["STRANGERS_TITLE"] = "Beneficios de Desconocidos"
strings["STRANGERS_ENABLE"] = "Reaccionar a beneficios de desconocidos"
strings["STRANGERS_COOLDOWN"] = "Tiempo de reutilización (Segundos)"
strings["STRANGERS_COOLDOWN_DESC"] = "Con qué frecuencia máxima se agradecerá al mismo jugador."
strings["STRANGERS_MIN_DURATION"] = "Duración mínima del beneficio (Segundos)"
strings["STRANGERS_MIN_DURATION_DESC"] = "Duración mínima que debe durar el beneficio para activar un agradecimiento.\n\nFiltra sanaciones cortas en el tiempo como Renovar o Rejuvenecimiento."
strings["STRANGERS_MESSAGING"] = "Mensajes"
strings["STRANGERS_EMOTES_ENABLE"] = "Habilitar Emotes"
strings["STRANGERS_EMOTES_DESC"] = "Muestra tu aprecio por los beneficios de desconocidos con emotes."
strings["STRANGERS_EMOTES_SELECT"] = "Seleccionar Emotes"

--------------------------------------------------------------------------------
-- Options: Combat Buffs
--------------------------------------------------------------------------------

strings["COMBAT_TITLE"] = "Beneficios de Combate"
strings["COMBAT_MESSAGING"] = "Mensajes"
strings["COMBAT_TRACKED"] = "Habilidades rastreadas:"
strings["COMBAT_TOGGLE_TRACKING"] = "Alternar rastreo para %s"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

strings["BUTTON_TITLE"] = "Botón de Agradecimiento"
strings["BUTTON_CREATE_MACRO"] = "Crear Macro"
strings["BUTTON_CREATE_MACRO_DESC"] = "Se creará automáticamente una macro llamada %s al iniciar sesión."
strings["BUTTON_WHISPER"] = "Mensaje de Susurro"
strings["BUTTON_RESET"] = "Restablecer"
strings["BUTTON_RESET_DESC"] = "Restablece el mensaje de susurro al texto predeterminado."
strings["BUTTON_EMOTES_HEADER"] = "Emotes del Botón de Agradecimiento:"
strings["BUTTON_EMOTES_SELECT"] = "Seleccionar Emotes"

--------------------------------------------------------------------------------
-- Shared: Messaging Dropdown
--------------------------------------------------------------------------------

strings["MESSAGING_NONE"] = "Ningún mensaje"
strings["MESSAGING_NONE_DEFAULT"] = "Ningún mensaje (Predeterminado)"
strings["MESSAGING_PRINT"] = "Mensaje impreso (Solo para ti)"
strings["MESSAGING_WHISPER"] = "Mensaje de Susurro"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

strings["DEFAULT_WHISPER"] = "¡Gracias, eres el mejor! (="

--------------------------------------------------------------------------------
-- Registration (esES + esMX)
--------------------------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "esES")
if L then
    for k, v in pairs(strings) do L[k] = v end
end

local L2 = LibStub("AceLocale-3.0"):NewLocale("TFTB", "esMX")
if L2 then
    for k, v in pairs(strings) do L2[k] = v end
end