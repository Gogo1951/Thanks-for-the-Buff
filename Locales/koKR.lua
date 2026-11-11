local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "koKR")
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
	"버전 %s. 설정(이 메시지를 끄는 옵션 포함)은 옵션 > 애드온 > Thanks for the Buff (TFTB)에 있습니다. 이 애드온이 마음에 드시나요? 친구에게 알려 주시거나, CurseForge에서 즐겨찾기에 추가하거나, GitHub에서 Star를 눌러 주세요. (="
L["CHAT_OPTIONS_IN_COMBAT"] = "안전을 위해 전투 중에는 설정 인터페이스를 열 수 없습니다."

-- Buff print out
L["MESSAGE_BUFFED"] = "%s님이 당신에게 %s 버프를 주었습니다!"

-- Thank You Button
L["MESSAGE_SELECT_PLAYER"] = "먼저 플레이어를 대상으로 지정하세요."
L["MESSAGE_CANT_THANK_SELF"] = "자신에게는 감사할 수 없습니다!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "알 수 없는 주문"
L["SAMPLE_EXAMPLE"] = "예시: %s"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "환영 메시지 활성화"
L["OPTIONS_WELCOME_DESCRIPTION"] = "접속할 때 자신만 볼 수 있는 메시지를 출력합니다."
L["OPTIONS_DESCRIPTION"] =
	"버프를 준 플레이어에게 감정 표현이나 귓속말로 자동으로 감사를 표하고, 지나치는 친구와 길드원에게 손을 흔들어 인사하며, 감사 매크로를 한 번 클릭해 대상으로 잡은 누구에게나 감사하세요."
L["OPTIONS_FEATURES_HEADER"] = "기능"
L["OPTIONS_FEATURES_DESCRIPTION"] =
	"각 기능은 여기서 또는 해당 기능의 패널에서 켜거나 끌 수 있습니다."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "이 애드온의 설정 인터페이스를 엽니다."

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "다른 기능을 찾고 계신가요?"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"일부 기능이 새 애드온 Good to Go로 옮겨졌습니다. CurseForge 또는 Wago에서 찾아보세요."

--------------------------------------------------------------------------------
-- Options: Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "Thanks for the Buff (TFTB)의 레벨 업을 도와주세요"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"이 애드온은 이 게임을 사랑하고 모두가 최대한 즐겁게 플레이하기를 바라는 플레이어들이 만들었습니다. 저희는 절대 후원을 요청하지 않습니다. 저희의 작업이 여러분의 게임을 조금 더 즐겁게 만든다는 것이 가장 큰 보람입니다. 그렇다면 꼭 이야기를 들려주세요!"
L["OPTIONS_LEVEL_UP_WAYS"] =
	"더 많은 플레이어에게 다가갈 수 있도록 도와주실 수 있는 몇 가지 방법입니다."
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• 피드백 공유: 버그를 발견했거나 아이디어가 있으신가요? Discord에서 알려 주세요. 여러분의 피드백은 애드온 개선에 도움이 되며, 풀 리퀘스트도 언제나 환영합니다."
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• 친구에게 알리기: 이 애드온을 좋아할 만한 사람을 알고 계신가요? 소개해 주세요. 입소문은 더 많은 플레이어가 좋은 애드온을 발견하는 데 도움이 됩니다."
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	"• CurseForge 즐겨찾기: 아래 CurseForge 링크를 열고 로그인한 뒤 Download 버튼 아래의 별을 클릭하세요. 즐겨찾기는 더 많은 플레이어가 애드온을 발견하는 데 도움이 됩니다."
L["OPTIONS_LEVEL_UP_GITHUB"] =
	"• GitHub에서 Star 누르기: 아래 GitHub 링크를 열고 로그인한 뒤 오른쪽 위의 Star를 클릭하세요. Star는 프로젝트가 더 많은 무료 개발자 도구를 이용할 자격을 얻는 데 도움이 됩니다."
L["OPTIONS_LEVEL_UP_THANKS"] = "Thanks for the Buff (TFTB)를 선택해 주셔서 감사합니다!"

L["OPTIONS_FEEDBACK"] = "피드백 및 지원"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "피드백 및 지원 링크"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "링크를 복사하려면 해당 칸을 클릭한 뒤 Ctrl+A와 Ctrl+C를 누르세요."
L["OPTIONS_VERSION"] = "버전 %s"

--------------------------------------------------------------------------------
-- Options: Give Thanks
--------------------------------------------------------------------------------

L["TAB_GIVE_THANKS"] = "감사하기"
L["GIVE_THANKS_ENABLE"] = "감사하기 활성화"
L["GIVE_THANKS_ENABLE_DESCRIPTION"] =
	"파티 외부의 플레이어가 준 버프에 대한 감사 표시를 켭니다."
