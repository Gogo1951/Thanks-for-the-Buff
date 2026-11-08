local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "esMX")
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
	"Versión %s. La configuración (incluida la opción para desactivar este mensaje) está en Opciones > Accesorios > Thanks for the Buff (TFTB). ¿Te gusta este accesorio? Cuéntaselo a un amigo, márcalo como favorito en CurseForge o presiona Star en GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por seguridad, la interfaz de opciones no se puede abrir durante el combate."

-- Buff print out
L["MESSAGE_BUFFED"] = "¡%s te benefició con %s!"

-- Thank You Button
L["MESSAGE_SELECT_PLAYER"] = "Primero selecciona a un jugador como objetivo."
L["MESSAGE_CANT_THANK_SELF"] = "¡No puedes agradecerte a ti mismo!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Hechizo desconocido"
L["SAMPLE_EXAMPLE"] = "Ejemplo: %s"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensaje de bienvenida"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Muestra un mensaje que solo tú puedes ver al iniciar sesión."
L["OPTIONS_DESCRIPTION"] =
	"Agradece automáticamente con una emoción o un susurro a los jugadores que te den un beneficio. Los desconocidos que te lancen Entereza, Intelecto Arcano o Marca de lo Salvaje reciben tu agradecimiento al momento, y un clic en tus macros de agradecimiento da las gracias a quien tengas como objetivo."
L["OPTIONS_FEATURES_HEADER"] = "Funciones"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Activa o desactiva cada función aquí o en su propio panel."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre la interfaz de opciones de este accesorio."

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "¿Buscas otras funciones?"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"Algunas funciones se mudaron a nuestro nuevo accesorio, Good to Go. Encuéntralo en CurseForge o Wago."

--------------------------------------------------------------------------------
-- Options: Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "Ayuda a Thanks for the Buff (TFTB) a subir de nivel"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"Este accesorio lo crearon jugadores que aman este juego y quieren hacerlo lo más divertido posible para todos. Nunca pediremos donaciones. La verdadera satisfacción está en saber que nuestro trabajo hace el juego un poco mejor para ti. Si es así, ¡nos encantaría saberlo!"
L["OPTIONS_LEVEL_UP_WAYS"] = "Estas son algunas formas en las que puedes ayudarnos a llegar a más jugadores."
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• Comparte tus comentarios: ¿encontraste un error o tienes una idea? Avísanos en Discord. Tus comentarios nos ayudan a mejorar el accesorio, y las pull requests siempre son bienvenidas."
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• Cuéntaselo a un amigo: ¿conoces a alguien a quien le podría gustar este accesorio? Háblale de él. El boca a boca ayuda a que más jugadores descubran grandes accesorios."
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	"• Márcalo como favorito en CurseForge: abre el enlace de CurseForge de abajo, inicia sesión y haz clic en la estrella que hay debajo del botón Download. Los favoritos ayudan a que más jugadores descubran el accesorio."
L["OPTIONS_LEVEL_UP_GITHUB"] =
	"• Presiona Star en GitHub: abre el enlace de GitHub de abajo, inicia sesión y haz clic en Star, arriba a la derecha. Las estrellas ayudan al proyecto a acceder a más herramientas de desarrollo gratuitas."
L["OPTIONS_LEVEL_UP_THANKS"] = "¡Gracias por elegir Thanks for the Buff (TFTB)!"

L["OPTIONS_FEEDBACK"] = "Comentarios y soporte"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "Enlaces de comentarios y soporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "Para copiar un enlace, haz clic en su casilla y luego presiona Ctrl+A y Ctrl+C."
L["OPTIONS_VERSION"] = "Versión %s"

--------------------------------------------------------------------------------
-- Options: Give Thanks
--------------------------------------------------------------------------------

L["TAB_GIVE_THANKS"] = "Agradecimientos"
L["GIVE_THANKS_ENABLE"] = "Habilitar agradecimientos"
L["GIVE_THANKS_ENABLE_DESCRIPTION"] = "Activa los agradecimientos por beneficios de jugadores de fuera de tu grupo."
L["GIVE_THANKS_DESCRIPTION"] = "Agradece a los jugadores de fuera de tu grupo cuando te benefician en el mundo abierto."

-- Praise Limits
L["PRAISE_HEADER"] = "Límites de elogios"
L["PRAISE_DESCRIPTION"] =
	"Estas opciones retienen tanto la emoción como el susurro, para que una oleada de beneficios nunca se convierta en spam."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["GIVE_THANKS_OVERALL_COOLDOWN"] = "Reutilización de elogios"
L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Establece el tiempo de espera entre una ronda de elogios y la siguiente, sin importar quién te haya dado el beneficio. Ponlo en cero para elogiar todos los beneficios."
L["GIVE_THANKS_SOURCE_COOLDOWN"] = "Reutilización de elogios al mismo jugador"
L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Establece el tiempo de espera entre elogios dirigidos al mismo jugador. Ponlo en cero para elogiar todos los beneficios."
L["GIVE_THANKS_MIN_DURATION"] = "Duración mínima del beneficio"
L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"] =
	"Ignora los beneficios que duran menos que este valor. Ponlo en cero para reaccionar a todos los beneficios."
L["PRAISE_DELAY_ENABLE"] = "Habilitar retraso del elogio"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Espera un momento antes del susurro y la emoción, para que tu agradecimiento no llegue en el mismo instante que el beneficio. Las notificaciones no se ven afectadas."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Establece cuánto se espera antes de enviar el susurro y la emoción."

