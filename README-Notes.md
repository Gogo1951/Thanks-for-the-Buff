# Thanks for the Buff // Notes

> Where Thanks for the Buff departs from the Gogo1951 add-on Style Guide, kept so no review raises it again.

## Exceptions

### README H1 is the full title

- **Departs from:** README Creation Rules → Title, "H1, the add-on's Short Name."
- **Instead:** The README's H1 is the in-game title, `Thanks for the Buff (TFTB)`.
- **Why:** The README heading matches the name players see in game and in their add-on list.

### README Features lists every headline feature

- **Departs from:** README Creation Rules → Features, "Restating the pitch as a bullet."
- **Instead:** Features keeps a bullet for every headline feature, including the ones the pitch already names.
- **Why:** Each headline feature is its own reason to install, and a reader skimming Features should see every one.

### Sent messages sign off with the name

- **Departs from:** MESSAGES → Sent Messages, "`{rtN} Add-on Name // Message`".
- **Instead:** Every sent message puts the short name after the body, `{rt1} Message // TFTB`, whether or not it is time-sensitive.
- **Why:** A thank-you should read as thanks first, and the sign-off still tells the recipient where it came from.

### Buff Key's global-cooldown cutoff

- **Departs from:** COMPATIBILITY → Game Mechanics, "never with a magic threshold like `duration > 1.5`".
- **Instead:** The Buff Key counts a cooldown of 1.5 seconds or less as the global cooldown when choosing what to cast next, and Skip Buffs with Cooldowns counts a spell's base cooldown over 1.5 seconds as one of its own.
- **Why:** On every client the add-on targets, no global cooldown runs past 1.5 seconds and no buff it offers has a real cooldown that short, so the cutoff never misreads.

### Buff Key bound on the Buff Duty panel

- **Departs from:** OPTIONS PANEL → Main Page Layout, "Key Bindings (if any: one row per binding with its caption, bound key and a Set Key button, then one line saying what the key does)".
- **Instead:** The Buff Duty panel binds its own key in place, a key-capture button with a copyable macro line under it, and the General panel has no Key Bindings section.
- **Why:** The key belongs to one feature, and setting it where that feature is configured is quicker than opening the game's Key Bindings list.

### Note on where the newer features may go

- **Departs from:** OPTIONS PANEL → Main Page Layout, "Page order of the root General panel".
- **Instead:** A note under the General panel's Features switches, repeated under Buff Duty's own switch, says the newer features may move to Connoisseur & Restocker or merge into one bigger add-on, and asks for players' thoughts.
- **Why:** Players who rely on the newer features should hear where they may end up before it happens, and have a say in it.

### Peer Pressure notice marked TEMPORARY (remove after 2026-11-21)

- **Departs from:** SAVED VARIABLES → Migration Windows, "tagged where it sits ... with `MIGRATION (remove after YYYY-MM-DD)`".
- **Instead:** The panel telling players where Peer Pressure went, and every line that exists only for it, is marked `TEMPORARY -- delete on or after 2026-11-21`, with its removal steps written beside it.
- **Why:** The notice moves no saved data, so it carries its own marker apart from the saved-data migrations.
