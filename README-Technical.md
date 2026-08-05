# Thanks for the Buff — Technical Reference

This document combines architecture notes and contribution guidance for developers working on Thanks for the Buff. For end-user documentation, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md).

## File Map

The repo root *is* the add-on folder; the packager renames it to `TFTB` on release (`package-as` in `.pkgmeta`), which is why the installed path is `Interface/AddOns/TFTB/`.

```
Thanks-for-the-Buff/
├── .github/workflows/package.yml         Release packaging (repo only)
├── .gitattributes                        LF normalization; keeps the GitHub web UI from committing CRLF (repo only)
├── .pkgmeta                              Packager manifest: package-as, externals, ignore list (repo only)
├── LICENSE                               MIT (repo only)
├── TFTB.toc                              Load order; one TOC for Era + TBC Anniversary
├── Data/
│   ├── Data.lua                          Locale init, raw palette, class colors, options registry, target marker, URLs, emote list, praise-delay choices
│   ├── Tracked-Abilities.lua             Data.TRACKED: buffs / cooldowns / services others spend on you
│   ├── Peer-Pressure-Abilities.lua       Data.PEER_PRESSURE: same-class cooldowns for the Peer Pressure alert
│   └── Default-Settings.lua              ns.DATABASE_DEFAULTS (one shared AceDB profile; global ships empty)
├── Features/
│   ├── Core.lua                          Version read, AceDB lifecycle + migrations, the one event dispatcher, login sequence
│   ├── Utilities.lua                     ns.GetColor, spell/item/aura API shims, ns.GetSpellLink, ns.IsPlayerGUID, sounds, ns.FLAVOR_INDEX
│   ├── Announcements.lua                 Print / whisper builders, ns.GetBuffLink, emotes, plural resolution, Good News whisper queue
│   ├── Buff-Tracking.lua                 The reaction engine: combat-log + cast taps, source classification, praise delivery, watched lists, display groups
│   ├── Peer-Pressure.lua                 Same-class cooldown alert, tapped from the combat-log handler
│   ├── Thank-You-Button.lua              The /thankyou command body and its auto-created macro
│   └── Diagnostics.lua                   Runtime-only probes and bug-report dumps (never persisted; strings not localized)
├── Options/
│   ├── Options-Utilities.lua             Shared AceConfig helpers + the control factories every buff panel draws from
│   ├── Options-General.lua               Root panel: description, welcome toggle, /commands, Feedback & Support links
│   ├── Options-Buffs-from-Strangers.lua
│   ├── Options-Buffs-from-Teammates.lua
│   ├── Options-Buff-Services.lua         Group Services panel
│   ├── Options-Good-News.lua             Good News panel
│   ├── Options-Peer-Pressure.lua         Peer Pressure panel
│   ├── Options-Thank-You-Button.lua
│   ├── Options-Profiles.lua              Stock AceDBOptions-3.0 table, returned as-is
│   ├── Options-Diagnostics.lua           Renders the Diagnostics probes
│   └── Options.lua                       Panel registration order, panel-open routing, /tftb + /thankyou slash commands
├── Locales/                              AceLocale-3.0 files, one per supported locale; enUS.lua is the source of truth
├── Includes/
│   ├── Libraries/                        Vendored LibStub, CallbackHandler-1.0, AceLocale/DB/DBOptions/GUI/Config — never hand-edited (see below)
│   ├── Images/                           Thanks-for-the-Buff.tga (the TOC IconTexture)
│   └── Sounds/                           Buff.ogg (any buff on you), Thunder.ogg (Peer Pressure)
├── README.md                             End-user documentation
├── README-Technical.md                   This document
└── README-Testing.md                     Manual QA script, walked before tagging a release
```

`Includes/Libraries/` is committed *and* declared as packager `externals`, so every release re-pulls each library from upstream — a hand-edit to a vendored file is silently discarded on the next build. Fix the upstream library or work around it in `Features/`.

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

