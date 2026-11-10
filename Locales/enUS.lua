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

-- Thank You Button
L["MESSAGE_SELECT_PLAYER"] = "Target a player first."
L["MESSAGE_CANT_THANK_SELF"] = "You can't thank yourself!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

L["UNKNOWN_SPELL"] = "Unknown Spell"
L["SAMPLE_EXAMPLE"] = "Example: %s"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Enable Welcome Message"
L["OPTIONS_WELCOME_DESCRIPTION"] = "Prints a message only you can see when you log in."
L["OPTIONS_DESCRIPTION"] =
	"Auto thank players who buff you with an emote or whisper, greet friends and guildmates with a wave as you pass them, and thank anyone you target with one click of your Thank You macros."
L["OPTIONS_FEATURES_HEADER"] = "Features"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Turn each feature on or off here, or on its own panel."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Opens the Options Interface for this add-on."

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
-- Options: Give Thanks
--------------------------------------------------------------------------------

L["TAB_GIVE_THANKS"] = "Give Thanks"
L["GIVE_THANKS_ENABLE"] = "Enable Give Thanks"
L["GIVE_THANKS_ENABLE_DESCRIPTION"] = "Turns on thanks for buffs from players outside your group."
L["GIVE_THANKS_DESCRIPTION"] = "Thank players outside your group when they buff you out in the open world."

-- Praise Limits
L["PRAISE_HEADER"] = "Praise Limits"
L["PRAISE_DESCRIPTION"] = "These hold back both the emote and the whisper, so a wave of buffs never turns into spam."
-- The dropdown values carry the unit, so these labels do not repeat it.
L["GIVE_THANKS_OVERALL_COOLDOWN"] = "Praise Cooldown"
L["GIVE_THANKS_OVERALL_COOLDOWN_DESCRIPTION"] =
	"Sets the delay between one round of praise and the next, no matter who buffed you. Set to zero to praise every buff."
L["GIVE_THANKS_SOURCE_COOLDOWN"] = "Same-Player Praise Cooldown"
L["GIVE_THANKS_SOURCE_COOLDOWN_DESCRIPTION"] =
	"Sets the delay between praise aimed at the same player. Set to zero to praise every buff."
L["GIVE_THANKS_MIN_DURATION"] = "Minimum Buff Duration"
L["GIVE_THANKS_MIN_DURATION_DESCRIPTION"] = "Ignores buffs shorter than this. Set to zero to react to every buff."
L["PRAISE_DELAY_ENABLE"] = "Enable Praise Delay"
L["PRAISE_DELAY_DESCRIPTION"] =
	"Waits a moment before the whisper and the emote, so your thanks don't land in the same instant as the buff. Notifications are unaffected."
L["PRAISE_DELAY_LENGTH_DESCRIPTION"] = "Sets how long to wait before the whisper and the emote go out."

-- Thank-You Whispers
L["WHISPERS_HEADER"] = "Thank-You Whispers"
L["PRAISE_WHISPER_ENABLE"] = "Enable Thank-You Whispers"
L["PRAISE_WHISPER_DESCRIPTION"] = "Whispers a thank-you to the player who buffed you."
-- TRANSLATORS: keep {spell} exactly as written; it is the token players type into the whisper.
L["PRAISE_WHISPER_MESSAGE_DESCRIPTION"] =
	"Sets what TFTB whispers to the player who buffed you. {spell} becomes the buff. Leave it empty to send no whisper."

-- Notifications
L["NOTIFICATIONS_HEADER"] = "Notifications"
L["NOTIFICATIONS_DESCRIPTION"] = "What only you get: a print out, a sound, or both."
L["NOTIFICATIONS_PRINT_ENABLE"] = "Enable Print Outs"
L["NOTIFICATIONS_PRINT_DESCRIPTION"] = "Prints a message only you can see when you receive a buff."
L["NOTIFICATIONS_SOUND_ENABLE"] = "Enable Sound Effects"
L["NOTIFICATIONS_SOUND_DESCRIPTION"] = "Plays a sound when you receive a buff. Only you hear it."
L["NOTIFICATIONS_SOUND_PREVIEW_DESCRIPTION"] = "Plays the sound so you can hear it before turning it on."

