local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "ptBR")
if not L then return end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] = "Versão %s. Configurações (incluindo a opção de desativar esta mensagem) podem ser encontradas em Opções > AddOns > Thanks for the Buff. Gostando do add-on? Conte a um amigo! (="
L["MSG_RESET"] = "Todas as configurações foram redefinidas para os padrões."

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s buffou você com %s!"
L["MSG_GAVE_YOU"] = "%s deu a você %s!"
L["MSG_GAVE_GROUP"] = "%s deu ao seu grupo %s!"
L["MSG_USED_ITEM"] = "%1$s usou %3$s %2$s em você!"
L["MSG_USED_SPELL"] = "%s usou %s em você!"
L["MSG_SET_OUT"] = "%s colocou %s!"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "Obrigado por %s!"
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
L["OPTIONS_RESET"] = "Redefinir"
L["OPTIONS_RESET_ALL"] = "Redefinir Todas as Configurações"
L["OPTIONS_RESET_ALL_DESC"] = "Restaura cada opção ao seu valor padrão."
L["OPTIONS_RESET_CONFIRM"] = "Tem certeza de que deseja redefinir todas as configurações para seus padrões?"
L["OPTIONS_DESCRIPTION"] = "Expresse automaticamente sua apreciação com emotes e mensagens sempre que receber um buff — seja de um estranho no mundo aberto ou de um colega de equipe usando uma recarga para você em combate."
L["OPTIONS_SUPPORT"] = "Feedback e Suporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Abre a interface de opções do Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Manda um emote e um sussurro para o jogador no seu alvo."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "Buffs de Estranhos"
L["STRANGERS_DESC"] = "Um buff em você de um jogador de fora do seu grupo (mundo aberto)."
L["STRANGERS_COOLDOWN"] = "Recarga (Segundos)"
L["STRANGERS_COOLDOWN_DESC"] = "No máximo, com que frequência lançar emote no mesmo jogador.\n\nAs mensagens não são afetadas; elas são disparadas a cada buff."
L["STRANGERS_MIN_DURATION"] = "Duração Mínima do Buff (Segundos)"
L["STRANGERS_MIN_DURATION_DESC"] = "A duração mínima que o buff deve durar para disparar um agradecimento.\n\nFiltra curas curtas ao longo do tempo como Renovar ou Rejuvenescer."
L["STRANGERS_MESSAGING"] = "Mensagens"
L["STRANGERS_EMOTES_SELECT"] = "Selecionar Emotes"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

L["TEAMMATES_TITLE"] = "Buffs de Colegas de Equipe"
L["TEAMMATES_DESC"] = "Um buff ou recarga de um membro do grupo ou raide lançado em você."
L["SERVICES_TITLE"] = "Serviços de Grupo"
L["SERVICES_DESC"] = "Ajuda para toda a raide de um membro do grupo ou raide — banquetes, poços de almas, portais, robôs de reparo."
L["COMBAT_MESSAGING"] = "Mensagens"
L["COMBAT_EMOTES_SELECT"] = "Selecionar Emotes"
L["COMBAT_TRACKED"] = "Habilidades Rastreadas:"
L["COMBAT_TOGGLE_TRACKING"] = "Alternar rastreio para %s"
L["COMBAT_GROUP_ITEMS"] = "Itens"
L["COMBAT_ITEM_PENDING"] = "Item #%d"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Botão de Agradecimento"
L["BUTTON_DESC"] = "Agradeça ao seu alvo atual com um emote e um sussurro."
L["BUTTON_CREATE_MACRO"] = "Criar Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Uma macro chamada %s será criada automaticamente para você ao entrar no jogo."
L["BUTTON_WHISPER"] = "Mensagem de Sussurro"
L["BUTTON_RESET"] = "Redefinir"
L["BUTTON_RESET_DESC"] = "Redefine a mensagem de sussurro para o texto padrão."
L["BUTTON_EMOTES_SELECT"] = "Selecionar Emotes"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_PRINT_ENABLE"] = "Habilitar Mensagens no Chat (Apenas para você)"
L["MESSAGING_PRINT_DESC"] = "Mostra uma mensagem no seu próprio chat quando você recebe um buff. Só você vê."
L["MESSAGING_WHISPER_ENABLE"] = "Habilitar Mensagens de Agradecimento"
L["MESSAGING_WHISPER_DESC"] = "Sussurra um agradecimento ao jogador que buffou você."
L["MESSAGING_EMOTES_ENABLE"] = "Habilitar Emotes (Fora de Combate)"
L["MESSAGING_EMOTES_DESC"] = "Mostre sua apreciação com um emote. Emotes são retidos enquanto você está em combate."

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