Three things answer to combat, in three different ways.

**The options panel refuses outright.** `InCombatLockdown()` is the first thing `ns:OpenOptionsPanel` does — one gate in front of the whole routing chain, ahead of the Settings / legacy / AceConfigDialog branches, so `/tftb` behaves identically on every flavor. It prints `CHAT_OPTIONS_IN_COMBAT` and returns. It never queues the panel to open when combat ends and never registers `PLAYER_REGEN_ENABLED` to finish the job later; Blizzard's Settings panel is protected in combat, and a silent refusal reads as a broken command.

**The macro never has to defer.** Thanks for the Buff writes only one macro, and only at login (`ns:CreateAutoMacro`), guarded by `InCombatLockdown()` — so no macro write is ever attempted mid-combat and there is no dirty flag to replay.

**Emotes are suppressed, not queued.** The reaction paths themselves run in combat: self-only prints, sounds, and outgoing whispers all fire on qualifying buffs whether or not you are fighting, because they touch no protected functions. `/cheer`-style emotes are visible and social, so `HandleTracked` and `HandleStrangersBuff` perform them only when `not InCombatLockdown()`. An emote skipped during combat is simply not performed for that buff — and because a praise cooldown is spent only when praise actually goes out, the next qualifying buff after combat reacts immediately. Combat is tested twice: once when the reaction is decided, and again inside `DeliverPraise` when the emote fires, so entering combat during a Praise Delay still suppresses it.

### Praise vs Notifications

The reactions split into two kinds, which is also how the Strangers and Teammates panels are laid out:

- **Praise** — the thank-you whisper and the emote. Both go outward to the player who buffed you, so both answer to the cooldowns and to the Praise Delay, and both are delivered by `DeliverPraise` in `Features/Buff-Tracking.lua`.
- **Notifications** — the chat print and the sound. Self-only, never throttled or delayed, fired inline the moment the buff qualifies.

`DeliverPraise` receives decisions, not permissions to re-derive: every gate (the toggles, both cooldowns, the whisper throttle, the combat check) is settled before the timer is armed, so a burst of buffs landing inside the delay window cannot slip past a cooldown. `praiseDelayEnabled` off, or a missing `praiseDelay`, means a delay of 0 and inline delivery. The emote *target* is the deliberate exception, resolved inside the timer rather than before it: `ResolveEmoteTarget` returns a live unit token, and `target` / `focus` / `mouseover` all name whoever you are pointing at in that instant, so resolving early makes a delayed emote thank whoever you moved on to.

### Detect → Classify → Announce

The reaction pipeline runs across `Features/Buff-Tracking.lua` and `Features/Announcements.lua`:

1. **Detect** — `OnCombatLogEvent` taps `SPELL_AURA_APPLIED`/`SPELL_AURA_REFRESH` (buffs landing on you) and `SPELL_CAST_SUCCESS`; `OnUnitSpellcastSucceeded` taps group services and confirms Good News casts; `OnUnitSpellcastSent` captures the recipient of your own casts. The three lookups (`auraLookup`, `castLookup`, `givenLookup`) are each keyed by the id the relevant event actually carries.
2. **Classify** — `ResolveSource` trades a pet/guardian GUID for its owner and returns nil (drop the event) when no owner unit resolves. Cross-realm sources arrive as `Name-Realm` and never match a name lookup, so group membership is decided by the combat-log affiliation flags (`MINE`/`PARTY`/`RAID`), and a friendly outsider is recognized by `AFFILIATION_OUTSIDER`.
3. **Announce** — `HandleTracked` / `HandleStrangersBuff` route to the announcement helpers, which apply the target marker, brand, and colors. Sent messages carry a spell/item link; `SendChatMessage` rejects anything over **255 bytes**, and TFTB's single-line messages stay well under it.

### Item Data Caching

