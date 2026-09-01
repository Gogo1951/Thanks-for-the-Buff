local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "enUS", true)
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
	"Version %s. Settings (including the option to disable this message) can be found under Options > AddOns > Thanks for the Buff (TFTB). Enjoying the add-on? Tell a friend about it! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "As a safety precaution, the Options Interface cannot be opened during combat."

-- Buff & gift announcements
L["MESSAGE_BUFFED"] = "%s buffed you with %s!"
L["MESSAGE_GAVE_YOU"] = "%s gave you %s!"
L["MESSAGE_GAVE_GROUP"] = "%s gave your group %s!"
L["MESSAGE_USED_ITEM"] = "%s used %s on you!"
L["MESSAGE_USED_SPELL"] = "%s cast %s on you!"
L["MESSAGE_SET_OUT"] = "%s set out %s!"
L["MESSAGE_OPENED"] = "%s opened %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Thanks for the %s!"
L["MESSAGE_PEER_PRESSURE"] = "%s used %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s used %s on %s!"
L["MESSAGE_SELECT_PLAYER"] = "Select a player to thank."
L["MESSAGE_CANT_THANK_SELF"] = "You can't thank yourself!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Unknown Spell"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Enable Welcome Message"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Print a message to chat when you log in."
L["OPTIONS_DESCRIPTION"] =
	"Automatically thank players who buff you with emotes, whispers, and chat notifications, from open-world buffs to teammate cooldowns like Power Infusion and Innervate. Get alerts for feasts, portals, and same-class cooldowns too."
L["OPTIONS_SUPPORT"] = "Feedback & Support"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Opens the Options Interface for this add-on."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Stranger Buffs"
L["STRANGERS_ENABLE"] = "Enable Thanks for Stranger Buffs"
L["STRANGERS_DESCRIPTION"] = "Thank players outside your group when they buff you out in the open world."
--[[
    The dropdown values carry the unit, so these labels do not repeat it. Each
    description is one line because it renders as visible help under its control
    rather than behind a hover.
]]
L["STRANGERS_OVERALL_COOLDOWN"] = "Praise Cooldown"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Delay between one praise and the next, no matter who buffed you. Set to zero to praise every buff."
L["STRANGERS_SOURCE_COOLDOWN"] = "Same-Player Praise Cooldown"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Delay between praise aimed at the same player. Set to zero to praise every buff."
L["STRANGERS_MIN_DURATION"] = "Minimum Buff Duration"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] = "Ignore buffs shorter than this. Set to zero to react to every buff."

--------------------------------------------------------------------------------
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Teammate Buffs"
L["TEAMMATES_ENABLE"] = "Enable Thanks for Teammate Buffs"
L["TEAMMATES_DESCRIPTION"] = "Thank party and raid members for the buffs and cooldowns they cast on you."

-- Service Alerts
L["TAB_SERVICES"] = "Service Alerts"
L["SERVICES_ENABLE"] = "Enable Service Alerts"
L["SERVICES_DESCRIPTION"] = "React to raid-wide help from your group: feasts, soulwells, portals, repair bots."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Send Good News"
L["GOOD_NEWS_DESCRIPTION"] = "Let the players you buff know what you cast on them, and how long it lasts."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Enable Good News"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] = "Whisper the player you buffed to tell them what they got and for how long."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Anyone You Buff"
L["GOOD_NEWS_SCOPE_GROUP"] = "Only Group Members"
L["GOOD_NEWS_MESSAGES_HEADER"] = "Good News Messages"
L["GOOD_NEWS_MESSAGE"] = "Whisper Message"
--[[
    Two halves so the number stays authoritative: LIMIT's %d is a real placeholder
    and gets formatted, TOKENS carries a literal %a for the reader to copy and so
    must never reach string.format. Joined into one line at the point of use.
]]
L["GOOD_NEWS_MESSAGE_LIMIT"] = "Maximum length: %d."
L["GOOD_NEWS_MESSAGE_TOKENS"] = "%a becomes the ability link."
--[[
    Appended to the ability link inside %a when the buff has a readable duration.
    A whole clause rather than a bare number so it can be reworded per language.
]]
L["GOOD_NEWS_DURATION_CLAUSE"] = "for %s"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Peer Pressure"
L["PEER_PRESSURE_DESCRIPTION"] =
	"Get notified when other players of your class use their cooldowns, so you can give in to Peer Pressure."
L["PEER_PRESSURE_ENABLE"] = "Enable Peer Pressure"
L["PEER_PRESSURE_PRINT_DESCRIPTION"] =
	"Print a message to your own chat when a same-class cooldown is used. Only you see it."
