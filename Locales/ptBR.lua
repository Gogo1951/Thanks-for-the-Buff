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
L["MSG_BUFFED"] = "%s buffou você com %s!"
L["MSG_GAVE_YOU"] = "%s deu a você %s!"
L["MSG_GAVE_GROUP"] = "%s deu ao seu grupo %s!"
L["MSG_USED_ITEM"] = "%1$s usou %3$s %2$s em você!"
L["MSG_USED_SPELL"] = "%s usou %s em você!"
L["MSG_SET_OUT"] = "%s colocou %s!"
L["MSG_OPENED"] = "%s abriu %s!"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "Obrigado por %s!"
L["MSG_GOODNEWS_DURATION"] = "Boas notícias! Você tem %s por %s!"
L["MSG_GOODNEWS"] = "Boas notícias! Você tem %s!"
L["MSG_PEER_PRESSURE"] = "%s usou %s!"
L["MSG_PEER_PRESSURE_TARGET"] = "%s usou %s em %s!"
L["MSG_SELECT_PLAYER"] = "Selecione um jogador para agradecer."
L["MSG_CANT_THANK_SELF"] = "Você não pode agradecer a si mesmo!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MSG_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "dele"
L["PRONOUN_HER"] = "dela"
L["PRONOUN_THEIR"] = "deles"
L["UNKNOWN_SPELL"] = "Feitiço Desconhecido"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar Mensagem de Boas-vindas"
L["OPTIONS_WELCOME_DESC"] = "Mostra uma mensagem no chat quando você entra."
L["OPTIONS_DESCRIPTION"] =
	"Agradeça automaticamente com emotes, sussurros e avisos no chat aos jogadores que te dão buff, seja um estranho no mundo aberto ou a recarga de um colega como Power Infusion ou Innervate. Receba também um aviso de banquetes, portais e recargas da sua classe."
L["OPTIONS_SUPPORT"] = "Feedback e Suporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Abre a interface de opções do Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Manda um emote e um sussurro para o seu alvo atual."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Buffs de Estranhos"
L["STRANGERS_DESC"] = "Um buff em você de um jogador de fora do seu grupo (mundo aberto)."
L["STRANGERS_COOLDOWN"] = "Recarga (Segundos)"
L["STRANGERS_COOLDOWN_DESC"] =
	"No máximo, com que frequência lançar emote no mesmo jogador.\n\nAs mensagens não são afetadas; elas são disparadas a cada buff."
L["STRANGERS_MIN_DURATION"] = "Duração Mínima do Buff (Segundos)"
L["STRANGERS_MIN_DURATION_DESC"] =
	"A duração mínima que o buff deve durar para disparar um agradecimento.\n\nFiltra curas curtas ao longo do tempo como Renovar ou Rejuvenescer."

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Buffs de Colegas de Equipe"
L["TEAMMATES_DESC"] = "Um buff ou recarga de um membro do grupo ou raide lançado em você."

-- Group Services
L["TAB_SERVICES"] = "Serviços de Grupo"
L["SERVICES_DESC"] =
	"Ajuda para toda a raide de um membro do grupo ou raide: banquetes, poços de almas, portais, robôs de reparo."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Boas Notícias"
L["GOOD_NEWS_DESC"] =
	"Sussurra automaticamente aos jogadores que você buffa sobre os buffs de combate que você lança neles."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Habilitar Boas Notícias"
L["GOOD_NEWS_WHISPER_DESC"] = "Sussurra ao jogador que você buffou para dizer o que ele recebeu e por quanto tempo."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Qualquer um que você buffar"
L["GOOD_NEWS_SCOPE_GROUP"] = "Apenas membros do grupo"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Peer Pressure"
L["PEER_PRESSURE_DESC"] =
	"Receba um aviso quando outros jogadores da sua classe usarem seus tempos de recarga, para você ceder ao Peer Pressure."
L["PEER_PRESSURE_ENABLE"] = "Habilitar Peer Pressure"
L["PEER_PRESSURE_PRINT_DESC"] =
	"Mostra uma mensagem no seu próprio chat quando um tempo de recarga da sua classe é usado. Só você vê."
L["PEER_PRESSURE_OWN_CASTS"] = "Ativar com Seus Próprios Feitiços"
L["PEER_PRESSURE_OWN_CASTS_DESC"] =
	"Dispara o aviso também quando você usa suas próprias recargas, não só as de outros jogadores."
L["PEER_PRESSURE_SOUND_DESC"] = "Toca um som quando um tempo de recarga da sua classe é usado. Só você ouve."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Habilidades Rastreadas"
L["COMBAT_GROUP_ITEMS"] = "Itens"
L["COMBAT_TOGGLE_TRACKING"] = "Alternar rastreio para %s"
L["COMBAT_ITEM_PENDING"] = "Item #%d"
L["COMBAT_SPELL_PENDING"] = "Feitiço #%d"

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
L["BUTTON_DESC"] = "Agradeça ao seu alvo atual com um emote e um sussurro."
L["BUTTON_CREATE_MACRO"] = "Criar Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Cria automaticamente uma macro chamada %s ao entrar no jogo."
L["BUTTON_WHISPER"] = "Mensagem de Sussurro"
L["BUTTON_RESET"] = "Redefinir"
L["BUTTON_RESET_DESC"] = "Redefine a mensagem de sussurro para o texto padrão."

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_HEADER"] = "Mensagens"
L["MESSAGING_PRINT_ENABLE"] = "Habilitar Mensagens no Chat (Apenas para você)"
L["MESSAGING_PRINT_DESC"] = "Mostra uma mensagem no seu próprio chat quando você recebe um buff. Só você vê."
L["MESSAGING_WHISPER_ENABLE"] = "Habilitar Mensagens de Agradecimento"
L["MESSAGING_WHISPER_DESC"] = "Sussurra um agradecimento ao jogador que buffou você."
L["MESSAGING_EMOTES_ENABLE"] = "Habilitar Emotes (Fora de Combate)"
L["MESSAGING_EMOTES_DESC"] =
	"Mostre sua apreciação com um emote. Emotes são retidos enquanto você está em combate."
L["MESSAGING_EMOTES_SELECT"] = "Selecionar Emotes"
L["MESSAGING_SOUND_ENABLE"] = "Habilitar Efeito Sonoro"
L["MESSAGING_SOUND_DESC"] = "Toca um som quando você recebe um buff. Só você ouve."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Obrigado, você é o melhor! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESC"] = "Você torce por <Target>."
L["EMOTE_DRINK_DESC"] = "Você ergue um brinde a <Target>."
L["EMOTE_FLEX_DESC"] = "Você exibe seus músculos para <Target>."
L["EMOTE_GRIN_DESC"] = "Você dá um sorriso malicioso para <Target>."
L["EMOTE_HIGHFIVE_DESC"] = "Você dá um toca-aqui em <Target>."
L["EMOTE_PRAISE_DESC"] = "Você elogia <Target>."
L["EMOTE_SALUTE_DESC"] = "Você saúda <Target> com respeito."
L["EMOTE_SMILE_DESC"] = "Você sorri para <Target>."
L["EMOTE_THANK_DESC"] = "Você agradece a <Target>."
L["EMOTE_WHOA_DESC"] = "Você olha para <Target> e exclama 'Uau!'"
L["EMOTE_WINK_DESC"] = "Você pisca para <Target>."
L["EMOTE_YES_DESC"] = "Você acena com a cabeça para <Target>."