L["GIVE_THANKS_DESCRIPTION"] = "야외에서 파티 외부의 플레이어가 버프를 주면 감사를 표합니다."

-- Praise Limits
L["PRAISE_HEADER"] = "감사 표시 제한"
L["PRAISE_DESCRIPTION"] =
	"감정 표현과 귓속말을 모두 제한하여, 버프가 한꺼번에 몰려와도 도배가 되지 않게 합니다."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["GIVE_THANKS_OVERALL_COOLDOWN"] = "감사 표시 대기시간"
L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"누가 버프를 주었든, 한 차례 감사 표시와 다음 감사 표시 사이의 대기시간을 설정합니다. 0으로 설정하면 모든 버프에 감사를 표합니다."
L["GIVE_THANKS_SOURCE_COOLDOWN"] = "같은 플레이어 감사 표시 대기시간"
L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"같은 플레이어에게 감사를 표하는 사이의 대기시간을 설정합니다. 0으로 설정하면 모든 버프에 감사를 표합니다."
L["GIVE_THANKS_MIN_DURATION"] = "최소 버프 지속시간"
L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"] =
	"이보다 짧은 버프는 무시합니다. 0으로 설정하면 모든 버프에 반응합니다."
L["PRAISE_DELAY_ENABLE"] = "감사 표시 지연 활성화"
L["PRAISE_DELAY_DESCRIPTION"] =
	"귓속말과 감정 표현을 보내기 전에 잠시 기다려, 버프와 같은 순간에 감사가 전달되지 않도록 합니다. 알림은 영향을 받지 않습니다."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] =
	"귓속말과 감정 표현을 보내기 전에 기다릴 시간을 설정합니다."

-- Thank-You Whispers
L["WHISPERS_HEADER"] = "감사 귓속말"
L["PRAISE_WHISPER_ENABLE"] = "감사 귓속말 활성화"
L["PRAISE_WHISPER_DESCRIPTION"] = "버프를 준 플레이어에게 감사의 귓속말을 보냅니다."
-- TRANSLATORS: keep {spell} and {name} exactly as written; they are the tokens players type into the whisper.
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"버프를 준 플레이어에게 TFTB가 보낼 귓속말을 설정합니다. {spell}은 해당 버프로, {name}은 그 플레이어의 이름으로 바뀝니다. 비워 두면 귓속말을 보내지 않습니다."

-- Notifications
L["NOTIFICATIONS_HEADER"] = "알림"
L["NOTIFICATIONS_DESCRIPTION"] = "자신만 받는 것: 텍스트 알림, 효과음 또는 둘 다."
L["NOTIFICATIONS_PRINT_ENABLE"] = "텍스트 알림 활성화"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "버프를 받을 때 자신만 볼 수 있는 메시지를 출력합니다."
L["NOTIFICATIONS_SOUND_ENABLE"] = "효과음 활성화"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] =
	"버프를 받을 때 효과음을 재생합니다. 자신에게만 들립니다."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] =
	"켜기 전에 미리 들어 볼 수 있도록 효과음을 재생합니다."

--------------------------------------------------------------------------------
-- Options: Emotes List
--------------------------------------------------------------------------------

L["TAB_EMOTES_LIST"] = "감정 표현 목록"
L["EMOTES_GRID_DESCRIPTION"] =
	"파티 외부의 플레이어가 버프를 줄 때 감사하기 기능이 고를 수 있는 감정 표현을 선택하세요. 그중 하나를 무작위로 사용합니다. 전투 중에는 감정 표현이 보류됩니다."

--[[
    The emote checklist, shared by this panel and Wave to Friends' Friends and
    Guilds tabs. Its group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS
    entry, upper-cased.
]]
L["EMOTE_GROUP_COUNT"] = "%s (%d/%d 선택)"
L["EMOTE_GROUP_TEXT"] = "텍스트"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "감정 표현 문구만 표시합니다."
L["EMOTE_GROUP_VOICE"] = "음성"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "음성 대사를 재생합니다."
L["EMOTE_GROUP_GESTURE"] = "동작"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "짧은 동작을 재생합니다."
L["EMOTE_GROUP_POSE"] = "자세"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "움직일 때까지 유지됩니다."
L["EMOTES_RESET"] = "감정 표현 초기화"
L["EMOTES_RESET_DESCRIPTION"] = "목록을 기본 감사 감정 표현으로 되돌립니다."
L["EMOTES_RESET_CONFIRM"] = "감정 표현 목록을 기본값으로 초기화할까요?"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "무시할 버프"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"이 목록의 버프에는 누가 걸어 주든 감사 인사를 보내지 않습니다. 텍스트 알림과 효과음은 그대로 받습니다."
L["IGNORED_BUFFS_ADD_CURRENT"] = "현재 버프 무시"
L["IGNORED_BUFFS_ADD_CURRENT_DESCRIPTION"] = "지금 자신에게 걸린 버프 중 하나를 추가합니다."
L["IGNORED_BUFFS_ADD"] = "버프 추가"
L["IGNORED_BUFFS_ADD_DESCRIPTION"] =
	"주문 ID를 입력하거나 버프 링크를 Shift-클릭하여 칸에 넣은 다음 Enter 키를 누르세요."
