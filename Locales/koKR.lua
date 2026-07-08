local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "koKR")
if not L then return end

--------------------------------------------------------------------------------
-- Add-on Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Thanks for the Buff (TFTB)"
L["ADDON_SHORT"] = "TFTB"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] = "버전 %s. 설정(이 메시지를 비활성화하는 옵션 포함)은 옵션 > 애드온 > Thanks for the Buff 에서 찾을 수 있습니다. 애드온이 마음에 드시나요? 친구에게 알려주세요! (="
L["MSG_RESET"] = "모든 설정이 기본값으로 초기화되었습니다."

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s님이 당신에게 %s 버프를 주었습니다!"
L["MSG_GAVE_YOU"] = "%s님이 당신에게 %s(을)를 주었습니다!"
L["MSG_GAVE_GROUP"] = "%s님이 파티에 %s(을)를 주었습니다!"
L["MSG_USED_ITEM"] = "%s님이 당신에게 %s %s(을)를 사용했습니다!"
L["MSG_USED_SPELL"] = "%s님이 당신에게 %s(을)를 사용했습니다!"
L["MSG_SET_OUT"] = "%s님이 %s(을)를 꺼냈습니다!"
L["MSG_OPENED"] = "%s님이 %s(을)를 열었습니다!"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "%s 고맙습니다!"
L["MSG_SELECT_PLAYER"] = "감사할 플레이어를 선택하세요."
L["MSG_CANT_THANK_SELF"] = "자신에게는 감사할 수 없습니다!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MSG_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "그의"
L["PRONOUN_HER"] = "그녀의"
L["PRONOUN_THEIR"] = "그들의"
L["UNKNOWN_SPELL"] = "알 수 없는 주문"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "환영 메시지 활성화"
L["OPTIONS_WELCOME_DESC"] = "접속할 때 대화창에 메시지를 출력합니다."
L["OPTIONS_RESET_ALL_PROFILES"] = "모든 프로필 초기화"
L["OPTIONS_RESET_ALL_PROFILES_DESCRIPTION"] = "이 계정의 모든 프로필을 기본 설정으로 초기화합니다."
L["OPTIONS_RESET_ALL_PROFILES_CONFIRM"] = "계정의 모든 프로필이 기본 설정으로 초기화됩니다 — 모든 캐릭터. 되돌릴 수 없습니다. 계속하시겠습니까?"
L["OPTIONS_DESCRIPTION"] = "야외에서 낯선 사람이 버프를 주거나 전투 중 팀원이 쿨기를 사용해 줄 때마다 감정표현과 메시지로 자동으로 감사를 표합니다."
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
L["STRANGERS_DESC"] = "파티 외부(야외)의 플레이어가 당신에게 주는 버프입니다."
L["STRANGERS_COOLDOWN"] = "재사용 대기시간 (초)"
L["STRANGERS_COOLDOWN_DESC"] = "동일한 플레이어에게 감정표현을 하는 최대 빈도입니다.\n\n메시지는 영향을 받지 않으며, 모든 버프에 대해 발동합니다."
L["STRANGERS_MIN_DURATION"] = "최소 버프 지속시간 (초)"
L["STRANGERS_MIN_DURATION_DESC"] = "감사를 트리거하려면 버프가 지속되어야 하는 최소 시간입니다.\n\n소생이나 회복과 같은 짧은 지속 치유는 무시합니다."
L["STRANGERS_MESSAGING"] = "메시지"
L["STRANGERS_EMOTES_SELECT"] = "감정표현 선택"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

L["TEAMMATES_TITLE"] = "팀원의 버프"
L["TEAMMATES_DESC"] = "파티 또는 공격대원이 당신에게 시전하는 버프나 재사용 대기시간 기술입니다."
L["SERVICES_TITLE"] = "그룹 서비스"
L["SERVICES_DESC"] = "파티 또는 공격대원이 제공하는 전체 도움말 - 잔치, 영혼샘, 차원문, 수리 로봇."
L["COMBAT_MESSAGING"] = "메시지"
L["COMBAT_EMOTES_SELECT"] = "감정표현 선택"
L["COMBAT_TRACKED"] = "추적 중인 능력:"
L["COMBAT_TOGGLE_TRACKING"] = "%s에 대한 추적 켜기/끄기"
L["COMBAT_GROUP_ITEMS"] = "아이템"
L["COMBAT_ITEM_PENDING"] = "아이템 #%d"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "감사 버튼"
L["BUTTON_DESC"] = "감정표현과 귓속말로 현재 대상에게 감사합니다."
L["BUTTON_CREATE_MACRO"] = "매크로 생성"
L["BUTTON_CREATE_MACRO_DESC"] = "접속할 때 %s(이)라는 이름의 매크로가 자동으로 생성됩니다."
L["BUTTON_WHISPER"] = "귓속말 메시지"
L["BUTTON_RESET"] = "초기화"
L["BUTTON_RESET_DESC"] = "귓속말 메시지를 기본 텍스트로 초기화합니다."
L["BUTTON_EMOTES_SELECT"] = "감정표현 선택"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_PRINT_ENABLE"] = "출력 메시 활성화 (자신에게만)"
L["MESSAGING_PRINT_DESC"] = "버프를 받을 때 자신의 대화창에 메시지를 출력합니다. 자신만 볼 수 있습니다."
L["MESSAGING_WHISPER_ENABLE"] = "감사 메시지 활성화"
L["MESSAGING_WHISPER_DESC"] = "버프를 준 플레이어에게 감사의 귓속말을 보냅니다."
L["MESSAGING_EMOTES_ENABLE"] = "감정표현 활성화 (비전투 시)"
L["MESSAGING_EMOTES_DESC"] = "감정표현으로 감사를 표합니다. 전투 중에는 감정표현이 보류됩니다."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "감사합니다, 최고예요! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESC"] = "<Target>에게 환호합니다."
L["EMOTE_DRINK_DESC"] = "<Target>을(를) 향해 건배합니다."
L["EMOTE_FLEX_DESC"] = "<Target>에게 근육을 자랑합니다."
L["EMOTE_GRIN_DESC"] = "<Target>에게 짖궂게 웃어 보입니다."
L["EMOTE_HIGHFIVE_DESC"] = "<Target>와(과) 하이파이브를 합니다."
L["EMOTE_PRAISE_DESC"] = "<Target>을(를) 칭찬합니다."
L["EMOTE_SALUTE_DESC"] = "<Target>에게 정중하게 경례합니다."
L["EMOTE_SMILE_DESC"] = "<Target>을(를) 보며 미소 짓습니다."
L["EMOTE_THANK_DESC"] = "<Target>에게 감사합니다."
L["EMOTE_WHOA_DESC"] = "<Target>을(를) 바라보며 '우와!'하고 외칩니다."
L["EMOTE_WINK_DESC"] = "<Target>에게 윙크합니다."
L["EMOTE_YES_DESC"] = "<Target>에게 고개를 끄덕입니다."