--------------------------------------------------------------------------------
-- Options: Emotes List
--------------------------------------------------------------------------------

L["TAB_EMOTES_LIST"] = "Emotes List"
L["EMOTES_GRID_DESCRIPTION"] =
	"Check the emotes Give Thanks can pick from when a player outside your group buffs you; it uses one at random. Emotes are held back while you are in combat."

--[[
    The emote checklist, shared by this panel and Wave to Friends' Friends and
    Guilds tabs. Its group keys are EMOTE_GROUP_ plus each Data.EMOTE_GROUPS
    entry, upper-cased.
]]
L["EMOTE_GROUP_COUNT"] = "%s (%d of %d Checked)"
L["EMOTE_GROUP_TEXT"] = "Text"
L["EMOTE_GROUP_TEXT_DESCRIPTION"] = "Shows the emote line only."
L["EMOTE_GROUP_VOICE"] = "Voice"
L["EMOTE_GROUP_VOICE_DESCRIPTION"] = "Plays a voice line."
L["EMOTE_GROUP_GESTURE"] = "Gesture"
L["EMOTE_GROUP_GESTURE_DESCRIPTION"] = "Plays a short animation."
L["EMOTE_GROUP_POSE"] = "Pose"
L["EMOTE_GROUP_POSE_DESCRIPTION"] = "Holds until you move."
L["EMOTES_RESET"] = "Reset Emotes"
L["EMOTES_RESET_DESCRIPTION"] = "Puts the checklist back to the default praise emotes."
L["EMOTES_RESET_CONFIRM"] = "Reset the emote checklist to the defaults?"

--------------------------------------------------------------------------------
-- Options: Ignored Buffs
--------------------------------------------------------------------------------

L["TAB_IGNORED_BUFFS"] = "Ignored Buffs"
L["IGNORED_BUFFS_DESCRIPTION"] =
	"Buffs on this list never get a thank-you, whoever casts them. You still get your print out and sound."
L["IGNORED_BUFFS_ADD_CURRENT"] = "Ignore Current Buff"
L["IGNORED_BUFFS_ADD_CURRENT_DESCRIPTION"] = "Adds one of the buffs on you right now."
L["IGNORED_BUFFS_ADD"] = "Add Buff"
L["IGNORED_BUFFS_ADD_DESCRIPTION"] = "Type a spell ID, or Shift-click a buff's link into the box, then press Enter."
L["IGNORED_BUFFS_EMPTY"] = "No buffs ignored yet. Add one above."
L["IGNORED_BUFFS_REMOVE"] = "Removes this buff from the list."
L["IGNORED_BUFFS_NOT_FOUND"] = "No buff found for %s."
L["IGNORED_BUFFS_ALL_CHARACTERS"] = "All Characters"
L["IGNORED_BUFFS_PROMOTE_DESCRIPTION"] =
	"Moves this buff to the All Characters list, so it's never thanked on any character."

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
-- Titles Thank You Button 1's emote checklist.
L["EMOTES_SELECT"] = "Select Emotes"
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

--------------------------------------------------------------------------------
-- Options: Wave to Friends
--------------------------------------------------------------------------------

L["TAB_WAVE_TO_FRIENDS"] = "Wave to Friends"
L["WAVE_ENABLE"] = "Enable Wave to Friends"
L["WAVE_ENABLE_DESCRIPTION"] = "Turns on an emote for friends and guildmates when you mouse over them."
L["WAVE_DESCRIPTION"] = "Greet friends and guildmates with an emote when you mouse over them out in the world."
L["WAVE_RULES"] = "Never your party or raid, and never in combat."
L["WAVE_RESTING_ENABLE"] = "Only While Resting"
L["WAVE_RESTING_ENABLE_DESCRIPTION"] = "Waves only while you are resting, in a town or an inn."
L["WAVE_COOLDOWN"] = "Same-Player Cooldown"
L["WAVE_COOLDOWN_DESCRIPTION"] = "Sets how long before the same player can be greeted again."
L["WAVE_COOLDOWN_ONCE_PER_SESSION"] = "Once per Session"
-- %s is the default emotes' slash commands, as the client names them.
L["WAVE_EMOTES_RESET_DEFAULTS_DESCRIPTION"] = "Puts the checklist back to %s only."

