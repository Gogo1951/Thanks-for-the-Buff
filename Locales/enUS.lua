local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "enUS", true)
if not L then return end

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["MSG_ENABLED"] = "Enabled. Use /tftb to adjust your settings; including turning off this message. (="
L["MSG_DB_ERROR"] = "Error: Database defaults failed to load. Please reset your profile via /tftb."
L["MSG_RESET"] = "All settings have been reset to defaults."
L["MSG_BUFFED"] = "%s buffed you with %s!"
L["MSG_HIT"] = "%s hit you with %s!"
L["MSG_PARTY_ITEM"] = "%s used %s for your party!"
L["MSG_WHISPER_THANKS"] = "Thanks for the %s!"
L["MSG_SELECT_PLAYER"] = "Select a player to thank."
L["MSG_CANT_THANK_SELF"] = "You can't thank yourself!"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_TITLE"] = "Thanks for the Buff!"
L["OPTIONS_GENERAL"] = "General Settings"
L["OPTIONS_WELCOME_TOGGLE"] = "Enable Welcome Message"
L["OPTIONS_WELCOME_DESC"] = "Print a message to chat when you log in."
L["OPTIONS_RESET"] = "Reset"
L["OPTIONS_RESET_ALL"] = "Reset All Settings"
L["OPTIONS_RESET_ALL_DESC"] = "Restore every option to its default value."
L["OPTIONS_RESET_CONFIRM"] = "Are you sure you want to reset all settings to their defaults?"
L["OPTIONS_DESCRIPTION"] = "Automatically express happiness with an emote whenever you receive a new buff."
L["OPTIONS_SUPPORT"] = "Feedback & Support"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Opens the Thanks for the Buff options interface."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Emotes and whispers your targeted player."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["STRANGERS_TITLE"] = "Buffs from Strangers"
L["STRANGERS_ENABLE"] = "React to Buffs from Strangers"
L["STRANGERS_COOLDOWN"] = "Cooldown (Seconds)"
L["STRANGERS_COOLDOWN_DESC"] = "At most, how often to thank the same player."
L["STRANGERS_MIN_DURATION"] = "Minimum Buff Duration (Seconds)"
L["STRANGERS_MIN_DURATION_DESC"] = "Minimum duration the buff must last to trigger a thank you.\n\nFilters out short heals over time like Renew or Rejuvenation."
L["STRANGERS_MESSAGING"] = "Messaging"
L["STRANGERS_EMOTES_ENABLE"] = "Enable Emotes"
L["STRANGERS_EMOTES_DESC"] = "Emote your appreciation for buffs from strangers."
L["STRANGERS_EMOTES_SELECT"] = "Select Emotes"

--------------------------------------------------------------------------------
-- Options: Combat Buffs
--------------------------------------------------------------------------------

L["COMBAT_TITLE"] = "Combat Buffs"
L["COMBAT_MESSAGING"] = "Messaging"
L["COMBAT_TRACKED"] = "Tracked Abilities:"
L["COMBAT_TOGGLE_TRACKING"] = "Toggle tracking for %s"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Thank You Button"
L["BUTTON_CREATE_MACRO"] = "Create Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "A macro named %s will be automatically created for you on sign-in."
L["BUTTON_WHISPER"] = "Whisper Message"
L["BUTTON_RESET"] = "Reset"
L["BUTTON_RESET_DESC"] = "Reset the whisper message to the default text."
L["BUTTON_EMOTES_HEADER"] = "Thank You Button Emotes:"
L["BUTTON_EMOTES_SELECT"] = "Select Emotes"

--------------------------------------------------------------------------------
-- Shared: Messaging Dropdown
--------------------------------------------------------------------------------

L["MESSAGING_NONE"] = "No Message"
L["MESSAGING_NONE_DEFAULT"] = "No Message (Default)"
L["MESSAGING_PRINT"] = "Print-out Message (Self Only)"
L["MESSAGING_WHISPER"] = "Whisper Message"

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Thanks, you're the best! (="