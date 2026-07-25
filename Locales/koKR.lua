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
	"버전 %s. 설정(이 메시지를 비활성화하는 옵션 포함)은 옵션 > 애드온 > Thanks for the Buff 에서 찾을 수 있습니다. 애드온이 마음에 드시나요? 친구에게 알려주세요! (="

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s님이 당신에게 %s 버프를 주었습니다!"
L["MESSAGE_GAVE_YOU"] = "%s님이 당신에게 %s(을)를 주었습니다!"
L["MESSAGE_GAVE_GROUP"] = "%s님이 파티에 %s(을)를 주었습니다!"
L["MESSAGE_USED_ITEM"] = "%s님이 당신에게 %s %s(을)를 사용했습니다!"
L["MESSAGE_USED_SPELL"] = "%s님이 당신에게 %s(을)를 사용했습니다!"
L["MESSAGE_SET_OUT"] = "%s님이 %s(을)를 꺼냈습니다!"
L["MESSAGE_OPENED"] = "%s님이 %s(을)를 열었습니다!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "%s 고맙습니다!"
L["MESSAGE_GOOD_NEWS_DURATION"] = "좋은 소식! %s 버프가 %s 동안 지속됩니다!"
L["MESSAGE_GOOD_NEWS"] = "좋은 소식! %s 버프를 받았습니다!"
L["MESSAGE_PEER_PRESSURE"] = "%s님이 %s을(를) 사용했습니다!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s님이 %s을(를) %s님에게 사용했습니다!"
L["MESSAGE_SELECT_PLAYER"] = "감사할 플레이어를 선택하세요."
L["MESSAGE_CANT_THANK_SELF"] = "자신에게는 감사할 수 없습니다!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MESSAGE_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "그의"
L["PRONOUN_HER"] = "그녀의"
L["PRONOUN_THEIR"] = "그들의"
L["UNKNOWN_SPELL"] = "알 수 없는 주문"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "환영 메시지 활성화"
L["OPTIONS_WELCOME_DESCRIPTION"] = "접속할 때 대화창에 메시지를 출력합니다."
L["OPTIONS_DESCRIPTION"] =
	"야외의 낯선 사람이든 Power Infusion이나 Innervate 같은 팀원의 재사용 대기시간 기술이든, 당신에게 버프를 준 플레이어에게 감정표현, 귓속말, 대화창 알림으로 자동으로 감사를 표합니다. 잔치, 차원문, 같은 직업의 재사용 대기시간 기술도 알려줍니다."
L["OPTIONS_SUPPORT"] = "피드백 및 지원"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMAND_TFTB"] = "/tftb"
L["OPTIONS_COMMAND_TFTB_DESCRIPTION"] = "Thanks for the Buff 설정 인터페이스를 엽니다."
L["OPTIONS_COMMAND_THANKYOU"] = "/thankyou"
L["OPTIONS_COMMAND_THANKYOU_DESCRIPTION"] = "현재 대상에게 감정표현을 하고 귓속말을 보냅니다."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "낯선 사람의 버프"
L["STRANGERS_DESCRIPTION"] = "파티 외부(야외)의 플레이어가 당신에게 주는 버프입니다."
L["STRANGERS_OVERALL_COOLDOWN"] = "감사 표시 대기시간 (초)"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"누구에게 버프를 받았든 상관없이 감사를 표하는 최대 빈도입니다.\n\n0으로 설정하면 이 제한이 꺼집니다. 알림은 영향을 받지 않습니다."
L["STRANGERS_SOURCE_COOLDOWN"] = "플레이어별 감사 표시 대기시간 (초)"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"동일한 플레이어에게 감사를 표하는 최대 빈도입니다.\n\n알림은 영향을 받지 않습니다."
L["STRANGERS_MIN_DURATION"] = "최소 버프 지속시간 (초)"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"반응할 가치가 있으려면 버프가 지속되어야 하는 최소 시간입니다.\n\n소생이나 회복과 같은 짧은 지속 치유는 무시합니다. 알림도 영향을 받으며, 이보다 짧은 버프는 메시지, 효과음, 귓속말, 감정표현 없이 완전히 무시됩니다."

--------------------------------------------------------------------------------
-- Options: Combat Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "팀원의 버프"
L["TEAMMATES_DESCRIPTION"] =
	"파티 또는 공격대원이 당신에게 시전하는 버프나 재사용 대기시간 기술입니다."

-- Group Services
L["TAB_SERVICES"] = "그룹 서비스"
L["SERVICES_DESCRIPTION"] =
	"파티 또는 공격대원이 제공하는 공격대 전체를 위한 도움: 잔치, 영혼샘, 차원문, 수리 로봇."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "좋은 소식"
L["GOOD_NEWS_DESCRIPTION"] =
	"당신이 버프한 플레이어에게 무엇을 시전했고 얼마나 지속되는지 알려줍니다."
