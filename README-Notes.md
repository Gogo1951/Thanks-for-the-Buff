# Thanks for the Buff // Notes

> The maintainer's settled rulings for Thanks for the Buff, kept so no review raises them again: exceptions to the Gogo1951 add-on Style Guide, and decisions it leaves open.

## Exceptions

### README H1 is the full title

- **Departs from:** README Creation Rules → Title, "H1, the add-on's Short Name."
- **Instead:** The README's H1 is the in-game title, `Thanks for the Buff (TFTB)`.
- **Why:** The README heading matches the name players see in game and in their add-on list.

### README Features lists all five features

- **Departs from:** README Creation Rules → Features, "Restating the pitch as a bullet."
- **Instead:** Features keeps a bullet for every headline feature, including the ones the pitch already names.
- **Why:** Each headline feature is its own reason to install, and a reader skimming Features should see every one.

## Decisions

- The TOC `## Title` and `L["ADDON_TITLE"]` are `Thanks for the Buff (TFTB)`, and every print and sent message brands with the short name `TFTB` (`L["ADDON_SHORT"]`).
- On the Thank You Button panel, unchecking a button's Enable Macro toggle collapses that button's whisper and emote settings, while the typed `/thankyou` command keeps firing with the stored settings.
- The `TFTB_DB` to `TFTBDB` SavedVariables rename ships with no migration bridge, so existing settings reset to defaults once: the rename brings the table onto the house `AddonNameDB` name, and a one-release bridge wasn't worth carrying.
- Jumper Cables has no row in `Data/Camelot/`, because its `RESURRECT` detection needs the combat log's resurrection event, which WoW Forever doesn't have, and tracking the cast instead would thank people for failed jolts.
