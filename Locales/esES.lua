local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "esES")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff (TFTB)"
L["ADDON_SHORT"] = "TFTB"

--------------------------------------------------------------------------------
-- Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"Versión %s. La configuración (incluida la opción para desactivar este mensaje) está en Opciones > Accesorios > Thanks for the Buff (TFTB). ¿Te gusta este accesorio? Cuéntaselo a un amigo, márcalo como favorito en CurseForge o pulsa Star en GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por seguridad, la interfaz de opciones no se puede abrir durante el combate."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "¡%s te ha beneficiado con %s!"
L["MESSAGE_GAVE_YOU"] = "¡%s te ha dado %s!"
L["MESSAGE_GAVE_GROUP"] = "¡%s le ha dado %s a tu grupo!"
L["MESSAGE_USED_ITEM"] = "¡%s ha usado %s en ti!"
L["MESSAGE_USED_SPELL"] = "¡%s ha lanzado %s sobre ti!"
L["MESSAGE_SET_OUT"] = "¡%s ha colocado %s!"
L["MESSAGE_OPENED"] = "¡%s ha abierto %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Gracias por %s"
L["MESSAGE_SELECT_PLAYER"] = "Primero selecciona a un jugador como objetivo."
L["MESSAGE_CANT_THANK_SELF"] = "¡No puedes agradecerte a ti mismo!"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "¡%s ha usado %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "¡%s ha usado %s sobre %s!"

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
	"Agradece automáticamente con un susurro o una emoción a los jugadores que te dan beneficios y anuncia los beneficios que lanzas, como Infusión de poder, Estimular y Piedra de alma. Recibe también avisos de festines, portales, invocaciones, pozos de almas y reutilizaciones de tu clase. Buenos modales, en automático."
L["OPTIONS_FEATURES_HEADER"] = "Funciones"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Activa o desactiva cada función aquí o en su propio panel."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre la interfaz de opciones de este accesorio."
L["OPTIONS_EXAMPLE"] = "Ejemplo: %s"

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
	"Establece el tiempo de espera entre una ronda de elogios y la siguiente, sin importar quién te haya dado el beneficio. Ponlo a cero para elogiar todos los beneficios."
L["STRANGERS_SOURCE_COOLDOWN"] = "Reutilización de elogios al mismo jugador"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Establece el tiempo de espera entre elogios dirigidos al mismo jugador. Ponlo a cero para elogiar todos los beneficios."
L["STRANGERS_MIN_DURATION"] = "Duración mínima del beneficio"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Ignora los beneficios que duran menos que este valor. Ponlo a cero para reaccionar a todos los beneficios."

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
	"Reacciona cuando alguien pone ayuda a disposición de tu grupo: festines, pozos de almas, portales y robots de reparación."

-- Send Good News
L["TAB_GOOD_NEWS"] = "Enviar buenas noticias"
L["GOOD_NEWS_DESCRIPTION"] = "Informa a los jugadores que beneficias de lo que les has lanzado y de cuánto dura."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Habilitar buenas noticias"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Susurra al jugador al que has dado el beneficio para decirle qué ha recibido y durante cuánto tiempo."
L["GOOD_NEWS_SCOPE"] = "Destinatarios"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Cualquiera al que beneficies"
L["GOOD_NEWS_SCOPE_GROUP"] = "Solo miembros del grupo"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Establece quién recibe un susurro de buenas noticias: cualquiera al que beneficies o solo los miembros de tu grupo."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Mensaje de buenas noticias"
L["GOOD_NEWS_MESSAGES_DESCRIPTION"] = "El susurro que reciben los jugadores a los que beneficias."
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
	"Muestra un mensaje que solo tú puedes ver cuando se usa una habilidad con reutilización de tu clase."
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
-- Options: Buff Duty
--------------------------------------------------------------------------------

L["TAB_BUFF_WINDOW"] = "Turno de beneficios"
L["BUFF_WINDOW_DESCRIPTION"] = "Muestra a quién le faltan tus beneficios. Haz clic en un icono para lanzarlo."
L["BUFF_WINDOW_ENABLE"] = "Habilitar turno de beneficios"
L["BUFF_WINDOW_ENABLE_DESCRIPTION"] =
	"Activa el turno de beneficios, la ventana de miembros del grupo a los que les falta un beneficio que puedes dar."
L["BUFF_WINDOW_NO_BUFFS"] =
	"Tu clase no tiene beneficios en esta lista, así que la ventana nunca aparece con este personaje."
L["BUFF_WINDOW_HEADER"] = "Ventana"
L["BUFF_WINDOW_WINDOW_DESCRIPTION"] = "Mantén la ventana donde la dejaste, o apártala durante el combate."
L["BUFF_WINDOW_LOCK"] = "Bloquear ventana"
L["BUFF_WINDOW_LOCK_DESCRIPTION"] = "Impide que la ventana se mueva. Desbloqueada, arrástrala desde el fondo."
L["BUFF_WINDOW_HIDE_IN_COMBAT"] = "Ocultar en combate"
L["BUFF_WINDOW_HIDE_IN_COMBAT_DESCRIPTION"] =
	"Oculta la ventana durante el combate. La lista no se puede actualizar en combate, así que si dejas la ventana visible, conserva su último estado hasta que termine el combate."
L["BUFF_WINDOW_SHOW_HEADER"] = "Mostrar en la ventana"
L["BUFF_WINDOW_SHOW_DESCRIPTION"] =
	"Añade a la ventana tus propios beneficios, los desconocidos que te han beneficiado y tu objetivo."
