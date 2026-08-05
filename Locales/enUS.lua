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
L["MESSAGE_USED_ITEM"] = "%s used %s %s on you!"
L["MESSAGE_USED_SPELL"] = "%s used %s on you!"
L["MESSAGE_SET_OUT"] = "%s set out %s!"
L["MESSAGE_OPENED"] = "%s opened %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Thanks for the %s!"
L["MESSAGE_GOOD_NEWS_DURATION"] = "Good News! You have %s for %s!"
L["MESSAGE_GOOD_NEWS"] = "Good News! You have %s!"
L["MESSAGE_PEER_PRESSURE"] = "%s used %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s used %s on %s!"
L["MESSAGE_SELECT_PLAYER"] = "Select a player to thank."
L["MESSAGE_CANT_THANK_SELF"] = "You can't thank yourself!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MESSAGE_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "his"
L["PRONOUN_HER"] = "her"
L["PRONOUN_THEIR"] = "their"
L["UNKNOWN_SPELL"] = "Unknown Spell"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Enable Welcome Message"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Print a message to chat when you log in."
L["OPTIONS_DESCRIPTION"] =
	"Automatically thank players who buff you with emotes, whispers, and chat notifications, whether it's a stranger in the open world or a teammate's cooldown like Power Infusion or Innervate. Get a heads-up for feasts, portals, and same-class cooldowns too."
L["OPTIONS_SUPPORT"] = "Feedback & Support"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Opens the Options Interface for this add-on."
L["OPTIONS_COMMAND_THANKYOU"] = "/thankyou"
L["OPTIONS_COMMAND_THANKYOU_DESCRIPTION"] = "Emotes at and whispers your current target."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Buffs from Strangers"
L["STRANGERS_DESCRIPTION"] = "A buff on you from a player outside your group (open world)."
L["STRANGERS_OVERALL_COOLDOWN"] = "Praise Cooldown (Seconds)"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"At most, how often to praise anyone at all, whoever the buff came from.\n\nSet to 0 to turn this limit off. Notifications are not affected."
L["STRANGERS_SOURCE_COOLDOWN"] = "Same-Source Praise Cooldown (Seconds)"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"At most, how often to praise the same player.\n\nNotifications are not affected."
L["STRANGERS_MIN_DURATION"] = "Minimum Buff Duration (Seconds)"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] =
	"How long the buff must last to be worth reacting to at all.\n\nFilters out short heals over time like Renew or Rejuvenation. Notifications are affected too; a buff below this is ignored completely, with no message, sound, whisper, or emote."

--------------------------------------------------------------------------------
-- Options: Combat Buff Panels
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Buffs from Teammates"
L["TEAMMATES_DESCRIPTION"] = "A party or raid member's buff or cooldown cast on you."

-- Group Services
L["TAB_SERVICES"] = "Group Services"
L["SERVICES_DESCRIPTION"] = "A party or raid member's raid-wide help: feasts, soulwells, portals, repair bots."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Good News"
L["GOOD_NEWS_DESCRIPTION"] = "Let the players you buff know what you cast on them, and how long it lasts."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Enable Good News"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] = "Whisper the player you buffed to tell them what they got and for how long."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Anyone You Buff"
L["GOOD_NEWS_SCOPE_GROUP"] = "Only Group Members"

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

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Tracked Abilities"
L["COMBAT_GROUP_ITEMS"] = "Items"
L["COMBAT_TOGGLE_TRACKING"] = "Toggle tracking for %s."
L["COMBAT_ITEM_PENDING"] = "Item #%d"
L["COMBAT_SPELL_PENDING"] = "Spell #%d"

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

-- The two section headers every buff panel is built from: what the other player
-- sees, then what only you get. Peer Pressure sends nothing outward, so it
-- carries the Notifications header alone. Key prefixes match the header the
-- control appears under.
L["PRAISE_HEADER"] = "Praise Messages & Emotes"
L["NOTIFICATIONS_HEADER"] = "Notifications"

L["PRAISE_WHISPER_ENABLE"] = "Enable Thank You Whispers"
L["PRAISE_WHISPER_DESCRIPTION"] = "Whisper a thank-you to the player who buffed you."
L["PRAISE_EMOTES_ENABLE"] = "Enable Emotes (When Out of Combat)"
L["PRAISE_EMOTES_DESCRIPTION"] = "Emote your appreciation. Emotes are held back while you are in combat."
L["PRAISE_EMOTES_SELECT"] = "Select Emotes"
L["PRAISE_DELAY_ENABLE"] = "Enable Praise Delay"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Wait a moment before the whisper and the emote, so your thanks doesn't land in the same instant as the buff.\n\nNotifications are not affected."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "How long to wait before praising the player who buffed you."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Enable Print Out Messages"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Print a message to your own chat when you receive a buff. Only you see it."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Enable Sound Effects"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Play a sound when you receive a buff. Only you hear it."

--------------------------------------------------------------------------------
-- Tracked Ability Groups
--------------------------------------------------------------------------------

-- Labels for multi-member tracked groups (Data/Tracked-Abilities.lua). Single
-- spells and items take their names from the client and need no key here.
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
L["BUTTON_DESCRIPTION"] = "Thank your current target with an emote and a whisper."
L["BUTTON_CREATE_MACRO"] = "Create Macro"
L["BUTTON_CREATE_MACRO_DESCRIPTION"] = "Automatically creates a macro named %s when you log in."
L["BUTTON_WHISPER"] = "Whisper Message"
L["BUTTON_RESET"] = "Reset"
L["BUTTON_RESET_DESCRIPTION"] = "Reset the whisper message to the default text."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Thanks, you're the best! (="

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