Item names and links come from `GetItemInfo`, which returns nil on a cold cache and fills asynchronously. `WarmItemCache` (login) touches every tracked item so its name/link is warm by the time an options panel or a "used their X on you" message needs it. Where a name still isn't ready, the options toggle shows the `COMBAT_ITEM_PENDING` placeholder (`Item #%d`) and resolves on the next panel open — which is why the Teammates, Services, Good News, and Peer Pressure panels register as functions (rebuilt on open) rather than as prebuilt tables. All item/spell access goes through the `ns.GetItemInfo` / `ns.GetSpellName` shims in `Features/Utilities.lua`, which resolve the modern `C_Item`/`C_Spell` API or the legacy global once at load.

### Options Panels

Nine AceConfig panels register in `Options/Options.lua` — one per key in `ns.OPTIONS_REGISTRY` — in the order they appear in Blizzard's settings tree: General (root), the six feature panels, then Profiles second-to-last and Diagnostic Tools last.

Each panel file owns its own layout and order numbers; the controls themselves come from factories in `Options/Options-Utilities.lua` (`ns.DefinePrintToggle`, `ns.DefineWhisperToggle`, `ns.DefineEmotesToggle`, `ns.DefineEmoteGroup`, `ns.DefineSoundToggle`, `ns.DefinePraiseDelayToggle`, and friends). Every factory takes a `settings` accessor returning the profile subtable it binds to, so one definition serves Strangers, Teammates, and Group Services without those three having to share a layout — which they no longer do.

Two registration shapes coexist deliberately. Panels whose contents are fixed at login register a **prebuilt table** (General, Strangers, Thank You Button, Profiles, Diagnostic Tools); panels that render tracked abilities register the **builder function itself** (Teammates, Services, Good News, Peer Pressure), so the table is rebuilt on open once lazily-loaded item names have resolved (see Item Data Caching).

Section headers are real AceConfig `header` widgets throughout — `ns.OptionsHeader`, which takes an optional third `hidden` argument for the panels whose whole section collapses behind a master switch (Peer Pressure, Good News, Diagnostic Tools).

`ns:OpenOptionsPanel` backs the `/tftb` command. It routes by the **category ID captured from `AddToBlizOptions`**, never by panel title — see the Common Pitfalls entry for why a title lookup is the standing trap here.

### Cooldown Namespaces

A single `sessionCooldowns` table (key → expiry) backs every throttle, with disjoint string namespaces so keys on the same GUID never collide:

| Key                            | Window | Purpose                                          |
| ------------------------------ | ------ | ------------------------------------------------ |
| `praise:all`                   | `strangers.praiseCooldown` (default 0 = off) | Overall stranger praise limit |
| `praise:<guid>`                | `strangers.cooldown` (default 3s) | Per-source stranger praise    |
| `whisper:<guid>`               | 45s    | Per-recipient outgoing whisper throttle          |
| `service:<guid>`               | 10s    | Group-service rate limit *and* multi-token dedup |
| `goodnews:<guid>:<spellID>`    | 10s    | Good News per-recipient-per-spell dedup          |

Both `praise:` keys gate the whisper and the emote alike, and neither is stamped unless praise actually goes out. `whisper:<guid>` is a floor underneath them that no setting can lower: a 1-second praise cooldown still cannot whisper the same player more than once every 45 seconds, which is what keeps a generous setting clear of the server's chat squelch.

`SetCooldown` opportunistically sweeps lapsed entries on each write, so the table can't grow unbounded across a long session.

## Reaction Sources: Combat Log vs Cast Events

Why the same feature set reads three different event streams:

