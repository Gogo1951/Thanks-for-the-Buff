local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "ptBR")
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
	"Versão %s. As configurações (incluindo a opção de desativar esta mensagem) ficam em Opções > AddOns > Thanks for the Buff (TFTB). Gostando deste add-on? Conte a um amigo, favorite-o no CurseForge ou dê uma Star no GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por precaução, a interface de opções não pode ser aberta durante o combate."

-- Buff print out
L["MESSAGE_BUFFED"] = "%s buffou você com %s!"

-- Thank You Button
L["MESSAGE_SELECT_PLAYER"] = "Primeiro, selecione um jogador como alvo."
L["MESSAGE_CANT_THANK_SELF"] = "Você não pode agradecer a si mesmo!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Feitiço desconhecido"
L["SAMPLE_EXAMPLE"] = "Exemplo: %s"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensagem de boas-vindas"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Exibe uma mensagem que só você vê quando entra no jogo."
L["OPTIONS_DESCRIPTION"] =
	"Agradeça automaticamente com uma expressão ou um sussurro aos jogadores que derem um buff em você. Desconhecidos que lançarem Fortitude, Inteligência Arcana ou Marca do Indomado em você são agradecidos na hora, e um clique nas suas macros de agradecimento agradece a quem estiver no seu alvo."
L["OPTIONS_FEATURES_HEADER"] = "Recursos"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Ative ou desative cada recurso aqui ou no painel dele."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre a interface de opções deste add-on."

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "Procurando outros recursos?"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"Alguns recursos foram para o nosso novo add-on, Good to Go. Encontre-o no CurseForge ou no Wago."

--------------------------------------------------------------------------------
-- Options: Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "Ajude o Thanks for the Buff (TFTB) a subir de nível"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"Este add-on foi criado por jogadores que amam este jogo e querem deixá-lo o mais divertido possível para todos. Nunca pediremos doações. A verdadeira satisfação vem de saber que o nosso trabalho deixa o jogo um pouco melhor para você. Se for o caso, adoraríamos saber!"
L["OPTIONS_LEVEL_UP_WAYS"] = "Veja algumas formas de nos ajudar a alcançar mais jogadores."
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• Compartilhe feedback: encontrou um bug ou tem uma ideia? Conte para nós no Discord. Seu feedback nos ajuda a melhorar o add-on, e pull requests são sempre bem-vindos."
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• Conte a um amigo: conhece alguém que pode gostar deste add-on? Fale dele para essa pessoa. O boca a boca ajuda mais jogadores a descobrir ótimos add-ons."
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	"• Favorite no CurseForge: abra o link do CurseForge abaixo, entre na sua conta e clique na estrela embaixo do botão Download. Os favoritos ajudam mais jogadores a descobrir o add-on."
L["OPTIONS_LEVEL_UP_GITHUB"] =
	"• Dê uma Star no GitHub: abra o link do GitHub abaixo, entre na sua conta e clique em Star no canto superior direito. As stars ajudam o projeto a se qualificar para mais ferramentas de desenvolvimento gratuitas."
L["OPTIONS_LEVEL_UP_THANKS"] = "Obrigado por escolher o Thanks for the Buff (TFTB)!"

L["OPTIONS_FEEDBACK"] = "Feedback e suporte"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "Links de feedback e suporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "Para copiar um link, clique na caixa dele e pressione Ctrl+A e Ctrl+C."
L["OPTIONS_VERSION"] = "Versão %s"

--------------------------------------------------------------------------------
-- Options: Give Thanks
--------------------------------------------------------------------------------

L["TAB_GIVE_THANKS"] = "Agradecimentos"
L["GIVE_THANKS_ENABLE"] = "Habilitar agradecimentos"
L["GIVE_THANKS_ENABLE_DESCRIPTION"] = "Ativa os agradecimentos por buffs de jogadores de fora do seu grupo."
L["GIVE_THANKS_DESCRIPTION"] =
	"Agradeça aos jogadores de fora do seu grupo quando eles buffarem você no mundo aberto."

-- Praise Limits
L["PRAISE_HEADER"] = "Limites de agradecimento"
L["PRAISE_DESCRIPTION"] =
	"Estas opções seguram tanto a expressão quanto o sussurro, para que uma onda de buffs nunca vire spam."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["GIVE_THANKS_OVERALL_COOLDOWN"] = "Recarga dos agradecimentos"
L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Define o intervalo entre uma rodada de agradecimentos e a próxima, não importa quem buffou você. Defina como zero para agradecer todos os buffs."
L["GIVE_THANKS_SOURCE_COOLDOWN"] = "Recarga de agradecimento ao mesmo jogador"
L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Define o intervalo entre agradecimentos dirigidos ao mesmo jogador. Defina como zero para agradecer todos os buffs."
L["GIVE_THANKS_MIN_DURATION"] = "Duração mínima do buff"
L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"] =
	"Ignora buffs com duração menor que este valor. Defina como zero para reagir a todos os buffs."
L["PRAISE_DELAY_ENABLE"] = "Habilitar atraso do agradecimento"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Espera um momento antes do sussurro e da expressão, para que seu agradecimento não chegue no mesmo instante que o buff. As notificações não são afetadas."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Define quanto tempo esperar antes de enviar o sussurro e a expressão."