L["IGNORED_BUFFS_EMPTY"] = "아직 무시하는 버프가 없습니다. 위에서 추가하세요."
L["IGNORED_BUFFS_REMOVE"] = "이 버프를 목록에서 제거합니다."
L["IGNORED_BUFFS_NOT_FOUND"] = "%s에 해당하는 버프를 찾을 수 없습니다."
L["IGNORED_BUFFS_ALL_CHARACTERS"] = "모든 캐릭터"
L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"] =
	"이 버프를 모든 캐릭터 목록으로 옮겨, 어느 캐릭터에서도 감사 인사를 보내지 않습니다."

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "감사 버튼"
L["BUTTON_DESCRIPTION"] =
	"키 한 번으로 대상에게 귓속말과 감정 표현을 보냅니다. 예의를 자동으로."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "감사 버튼 %d"
L["BUTTON_EMOTE"] = "감정 표현"
L["BUTTON_EMOTE_DESCRIPTION"] =
	"이 버튼이 대상에게 할 감정 표현을 설정합니다. 없음을 선택하면 감정 표현을 하지 않습니다."
L["BUTTON_EMOTE_NONE"] = "없음"
-- Titles Thank You Button 1's emote checklist.
L["EMOTES_SELECT"] = "감정 표현 선택"
L["BUTTON_ICON"] = "아이콘"
L["BUTTON_ICON_DESCRIPTION"] =
	"이 버튼의 매크로가 매크로 목록과 행동 단축바에 표시할 아이콘을 설정합니다."
-- The Icon dropdown's first choice, the macros' own icon; every other choice is a picture alone.
L["BUTTON_ICON_DEFAULT"] = "기본값"
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
-- Options: Wave to Friends
--------------------------------------------------------------------------------

L["TAB_WAVE_TO_FRIENDS"] = "친구 인사"
L["WAVE_ENABLE"] = "친구 인사 활성화"
L["WAVE_ENABLE_DESCRIPTION"] = "친구와 길드원에게 마우스를 올리면 감정 표현을 하도록 켭니다."
L["WAVE_DESCRIPTION"] =
	"야외에서 친구와 길드원에게 마우스를 올리면 감정 표현으로 인사합니다."
L["WAVE_RULES"] = "파티원이나 공격대원에게는 하지 않으며, 전투 중에도 하지 않습니다."
L["WAVE_RESTING_ENABLE"] = "휴식 중에만"
L["WAVE_RESTING_ENABLE_DESCRIPTION"] = "도시나 여관에서 휴식 중일 때만 인사합니다."
L["WAVE_COOLDOWN"] = "같은 플레이어 대기시간"
L["WAVE_COOLDOWN_DESCRIPTION"] = "같은 플레이어에게 다시 인사하기까지의 시간을 설정합니다."
L["WAVE_COOLDOWN_ONCE_PER_SESSION"] = "접속당 한 번"
-- %s is the default emotes' slash commands, as the client names them.
L["WAVE_EMOTES_RESET_DEFAULTS_DESCRIPTION"] = "목록을 %s만 선택된 상태로 되돌립니다."

-- Custom List
L["WAVE_TAB_CUSTOM"] = "사용자 목록"
L["WAVE_CUSTOM_DESCRIPTION"] =
	"친구와 길드보다 우선해 항상 자신만의 감정 표현을 받는 플레이어입니다. 없음을 선택하면 그 사람에게는 감정 표현을 하지 않습니다."
-- One of these two follows WAVE_CUSTOM_DESCRIPTION: realm clients, then WoW Forever, which has no realms.
L["WAVE_CUSTOM_NAMES_REALM"] =
	"이름-서버는 그 서버에서만 일치하고, 서버 없이 이름만 쓰면 모든 서버에서 일치합니다."
L["WAVE_CUSTOM_NAMES_FOREVER"] =
	"전체 이름은 캐릭터 하나와 일치하고, 앞 이름만 쓰면 그 이름을 가진 모든 캐릭터와 일치합니다."
L["WAVE_CUSTOM_ENABLE"] = "사용자 목록 활성화"
L["WAVE_CUSTOM_ENABLE_DESCRIPTION"] = "친구와 길드보다 먼저 아래 이름을 사용합니다."
L["WAVE_CUSTOM_OFF_WARNING"] =
	"사용자 목록이 꺼져 있어 아래의 누구도 감정 표현을 받지 않습니다."
