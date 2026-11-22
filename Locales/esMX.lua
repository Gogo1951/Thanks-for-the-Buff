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
L["SAMPLE_EXAMPLE"] = "Ejemplo"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensaje de bienvenida"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Muestra un mensaje que solo tú puedes ver al iniciar sesión."
L["OPTIONS_ENABLE_MINIMAP"] = "Habilitar botón del minimapa"
L["OPTIONS_ENABLE_MINIMAP_DESCRIPTION"] =
	"Muestra el botón de TFTB en tu minimapa. Al pasar el cursor por encima se abre un menú con todo lo que hace el botón."
L["OPTIONS_DESCRIPTION"] =
	"Agradece automáticamente con una emoción o un susurro a los jugadores que te den un beneficio, devuélveles el beneficio con una sola pulsación, cuéntales a los jugadores lo que acabas de lanzarles, saluda con la mano a tus amigos y compañeros de hermandad y da las gracias a quien tengas como objetivo con un clic."
L["OPTIONS_FEATURES_HEADER"] = "Funciones"
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
-- Shown on the Emotes List and Ignored Buffs pages while Give Thanks is off.
L["GIVE_THANKS_LIST_OFF"] = "La función %s está desactivada, así que esta lista no se usa. Activa %s para usarla."

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

-- Give Thanks Whisper
L["GIVE_THANKS_WHISPER_HEADER"] = "Susurro de agradecimiento"
L["GIVE_THANKS_WHISPER_ENABLE"] = "Habilitar susurro de agradecimiento"
L["PRAISE_WHISPER_DESCRIPTION"] = "Le susurra un agradecimiento al jugador que te dio el beneficio."
-- TRANSLATORS: keep {spell} and {name} exactly as written; they are the tokens players type into the whisper.
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"Establece lo que TFTB le susurra al jugador que te dio el beneficio. {spell} se reemplaza por el beneficio y {name} por su nombre. Déjalo vacío para no enviar ningún susurro."

-- Notifications
L["NOTIFICATIONS_HEADER"] = "Notificaciones"
L["NOTIFICATIONS_DESCRIPTION"] = "Lo que solo recibes tú: un aviso de texto, un sonido o ambos."
L["NOTIFICATIONS_PRINT_ENABLE"] = "Habilitar avisos de texto"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Muestra un mensaje que solo tú puedes ver cuando recibes un beneficio."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Habilitar efectos de sonido"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Reproduce un sonido cuando recibes un beneficio. Solo tú lo oyes."
L["OPTIONS_SOUND_PREVIEW_DESCRIPTION"] = "Reproduce este sonido ahora, esté o no activado el sonido."

--------------------------------------------------------------------------------
-- Options: Good News
--------------------------------------------------------------------------------

L["TAB_GOOD_NEWS"] = "Buenas noticias"
L["GOOD_NEWS_ENABLE"] = "Habilitar buenas noticias"
L["GOOD_NEWS_ENABLE_DESCRIPTION"] = "Activa un susurro que les dice a los jugadores lo que acabas de lanzarles."
L["GOOD_NEWS_DESCRIPTION"] =
	"Avísales a los jugadores lo que acabas de lanzarles y, en los beneficios cortos, cuánto dura, para que le saquen el máximo provecho."
L["GOOD_NEWS_SCOPE"] = "Quién lo recibe"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Establece quién recibe un susurro de Buenas noticias: cualquiera al que le lances una habilidad rastreada, o solo tu grupo o banda."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Cualquiera"
L["GOOD_NEWS_SCOPE_GROUP"] = "Solo miembros del grupo"
L["GOOD_NEWS_WHISPER_HEADER"] = "Susurro de buenas noticias"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Lo que recibe el jugador al que le lanzas algo. Solo envían uno las habilidades marcadas en Habilidades rastreadas."
-- TRANSLATORS: keep {spell} and {name} exactly as written; they are the tokens players type into the whisper.
L["GOOD_NEWS_MESSAGE_DESCRIPTION"] =
	"Establece lo que TFTB le susurra al jugador al que le lanzas algo. {spell} se reemplaza por lo que lanzaste, más su duración cuando es menor a un minuto, y {name} por su nombre. Déjalo vacío para no enviar ningún susurro."
-- TRANSLATORS: each %s is a token, {spell} then {name}, drawn in blue.
L["GOOD_NEWS_TOKENS"] = "Comodines: %s lo que lanzaste, %s quien lo recibió"

-- Tracked Abilities
L["TAB_GOOD_NEWS_ABILITIES"] = "Habilidades rastreadas"
L["GOOD_NEWS_ABILITIES_DESCRIPTION"] =
	"Buenas noticias envía un susurro sobre las habilidades marcadas aquí cuando las lanzas a otro jugador."
