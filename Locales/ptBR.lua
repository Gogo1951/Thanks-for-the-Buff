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
	"Versão %s. Configurações (incluindo a opção de desativar esta mensagem) podem ser encontradas em Opções > AddOns > Thanks for the Buff (TFTB). Gostando do add-on? Conte a um amigo! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por precaução, a interface de opções não pode ser aberta durante o combate."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s buffou você com %s!"
L["MESSAGE_GAVE_YOU"] = "%s deu %s a você!"
L["MESSAGE_GAVE_GROUP"] = "%s deu %s ao seu grupo!"
L["MESSAGE_USED_ITEM"] = "%s usou %s em você!"
L["MESSAGE_USED_SPELL"] = "%s lançou %s em você!"
L["MESSAGE_SET_OUT"] = "%s colocou %s!"
L["MESSAGE_OPENED"] = "%s abriu %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Obrigado por %s"
L["MESSAGE_SELECT_PLAYER"] = "Selecione um jogador para agradecer."
L["MESSAGE_CANT_THANK_SELF"] = "Você não pode agradecer a si mesmo!"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "%s usou %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s usou %s em %s!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Feitiço desconhecido"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensagem de boas-vindas"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Exibe uma mensagem no chat quando você entra no jogo."
L["OPTIONS_DESCRIPTION"] =
	"Agradeça automaticamente, com um sussurro ou uma expressão, aos jogadores que dão buffs a você e anuncie os buffs que você lança, como Infusão de Poder, Avivar e Pedra da Alma. Receba também avisos de banquetes, portais, invocações, poços de almas e recargas da sua classe. Boas maneiras, no automático."
L["OPTIONS_SUPPORT"] = "Feedback e suporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_VERSION"] = "Versão %s"
L["OPTIONS_FEATURES_HEADER"] = "Recursos"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre a interface de opções deste add-on."

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Stranger Buffs
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

-- Teammate Buffs
L["TAB_TEAMMATES"] = "Buffs de colegas de equipe"
L["TEAMMATES_ENABLE"] = "Habilitar agradecimentos por buffs de colegas de equipe"
L["TEAMMATES_ENABLE_DESCRIPTION"] =
	"Ativa os agradecimentos pelos buffs e habilidades com recarga que os membros do seu grupo ou raide lançam em você."
L["TEAMMATES_DESCRIPTION"] =
	"Agradeça aos membros do grupo e da raide pelos buffs e habilidades com recarga que eles lançam em você."

-- Service Alerts
L["TAB_SERVICES"] = "Avisos de serviços"
L["SERVICES_ENABLE"] = "Habilitar avisos de serviços"
L["SERVICES_ENABLE_DESCRIPTION"] =
	"Ativa os avisos de banquetes, poços de almas, portais e outras ajudas colocadas para o seu grupo."
L["SERVICES_DESCRIPTION"] =
	"Reaja à ajuda que o seu grupo oferece para toda a raide: banquetes, poços de almas, portais e robôs de reparo."

-- Send Good News
L["TAB_GOOD_NEWS"] = "Enviar boas notícias"
L["GOOD_NEWS_DESCRIPTION"] = "Avise os jogadores que você buffa sobre o que lançou neles e quanto tempo dura."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Habilitar boas notícias"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"Sussurra para o jogador que você buffou dizendo o que ele recebeu e por quanto tempo."
L["GOOD_NEWS_SCOPE"] = "Destinatários"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Qualquer um que você buffar"
L["GOOD_NEWS_SCOPE_GROUP"] = "Apenas membros do grupo"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Define quem recebe um sussurro de boas notícias: qualquer um que você buffar ou apenas o seu grupo ou raide."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Mensagem de boas notícias"
--[[
    Two halves so the number stays authoritative: LIMIT's %d is a real placeholder
    and gets formatted, TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_LIMIT"] = "Comprimento máximo: %d."
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a vira o link da habilidade."
--[[
    Appended to the ability link inside %a when the buff has a readable duration.
    A whole clause rather than a bare number so it can be reworded per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "por %s"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Pressão do grupo"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Receba um aviso quando outros jogadores da sua classe usarem suas habilidades com recarga, para você ceder à pressão do grupo."
L["PEER_PRESSURE_ENABLE"] = "Habilitar pressão do grupo"
L["PEER_PRESSURE_ENABLE_DESCRIPTION"] =
	"Ativa os avisos quando outro jogador da sua classe usa uma habilidade com recarga rastreada."
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Exibe uma mensagem no seu próprio chat quando uma habilidade com recarga da sua classe é usada. Só você vê."
L["PEER_PRESSURE_OWN_CASTS"] = "Ativar com seus próprios feitiços"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Também dispara quando você usa suas próprias habilidades com recarga, não só quando outros jogadores usam as deles."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"Toca um som quando uma habilidade com recarga da sua classe é usada. Só você ouve."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Habilidades rastreadas"
L["TRACKED_GROUP_ITEMS"] = "Itens"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Ativa ou desativa o rastreamento de %s."
L["TRACKED_ITEM_PENDING"] = "Item nº %d"
L["TRACKED_SPELL_PENDING"] = "Feitiço nº %d"

-- Shared by Send Good News and the Thank You Button
L["WHISPER_MESSAGE"] = "Mensagem de sussurro"
L["WHISPER_MESSAGE_RESET"] = "Redefinir"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Redefine a mensagem de sussurro para o texto padrão."

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "Mensagens de agradecimento e expressões"
L["NOTIFICATIONS_HEADER"] = "Notificações"

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

L["NOTIFICATIONS_PRINT_ENABLE"] = "Habilitar mensagens de chat"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"Exibe uma mensagem no seu próprio chat quando você recebe um buff. Só você vê."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Habilitar efeitos sonoros"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Toca um som quando você recebe um buff. Só você ouve."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Toca o som para você ouvi-lo antes de ativá-lo."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups that no single game record names
    (Data/{Game}/Tracked-Abilities-{Game}.lua). Single spells and items, and a
    group named after one of its own items, take their names from the client.
]]
L["GROUP_PORTALS"] = "Portais"
L["GROUP_RESISTANCE_CAULDRONS"] = "Caldeirões de Resistência"
L["GROUP_REPAIR_BOTS"] = "Robôs de Reparo"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Botão de agradecimento"
L["BUTTON_DESCRIPTION"] =
	"Gentileza, automatizada. Cada botão sussurra para o seu alvo atual e ainda pode fazer uma expressão para ele: pedir água a um mago, agradecer por um portal, elogiar um amigo no meio da luta por aquela provocação na hora certa. Escreva a mensagem uma vez e a partir daí é só uma tecla."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Botão de agradecimento %d"
L["BUTTON_EMOTE"] = "Expressão"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"Define a expressão que este botão faz para o seu alvo, ou Nenhuma para não fazer expressão."
L["BUTTON_EMOTE_NONE"] = "Nenhuma"
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
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Valeu, você é demais! (="
--[[
    The star marker (left off on WoW Forever) and " // TFTB" sign-off are added
    by the builder, which also drops the closing punctuation; neither is part of
    the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "Você tem %a"

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