L["PEER_PRESSURE_OWN_CASTS"] = "Trigger on Own Casts"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Also trigger when you use your own cooldowns, not just when other players do."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] = "Play a sound when a same-class cooldown is used. Only you hear it."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Tracked Abilities"
L["TRACKED_GROUP_ITEMS"] = "Items"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Toggle tracking for %s."
L["TRACKED_ITEM_PENDING"] = "Item #%d"
L["TRACKED_SPELL_PENDING"] = "Spell #%d"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
]]
L["PRAISE_HEADER"] = "Praise Messages & Emotes"
L["NOTIFICATIONS_HEADER"] = "Notifications"

L["PRAISE_WHISPER_ENABLE"] = "Enable Thank You Whispers"
L["PRAISE_WHISPER_DESCRIPTION"] = "Whisper a thank-you to the player who buffed you."
L["PRAISE_EMOTES_ENABLE"] = "Enable Emotes"
L["PRAISE_EMOTES_DESCRIPTION"] = "Emote your appreciation. Emotes are held back while you are in combat."
L["PRAISE_EMOTES_SELECT"] = "Select Emotes"
L["PRAISE_DELAY_ENABLE"] = "Enable Praise Delay"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Wait a moment before the whisper and the emote, so your thanks doesn't land in the same instant as the buff. Notifications are unaffected."
L["PRAISE_DELAY_HELP"] = "Wait before praising, so your thanks doesn't land in the same instant as the buff."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Enable Chat Messages"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Print a message to your own chat when you receive a buff. Only you see it."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Enable Sound Effects"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Play a sound when you receive a buff. Only you hear it."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
    spells and items take their names from the client and need no key here.
]]
L["GROUP_PORTALS"] = "Portals"
L["GROUP_SOULSTONE"] = "Soulstone"
L["GROUP_RESISTANCE_CAULDRONS"] = "Resistance Cauldrons"
L["GROUP_SCROLL_OF_SPIRIT"] = "Scroll of Spirit"
L["GROUP_SCROLL_OF_STAMINA"] = "Scroll of Stamina"
L["GROUP_SCROLL_OF_STRENGTH"] = "Scroll of Strength"
L["GROUP_SCROLL_OF_PROTECTION"] = "Scroll of Protection"
L["GROUP_SCROLL_OF_INTELLECT"] = "Scroll of Intellect"
L["GROUP_SCROLL_OF_AGILITY"] = "Scroll of Agility"
L["GROUP_REPAIR_BOTS"] = "Repair Bots"
L["GROUP_JUMPER_CABLES"] = "Jumper Cables"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Thank You Button"
L["BUTTON_DESCRIPTION"] =
	"Civility, automated. Each button whispers your current target and can emote at them too: ask a mage for water, thank someone for a portal, praise a friend mid-fight for the quick taunt. Write the message once and it's a keypress from then on."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "TFTB Button %d"
L["BUTTON_EMOTE"] = "Emote"
L["BUTTON_EMOTE_NONE"] = "None"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Enable Macro "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "Create a macro named %s, and delete it again when you turn this off."
L["BUTTON_WHISPER"] = "Whisper Message"
L["BUTTON_RESET"] = "Reset"
L["BUTTON_RESET_DESCRIPTION"] = "Reset the whisper message to the default text."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Thanks, you're the best! (="
--[[
    The star marker and "TFTB // " prefix are added by the builder and are not
    part of the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "You have %a!"

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESCRIPTION"] = "You cheer at <Target>."
L["EMOTE_DRINK_DESCRIPTION"] = "You raise a drink to <Target>."
L["EMOTE_FLEX_DESCRIPTION"] = "You flex at <Target>."
L["EMOTE_GRIN_DESCRIPTION"] = "You grin wickedly at <Target>."
L["EMOTE_HIGHFIVE_DESCRIPTION"] = "You high-five <Target>."
L["EMOTE_PRAISE_DESCRIPTION"] = "You praise <Target>."
L["EMOTE_SALUTE_DESCRIPTION"] = "You salute <Target> with respect."
L["EMOTE_SMILE_DESCRIPTION"] = "You smile at <Target>."
L["EMOTE_THANK_DESCRIPTION"] = "You thank <Target>."
L["EMOTE_WHOA_DESCRIPTION"] = "You exclaim 'Whoa!' at <Target>."
L["EMOTE_WINK_DESCRIPTION"] = "You wink at <Target>."
L["EMOTE_YES_DESCRIPTION"] = "You nod at <Target>."
