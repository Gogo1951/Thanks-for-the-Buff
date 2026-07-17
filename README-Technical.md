# Thanks for the Buff — Technical Reference

This document combines architecture notes and contribution guidance for developers working on Thanks for the Buff. For end-user documentation, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md).

## File Map

```
TFTB/
├── TFTB.toc                            Load order; single TOC for Era + TBC Anniversary
├── Data/
│   ├── Data.lua                        Locale init, raw palette, class colors, options registry, target marker, URLs, emote list
│   ├── Tracked-Abilities.lua           Static Data.TRACKED: buffs/cooldowns/services others cast on you (SQL-sourced, StyLua-formatted)
│   ├── Peer-Pressure-Abilities.lua        Static Data.PEER_PRESSURE: same-class cooldowns for the Peer Pressure alert
│   └── Default-Settings.lua            ns.DATABASE_DEFAULTS (AceDB profile; global is empty)
├── Features/
│   ├── Core.lua                        Version read, AceDB lifecycle + migrations, single event dispatcher, login sequence
│   ├── Utilities.lua                   ns.GetColor, spell/item/aura API shims, ns.GetSpellLink, ns.IsPlayerGUID, sounds, ns.FLAVOR_INDEX
│   ├── Announcements.lua               Print / whisper / group message builders, emotes, Good News whisper queue
│   ├── Buff-Tracking.lua               The reaction engine: combat-log + cast taps, source classification, watched lists, display groups
│   ├── Peer-Pressure.lua                  Peer Pressure: same-class cooldown alert
│   ├── Thank-You-Button.lua            The /thankyou command and its auto-created macro
│   └── Diagnostics.lua                 Runtime-only probes and bug-report dumps (never persisted; strings not localized)
├── Options/
│   ├── Options-Utilities.lua           Shared AceConfig helpers + the BuildBuffPanel scaffold both group panels share
│   ├── Options-General.lua             Root panel: description, welcome toggle, /commands, Feedback & Support links, version
│   ├── Options-Buffs-from-Strangers.lua
│   ├── Options-Buffs-from-Teammates.lua
│   ├── Options-Buff-Services.lua       Group Services panel
│   ├── Options-Good-News.lua         Good News panel
│   ├── Options-Peer-Pressure.lua          Peer Pressure panel
│   ├── Options-Thank-You-Button.lua
│   ├── Options-Profiles.lua            Stock AceDBOptions-3.0 table, returned as-is
│   ├── Options-Diagnostics.lua         Renders the Diagnostics probes
│   └── Options.lua                     Panel registration order, /tftb + /thankyou slash commands
├── Locales/                            AceLocale-3.0 files; enUS.lua is the source of truth
├── Includes/                           Vendored libraries + Images/ (icon) + Sounds/ (Buff, Combat-Buff, Thunder) — never edited by hand
├── README.md                           End-user documentation
└── README-Technical.md                 This document
```

No deprecated files remain in the tree. The pre-AceDB flat saved-variable layout and the combined `groupBuffs` config are handled by the migrations in `Features/Core.lua` (see Migration Chain), not by any lingering file.

## Architecture

### Event Loop

`Features/Core.lua` owns one frame and one dispatcher; feature files never register their own frames. The complete event list is exported as `ns.EVENT_NAMES`, so the registered set, the diagnostics event-log tap, and the event-registration probe can never drift from one another:

```
PLAYER_LOGIN · PLAYER_ENTERING_WORLD · COMBAT_LOG_EVENT_UNFILTERED
UNIT_SPELLCAST_SENT · UNIT_SPELLCAST_SUCCEEDED · LOADING_SCREEN_DISABLED
```

Feature modules attach handlers by name with `ns.SetEventHandler(event, handler)`. Attaching the same event twice replaces the earlier handler — one owner per event. Every event first passes through `ns:LogEvent` when diagnostics logging is active, then to its handler.

A safety timer (`Data.SAFETY_PAUSE`, 3s) suppresses buff reactions until the world settles after login or a loading screen. A monotonic token invalidates earlier timers, so back-to-back loading screens can't let a stale callback flip `isReady` back on mid-pause.

### Combat Lockdown

