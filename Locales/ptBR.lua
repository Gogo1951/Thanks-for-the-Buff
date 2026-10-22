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
-- Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"Versão %s. As configurações (incluindo a opção de desativar esta mensagem) ficam em Opções > AddOns > Thanks for the Buff (TFTB). Gostando deste add-on? Conte a um amigo, favorite-o no CurseForge ou dê uma Star no GitHub. (="
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
L["MESSAGE_SELECT_PLAYER"] = "Primeiro, selecione um jogador como alvo."
L["MESSAGE_CANT_THANK_SELF"] = "Você não pode agradecer a si mesmo!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Feitiço desconhecido"

--------------------------------------------------------------------------------
-- Mini-map Button
--------------------------------------------------------------------------------

L["MINIMAP_OPTIONS"] = "Opções do Thanks for the Buff (TFTB)"
L["LEFT_CLICK"] = "Clique esquerdo"
L["RIGHT_CLICK"] = "Clique direito"
L["SHIFT_LEFT_CLICK"] = "Shift + Clique esquerdo"
L["SHIFT_RIGHT_CLICK"] = "Shift + Clique direito"
L["SHIFT_MIDDLE_CLICK"] = "Shift + Clique do meio"
L["ACTION_TOGGLE"] = "Alternar"
L["ENABLED"] = "Ativado"
L["DISABLED"] = "Desativado"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Habilitar mensagem de boas-vindas"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Exibe uma mensagem que só você vê quando entra no jogo."
L["OPTIONS_ENABLE_MINIMAP"] = "Ativar botão do minimapa"
L["OPTIONS_ENABLE_MINIMAP_DESCRIPTION"] =
	"Mostra o botão do TFTB no seu minimapa, que liga e desliga recursos com um clique."
L["OPTIONS_DESCRIPTION"] =
	"Agradeça automaticamente com um sussurro ou uma expressão a cada jogador que der um buff em você, e nunca deixe faltar buff na sua raide, em você e nas suas armas, com um lembrete de buffs em falta em que basta um clique para lançá-los. E ainda avisos de banquetes, portais, invocações e poços de almas. Boas maneiras, no automático."
L["OPTIONS_FEATURES_HEADER"] = "Recursos"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Ative ou desative cada recurso aqui ou no painel dele."
L["OPTIONS_FEATURES_NOTE"] =
	'Alguns dos nossos recursos mais novos, como "%s", vão além do escopo tradicional do "Thanks for the Buff". Fique à vontade para desativar o que você não precisa. Esses recursos podem ir para nosso outro add-on, "Connoisseur & Restocker", ou tudo pode se juntar em um add-on maior, talvez "Buttons, Buffs, & Bags". Conte o que você acha no Discord, CurseForge ou GitHub. Obrigado!'
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre a interface de opções deste add-on."
L["OPTIONS_EXAMPLE"] = "Exemplo: %s"

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
	"Reaja quando alguém disponibiliza ajuda para o seu grupo: banquetes, poços de almas, portais e robôs de reparo."

-- Send Good News
L["TAB_GOOD_NEWS"] = "Enviar boas notícias"
L["GOOD_NEWS_DESCRIPTION"] =
	"Avise os jogadores que você buffa sobre o que lançou neles e, nos buffs curtos, quanto tempo dura."
