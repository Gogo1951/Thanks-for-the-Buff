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

### Buff Keys' global-cooldown cutoff

- **Departs from:** COMPATIBILITY → Game Mechanics, "never with a magic threshold like `duration > 1.5`".
- **Instead:** The Buff Keys count a cooldown of 1.5 seconds or less as the global cooldown when choosing what to cast next.
- **Why:** On every client the add-on targets, no global cooldown runs past 1.5 seconds and no buff it offers has a real cooldown that short, so the cutoff never misreads.

### Buff Keys bound on the Buff Duty panel

- **Departs from:** OPTIONS PANEL → Main Page Layout, "Key Bindings (if any: one row per binding with its caption, bound key and a Set Key button, then one line saying what the key does)".
- **Instead:** The Buff Duty panel binds its own keys in place, each row a key-capture button with a copyable macro line under it, and the General panel has no Key Bindings section.
- **Why:** The keys belong to one feature, and setting a key where that feature is configured is quicker than opening the game's Key Bindings list.

### Note on where the newer features may go

- **Departs from:** OPTIONS PANEL → Main Page Layout, "Page order of the root General panel".
- **Instead:** A note under the General panel's Features switches, repeated under Buff Duty's own switch, says the newer features may move to Connoisseur & Restocker or merge into one bigger add-on, and asks for players' thoughts.
- **Why:** Players who rely on the newer features should hear where they may end up before it happens, and have a say in it.
