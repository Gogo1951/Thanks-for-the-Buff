local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "ptBR")
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
	"Versão %s. Configurações (incluindo a opção de desativar esta mensagem) podem ser encontradas em Opções > AddOns > Thanks for the Buff. Gostando do add-on? Conte a um amigo! (="

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s buffou você com %s!"
L["MESSAGE_GAVE_YOU"] = "%s deu a você %s!"
L["MESSAGE_GAVE_GROUP"] = "%s deu ao seu grupo %s!"
L["MESSAGE_USED_ITEM"] = "%1$s usou %3$s %2$s em você!"
L["MESSAGE_USED_SPELL"] = "%s usou %s em você!"
L["MESSAGE_SET_OUT"] = "%s colocou %s!"
L["MESSAGE_OPENED"] = "%s abriu %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Obrigado por %s!"
L["MESSAGE_GOOD_NEWS_DURATION"] = "Boas notícias! Você tem %s por %s!"
L["MESSAGE_GOOD_NEWS"] = "Boas notícias! Você tem %s!"
L["MESSAGE_PEER_PRESSURE"] = "%s usou %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s usou %s em %s!"
L["MESSAGE_SELECT_PLAYER"] = "Selecione um jogador para agradecer."
L["MESSAGE_CANT_THANK_SELF"] = "Você não pode agradecer a si mesmo!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MESSAGE_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "dele"
L["PRONOUN_HER"] = "dela"
L["PRONOUN_THEIR"] = "deles"
L["UNKNOWN_SPELL"] = "Feitiço Desconhecido"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar Mensagem de Boas-vindas"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Mostra uma mensagem no chat quando você entra."
L["OPTIONS_DESCRIPTION"] =
	"Agradeça automaticamente com emotes, sussurros e avisos no chat aos jogadores que te dão buff, seja um estranho no mundo aberto ou a recarga de um colega como Power Infusion ou Innervate. Receba também um aviso de banquetes, portais e recargas da sua classe."
L["OPTIONS_SUPPORT"] = "Feedback e Suporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMAND_TFTB"] = "/tftb"
L["OPTIONS_COMMAND_TFTB_DESCRIPTION"] = "Abre a interface de opções do Thanks for the Buff."
L["OPTIONS_COMMAND_THANKYOU"] = "/thankyou"
L["OPTIONS_COMMAND_THANKYOU_DESCRIPTION"] = "Manda um emote e um sussurro para o seu alvo atual."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Buffs de Estranhos"
L["STRANGERS_DESCRIPTION"] = "Um buff em você de um jogador de fora do seu grupo (mundo aberto)."
L["STRANGERS_OVERALL_COOLDOWN"] = "Recarga de Agradecimentos (Segundos)"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"No máximo, com que frequência agradecer a alguém, venha de quem vier o buff.\n\nDefina 0 para desativar esse limite. As notificações não são afetadas."
L["STRANGERS_SOURCE_COOLDOWN"] = "Recarga por Jogador (Segundos)"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"No máximo, com que frequência agradecer ao mesmo jogador.\n\nAs notificações não são afetadas."
L["STRANGERS_MIN_DURATION"] = "Duração Mínima do Buff (Segundos)"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Quanto o buff deve durar para valer a pena reagir.\n\nFiltra curas curtas ao longo do tempo como Renovar ou Rejuvenescer. As notificações também são afetadas; um buff abaixo disso é ignorado por completo, sem mensagem, som, sussurro ou emote."

--------------------------------------------------------------------------------
-- Options: Combat Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Buffs de Colegas de Equipe"
L["TEAMMATES_DESCRIPTION"] = "Um buff ou recarga de um membro do grupo ou raide lançado em você."

-- Group Services
L["TAB_SERVICES"] = "Serviços de Grupo"
L["SERVICES_DESCRIPTION"] =
	"Ajuda para toda a raide de um membro do grupo ou raide: banquetes, poços de almas, portais, robôs de reparo."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Boas Notícias"
L["GOOD_NEWS_DESCRIPTION"] = "Avise os jogadores que você buffa sobre o que lançou neles e quanto tempo dura."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Habilitar Boas Notícias"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Sussurra ao jogador que você buffou para dizer o que ele recebeu e por quanto tempo."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Qualquer um que você buffar"
L["GOOD_NEWS_SCOPE_GROUP"] = "Apenas membros do grupo"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Pressão do Grupo"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Receba um aviso quando outros jogadores da sua classe usarem seus tempos de recarga, para você ceder à pressão do grupo."
L["PEER_PRESSURE_ENABLE"] = "Habilitar Peer Pressure"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Mostra uma mensagem no seu próprio chat quando um tempo de recarga da sua classe é usado. Só você vê."
L["PEER_PRESSURE_OWN_CASTS"] = "Ativar com Seus Próprios Feitiços"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Dispara o aviso também quando você usa suas próprias recargas, não só as de outros jogadores."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] = "Toca um som quando um tempo de recarga da sua classe é usado. Só você ouve."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Habilidades Rastreadas"
L["COMBAT_GROUP_ITEMS"] = "Itens"
L["COMBAT_TOGGLE_TRACKING"] = "Alternar rastreio para %s"
L["COMBAT_ITEM_PENDING"] = "Item #%d"
L["COMBAT_SPELL_PENDING"] = "Feitiço #%d"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

