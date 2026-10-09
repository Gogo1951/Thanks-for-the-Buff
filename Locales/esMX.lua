local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "esMX")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff (TFTB)"
L["ADDON_SHORT"] = "TFTB"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"Versión %s. La configuración (incluida la opción para desactivar este mensaje) se encuentra en Opciones > Accesorios > Thanks for the Buff (TFTB). ¿Te gusta el accesorio? ¡Cuéntaselo a un amigo! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por seguridad, la interfaz de opciones no se puede abrir durante el combate."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "¡%s te benefició con %s!"
L["MESSAGE_GAVE_YOU"] = "¡%s te dio %s!"
L["MESSAGE_GAVE_GROUP"] = "¡%s le dio %s a tu grupo!"
L["MESSAGE_USED_ITEM"] = "¡%s usó %s en ti!"
L["MESSAGE_USED_SPELL"] = "¡%s lanzó %s sobre ti!"
L["MESSAGE_SET_OUT"] = "¡%s colocó %s!"
L["MESSAGE_OPENED"] = "¡%s abrió %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Gracias por %s"
L["MESSAGE_SELECT_PLAYER"] = "Selecciona a un jugador para agradecerle."
L["MESSAGE_CANT_THANK_SELF"] = "¡No puedes agradecerte a ti mismo!"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "¡%s usó %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "¡%s usó %s sobre %s!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Hechizo desconocido"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensaje de bienvenida"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Muestra un mensaje en el chat al iniciar sesión."
L["OPTIONS_DESCRIPTION"] =
	"Agradece automáticamente con un susurro o una emoción a los jugadores que te dan beneficios y anuncia los beneficios que lanzas, como Infusión de poder, Estimular y Piedra de alma. Recibe también avisos de festines, portales, invocaciones, pozos de almas y reutilizaciones de tu clase. Buenos modales, en automático."
L["OPTIONS_SUPPORT"] = "Comentarios y soporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_VERSION"] = "Versión %s"
L["OPTIONS_FEATURES_HEADER"] = "Funciones"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre la interfaz de opciones de este accesorio."

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Stranger Buffs
L["TAB_STRANGERS"] = "Beneficios de desconocidos"
L["STRANGERS_ENABLE"] = "Habilitar agradecimientos por beneficios de desconocidos"
L["STRANGERS_ENABLE_DESCRIPTION"] = "Activa los agradecimientos por beneficios de jugadores de fuera de tu grupo."
L["STRANGERS_DESCRIPTION"] = "Agradece a los jugadores de fuera de tu grupo cuando te benefician en el mundo abierto."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "Reutilización de elogios"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Establece el tiempo de espera entre una ronda de elogios y la siguiente, sin importar quién te haya dado el beneficio. Ponlo en cero para elogiar todos los beneficios."
L["STRANGERS_SOURCE_COOLDOWN"] = "Reutilización de elogios al mismo jugador"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Establece el tiempo de espera entre elogios dirigidos al mismo jugador. Ponlo en cero para elogiar todos los beneficios."
L["STRANGERS_MIN_DURATION"] = "Duración mínima del beneficio"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Ignora los beneficios que duran menos que este valor. Ponlo en cero para reaccionar a todos los beneficios."

-- Teammate Buffs
L["TAB_TEAMMATES"] = "Beneficios de compañeros"
L["TEAMMATES_ENABLE"] = "Habilitar agradecimientos por beneficios de compañeros"
L["TEAMMATES_ENABLE_DESCRIPTION"] =
	"Activa los agradecimientos por los beneficios y habilidades con reutilización que los miembros de tu grupo o banda lanzan sobre ti."
L["TEAMMATES_DESCRIPTION"] =
	"Agradece a los miembros de tu grupo o banda los beneficios y habilidades con reutilización que lanzan sobre ti."

-- Service Alerts
L["TAB_SERVICES"] = "Avisos de servicios"
L["SERVICES_ENABLE"] = "Habilitar avisos de servicios"
L["SERVICES_ENABLE_DESCRIPTION"] =
	"Activa los avisos de festines, pozos de almas, portales y otras ayudas que se colocan para tu grupo."
L["SERVICES_DESCRIPTION"] =
	"Reacciona a la ayuda que tu grupo ofrece a toda la banda: festines, pozos de almas, portales y robots de reparación."

