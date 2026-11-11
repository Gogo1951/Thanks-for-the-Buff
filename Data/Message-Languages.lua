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
    client, and no translation is needed), and the default thank-you whisper.

    TRANSLATORS: keep {spell} exactly as written; TFTB swaps in the buff's link.
]]
Data.MESSAGE_LANGUAGES = {
	{ locale = "enUS", name = "English", giveThanks = "Thanks for the {spell}" },
	{ locale = "deDE", name = "Deutsch", giveThanks = "Danke für {spell}" },
	{ locale = "esES", name = "Español (EU)", giveThanks = "Gracias por {spell}" },
	{ locale = "esMX", name = "Español (AL)", giveThanks = "Gracias por {spell}" },
	{ locale = "frFR", name = "Français", giveThanks = "Merci pour {spell}" },
	{ locale = "itIT", name = "Italiano", giveThanks = "Grazie per {spell}" },
	{ locale = "koKR", name = "한국어", giveThanks = "{spell} 고맙습니다" },
	{ locale = "ptBR", name = "Português (BR)", giveThanks = "Obrigado por {spell}" },
	{ locale = "ruRU", name = "Русский", giveThanks = "Спасибо за {spell}" },
	{ locale = "zhCN", name = "简体中文", giveThanks = "感谢你的 {spell}" },
	{ locale = "zhTW", name = "繁體中文", giveThanks = "感謝你的 {spell}" },
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