L["GOOD_NEWS_ENABLE"] = "Habilitar boas notícias"
L["GOOD_NEWS_ENABLE_DESCRIPTION"] = "Ativa um sussurro que conta aos jogadores que você buffa o que lançou neles."
L["GOOD_NEWS_SCOPE"] = "Destinatários"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Qualquer um que você buffar"
L["GOOD_NEWS_SCOPE_GROUP"] = "Apenas membros do grupo"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"Define quem recebe um sussurro de boas notícias: qualquer um que você buffar ou apenas os membros do seu grupo."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Mensagem de boas notícias"
L["GOOD_NEWS_MESSAGES_DESCRIPTION"] = "O sussurro que os jogadores que você buffa recebem."
--[[
    The message box's tooltip, in three parts. LIMIT's %d is a real placeholder
    and gets formatted; TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_INPUT_DESCRIPTION"] = "Define o que o sussurro diz. Deixe em branco para usar o texto padrão."
L["GOOD_NEWS_MESSAGE_LIMIT"] = "Comprimento máximo: %d."
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a vira o link da habilidade, com a duração quando ela é menor que um minuto."
--[[
    Appended to the ability link inside %a when the buff has a readable duration
    under a minute. A whole clause rather than a bare number so it can be reworded
    per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "por %s"

-- Peer Pressure (TEMPORARY: delete on or after 2026-11-21, with Options/Options-Peer-Pressure.lua)
L["TAB_PEER_PRESSURE"] = "Pressão do grupo"
L["PEER_PRESSURE_CONTROL_FREAK"] = "Control Freak"
L["PEER_PRESSURE_MOVED"] =
	'O WoW Forever não deixa os add-ons lerem o registro de combate, então estamos reorganizando nossos add-ons para funcionarem do mesmo jeito em todas as versões do jogo. A "Pressão do grupo" foi para nosso outro add-on, "Control Freak". Instale-o para continuar recebendo alertas quando jogadores da sua classe usarem suas recargas.'

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Habilidades rastreadas"
L["TRACKED_GROUP_ITEMS"] = "Itens"
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
    sees, then what only you get. Key prefixes match the header the control
    appears under.
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
-- Options: Buff Duty
--------------------------------------------------------------------------------

L["TAB_BUFF_WINDOW"] = "Plantão de buffs"
L["BUFF_WINDOW_DESCRIPTION"] = "Mostra quem está sem os seus buffs. Clique em um ícone para lançar."
L["BUFF_WINDOW_ENABLE"] = "Habilitar plantão de buffs"
L["BUFF_WINDOW_ENABLE_DESCRIPTION"] =
	"Ativa o plantão de buffs, a janela de membros do grupo sem um buff que você pode dar."
L["BUFF_WINDOW_NO_BUFFS"] = "Sua classe não tem buffs nesta lista, então a janela nunca aparece neste personagem."
-- When to Show: Solo and In Group, each with Always or In Instance, then the classes.
L["BUFF_WINDOW_WHEN_HEADER"] = "Quando mostrar"
L["BUFF_WINDOW_WHEN_DESCRIPTION"] = "Escolha quando a janela pode aparecer."
L["BUFF_WINDOW_WHEN_SOLO"] = "Sozinho"
L["BUFF_WINDOW_WHEN_SOLO_DESCRIPTION"] = "Mostra a janela quando você não está em grupo ou raide."
L["BUFF_WINDOW_WHEN_GROUP"] = "Em grupo"
L["BUFF_WINDOW_WHEN_GROUP_DESCRIPTION"] = "Mostra a janela quando você está em grupo ou raide."
L["BUFF_WINDOW_WHERE_DESCRIPTION"] =
	"Define onde a janela aparece: em qualquer lugar, ou só dentro de masmorras, raides, campos de batalha e arenas."
L["BUFF_WINDOW_WHERE_ALWAYS"] = "Sempre"
L["BUFF_WINDOW_WHERE_INSTANCE"] = "Em instância"
L["BUFF_WINDOW_CLASSES_DESCRIPTION"] = "Mostra a janela quando você joga com estas classes."
L["BUFF_WINDOW_CLASS_DESCRIPTION"] = "Mostra a janela quando você joga com esta classe."
L["BUFF_WINDOW_HEADER"] = "Janela"
L["BUFF_WINDOW_WINDOW_DESCRIPTION"] = "Mantenha a janela onde você a deixou, ou tire-a do caminho em combate."
L["BUFF_WINDOW_LOCK"] = "Travar janela"
L["BUFF_WINDOW_LOCK_DESCRIPTION"] = "Impede que a janela seja movida. Destravada, arraste-a pelo fundo."
L["BUFF_WINDOW_HIDE_IN_COMBAT"] = "Ocultar em combate"
L["BUFF_WINDOW_HIDE_IN_COMBAT_DESCRIPTION"] =
	"Oculta a janela durante o combate. A lista não pode ser atualizada em combate, então uma janela deixada à mostra mantém o último estado até o combate terminar."
L["BUFF_WINDOW_SHOW_HEADER"] = "Mostrar na janela"
L["BUFF_WINDOW_SHOW_DESCRIPTION"] =
	"Adicione à janela os seus próprios buffs, os estranhos que buffaram você e o seu alvo."
L["BUFF_WINDOW_FAVOR_ENABLE"] = "Retribuir o favor"
L["BUFF_WINDOW_FAVOR_ENABLE_DESCRIPTION"] =
	"Lista os estranhos que buffaram você recentemente, com os buffs que você pode devolver a eles. Clique com o botão direito em um ícone para tirar alguém da lista."
L["BUFF_WINDOW_FAVOR_SECONDS_DESCRIPTION"] =
	"Define por quanto tempo um estranho fica na lista após o último buff dele."
L["BUFF_WINDOW_TARGET_ENABLE"] = "Seu alvo"
L["BUFF_WINDOW_TARGET_ENABLE_DESCRIPTION"] =
	"Lista o seu alvo quando ele é um jogador de fora do seu grupo sem um buff que você pode dar."
L["BUFF_WINDOW_REFRESH"] = "Renovar abaixo de"
L["BUFF_WINDOW_REFRESH_DESCRIPTION"] =
	"Define com quanto tempo restante um buff passa a contar como ausente, para que você possa renová-lo antes que ele acabe. Um buff que não dura mais do que isso só conta depois que acaba."
-- Count as Tanks: one dropdown per class, then Pets, each with these three choices.
L["BUFF_WINDOW_TANKS_HEADER"] = "Contar como tanques"
L["BUFF_WINDOW_TANKS_DESCRIPTION"] =
	"Quem recebe os buffs que você oferece a Tanques, como Espinhos, quando não tem uma função própria."
L["BUFF_WINDOW_TANKS_CLASS_DESCRIPTION"] =
	"Define quando os jogadores desta classe contam como tanques. Uma função de tanque ou curador que eles tenham sempre vem primeiro."
L["BUFF_WINDOW_TANKS_PETS"] = "Mascotes"
L["BUFF_WINDOW_TANKS_PETS_DESCRIPTION"] =
	"Define quando os mascotes contam como tanques. Os mascotes também recebem os buffs que você oferece a Todos."
L["BUFF_WINDOW_TANKS_NEVER"] = "Nunca"
L["BUFF_WINDOW_TANKS_SOLO"] = "Quando não estiver em grupo"
L["BUFF_WINDOW_TANKS_ALWAYS"] = "Sempre"
-- Who each buff is offered to: one dropdown per buff, these four choices.
L["BUFF_WINDOW_AUDIENCE_OFF"] = "Desativado"
L["BUFF_WINDOW_AUDIENCE_TANK"] = "Tanques"
L["BUFF_WINDOW_AUDIENCE_HEALER"] = "Curadores"
L["BUFF_WINDOW_AUDIENCE_ALL"] = "Todos"
-- Each buff's dropdown tooltip; hovering the buff's name shows the spell itself.
L["BUFF_WINDOW_AUDIENCE_DESCRIPTION"] = "Define para quem oferecer %s."
L["BUFF_WINDOW_BUFFS_DESCRIPTION"] =
	"Escolha para quem cada buff é oferecido. Tanques e Curadores seguem a função no grupo; quem não tiver uma conta como Dano, a menos que Contar como tanques, abaixo, diga o contrário."

L["BUFF_WINDOW_SELF_DESCRIPTION"] = "Seus próprios buffs, fixados no topo da janela."
--[[
    Muted note after a class name on the Self-Buffs panel, for a family of self
    buffs only one of which can be up at a time. Keyed by the family.
]]
L["BUFF_WINDOW_SELF_NOTE_ASPECT"] = "qualquer aspecto conta"
L["BUFF_WINDOW_SELF_NOTE_MAGE_ARMOR"] = "qualquer armadura conta"
L["BUFF_WINDOW_SELF_NOTE_PALADIN_AURA"] = "qualquer aura conta"
L["BUFF_WINDOW_SELF_NOTE_SHAMAN_SHIELD"] = "qualquer escudo conta"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_ARMOR"] = "qualquer armadura conta"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_DEMON"] = "qualquer um dos dois bônus demoníacos conta"
L["BUFF_WINDOW_SELF_REFRESH_OFF"] = "Desativado"
L["BUFF_WINDOW_SELF_REFRESH_MISSING"] = "Quando faltar"
-- %s is a duration from the client, like "5 Minutes".
L["BUFF_WINDOW_SELF_REFRESH_UNDER"] = "Menos de %s"
L["BUFF_WINDOW_SELF_REFRESH_DESCRIPTION"] =
	"Define quando %s aparece: nunca, quando acabar ou quando restar menos que esse tempo."
-- The Weapon Buffs panel, under Buff Duty after Self-Buffs.
L["BUFF_WINDOW_WEAPON_PANEL_HEADER"] = "Buffs de arma"
L["BUFF_WINDOW_WEAPON_DESCRIPTION"] =
	"Marque o que cada arma deve ter. A janela oferece quando estiver faltando ou acabando, se estiver nas suas bolsas e servir na arma."
-- The one timing for every weapon buff, at the top of the panel.
L["BUFF_WINDOW_WEAPON_REFRESH"] = "Reaplicar"
L["BUFF_WINDOW_WEAPON_REFRESH_DESCRIPTION"] =
	"Define quando um buff de arma é oferecido de novo: quando acabar ou quando restar menos que esse tempo."
-- The boxes for the weapon items any class can use, after the rogue and shaman boxes.
L["BUFF_WINDOW_WEAPON_KIND_OIL"] = "Óleos"
L["BUFF_WINDOW_WEAPON_KIND_STONE"] = "Pedras"
L["BUFF_WINDOW_WEAPON_KIND_LURE"] = "Iscas"
--[[
    One choice's checkbox under one hand. The first %s is the poison, imbue,
    oil, stone or lure, the second the client's "Main Hand" or "Off Hand".
]]
L["BUFF_WINDOW_WEAPON_PICK_DESCRIPTION"] =
	"Oferece %s para a sua arma (%s). Enquanto a arma não tiver nenhuma das opções marcadas, cada uma que você tiver é oferecida."
L["BUFF_WINDOW_SELF_ENABLE"] = "Seus buffs próprios"
L["BUFF_WINDOW_SELF_ENABLE_DESCRIPTION"] =
	"Mostra no topo da janela os buffs que só você pode lançar em si mesmo, como uma armadura ou Fogo Interior, quando estão faltando ou acabando. Escolha quais em Buffs próprios."
L["BUFF_WINDOW_WEAPON_ENABLE"] = "Seus buffs de arma"
L["BUFF_WINDOW_WEAPON_ENABLE_DESCRIPTION"] =
	"Mostra os venenos, imbuições, óleos, pedras e iscas que estão faltando ou acabando nas suas armas, junto com seus buffs próprios no topo da janela. Clique em um para aplicá-lo. Escolha quais em Buffs de arma."

-- The window itself
L["BUFF_WINDOW_SELF_HEADER"] = "Buffs próprios"
L["BUFF_WINDOW_FAVOR_HEADER"] = "Retribuir o favor"
L["BUFF_WINDOW_TARGET_HEADER"] = "Alvo"
L["BUFF_WINDOW_TOOLTIP_CAST"] = "Clique para lançar em %s."
-- %s is the client's "Main Hand" or "Off Hand".
L["BUFF_WINDOW_TOOLTIP_WEAPON"] = "Clique para aplicar na sua arma (%s)."
L["BUFF_WINDOW_TOOLTIP_USE"] = "Ninguém no seu grupo tem uma Pedra da Alma. Clique para usar uma em %s."
L["BUFF_WINDOW_TOOLTIP_CREATE"] = "Ninguém no seu grupo tem uma Pedra da Alma. Clique para criar uma."
L["BUFF_WINDOW_TOOLTIP_GROUP"] = "Clique para lançar em %s e no grupo dele."
L["BUFF_WINDOW_TOOLTIP_FAVOR"] = "Clique para selecionar %s como alvo e lançar."
L["BUFF_WINDOW_TOOLTIP_DISMISS"] = "Clique com o botão direito para tirar %s da lista."
-- The window's close button: the class name in its color, then the options command.
L["BUFF_WINDOW_CLOSED"] =
	"Plantão de buffs está desligado para a classe %s. Para ligá-lo de novo, use Shift + Clique direito no botão do minimapa ou digite %s."

-- The Buff Key (Key Bindings, and the Keybinds section of Buff Duty)
L["BUFF_KEYS_HEADER"] = "Atalhos"
L["BUFF_KEYS_DESCRIPTION"] =
	"Lance o próximo buff da sua lista com uma tecla ou macro, fora de combate. Os buffs de arma continuam sendo um clique na janela."
L["BUFF_KEY"] = "Botão de buff"
L["BUFF_KEY_DESCRIPTION"] =
	"Lança seu próximo buff em falta, um por toque: uma ressurreição no seu alvo morto, depois nos mortos do seu grupo (sacerdotes, paladinos e xamãs), depois seus buffs próprios, Retribuir o favor, seu alvo e seu grupo. Um grupo recebe o buff de grupo quando ele custa menos mana do que buffar um por um todos ao alcance."
L["BUFF_KEY_SKIP_COOLDOWNS"] = "Pular buffs com tempo de recarga"
L["BUFF_KEY_SKIP_COOLDOWNS_DESCRIPTION"] =
	"Ignora buffs com tempo de recarga, como Proteção contra Medo, e passa para o próximo."
-- %s is a player's name.
L["BUFF_KEY_WAITING"] = "Esperando %s chegar ao alcance."
L["BUFF_KEY_DONE"] = "Nada mais para buffar."
-- The caption beside the read-only box that holds a Buff Key's macro line.
L["BUFF_KEY_MACRO_CAPTION"] = "Macro"

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