-- Send Good News
L["TAB_GOOD_NEWS"] = "Enviar buenas noticias"
L["GOOD_NEWS_DESCRIPTION"] = "Informa a los jugadores que beneficias de lo que les lanzaste y de cuánto dura."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Habilitar buenas noticias"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Le susurra al jugador al que le diste el beneficio para decirle qué recibió y por cuánto tiempo."
L["GOOD_NEWS_SCOPE"] = "Destinatarios"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Cualquiera al que beneficies"
L["GOOD_NEWS_SCOPE_GROUP"] = "Solo miembros del grupo"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Establece quién recibe un susurro de buenas noticias: cualquiera al que beneficies o solo tu grupo o banda."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Mensaje de buenas noticias"
--[[
    Two halves so the number stays authoritative: LIMIT's %d is a real placeholder
    and gets formatted, TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_LIMIT"] = "Longitud máxima: %d."
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a se convierte en el enlace de la habilidad."
--[[
    Appended to the ability link inside %a when the buff has a readable duration.
    A whole clause rather than a bare number so it can be reworded per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "durante %s"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Presión de grupo"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Recibe una notificación cuando otros jugadores de tu clase usen sus habilidades con reutilización, para que cedas a la presión de grupo."
L["PEER_PRESSURE_ENABLE"] = "Habilitar presión de grupo"
L["PEER_PRESSURE_ENABLE_DESCRIPTION"] =
	"Activa los avisos cuando otro jugador de tu clase usa una habilidad con reutilización rastreada."
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Muestra un mensaje en tu propio chat cuando se usa una habilidad con reutilización de tu clase. Solo tú lo ves."
L["PEER_PRESSURE_OWN_CASTS"] = "Activar con tus propios lanzamientos"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"También se activa cuando usas tus propias habilidades con reutilización, no solo cuando lo hacen otros jugadores."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Reproduce un sonido cuando se usa una habilidad con reutilización de tu clase. Solo tú lo oyes."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Habilidades rastreadas"
L["TRACKED_GROUP_ITEMS"] = "Objetos"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Activa o desactiva el rastreo de %s."
L["TRACKED_ITEM_PENDING"] = "Objeto #%d"
L["TRACKED_SPELL_PENDING"] = "Hechizo #%d"

-- Shared by Send Good News and the Thank You Button
L["WHISPER_MESSAGE"] = "Mensaje de susurro"
L["WHISPER_MESSAGE_RESET"] = "Restablecer"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Restablece el mensaje de susurro al texto predeterminado."

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "Mensajes de elogio y emociones"
L["NOTIFICATIONS_HEADER"] = "Notificaciones"

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "Seleccionar emociones"

L["PRAISE_WHISPER_ENABLE"] = "Habilitar susurros de agradecimiento"
L["PRAISE_WHISPER_DESCRIPTION"] = "Le susurra un agradecimiento al jugador que te dio el beneficio."
L["PRAISE_EMOTES_ENABLE"] = "Habilitar emociones"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Muestra tu agradecimiento con una emoción. Las emociones se retienen mientras estás en combate."
L["PRAISE_DELAY_ENABLE"] = "Habilitar retraso del elogio"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Espera un momento antes del susurro y la emoción, para que tu agradecimiento no llegue en el mismo instante que el beneficio. Las notificaciones no se ven afectadas."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Establece cuánto se espera antes de enviar el susurro y la emoción."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Habilitar mensajes de chat"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Muestra un mensaje en tu propio chat cuando recibes un beneficio. Solo tú lo ves."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Habilitar efectos de sonido"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Reproduce un sonido cuando recibes un beneficio. Solo tú lo oyes."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Reproduce el sonido para que puedas oírlo antes de activarlo."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups that no single game record names
    (Data/{Game}/Tracked-Abilities-{Game}.lua). Single spells and items, and a
    group named after one of its own items, take their names from the client.
]]
L["GROUP_PORTALS"] = "Portales"
L["GROUP_RESISTANCE_CAULDRONS"] = "Calderos de resistencia"
L["GROUP_REPAIR_BOTS"] = "Robots de reparación"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Botón de agradecimiento"
L["BUTTON_DESCRIPTION"] =
	"Cortesía, automatizada. Cada botón le susurra a tu objetivo actual y también puede dedicarle una emoción: pedirle agua a un mago, dar las gracias por un portal, elogiar a un amigo en plena pelea por esa provocación rápida. Escribe el mensaje una vez y de ahí en adelante queda a una tecla de distancia."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Botón de agradecimiento %d"
L["BUTTON_EMOTE"] = "Emoción"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Establece la emoción que este botón realiza hacia tu objetivo, o Ninguna para no realizar ninguna."
L["BUTTON_EMOTE_NONE"] = "Ninguna"
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
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "¡Gracias, eres lo máximo! (="
--[[
    The star marker (left off on WoW Forever) and " // TFTB" sign-off are added
    by the builder, which also drops the closing punctuation; neither is part of
    the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "Tienes %a"

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "Animas a <Target>."
L["EMOTE_DRINK_DESCRIPTION"] = "Levantas una copa por <Target>."
L["EMOTE_FLEX_DESCRIPTION"] = "Presumes tus músculos ante <Target>."
L["EMOTE_GRIN_DESCRIPTION"] = "Le sonríes con malicia a <Target>."
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "Chocas esos cinco con <Target>."
L["EMOTE_PRAISE_DESCRIPTION"] = "Alabas a <Target>."
L["EMOTE_SALUTE_DESCRIPTION"] = "Saludas a <Target> con respeto."
L["EMOTE_SMILE_DESCRIPTION"] = "Le sonríes a <Target>."
L["EMOTE_THANK_DESCRIPTION"] = "Le das las gracias a <Target>."
L["EMOTE_WHOA_DESCRIPTION"] = "Exclamas '¡Guau!' a <Target>."
L["EMOTE_WINK_DESCRIPTION"] = "Le guiñas un ojo a <Target>."
L["EMOTE_YES_DESCRIPTION"] = "Asientes a <Target>."