L["GOOD_NEWS_ABILITIES_OFF"] =
	"La función %s está desactivada, así que todavía no se susurra nada. Activa %s para enviarla."
-- The heading over the rows no class owns: scrolls, and abilities cast by a trinket's pet.
L["GOOD_NEWS_ITEMS"] = "Objetos"

--------------------------------------------------------------------------------
-- Options: Emotes List
--------------------------------------------------------------------------------

L["TAB_EMOTES_LIST"] = "Lista de emociones"
L["EMOTES_GRID_DESCRIPTION"] =
	"Marca las emociones entre las que puede elegir la función Agradecimientos cuando un jugador de fuera de tu grupo te da un beneficio; usa una al azar. Las emociones se retienen mientras estás en combate, lanzando un hechizo o pescando."

--[[
    The emote checklist, shared by this panel and Wave to Friends' Friends and
    Guilds tabs. Its group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS
    entry, upper-cased.
]]
L["EMOTE_GROUP_COUNT"] = "%s (%d de %d marcadas)"
L["EMOTE_GROUP_TEXT"] = "Texto"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "Solo muestra la línea de la emoción."
L["EMOTE_GROUP_GESTURE"] = "Gesto"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "Reproduce una animación corta."
L["EMOTE_GROUP_VOICE"] = "Voz"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "Reproduce una frase hablada."
L["EMOTE_GROUP_POSE"] = "Postura"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "Se mantiene hasta que te mueves."
L["EMOTES_RESET_DESCRIPTION"] = "Regresa la lista a las emociones de agradecimiento predeterminadas."
L["EMOTES_RESET_CONFIRM"] = "¿Restablecer la lista de emociones a los valores predeterminados?"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "Beneficios ignorados"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"Los beneficios de esta lista nunca reciben un agradecimiento, sin importar quién los lance. Sigues recibiendo tu aviso de texto y tu sonido."
L["IGNORED_BUFFS_ADD_RECENT"] = "Ignorar beneficio reciente"
L["IGNORED_BUFFS_ADD_RECENT_DESCRIPTION"] =
	"Agrega un beneficio que tienes en este momento, o uno que otro jugador te dio desde que iniciaste sesión."
-- The first %s is the buff's icon and name, the second the player who cast it.
L["IGNORED_BUFFS_RECENT_FROM"] = "%s, de %s"
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
L["BUTTON_PICKUP"] = "Tomar macro"
L["BUTTON_PICKUP_DESCRIPTION"] = "Pone la macro %s en tu cursor para que puedas soltarla en una barra de acción."
L["BUTTON_WHISPER_DESCRIPTION"] =
	"Establece lo que este botón le susurra a tu objetivo. {name} se sustituye por su nombre. Déjalo vacío para no enviar ningún susurro."
L["BUTTON_TOKENS"] = "Comodines: %s a quien das las gracias"

-- Return Buff
L["TAB_RETURN_BUFF"] = "Devolver beneficio"
L["RETURN_BUFF_DESCRIPTION"] =
	"Devuelve el favor. Cada vez que un jugador fuera de tu grupo te da un beneficio, la macro %s lo apunta, así que una pulsación le lanza tu beneficio de vuelta."
L["RETURN_BUFF_ENABLE_DESCRIPTION"] =
	"Crea una macro llamada %s que lanza tu beneficio al último jugador fuera de tu grupo que te lo dio, y la borra de nuevo al desactivar esto."
L["RETURN_BUFF_SPELL"] = "Beneficio a lanzar"
L["RETURN_BUFF_SPELL_DESCRIPTION"] = "Establece cuál de tus beneficios lanza la macro."
L["RETURN_BUFF_EXAMPLE"] = "%s fue el último en darte un beneficio, así que la macro le lanza %s."
L["RETURN_BUFF_EXAMPLE_LEVEL"] = "%s (nivel %d) fue el último en darte un beneficio, así que la macro le lanza %s."
L["RETURN_BUFF_NONE"] = "Este personaje aún no conoce ningún beneficio que pueda lanzar a otros jugadores."
L["RETURN_BUFF_MACROS_FULL"] = "Tus macros generales de la cuenta están llenas (%d). Borra una para dejar sitio a %s."
L["RETURN_BUFF_HELP"] =
	"Hasta que alguien te dé un beneficio, la macro lanza sobre tu objetivo. El juego no deja que los addons cambien macros en combate, así que un beneficio recibido en plena pelea mueve la macro al terminar el combate."
