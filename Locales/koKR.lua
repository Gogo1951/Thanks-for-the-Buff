local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "koKR")
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
	"버전 %s. 설정(이 메시지를 비활성화하는 옵션 포함)은 옵션 > 애드온 > Thanks for the Buff (TFTB)에서 찾을 수 있습니다. 애드온이 마음에 드시나요? 친구에게 알려주세요! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "안전을 위해 전투 중에는 설정 인터페이스를 열 수 없습니다."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s님이 당신에게 %s 버프를 주었습니다!"
L["MESSAGE_GAVE_YOU"] = "%s님이 당신에게 %s(을)를 주었습니다!"
L["MESSAGE_GAVE_GROUP"] = "%s님이 파티에 %s(을)를 주었습니다!"
L["MESSAGE_USED_ITEM"] = "%s님이 당신에게 %s(을)를 사용했습니다!"
L["MESSAGE_USED_SPELL"] = "%s님이 당신에게 %s(을)를 시전했습니다!"
L["MESSAGE_SET_OUT"] = "%s님이 %s(을)를 꺼냈습니다!"
L["MESSAGE_OPENED"] = "%s님이 %s(을)를 열었습니다!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "%s 고맙습니다"
L["MESSAGE_SELECT_PLAYER"] = "감사할 플레이어를 선택하세요."
L["MESSAGE_CANT_THANK_SELF"] = "자신에게는 감사할 수 없습니다!"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "%s님이 %s(을)를 사용했습니다!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s님이 %s(을)를 %s님에게 사용했습니다!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "알 수 없는 주문"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "환영 메시지 활성화"
L["OPTIONS_WELCOME_DESCRIPTION"] = "접속할 때 대화창에 메시지를 출력합니다."
L["OPTIONS_DESCRIPTION"] =
	"버프를 준 플레이어에게 귓속말이나 감정 표현으로 자동으로 감사를 표하고, 마력 주입, 정신 자극, 영혼석처럼 내가 시전한 버프를 알립니다. 잔치, 차원문, 소환, 영혼샘, 같은 직업의 재사용 대기시간 기술 알림도 받을 수 있습니다. 매너도 자동으로."
L["OPTIONS_SUPPORT"] = "피드백 및 지원"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_VERSION"] = "버전 %s"
L["OPTIONS_FEATURES_HEADER"] = "기능"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "이 애드온의 설정 인터페이스를 엽니다."

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Stranger Buffs
L["TAB_STRANGERS"] = "낯선 사람의 버프"
L["STRANGERS_ENABLE"] = "낯선 사람의 버프에 감사 표시 활성화"
L["STRANGERS_ENABLE_DESCRIPTION"] = "파티 외부의 플레이어가 준 버프에 대한 감사 표시를 켭니다."
L["STRANGERS_DESCRIPTION"] = "야외에서 파티 외부의 플레이어가 버프를 주면 감사를 표합니다."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "감사 표시 대기시간"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"누가 버프를 주었든, 한 차례 감사 표시와 다음 감사 표시 사이의 대기시간을 설정합니다. 0으로 설정하면 모든 버프에 감사를 표합니다."
L["STRANGERS_SOURCE_COOLDOWN"] = "같은 플레이어 감사 표시 대기시간"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"같은 플레이어에게 감사를 표하는 사이의 대기시간을 설정합니다. 0으로 설정하면 모든 버프에 감사를 표합니다."
L["STRANGERS_MIN_DURATION"] = "최소 버프 지속시간"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"이보다 짧은 버프는 무시합니다. 0으로 설정하면 모든 버프에 반응합니다."

-- Teammate Buffs
L["TAB_TEAMMATES"] = "팀원의 버프"
L["TEAMMATES_ENABLE"] = "팀원의 버프에 감사 표시 활성화"
L["TEAMMATES_ENABLE_DESCRIPTION"] =
	"파티원이나 공격대원이 당신에게 시전한 버프와 재사용 대기시간 기술에 대한 감사 표시를 켭니다."
