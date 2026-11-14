local _, ns = ...
local Data = ns.Data

--------------------------------------------------------------------------------
-- Message Languages
--------------------------------------------------------------------------------

--[[
    The languages TFTB can write sent messages in, for the "Send Messages In"
    dropdown. This is the language other players read. The Locales files are
    the language of the player's own UI, and AceLocale loads only the client's
    own file. That is why the default whisper of every language lives here,
    where all of them load in every client: an English client sending German
    still needs the German default.

    One row per supported locale, in the master list's order (which is also
    the dropdown's): the client locale code, the
    language's name in that language (so a player can find their own in any
    client, and no translation is needed), the default thank-you whisper, the
    default Good News whisper, and the clause Good News adds after the spell
    when its buff lasts under a minute.

    TRANSLATORS: keep {spell} and {seconds} exactly as written; TFTB swaps in
    the spell's link and a whole number of seconds. In goodNewsFor, write the
    unit as |4one:many; (|4one:few:many; for Russian) right after {seconds}, the
    way the game writes its own durations, so "1 second" and "15 seconds" each
    read right; a language with no plural writes the unit plainly.
]]
Data.MESSAGE_LANGUAGES = {
	{
		locale = "enUS",
		name = "English",
		giveThanks = "Thanks for the {spell}",
		goodNews = "Good News! You have {spell}",
		goodNewsFor = "for {seconds} |4Second:Seconds;",
	},
	{
		locale = "deDE",
		name = "Deutsch",
		giveThanks = "Danke für {spell}",
		goodNews = "Gute Nachrichten! Du hast {spell}",
		goodNewsFor = "für {seconds} |4Sekunde:Sekunden;",
	},
	{
		locale = "esES",
		name = "Español (EU)",
		giveThanks = "Gracias por {spell}",
		goodNews = "¡Buenas noticias! Tienes {spell}",
		goodNewsFor = "durante {seconds} |4segundo:segundos;",
	},
	{
		locale = "esMX",
		name = "Español (AL)",
		giveThanks = "Gracias por {spell}",
		goodNews = "¡Buenas noticias! Tienes {spell}",
		goodNewsFor = "durante {seconds} |4segundo:segundos;",
	},
	{
		locale = "frFR",
		name = "Français",
		giveThanks = "Merci pour {spell}",
		goodNews = "Bonne nouvelle ! Tu as {spell}",
		goodNewsFor = "pendant {seconds} |4seconde:secondes;",
	},
	{
		locale = "itIT",
		name = "Italiano",
		giveThanks = "Grazie per {spell}",
		goodNews = "Buone notizie! Hai {spell}",
		goodNewsFor = "per {seconds} |4secondo:secondi;",
	},
	{
		locale = "koKR",
		name = "한국어",
		giveThanks = "{spell} 고맙습니다",
		goodNews = "좋은 소식! {spell} 받으셨습니다",
		goodNewsFor = "{seconds}초 동안",
	},
	{
		locale = "ptBR",
		name = "Português (BR)",
		giveThanks = "Obrigado por {spell}",
		goodNews = "Boas notícias! Você tem {spell}",
		goodNewsFor = "por {seconds} |4segundo:segundos;",
	},
	{
		locale = "ruRU",
		name = "Русский",
		giveThanks = "Спасибо за {spell}",
		goodNews = "Хорошие новости! У тебя {spell}",
		goodNewsFor = "на {seconds} |4секунду:секунды:секунд;",
	},
	{
		locale = "zhCN",
		name = "简体中文",
		giveThanks = "感谢你的 {spell}",
		goodNews = "好消息！你获得了 {spell}",
		goodNewsFor = "持续{seconds}秒",
	},
	{
		locale = "zhTW",
		name = "繁體中文",
		giveThanks = "感謝你的 {spell}",
		goodNews = "好消息！你獲得了 {spell}",
		goodNewsFor = "持續{seconds}秒",
	},
}

-- English unless the player picks another, whatever the client's own language.
Data.DEFAULT_MESSAGE_LANGUAGE = "enUS"

local languageByLocale = {}
for _, language in ipairs(Data.MESSAGE_LANGUAGES) do
	languageByLocale[language.locale] = language
end

-- The row for a locale code, or nil when TFTB has no messages in it (enGB, for one).
function ns.GetMessageLanguageInfo(locale)
	return locale and languageByLocale[locale] or nil
end

--[[
    The language sent messages go out in. A saved code TFTB no longer lists
    reads as the default, so a stale value never leaves a whisper with no text.
]]
function ns.GetMessageLanguage()
	local saved = ns.db and ns.db.profile.messageLanguage
	if languageByLocale[saved] then
		return saved
	end
	return Data.DEFAULT_MESSAGE_LANGUAGE
end

-- The default thank-you whisper in `locale`, or in the language messages go out in now.
function ns.GetDefaultThanksWhisper(locale)
	local language = languageByLocale[locale or ns.GetMessageLanguage()]
		or languageByLocale[Data.DEFAULT_MESSAGE_LANGUAGE]
	return language.giveThanks
end

-- The default Good News whisper in `locale`, or in the language messages go out in now.
function ns.GetDefaultGoodNewsWhisper(locale)
	local language = languageByLocale[locale or ns.GetMessageLanguage()]
		or languageByLocale[Data.DEFAULT_MESSAGE_LANGUAGE]
	return language.goodNews
end

--[[
    Good News' "for 15 Seconds", in the language messages go out in: the row's
    clause with the count filled in. Its plural escape is left for the caller
    to resolve, since SendChatMessage rejects a line that still carries one.
]]
function ns.GetGoodNewsDurationClause(seconds)
	local language = languageByLocale[ns.GetMessageLanguage()] or languageByLocale[Data.DEFAULT_MESSAGE_LANGUAGE]
	return (language.goodNewsFor:gsub("{seconds}", function()
		return tostring(seconds)
	end))
end
