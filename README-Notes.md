# Thanks for the Buff // Notes

> Where Thanks for the Buff departs from the Gogo1951 add-on Style Guide, kept so no review raises it again.

## Exceptions

### README Features lists every headline feature

- **Departs from:** README Creation Rules → Features, "Restating the pitch as a bullet."
- **Instead:** Features keeps a bullet for every headline feature, including the ones the pitch already names.
- **Why:** Each headline feature is its own reason to install, and a reader skimming Features should see every one.

### In-game name carries the Short Name

- **Departs from:** ADD-ON NAMES, Full Name in "the TOC `## Title`; the Options category and root panel".
- **Instead:** Every place the guide shows the Full Name in game reads `Thanks for the Buff (TFTB)`.
- **Why:** Players know the add-on by both names, so the title they see in game carries both.

### Prints open with the Short Name

- **Departs from:** MESSAGES, "Every print leads with the Full Name".
- **Instead:** Every print to the player opens `TFTB //`.
- **Why:** Buff print-outs are frequent, and a short brand keeps each line compact in chat.

### Main panel ends with Good to Go links

- **Departs from:** OPTIONS PANEL → Main Page Layout, "The root panel ends at /Commands."
- **Instead:** A Looking for Other Features? section, with Good to Go's CurseForge and Wago links, follows /Commands at the bottom of the General panel.
- **Why:** Players who open the main panel looking for a feature that moved need to find where it went.

### Shares the Star marker with Good to Go

- **Departs from:** MESSAGES → Target Marker, "so two add-ons never collide."
- **Instead:** Sent messages carry the Star marker (`{rt1}`), which Good to Go also uses.
- **Why:** Good to Go carries on features that moved out of Thanks for the Buff, so the two sister add-ons share one marker.

### Thank You Button whispers go out unbranded

- **Departs from:** MESSAGES, "every sent message trails with the Short Name".
- **Instead:** A Thank You Button whisper sends the player's own text exactly as typed, with no target marker and no Short Name.
- **Why:** The player writes it and sends it with their own key press, so it speaks in their voice, not the add-on's.

### Thank You Button whispers skip the composer

- **Departs from:** MESSAGES → Editable Messages, "Send Messages In" and "On the panel, the composer".
- **Instead:** A Thank You Button whisper keeps a plain box with Reset and an Example line, and its default text comes from the client's own locale.
- **Why:** The player types it and sends it with their own key press, so it is written in whatever language they choose, not one the add-on picks.

### Ignored Buffs match one spell ID

- **Departs from:** COMPATIBILITY → Game Mechanics, "a check for a buff matches every rank's ID".
- **Instead:** Each Ignored Buffs entry ignores only the exact spell ID added, from the player's own buffs or typed in.
- **Why:** Rank names differ within some locales, so no name match covers every rank, and a player can add each rank's ID by hand.

### Per-character Ignored Buffs on a shared profile

- **Departs from:** SAVED VARIABLES → The Two Models, "an add-on uses Per-Character if and only if it stores something that genuinely differs from character to character".
- **Instead:** Every setting rides the one shared profile, and only each character's own Ignored Buffs list is kept per character.
- **Why:** A player who wants different settings switches profiles, while a buff worth ignoring belongs to the character who keeps receiving it.
