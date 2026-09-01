# Thanks for the Buff // Technical Reference

This document combines architecture notes and contribution guidance for developers working on Thanks for the Buff. For end-user documentation, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md).

## File Map

The repo root *is* the add-on folder; the packager renames it to `TFTB` on release (`package-as` in `.pkgmeta`), which is why the installed path is `Interface/AddOns/TFTB/`.

```
Thanks-for-the-Buff/
├── .github/
│   └── workflows/
│       └── package.yml               Release packaging (repo only)
├── .gitattributes                    LF normalization (repo only)
├── .gitignore                        Dev-clutter ignore list (repo only)
├── .luacheckrc                       Lint config (repo only)
├── .pkgmeta                          Packager manifest: package-as, externals, ignore list (repo only)
├── TFTB.toc                          Load order; one TOC for Era and TBC Anniversary
├── Data/
│   ├── Data.lua                      Locale init, palette, registry names, constants, emote list
│   ├── Tracked-Abilities.lua         Data.TRACKED: what other players spend on you
│   ├── Peer-Pressure-Abilities.lua   Data.PEER_PRESSURE: same-class cooldowns
│   └── Default-Settings.lua          ns.DATABASE_DEFAULTS, one shared profile
├── Features/
│   ├── Core.lua                      Version, AceDB lifecycle, event dispatcher, login order
│   ├── Utilities.lua                 Colors, API shims, emote catalog, GUID and sound helpers
│   ├── Announcements.lua             Prints, whispers, emotes, durations, whisper queue
│   ├── Buff-Tracking.lua             The reaction engine: detect, classify, deliver praise
│   ├── Peer-Pressure.lua             Same-class cooldown alert, tapped from the combat log
│   ├── Thank-You-Button.lua          The five Thank You buttons: macros and command bodies
│   └── Diagnostics.lua               Runtime-only probes and dumps; strings not localized
├── Includes/
│   ├── Images/                       Thanks-for-the-Buff.tga, the TOC IconTexture
│   ├── Libraries/                    Vendored LibStub and Ace3; never hand-edited
│   └── Sounds/                       Buff.ogg (any buff on you), Thunder.ogg (Peer Pressure)
├── Locales/                          AceLocale-3.0 strings; enUS.lua is the source of truth
├── Options/
│   ├── Options-Utilities.lua         Shared helpers and the buff-panel control factories
│   ├── Options-General.lua           Root panel: pitch, welcome toggle, /commands, links
│   ├── Options-Stranger-Buffs.lua
│   ├── Options-Teammate-Buffs.lua
│   ├── Options-Send-Good-News.lua
│   ├── Options-Service-Alerts.lua
│   ├── Options-Peer-Pressure.lua
│   ├── Options-Thank-You-Button.lua
│   ├── Options-Profiles.lua          Stock AceDBOptions-3.0 table, returned as-is
│   ├── Options-Diagnostics.lua       Renders the Diagnostics probes
│   └── Options.lua                   Registration order, panel routing, slash commands
├── LICENSE                           MIT (repo only)
├── README.md                         End-user documentation
├── README-Technical.md               This document
└── README-Testing.md                 Manual test plan, walked before tagging a release
```

`Includes/Libraries/` is committed *and* declared as packager `externals`, so every tagged release re-pulls each library from upstream and commits the result back to the default branch. A hand-edit to a vendored file is discarded on the next build. Fix the upstream library, or work around it in `Features/`.

No deprecated or dead files remain in the tree, and no saved-variable migration code remains in `Features/Core.lua`. A database written before the AceDB conversion keeps its orphaned root keys, which nothing reads, and the active profile starts from defaults.

## Architecture

### Event Loop

`Features/Core.lua` owns one frame and one dispatcher; feature files never register their own frames. The complete event list is exported as `ns.EVENT_NAMES`, so the registered set, the diagnostics event-log tap, and the event-registration probe can never drift from one another:

```
PLAYER_LOGIN · PLAYER_ENTERING_WORLD · COMBAT_LOG_EVENT_UNFILTERED
UNIT_SPELLCAST_SENT · UNIT_SPELLCAST_SUCCEEDED · LOADING_SCREEN_DISABLED
```

Feature modules attach handlers by name with `ns.SetEventHandler(event, handler)`. Attaching the same event twice replaces the earlier handler, so there is exactly one owner per event. Every event first passes through `ns:LogEvent` when diagnostics logging is active, then to its handler.

`PLAYER_LOGIN` runs the whole setup sequence in order, and the order is load-bearing: `AceDB:New` first (nothing may read a setting before it exists), then `ns.SetupBuffTracking` and `ns.SetupPeerPressure` (which need the spell and item APIs live), then `ns.SetupOptions` (whose panels render the display groups those two just built), then `ns:CreateAutoMacro`. The welcome message rides `PLAYER_ENTERING_WORLD` behind a once-per-session flag, since that event refires on every loading screen.

A safety timer (`Data.SAFETY_PAUSE`, 3s) suppresses buff reactions until the world settles after login or a loading screen. A monotonic token invalidates earlier timers, so back-to-back loading screens cannot let a stale callback flip `isReady` back on mid-pause.

### Combat Lockdown

Three things answer to combat, in three different ways.

