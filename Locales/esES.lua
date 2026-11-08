local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "esES")
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
	"Versión %s. La configuración (incluida la opción para desactivar este mensaje) está en Opciones > Accesorios > Thanks for the Buff (TFTB). ¿Te gusta este accesorio? Cuéntaselo a un amigo, márcalo como favorito en CurseForge o pulsa Star en GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por seguridad, la interfaz de opciones no se puede abrir durante el combate."

-- Buff print out
L["MESSAGE_BUFFED"] = "¡%s te ha beneficiado con %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Gracias por %s"
L["MESSAGE_SELECT_PLAYER"] = "Primero selecciona a un jugador como objetivo."
L["MESSAGE_CANT_THANK_SELF"] = "¡No puedes agradecerte a ti mismo!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Hechizo desconocido"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensaje de bienvenida"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Muestra un mensaje que solo tú puedes ver al iniciar sesión."
L["OPTIONS_DESCRIPTION"] =
	"Agradece automáticamente con un susurro o una emoción a cada jugador que te dé un beneficio, y agradece a mano a quien quieras con un clic en tus macros de agradecimiento. Buenos modales, en automático."
L["OPTIONS_FEATURES_HEADER"] = "Funciones"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Activa o desactiva cada función aquí o en su propio panel."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre la interfaz de opciones de este accesorio."
L["SAMPLE_EXAMPLE"] = "Ejemplo: %s"

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "¿Buscas otras funciones?"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"Algunas funciones se han trasladado a nuestro nuevo accesorio, Good to Go. Encuéntralo en CurseForge o Wago."

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
	"• Pulsa Star en GitHub: abre el enlace de GitHub de abajo, inicia sesión y haz clic en Star, arriba a la derecha. Las estrellas ayudan al proyecto a acceder a más herramientas de desarrollo gratuitas."
L["OPTIONS_LEVEL_UP_THANKS"] = "¡Gracias por elegir Thanks for the Buff (TFTB)!"

L["OPTIONS_FEEDBACK"] = "Comentarios y soporte"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "Enlaces de comentarios y soporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "Para copiar un enlace, haz clic en su casilla y luego pulsa Ctrl+A y Ctrl+C."
L["OPTIONS_VERSION"] = "Versión %s"

--------------------------------------------------------------------------------
-- Options: Stranger Buffs
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Beneficios de desconocidos"
L["STRANGERS_ENABLE"] = "Habilitar agradecimientos por beneficios de desconocidos"
L["STRANGERS_ENABLE_DESCRIPTION"] = "Activa los agradecimientos por beneficios de jugadores de fuera de tu grupo."
L["STRANGERS_DESCRIPTION"] = "Agradece a los jugadores de fuera de tu grupo cuando te benefician en el mundo abierto."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "Reutilización de elogios"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Establece el tiempo de espera entre una ronda de elogios y la siguiente, sin importar quién te haya dado el beneficio. Ponlo a cero para elogiar todos los beneficios."
L["STRANGERS_SOURCE_COOLDOWN"] = "Reutilización de elogios al mismo jugador"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Establece el tiempo de espera entre elogios dirigidos al mismo jugador. Ponlo a cero para elogiar todos los beneficios."
L["STRANGERS_MIN_DURATION"] = "Duración mínima del beneficio"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Ignora los beneficios que duran menos que este valor. Ponlo a cero para reaccionar a todos los beneficios."

--------------------------------------------------------------------------------
-- Options: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers the Stranger Buffs panel is built from: what the
    other player sees, then what only you get. Key prefixes match the header
    the control appears under.
]]
L["PRAISE_HEADER"] = "Susurros de agradecimiento y emociones"
L["NOTIFICATIONS_HEADER"] = "Notificaciones"
L["PRAISE_DESCRIPTION"] = "Lo que ve el otro jugador: un susurro de agradecimiento, una emoción o ambos."
L["NOTIFICATIONS_DESCRIPTION"] = "Lo que solo recibes tú: un aviso de texto, un sonido o ambos."

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "Seleccionar emociones"

L["PRAISE_WHISPER_ENABLE"] = "Habilitar susurros de agradecimiento"
L["PRAISE_WHISPER_DESCRIPTION"] = "Susurra un agradecimiento al jugador que te ha dado el beneficio."
L["PRAISE_EMOTES_ENABLE"] = "Habilitar emociones"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Muestra tu agradecimiento con una emoción. Las emociones se retienen mientras estás en combate."
L["PRAISE_DELAY_ENABLE"] = "Habilitar retraso del elogio"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Espera un momento antes del susurro y la emoción, para que tu agradecimiento no llegue en el mismo instante que el beneficio. Las notificaciones no se ven afectadas."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Establece cuánto se espera antes de enviar el susurro y la emoción."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Habilitar avisos de texto"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Muestra un mensaje que solo tú puedes ver cuando recibes un beneficio."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Habilitar efectos de sonido"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Reproduce un sonido cuando recibes un beneficio. Solo tú lo oyes."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Reproduce el sonido para que puedas oírlo antes de activarlo."

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
L["BUTTON_ICON"] = "Icono"
L["BUTTON_ICON_DESCRIPTION"] =
	"Establece el icono que muestra la macro de este botón en tu lista de macros y en tus barras de acción."
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
	"Establece lo que este botón susurra a tu objetivo. Déjalo vacío para no enviar ningún susurro."

-- Each button's whisper box
L["WHISPER_MESSAGE"] = "Mensaje de susurro"
L["WHISPER_MESSAGE_RESET"] = "Restablecer"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Restablece el mensaje de susurro al texto predeterminado."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "¡Gracias, eres lo máximo! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "Animas a <Target>."
L["EMOTE_DRINK_DESCRIPTION"] = "Levantas una copa por <Target>."
L["EMOTE_FLEX_DESCRIPTION"] = "Haces alarde de tus músculos ante <Target>."
L["EMOTE_GRIN_DESCRIPTION"] = "Le sonríes con malicia a <Target>."
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "Chocas los cinco con <Target>."
L["EMOTE_PRAISE_DESCRIPTION"] = "Alabas a <Target>."
L["EMOTE_SALUTE_DESCRIPTION"] = "Saludas a <Target> con respeto."
L["EMOTE_SMILE_DESCRIPTION"] = "Le sonríes a <Target>."
L["EMOTE_THANK_DESCRIPTION"] = "Le das las gracias a <Target>."
L["EMOTE_WHOA_DESCRIPTION"] = "Exclamas '¡Hala!' a <Target>."
L["EMOTE_WINK_DESCRIPTION"] = "Le guiñas un ojo a <Target>."
L["EMOTE_YES_DESCRIPTION"] = "Asientes a <Target>."