L["GOOD_NEWS_WHISPER_ENABLE"] = "좋은 소식 활성화"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] =
	"버프를 시전한 플레이어에게 무엇을 얼마 동안 받았는지 귓속말로 알립니다."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "버프한 모든 대상"
L["GOOD_NEWS_SCOPE_GROUP"] = "파티/공격대 구성원만"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "또래 압박"
L["PEER_PRESSURE_DESCRIPTION"] =
	"같은 직업의 다른 플레이어가 재사용 대기시간 기술을 사용하면 알림을 받아 또래 압박에 동참하세요."
L["PEER_PRESSURE_ENABLE"] = "Peer Pressure 활성화"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"같은 직업의 기술이 사용되면 자신의 대화창에 메시지를 출력합니다. 자신만 볼 수 있습니다."
L["PEER_PRESSURE_OWN_CASTS"] = "자신의 시전에도 발동"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"다른 플레이어뿐 아니라 자신이 재사용 대기시간 기술을 사용할 때도 알림이 발동합니다."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] =
	"같은 직업의 기술이 사용되면 효과음을 재생합니다. 자신에게만 들립니다."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "추적 중인 능력"
L["COMBAT_GROUP_ITEMS"] = "아이템"
L["COMBAT_TOGGLE_TRACKING"] = "%s에 대한 추적 켜기/끄기"
L["COMBAT_ITEM_PENDING"] = "아이템 #%d"
L["COMBAT_SPELL_PENDING"] = "주문 #%d"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

-- The two section headers every buff panel is built from: what the other player
-- sees, then what only you get. Peer Pressure sends nothing outward, so it
-- carries the Notifications header alone. Key prefixes match the header the
-- control appears under.
L["PRAISE_HEADER"] = "감사 메시지 및 감정표현"
L["NOTIFICATIONS_HEADER"] = "알림"

L["PRAISE_WHISPER_ENABLE"] = "감사 귓속말 활성화"
L["PRAISE_WHISPER_DESCRIPTION"] = "버프를 준 플레이어에게 감사의 귓속말을 보냅니다."
L["PRAISE_EMOTES_ENABLE"] = "감정표현 활성화 (비전투 시)"
L["PRAISE_EMOTES_DESCRIPTION"] =
	"감정표현으로 감사를 표합니다. 전투 중에는 감정표현이 보류됩니다."
L["PRAISE_EMOTES_SELECT"] = "감정표현 선택"
L["PRAISE_DELAY_ENABLE"] = "감사 표시 지연 활성화"
L["PRAISE_DELAY_DESCRIPTION"] =
	"귓속말과 감정표현 전에 잠시 기다려, 버프와 같은 순간에 감사가 전달되지 않도록 합니다.\n\n알림은 영향을 받지 않습니다."
L["PRAISE_DELAY_LENGTH"] = "지연 시간"
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] =
	"버프를 준 플레이어에게 감사를 표하기 전에 기다릴 시간입니다."

L["NOTIFICATIONS_PRINT_ENABLE"] = "출력 메시지 활성화"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] =
	"버프를 받을 때 자신의 대화창에 메시지를 출력합니다. 자신만 볼 수 있습니다."
L["NOTIFICATIONS_SOUND_ENABLE"] = "효과음 활성화"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] =
	"버프를 받을 때 효과음을 재생합니다. 자신에게만 들립니다."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

-- Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
-- spells and items take their names from the client and need no key here.
L["GROUP_PORTALS"] = "차원문"
L["GROUP_SOULSTONE"] = "영혼석"
L["GROUP_RESISTANCE_CAULDRONS"] = "저항 가마솥"
L["GROUP_SCROLL_OF_SPIRIT"] = "정신력 두루마리"
L["GROUP_SCROLL_OF_STAMINA"] = "체력 두루마리"
L["GROUP_SCROLL_OF_STRENGTH"] = "힘 두루마리"
L["GROUP_SCROLL_OF_PROTECTION"] = "보호 두루마리"
L["GROUP_SCROLL_OF_INTELLECT"] = "지능 두루마리"
L["GROUP_SCROLL_OF_AGILITY"] = "민첩성 두루마리"
L["GROUP_REPAIR_BOTS"] = "수리 로봇"
L["GROUP_JUMPER_CABLES"] = "점프 케이블"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "감사 버튼"
L["BUTTON_DESCRIPTION"] = "감정표현과 귓속말로 현재 대상에게 감사합니다."
L["BUTTON_CREATE_MACRO"] = "매크로 생성"
L["BUTTON_CREATE_MACRO_DESCRIPTION"] =
	"접속할 때 %s(이)라는 이름의 매크로를 자동으로 생성합니다."
L["BUTTON_WHISPER"] = "귓속말 메시지"
L["BUTTON_RESET"] = "초기화"
L["BUTTON_RESET_DESCRIPTION"] = "귓속말 메시지를 기본 텍스트로 초기화합니다."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "감사합니다, 최고예요! (="

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