Thanks for the Buff writes only one macro, and only at login (`ns:CreateAutoMacro`), guarded by `InCombatLockdown()` — so no macro write is ever attempted mid-combat. The reaction paths themselves run in combat: self-only prints, sounds, and outgoing whispers all fire on qualifying buffs whether or not you are fighting, because they touch no protected functions.

The one thing combat gates is emotes. `/cheer`-style emotes are visible and social, so `HandleTracked` and `HandleStrangersBuff` perform them only when `not InCombatLockdown()`. This is suppression, not a replay queue: an emote skipped during combat is simply not performed for that buff, and — because the per-source emote cooldown is spent only when an emote actually fires — the next qualifying buff after combat reacts immediately.

### Detect → Classify → Announce

The reaction pipeline runs across `Features/Buff-Tracking.lua` and `Features/Announcements.lua`:

1. **Detect** — `OnCombatLogEvent` taps `SPELL_AURA_APPLIED`/`SPELL_AURA_REFRESH` (buffs landing on you) and `SPELL_CAST_SUCCESS`; `OnUnitSpellcastSucceeded` taps group services and confirms Good News casts; `OnUnitSpellcastSent` captures the recipient of your own casts. Lookups (`auraLookup`, `castLookup`, `givenLookup`) are keyed by the id the relevant event actually carries.
2. **Classify** — `ResolveSource` trades a pet/guardian GUID for its owner and returns nil (drop the event) when no owner unit resolves. Cross-realm sources arrive as `Name-Realm` and never match a name lookup, so group membership is decided by the combat-log affiliation flags (`MINE`/`PARTY`/`RAID`), and a friendly outsider is recognized by `AFFILIATION_OUTSIDER`.
3. **Announce** — `HandleTracked` / `HandleStrangersBuff` route to the announcement helpers, which apply the target marker, brand, and colors. Sent messages carry a spell/item link; `SendChatMessage` rejects anything over **255 bytes**, and TFTB's single-line messages stay well under it.

### Item Data Caching

Item names and links come from `GetItemInfo`, which returns nil on a cold cache and fills asynchronously. `WarmItemCache` (login) touches every tracked item so its name/link is warm by the time an options panel or a "used their X on you" message needs it. Where a name still isn't ready, the options toggle shows the `COMBAT_ITEM_PENDING` placeholder (`Item #%d`) and resolves on the next panel open — which is why the Teammates, Services, Good News, and Peer Pressure panels register as functions (rebuilt on open) rather than as prebuilt tables. All item/spell access goes through the `ns.GetItemInfo` / `ns.GetSpellName` shims in `Features/Utilities.lua`, which resolve the modern `C_Item`/`C_Spell` API or the legacy global once at load.

### Cooldown Namespaces

A single `sessionCooldowns` table (GUID/key → expiry) backs every throttle, with disjoint string namespaces so keys on the same GUID never collide: bare GUID for the per-source stranger emote, `whisper:<guid>` for the per-recipient whisper throttle, `service:<guid>` for the group-service rate-limit and token-dedup, and `goodnews:<guid>:<spellID>` for the Good News per-recipient-per-spell dedup. `SetCooldown` opportunistically sweeps lapsed entries on each write so the table can't grow unbounded across a long session.

## Reaction Sources: Combat Log vs Cast Events

Why the same feature set reads three different event streams:

- **Buffs on you (Strangers, Teammates)** ride the combat log. `SPELL_AURA_APPLIED`/`REFRESH` tell you a buff landed and on whom.
- **Group services (feasts, soulwells, portals, repair bots)** ride `UNIT_SPELLCAST_SUCCEEDED`, *not* the combat log — these utility casts don't reliably emit `SPELL_CAST_SUCCESS` in `COMBAT_LOG_EVENT_UNFILTERED`, but they do fire the unit event for any unit the client tracks. A service has no per-you destination, so crediting the casting unit is all that's needed.
- **Good News (buffs you cast on others)** rides `UNIT_SPELLCAST_SENT` + `UNIT_SPELLCAST_SUCCEEDED`. The combat log is scoped to you, your group, and units in combat, so buffing a player *outside* your group produces no `SPELL_AURA_APPLIED` at all — the most common case for this feature is exactly the one the combat log never reports. `SENT` is also the only event that names the recipient; `SUCCEEDED` confirms the cast went off, so an interrupted cast stays silent.

