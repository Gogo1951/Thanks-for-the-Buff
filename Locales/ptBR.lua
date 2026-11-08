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

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Obrigado por %s"
L["MESSAGE_SELECT_PLAYER"] = "Primeiro, selecione um jogador como alvo."
L["MESSAGE_CANT_THANK_SELF"] = "Você não pode agradecer a si mesmo!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Feitiço desconhecido"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensagem de boas-vindas"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Exibe uma mensagem que só você vê quando entra no jogo."
L["OPTIONS_DESCRIPTION"] =
	"Agradeça automaticamente com um sussurro ou uma expressão a cada jogador que der um buff em você, e agradeça a qualquer um manualmente com um clique nas suas macros de agradecimento. Boas maneiras, no automático."
L["OPTIONS_FEATURES_HEADER"] = "Recursos"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Ative ou desative cada recurso aqui ou no painel dele."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre a interface de opções deste add-on."
L["SAMPLE_EXAMPLE"] = "Exemplo: %s"

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
-- Options: Stranger Buffs
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Buffs de estranhos"
L["STRANGERS_ENABLE"] = "Habilitar agradecimentos por buffs de estranhos"
L["STRANGERS_ENABLE_DESCRIPTION"] = "Ativa os agradecimentos por buffs de jogadores de fora do seu grupo."
L["STRANGERS_DESCRIPTION"] = "Agradeça aos jogadores de fora do seu grupo quando eles buffarem você no mundo aberto."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "Recarga dos agradecimentos"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Define o intervalo entre uma rodada de agradecimentos e a próxima, não importa quem buffou você. Defina como zero para agradecer todos os buffs."
L["STRANGERS_SOURCE_COOLDOWN"] = "Recarga de agradecimento ao mesmo jogador"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Define o intervalo entre agradecimentos dirigidos ao mesmo jogador. Defina como zero para agradecer todos os buffs."
L["STRANGERS_MIN_DURATION"] = "Duração mínima do buff"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"Ignora buffs com duração menor que este valor. Defina como zero para reagir a todos os buffs."

--------------------------------------------------------------------------------
-- Options: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers the Stranger Buffs panel is built from: what the
    other player sees, then what only you get. Key prefixes match the header
    the control appears under.
]]
L["PRAISE_HEADER"] = "Sussurros de agradecimento e expressões"
L["NOTIFICATIONS_HEADER"] = "Notificações"
L["PRAISE_DESCRIPTION"] = "O que o outro jogador vê: um sussurro de agradecimento, uma expressão ou ambos."
L["NOTIFICATIONS_DESCRIPTION"] = "O que só você recebe: um aviso de texto, um som ou ambos."

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "Selecionar expressões"

L["PRAISE_WHISPER_ENABLE"] = "Habilitar sussurros de agradecimento"
L["PRAISE_WHISPER_DESCRIPTION"] = "Sussurra um agradecimento ao jogador que buffou você."
L["PRAISE_EMOTES_ENABLE"] = "Habilitar expressões"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"Mostra sua gratidão com uma expressão. As expressões ficam retidas enquanto você está em combate."
L["PRAISE_DELAY_ENABLE"] = "Habilitar atraso do agradecimento"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Espera um momento antes do sussurro e da expressão, para que seu agradecimento não chegue no mesmo instante que o buff. As notificações não são afetadas."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Define quanto tempo esperar antes de enviar o sussurro e a expressão."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Habilitar avisos de texto"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Exibe uma mensagem que só você vê quando recebe um buff."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Habilitar efeitos sonoros"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Toca um som quando você recebe um buff. Só você ouve."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Toca o som para você ouvi-lo antes de ativá-lo."

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

-- Each button's whisper box
L["WHISPER_MESSAGE"] = "Mensagem de sussurro"
L["WHISPER_MESSAGE_RESET"] = "Redefinir"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Redefine a mensagem de sussurro para o texto padrão."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Valeu, você é demais! (="

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
