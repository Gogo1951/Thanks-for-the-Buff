local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "enUS", true)
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
	"Version %s. Settings (including the option to disable this message) are under Options > AddOns > Thanks for the Buff (TFTB). Enjoying this add-on? Tell a friend, Favorite it on CurseForge, or Star it on GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] = "As a safety precaution, the Options Interface cannot be opened during combat."

-- Buff print out
L["MESSAGE_BUFFED"] = "%s buffed you with %s!"

-- Thank-you
L["MESSAGE_WHISPER_THANKS"] = "Thanks for the %s"
L["MESSAGE_SELECT_PLAYER"] = "Target a player first."
L["MESSAGE_CANT_THANK_SELF"] = "You can't thank yourself!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Unknown Spell"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Enable Welcome Message"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Prints a message only you can see when you log in."
L["OPTIONS_DESCRIPTION"] =
	"Auto thank every player who buffs you with a whisper or emote, and thank anyone by hand with a click of your Thank You macros. Manners, automated."
L["OPTIONS_FEATURES_HEADER"] = "Features"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Turn each feature on or off here, or on its own panel."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Opens the Options Interface for this add-on."
L["SAMPLE_EXAMPLE"] = "Example: %s"

-- Looking for Other Features?
L["OPTIONS_GOOD_TO_GO_HEADER"] = "Looking for Other Features?"
L["OPTIONS_GOOD_TO_GO_DESCRIPTION"] =
	"Some features have moved to our new add-on, Good to Go. Find it on CurseForge or Wago."

--------------------------------------------------------------------------------
-- Options: Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "Help Thanks for the Buff (TFTB) Level Up"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"This add-on was built by players who love this game and want to make it as fun as possible for everyone. We'll never ask for donations. The real satisfaction comes from knowing our work makes the game a little better for you. If it does, we'd love to hear about it!"
L["OPTIONS_LEVEL_UP_WAYS"] = "Here are a few ways you can help us reach more players."
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• Share Feedback: Found a bug or have an idea? Let us know on Discord. Your feedback helps us improve the add-on, and pull requests are always welcome."
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• Tell a Friend: Know someone who might enjoy this add-on? Tell them about it. Word of mouth helps more players discover great add-ons."
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	"• Favorite on CurseForge: Open the CurseForge link below, sign in, and click the star beneath the Download button. Favorites help more players discover the add-on."
L["OPTIONS_LEVEL_UP_GITHUB"] =
	"• Star on GitHub: Open the GitHub link below, sign in, and click Star in the top right. Stars help the project qualify for more free developer tools."
L["OPTIONS_LEVEL_UP_THANKS"] = "Thanks for choosing Thanks for the Buff (TFTB)!"

L["OPTIONS_FEEDBACK"] = "Feedback & Support"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "Feedback & Support Links"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "To copy a link, click its box, then press Ctrl+A and Ctrl+C."
L["OPTIONS_VERSION"] = "Version %s"

--------------------------------------------------------------------------------
-- Options: Stranger Buffs
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Stranger Buffs"
L["STRANGERS_ENABLE"] = "Enable Thanks for Stranger Buffs"
L["STRANGERS_ENABLE_DESCRIPTION"] = "Turns on thanks for buffs from players outside your group."
L["STRANGERS_DESCRIPTION"] = "Thank players outside your group when they buff you out in the open world."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["STRANGERS_OVERALL_COOLDOWN"] = "Praise Cooldown"
L["STRANGERS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Sets the delay between one round of praise and the next, no matter who buffed you. Set to zero to praise every buff."
L["STRANGERS_SOURCE_COOLDOWN"] = "Same-Player Praise Cooldown"
L["STRANGERS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Sets the delay between praise aimed at the same player. Set to zero to praise every buff."
L["STRANGERS_MIN_DURATION"] = "Minimum Buff Duration"
L["STRANGERS_MIN_DURATION_DESCRIPTION"] = "Ignores buffs shorter than this. Set to zero to react to every buff."

--------------------------------------------------------------------------------
-- Options: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers the Stranger Buffs panel is built from: what the
    other player sees, then what only you get. Key prefixes match the header
    the control appears under.
]]
L["PRAISE_HEADER"] = "Praise Whispers & Emotes"
L["NOTIFICATIONS_HEADER"] = "Notifications"
L["PRAISE_DESCRIPTION"] = "What the other player sees: a thank-you whisper, an emote, or both."
L["NOTIFICATIONS_DESCRIPTION"] = "What only you get: a print out, a sound, or both."

-- Also titles the Thank You Button's emote grid, so it carries no PRAISE_ prefix.
L["EMOTES_SELECT"] = "Select Emotes"

L["PRAISE_WHISPER_ENABLE"] = "Enable Thank-You Whispers"
L["PRAISE_WHISPER_DESCRIPTION"] = "Whispers a thank-you to the player who buffed you."
L["PRAISE_EMOTES_ENABLE"] = "Enable Emotes"
L["PRAISE_EMOTES_DESCRIPTION"] = "Shows your appreciation with an emote. Emotes are held back while you are in combat."
L["PRAISE_DELAY_ENABLE"] = "Enable Praise Delay"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Waits a moment before the whisper and the emote, so your thanks don't land in the same instant as the buff. Notifications are unaffected."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Sets how long to wait before the whisper and the emote go out."

L["NOTIFICATIONS_PRINT_ENABLE"] = "Enable Print Outs"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Prints a message only you can see when you receive a buff."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Enable Sound Effects"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Plays a sound when you receive a buff. Only you hear it."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Plays the sound so you can hear it before turning it on."

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["TAB_THANK_YOU_BUTTON"] = "Thank You Button"
L["BUTTON_DESCRIPTION"] = "Whisper and emote at your target with a single keypress. Civility, automated."
-- One heading per button, numbered; %d is the button's position in the list.
L["BUTTON_SECTION"] = "Thank You Button %d"
L["BUTTON_EMOTE"] = "Emote"
L["BUTTON_EMOTE_DESCRIPTION"] = "Sets the emote this button performs at your target, or None for no emote."
L["BUTTON_EMOTE_NONE"] = "None"
L["BUTTON_ICON"] = "Icon"
L["BUTTON_ICON_DESCRIPTION"] = "Sets the icon this button's macro shows in your macro list and on your action bars."
-- The Icon dropdown's first choice, the macros' own icon; every other choice is a picture alone.
L["BUTTON_ICON_DEFAULT"] = "Default"
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Enable Macro "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "Creates a macro named %s and deletes it again when you turn this off."
L["BUTTON_WHISPER_DESCRIPTION"] = "Sets what this button whispers to your target. Leave it empty to send no whisper."

-- Each button's whisper box
L["WHISPER_MESSAGE"] = "Whisper Message"
L["WHISPER_MESSAGE_RESET"] = "Reset"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Resets the whisper message to the default text."

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