L["WAVE_CUSTOM_ADD"] = "플레이어 추가"
L["WAVE_CUSTOM_ADD_DESCRIPTION"] =
	"이름 또는 이름-서버를 입력한 다음 Enter 키를 누르세요. 여러 이름은 쉼표로 구분하세요."
L["WAVE_CUSTOM_ADD_DESCRIPTION_FOREVER"] =
	"전체 이름이나 앞 이름을 입력한 다음 Enter 키를 누르세요. 여러 이름은 쉼표로 구분하세요."
L["WAVE_CUSTOM_EMPTY"] = "아직 플레이어가 없습니다. 위에서 추가하세요."
L["WAVE_CUSTOM_EMOTE_DESCRIPTION"] =
	"이 플레이어에게 할 감정 표현을 설정합니다. 없음을 선택하면 감정 표현을 하지 않습니다."
L["WAVE_CUSTOM_REMOVE"] = "이 플레이어를 목록에서 제거합니다."

-- Friends
L["WAVE_TAB_FRIENDS"] = "친구"
L["WAVE_FRIENDS_ENABLE"] = "친구에게 손 흔들기"
L["WAVE_FRIENDS_ENABLE_DESCRIPTION"] = "친구 목록에 있는 캐릭터에게 인사합니다."
L["WAVE_BNET_ENABLE"] = "Battle.net 친구 포함"
L["WAVE_BNET_ENABLE_DESCRIPTION"] = "Battle.net 친구가 플레이 중인 캐릭터에게도 인사합니다."
L["WAVE_FRIENDS_EMOTES_DESCRIPTION"] =
	"친구에게 쓸 감정 표현을 선택하세요. 그중 하나를 무작위로 사용합니다."

-- Guilds
L["WAVE_TAB_GUILDS"] = "길드"
L["WAVE_MY_GUILD_ENABLE"] = "내 길드에 손 흔들기"
L["WAVE_MY_GUILD_ENABLE_DESCRIPTION"] = "내가 속한 길드의 길드원에게 인사합니다."
L["WAVE_GUILD_ADD"] = "길드 추가"
L["WAVE_GUILD_ADD_DESCRIPTION"] =
	"길드 이름을 입력한 다음 Enter 키를 누르세요. 여러 길드는 쉼표로 구분하세요. 대소문자는 구분하지 않습니다."
L["WAVE_GUILDS_EMPTY"] = "아직 다른 길드가 없습니다. 위에서 추가하세요."
L["WAVE_GUILD_REMOVE"] = "이 길드를 목록에서 제거합니다."
L["WAVE_GUILDS_EMOTES_DESCRIPTION"] =
	"길드원에게 쓸 감정 표현을 선택하세요. 그중 하나를 무작위로 사용합니다."

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks and each Thank You Button.
L["WHISPER_MESSAGE"] = "귓속말 메시지"
L["WHISPER_MESSAGE_RESET"] = "초기화"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "귓속말 메시지를 기본 문구로 되돌립니다."

-- The whisper composer around the Give Thanks message box.
L["SEND_MESSAGES_IN"] = "메시지 언어"
L["SEND_MESSAGES_IN_DESCRIPTION"] =
	"TFTB가 다른 플레이어에게 보내는 메시지의 언어를 설정합니다. 다른 언어를 고르면, 직접 쓴 메시지가 아닌 경우 그 언어의 기본 메시지로 바뀝니다."
L["WHISPER_SIGN_OFF_DESCRIPTION"] = "TFTB가 보내는 모든 메시지에 붙어, 다른 플레이어가 애드온이 보낸 메시지임을 알 수 있게 합니다."
-- TRANSLATORS: each %s is a token, {spell} then {name}, drawn in blue.
L["WHISPER_TOKENS"] = "토큰: %s 버프, %s 시전자"
L["WHISPER_ROOM_LEFT"] = "남은 공간: %d"
L["WHISPER_ROOM_LEFT_DESCRIPTION"] =
	"예시 버프를 기준으로 귓속말에 더 넣을 수 있는 양입니다. 일부 글자는 한 칸보다 많이 차지하며, 이름이 긴 버프는 공간을 더 씁니다."
L["WHISPER_TOO_LONG"] = "너무 깁니다. 대신 기본 메시지를 보냅니다."
L["WHISPER_TEST"] = "나에게 테스트 보내기"
L["WHISPER_TEST_DESCRIPTION"] = "예시를 나에게 귓속말로 보내, 다른 플레이어가 보는 그대로 확인할 수 있습니다."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "감사합니다, 최고예요! (="
