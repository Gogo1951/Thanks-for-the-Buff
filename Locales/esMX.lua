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
	"Versión %s. La configuración (incluida la opción para desactivar este mensaje) se encuentra en Opciones > Accesorios > Thanks for the Buff. ¿Te gusta el accesorio? ¡Cuéntaselo a un amigo! (="

-- Buff & gift announcements
L["MSG_BUFFED"] = "¡%s te ha beneficiado con %s!"
L["MSG_GAVE_YOU"] = "¡%s te ha dado %s!"
L["MSG_GAVE_GROUP"] = "¡%s le dio a tu grupo %s!"
L["MSG_USED_ITEM"] = "¡%s usó %s %s en ti!"
L["MSG_USED_SPELL"] = "¡%s usó %s en ti!"
L["MSG_SET_OUT"] = "¡%s puso %s!"
L["MSG_OPENED"] = "¡%s abrió %s!"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "¡Gracias por %s!"
L["MSG_GOODNEWS_DURATION"] = "¡Buenas noticias! ¡Tienes %s durante %s!"
L["MSG_GOODNEWS"] = "¡Buenas noticias! ¡Tienes %s!"
L["MSG_PEER_PRESSURE"] = "¡%s usó %s!"
L["MSG_PEER_PRESSURE_TARGET"] = "¡%s usó %s en %s!"
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
L["OPTIONS_DESCRIPTION"] =
	"Agradece automáticamente con emotes, susurros y avisos de chat a los jugadores que te benefician, ya sea un desconocido en el mundo abierto o el tiempo de reutilización de un compañero como Power Infusion o Innervate. Recibe también un aviso de festines, portales y cooldowns de tu clase."
L["OPTIONS_SUPPORT"] = "Comentarios y soporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Abre la interfaz de opciones de Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Hace un emote y susurra a tu objetivo actual."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Beneficios de Desconocidos"
L["STRANGERS_DESC"] = "Un beneficio sobre ti de un jugador fuera de tu grupo (mundo abierto)."
L["STRANGERS_COOLDOWN"] = "Tiempo de reutilización (Segundos)"
L["STRANGERS_COOLDOWN_DESC"] =
	"Con qué frecuencia máxima se enviará un emote al mismo jugador.\n\nLos mensajes no se ven afectados; se activan para cada beneficio."
L["STRANGERS_MIN_DURATION"] = "Duración mínima del beneficio (Segundos)"
L["STRANGERS_MIN_DURATION_DESC"] =
	"Duración mínima que debe durar el beneficio para activar un agradecimiento.\n\nFiltra sanaciones cortas en el tiempo como Renovar o Rejuvenecimiento."

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Beneficios de Compañeros de Equipo"
L["TEAMMATES_DESC"] = "Un beneficio o tiempo de reutilización de un miembro del grupo o banda lanzado sobre ti."

-- Group Services
L["TAB_SERVICES"] = "Servicios de Grupo"
L["SERVICES_DESC"] =
	"Ayuda para toda la banda de un miembro del grupo o banda: festines, pozos de almas, portales, bots de reparación."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Buenas Noticias"
L["GOOD_NEWS_DESC"] =
	"Susurra automáticamente a los jugadores que beneficias sobre los beneficios de combate que les lanzas."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Habilitar Buenas Noticias"
L["GOOD_NEWS_WHISPER_DESC"] = "Susurra al jugador que beneficiaste para decirle qué recibió y por cuánto tiempo."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Cualquiera que beneficies"
L["GOOD_NEWS_SCOPE_GROUP"] = "Solo miembros del grupo"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Peer Pressure"
L["PEER_PRESSURE_DESC"] =
	"Recibe una notificación cuando otros jugadores de tu clase usen sus tiempos de reutilización, para que cedas al Peer Pressure."
L["PEER_PRESSURE_ENABLE"] = "Habilitar Peer Pressure"
L["PEER_PRESSURE_PRINT_DESC"] =
	"Imprime un mensaje en tu propio chat cuando se usa un tiempo de reutilización de tu clase. Solo tú lo ves."
L["PEER_PRESSURE_OWN_CASTS"] = "Activar con tus propios hechizos"
L["PEER_PRESSURE_OWN_CASTS_DESC"] =
	"Activa la notificación también cuando usas tus propios tiempos de reutilización, no solo cuando lo hacen otros jugadores."
L["PEER_PRESSURE_SOUND_DESC"] =
	"Reproduce un sonido cuando se usa un tiempo de reutilización de tu clase. Solo tú lo oyes."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Habilidades rastreadas"
L["COMBAT_GROUP_ITEMS"] = "Objetos"
L["COMBAT_TOGGLE_TRACKING"] = "Alternar rastreo para %s"
L["COMBAT_ITEM_PENDING"] = "Objeto #%d"
L["COMBAT_SPELL_PENDING"] = "Hechizo #%d"

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
L["BUTTON_DESC"] = "Agradece a tu objetivo actual con un emote y un susurro."
L["BUTTON_CREATE_MACRO"] = "Crear Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Crea automáticamente una macro llamada %s al iniciar sesión."
L["BUTTON_WHISPER"] = "Mensaje de Susurro"
L["BUTTON_RESET"] = "Restablecer"
L["BUTTON_RESET_DESC"] = "Restablece el mensaje de susurro al texto predeterminado."

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_HEADER"] = "Mensajes"
L["MESSAGING_PRINT_ENABLE"] = "Habilitar mensajes impresos (Solo para ti)"
L["MESSAGING_PRINT_DESC"] = "Imprime un mensaje en tu propio chat cuando recibes un beneficio. Solo tú lo ves."
L["MESSAGING_WHISPER_ENABLE"] = "Habilitar mensajes de agradecimiento"
L["MESSAGING_WHISPER_DESC"] = "Susurra un agradecimiento al jugador que te dio el beneficio."
L["MESSAGING_EMOTES_ENABLE"] = "Habilitar Emotes (Fuera de combate)"
L["MESSAGING_EMOTES_DESC"] = "Muestra tu aprecio con un emote. Los emotes se retienen mientras estás en combate."
L["MESSAGING_EMOTES_SELECT"] = "Seleccionar Emotes"
L["MESSAGING_SOUND_ENABLE"] = "Habilitar efecto de sonido"
L["MESSAGING_SOUND_DESC"] = "Reproduce un sonido cuando recibes un beneficio. Solo tú lo oyes."

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