- **Buffs on you (Strangers, Teammates)** ride the combat log. `SPELL_AURA_APPLIED`/`REFRESH` tell you a buff landed and on whom.
- **Group services (feasts, soulwells, portals, repair bots)** ride `UNIT_SPELLCAST_SUCCEEDED`, *not* the combat log — these utility casts don't reliably emit `SPELL_CAST_SUCCESS` in `COMBAT_LOG_EVENT_UNFILTERED`, but they do fire the unit event for any unit the client tracks. A service has no per-you destination, so crediting the casting unit is all that's needed. Because the event's reach (target, focus, nameplates) is far wider than the feature's, the caster is filtered to `UnitInParty` / `UnitInRaid` — otherwise a stranger opening a portal across a capital city announces as a service.
- **Good News (buffs you cast on others)** rides `UNIT_SPELLCAST_SENT` + `UNIT_SPELLCAST_SUCCEEDED`. The combat log is scoped to you, your group, and units in combat, so buffing a player *outside* your group produces no `SPELL_AURA_APPLIED` at all — the most common case for this feature is exactly the one the combat log never reports. `SENT` is also the only event that names the recipient; `SUCCEEDED` confirms the cast went off, so an interrupted cast stays silent.

## Good News

Good News whispers the player *you* just buffed to tell them what they got and how long it lasts. It is the only feature driven by your own casts, and the only one that sends more than one message per trigger.

