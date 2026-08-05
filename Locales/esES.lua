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
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"Versión %s. La configuración (incluida la opción para desactivar este mensaje) se encuentra en Opciones > Accesorios > Thanks for the Buff (TFTB). ¿Te gusta el accesorio? ¡Cuéntaselo a un amigo! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por seguridad, la interfaz de opciones no se puede abrir durante el combate."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "¡%s te ha beneficiado con %s!"
L["MESSAGE_GAVE_YOU"] = "¡%s te ha dado %s!"
L["MESSAGE_GAVE_GROUP"] = "¡%s le dio a tu grupo %s!"
L["MESSAGE_USED_ITEM"] = "¡%s usó %s %s en ti!"
L["MESSAGE_USED_SPELL"] = "¡%s usó %s en ti!"
L["MESSAGE_SET_OUT"] = "¡%s puso %s!"
L["MESSAGE_OPENED"] = "¡%s abrió %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "¡Gracias por %s!"
L["MESSAGE_GOOD_NEWS_DURATION"] = "¡Buenas noticias! ¡Tienes %s durante %s!"
L["MESSAGE_GOOD_NEWS"] = "¡Buenas noticias! ¡Tienes %s!"
L["MESSAGE_PEER_PRESSURE"] = "¡%s usó %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "¡%s usó %s en %s!"
L["MESSAGE_SELECT_PLAYER"] = "Selecciona a un jugador para agradecerle."
L["MESSAGE_CANT_THANK_SELF"] = "¡No puedes agradecerte a ti mismo!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MESSAGE_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "su"
L["PRONOUN_HER"] = "su"
L["PRONOUN_THEIR"] = "su"
L["UNKNOWN_SPELL"] = "Hechizo desconocido"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensaje de bienvenida"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Imprime un mensaje en el chat cuando inicias sesión."
L["OPTIONS_DESCRIPTION"] =
	"Agradece automáticamente con emotes, susurros y avisos de chat a los jugadores que te benefician, ya sea un desconocido en el mundo abierto o el tiempo de reutilización de un compañero como Power Infusion o Innervate. Recibe también un aviso de festines, portales y cooldowns de tu clase."
L["OPTIONS_SUPPORT"] = "Comentarios y soporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre la interfaz de opciones de este accesorio."
L["OPTIONS_COMMAND_THANKYOU"] = "/thankyou"
L["OPTIONS_COMMAND_THANKYOU_DESCRIPTION"] = "Hace un emote y susurra a tu objetivo actual."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Beneficios de Desconocidos"
L["STRANGERS_DESCRIPTION"] = "Un beneficio sobre ti de un jugador fuera de tu grupo (mundo abierto)."
L["STRANGERS_OVERALL_COOLDOWN"] = "Tiempo de reutilización de elogios (Segundos)"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Con qué frecuencia máxima elogiar a alguien, venga de quien venga el beneficio.\n\nEstablécelo en 0 para desactivar este límite. Las notificaciones no se ven afectadas."
L["STRANGERS_SOURCE_COOLDOWN"] = "Tiempo de reutilización por jugador (Segundos)"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Con qué frecuencia máxima elogiar al mismo jugador.\n\nLas notificaciones no se ven afectadas."
L["STRANGERS_MIN_DURATION"] = "Duración mínima del beneficio (Segundos)"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Cuánto debe durar el beneficio para que merezca la pena reaccionar.\n\nFiltra sanaciones cortas en el tiempo como Renovar o Rejuvenecimiento. Las notificaciones también se ven afectadas; un beneficio por debajo de esto se ignora por completo, sin mensaje, sonido, susurro ni emote."

--------------------------------------------------------------------------------
-- Options: Combat Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Beneficios de Compañeros de Equipo"
L["TEAMMATES_DESCRIPTION"] = "Un beneficio o tiempo de reutilización de un miembro del grupo o banda lanzado sobre ti."

-- Group Services
L["TAB_SERVICES"] = "Servicios de Grupo"
L["SERVICES_DESCRIPTION"] =
	"Ayuda para toda la banda de un miembro del grupo o banda: festines, pozos de almas, portales, bots de reparación."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Buenas Noticias"