L["RETURN_BUFF_RANK_HELP"] =
	"Lanza el rango más alto que admite el nivel de ese jugador. Si TFTB no pudo ver su nivel, lanza tu rango más alto."

--------------------------------------------------------------------------------
-- Options: Wave to Friends
--------------------------------------------------------------------------------

L["TAB_WAVE_TO_FRIENDS"] = "Saludo a amigos"
L["WAVE_ENABLE"] = "Habilitar saludo a amigos"
L["WAVE_ENABLE_DESCRIPTION"] =
	"Activa una emoción para amigos y compañeros de hermandad cuando pasas el cursor sobre ellos."
L["WAVE_DESCRIPTION"] =
	"Saluda con una emoción a tus amigos y compañeros de hermandad cuando pasas el cursor sobre ellos por el mundo."
L["WAVE_RULES"] = "Nunca a tu grupo o banda, y nunca mientras estás en combate, lanzando un hechizo o pescando."
L["WAVE_RESTING_ENABLE"] = "Solo en la ciudad"
L["WAVE_RESTING_ENABLE_DESCRIPTION"] = "Saluda solo mientras descansas, en una ciudad o una posada."
L["WAVE_COOLDOWN"] = "Reutilización para el mismo jugador"
L["WAVE_COOLDOWN_DESCRIPTION"] =
	"Establece cuánto tiempo pasa antes de que se pueda volver a saludar al mismo jugador."
L["WAVE_COOLDOWN_ONCE_PER_SESSION"] = "Una vez por sesión"
-- %s is the default emotes' slash commands, as the client names them.
L["WAVE_EMOTES_RESET_DEFAULTS_DESCRIPTION"] = "Regresa la lista a solo %s."

-- Custom List
L["WAVE_TAB_CUSTOM"] = "Lista personalizada"
L["WAVE_CUSTOM_DESCRIPTION"] =
	"Jugadores que siempre reciben su propia emoción, incluso por encima de Amigos y Hermandades. Elige Ninguna para no dedicarle nunca una emoción a alguien."
-- One of these two follows WAVE_CUSTOM_DESCRIPTION: realm clients, then WoW Forever, which has no realms.
L["WAVE_CUSTOM_NAMES_REALM"] =
	"Nombre-Reino solo coincide con ese reino; un nombre sin reino coincide con cualquier reino."
L["WAVE_CUSTOM_NAMES_FOREVER"] =
	"Un nombre completo coincide con un solo personaje; solo el nombre de pila coincide con todos los que lo llevan."
L["WAVE_CUSTOM_ENABLE"] = "Habilitar lista personalizada"
L["WAVE_CUSTOM_ENABLE_DESCRIPTION"] = "Usa los nombres de abajo antes que Amigos y Hermandades."
L["WAVE_CUSTOM_OFF_WARNING"] = "La lista personalizada está desactivada, así que nadie de abajo recibe su emoción."
L["WAVE_CUSTOM_ADD"] = "Agregar jugador"
L["WAVE_CUSTOM_ADD_DESCRIPTION"] =
	"Escribe un nombre o Nombre-Reino y luego presiona Enter. Separa varios nombres con comas."
L["WAVE_CUSTOM_ADD_DESCRIPTION_FOREVER"] =
	"Escribe un nombre completo o un nombre de pila y luego presiona Enter. Separa varios nombres con comas."
L["WAVE_CUSTOM_EMPTY"] = "Todavía no hay jugadores. Agrega uno arriba."
L["WAVE_CUSTOM_EMOTE_DESCRIPTION"] =
	"Establece la emoción para este jugador, o Ninguna para no dedicarle nunca una emoción."
L["WAVE_CUSTOM_REMOVE"] = "Quita a este jugador de la lista."

-- Friends
L["WAVE_TAB_FRIENDS"] = "Amigos"
L["WAVE_FRIENDS_ENABLE"] = "Saludar a amigos"
L["WAVE_FRIENDS_ENABLE_DESCRIPTION"] = "Saluda a los personajes de tu lista de amigos."
L["WAVE_BNET_ENABLE"] = "Incluir amigos de Battle.net"
L["WAVE_BNET_ENABLE_DESCRIPTION"] = "Saluda también a los personajes con los que juegan tus amigos de Battle.net."
L["WAVE_FRIENDS_EMOTES_DESCRIPTION"] = "Marca las emociones entre las que elegir para los amigos; se usa una al azar."

-- Guilds
L["WAVE_TAB_GUILDS"] = "Hermandades"
L["WAVE_MY_GUILD_ENABLE"] = "Saludar a mi hermandad"
L["WAVE_MY_GUILD_ENABLE_DESCRIPTION"] = "Saluda a los miembros de la hermandad a la que perteneces."
L["WAVE_GUILD_ADD"] = "Agregar hermandad"
L["WAVE_GUILD_ADD_DESCRIPTION"] =
	"Escribe el nombre de una hermandad y luego presiona Enter. Separa varias hermandades con comas. No importan las mayúsculas."
