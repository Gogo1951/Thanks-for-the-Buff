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
	"Version %s. Settings (including the option to disable this message) can be found under Options > AddOns > Thanks for the Buff. Enjoying the add-on? Tell a friend about it! (="

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
L["MSG_GOODNEWS_DURATION"] = "Good News! You have %s for %s!"
L["MSG_GOODNEWS"] = "Good News! You have %s!"
L["MSG_PEER_PRESSURE"] = "%s used %s!"
L["MSG_PEER_PRESSURE_TARGET"] = "%s used %s on %s!"
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
L["OPTIONS_DESCRIPTION"] =
	"Automatically thank players who buff you with emotes, whispers, and chat notifications, whether it's a stranger in the open world or a teammate's cooldown like Power Infusion or Innervate. Get a heads-up for feasts, portals, and same-class cooldowns too."
L["OPTIONS_SUPPORT"] = "Feedback & Support"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_CMD_TFTB"] = "/tftb"
L["OPTIONS_CMD_TFTB_DESC"] = "Opens the Thanks for the Buff options interface."
L["OPTIONS_CMD_THANKYOU"] = "/thankyou"
L["OPTIONS_CMD_THANKYOU_DESC"] = "Emotes at and whispers your current target."

--------------------------------------------------------------------------------
-- Options: Buffs from Strangers
--------------------------------------------------------------------------------

L["TAB_STRANGERS"] = "Buffs from Strangers"
L["STRANGERS_DESC"] = "A buff on you from a player outside your group (open world)."
L["STRANGERS_COOLDOWN"] = "Cooldown (Seconds)"
L["STRANGERS_COOLDOWN_DESC"] =
	"At most, how often to emote at the same player.\n\nMessages are not affected; they fire for every buff."
L["STRANGERS_MIN_DURATION"] = "Minimum Buff Duration (Seconds)"
L["STRANGERS_MIN_DURATION_DESC"] =
	"Minimum duration the buff must last to trigger a thank-you.\n\nFilters out short heals over time like Renew or Rejuvenation."

--------------------------------------------------------------------------------
-- Options: Buffs from Teammates & Group Services
--------------------------------------------------------------------------------

-- Buffs from Teammates
L["TAB_TEAMMATES"] = "Buffs from Teammates"
L["TEAMMATES_DESC"] = "A party or raid member's buff or cooldown cast on you."

-- Group Services
L["TAB_SERVICES"] = "Group Services"
L["SERVICES_DESC"] = "A party or raid member's raid-wide help: feasts, soulwells, portals, repair bots."

-- Good News (buffs you cast on others)
L["TAB_GOOD_NEWS"] = "Good News"
L["GOOD_NEWS_DESC"] = "Automatically whisper the players you buff about the combat buffs you cast on them."
L["GOOD_NEWS_WHISPER_ENABLE"] = "Enable Good News"
L["GOOD_NEWS_WHISPER_DESC"] = "Whisper the player you buffed to tell them what they got and for how long."
L["GOOD_NEWS_SCOPE_ALWAYS"] = "Anyone You Buff"
L["GOOD_NEWS_SCOPE_GROUP"] = "Only Group Members"

-- Peer Pressure
L["TAB_PEER_PRESSURE"] = "Peer Pressure"
L["PEER_PRESSURE_DESC"] =
	"Get notified when other players of your class use their cooldowns, so you can give in to Peer Pressure."
L["PEER_PRESSURE_ENABLE"] = "Enable Peer Pressure"
L["PEER_PRESSURE_PRINT_DESC"] = "Print a message to your own chat when a same-class cooldown is used. Only you see it."
L["PEER_PRESSURE_OWN_CASTS"] = "Trigger on Own Casts"
L["PEER_PRESSURE_OWN_CASTS_DESC"] = "Also trigger when you use your own cooldowns, not just when other players do."
L["PEER_PRESSURE_SOUND_DESC"] = "Play a sound when a same-class cooldown is used. Only you hear it."

-- Shared across the combat panels
L["COMBAT_TRACKED"] = "Tracked Abilities"
L["COMBAT_GROUP_ITEMS"] = "Items"
L["COMBAT_TOGGLE_TRACKING"] = "Toggle tracking for %s"
L["COMBAT_ITEM_PENDING"] = "Item #%d"
L["COMBAT_SPELL_PENDING"] = "Spell #%d"

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
L["BUTTON_DESC"] = "Thank your current target with an emote and a whisper."
L["BUTTON_CREATE_MACRO"] = "Create Macro"
L["BUTTON_CREATE_MACRO_DESC"] = "Automatically creates a macro named %s when you log in."
L["BUTTON_WHISPER"] = "Whisper Message"
L["BUTTON_RESET"] = "Reset"
L["BUTTON_RESET_DESC"] = "Reset the whisper message to the default text."

--------------------------------------------------------------------------------
-- Shared: Messaging
--------------------------------------------------------------------------------

L["MESSAGING_HEADER"] = "Messaging"
L["MESSAGING_PRINT_ENABLE"] = "Enable Print Out Messages (Self-Only)"
L["MESSAGING_PRINT_DESC"] = "Print a message to your own chat when you receive a buff. Only you see it."
L["MESSAGING_WHISPER_ENABLE"] = "Enable Thank You Messages"
L["MESSAGING_WHISPER_DESC"] = "Whisper a thank-you to the player who buffed you."
L["MESSAGING_EMOTES_ENABLE"] = "Enable Emotes (When Out of Combat)"
L["MESSAGING_EMOTES_DESC"] = "Emote your appreciation. Emotes are held back while you are in combat."
L["MESSAGING_EMOTES_SELECT"] = "Select Emotes"
L["MESSAGING_SOUND_ENABLE"] = "Enable Sound Effect"
L["MESSAGING_SOUND_DESC"] = "Play a sound when you receive a buff. Only you hear it."

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