**The options panel refuses outright.** `InCombatLockdown()` is the first thing `ns:OpenOptionsPanel` does, one gate in front of the whole routing chain, ahead of the Settings and AceConfigDialog branches, so `/tftb` behaves identically on every flavor. It prints `CHAT_OPTIONS_IN_COMBAT` and returns. It never queues the panel to open when combat ends and never registers `PLAYER_REGEN_ENABLED` to finish the job later: Blizzard's Settings panel is protected in combat, and a silent refusal reads as a broken command.

**Macros are skipped, not queued.** `ns.ReconcileMacros` returns early in combat, in both directions, because the macro API is unavailable there. A Create Macro toggle flipped mid-fight simply leaves the macro alone; the next login or profile change reconciles it. There is no dirty flag and no replay.

**Emotes are suppressed, not queued.** The reaction paths themselves run in combat: self-only prints, sounds, and outgoing whispers all fire on qualifying buffs whether or not you are fighting, because they touch no protected functions. `/cheer`-style emotes are visible and social, so `HandleTracked` and `HandleStrangersBuff` perform them only when `not InCombatLockdown()`. An emote skipped during combat is simply not performed for that buff, and because a praise cooldown is spent only when praise actually goes out, the next qualifying buff after combat reacts immediately. Combat is tested twice: once when the reaction is decided, and again inside `DeliverPraise` when the emote fires, so entering combat during a Praise Delay still suppresses it.

### Praise vs Notifications

The reactions split into two kinds, which is also how the Stranger Buffs, Teammate Buffs, and Service Alerts panels are laid out:

- **Praise** is the thank-you whisper and the emote. Both go outward to the player who buffed you, so both answer to the cooldowns and to the Praise Delay, and both are delivered by `DeliverPraise` in `Features/Buff-Tracking.lua`.
- **Notifications** are the chat print and the sound. Self-only, never throttled or delayed, fired inline the moment the buff qualifies.

`DeliverPraise` receives decisions, not permissions to re-derive: every gate (the toggles, both cooldowns, the whisper throttle, the combat check) is settled before the timer is armed, so a burst of buffs landing inside the delay window cannot slip past a cooldown. `praiseDelayEnabled` off, or a missing `praiseDelay`, means a delay of 0 and inline delivery. The emote *target* is the deliberate exception, resolved inside the timer rather than before it: `ResolveEmoteTarget` returns a live unit token, and `target` / `focus` / `mouseover` all name whoever you are pointing at in that instant, so resolving early makes a delayed emote thank whoever you moved on to.

### Detect, Classify, Announce

The reaction pipeline runs across `Features/Buff-Tracking.lua` and `Features/Announcements.lua`:

1. **Detect.** `OnCombatLogEvent` taps `SPELL_AURA_APPLIED` and `SPELL_AURA_REFRESH` (buffs landing on you), `SPELL_CAST_SUCCESS`, and `SPELL_RESURRECT`. `OnUnitSpellcastSucceeded` taps group services and confirms Good News casts; `OnUnitSpellcastSent` captures the recipient of your own casts. The three lookups (`auraLookup`, `castLookup`, `givenLookup`) are each keyed by the id the relevant event actually carries.
2. **Classify.** `MatchTracked` requires the subevent to match the entry's own `detect` mode rather than merely finding the id in a lookup, which is what keeps a `RESURRECT` entry from firing on the `SPELL_CAST_SUCCESS` it shares a lookup with. `ResolveSource` trades a pet or guardian GUID for its owner and returns nil (drop the event) when no owner unit resolves. Cross-realm sources arrive as `Name-Realm` and never match a name lookup, so group membership is decided by the combat-log affiliation flags (`MINE`, `PARTY`, `RAID`), and a friendly outsider is recognized by `AFFILIATION_OUTSIDER`.
3. **Announce.** `HandleTracked` and `HandleStrangersBuff` route to the announcement helpers, which apply the target marker (`{rt1}` Star), the `TFTB` brand, and the colors. Sent messages carry a spell or item link; `SendChatMessage` rejects anything over **255 bytes** (`ns.CHAT_MESSAGE_MAX_LENGTH`), and TFTB's single-line messages stay well under it.

