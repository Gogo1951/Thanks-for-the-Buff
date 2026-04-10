local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "koKR")
if not L then return end

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["MSG_ENABLED"] = "활성화되었습니다. /tftb를 사용하여 설정을 조정하거나 이 메시지를 끌 수 있습니다. (="
L["MSG_DB_ERROR"] = "오류: 데이터베이스 기본값을 불러오지 못했습니다. /tftb를 통해 프로필을 초기화하세요."
L["MSG_RESET"] = "모든 설정이 기본값으로 초기화되었습니다."
L["MSG_BUFFED"] = "%s님이 당신에게 %s 버프를 주었습니다!"
L["MSG_HIT"] = "%s님이 %s(으)로 당신을 적중했습니다!"
L["MSG_PARTY_ITEM"] = "%s님이 파티를 위해 %s(을)를 사용했습니다!"
L["MSG_WHISPER_THANKS"] = "%s 고맙습니다!"
L["MSG_SELECT_PLAYER"] = "감사할 플레이어를 선택하세요."
L["MSG_CANT_THANK_SELF"] = "자신에게는 감사할 수 없습니다!"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_TITLE"] = "Thanks for the Buff!"
L["OPTIONS_GENERAL"] = "일반 설정"
L["OPTIONS_WELCOME_TOGGLE"] = "환영 메시지 활성화"
L["OPTIONS_WELCOME_DESC"] = "접속할 때 대화창에 메시지를 출력합니다."
L["OPTIONS_RESET"] = "초기화"
L["OPTIONS_RESET_ALL"] = "모든 설정 초기화"
L["OPTIONS_RESET_ALL_DESC"] = "모든 옵션을 기본값으로 복원합니다."
L["OPTIONS_RESET_CONFIRM"] = "모든 설정을 기본값으로 초기화하시겠습니까?"
L["OPTIONS_DESCRIPTION"] = "새로운 버프를 받을 때마다 감정표현으로 행복을 자동으로 표현합니다."
L["OPTIONS_SUPPORT"] = "피드백 및 지원"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Thanks for the Buff 설정 인터페이스를 엽니다."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "대상의 플레이어에게 감정표현과 귓속말을 합니다."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "낯선 사람의 버프"
L["STRANGERS_ENABLE"] = "낯선 사람의 버프에 반응"
L["STRANGERS_COOLDOWN"] = "재사용 대기시간 (초)"
L["STRANGERS_COOLDOWN_DESC"] = "동일한 플레이어에게 감사하는 최대 빈도입니다."
L["STRANGERS_MIN_DURATION"] = "최소 버프 지속시간 (초)"
L["STRANGERS_MIN_DURATION_DESC"] = "감사를 트리거하려면 버프가 지속되어야 하는 최소 시간입니다.\n\n소생이나 회복과 같은 짧은 지속 치유는 무시합니다."
L["STRANGERS_MESSAGING"] = "메시지"
L["STRANGERS_EMOTES_ENABLE"] = "감정표현 활성화"
L["STRANGERS_EMOTES_DESC"] = "낯선 사람의 버프에 대한 감사를 감정표현으로 나타냅니다."
L["STRANGERS_EMOTES_SELECT"] = "감정표현 선택"

--------------------------------------------------------------------------------
-- Options: Combat Buffs
--------------------------------------------------------------------------------

L["COMBAT_TITLE"] = "전투 버프"
L["COMBAT_MESSAGING"] = "메시지"
L["COMBAT_TRACKED"] = "추적 중인 능력:"
L["COMBAT_TOGGLE_TRACKING"] = "%s에 대한 추적 켜기/끄기"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "감사 버튼"
L["BUTTON_CREATE_MACRO"] = "매크로 생성"
L["BUTTON_CREATE_MACRO_DESC"] = "접속할 때 %s(이)라는 이름의 매크로가 자동으로 생성됩니다."
L["BUTTON_WHISPER"] = "귓속말 메시지"
L["BUTTON_RESET"] = "초기화"
L["BUTTON_RESET_DESC"] = "귓속말 메시지를 기본 텍스트로 초기화합니다."
L["BUTTON_EMOTES_HEADER"] = "감사 버튼 감정표현:"
L["BUTTON_EMOTES_SELECT"] = "감정표현 선택"

--------------------------------------------------------------------------------
-- Shared: Messaging Dropdown
--------------------------------------------------------------------------------

L["MESSAGING_NONE"] = "메시지 없음"
L["MESSAGING_NONE_DEFAULT"] = "메시지 없음 (기본값)"
L["MESSAGING_PRINT"] = "출력 메시지 (자신에게만)"
L["MESSAGING_WHISPER"] = "귓속말 메시지"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "감사합니다, 최고예요! (="