-- Custom List
L["WAVE_TAB_CUSTOM"] = "Custom List"
L["WAVE_CUSTOM_DESCRIPTION"] =
	"Players who always get their own emote, even over Friends and Guilds. Pick None to never emote at someone."
-- One of these two follows WAVE_CUSTOM_DESCRIPTION: realm clients, then WoW Forever, which has no realms.
L["WAVE_CUSTOM_NAMES_REALM"] = "Name-Realm matches that realm only; a bare name matches any realm."
L["WAVE_CUSTOM_NAMES_FOREVER"] = "A full name matches one character; a first name alone matches everyone with it."
L["WAVE_CUSTOM_ENABLE"] = "Enable Custom List"
L["WAVE_CUSTOM_ENABLE_DESCRIPTION"] = "Uses the names below before Friends and Guilds."
L["WAVE_CUSTOM_OFF_WARNING"] = "The Custom List is off, so nobody below gets their emote."
L["WAVE_CUSTOM_ADD"] = "Add Player"
L["WAVE_CUSTOM_ADD_DESCRIPTION"] = "Type a name or Name-Realm, then press Enter. Separate several names with commas."
L["WAVE_CUSTOM_ADD_DESCRIPTION_FOREVER"] =
	"Type a full name or a first name, then press Enter. Separate several names with commas."
L["WAVE_CUSTOM_EMPTY"] = "No players yet. Add one above."
L["WAVE_CUSTOM_EMOTE_DESCRIPTION"] = "Sets the emote for this player, or None to never emote at them."
L["WAVE_CUSTOM_REMOVE"] = "Removes this player from the list."

-- Friends
L["WAVE_TAB_FRIENDS"] = "Friends"
L["WAVE_FRIENDS_ENABLE"] = "Wave at Friends"
L["WAVE_FRIENDS_ENABLE_DESCRIPTION"] = "Greets characters on your friends list."
L["WAVE_BNET_ENABLE"] = "Include Battle.net Friends"
L["WAVE_BNET_ENABLE_DESCRIPTION"] = "Also greets the characters your Battle.net friends are playing."
L["WAVE_FRIENDS_EMOTES_DESCRIPTION"] = "Check the emotes to pick from for friends; one is used at random."

-- Guilds
L["WAVE_TAB_GUILDS"] = "Guilds"
L["WAVE_MY_GUILD_ENABLE"] = "Wave at My Guild"
L["WAVE_MY_GUILD_ENABLE_DESCRIPTION"] = "Greets members of the guild you are in."
L["WAVE_GUILD_ADD"] = "Add Guild"
L["WAVE_GUILD_ADD_DESCRIPTION"] =
	"Type a guild's name, then press Enter. Separate several guilds with commas. Capitals don't matter."
L["WAVE_GUILDS_EMPTY"] = "No other guilds yet. Add one above."
L["WAVE_GUILD_REMOVE"] = "Removes this guild from the list."
L["WAVE_GUILDS_EMOTES_DESCRIPTION"] = "Check the emotes to pick from for guild members; one is used at random."

--------------------------------------------------------------------------------
-- Options: Whisper Message Row
--------------------------------------------------------------------------------

-- The caption and Reset button beside every whisper box, on Give Thanks and each Thank You Button.
L["WHISPER_MESSAGE"] = "Whisper Message"
L["WHISPER_MESSAGE_RESET"] = "Reset"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Resets the whisper message to the default text."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Thanks, you're the best! (="
-- TRANSLATORS: keep {spell} exactly as written; TFTB swaps in the buff's link.
L["DEFAULT_GIVE_THANKS_WHISPER"] = "Thanks for the {spell}"