Each buff panel carries a master switch (`strangers.enabled`, `teammates.enabled`, `services.enabled`, `peerPressure.enabled`, and Good News's own `whisperEnabled`), and the switch is a real gate in the engine, not only a way to hide controls: `HandleTracked`, `HandleStrangersBuff`, `ns.CheckPeerPressure`, and `OnUnitSpellcastSent` each return early when their panel is off.

### Item Data Caching

Item names and links come from `GetItemInfo`, which returns nil on a cold cache and fills asynchronously. `WarmItemCache` runs at login and touches every tracked item so its name and link are warm by the time an options panel or a "used their X on you" message needs it. Where a name still is not ready, the options toggle shows the `TRACKED_ITEM_PENDING` placeholder (`Item #%d`) and resolves on the next panel open, which is why the Teammate Buffs, Send Good News, Service Alerts, and Peer Pressure panels register as functions (rebuilt on open) rather than as prebuilt tables.

Spell *descriptions* have the same shape of problem for a different reason: Classic keeps tooltip data only for spells the character has actually known, and these panels list every class. `ns.RequestSpellData` asks the client to stream a spell's text in, and every toggle's `desc` is a function rather than a baked string, so the real text appears once it lands.

All item and spell access goes through the `ns.GetItemInfo`, `ns.GetItemIcon`, `ns.GetSpellName`, and `ns.GetSpellTexture` shims in `Features/Utilities.lua`, which resolve the modern `C_Item` / `C_Spell` API or the legacy global once at load.

### Options Panels

Nine AceConfig panels register in `Options/Options.lua`, one per key in `ns.OPTIONS_REGISTRY`, in the order they appear in Blizzard's settings tree: General (root), then Stranger Buffs, Teammate Buffs, Send Good News, Service Alerts, Peer Pressure, and Thank You Button, then Profiles second-to-last and Diagnostic Tools last. The tree order *is* the order of the `AddToBlizOptions` calls.

Each panel file owns its own layout and order numbers; the controls themselves come from factories in `Options/Options-Utilities.lua` (`ns.DefinePrintToggle`, `ns.DefineWhisperToggle`, `ns.DefineEmotesToggle`, `ns.DefineEmoteGroup`, `ns.DefineSoundToggle`, `ns.DefineSoundPreview`, `ns.DefinePraiseDelayToggle`, `ns.DefineSecondsSelect`, `ns.DefineEntryToggle`, and friends). Every factory takes a `settings` accessor returning the profile subtable it binds to, so one definition serves Stranger Buffs, Teammate Buffs, and Service Alerts without those three having to share a layout, which they no longer do.

Two registration shapes coexist deliberately. Panels whose contents are fixed at login register a **prebuilt table** (General, Stranger Buffs, Thank You Button, Profiles, Diagnostic Tools); panels that render tracked abilities register the **builder function itself** (Teammate Buffs, Send Good News, Service Alerts, Peer Pressure), so the table is rebuilt on open once lazily-loaded item names have resolved.

A panel behind a master switch hides its contents with `ns.HideAllExcept(args, isHidden, keep)`, applied to the finished args table rather than threaded through every shared factory. The rule is positional (everything except the intro text and the switch itself), so a control added later is covered automatically, and existing `hidden` values are composed rather than replaced, which is what keeps the emote grid following its own toggle inside a panel that is switched on.

Section headers are real AceConfig `header` widgets throughout, built by `ns.OptionsHeader`, whose optional third `hidden` argument collapses a gated section. Silver helper text under a control is `ns.OptionsHelp`.

`ns:OpenOptionsPanel` backs the `/tftb` command. It routes by the **category ID captured from `AddToBlizOptions`**, never by panel title. See the Common Pitfalls entry for why a title lookup is the standing trap here.

Two panels render a **sample message through the real pipeline** rather than a hand-written mock: Good News calls `ns:BuildGoodNewsMessage` with a live spell link, and Peer Pressure calls `ns.GetPrintPrefix` plus `ns:BuildPeerPressureMessage`. A sample built any other way drifts from what players actually receive the first time the format changes.

### Cooldown Namespaces

A single `sessionCooldowns` table (key to expiry) backs every throttle, with disjoint string namespaces so keys on the same GUID never collide:

| Key | Window | Purpose |
| --- | --- | --- |
| `praise:all` | `strangers.praiseCooldown` (default 0, off) | Overall stranger praise limit |
| `praise:<guid>` | `strangers.cooldown` (default 3s) | Per-source stranger praise |
| `whisper:<guid>` | 45s | Per-recipient outgoing whisper throttle |
| `service:<guid>` | 10s | Group-service rate limit *and* multi-token dedup |
| `goodnews:<guid>:<spellID>` | 10s | Good News per-recipient-per-spell dedup |

Both `praise:` keys gate the whisper and the emote alike, and neither is stamped unless praise actually goes out. `whisper:<guid>` is a floor underneath them that no setting can lower: a 1-second praise cooldown still cannot whisper the same player more than once every 45 seconds, which is what keeps a generous setting clear of the server's chat squelch.

`SetCooldown` opportunistically sweeps lapsed entries on each write, so the table cannot grow unbounded across a long session.

## Reaction Sources: Combat Log vs Cast Events

Why the same feature set reads three different event streams:

- **Buffs on you (Stranger Buffs, Teammate Buffs)** ride the combat log. `SPELL_AURA_APPLIED` and `SPELL_AURA_REFRESH` tell you a buff landed and on whom.
- **Group services (feasts, soulwells, portals, repair bots)** ride `UNIT_SPELLCAST_SUCCEEDED`, *not* the combat log. These utility casts do not reliably emit `SPELL_CAST_SUCCESS` in `COMBAT_LOG_EVENT_UNFILTERED`, but they do fire the unit event for any unit the client tracks. A service has no per-you destination, so crediting the casting unit is all that is needed. Because the event's reach (target, focus, nameplates) is far wider than the feature's, the caster is filtered to `UnitInParty` / `UnitInRaid`, and `UnitIsPlayer` drops group pets; otherwise a stranger opening a portal across a capital city announces as a service.
- **Good News (buffs you cast on others)** rides `UNIT_SPELLCAST_SENT` plus `UNIT_SPELLCAST_SUCCEEDED`. The combat log is scoped to you, your group, and units in combat, so buffing a player *outside* your group produces no `SPELL_AURA_APPLIED` at all, and that is the most common case for this feature. `SENT` is also the only event that names the recipient; `SUCCEEDED` confirms the cast went off, so an interrupted cast stays silent.

The one deliberate crossover is the `RESURRECT` detect mode. Goblin jumper cables and Defibrillate report `SPELL_CAST_SUCCESS` on every jolt, revived or not, so a Good News record for one of those casts is *parked* at `SUCCEEDED` instead of announced, and only the `SPELL_RESURRECT` a working jolt produces releases it (`ClaimPendingResurrect`). A jolt that never revives anyone is swept by `PENDING_TTL` and stays silent.

## Good News

Good News whispers the player *you* just buffed to tell them what they got and, when the number is short enough to act on, how long it lasts. It is the only feature driven by your own casts, and the only one that sends more than one message per trigger.

The whisper is assembled from a player-editable template holding one token:

```
Template   You have %a!
Sent       {rt1} TFTB // You have [Power Infusion] for 15 Seconds!
```

`%a` carries the whole ability phrase, link plus optional duration clause. Folding the duration into the token instead of exposing it as a second placeholder is what lets one template cover both cases: a one-shot cast with nothing to report leaves no dangling clause, so the template needs no conditional and the player needs no second variable. Substitution is `gsub` with a replacement **function**, never `string.format`: the template is user-editable, so a stray `%` would otherwise raise an error mid-whisper, and a `%` inside a spell link would be read back as a capture reference. The star marker and the `TFTB // ` brand are added by `ns:BuildGoodNewsMessage` and are deliberately out of reach, because they are how a recipient recognizes where the whisper came from. The edit box caps at 120 bytes through `ns.TrimToBytes`, and emptying it restores the default rather than sending a brand with nothing after it.

Because `SENT` and `SUCCEEDED` carry the **cast** id, `givenLookup` is keyed by cast id, and each record carries `watchedId` (the id the panel toggle and the settings list use) and `auraId` (the id to read the recipient's remaining duration with). `auraId` is deliberately absent for no-aura casts like Rebirth and for `noDuration` entries like Fear Ward and Misdirection: nothing to read is what drops the duration clause from their message.

A message ends up without a duration clause in exactly three ways, and it is worth keeping them straight because only the last one looks at a real timer:

1. **No aura to read.** A cast that leaves none (Rebirth, Lay on Hands, jumper cables). Settled at login, in `BuildLookups`.
2. **`noDuration`.** An aura spent by an event rather than by time (Fear Ward, Misdirection, Tricks of the Trade, Intervene). Also settled at login.
3. **A minute or longer.** `GOOD_NEWS_MAX_SECONDS` (60) in `Features/Announcements.lua`. "for 15 Seconds" is a cue to use it now; "for 10 Minutes" is a number nobody paces themselves off, and it pushes the ability name further from the front of a one-job whisper. Checked per cast, on the value actually read off the recipient.

The cap is compared against the duration **pre-rounded** the way `FormatDuration` would round it, so a 59.7s aura is tested as the "60 Seconds" it would print as rather than slipping under and printing a full minute in seconds. Good News has no *lower* bound: a 6-second buff whispers "for 6 Seconds". The `minBuffDuration` floor (default 21s) belongs to Stranger Buffs alone.

"Your own cast" includes your **pet's**. Roar of Sacrifice and Battle Squawk are cast by the pet and never by the player, so `OnUnitSpellcastSent` accepts `player` and `pet` alike; a bare `unit == "player"` test silently switches Good News off for every pet-cast entry in the data. Recipients are resolved by name back to a unit token (target, mouseover, focus, then group members), which is what proves the recipient is a player rather than a pet and gives something to read the duration off later. `scope` decides who qualifies: `ALWAYS` whispers anyone you buff, and anything else means group members only, with unrecognized values failing closed into the group check.

Four timing constants shape the flow:

- `AURA_SETTLE` (0.1s, `Features/Buff-Tracking.lua`). The aura lands a beat *after* the cast succeeds, so `AnnounceGivenCast` waits before reading the duration, re-checking that the unit still holds the recipient's GUID.
- `PENDING_TTL` (15s). A `SENT` whose `SUCCEEDED` never arrives, or a parked resurrect that never took, is swept from `pendingGiven`.
- `GOODNEWS_DEDUP` (10s). A quick recast on the same person does not whisper twice.
- `WHISPER_GAP` (0.35s, `Features/Announcements.lua`). The whispers themselves are **queued, not sent inline** (`QueueWhisper`). A raid-wide buff like Prayer of Fortitude lands on every recipient in the same instant, and a burst of same-frame whispers risks the server-side chat squelch, which would drop them all silently. An empty queue still sends immediately, so the common one-recipient case feels instant.

Durations render through the client's own localized `D_HOURS`, `D_MINUTES`, and `D_SECONDS` templates, so the units are correct in every language without TFTB shipping its own copies. That comes with a trap severe enough to have its own entry in Common Pitfalls: those templates carry a `|4singular:plural;` escape that `SendChatMessage` rejects outright, so `ResolvePlurals` expands it to plain text first. With the cap in place no caller reaches `FormatDuration`'s minute or hour rung (Good News stops below a minute, and both dropdowns list seconds), but the ladder stays, because the helper formats whatever it is handed and a later caller re-deriving it would walk straight back into that escape.

## Per-Flavor Tracking Data

`Data.TRACKED` and `Data.PEER_PRESSURE` carry `{ Era, TBC, Wrath }` default columns. `ns.FLAVOR_INDEX` (from `GetBuildInfo`) picks the column for the running client; anything past Wrath reads the Wrath slot, which is deliberate forward-prep. `Data.TRACKED` names its columns (`received`, `given`); `Data.PEER_PRESSURE` rows are positional, so `Features/Peer-Pressure.lua` reads slot `2 + ns.FLAVOR_INDEX`.

A `"-"` in the flavor column means the row **does not exist on this flavor at all**, a stronger statement than `DoesSpellExist` can make, because Blizzard reuses spell ids across flavors for entirely different abilities. Id `11958` is **Ice Block** on Era but **Cold Snap** in TBC and Wrath, and `12472` is **Cold Snap** on Era but **Icy Veins** in TBC and Wrath. Such ids get one row per identity, each hidden (`"-"`) on the flavors where the id means something else. A `"-"` row owns nothing: no lookup, no toggle, no seed, and no place in the diagnostics coverage counts. Numeric columns seed the checkbox default (`0` is off, anything else on).

## Peer Pressure

Peer Pressure alerts you when another player of your class pops a tracked cooldown so you can join in. `Features/Peer-Pressure.lua` builds a class-keyed lookup from `Data.PEER_PRESSURE`, and `ns.CheckPeerPressure` is called from the combat-log tap for every `SPELL_CAST_SUCCESS`. Spells are class-locked, so "the caster is your class" needs no GUID inspection: the entry's class tag against your own is the whole test.

Two filters matter. `IsGroupAffiliated` drops passers-by, because Era's combat log is proximity-scoped rather than group-scoped, so a paladin popping Lay on Hands across a capital city arrives exactly like a raid member's cast. And the `MINE` flag deliberately lets your own casts through to the "Trigger on Own Casts" check (`triggerOnOwnCasts`, default off), which is the setting that actually owns that decision; this is also why the Peer Pressure tap sits *above* the own-source drop in `OnCombatLogEvent`.

When the cast had a real player target other than the caster, the message names them ("Expektor used [Blade Flurry] on Sally!"); self-buffs and pet targets read as plain. The body renders in the caster's class color (always your own class), the spell link keeps the standard link blue, and the target's name wears the target's class color. A closing `|r` resets the fontstring to white, so `ns:BuildPeerPressureMessage` re-opens the body color right after the link and after the target's name. Print and sound are independent toggles, and with both off nothing fires.

## Thank You Buttons

`Data.THANK_YOU_BUTTONS` in `Data/Data.lua` is the whole feature. One row per button, holding the profile key it stores under, the macro it offers to create, the slash command that macro runs, and whether it picks one chosen emote or randomizes over a checklist:

```lua
{ profileKey = "slash",  macroName = "- Thank",  command = "/thankyou" },
{ profileKey = "slash2", macroName = "- TFTB 2", command = "/thankyou2", singleEmote = true },
```

Everything else is generated from that list: the defaults in `Data/Default-Settings.lua`, the options sections in `Options/Options-Thank-You-Button.lua`, the slash registrations in `Options/Options.lua`, and the macros in `Features/Thank-You-Button.lua`. Nothing counts the buttons.

Button 1 is the original and keeps its on-by-default settings and its friendly default whisper. Buttons 2 through 5 were added later and ship fully switched off (no macro, no whisper text, no emote), so a fresh install behaves exactly as it did before they existed. An empty message sends no whisper and an empty emote token performs no emote, both by existing logic, so "off" needs no extra guard. All five macro names lead with a dash so the family sorts together at the top of the macro list.

`singleEmote` changes the stored shape as well as the control: `emote` (one token, `""` meaning none) rather than `emotes` (a set). The single-emote dropdown is built from the **client's** emote catalog (`ns.GetEmoteCatalog`, read from the client's own `EMOTE<n>_TOKEN` globals), not from the curated twelve in `Data.EMOTES`, so it offers precisely what this build can perform. `ns:DoEmoteToken` validates against that catalog before calling `DoEmote`, because `DoEmote` given a bad token is a silent no-op, which is indistinguishable from a broken button.

`ns.ReconcileMacros` is the only macro path, and it runs in both directions: create the enabled macros that are missing, delete the disabled ones that are still there. It runs at login, on every profile change, and from the Create Macro toggle itself, so a profile switch moves the macros with it instead of leaving the previous profile's on the bars until a reload. The global cap (`GetNumMacros() < 120`) is re-read *inside* the loop, because each macro this call creates counts against it. Deletion resolves the index from the button's exact name first, so the existence check and the delete agree on the same macro.

`ns.RunThankYou` requires a player target that is not you, emotes at it, and whispers only when the target shares your faction and the message is non-empty. The whisper body is sent verbatim and is unbranded by design: a human-sounding message, deliberately without the marker or add-on name. Its edit box caps at `ns.CHAT_MESSAGE_MAX_LENGTH` (255 bytes) through `ns.TrimToBytes`, which steps back off a UTF-8 continuation byte so a cut never lands mid-character.

## Diagnostics

`Features/Diagnostics.lua` is runtime-only: `ns.diagnostics` holds `enabled`, `logging`, and `log`, and **nothing persists to SavedVariables**. Its strings live in `ns.DiagnosticsStrings` as plain English and never go through `Locales/`, because they are developer-facing. The enable gate defaults off, and turning it off also stops the event log.

The event log snapshots each argument to a string immediately (never retaining frame or table references), caps arg count and length (`EVENT_LOG_SIZE` 500, `EVENT_LOG_MAX_ARGS` 8, `EVENT_LOG_MAX_ARG_LENGTH` 255), and escapes pipes *after* truncation so a clipped argument cannot eat the next separator.

`COMBAT_LOG_EVENT_UNFILTERED` is the sole entry in `ns.DIAGNOSTIC_EVENT_EXCLUDE`, since as a firehose it would bury the signal. The buff engine instead feeds one decoded line per nearby `SPELL_CAST_SUCCESS` and `SPELL_RESURRECT` through `ns:LogCombatCast`, recorded *before* any filtering, so a portal or feast that arrives but is dropped is still visible. Each line carries the spell id and name, the source, the decoded affiliation and reaction flags, and `tracked` / `watched` flags to tell a data problem from a downstream one. Resurrects are labelled `REZ` rather than `CAST` specifically so a failed jolt (a `CAST` with no `REZ` after it) can be told from a working one by eye.

Beyond the copied framework, three probes are TFTB's own. **Add-on Context** reports the player, group state, every panel's settings, the watched-buff counts, the live-versus-total tracked coverage (`ns.DIAGNOSTIC_TRACKED`), and an `IsPlayerSpell` readout over the tracked spells for the player's class (`ns.DIAGNOSTIC_SPELLS`), which is where most "nothing happens when I get buffed" reports resolve. **Emote Extract** dumps every emote the running client can perform as a tab-separated table, so the same build produces the same list on any flavor without a code change. The **Taint Log** buttons are the only state the panel ever writes.

## Saved Variables

One account-wide table, `TFTBDB`, managed by AceDB-3.0.

**Thanks for the Buff uses the Simple saved-variables model.** `AceDB:New` is called with `true` as its third argument, so every character on the account lands on the one shared `"Default"` profile and the whole database lives under `profile`. `global` is unused: there is no minimap button and nothing the add-on stores differs from character to character. **Reset Profile therefore clears everything, back to install defaults.** A new setting belongs in `ns.db.profile`.

The top-level keys, regenerated from `Data/Default-Settings.lua`:

- **`showWelcome`** is the login welcome message.
- **`strangers`**, **`teammates`**, and **`services`** each hold one panel's reactions: its master switch, the print / whisper / emote / sound toggles, the emote checklist, and the Praise Delay pair. `strangers` alone adds `praiseCooldown`, `cooldown`, and `minBuffDuration`; the other two carry no cooldowns at all, because a teammate's cooldown is worth acknowledging every time it lands. The one default that differs between `teammates` and `services` is `whisperEnabled`, which ships off for services: a feast or a portal is ambient group help rather than something aimed at you.
- **`goodNews`** holds `whisperEnabled`, `scope`, the editable `message`, and its own `watched` list.
- **`peerPressure`** holds `enabled`, `printEnabled`, `triggerOnOwnCasts`, `soundEnabled`, and its own `watched` list.
- **`watchedBuffs`** is the shared thank-you list behind Teammate Buffs and Service Alerts. Their ids never overlap, so one table is unambiguous.
- **`slash`** through **`slash5`** are the five Thank You buttons, one subtable each, generated from `Data.THANK_YOU_BUTTONS`.

Good News keeps its own `watched` list rather than sharing `watchedBuffs` because it reuses the *same* teammate buff ids with independent choices. One shared table could not hold both "thank someone for it" and "announce it when I cast it".

Defaults come from `ns.DATABASE_DEFAULTS` and are applied by AceDB-3.0 when a scope is first accessed, and explicit user values, including `false`, are never overridden. Note that scalar and table defaults are physically copied into the saved table (`copyDefaults` via `rawset`); only `*` and `**` wildcard defaults resolve through metatables.

Both watched lists refill on empty. `PopulateWatchedBuffs` and `PopulatePeerPressureWatched` seed any id the saved list does not hold yet from the per-flavor default columns, and prune ids not live on this client so the saved data stays client-real. They run at login and again on every profile change, copy, or reset, because a profile swap replaces every setting at once. That same callback reconciles the Thank You macros and tells the open options panels to redraw, one `NotifyChange` per entry in `ns.OPTIONS_REGISTRY`.

There is no migration chain. Every pre-cutoff migration has been deleted, and a new schema change ships its own bridge for exactly one release.

## Adding a New Tracked Buff or Cooldown

`Data.TRACKED` in `Data/Tracked-Abilities.lua`. One entry is one checkbox on the Teammate Buffs, Service Alerts, or Send Good News panel.

1. Add an entry with its `type` (`SOLO`, `GROUP`, or `SERVICE`), `detect` (`AURA`, `CAST`, or `RESURRECT`), the `received` and (non-service) `given` per-flavor columns, and a `triggers` list of `{ spell = id }`. Add `item = id` for item-driven buffs, and `aura = id` when the applied aura id differs from the cast id.
2. For a multi-rank or multi-variant group under one toggle, list every id in `triggers` and set `name = L["GROUP_*"]`, adding the key to `Locales/enUS.lua`; the Localization pass translates it into the rest. A single spell or item takes its name from the client and needs no locale key.
3. Use `"-"` in a flavor column for any id that means a different ability on that flavor, and give each identity its own row.
4. Set `noDuration` when the buff is spent by an event rather than by time (Fear Ward, Misdirection), so Good News drops its duration clause. It changes the outcome only for buffs *under a minute* (Misdirection, Tricks of the Trade, Intervene), since longer ones are dropped by the cap regardless, but set it wherever it is true.
5. Set `opened` on a `SERVICE` to read "opened" (portals, summons) instead of "set out" (feasts, soulwells, repair bots). Use `detect = RESURRECT` for a cast that can fail, so only a confirmed revive announces.
6. No code change is needed. `BuildLookups`, `PopulateWatchedBuffs`, and `BuildDisplayGroups` consume the table at login.

Whatever the entry, its chat line ends up inside a message capped at **255 bytes** (Style Guide, MESSAGES, Message Length) once the spell or item link is expanded, so a new `GROUP_*` label should stay short.

## Adding a New Peer Pressure Ability

`Data.PEER_PRESSURE` in `Data/Peer-Pressure-Abilities.lua`. One row per checkbox: `{ "CLASS", { spell ids }, Era, TBC, Wrath }`. List every rank or variant in the id list, and use `"-"` for a flavor where the id is a different ability. Rows are consumed at login by `Features/Peer-Pressure.lua`; no code change is needed.

## Adding a New Thank You Button

Append one row to `Data.THANK_YOU_BUTTONS` in `Data/Data.lua`, with a unique `profileKey`, a `macroName` leading with a dash, and a `command` nobody else registers. Its defaults, options section, slash command, and macro all generate from that row, and it starts switched off. Nothing else changes.

## Adding a New Registered Event

1. Add the event name to `ns.EVENT_NAMES` in `Features/Core.lua`. The dispatcher registers it and the diagnostics event-registration probe picks it up automatically. Never register a frame anywhere else.
2. Attach a handler in the owning feature module with `ns.SetEventHandler("EVENT_NAME", handler)`. Only one module may own an event.
3. If it is a firehose (like the combat log), add it to `ns.DIAGNOSTIC_EVENT_EXCLUDE` and decode it into the log through a purpose-built helper instead.

## Localization

- **Structure.** Locale files live in `Locales/<locale>.lua`, each registered through AceLocale-3.0's `NewLocale("TFTB", "<code>")`. `enUS.lua` is the source of truth and the only file that passes the `true` default-fallback flag; every string originates there and the other locales translate from it.
- **Keeping locales in sync.** Every other locale carries a translation of the same key set, and AceLocale falls back to English via `__index` for anything missing at runtime. Translating each `enUS.lua` key into every locale and keeping the files aligned is the job of the Localization pass (`3 - Copy Cleanup & Localization Prompt.md`); do not hand-edit the other locales during ordinary work. WoW ships a fixed locale set and all eleven files already exist, so this is maintenance, never expansion.
- **Placeholders.** The `%s` and `%d` count, type, and order must match `enUS` per key in every locale, or the string crashes at runtime. Where a language needs a different word order, WoW's Lua accepts positional specifiers (`%1$s`); no locale needs one today, and a translation that introduces one keeps the numbering consistent across the whole value.
- **Spanish.** esES and esMX are two separate, self-contained files; identical strings in both is correct and expected.
- **Quote style.** A value containing a double quote is written with single-quoted Lua delimiters and stays that way under StyLua. `BUTTON_MACRO_ENABLE` (`'Enable Macro "%s"'`) is the live example, in every locale including enUS. Any script that audits key parity must accept both delimiters; a double-quote-only regex reports that key as missing and invites re-adding a key that already exists.
- **Diagnostics strings are not localized.** They live in `ns.DiagnosticsStrings` in `Features/Diagnostics.lua` as plain English.
- **Locale overflow.** TFTB writes no user-authored macro body, so its real ceiling is the **255-byte** `SendChatMessage` limit. It is measured in *bytes*, not characters, so the canary is whichever locale encodes widest: ruRU, koKR, and zhCN / zhTW all spend 2 to 3 UTF-8 bytes per character, which makes them the binding constraint long before German's longer word count does. The `MESSAGE_*` templates and `DEFAULT_GOOD_NEWS` are the ones that carry a live spell or item link (itself a translated spell name), so keep translated bodies short enough to leave the link room.

## Common Pitfalls

- **A `|4` plural escape in a sent message.** WoW's own duration strings (`D_MINUTES` is `"%d |4minute:minutes;"`) carry an escape the UI expands only at render time. It looks correct in a print, but `SendChatMessage` rejects any message still holding one ("Invalid escape code in chat message") and silently drops the *whole line*. `ResolvePlurals` in `Features/Announcements.lua` expands it to plain text before the whisper is queued.
- **`string.format` on a user-editable template.** The Good News body is whatever the player typed, so a stray `%` in it makes `format` raise mid-whisper. `ns:BuildGoodNewsMessage` substitutes `%a` with `gsub` and a replacement function, which also stops a `%` inside a spell link from being read as a capture reference.
- **Whispering a pet name.** A whisper addressed to a pet bounces ("No player named 'X' is currently playing"). Every whisper path is guarded by `ns.IsPlayerGUID`, and pet sources are traded for their owner via `ResolveSource`, which returns nil rather than falling back to the pet.
- **Assuming your own casts come from `player`.** Roar of Sacrifice and Battle Squawk are cast by your pet. `OnUnitSpellcastSent` accepts `player` and `pet`, and a bare `unit == "player"` test silently switches Good News off for every pet-cast entry in the data.
- **Cross-realm source names.** A combat-log name is `Name-Realm` and never matches a name lookup or resolves as an emote target. Classify group membership by affiliation flags, and strip the realm with `Ambiguate(name, "short")` before passing a name to `DoEmote`.
- **`DoEmote(cmd, nil)` is not undirected.** It falls back to your *current target*, thanking a bystander. TFTB never emotes undirected either: `ns:DoRandomEmote` and `ns:DoEmoteToken` return early on a nil target, because the undirected flavor ("You thank everyone around you.") fires precisely when the buffer could not be resolved, which is itself the evidence they are gone.
- **A unit token is not proof of presence.** A party member who zoned into a dungeon is still `party2`. `CanWitnessEmote` gates on `UnitIsVisible` plus `UnitInRange`, reading `UnitInRange`'s second return so a non-group unit falls through to the visibility verdict instead of a bogus false.
- **Resolving an emote target before a delay.** `ResolveEmoteTarget` hands back a live unit token, and `target` / `focus` / `mouseover` name whoever you are pointing at *in that instant*. Resolve it when the buff lands and a delayed emote thanks whoever you moved on to. `DeliverPraise` resolves inside the timer for exactly this reason; every other gate is settled before the timer arms.
- **Iterating a saved emote table instead of `Data.EMOTES`.** Saved settings outlive the list, so a retired key sits in every existing profile and a random pick that lands on it is a silent no-op. `ns:DoRandomEmote` walks `Data.EMOTES` and reads the saved table by key.
- **Opening the options panel by title.** `Settings.GetCategory(<title>)`, or passing the add-on title to `Settings.OpenToCategory`, returns nil on clients that carry the Settings API. Execution falls through to `AceConfigDialog:Open` and the panel opens as a floating window instead of docking into Blizzard's settings. It still works on Classic Era, so one-flavor testing misses it. `ns:OpenOptionsPanel` captures both return values of `AddToBlizOptions` and routes by the captured id, resolving no names anywhere.
- **Reading a buff's duration too early.** For Good News, the aura lands a tick *after* the cast succeeds, so reading it inline reports "no duration" for every buff. Wait `AURA_SETTLE`, then read it off the recipient after re-confirming their GUID.
- **A live buff reporting 0 duration.** `ns.GetBuffDuration` returns 0 for a timerless buff and nil for absent, so callers must nil-check and never test the number for truthiness.
- **A successful cast is not a successful resurrect.** Goblin jumper cables emit `SPELL_CAST_SUCCESS` for every jolt, revived or not. Only `SPELL_RESURRECT` proves it took, which is what the `RESURRECT` detect mode exists for.
- **Native `GetSpellLink` in chat.** On Classic it omits the trailing `:0` field, which `SendChatMessage`'s validator strips on send, so whispers arrive with the link gone. `ns.GetSpellLink` builds `|Hspell:<id>:0|h` by hand to pass the validator.
- **Reusing a spell id across flavors.** `DoesSpellExist` cannot tell Ice Block (Era) from Cold Snap (TBC); they share id `11958`. Use the `"-"` flavor column, one row per identity.
- **Leaving a caption on a label-beside-control row.** AceConfig renders a widget's own `name` above it, so a `select` that keeps its caption stacks the label over the control and breaks the row. Every dropdown here (`ns.DefineSecondsSelect`, `ns.DefinePraiseDelaySelect`, the Good News scope) carries `name = ""` and pairs with an `ns.OptionsRowLabel` cell that makes up the rest of `ns.OPTIONS_ROW_WIDTH`.
- **Editing a vendored library.** `Includes/Libraries/` is refreshed from upstream by the packager on every release (`externals` in `.pkgmeta`), so a local fix is discarded at build time. Work around it in `Features/`, or fix it upstream.

## Contributing

- **Issues.** <https://github.com/Gogo1951/Thanks-for-the-Buff/issues>.
- **Bug reports.** Include game version and locale, class and level, repro steps, and the relevant chat output. The Diagnostic Tools panel (enable it, then run the Context, API, and Event checks) produces a ready-to-paste report.
- **Discord.** <https://discord.gg/eh8hKq992Q>.
- **PRs.** Keep changes scoped. Run StyLua with its default config over every touched Lua file, and keep `luacheck .` clean. Preserve migration discipline: never rename a saved-variable key without shipping a bridge for one release. Check any sent-message change against the **255-byte** chat limit in the widest-encoding locale (Style Guide, MESSAGES, Message Length, is canonical for both output ceilings; the macro one is measured in bytes with `#body`, though TFTB's macro bodies are fixed command literals). Update this document if the architecture or file map changes.
- **Commit and PR descriptions require a User Story.** Frame the change by who it helps and why, not just what changed.

   **Format:** *As a [role], I [needed / wanted] [behavior] so that [outcome]. This change [does X].*

   **Example:** *As a raider who gets buffed constantly, I wanted teammate buffs to use the same soft sound as stranger buffs so that a busy pull stops sounding like an alarm. This change collapses the two sound helpers into `ns.PlayBuffSound` and drops `Combat-Buff.ogg`.*