L["GOOD_NEWS_DESCRIPTION"] = "Informa a los jugadores que beneficias de lo que les has lanzado y cuánto dura."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Habilitar Buenas Noticias"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Susurra al jugador que beneficiaste para decirle qué recibió y por cuánto tiempo."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Cualquiera que beneficies"
L["GOOD_NEWS_SCOPE_GROUP"] = "Solo miembros del grupo"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Presión de Grupo"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Recibe una notificación cuando otros jugadores de tu clase usen sus tiempos de reutilización, para que cedas a la presión de grupo."
L["PEER_PRESSURE_ENABLE"] = "Habilitar Peer Pressure"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Imprime un mensaje en tu propio chat cuando se usa un tiempo de reutilización de tu clase. Solo tú lo ves."
L["PEER_PRESSURE_OWN_CASTS"] = "Activar con tus propios hechizos"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Activa la notificación también cuando usas tus propios tiempos de reutilización, no solo cuando lo hacen otros jugadores."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Reproduce un sonido cuando se usa un tiempo de reutilización de tu clase. Solo tú lo oyes."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Habilidades rastreadas"
L["COMBAT_GROUP_ITEMS"] = "Objetos"
L["COMBAT_TOGGLE_TRACKING"] = "Alternar rastreo para %s."
L["COMBAT_ITEM_PENDING"] = "Objeto #%d"
L["COMBAT_SPELL_PENDING"] = "Hechizo #%d"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

-- The two section headers every buff panel is built from: what the other player
-- sees, then what only you get. Peer Pressure sends nothing outward, so it
-- carries the Notifications header alone. Key prefixes match the header the
-- control appears under.
L["PRAISE_HEADER"] = "Mensajes de elogio y emotes"
L["NOTIFICATIONS_HEADER"] = "Notificaciones"

L["PRAISE_WHISPER_ENABLE"] = "Habilitar susurros de agradecimiento"
L["PRAISE_WHISPER_DESCRIPTION"] = "Susurra un agradecimiento al jugador que te dio el beneficio."
L["PRAISE_EMOTES_ENABLE"] = "Habilitar Emotes (Fuera de combate)"
L["PRAISE_EMOTES_DESCRIPTION"] = "Muestra tu aprecio con un emote. Los emotes se retienen mientras estás en combate."
L["PRAISE_EMOTES_SELECT"] = "Seleccionar Emotes"
L["PRAISE_DELAY_ENABLE"] = "Habilitar retraso de elogio"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Espera un momento antes del susurro y el emote, para que tu agradecimiento no llegue en el mismo instante que el beneficio.\n\nLas notificaciones no se ven afectadas."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Cuánto esperar antes de elogiar al jugador que te dio el beneficio."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Habilitar mensajes impresos"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Imprime un mensaje en tu propio chat cuando recibes un beneficio. Solo tú lo ves."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Habilitar efectos de sonido"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Reproduce un sonido cuando recibes un beneficio. Solo tú lo oyes."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

-- Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
-- spells and items take their names from the client and need no key here.
L["GROUP_PORTALS"] = "Portales"
L["GROUP_SOULSTONE"] = "Piedra de alma"
L["GROUP_RESISTANCE_CAULDRONS"] = "Calderos de resistencia"
L["GROUP_SCROLL_OF_SPIRIT"] = "Pergamino de espíritu"
L["GROUP_SCROLL_OF_STAMINA"] = "Pergamino de aguante"
L["GROUP_SCROLL_OF_STRENGTH"] = "Pergamino de fuerza"
L["GROUP_SCROLL_OF_PROTECTION"] = "Pergamino de protección"
L["GROUP_SCROLL_OF_INTELLECT"] = "Pergamino de intelecto"
L["GROUP_SCROLL_OF_AGILITY"] = "Pergamino de agilidad"
L["GROUP_REPAIR_BOTS"] = "Robots de reparación"
L["GROUP_JUMPER_CABLES"] = "Pinzas de arranque"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Botón de Agradecimiento"
L["BUTTON_DESCRIPTION"] = "Agradece a tu objetivo actual con un emote y un susurro."
L["BUTTON_CREATE_MACRO"] = "Crear Macro"
L["BUTTON_CREATE_MACRO_DESCRIPTION"] = "Crea automáticamente una macro llamada %s al iniciar sesión."
L["BUTTON_WHISPER"] = "Mensaje de Susurro"
L["BUTTON_RESET"] = "Restablecer"
L["BUTTON_RESET_DESCRIPTION"] = "Restablece el mensaje de susurro al texto predeterminado."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "¡Gracias, eres el mejor! (="

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