-- Thank-You Whispers
L["WHISPERS_HEADER"] = "Sussurros de agradecimento"
L["PRAISE_WHISPER_ENABLE"] = "Habilitar sussurros de agradecimento"
L["PRAISE_WHISPER_DESCRIPTION"] = "Sussurra um agradecimento ao jogador que buffou você."
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"Define o que o TFTB sussurra para o jogador que buffou você. {spell} vira o buff. Deixe em branco para não enviar sussurro."

-- Notifications
L["NOTIFICATIONS_HEADER"] = "Notificações"
L["NOTIFICATIONS_DESCRIPTION"] = "O que só você recebe: um aviso de texto, um som ou ambos."
L["NOTIFICATIONS_PRINT_ENABLE"] = "Habilitar avisos de texto"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Exibe uma mensagem que só você vê quando recebe um buff."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Habilitar efeitos sonoros"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Toca um som quando você recebe um buff. Só você ouve."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Toca o som para você ouvi-lo antes de ativá-lo."

-- Emotes: the grid's group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS entry, upper-cased.
L["TAB_EMOTES_LIST"] = "Lista de expressões"
L["EMOTES_GRID_DESCRIPTION"] =
	"Marque as expressões que a função Agradecimentos pode escolher quando um jogador de fora do seu grupo buffa você; ela usa uma ao acaso. As expressões ficam retidas enquanto você está em combate."
L["EMOTE_GROUP_COUNT"] = "%s (%d de %d marcadas)"
L["EMOTE_GROUP_TEXT"] = "Texto"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "Mostra só a linha da expressão."
L["EMOTE_GROUP_VOICE"] = "Voz"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "Toca uma fala."
L["EMOTE_GROUP_GESTURE"] = "Gesto"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "Toca uma animação curta."
L["EMOTE_GROUP_POSE"] = "Postura"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "Dura até você se mover."
L["EMOTES_RESET"] = "Redefinir expressões"
L["EMOTES_RESET_DESCRIPTION"] = "Volta a lista às expressões de agradecimento padrão."
L["EMOTES_RESET_CONFIRM"] = "Redefinir a lista de expressões para o padrão?"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "Buffs ignorados"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"Os buffs desta lista nunca recebem agradecimento, não importa quem os lance. Você continua recebendo seu aviso de texto e seu som."
L["IGNORED_BUFFS_ADD_CURRENT"] = "Ignorar buff atual"
L["IGNORED_BUFFS_ADD_CURRENT_DESCRIPTION"] = "Adiciona um dos buffs que estão em você agora."
L["IGNORED_BUFFS_ADD"] = "Adicionar buff"
L["IGNORED_BUFFS_ADD_DESCRIPTION"] =
	"Digite um ID de feitiço, ou clique com Shift no link de um buff para colocá-lo na caixa, e depois pressione Enter."
L["IGNORED_BUFFS_EMPTY"] = "Nenhum buff ignorado ainda. Adicione um acima."
L["IGNORED_BUFFS_REMOVE"] = "Remove este buff da lista."
L["IGNORED_BUFFS_NOT_FOUND"] = "Nenhum buff encontrado para %s."
L["IGNORED_BUFFS_ALL_CHARACTERS"] = "Todos os personagens"
L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"] =
	"Move este buff para a lista Todos os personagens, para que não seja agradecido em nenhum personagem."

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Botão de agradecimento"
L["BUTTON_DESCRIPTION"] =
	"Sussurre e faça uma expressão para o seu alvo com uma única tecla. Gentileza, automatizada."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Botão de agradecimento %d"
L["BUTTON_EMOTE"] = "Expressão"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Define a expressão que este botão faz para o seu alvo, ou Nenhuma para não fazer expressão."
L["BUTTON_EMOTE_NONE"] = "Nenhuma"
-- Titles Thank You Button 1's emote checklist.
L["EMOTES_SELECT"] = "Selecionar expressões"
L["BUTTON_ICON"] = "Ícone"
L["BUTTON_ICON_DESCRIPTION"] =
	"Define o ícone que a macro deste botão mostra na sua lista de macros e nas suas barras de ação."
-- The Icon dropdown's first choice, the macros' own icon; every other choice is a picture alone.
L["BUTTON_ICON_DEFAULT"] = "Padrão"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Habilitar a macro "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "Cria uma macro chamada %s e a apaga quando você desativa esta opção."
L["BUTTON_WHISPER_DESCRIPTION"] =
	"Define o que este botão sussurra para o seu alvo. Deixe em branco para não enviar sussurro."

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks and each Thank You Button.
L["WHISPER_MESSAGE"] = "Mensagem de sussurro"
L["WHISPER_MESSAGE_RESET"] = "Redefinir"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Redefine a mensagem de sussurro para o texto padrão."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Valeu, você é demais! (="
-- TRANSLATORS: keep {spell} exactly as written; TFTB swaps in the buff's link.
L["DEFAULT_GIVE_THANKS_WHISPER"] = "Obrigado por {spell}"
