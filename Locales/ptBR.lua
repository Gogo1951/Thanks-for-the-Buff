local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "ptBR")
if not L then return end

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["MSG_ENABLED"] = "Habilitado. Use /tftb para ajustar suas configurações; incluindo desligar esta mensagem. (="
L["MSG_DB_ERROR"] = "Erro: Falha ao carregar os padrões do banco de dados. Por favor, redefina seu perfil via /tftb."
L["MSG_RESET"] = "Todas as configurações foram redefinidas para os padrões."
L["MSG_BUFFED"] = "%s buffou você com %s!"
L["MSG_HIT"] = "%s atingiu você com %s!"
L["MSG_PARTY_ITEM"] = "%s usou %s para o seu grupo!"
L["MSG_WHISPER_THANKS"] = "Obrigado por %s!"
L["MSG_SELECT_PLAYER"] = "Selecione um jogador para agradecer."
L["MSG_CANT_THANK_SELF"] = "Você não pode agradecer a si mesmo!"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_GENERAL"] = "Configurações Gerais"
L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar Mensagem de Boas-vindas"
L["OPTIONS_WELCOME_DESC"] = "Mostra uma mensagem no chat quando você entra."
L["OPTIONS_RESET"] = "Redefinir"
L["OPTIONS_RESET_ALL"] = "Redefinir Todas as Configurações"
L["OPTIONS_RESET_ALL_DESC"] = "Restaura cada opção ao seu valor padrão."
L["OPTIONS_RESET_CONFIRM"] = "Tem certeza de que deseja redefinir todas as configurações para seus padrões?"
L["OPTIONS_DESCRIPTION"] = "Expresse felicidade automaticamente com um emote sempre que receber um novo buff."
L["OPTIONS_SUPPORT"] = "Feedback e Suporte"
L["OPTIONS_CMD_TFTB_DESC"] = "Abre a interface de opções do Thanks for the Buff."
L["OPTIONS_CMD_THANKYOU_DESC"] = "Manda um emote e um sussurro para o jogador no seu alvo."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "Buffs de Estranhos"
L["STRANGERS_ENABLE"] = "Reagir a Buffs de Estranhos"
L["STRANGERS_COOLDOWN"] = "Recarga (Segundos)"
L["STRANGERS_COOLDOWN_DESC"] = "No máximo, com que frequência agradecer o mesmo jogador."
L["STRANGERS_MIN_DURATION"] = "Duração Mínima do Buff (Segundos)"
L["STRANGERS_MIN_DURATION_DESC"] = "A duração mínima que o buff deve durar para disparar um agradecimento.\n\nFiltra curas curtas ao longo do tempo como Renovar ou Rejuvenescer."
L["STRANGERS_MESSAGING"] = "Mensagens"
L["STRANGERS_EMOTES_ENABLE"] = "Habilitar Emotes"
L["STRANGERS_EMOTES_DESC"] = "Use emotes para mostrar apreciação por buffs de estranhos."
L["STRANGERS_EMOTES_SELECT"] = "Selecionar Emotes"

--------------------------------------------------------------------------------
-- Options: Combat Buffs
--------------------------------------------------------------------------------

L["COMBAT_TITLE"] = "Buffs de Combate"
L["COMBAT_MESSAGING"] = "Mensagens"
L["COMBAT_TRACKED"] = "Habilidades Rastreadas:"
L["COMBAT_TOGGLE_TRACKING"] = "Alternar rastreio para %s"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Botão de Agradecimento"
L["BUTTON_CREATE_MACRO"] = "Criar Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Uma macro chamada %s será criada automaticamente para você ao entrar no jogo."
L["BUTTON_WHISPER"] = "Mensagem de Sussurro"
L["BUTTON_RESET"] = "Redefinir"
L["BUTTON_RESET_DESC"] = "Redefine a mensagem de sussurro para o texto padrão."
L["BUTTON_EMOTES_HEADER"] = "Emotes do Botão de Agradecimento:"
L["BUTTON_EMOTES_SELECT"] = "Selecionar Emotes"

--------------------------------------------------------------------------------
-- Shared: Messaging Dropdown
--------------------------------------------------------------------------------

L["MESSAGING_NONE"] = "Nenhuma Mensagem"
L["MESSAGING_NONE_DEFAULT"] = "Nenhuma Mensagem (Padrão)"
L["MESSAGING_PRINT"] = "Mensagem no Chat (Apenas para você)"
L["MESSAGING_WHISPER"] = "Mensagem de Sussurro"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Obrigado, você é o melhor! (="