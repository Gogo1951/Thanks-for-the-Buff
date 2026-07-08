local L = LibStub("AceLocale-3.0"):NewLocale("TFTB", "enUS", true)
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
L["CHAT_LOADED"] = "Version %s. Settings (including the option to disable this message) can be found under Options > AddOns > Thanks for the Buff. Enjoying the add-on? Tell a friend about it! (="
L["MSG_RESET"] = "All settings have been reset to defaults."

-- Buff & gift announcements
L["MSG_BUFFED"] = "%s buffed you with %s!"
L["MSG_GAVE_YOU"] = "%s gave you %s!"
L["MSG_GAVE_GROUP"] = "%s gave your group %s!"
L["MSG_USED_ITEM"] = "%s used %s %s on you!"
L["MSG_USED_SPELL"] = "%s used %s on you!"
L["MSG_SET_OUT"] = "%s set out %s!"
L["MSG_OPENED"] = "%s opened %s!"

-- Thank-you
L["MSG_WHISPER_THANKS"] = "Thanks for the %s!"
L["MSG_SELECT_PLAYER"] = "Select a player to thank."
L["MSG_CANT_THANK_SELF"] = "You can't thank yourself!"

--------------------------------------------------------------------------------
-- Text Fragments
--------------------------------------------------------------------------------

-- Pronouns substituted into MSG_USED_ITEM by the buffer's gender.
L["PRONOUN_HIS"] = "his"
L["PRONOUN_HER"] = "her"
L["PRONOUN_THEIR"] = "their"
L["UNKNOWN_SPELL"] = "Unknown Spell"

--------------------------------------------------------------------------------
-- Options: Main Panel
--------------------------------------------------------------------------------

L["OPTIONS_WELCOME_TOGGLE"] = "Enable Welcome Message"
L["OPTIONS_WELCOME_DESC"] = "Print a message to chat when you log in."
L["OPTIONS_RESET_ALL_PROFILES"] = "Reset All Profiles"
L["OPTIONS_RESET_ALL_PROFILES_DESCRIPTION"] = "Reset every profile on this account back to default settings."
L["OPTIONS_RESET_ALL_PROFILES_CONFIRM"] = "This will reset ALL profiles on your account back to default settings — every character. There is no undo. Continue?"
L["OPTIONS_DESCRIPTION"] = "Automatically express appreciation with emotes and messages whenever you receive a buff — whether it's a stranger buffing you in the open world or a teammate popping a cooldown for you in combat."
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
L["STRANGERS_DESC"] = "A buff on you from a player outside your group (open world)."
L["STRANGERS_COOLDOWN"] = "Cooldown (Seconds)"
L["STRANGERS_COOLDOWN_DESC"] = "At most, how often to emote at the same player.\n\nMessages are not affected; they fire for every buff."
L["STRANGERS_MIN_DURATION"] = "Minimum Buff Duration (Seconds)"
L["STRANGERS_MIN_DURATION_DESC"] = "Minimum duration the buff must last to trigger a thank you.\n\nFilters out short heals over time like Renew or Rejuvenation."
L["STRANGERS_MESSAGING"] = "Messaging"
L["STRANGERS_EMOTES_SELECT"] = "Select Emotes"

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

L["TEAMMATES_TITLE"] = "Buffs from Teammates"
L["TEAMMATES_DESC"] = "A party or raid member's buff or cooldown cast on you."
L["SERVICES_TITLE"] = "Group Services"
L["SERVICES_DESC"] = "A party or raid member's raid-wide help — feasts, soulwells, portals, repair bots."
L["COMBAT_MESSAGING"] = "Messaging"
L["COMBAT_EMOTES_SELECT"] = "Select Emotes"
L["COMBAT_TRACKED"] = "Tracked Abilities:"
L["COMBAT_TOGGLE_TRACKING"] = "Toggle tracking for %s"
L["COMBAT_GROUP_ITEMS"] = "Items"
L["COMBAT_ITEM_PENDING"] = "Item #%d"

--------------------------------------------------------------------------------
-- Options: Thank You Button
--------------------------------------------------------------------------------

L["BUTTON_TITLE"] = "Thank You Button"
L["BUTTON_DESC"] = "Thank your current target with an emote and a whisper."
L["BUTTON_CREATE_MACRO"] = "Create Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "A macro named %s will be automatically created for you on sign-in."
L["BUTTON_WHISPER"] = "Whisper Message"
L["BUTTON_RESET"] = "Reset"
L["BUTTON_RESET_DESC"] = "Reset the whisper message to the default text."
L["BUTTON_EMOTES_SELECT"] = "Select Emotes"

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_PRINT_ENABLE"] = "Enable Print Out Messages (Self-Only)"
L["MESSAGING_PRINT_DESC"] = "Print a message to your own chat when you receive a buff. Only you see it."
L["MESSAGING_WHISPER_ENABLE"] = "Enable Thank You Messages"
L["MESSAGING_WHISPER_DESC"] = "Whisper a thank-you to the player who buffed you."
L["MESSAGING_EMOTES_ENABLE"] = "Enable Emotes (When Out of Combat)"
L["MESSAGING_EMOTES_DESC"] = "Emote your appreciation. Emotes are held back while you are in combat."

--------------------------------------------------------------------------------
-- Defaults
--------------------------------------------------------------------------------

L["DEFAULT_WHISPER"] = "Thanks, you're the best! (="

--------------------------------------------------------------------------------
-- Emotes
--------------------------------------------------------------------------------

L["EMOTE_CHEER_DESC"] = "You cheer at <Target>."
L["EMOTE_DRINK_DESC"] = "You raise a drink to <Target>."
L["EMOTE_FLEX_DESC"] = "You flex at <Target>."
L["EMOTE_GRIN_DESC"] = "You grin wickedly at <Target>."
L["EMOTE_HIGHFIVE_DESC"] = "You high-five <Target>."
L["EMOTE_PRAISE_DESC"] = "You praise <Target>."
L["EMOTE_SALUTE_DESC"] = "You salute <Target> with respect."
L["EMOTE_SMILE_DESC"] = "You smile at <Target>."
L["EMOTE_THANK_DESC"] = "You thank <Target>."
L["EMOTE_WHOA_DESC"] = "You look at <Target> and exclaim 'Whoa!'"
L["EMOTE_WINK_DESC"] = "You wink at <Target>."
L["EMOTE_YES_DESC"] = "You nod at <Target>."