-- The two section headers every buff panel is built from: what the other player
-- sees, then what only you get. Peer Pressure sends nothing outward, so it
-- carries the Notifications header alone. Key prefixes match the header the
-- control appears under.
L["PRAISE_HEADER"] = "Mensagens de Agradecimento e Emotes"
L["NOTIFICATIONS_HEADER"] = "Notificações"

L["PRAISE_WHISPER_ENABLE"] = "Habilitar Sussurros de Agradecimento"
L["PRAISE_WHISPER_DESCRIPTION"] = "Sussurra um agradecimento ao jogador que buffou você."
L["PRAISE_EMOTES_ENABLE"] = "Habilitar Emotes (Fora de Combate)"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Mostre sua apreciação com um emote. Emotes são retidos enquanto você está em combate."
L["PRAISE_EMOTES_SELECT"] = "Selecionar Emotes"
L["PRAISE_DELAY_ENABLE"] = "Habilitar Atraso do Agradecimento"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Espera um instante antes do sussurro e do emote, para que seu agradecimento não chegue no mesmo instante que o buff.\n\nAs notificações não são afetadas."
L["PRAISE_DELAY_LENGTH"] = "Atraso"
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Quanto esperar antes de agradecer ao jogador que buffou você."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Habilitar Mensagens no Chat"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Mostra uma mensagem no seu próprio chat quando você recebe um buff. Só você vê."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Habilitar Efeitos Sonoros"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Toca um som quando você recebe um buff. Só você ouve."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

-- Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
-- spells and items take their names from the client and need no key here.
L["GROUP_PORTALS"] = "Portais"
L["GROUP_SOULSTONE"] = "Pedra de Alma"
L["GROUP_RESISTANCE_CAULDRONS"] = "Caldeirões de Resistência"
L["GROUP_SCROLL_OF_SPIRIT"] = "Pergaminho do Espírito"
L["GROUP_SCROLL_OF_STAMINA"] = "Pergaminho de Vigor"
L["GROUP_SCROLL_OF_STRENGTH"] = "Pergaminho de Força"
L["GROUP_SCROLL_OF_PROTECTION"] = "Pergaminho de Proteção"
L["GROUP_SCROLL_OF_INTELLECT"] = "Pergaminho de Intelecto"
L["GROUP_SCROLL_OF_AGILITY"] = "Pergaminho de Agilidade"
L["GROUP_REPAIR_BOTS"] = "Robôs de Reparo"
L["GROUP_JUMPER_CABLES"] = "Cabos de Chupeta"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Botão de Agradecimento"
L["BUTTON_DESCRIPTION"] = "Agradeça ao seu alvo atual com um emote e um sussurro."
L["BUTTON_CREATE_MACRO"] = "Criar Macro"
L["BUTTON_CREATE_MACRO_DESCRIPTION"] = "Cria automaticamente uma macro chamada %s ao entrar no jogo."
L["BUTTON_WHISPER"] = "Mensagem de Sussurro"
L["BUTTON_RESET"] = "Redefinir"
L["BUTTON_RESET_DESCRIPTION"] = "Redefine a mensagem de sussurro para o texto padrão."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Obrigado, você é o melhor! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "Você torce por <Target>."
L["EMOTE_DRINK_DESCRIPTION"] = "Você ergue um brinde a <Target>."
L["EMOTE_FLEX_DESCRIPTION"] = "Você exibe seus músculos para <Target>."
L["EMOTE_GRIN_DESCRIPTION"] = "Você dá um sorriso malicioso para <Target>."
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "Você dá um toca-aqui em <Target>."
L["EMOTE_PRAISE_DESCRIPTION"] = "Você elogia <Target>."
L["EMOTE_SALUTE_DESCRIPTION"] = "Você saúda <Target> com respeito."
L["EMOTE_SMILE_DESCRIPTION"] = "Você sorri para <Target>."
L["EMOTE_THANK_DESCRIPTION"] = "Você agradece a <Target>."
L["EMOTE_WHOA_DESCRIPTION"] = "Você exclama 'Uau!' para <Target>."
L["EMOTE_WINK_DESCRIPTION"] = "Você pisca para <Target>."
L["EMOTE_YES_DESCRIPTION"] = "Você acena com a cabeça para <Target>."