L["TEAMMATES_DESCRIPTION"] =
	"파티 및 공격대원이 당신에게 시전한 버프와 재사용 대기시간 기술에 감사를 표합니다."

-- Service Alerts
L["TAB_SERVICES"] = "지원 알림"
L["SERVICES_ENABLE"] = "지원 알림 활성화"
L["SERVICES_ENABLE_DESCRIPTION"] =
	"잔치, 영혼샘, 차원문 등 파티를 위해 설치된 도움에 대한 알림을 켭니다."
L["SERVICES_DESCRIPTION"] =
	"파티가 제공하는 공격대 전체 지원에 반응합니다. 잔치, 영혼샘, 차원문, 수리 로봇이 해당됩니다."

-- Send Good News
L["TAB_GOOD_NEWS"] = "좋은 소식 보내기"
L["GOOD_NEWS_DESCRIPTION"] =
	"당신이 버프한 플레이어에게 무엇을 시전했고 얼마나 지속되는지 알려줍니다."
L["GOOD_NEWS_WHISPER_ENABLE"] = "좋은 소식 활성화"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"당신이 버프를 걸어 준 플레이어에게 무엇을 얼마 동안 받았는지 귓속말로 알려줍니다."
L["GOOD_NEWS_SCOPE"] = "받는 대상"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "버프한 모든 대상"
L["GOOD_NEWS_SCOPE_GROUP"] = "파티/공격대 구성원만"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] =
	"좋은 소식 귓속말을 받을 대상을 설정합니다. 버프한 모든 대상 또는 파티나 공격대 구성원만 선택할 수 있습니다."
L["GOOD_NEWS_MESSAGES_HEADER"] = "좋은 소식 메시지"
--[[
    Two halves so the number stays authoritative: LIMIT's %d is a real placeholder
    and gets formatted, TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_LIMIT"] = "최대 길이는 %d입니다."
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a(은)는 기술 링크로 바뀝니다."
--[[
    Appended to the ability link inside %a when the buff has a readable duration.
    A whole clause rather than a bare number so it can be reworded per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "%s 동안"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "또래 압박"
L["PEER_PRESSURE_DESCRIPTION"] =
	"같은 직업의 다른 플레이어가 재사용 대기시간 기술을 사용하면 알림을 받아 또래 압박에 동참하세요."
L["PEER_PRESSURE_ENABLE"] = "또래 압박 활성화"
L["PEER_PRESSURE_ENABLE_DESCRIPTION"] =
	"같은 직업의 다른 플레이어가 추적 중인 재사용 대기시간 기술을 사용할 때의 알림을 켭니다."
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"같은 직업의 재사용 대기시간 기술이 사용되면 자신의 대화창에 메시지를 출력합니다. 자신만 볼 수 있습니다."
L["PEER_PRESSURE_OWN_CASTS"] = "자신의 시전에도 발동"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"다른 플레이어뿐 아니라 자신이 재사용 대기시간 기술을 사용할 때도 발동합니다."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"같은 직업의 재사용 대기시간 기술이 사용되면 효과음을 재생합니다. 자신에게만 들립니다."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "추적 중인 능력"
L["TRACKED_GROUP_ITEMS"] = "아이템"
L["TRACKED_TOGGLE_DESCRIPTION"] = "%s 추적을 켜거나 끕니다."
L["TRACKED_ITEM_PENDING"] = "아이템 #%d"
L["TRACKED_SPELL_PENDING"] = "주문 #%d"

-- Shared by Send Good News and the Thank You Button
L["WHISPER_MESSAGE"] = "귓속말 메시지"
L["WHISPER_MESSAGE_RESET"] = "초기화"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "귓속말 메시지를 기본 문구로 되돌립니다."

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "감사 메시지 및 감정 표현"
L["NOTIFICATIONS_HEADER"] = "알림"

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "감정 표현 선택"

L["PRAISE_WHISPER_ENABLE"] = "감사 귓속말 활성화"
L["PRAISE_WHISPER_DESCRIPTION"] = "버프를 준 플레이어에게 감사의 귓속말을 보냅니다."
L["PRAISE_EMOTES_ENABLE"] = "감정 표현 활성화"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"감정 표현으로 감사를 표합니다. 전투 중에는 감정 표현이 보류됩니다."
L["PRAISE_DELAY_ENABLE"] = "감사 표시 지연 활성화"
L["PRAISE_DELAY_DESCRIPTION"] =
	"귓속말과 감정 표현을 보내기 전에 잠시 기다려, 버프와 같은 순간에 감사가 전달되지 않도록 합니다. 알림은 영향을 받지 않습니다."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] =
	"귓속말과 감정 표현을 보내기 전에 기다릴 시간을 설정합니다."

L["NOTIFICATIONS_PRINT_ENABLE"] = "대화창 메시지 활성화"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"버프를 받을 때 자신의 대화창에 메시지를 출력합니다. 자신만 볼 수 있습니다."
L["NOTIFICATIONS_SOUND_ENABLE"] = "효과음 활성화"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] =
	"버프를 받을 때 효과음을 재생합니다. 자신에게만 들립니다."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] =
	"켜기 전에 미리 들어 볼 수 있도록 효과음을 재생합니다."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups that no single game record names
    (Data/{Game}/Tracked-Abilities-{Game}.lua). Single spells and items, and a
    group named after one of its own items, take their names from the client.
]]
L["GROUP_PORTALS"] = "차원문"
L["GROUP_RESISTANCE_CAULDRONS"] = "저항 가마솥"
L["GROUP_REPAIR_BOTS"] = "수리 로봇"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "감사 버튼"
L["BUTTON_DESCRIPTION"] =
	"예의를 자동으로. 버튼마다 현재 대상에게 귓속말을 보내고 감정 표현까지 함께 할 수 있습니다. 마법사에게 물을 부탁하고, 차원문에 감사를 전하고, 전투 중에 재빨리 도발해 준 친구를 칭찬하세요. 메시지는 한 번만 적어 두면 그다음부터는 키 하나면 됩니다."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "감사 버튼 %d"