Because `SENT`/`SUCCEEDED` carry the **cast** id, `givenLookup` is keyed by cast id, and each record carries `watchedId` (the id the panel toggle and settings list use) and `auraId` (the id to read the recipient's remaining duration with — deliberately absent for no-aura casts like Rebirth and for `noDuration` entries like Fear Ward and Misdirection, which is what drops the "for 10 minutes" clause from their message). The aura lands a beat after the cast succeeds, so `AnnounceGivenCast` waits `AURA_SETTLE` (0.1s) before reading the duration, re-checking the unit still holds the recipient's GUID.

## Per-Flavor Tracking Data

`Data.TRACKED` and `Data.PEER_PRESSURE` carry `{ Era, TBC, Wrath }` default columns. `ns.FLAVOR_INDEX` (from `GetBuildInfo`) picks the column for the running client; anything past Wrath reads the Wrath slot (deliberate forward-prep).

A `"-"` in the flavor column means the row **does not exist on this flavor at all** — a stronger statement than `DoesSpellExist` can make, because Blizzard reuses spell ids across flavors for entirely different abilities. For example, id `11958` is **Ice Block** on Era but **Cold Snap** in TBC/Wrath, and `12472` is **Cold Snap** on Era but **Icy Veins** in TBC/Wrath. Such ids get one row per identity, each hidden (`"-"`) on the flavors where the id means something else. A `"-"` row owns nothing: no lookup, no toggle, no seed. Numeric columns seed the checkbox default (`0` = off, anything else = on).

## Peer Pressure

Peer Pressure alerts you when another player of your class pops a tracked cooldown so you can join in. `Features/Peer-Pressure.lua` builds a class-keyed lookup from `Data.PEER_PRESSURE`; `ns.CheckPeerPressure` is called from the combat-log tap for every `SPELL_CAST_SUCCESS`. (This feature shipped under the codename **Buff Train** and the sibling **Good News** feature as **Buffs Given**; both were renamed to match their player-facing labels, saved-variable keys included — see the Migration Chain.)

The alert normally fires only for *other* players' casts, but "Trigger on Own Casts" (`triggerOnOwnCasts`, default on) lets your own cooldowns fire it too — which is why the Peer Pressure tap sits *above* the own-source drop in `OnCombatLogEvent`; `CheckPeerPressure` applies the setting itself. Print and sound are independent toggles; the message renders in your class color with a standard spell link.

## Thank You Button

`Features/Thank-You-Button.lua` provides the `/thankyou` command (registered in `Options/Options.lua`) and an auto-created macro named `Data.MACRO_NAME` (`- Thank`, icon `134411`, body `/thankyou`). The macro is created only at login, only when `slash.createMacro` is set, only out of combat, and only if fewer than 120 global macros exist. `/thankyou` emotes at and whispers your current target; it whispers only when the target shares your faction and the message is non-empty. The whisper body (`slash.message`, user-editable) is sent verbatim via `SendChatMessage` — a custom message must respect the 255-byte limit.

## Diagnostics

`Features/Diagnostics.lua` is runtime-only: `ns.diagnostics` holds `enabled`/`logging`/`log` and **nothing persists to SavedVariables**. Its strings live in `ns.DiagnosticsStrings` as plain English and never go through `Locales/` (they are developer-facing). The enable gate defaults off; turning it off also stops the event log. The event log snapshots each argument to a string immediately (never retaining frame/table references), caps arg count and length, and escapes pipes after truncation so a clipped argument can't eat the next separator. `COMBAT_LOG_EVENT_UNFILTERED` is excluded from the general log as a firehose; the buff engine instead feeds one decoded line per nearby `SPELL_CAST_SUCCESS` through `ns:LogCombatCast`, recorded before any filtering — so a portal or feast that arrives but is dropped is still visible, with `tracked`/`watched` flags to tell a data problem from a downstream one.

## Saved Variables

One account-wide table, `TFTB_DB`, managed by AceDB-3.0. Every user setting lives under `profile`; `global` ships empty.

- **`profile.showWelcome`** — login welcome message on/off.
- **`profile.strangers`** — `printEnabled`, `whisperEnabled`, `emotesEnabled`, `soundEnabled`, `emotes`, plus `cooldown` (emote rate-limit seconds) and `minBuffDuration` (filter for short HoTs).
- **`profile.teammates`** — `printEnabled`, `whisperEnabled`, `emotesEnabled`, `soundEnabled`, `emotes`.
- **`profile.services`** — as teammates, minus sound (Group Services has no sound option).
- **`profile.goodNews`** (Good News) — `whisperEnabled`, `scope` (`ALWAYS` = anyone you buff, otherwise group only), and `watched` (its own list of ids you want announced).
- **`profile.peerPressure`** (Peer Pressure) — `enabled`, `printEnabled`, `triggerOnOwnCasts`, `soundEnabled`, `watched`.
- **`profile.slash`** (Thank You Button) — `createMacro`, `message`, `emotes`.
- **`profile.watchedBuffs`** — the shared thank-you list behind Teammates and Group Services (their ids never overlap, so one table is unambiguous).

### Migration Chain

Applied once in `InitializeDatabase`, in order, each removable after its dated window:

1. **`MigrateFlatToProfile`** (remove after 2026-10-05) — lifts the pre-AceDB flat layout (settings that used to sit at the `TFTB_DB` root) into the shared Default profile, then clears the orphaned root keys. Recurses per-key so a value the user set wins while untouched keys keep their default.
2. **`ApplyFieldMigrations`** (remove after 2026-09-28) — drops the retired `strangers.messaging` dropdown and `strangers.enabled` master switch; renames `welcomeMessage` → `showWelcome`; and splits the old combined `groupBuffs` config into independent `teammates` and `services` settings, carrying the player's old messaging prefs and watched list into both so upgrading resets nothing.
3. **Feature rename** (in `ApplyFieldMigrations`, remove after 2027-01-17) — the Buff Train and Buffs Given features were renamed Peer Pressure and Good News; their saved profile keys move `buffTrain` → `peerPressure` and `buffsGiven` → `goodNews` (via `LiftInto`), so existing toggles and watched lists survive the rename.

Defaults come from `ns.DATABASE_DEFAULTS` and are applied lazily by AceDB-3.0 via metatables — nothing is copied into the saved table, and explicit user values (including `false`) are never overridden.

Both watched lists refill on empty: `PopulateWatchedBuffs` and `PopulatePeerPressureWatched` seed any id the saved list doesn't hold yet from the per-flavor default columns, and prune ids not live on this client so the saved data stays client-real. They run at login and again on every profile change / copy / reset (`OnProfileChanged`), because a profile swap replaces every setting at once.

## Adding a New Tracked Buff or Cooldown

`Data.TRACKED` in `Data/Tracked-Abilities.lua` — one entry is one checkbox on the Teammates, Services, or Good News panel.

1. Add an entry with its `type` (`SOLO` / `GROUP` / `SERVICE`), `detect` (`AURA` / `CAST`), the `received` and (non-service) `given` per-flavor columns, and a `triggers` list of `{ spell = id }` (add `item = id` for item-driven buffs, `aura = id` when the applied aura id differs from the cast id).
2. For a multi-rank/variant group under one toggle, list every id in `triggers` and set `name = L["GROUP_*"]` (add the key to every locale). A single spell/item takes its name from the client and needs no locale key.
3. Use `"-"` in a flavor column for any id that means a different ability on that flavor; give each identity its own row.
4. No code change is needed — `BuildLookups`, `PopulateWatchedBuffs`, and `BuildDisplayGroups` consume the table at login.

## Adding a New Peer Pressure Ability

`Data.PEER_PRESSURE` in `Data/Peer-Pressure-Abilities.lua` — one row per checkbox: `{ "CLASS", { spell ids }, Era, TBC, Wrath }`. List every rank/variant in the id list; use `"-"` for a flavor where the id is a different ability. Rows are consumed at login by `Features/Peer-Pressure.lua`; no code change is needed.

## Adding a New Registered Event

1. Add the event name to `ns.EVENT_NAMES` in `Features/Core.lua`. The dispatcher registers it and the diagnostics event-registration probe picks it up automatically — never register a frame anywhere else.
2. Attach a handler in the owning feature module with `ns.SetEventHandler("EVENT_NAME", handler)`. Only one module may own an event.
3. If it's a firehose (like the combat log), add it to `ns.DIAGNOSTIC_EVENT_EXCLUDE` and decode it into the log through a purpose-built helper instead.

## Localization

- **Structure** — locale files live in `Locales/<locale>.lua`, each registered through AceLocale-3.0's `NewLocale("TFTB", "<code>")`. `enUS.lua` is the source of truth and the only file that passes the `true` default-fallback flag; every string originates there.
- **Keeping locales in sync** — every other locale carries a translation of the same key set, and AceLocale falls back to English via `__index` for anything missing at runtime. Translating each `enUS.lua` key into every locale and keeping the files aligned is the job of the Localization pass (`3 - Copy Cleanup & Localization Prompt.md`); don't hand-edit the other locales during ordinary work.
- **Placeholders** — `%s`/`%d` count, type, and order must match `enUS` per key in every locale, or the string crashes at runtime. `MSG_USED_ITEM` uses positional specifiers (`%1$s`/`%2$s`/`%3$s`) in locales whose word order differs (e.g. ptBR); keep the numbering when translating.
- **Spanish** — esES and esMX are two separate, self-contained files; identical strings in both is correct and expected.
- **Locale overflow** — German is the usual canary against the 255-byte `SendChatMessage` limit; the tracked message templates (`MSG_*`) are the ones that carry a live spell/item link, so keep translated bodies short enough to leave the link room.

## Common Pitfalls

- **Whispering a pet name**: a whisper addressed to a pet bounces ("No player named 'X' is currently playing"). Every whisper path is guarded by `ns.IsPlayerGUID`, and pet sources are traded for their owner via `ResolveSource` (which returns nil rather than falling back to the pet).
- **Cross-realm source names**: a combat-log name is `Name-Realm` and never matches a name lookup or resolves as an emote target. Classify group membership by affiliation flags, and strip the realm with `Ambiguate(name, "short")` before passing a name to `DoEmote`.
- **`DoEmote(cmd, nil)` is not undirected**: it falls back to your *current target*, thanking a bystander. Pass `"none"` (or an unresolvable name, which degrades the same way) to force the undirected emote.
- **Reading a buff's duration too early**: for Good News, the aura lands a tick *after* the cast succeeds, so reading it inline reports "no duration" for every buff. Wait `AURA_SETTLE`, then read it off the recipient after re-confirming their GUID.
- **A live buff reporting 0 duration**: `ns.GetBuffDuration` returns 0 for a timerless buff and nil for absent — callers must nil-check, never test the number for truthiness.
- **Native `GetSpellLink` in chat**: on Classic it omits the trailing `:0` field, which `SendChatMessage`'s validator strips on send, so whispers arrive with the link gone. `ns.GetSpellLink` builds `|Hspell:<id>:0|h` by hand to pass the validator.
- **Reusing a spell id across flavors**: `DoesSpellExist` can't tell Ice Block (Era) from Cold Snap (TBC) — they share id `11958`. Use the `"-"` flavor column, one row per identity (see Per-Flavor Tracking Data).

## Contributing

- **Issues** — <https://github.com/Gogo1951/Thanks-for-the-Buff/issues>.
- **Bug reports** — include game version + locale, class + level, repro steps, and the relevant chat output. The Diagnostic Tools panel (enable it, run the Context / API / Event checks) produces a ready-to-paste report.
- **Discord** — <https://discord.gg/eh8hKq992Q>.
- **PRs** — keep changes scoped; run StyLua with its default config over every touched Lua file; preserve migration discipline (never rename a saved-variable key without a dated migration window and note); check any macro or sent-message change against the 255-byte limit; and update this document if the architecture or file map changes.
- **Commit and PR descriptions require a User Story.** Frame the change by who it helps and why, not just what changed.

   **Format:** *As a [role], I [needed / wanted] [behavior] so that [outcome]. This change [does X].*

   **Example:** *As a healer who buffs strangers in the open world, I wanted a distinct sound only for combat cooldowns cast on me so that I could tell them apart from routine buffs. This change points `PlayTeammateSound` at `Combat-Buff.ogg` while strangers keep `Buff.ogg`.*