Because `SENT`/`SUCCEEDED` carry the **cast** id, `givenLookup` is keyed by cast id, and each record carries `watchedId` (the id the panel toggle and settings list use) and `auraId` (the id to read the recipient's remaining duration with). `auraId` is deliberately absent for no-aura casts like Rebirth and for `noDuration` entries like Fear Ward and Misdirection — nothing to read is what drops the "for 10 minutes" clause from their message.

Three timing constants shape the flow, all in `Features/Buff-Tracking.lua`:

- `AURA_SETTLE` (0.1s) — the aura lands a beat *after* the cast succeeds, so `AnnounceGivenCast` waits before reading the duration, re-checking that the unit still holds the recipient's GUID.
- `PENDING_TTL` (15s) — a `SENT` whose `SUCCEEDED` never arrives (interrupted cast) is swept from `pendingGiven`.
- `GOODNEWS_DEDUP` (10s) — a quick recast on the same person doesn't whisper twice.

The whispers themselves are **queued, not sent inline** (`QueueWhisper` in `Features/Announcements.lua`, `WHISPER_GAP` 0.35s). A raid-wide buff like Prayer of Fortitude lands on every recipient in the same instant, and a burst of same-frame whispers risks the server-side chat squelch — which would drop them all silently. An empty queue still sends immediately, so the common one-recipient case feels instant.

Durations render through the client's own localized `D_HOURS` / `D_MINUTES` / `D_SECONDS` templates, so the units are correct in every language without TFTB shipping its own copies. That comes with a trap severe enough to have its own entry in Common Pitfalls: those templates carry a `|4singular:plural;` escape that `SendChatMessage` rejects outright, so `ResolvePlurals` expands it to plain text first.

## Per-Flavor Tracking Data

`Data.TRACKED` and `Data.PEER_PRESSURE` carry `{ Era, TBC, Wrath }` default columns. `ns.FLAVOR_INDEX` (from `GetBuildInfo`) picks the column for the running client; anything past Wrath reads the Wrath slot (deliberate forward-prep).

A `"-"` in the flavor column means the row **does not exist on this flavor at all** — a stronger statement than `DoesSpellExist` can make, because Blizzard reuses spell ids across flavors for entirely different abilities. For example, id `11958` is **Ice Block** on Era but **Cold Snap** in TBC/Wrath, and `12472` is **Cold Snap** on Era but **Icy Veins** in TBC/Wrath. Such ids get one row per identity, each hidden (`"-"`) on the flavors where the id means something else. A `"-"` row owns nothing: no lookup, no toggle, no seed. Numeric columns seed the checkbox default (`0` = off, anything else = on).

## Peer Pressure

Peer Pressure alerts you when another player of your class pops a tracked cooldown so you can join in. `Features/Peer-Pressure.lua` builds a class-keyed lookup from `Data.PEER_PRESSURE`; `ns.CheckPeerPressure` is called from the combat-log tap for every `SPELL_CAST_SUCCESS`. Spells are class-locked, so "the caster is your class" needs no GUID inspection — the entry's class tag against your own is the whole test. (This feature shipped under the codename **Buff Train** and the sibling **Good News** feature as **Buffs Given**; both were renamed to match their player-facing labels, saved-variable keys included — see the Migration Chain.)

The alert normally fires only for *other* players' casts, but "Trigger on Own Casts" (`triggerOnOwnCasts`, default off) lets your own cooldowns fire it too — which is why the Peer Pressure tap sits *above* the own-source drop in `OnCombatLogEvent`; `CheckPeerPressure` applies the setting itself. Print and sound are independent toggles; the message renders in your class color with a standard spell link.

## Thank You Button

`Features/Thank-You-Button.lua` provides the `/thankyou` command (registered in `Options/Options.lua`) and an auto-created macro named `Data.MACRO_NAME` (`- Thank`, icon `134411`, body `/thankyou`). The macro is created only at login, only when `slash.createMacro` is set, only out of combat, and only if fewer than 120 global macros exist. `/thankyou` emotes at and whispers your current target; it whispers only when the target shares your faction and the message is non-empty. The whisper body (`slash.message`, user-editable) is sent verbatim via `SendChatMessage` and is unbranded by design — a human-sounding message, deliberately without the marker or add-on name. A custom message must respect the 255-byte chat limit.

## Diagnostics

`Features/Diagnostics.lua` is runtime-only: `ns.diagnostics` holds `enabled`/`logging`/`log` and **nothing persists to SavedVariables**. Its strings live in `ns.DiagnosticsStrings` as plain English and never go through `Locales/` (they are developer-facing). The enable gate defaults off; turning it off also stops the event log.

The event log snapshots each argument to a string immediately (never retaining frame/table references), caps arg count and length (`EVENT_LOG_SIZE` 500, `EVENT_LOG_MAX_ARGS` 8, `EVENT_LOG_MAX_ARG_LENGTH` 255), and escapes pipes *after* truncation so a clipped argument can't eat the next separator. `COMBAT_LOG_EVENT_UNFILTERED` is the sole entry in `ns.DIAGNOSTIC_EVENT_EXCLUDE` — as a firehose it would bury the signal. The buff engine instead feeds one decoded line per nearby `SPELL_CAST_SUCCESS` through `ns:LogCombatCast`, recorded *before* any filtering, so a portal or feast that arrives but is dropped is still visible, with `tracked`/`watched` flags to tell a data problem from a downstream one.

## Saved Variables

One account-wide table, `TFTB_DB`, managed by AceDB-3.0.

**Thanks for the Buff uses the Simple saved-variables model.** `AceDB:New` is called with `true` as its third argument, so every character on the account lands on the one shared `"Default"` profile and the whole database lives under `profile`; `global` ships empty (there is no minimap button or other profile-independent state), and there is nothing the add-on stores that differs from character to character. **Reset Profile therefore clears everything, back to install defaults.** A new setting belongs in `ns.db.profile`.

- **`profile.showWelcome`** — login welcome message on/off.
- **`profile.strangers`** — `printEnabled`, `whisperEnabled`, `emotesEnabled`, `soundEnabled`, `emotes`, plus `praiseDelayEnabled` / `praiseDelay` (hold the whisper and emote back by 1-4 seconds), `praiseCooldown` (overall praise rate limit, 0 = off), `cooldown` (per-source praise rate limit) and `minBuffDuration` (filter for short HoTs).
- **`profile.teammates`** — `printEnabled`, `whisperEnabled`, `emotesEnabled`, `soundEnabled`, `emotes`, `praiseDelayEnabled`, `praiseDelay`. No cooldown fields: a teammate's cooldown is acknowledged every time it lands.
- **`profile.services`** — the same fields as teammates, and the one default that differs between the two: `whisperEnabled` ships off here (teammates ships it on), because a feast or a portal is ambient group help rather than something aimed at you.
- **`profile.goodNews`** — `whisperEnabled`, `scope` (`ALWAYS` = anyone you buff, anything else = group only), and `watched` (its own list of ids you want announced).
- **`profile.peerPressure`** — `enabled`, `printEnabled`, `triggerOnOwnCasts`, `soundEnabled`, `watched`.
- **`profile.slash`** (Thank You Button) — `createMacro`, `message`, `emotes`.
- **`profile.watchedBuffs`** — the shared thank-you list behind Teammates and Group Services (their ids never overlap, so one table is unambiguous).

Good News keeps its own `watched` list rather than sharing `watchedBuffs` because it reuses the *same* teammate buff ids with independent choices — one shared table couldn't hold both "thank someone for it" and "announce it when I cast it."

### Migration Chain

Applied once in `InitializeDatabase`, in order. All three share the one house cutoff, 2026-08-15, after which every block below is deleted outright:

1. **`MigrateFlatToProfile`** (remove after 2026-08-15) — lifts the pre-AceDB flat layout (settings that used to sit at the `TFTB_DB` root) into the shared Default profile, then clears the orphaned root keys. Recurses per-key via `LiftInto` so a value the user set wins while untouched keys keep their default. Older copies that already hold a real AceDB `profiles` table are adopted by `AceDB:New` directly and never reach this path.
2. **`ApplyFieldMigrations`** (remove after 2026-08-15) — drops the retired `strangers.messaging` dropdown and `strangers.enabled` master switch; renames `welcomeMessage` → `showWelcome`; and splits the old combined `groupBuffs` config into independent `teammates` and `services` settings, carrying the player's old messaging prefs and watched list into both so upgrading resets nothing.
3. **Feature rename** (in `ApplyFieldMigrations`, remove after 2026-08-15) — the Buff Train and Buffs Given features were renamed Peer Pressure and Good News; their saved profile keys move `buffTrain` → `peerPressure` and `buffsGiven` → `goodNews` (via `LiftInto`), so existing toggles and watched lists survive the rename.

Defaults come from `ns.DATABASE_DEFAULTS` and are applied by AceDB-3.0 when a scope is first accessed — explicit user values, including `false`, are never overridden. Note that scalar and table defaults are physically copied into the saved table (`copyDefaults` via `rawset`); only `*`/`**` wildcard defaults resolve through metatables.

Both watched lists refill on empty: `PopulateWatchedBuffs` and `PopulatePeerPressureWatched` seed any id the saved list doesn't hold yet from the per-flavor default columns, and prune ids not live on this client so the saved data stays client-real. They run at login and again on every profile change / copy / reset (`OnProfileChanged`), because a profile swap replaces every setting at once — which is also where the open options panels are told to redraw, one `NotifyChange` per entry in `ns.OPTIONS_REGISTRY`.

## Adding a New Tracked Buff or Cooldown

`Data.TRACKED` in `Data/Tracked-Abilities.lua` — one entry is one checkbox on the Teammates, Services, or Good News panel.

1. Add an entry with its `type` (`SOLO` / `GROUP` / `SERVICE`), `detect` (`AURA` / `CAST`), the `received` and (non-service) `given` per-flavor columns, and a `triggers` list of `{ spell = id }` (add `item = id` for item-driven buffs, `aura = id` when the applied aura id differs from the cast id).
2. For a multi-rank/variant group under one toggle, list every id in `triggers` and set `name = L["GROUP_*"]` (add the key to `Locales/enUS.lua`; the Localization pass translates it into the rest). A single spell/item takes its name from the client and needs no locale key.
3. Use `"-"` in a flavor column for any id that means a different ability on that flavor; give each identity its own row.
4. Set `noDuration` when the buff is spent by an event rather than by time (Fear Ward, Misdirection), so Good News drops its duration clause. Set `opened` on a `SERVICE` to read "opened" (portals, summons) instead of "set out" (feasts, soulwells, repair bots).
5. No code change is needed — `BuildLookups`, `PopulateWatchedBuffs`, and `BuildDisplayGroups` consume the table at login.

Whatever the entry, its chat line ends up inside a message capped at **255 bytes** (Style Guide → MESSAGES → Message Length) once the spell/item link is expanded, so a new `GROUP_*` label should stay short.

## Adding a New Peer Pressure Ability

`Data.PEER_PRESSURE` in `Data/Peer-Pressure-Abilities.lua` — one row per checkbox: `{ "CLASS", { spell ids }, Era, TBC, Wrath }`. List every rank/variant in the id list; use `"-"` for a flavor where the id is a different ability. Rows are consumed at login by `Features/Peer-Pressure.lua`; no code change is needed.

## Adding a New Registered Event

1. Add the event name to `ns.EVENT_NAMES` in `Features/Core.lua`. The dispatcher registers it and the diagnostics event-registration probe picks it up automatically — never register a frame anywhere else.
2. Attach a handler in the owning feature module with `ns.SetEventHandler("EVENT_NAME", handler)`. Only one module may own an event.
3. If it's a firehose (like the combat log), add it to `ns.DIAGNOSTIC_EVENT_EXCLUDE` and decode it into the log through a purpose-built helper instead.

## Localization

- **Structure** — locale files live in `Locales/<locale>.lua`, each registered through AceLocale-3.0's `NewLocale("TFTB", "<code>")`. `enUS.lua` is the source of truth and the only file that passes the `true` default-fallback flag; every string originates there and the other locales translate from it.
- **Keeping locales in sync** — every other locale carries a translation of the same key set, and AceLocale falls back to English via `__index` for anything missing at runtime. Translating each `enUS.lua` key into every locale and keeping the files aligned is the job of the Localization pass (`3 - Copy Cleanup & Localization Prompt.md`); don't hand-edit the other locales during ordinary work. WoW ships a fixed locale set and all eleven files already exist — this is maintenance, never expansion.
- **Placeholders** — `%s`/`%d` count, type, and order must match `enUS` per key in every locale, or the string crashes at runtime. Where a language needs a different word order, use WoW Lua's positional specifiers: `MESSAGE_USED_ITEM` is `"%s used %s %s on you!"` (name, possessive, link) in `enUS`, and ptBR reorders it to `"%1$s usou %3$s %2$s em você!"` so the item link precedes the possessive. Keep the numbering when translating — it is the only file that uses positional form today.
- **Spanish** — esES and esMX are two separate, self-contained files; identical strings in both is correct and expected.
- **Quote style** — a value containing a double quote is written with single-quoted Lua delimiters and stays that way under StyLua (`ruRU`'s `GOOD_NEWS_WHISPER_ENABLE` is the one live example). Any script that audits key parity must accept both delimiters; a double-quote-only regex reports that key as missing from ruRU and invites re-adding a key that already exists.
- **Locale overflow** — TFTB writes no user-authored macro body, so its real ceiling is the **255-byte** `SendChatMessage` limit. It is measured in *bytes*, not characters, so the canary is whichever locale encodes widest — ruRU, koKR, and zhCN/zhTW all spend 2–3 UTF-8 bytes per character, which makes them the binding constraint long before German's longer word count does. The `MESSAGE_*` templates are the ones that carry a live spell/item link (itself a translated spell name), so keep translated bodies short enough to leave the link room.

## Common Pitfalls

- **A `|4` plural escape in a sent message**: WoW's own duration strings (`D_MINUTES` is `"%d |4minute:minutes;"`) carry an escape the UI expands only at render time. It looks correct in a print, but `SendChatMessage` rejects any message still holding one — "Invalid escape code in chat message" — and silently drops the *whole line*. `ResolvePlurals` in `Features/Announcements.lua` expands it to plain text before the whisper is queued.
- **Whispering a pet name**: a whisper addressed to a pet bounces ("No player named 'X' is currently playing"). Every whisper path is guarded by `ns.IsPlayerGUID`, and pet sources are traded for their owner via `ResolveSource` (which returns nil rather than falling back to the pet).
- **Cross-realm source names**: a combat-log name is `Name-Realm` and never matches a name lookup or resolves as an emote target. Classify group membership by affiliation flags, and strip the realm with `Ambiguate(name, "short")` before passing a name to `DoEmote`.
- **`DoEmote(cmd, nil)` is not undirected**: it falls back to your *current target*, thanking a bystander. Pass `"none"` (or an unresolvable name, which degrades the same way) to force the undirected emote.
- **Resolving an emote target before a delay**: `ResolveEmoteTarget` hands back a live unit token, and `target` / `focus` / `mouseover` name whoever you are pointing at *in that instant*. Resolve it when the buff lands and a delayed emote thanks whoever you moved on to. `DeliverPraise` resolves inside the timer for exactly this reason; every other gate is settled before the timer arms.
- **Opening the options panel by title**: `Settings.GetCategory(<title>)`, or passing the add-on title to `Settings.OpenToCategory`, returns nil on clients that carry the Settings API — execution falls through to `AceConfigDialog:Open`, and the panel opens as a floating window instead of docking into Blizzard's settings. It still works on Classic Era, so one-flavor testing misses it. `ns:OpenOptionsPanel` captures both return values of `AddToBlizOptions` and routes by the captured ID, then the captured frame, resolving no names anywhere.
- **Reading a buff's duration too early**: for Good News, the aura lands a tick *after* the cast succeeds, so reading it inline reports "no duration" for every buff. Wait `AURA_SETTLE`, then read it off the recipient after re-confirming their GUID.
- **A live buff reporting 0 duration**: `ns.GetBuffDuration` returns 0 for a timerless buff and nil for absent — callers must nil-check, never test the number for truthiness.
- **Native `GetSpellLink` in chat**: on Classic it omits the trailing `:0` field, which `SendChatMessage`'s validator strips on send, so whispers arrive with the link gone. `ns.GetSpellLink` builds `|Hspell:<id>:0|h` by hand to pass the validator.
- **Reusing a spell id across flavors**: `DoesSpellExist` can't tell Ice Block (Era) from Cold Snap (TBC) — they share id `11958`. Use the `"-"` flavor column, one row per identity (see Per-Flavor Tracking Data).
- **Editing a vendored library**: `Includes/Libraries/` is refreshed from upstream by the packager on every release (`externals` in `.pkgmeta`), so a local fix is discarded at build time. Work around it in `Features/` or fix it upstream.

## Contributing

- **Issues** — <https://github.com/Gogo1951/Thanks-for-the-Buff/issues>.
- **Bug reports** — include game version + locale, class + level, repro steps, and the relevant chat output. The Diagnostic Tools panel (enable it, run the Context / API / Event checks) produces a ready-to-paste report.
- **Discord** — <https://discord.gg/eh8hKq992Q>.
- **PRs** — keep changes scoped; run StyLua with its default config over every touched Lua file; preserve migration discipline (never rename a saved-variable key without a dated migration window and note); check any sent-message change against the **255-byte** chat limit in the widest-encoding locale (Style Guide → MESSAGES → Message Length is canonical for both output ceilings — the macro one is measured in bytes with `#body`, though TFTB's only macro body is the fixed literal `/thankyou`); and update this document if the architecture or file map changes.
- **Commit and PR descriptions require a User Story.** Frame the change by who it helps and why, not just what changed.

   **Format:** *As a [role], I [needed / wanted] [behavior] so that [outcome]. This change [does X].*

   **Example:** *As a raider who gets buffed constantly, I wanted teammate buffs to use the same soft sound as stranger buffs so that a busy pull stops sounding like an alarm. This change collapses the two sound helpers into `ns.PlayBuffSound` and drops `Combat-Buff.ogg`.*