L["BUFF_WINDOW_FAVOR_ENABLE"] = "Devolver el favor"
L["BUFF_WINDOW_FAVOR_ENABLE_DESCRIPTION"] =
	"Muestra a los desconocidos que te han beneficiado hace poco, con los beneficios que puedes devolverles. Haz clic derecho en un icono para quitar a alguien de la lista."
L["BUFF_WINDOW_FAVOR_SECONDS_DESCRIPTION"] =
	"Establece cuánto tiempo permanece un desconocido en la lista tras su último beneficio."
L["BUFF_WINDOW_TARGET_ENABLE"] = "Tu objetivo"
L["BUFF_WINDOW_TARGET_ENABLE_DESCRIPTION"] =
	"Muestra a tu objetivo cuando es un jugador de fuera de tu grupo al que le falta un beneficio que puedes dar."
L["BUFF_WINDOW_REFRESH"] = "Renovar con menos de"
L["BUFF_WINDOW_REFRESH_DESCRIPTION"] =
	"Establece con cuánto tiempo restante un beneficio pasa a contar como ausente, para que puedas renovarlo antes de que expire. Un beneficio que no dura más que esto solo cuenta cuando ya ha desaparecido."
L["BUFF_WINDOW_PETS_AS_TANKS"] = "Considerar mascotas como tanques"
L["BUFF_WINDOW_PETS_AS_TANKS_DESCRIPTION"] =
	"Ofrece a las mascotas los beneficios que has asignado a Tanques, como Espinas, además de los de Todos."
L["BUFF_WINDOW_PETS_AS_TANKS_WHEN_DESCRIPTION"] = "Establece cuándo las mascotas cuentan como tanques."
L["BUFF_WINDOW_PETS_AS_TANKS_SOLO"] = "Cuando no estás en un grupo"
L["BUFF_WINDOW_PETS_AS_TANKS_ALWAYS"] = "Siempre"
-- Who each buff is offered to: one dropdown per buff, these four choices.
L["BUFF_WINDOW_AUDIENCE_OFF"] = "Desactivado"
L["BUFF_WINDOW_AUDIENCE_TANK"] = "Tanques"
L["BUFF_WINDOW_AUDIENCE_HEALER"] = "Sanadores"
L["BUFF_WINDOW_AUDIENCE_ALL"] = "Todos"
-- The dropdown's tooltip when the client has no description for the spell yet.
L["BUFF_WINDOW_AUDIENCE_DESCRIPTION"] = "Establece a quién se le ofrece %s."
L["BUFF_WINDOW_BUFFS_DESCRIPTION"] =
	"Elige a quién se ofrece cada beneficio. Tanques y Sanadores se asignan por rol de grupo, o por clase si no hay ninguno asignado."

L["BUFF_WINDOW_SELF_DESCRIPTION"] = "Tus propios beneficios, fijados en la parte superior de la ventana."
--[[
    Muted note after a class name on the Self-Buffs panel, for a family of self
    buffs only one of which can be up at a time. Keyed by the family.
]]
L["BUFF_WINDOW_SELF_NOTE_ASPECT"] = "cualquier aspecto cuenta"
L["BUFF_WINDOW_SELF_NOTE_MAGE_ARMOR"] = "cualquier armadura cuenta"
L["BUFF_WINDOW_SELF_NOTE_PALADIN_AURA"] = "cualquier aura cuenta"
L["BUFF_WINDOW_SELF_NOTE_SHAMAN_SHIELD"] = "cualquier escudo cuenta"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_ARMOR"] = "cualquier armadura cuenta"
L["BUFF_WINDOW_SELF_REFRESH_OFF"] = "Desactivado"
L["BUFF_WINDOW_SELF_REFRESH_MISSING"] = "Si falta"
-- %s is a duration from the client, like "5 Minutes".
L["BUFF_WINDOW_SELF_REFRESH_UNDER"] = "Menos de %s"
L["BUFF_WINDOW_SELF_REFRESH_DESCRIPTION"] =
	"Establece cuándo aparece %s: nunca, cuando ya no está activo o cuando le queda menos de este tiempo."
L["BUFF_WINDOW_SELF_ENABLE"] = "Tus beneficios propios"
L["BUFF_WINDOW_SELF_ENABLE_DESCRIPTION"] =
	"Muestra en la parte superior de la ventana los beneficios que solo puedes lanzarte a ti mismo, como una armadura o Fuego interno, cuando faltan o están por agotarse. Elige cuáles en Beneficios propios."

-- The window itself
L["BUFF_WINDOW_SELF_HEADER"] = "Beneficios propios"
L["BUFF_WINDOW_FAVOR_HEADER"] = "Devolver el favor"
L["BUFF_WINDOW_TARGET_HEADER"] = "Objetivo"
L["BUFF_WINDOW_TOOLTIP_CAST"] = "Haz clic para lanzarlo sobre %s."
L["BUFF_WINDOW_TOOLTIP_GROUP"] = "Haz clic para lanzarlo sobre %s y su grupo."
L["BUFF_WINDOW_TOOLTIP_FAVOR"] = "Haz clic para seleccionar a %s como objetivo y lanzarlo."
L["BUFF_WINDOW_TOOLTIP_DISMISS"] = "Haz clic derecho para quitar a %s de la lista."

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
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Habilitar macro "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "Crea una macro llamada %s y la elimina al desactivar esta opción."
L["BUTTON_WHISPER_DESCRIPTION"] =
	"Establece lo que este botón susurra a tu objetivo. Déjalo vacío para no enviar ningún susurro."

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
