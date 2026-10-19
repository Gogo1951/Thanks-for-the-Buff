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
-- Messages
--------------------------------------------------------------------------------

-- System
L["CHAT_LOADED"] =
	"Version %s. Settings (including the option to disable this message) are under Options > AddOns > Thanks for the Buff (TFTB). Enjoying this add-on? Tell a friend, Favorite it on CurseForge, or Star it on GitHub. (="
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
L["MESSAGE_WHISPER_THANKS"] = "Thanks for the %s"
L["MESSAGE_SELECT_PLAYER"] = "Target a player first."
L["MESSAGE_CANT_THANK_SELF"] = "You can't thank yourself!"

-- Peer Pressure
L["MESSAGE_PEER_PRESSURE"] = "%s used %s!"
L["MESSAGE_PEER_PRESSURE_TARGET"] = "%s used %s on %s!"

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
	"Thank every player who buffs you with a whisper or emote, and see who's missing your raid buffs with a click-to-cast buff tracker. Plus alerts for feasts, portals, summons, soulwells, and class cooldowns. Manners, automated."
L["OPTIONS_FEATURES_HEADER"] = "Features"
L["OPTIONS_FEATURES_DESCRIPTION"] = "Turn each feature on or off here, or on its own panel."
L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/tftb"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Opens the Options Interface for this add-on."
L["OPTIONS_EXAMPLE"] = "Example: %s"

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
-- Options: Buff Panels
--------------------------------------------------------------------------------

-- Stranger Buffs
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

-- Teammate Buffs
L["TAB_TEAMMATES"] = "Teammate Buffs"
L["TEAMMATES_ENABLE"] = "Enable Thanks for Teammate Buffs"
L["TEAMMATES_ENABLE_DESCRIPTION"] =
	"Turns on thanks for the buffs and cooldowns your party or raid members cast on you."
L["TEAMMATES_DESCRIPTION"] = "Thank party and raid members for the buffs and cooldowns they cast on you."

-- Service Alerts
L["TAB_SERVICES"] = "Service Alerts"
L["SERVICES_ENABLE"] = "Enable Service Alerts"
L["SERVICES_ENABLE_DESCRIPTION"] =
	"Turns on alerts for feasts, soulwells, portals, and other help set out for your group."
L["SERVICES_DESCRIPTION"] =
	"React when someone sets out help for your group: feasts, soulwells, portals, and repair bots."

-- Send Good News
L["TAB_GOOD_NEWS"] = "Send Good News"
L["GOOD_NEWS_DESCRIPTION"] = "Let the players you buff know what you cast on them, and how long it lasts."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Enable Good News"
L["GOOD_NEWS_WHISPER_DESCRIPTION"] = "Whispers the player you buffed to tell them what they got and for how long."
L["GOOD_NEWS_SCOPE"] = "Recipients"
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Anyone You Buff"
L["GOOD_NEWS_SCOPE_GROUP"] = "Only Group Members"
L["GOOD_NEWS_SCOPE_DESCRIPTION"] = "Sets who gets a Good News whisper: anyone you buff, or only your group members."
L["GOOD_NEWS_MESSAGES_HEADER"] = "Good News Message"
L["GOOD_NEWS_MESSAGES_DESCRIPTION"] = "The whisper the players you buff receive."
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
L["PEER_PRESSURE_ENABLE_DESCRIPTION"] = "Turns on alerts when another player of your class uses a tracked cooldown."
L["PEER_PRESSURE_PRINT_DESCRIPTION"] = "Prints a message only you can see when a same-class cooldown is used."
L["PEER_PRESSURE_OWN_CASTS"] = "Trigger on Own Casts"
L["PEER_PRESSURE_OWN_CASTS_DESCRIPTION"] =
	"Also triggers when you use your own cooldowns, not just when other players do."
L["PEER_PRESSURE_SOUND_DESCRIPTION"] = "Plays a sound when a same-class cooldown is used. Only you hear it."

-- Shared across the buff panels
L["TRACKED_HEADER"] = "Tracked Abilities"
L["TRACKED_GROUP_ITEMS"] = "Items"
L["TRACKED_TOGGLE_DESCRIPTION"] = "Toggles tracking for %s."
L["TRACKED_ITEM_PENDING"] = "Item #%d"
L["TRACKED_SPELL_PENDING"] = "Spell #%d"