L["BUTTON_EMOTE"] = "감정 표현"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"이 버튼이 대상에게 할 감정 표현을 설정합니다. 없음을 선택하면 감정 표현을 하지 않습니다."
L["BUTTON_EMOTE_NONE"] = "없음"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = '매크로 "%s" 활성화'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] =
	"%s(이)라는 이름의 매크로를 만들고, 이 설정을 끄면 다시 삭제합니다."
L["BUTTON_WHISPER_DESCRIPTION"] =
	"이 버튼이 대상에게 보낼 귓속말을 설정합니다. 비워 두면 귓속말을 보내지 않습니다."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "감사합니다, 최고예요! (="
--[[
    The star marker (left off on WoW Forever) and " // TFTB" sign-off are added
    by the builder, which also drops the closing punctuation; neither is part of
    the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "%a 버프를 받았습니다"

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "<Target>에게 환호합니다."
L["EMOTE_DRINK_DESCRIPTION"] = "<Target>을(를) 향해 건배합니다."
L["EMOTE_FLEX_DESCRIPTION"] = "<Target>에게 근육을 자랑합니다."
L["EMOTE_GRIN_DESCRIPTION"] = "<Target>에게 짓궂게 웃어 보입니다."
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "<Target>와(과) 하이파이브를 합니다."
L["EMOTE_PRAISE_DESCRIPTION"] = "<Target>을(를) 칭찬합니다."
L["EMOTE_SALUTE_DESCRIPTION"] = "<Target>에게 정중하게 경례합니다."
L["EMOTE_SMILE_DESCRIPTION"] = "<Target>을(를) 보며 미소 짓습니다."
L["EMOTE_THANK_DESCRIPTION"] = "<Target>에게 감사합니다."
L["EMOTE_WHOA_DESCRIPTION"] = "<Target>에게 '우와!'하고 외칩니다."
L["EMOTE_WINK_DESCRIPTION"] = "<Target>에게 윙크합니다."
L["EMOTE_YES_DESCRIPTION"] = "<Target>에게 고개를 끄덕입니다."