L["WAVE_GUILDS_EMPTY"] = "Todavía no hay otras hermandades. Agrega una arriba."
L["WAVE_GUILD_REMOVE"] = "Quita esta hermandad de la lista."
L["WAVE_GUILDS_EMOTES_DESCRIPTION"] =
	"Marca las emociones entre las que elegir para los miembros de la hermandad; se usa una al azar."

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption beside every whisper box, on Give Thanks, Good News and each Thank You Button; Give Thanks has several boxes, so its caption is plural.
L["WHISPER_MESSAGE"] = "Mensaje de susurro"
L["WHISPER_MESSAGES"] = "Mensajes de susurro"
L["WHISPER_RANDOM"] = "Se elige uno al azar; una casilla vacía se omite."
-- Every Reset row's button, a whisper box's included.
L["OPTIONS_RESET"] = "Restablecer"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Restablece el mensaje de susurro al texto predeterminado."

-- The whisper composer around every editable whisper's box, on Give Thanks and Good News.
L["SEND_MESSAGES_IN"] = "Enviar mensajes en"
L["SEND_MESSAGES_IN_DESCRIPTION"] =
	"Establece el idioma en el que TFTB les escribe a otros jugadores. Si eliges otro idioma, se usa su texto predeterminado, a menos que hayas escrito el tuyo."
L["WHISPER_SIGN_OFF_DESCRIPTION"] =
	"Se agrega a cada mensaje que envía TFTB, para que otros jugadores sepan que viene de un accesorio."
-- TRANSLATORS: each %s is a token, {spell} then {name}, drawn in blue.
L["WHISPER_TOKENS"] = "Comodines: %s el beneficio, %s quien lo lanzó"
L["WHISPER_TOO_LONG"] = "Demasiado largo, así que se enviará el texto predeterminado en su lugar."
L["WHISPER_TEST"] = "Enviarme una prueba"
L["WHISPER_TEST_DESCRIPTION"] = "Te susurra el ejemplo para que lo veas tal como lo verán otros jugadores."

--------------------------------------------------------------------------------
-- Mini-map Menu
--------------------------------------------------------------------------------

-- The words every feature's state and every switch show.
L["MENU_ON"] = "Activado"
L["MENU_OFF"] = "Desactivado"
L["MENU_TOGGLE"] = "Alternar"

-- %d is how many more buffs the list leaves out.
L["MENU_MORE"] = "%d más"

-- The button click that does what a menu row does, gray at the row's right.
L["MENU_CLICK_RIGHT"] = "Clic derecho"
L["MENU_CLICK_MIDDLE"] = "Clic central"
L["MENU_CLICK_SHIFT_MIDDLE"] = "Mayús + Clic central"
-- The menu's Options row.
L["MENU_OPTIONS"] = "Opciones de TFTB"

-- Give Thanks: the switches, named without their Enable.
L["MENU_PRAISE_DELAY"] = "Retraso del elogio"
L["MENU_WHISPER"] = "Susurro de agradecimiento"
L["MENU_PRINT"] = "Avisos de texto"
L["MENU_SOUND"] = "Efectos de sonido"

-- %d is how many emotes the Emotes List has ticked.
L["MENU_CHECKED"] = "%d marcados"
L["MENU_CHOOSE_EMOTES"] = "Elegir emociones"
L["MENU_RECENT"] = "Beneficios recientes"
L["MENU_RECENT_NOTE"] = "Haz clic en un beneficio para ignorarlo."
L["MENU_RECENT_EMPTY"] = "Aún no hay beneficios de otros jugadores."
L["MENU_IGNORED_NOTE"] = "Haz clic en un beneficio para dejar de ignorarlo."
L["MENU_IGNORED_EMPTY"] = "Aún no hay beneficios ignorados."

-- %s is the buff's link.
L["MENU_IGNORED_PRINT"] = "%s agregado a Beneficios ignorados."
L["MENU_UNIGNORED_PRINT"] = "%s quitado de Beneficios ignorados."

-- Wave to Friends.
L["MENU_WHO_WAVES"] = "A quién saludar"
L["MENU_EDIT_CUSTOM"] = "Editar lista personalizada"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

-- The Thank You Button whisper's default, in the client's own language; Give Thanks' and Good News' defaults live in Data/Message-Languages.lua.
L["DEFAULT_WHISPER"] = "¡Gracias, eres lo máximo! (="