-- Shared by Send Good News and the Thank You Button
L["WHISPER_MESSAGE"] = "Whisper Message"
L["WHISPER_MESSAGE_RESET"] = "Reset"
L["WHISPER_MESSAGE_RESET_DESCRIPTION"] = "Resets the whisper message to the default text."

--------------------------------------------------------------------------------
-- Shared: Praise and Notifications
--------------------------------------------------------------------------------

--[[
    The two section headers every buff panel is built from: what the other player
    sees, then what only you get. Peer Pressure sends nothing outward, so it
    carries the Notifications header alone. Key prefixes match the header the
    control appears under.
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
-- Tracked Ability Groups
--------------------------------------------------------------------------------

--[[
    Labels for multi-member tracked groups that no single game record names
    (Data/{Game}/Tracked-Abilities-{Game}.lua). Single spells and items, and a
    group named after one of its own items, take their names from the client.
]]
L["GROUP_PORTALS"] = "Portals"
L["GROUP_RESISTANCE_CAULDRONS"] = "Resistance Cauldrons"
L["GROUP_REPAIR_BOTS"] = "Repair Bots"

--------------------------------------------------------------------------------
-- Options: Buff Duty
--------------------------------------------------------------------------------

L["TAB_BUFF_WINDOW"] = "Buff Duty"
L["BUFF_WINDOW_DESCRIPTION"] = "Shows who's missing your buffs. Click an icon to cast."
L["BUFF_WINDOW_ENABLE"] = "Enable Buff Duty"
L["BUFF_WINDOW_ENABLE_DESCRIPTION"] = "Turns on Buff Duty, the window of group members missing a buff you can give."
L["BUFF_WINDOW_NO_BUFFS"] = "Your class has no buffs on this list, so the window never appears on this character."
L["BUFF_WINDOW_HEADER"] = "Window"
L["BUFF_WINDOW_WINDOW_DESCRIPTION"] = "Keep the window where you put it, or out of the way in combat."
L["BUFF_WINDOW_LOCK"] = "Lock Window"
L["BUFF_WINDOW_LOCK_DESCRIPTION"] = "Stops the window from moving. Unlocked, drag it by its background."
L["BUFF_WINDOW_HIDE_IN_COMBAT"] = "Hide in Combat"
L["BUFF_WINDOW_HIDE_IN_COMBAT_DESCRIPTION"] =
	"Hides the window during combat. The list can't update in combat, so a window left showing keeps its last state until combat ends."
L["BUFF_WINDOW_SHOW_HEADER"] = "Show in Window"
L["BUFF_WINDOW_SHOW_DESCRIPTION"] = "Add your own buffs, the strangers who buffed you, and your target to the window."
L["BUFF_WINDOW_FAVOR_ENABLE"] = "Return the Favor"
L["BUFF_WINDOW_FAVOR_ENABLE_DESCRIPTION"] =
	"Lists the strangers who recently buffed you, with the buffs you can give them back. Right-click an icon to take someone off the list."
L["BUFF_WINDOW_FAVOR_SECONDS_DESCRIPTION"] = "Sets how long a stranger stays on the list after their last buff."
L["BUFF_WINDOW_TARGET_ENABLE"] = "Your Target"
L["BUFF_WINDOW_TARGET_ENABLE_DESCRIPTION"] =
	"Lists your target when they are a player outside your group missing a buff you can give."
L["BUFF_WINDOW_REFRESH"] = "Refresh Under"
L["BUFF_WINDOW_REFRESH_DESCRIPTION"] =
	"Sets how little time a buff can have left before it counts as missing, so you can top it up before it drops. A buff that lasts no longer than this only counts once it's gone."
L["BUFF_WINDOW_PETS_AS_TANKS"] = "Consider Pets as Tanks"
L["BUFF_WINDOW_PETS_AS_TANKS_DESCRIPTION"] =
	"Offers pets the buffs you set to Tanks, like Thorns, as well as the ones for Everyone."
L["BUFF_WINDOW_PETS_AS_TANKS_WHEN_DESCRIPTION"] = "Sets when pets count as tanks."
L["BUFF_WINDOW_PETS_AS_TANKS_SOLO"] = "When Not in a Group"
L["BUFF_WINDOW_PETS_AS_TANKS_ALWAYS"] = "Always"
-- Who each buff is offered to: one dropdown per buff, these four choices.
L["BUFF_WINDOW_AUDIENCE_OFF"] = "Off"
L["BUFF_WINDOW_AUDIENCE_TANK"] = "Tanks"
L["BUFF_WINDOW_AUDIENCE_HEALER"] = "Healers"
L["BUFF_WINDOW_AUDIENCE_ALL"] = "Everyone"
-- The dropdown's tooltip when the client has no description for the spell yet.
L["BUFF_WINDOW_AUDIENCE_DESCRIPTION"] = "Sets who %s is offered to."
L["BUFF_WINDOW_BUFFS_DESCRIPTION"] =
	"Choose who's offered each buff. Tanks and Healers go by group role; anyone without one counts as Damage."

L["BUFF_WINDOW_SELF_DESCRIPTION"] = "Your own buffs, pinned to the top of the window."
--[[
    Muted note after a class name on the Self-Buffs panel, for a family of self
    buffs only one of which can be up at a time. Keyed by the family.
]]
L["BUFF_WINDOW_SELF_NOTE_ASPECT"] = "any one aspect counts"
L["BUFF_WINDOW_SELF_NOTE_MAGE_ARMOR"] = "any one armor counts"
L["BUFF_WINDOW_SELF_NOTE_PALADIN_AURA"] = "any one aura counts"
L["BUFF_WINDOW_SELF_NOTE_SHAMAN_SHIELD"] = "any one shield counts"
L["BUFF_WINDOW_SELF_NOTE_WARLOCK_ARMOR"] = "any one armor counts"
L["BUFF_WINDOW_SELF_REFRESH_OFF"] = "Off"
L["BUFF_WINDOW_SELF_REFRESH_MISSING"] = "When Missing"
-- %s is a duration from the client, like "5 Minutes".
L["BUFF_WINDOW_SELF_REFRESH_UNDER"] = "Under %s"
L["BUFF_WINDOW_SELF_REFRESH_DESCRIPTION"] =
	"Sets when %s shows: never, once it's gone, or once it has less than this left."
L["BUFF_WINDOW_SELF_ENABLE"] = "Your Self-Buffs"
L["BUFF_WINDOW_SELF_ENABLE_DESCRIPTION"] =
	"Shows the buffs only you can put on yourself, like an armor or Inner Fire, at the top of the window when they're missing or running low. Pick which ones under Self-Buffs."

-- The window itself
L["BUFF_WINDOW_SELF_HEADER"] = "Self-Buffs"
L["BUFF_WINDOW_FAVOR_HEADER"] = "Return the Favor"
L["BUFF_WINDOW_TARGET_HEADER"] = "Target"
L["BUFF_WINDOW_TOOLTIP_CAST"] = "Click to cast on %s."
L["BUFF_WINDOW_TOOLTIP_GROUP"] = "Click to cast on %s and their party."
L["BUFF_WINDOW_TOOLTIP_FAVOR"] = "Click to target %s and cast."
L["BUFF_WINDOW_TOOLTIP_DISMISS"] = "Right-click to take %s off the list."

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
--[[
    The toggle owns the macro in both directions, so the label is ENABLE rather
    than CREATE. Both strings carry the macro's name: with five buttons stacked,
    "which macro is this one?" should not need a hover.
]]
L["BUTTON_MACRO_ENABLE"] = 'Enable Macro "%s"'
L["BUTTON_MACRO_ENABLE_DESCRIPTION"] = "Creates a macro named %s and deletes it again when you turn this off."
L["BUTTON_WHISPER_DESCRIPTION"] = "Sets what this button whispers to your target. Leave it empty to send no whisper."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Thanks, you're the best! (="
--[[
    The star marker (left off on WoW Forever) and " // TFTB" sign-off are added
    by the builder, which also drops the closing punctuation; neither is part of
    the editable text.
]]
L["DEFAULT_GOOD_NEWS"] = "You have %a"

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