-- Thank-You Whispers
L["WHISPERS_HEADER"] = "Susurros de agradecimiento"
L["PRAISE_WHISPER_ENABLE"] = "Habilitar susurros de agradecimiento"
L["PRAISE_WHISPER_DESCRIPTION"] = "Le susurra un agradecimiento al jugador que te dio el beneficio."
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"Establece lo que TFTB le susurra al jugador que te dio el beneficio. {spell} se reemplaza por el beneficio. Déjalo vacío para no enviar ningún susurro."

-- Notifications
L["NOTIFICATIONS_HEADER"] = "Notificaciones"
L["NOTIFICATIONS_DESCRIPTION"] = "Lo que solo recibes tú: un aviso de texto, un sonido o ambos."
L["NOTIFICATIONS_PRINT_ENABLE"] = "Habilitar avisos de texto"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Muestra un mensaje que solo tú puedes ver cuando recibes un beneficio."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Habilitar efectos de sonido"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Reproduce un sonido cuando recibes un beneficio. Solo tú lo oyes."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Reproduce el sonido para que puedas oírlo antes de activarlo."

-- Emotes: the grid's group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS entry, upper-cased.
L["TAB_EMOTES_LIST"] = "Lista de emociones"
L["EMOTES_GRID_DESCRIPTION"] =
	"Marca las emociones entre las que puede elegir la función Agradecimientos cuando un jugador de fuera de tu grupo te da un beneficio; usa una al azar. Las emociones se retienen mientras estás en combate."
L["EMOTE_GROUP_COUNT"] = "%s (%d de %d marcadas)"
L["EMOTE_GROUP_TEXT"] = "Texto"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "Solo muestra la línea de la emoción."
L["EMOTE_GROUP_VOICE"] = "Voz"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "Reproduce una frase hablada."
L["EMOTE_GROUP_GESTURE"] = "Gesto"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "Reproduce una animación corta."
L["EMOTE_GROUP_POSE"] = "Postura"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "Se mantiene hasta que te mueves."
L["EMOTES_RESET"] = "Restablecer emociones"
L["EMOTES_RESET_DESCRIPTION"] = "Regresa la lista a las emociones de agradecimiento predeterminadas."
L["EMOTES_RESET_CONFIRM"] = "¿Restablecer la lista de emociones a los valores predeterminados?"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "Beneficios ignorados"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"Los beneficios de esta lista nunca reciben un agradecimiento, sin importar quién los lance. Sigues recibiendo tu aviso de texto y tu sonido."
L["IGNORED_BUFFS_ADD_CURRENT"] = "Ignorar beneficio actual"
L["IGNORED_BUFFS_ADD_CURRENT_DESCRIPTION"] = "Agrega uno de los beneficios que tienes en este momento."
L["IGNORED_BUFFS_ADD"] = "Agregar beneficio"
L["IGNORED_BUFFS_ADD_DESCRIPTION"] =
	"Escribe un ID de hechizo o haz Mayús-clic en el enlace de un beneficio para ponerlo en la casilla, y luego presiona Enter."
L["IGNORED_BUFFS_EMPTY"] = "Todavía no hay beneficios ignorados. Agrega uno arriba."
L["IGNORED_BUFFS_REMOVE"] = "Quita este beneficio de la lista."
L["IGNORED_BUFFS_NOT_FOUND"] = "No se encontró ningún beneficio para %s."
L["IGNORED_BUFFS_ALL_CHARACTERS"] = "Todos los personajes"
L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"] =
	"Mueve este beneficio a la lista Todos los personajes, para que no se agradezca en ningún personaje."

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Botón de agradecimiento"
L["BUTTON_DESCRIPTION"] = "Susurra a tu objetivo y dedícale una emoción con una sola tecla. Cortesía, automatizada."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Botón de agradecimiento %d"
L["BUTTON_EMOTE"] = "Emoción"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Establece la emoción que este botón realiza hacia tu objetivo, o Ninguna para no realizar ninguna."
L["BUTTON_EMOTE_NONE"] = "Ninguna"
-- Titles Thank You Button 1's emote checklist.
L["EMOTES_SELECT"] = "Seleccionar emociones"
L["BUTTON_ICON"] = "Ícono"
L["BUTTON_ICON_DESCRIPTION"] =
	"Establece el ícono que muestra la macro de este botón en tu lista de macros y en tus barras de acción."
-- The Icon dropdown's first choice, the macros' own icon; every other choice is a picture alone.
L["BUTTON_ICON_DEFAULT"] = "Predeterminado"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Habilitar macro "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "Crea una macro llamada %s y la elimina al desactivar esta opción."
L["BUTTON_WHISPER_DESCRIPTION"] =
	"Establece lo que este botón le susurra a tu objetivo. Déjalo vacío para no enviar ningún susurro."

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks and each Thank You Button.
L["WHISPER_MESSAGE"] = "Mensaje de susurro"
L["WHISPER_MESSAGE_RESET"] = "Restablecer"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Restablece el mensaje de susurro al texto predeterminado."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "¡Gracias, eres lo máximo! (="
-- TRANSLATORS: keep {spell} exactly as written; TFTB swaps in the buff's link.
L["DEFAULT_GIVE_THANKS_WHISPER"] = "Gracias por {spell}"
