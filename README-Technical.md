# Thanks for the Buff // Technical Reference

This document combines architecture notes and contribution guidance for developers working on Thanks for the Buff. For end-user documentation, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md).

## File Map

The repo root *is* the add-on folder; the packager renames it to `TFTB` on release (`package-as` in `.pkgmeta`), which is why the installed path is `Interface/AddOns/TFTB/`.

```
Thanks-for-the-Buff/
├── .github/
│   └── workflows/
│       ├── ci.yml                              Calls Common-Core: Lua 5.1 syntax, luacheck and StyLua on every PR and push to main
│       └── package.yml                         Calls Common-Core: release packaging on a pushed tag
├── .gitattributes                              Shared from Common-Core
├── .gitignore                                  Shared from Common-Core
├── .luacheckrc                                 Lint config
├── .pkgmeta                                    Packager manifest: package-as, externals, ignore list
├── TFTB_Vanilla.toc                            Classic Era, Season of Discovery included
├── TFTB_TBC.toc                                TBC Anniversary
├── TFTB_Camelot.toc                            WoW Forever; leaves out Peer Pressure
├── Data/
│   ├── Flavor.lua                              Flavor identity and the loaded data folder (canonical copy)
│   ├── Data.lua                                Locale init, palette, registry names, constants, Thank You buttons, emote list
│   ├── {Game}/                                 One folder per flavor: Vanilla, Discovery, TBC, Camelot, Wrath, Mists, Mainline
│   │   ├── Tracked-Abilities-{Game}.lua        What other players spend on you (ns.TRACKED_ABILITIES)
│   │   ├── Peer-Pressure-Abilities-{Game}.lua  Same-class cooldowns (ns.PEER_PRESSURE_ABILITIES)
│   │   └── Game-IDs-{Game}.lua                 The options panels' sample spells (ns.GAME_IDS)
│   └── Default-Settings.lua                    AceDB defaults (ns.DATABASE_DEFAULTS), one shared profile
├── Diagnostics/                                Diagnostic Tools, copied from Magic Eraser; TFTB's own surface is Manifests.lua
├── Features/
│   ├── Core.lua                                Version, AceDB lifecycle, event dispatcher, login order
│   ├── Utilities.lua                           Colors, emote catalog, secret-value checks, spell links, GUID and sound helpers
│   ├── Announcements.lua                       Prints, sent messages, emotes, durations, Good News whisper queue
│   ├── Tracked-Lookups.lua                     Tracked lookups, watched-list seeding, options display groups
│   ├── Praise.lua                              Cooldowns, emote targets, reactions to a classified buff
│   ├── Buff-Tracking.lua                       The reaction engine's event side: detect and classify
│   ├── Good-News.lua                           Your own casts: recipient capture, release, dedup
│   ├── Peer-Pressure.lua                       Same-class cooldown alert, tapped from the combat log
│   └── Thank-You-Button.lua                    The Thank You buttons: macros and command bodies
├── Includes/
│   ├── Images/                                 Thanks-for-the-Buff.tga, the TOC IconTexture
│   ├── Libraries/                              Vendored LibStub and Ace3; never hand-edited
│   └── Sounds/                                 Buff.ogg (any buff on you), Thunder.ogg (Peer Pressure)
├── Locales/                                    AceLocale-3.0 strings
├── Options/
│   ├── Options-Utilities.lua                   Shared helpers, feature switches, buff-panel control factories
│   ├── Options-General.lua                     Root panel: pitch, welcome toggle, feature switches, /commands, links
│   ├── Options-Stranger-Buffs.lua
│   ├── Options-Teammate-Buffs.lua
│   ├── Options-Send-Good-News.lua
│   ├── Options-Service-Alerts.lua
│   ├── Options-Peer-Pressure.lua
│   ├── Options-Thank-You-Button.lua
│   ├── Options-Profiles.lua                    Stock AceDBOptions-3.0 table, returned as-is
│   └── Options.lua                             Registration order, panel routing, slash commands
├── LICENSE                                     MIT
├── README.md                                   End-user documentation
├── README-Notes.md                             The maintainer's settled exceptions and decisions
├── README-Technical.md                         This document
└── README-Testing.md                           Manual test plan, walked before tagging a release
```

`.pkgmeta`'s ignore list keeps the `.github/` files, the dotfiles, and `LICENSE` out of the player zip, along with `Data/Wrath/`, `Data/Mists/`, and `Data/Mainline/`, which no TOC lists yet. Those three are forward-prep, kept complete so a flavor's data exists before its TOC does.

`Includes/Libraries/` is committed *and* declared as packager `externals`, so every tagged release re-pulls each library from upstream and commits the result back to `main`. A hand-edit to a vendored file is discarded on the next build. Fix the upstream library, or work around it in `Features/`.

No deprecated or dead files remain in the tree. The single `Data/Tracked-Abilities.lua` and `Data/Peer-Pressure-Abilities.lua`, the unsuffixed `TFTB.toc`, and the old `Features/Diagnostics.lua` / `Options/Options-Diagnostics.lua` pair are gone, replaced by the flavor folders, the three flavor TOCs, and `Diagnostics/`. Don't reintroduce any of them.

## Architecture

### Event Loop

`Features/Core.lua` owns one frame and one dispatcher; feature files never register their own frames. The complete event list is exported as `ns.EVENT_NAMES`, so the registered set, the diagnostics event-log tap, and the event-registration probe can never drift from one another:

```
PLAYER_LOGIN · PLAYER_ENTERING_WORLD · UNIT_SPELLCAST_SENT
UNIT_SPELLCAST_SUCCEEDED · LOADING_SCREEN_DISABLED
+ COMBAT_LOG_EVENT_UNFILTERED  (Vanilla, TBC)
+ UNIT_AURA                    (Camelot, in its place)
```

Forever has no combat log, and registering `COMBAT_LOG_EVENT_UNFILTERED` there errors, so when `ns.FLAVOR == "Camelot"` (from `Data/Flavor.lua`) Core appends `UNIT_AURA` instead. Peer Pressure has no other source than the combat log, so the Camelot TOC leaves out `Features/Peer-Pressure.lua` and `Options/Options-Peer-Pressure.lua` together; everything that reaches into it (`ns.SetupPeerPressure`, `ns.CheckPeerPressure`, `ns.BuildPeerPressureOptions`, the General panel's switch through its `loaded` check) tests that it loaded. `Data/Camelot/` has no Jumper Cables row (only `SPELL_RESURRECT` proves a revive), and marks Rebirth, Lay on Hands and Divine Grace `receivable = false`: their landing on you is invisible there, so they get no Teammate Buffs toggle, but your own casts of them still reach Good News through `UNIT_SPELLCAST_SUCCEEDED`. That is why Good News renders its own `ns.GoodNewsCategories` rather than reusing the teammate list.

Forever also hands out *secret values*. `ns.IsPlain` guards every event argument and API return that is compared, concatenated, sent, or used as a table key. Unit identity and aura data go secret in combat there, so `ns.IsUnitIdentitySecret(unit)` and `ns.AreAurasSecret()` (thin wrappers over `C_Secrets`, always false on other flavors) are asked before Good News resolves a recipient or reads a duration, before a group service credits its caster, and before the Thank You command checks or whispers its target. A secret read skips that output rather than working around it.

`UNIT_AURA` (player) and `UNIT_SPELLCAST_SENT` (player and pet) register through `RegisterUnitEvent` from `ns.EVENT_UNITS`, so the client never wakes the dispatcher for other units. Feature modules attach handlers by name with `ns.SetEventHandler(event, handler)`. Attaching the same event twice replaces the earlier handler, so there is exactly one owner per event. Every event first passes through `ns:LogEvent` when diagnostics logging is active, then to its handler.

`PLAYER_LOGIN` runs the whole setup sequence in order, and the order is load-bearing: `AceDB:New` first (nothing may read a setting before it exists), then `ns.RegisterOptionsPanels` (the Profiles panel binds to `ns.db`; panels that render display groups register as builders and draw them on open), then `ns.SetupBuffTracking` and `ns.SetupPeerPressure` (which need the spell and item APIs live), then `ns:CreateAutoMacro`. The welcome message rides `PLAYER_ENTERING_WORLD` behind a once-per-session flag, since that event refires on every loading screen.

A safety timer (`Data.SAFETY_PAUSE`, 3s) suppresses buff reactions and Good News until the world settles after login or a loading screen (`LOADING_SCREEN_DISABLED`). A monotonic token invalidates earlier timers, so back-to-back loading screens cannot let a stale callback flip `isReady` back on mid-pause.

### Combat Lockdown

Four things answer to combat, in four different ways.

**The options panel refuses outright.** `InCombatLockdown()` is the first thing `ns:OpenOptionsPanel` does, one gate in front of the whole routing chain, ahead of the Settings and AceConfigDialog branches, so `/tftb` behaves identically on every flavor. It prints `CHAT_OPTIONS_IN_COMBAT` and returns. It never queues the panel to open when combat ends and never registers `PLAYER_REGEN_ENABLED` to finish the job later: Blizzard's Settings panel is protected in combat, and a silent refusal reads as a broken command.

**Macros are skipped, not queued.** `ns.ReconcileMacros` and `ns:DeleteAutoMacro` return early in combat, because the macro API is unavailable there. A Create Macro toggle flipped mid-fight simply leaves the macro alone; the next login or profile change reconciles it. There is no dirty flag and no replay.

**Emotes are suppressed, not queued.** The reaction paths themselves run in combat: self-only prints, sounds, and outgoing whispers all fire on qualifying buffs whether or not you are fighting, because they touch no protected functions. Emotes are visible and social, so `HandleTracked` and `HandleStrangersBuff` allow them only when `not InCombatLockdown()`. An emote skipped during combat is simply not performed for that buff, and because a praise cooldown is spent only when praise actually goes out, the next qualifying buff after combat reacts immediately. Combat is tested twice: once when the reaction is decided, and again inside `DeliverPraise` when the emote fires, so entering combat during a Praise Delay still suppresses it.

**On Forever, buffs on you are not read at all in combat.** `OnUnitAura` returns while `InCombatLockdown()` or `ns.AreAurasSecret()` is true, so a buff that lands mid-fight is never seen there, and is not queued for later.

### Praise vs Notifications

The reactions split into two kinds, which is also how the Stranger Buffs, Teammate Buffs, and Service Alerts panels are laid out:

- **Praise** is the thank-you whisper and the emote. Both go outward to the player who buffed you, so both answer to the cooldowns and to the Praise Delay, and both are delivered by `DeliverPraise` in `Features/Praise.lua`.
- **Notifications** are the chat print and the sound. Self-only, never throttled or delayed, fired inline the moment the buff qualifies.

`DeliverPraise` receives decisions, not permissions to re-derive: every gate (the toggles, both cooldowns, the whisper throttle, the combat check) is settled before the timer is armed, so a burst of buffs landing inside the delay window cannot slip past a cooldown. `praiseDelayEnabled` off, or a missing `praiseDelay`, means a delay of 0 and inline delivery. The emote *target* is the deliberate exception, resolved inside the timer rather than before it: `ResolveEmoteTarget` returns a live unit token, and `target` / `focus` / `mouseover` all name whoever you are pointing at in that instant, so resolving early makes a delayed emote thank whoever you moved on to.

### Detect, Classify, Announce

The reaction pipeline runs across `Features/Buff-Tracking.lua` (detect and classify, against the lookups in `Features/Tracked-Lookups.lua`), `Features/Praise.lua` (react), `Features/Good-News.lua` (your own casts) and `Features/Announcements.lua` (output):

1. **Detect.** `OnCombatLogEventUnfiltered` taps `SPELL_AURA_APPLIED` and `SPELL_AURA_REFRESH` (buffs landing on you; a rebuff earns the same thanks), `SPELL_CAST_SUCCESS`, and `SPELL_RESURRECT`. On Forever, `OnUnitAura` stands in for the aura half. `OnUnitSpellcastSucceeded` taps group services and hands your own casts to Good News (`ns.ClaimPendingGiven`); `OnUnitSpellcastSent` in `Features/Good-News.lua` captures the recipient of your own casts. The three lookups (`auraLookup`, `castLookup`, `givenLookup`) are each keyed by the id the relevant event actually carries.
2. **Classify.** `MatchTracked` requires the subevent to match the entry's own `detect` mode rather than merely finding the id in a lookup, which is what keeps a `RESURRECT` entry from firing on the `SPELL_CAST_SUCCESS` it shares a lookup with. `ResolveSource` trades a pet or guardian GUID for its owner and returns nil (drop the event) when no owner unit resolves. Cross-realm sources arrive as `Name-Realm` and never match a name lookup, so group membership is decided by the combat-log affiliation flags (`MINE`, `PARTY`, `RAID`), and a friendly outsider is recognized by `AFFILIATION_OUTSIDER`. Service entries surfacing in the combat log are dropped here, since they announce from `UNIT_SPELLCAST_SUCCEEDED` instead.
3. **Announce.** `HandleTracked` and `HandleStrangersBuff` route to the announcement helpers. Sent messages go through `SignOff` in `Features/Announcements.lua`, which adds the target marker (`{rt1}` Star, left off on Forever, which blocks raid-marker tokens in chat), trims the body's closing punctuation (whole UTF-8 marks, including full-width and Spanish opening marks), and appends ` // TFTB` (`L["ADDON_SHORT"]`). Sent messages carry a spell or item link; `SendChatMessage` rejects anything over **255 bytes** (`ns.CHAT_MESSAGE_MAX_LENGTH`).

Each feature carries a master switch (`strangers.enabled`, `teammates.enabled`, `services.enabled`, `peerPressure.enabled`, and Good News's own `whisperEnabled`), declared once in `ns.FEATURE_SWITCHES` and built by `ns.OptionsFeatureToggle`. Each is placed twice, at the top of its panel and, two to a line, in the General panel's Features section; flipping either repaints every panel. The switch is a real gate in the engine, not only a way to hide controls: `HandleTracked`, `HandleStrangersBuff`, `ns.CheckPeerPressure`, and `OnUnitSpellcastSent` each return early when their feature is off.

### Item Data Caching

Item names and links come from `C_Item.GetItemInfo`, which returns nil on a cold cache and fills asynchronously. `WarmItemCache` runs at login (from `ns.BuildTrackedData`) and touches every tracked item so its name and link are warm by the time an options panel or a "used their X on you" message needs it. Nothing is stored by the add-on; the client's cache is the cache. Where a name still is not ready, the options toggle shows the `TRACKED_ITEM_PENDING` placeholder (`Item #%d`) and resolves on the next panel open, which is why the Teammate Buffs, Send Good News, Service Alerts, and Peer Pressure panels register as functions (rebuilt on open) rather than as prebuilt tables, and why `ns.SortedEntries` sorts at build time.

Spell *descriptions* have the same shape of problem for a different reason: Classic keeps tooltip data only for spells the character has actually known, and these panels list every class. `ns.DefineEntryToggle` calls `C_Spell.RequestLoadSpellData` for every id in the entry when the panel is built, and every toggle's `desc` is a function rather than a baked string, so the real text appears once it lands. It quotes the highest live id, so a rank group describes the rank you actually cast.

Item and spell access calls `C_Item` and `C_Spell` directly, with no legacy fallback: every client TFTB targets ships them, and the Retail engine behind WoW Forever has dropped the legacy globals. Chat and emotes go through `C_ChatInfo.SendChatMessage` and `C_ChatInfo.PerformEmote` for the same reason.

### Options Panels

AceConfig panels register in `Options/Options.lua`, one per key in `ns.OPTIONS_REGISTRY`, in the order they appear in Blizzard's settings tree: General (root), then Stranger Buffs, Teammate Buffs, Send Good News, Service Alerts, Peer Pressure, and Thank You Button, then Profiles second-to-last and Diagnostic Tools last. That is nine panels, or eight on Forever, where Peer Pressure's builder never loads. The tree order *is* the order of the `AddToBlizOptions` calls.

Each panel file owns its own layout and order numbers; the controls themselves come from factories in `Options/Options-Utilities.lua` (`ns.DefinePrintToggle`, `ns.DefineWhisperToggle`, `ns.DefineEmotesToggle`, `ns.DefineEmoteGroup`, `ns.DefineSoundToggle`, `ns.DefineSoundPreview`, `ns.DefinePraiseDelayToggle`, `ns.DefinePraiseDelaySelect`, `ns.DefineSecondsSelect`, `ns.DefineEntryToggle`). Every factory takes a `settings` accessor returning the profile subtable it binds to, so one definition serves Stranger Buffs, Teammate Buffs, and Service Alerts without those three having to share a layout, which they don't.

Two registration shapes coexist deliberately. Panels whose contents are fixed at login register a **prebuilt table** (General, Stranger Buffs, Thank You Button, Profiles). Panels that render tracked abilities register the **builder function itself** (Teammate Buffs, Send Good News, Service Alerts, Peer Pressure), so the table is rebuilt on open once lazily-loaded item names have resolved. Diagnostic Tools also registers its builder, so the enable gate can leave the tabs out of the table while it is off.

Stranger Buffs, Teammate Buffs, and Service Alerts hide everything behind their master switch with `ns.HideAllExcept(args, isHidden, keep)`, applied to the finished args table rather than threaded through every shared factory. The rule is positional (everything except the intro text and the switch itself), so a control added later is covered automatically, and existing `hidden` values are composed rather than replaced, which is what keeps the emote grid following its own toggle inside a panel that is switched on. Send Good News and Peer Pressure pass their own hidden predicate to each control instead.

Section headers are real AceConfig `header` widgets throughout, built by `ns.OptionsHeader`, whose optional third `hidden` argument collapses a gated section. A control explains itself once, in its `desc` tooltip; no panel puts helper text under a control.

`ns:OpenOptionsPanel` backs the `/tftb` command. It routes by the **category ID captured from `AddToBlizOptions`**, never by panel title. See Common Pitfalls for why a title lookup is the standing trap here.

Two panels render a **sample message through the real pipeline** rather than a hand-written mock: Good News calls `ns:BuildGoodNewsMessage` with a live link to `ns.GAME_IDS.SAMPLE_GOOD_NEWS_SPELL_ID`, and Peer Pressure calls `ns.GetPrintPrefix` plus `ns:BuildPeerPressureMessage` with `SAMPLE_PEER_PRESSURE_SPELL_ID`. A sample built any other way drifts from what players actually receive the first time the format changes.

### Cooldown Namespaces

A single `sessionCooldowns` table (key to expiry) in `Features/Praise.lua` backs every throttle, with disjoint string namespaces so keys on the same GUID never collide:

| Key | Window | Purpose |
| --- | --- | --- |
| `praise:all` | `strangers.praiseCooldown` (default 0, off) | Overall stranger praise limit |
| `praise:<guid>` | `strangers.cooldown` (default 3s) | Per-source stranger praise |
| `whisper:<guid>` | 45s | Per-recipient outgoing whisper throttle |
| `service:<guid>` | 10s | Group-service rate limit *and* multi-token dedup |
| `goodnews:<guid>:<spellID>` | 10s | Good News per-recipient-per-spell dedup |

Both `praise:` keys gate the whisper and the emote alike, and neither is stamped unless praise actually goes out. `whisper:<guid>` is a floor underneath them that no setting can lower: a 1-second praise cooldown still cannot whisper the same player more than once every 45 seconds, which is what keeps a generous setting clear of the server's chat squelch. `ns.GetPraiseCooldownState` reads all three for diagnostics without stamping.

`SetCooldown` sweeps lapsed entries on each write, so the table cannot grow unbounded across a long session.

## Reaction Sources: Combat Log vs Cast Events

Why the same feature set reads three different event streams:

- **Buffs on you (Stranger Buffs, Teammate Buffs)** ride the combat log. `SPELL_AURA_APPLIED` and `SPELL_AURA_REFRESH` tell you a buff landed and on whom.
- **Group services (feasts, soulwells, portals, repair bots)** ride `UNIT_SPELLCAST_SUCCEEDED`, *not* the combat log. These utility casts do not reliably emit `SPELL_CAST_SUCCESS` in `COMBAT_LOG_EVENT_UNFILTERED`, but they do fire the unit event for any unit the client tracks. A service has no per-you destination, so crediting the casting unit is all that is needed. Because the event's reach (target, focus, nameplates) is far wider than the feature's, the caster is filtered to `UnitInParty` / `UnitInRaid`, and `UnitIsPlayer` drops group pets; otherwise a stranger opening a portal across a capital city announces as a service.
- **Good News (buffs you cast on others)** rides `UNIT_SPELLCAST_SENT` plus `UNIT_SPELLCAST_SUCCEEDED`. The combat log is scoped to you, your group, and units in combat, so buffing a player *outside* your group produces no `SPELL_AURA_APPLIED` at all, and that is the most common case for this feature. `SENT` is also the only event that names the recipient; `SUCCEEDED` confirms the cast went off, so an interrupted cast stays silent.

On Forever, **buffs on you** ride `UNIT_AURA` instead (`OnUnitAura`). Only newly added helpful auras count, a full update is ignored, and nothing is read in combat, so a buff that lands mid-fight, or a recast of one you already hold, is not seen. `ResolveAuraCaster` credits the aura's `sourceUnit` when it carries one; when it doesn't (a stranger out of nameplate range), it reads the caster with `C_UnitAuras.GetAuraCasterGUID` and names them with `UnitNameFromGUID`, appending the realm for a cross-realm whisper. A caster in your party or raid goes to `HandleTracked`; any other player goes to `HandleStrangersBuff`. A stranger known only by GUID can't be asked whether they're friendly, and doesn't need to be: the other faction can't put a helpful buff on you.

The one deliberate crossover is the `RESURRECT` detect mode. Goblin jumper cables and Defibrillate report `SPELL_CAST_SUCCESS` on every jolt, revived or not, so a Good News record for one of those casts is *parked* at `SUCCEEDED` instead of announced, and only the `SPELL_RESURRECT` a working jolt produces releases it (`ns.ClaimPendingResurrect`, matched on recipient and spell, since the combat log carries no cast GUID). A jolt that never revives anyone is swept by `PENDING_TTL` and stays silent. Forever has no `SPELL_RESURRECT`, so no `RESURRECT` row exists in `Data/Camelot/`.

## Good News

Good News whispers the player *you* just buffed to tell them what they got and, when the number is short enough to act on, how long it lasts. It is the only feature driven by your own casts, and the only one that can send several whispers from one cast.

The whisper is assembled from a player-editable template holding one token:

```
Template   You have %a
Sent       {rt1} You have [Power Infusion] for 15 Seconds // TFTB
```

`%a` carries the whole ability phrase, link plus optional duration clause (`GOOD_NEWS_DURATION_CLAUSE`). Folding the duration into the token instead of exposing it as a second placeholder is what lets one template cover both cases: a one-shot cast with nothing to report leaves no dangling clause, so the template needs no conditional and the player needs no second variable. Substitution is `gsub` with a replacement **function**, never `string.format`: the template is user-editable, so a stray `%` would otherwise raise an error mid-whisper, and a `%` inside a spell link would be read back as a capture reference. The marker, the closing-punctuation trim, and the ` // TFTB` sign-off are added by `ns:BuildGoodNewsMessage` and are deliberately out of reach, because they are how a recipient recognizes where the whisper came from.

The edit box caps at 120 bytes through `ns.TrimToBytes`, and emptying it restores `DEFAULT_GOOD_NEWS` rather than sending a brand with nothing after it. Because `%a` may appear more than once, the finished line can still pass 255 bytes, so `ns:BuildGoodNewsMessage` falls back in two steps: first to the default template, then to the default without the duration. It never truncates, because a cut can land inside a link.

Because `SENT` and `SUCCEEDED` carry the **cast** id, `givenLookup` is keyed by cast id, and each record carries `watchedId` (the id the panel toggle and the settings list use) and `auraId` (the id to read the recipient's remaining duration with). `auraId` is deliberately absent for no-aura casts like Rebirth and for `noDuration` entries like Fear Ward and Misdirection: nothing to read is what drops the duration clause from their message.

A message ends up without a duration clause in exactly three ways, and it is worth keeping them straight because only the last one looks at a real timer:

1. **No aura to read.** A cast that leaves none (Rebirth, Lay on Hands, jumper cables). Settled at login, in `BuildLookups`.
2. **`noDuration`.** An aura spent by an event rather than by time (Fear Ward, Misdirection, Tricks of the Trade, Intervene). Also settled at login.
3. **A minute or longer.** `GOOD_NEWS_MAX_SECONDS` (60) in `Features/Announcements.lua`. "for 15 Seconds" is a cue to use it now; "for 10 Minutes" is a number nobody paces themselves off, and it pushes the ability name further from the front of a one-job whisper. Checked per cast, on the value actually read off the recipient.

A secret aura or recipient on Forever also yields no clause, since the duration is never read. The cap is compared against the duration **pre-rounded** the way `FormatDuration` would round it, so a 59.7s aura is tested as the "60 Seconds" it would print as rather than slipping under and printing a full minute in seconds. Good News has no *lower* bound: a 6-second buff whispers "for 6 Seconds". The `minBuffDuration` floor (default 21s) belongs to Stranger Buffs alone.

"Your own cast" includes your **pet's**. Roar of Sacrifice and Battle Squawk are cast by the pet and never by the player, so `UNIT_SPELLCAST_SENT` registers for `player` and `pet`; a bare `unit == "player"` test silently switches Good News off for every pet-cast entry in the data. Recipients are resolved by name back to a unit token (target, mouseover, focus, then group members), which is what proves the recipient is a player rather than a pet and gives something to read the duration off later. `scope` decides who qualifies: `ALWAYS` whispers anyone you buff, and anything else means group members only, with unrecognized values failing closed into the group check.

Four timing constants shape the flow:

- `AURA_SETTLE` (0.1s, `Features/Good-News.lua`). The aura lands a beat *after* the cast succeeds, so `AnnounceGivenCast` waits before reading the duration, re-checking that the unit still holds the recipient's GUID.
- `PENDING_TTL` (15s). A `SENT` whose `SUCCEEDED` never arrives, or a parked resurrect that never took, is swept from `pendingGiven`.
- `GOODNEWS_DEDUP` (10s). A quick recast on the same person does not whisper twice.
- `WHISPER_GAP` (0.35s, `Features/Announcements.lua`). The whispers themselves are **queued, not sent inline** (`QueueWhisper`). A raid-wide buff like Prayer of Fortitude lands on every recipient in the same instant, and a burst of same-frame whispers risks the server-side chat squelch, which would drop them all silently. An empty queue still sends immediately, so the common one-recipient case feels instant.

Durations render through the client's own localized `D_HOURS`, `D_MINUTES`, and `D_SECONDS` templates, so the units are correct in every language without TFTB shipping its own copies. That comes with a trap severe enough to have its own entry in Common Pitfalls: those templates carry a `|4singular:plural;` escape that `SendChatMessage` rejects outright, so `ResolvePlurals` expands it to plain text first, with a three-form rule for Slavic locales. With the cap in place no caller reaches `FormatDuration`'s minute or hour rung (Good News stops below a minute, and both dropdowns pass `forceSeconds` or list seconds only), but the ladder stays, because the helper formats whatever it is handed and a later caller re-deriving it would walk straight back into that escape.

## Per-Flavor Tracking Data

Each flavor TOC names its flavor in `## X-Flavor`, and `Data/Flavor.lua` turns that into `ns.FLAVOR`, `ns.EXPANSION`, `ns.IS_DISCOVERY`, and `ns.DATA_FOLDER`; code never works the client out for itself. Every flavor has its own complete copy of the tracked data in `Data/{Game}/`, and each TOC lists only its own folder. The Vanilla TOC lists `Data/Vanilla/` then `Data/Discovery/`, and each file in that pair opens with a Season of Discovery guard so exactly one set of tables is built.

Rows carry no flavor columns: a row's folder says where it is true. `ns.TRACKED_ABILITIES` rows carry scalar `received` and `given` defaults, and `ns.PEER_PRESSURE_ABILITIES` rows are positional, `{ "CLASS", { spell ids }, default }`. A default seeds the checkbox (`0` is off, anything else on). Blizzard reuses spell ids across flavors for entirely different abilities (id `11958` is **Ice Block** on Era but **Cold Snap** in TBC and Wrath, and `12472` is **Cold Snap** on Era but **Icy Veins** in TBC and Wrath), which `C_Spell.DoesSpellExist` cannot detect, so each folder carries only the rows whose ids mean that ability on its client. At login, triggers that don't exist on the running client are dropped and an entry with none left is skipped, so a row the client lacks costs nothing.

## Peer Pressure

Peer Pressure alerts you when another player of your class pops a tracked cooldown so you can join in. `Features/Peer-Pressure.lua` builds a spell-keyed lookup from `ns.PEER_PRESSURE_ABILITIES`, and `ns.CheckPeerPressure` is called from the combat-log tap for every `SPELL_CAST_SUCCESS`. Spells are class-locked, so "the caster is your class" needs no GUID inspection: the entry's class tag against your own is the whole test. It does not exist on Forever (see Event Loop).

Two filters matter. `IsGroupAffiliated` drops passers-by, because Era's combat log is proximity-scoped rather than group-scoped, so a paladin popping Lay on Hands across a capital city arrives exactly like a raid member's cast. And the `MINE` flag deliberately lets your own casts through to the "Trigger on Own Casts" check (`triggerOnOwnCasts`, default off), which is the setting that actually owns that decision; this is also why the Peer Pressure tap sits *above* the own-source drop in `OnCombatLogEventUnfiltered`.

When the cast had a real player target other than the caster, the message names them ("Expektor used [Blade Flurry] on Sally!"); self-buffs and pet targets read as plain. The body renders in the caster's class color (always your own class), the spell link keeps the standard link blue, and the target's name wears the target's class color. A closing `|r` resets the fontstring to white, so `ns:BuildPeerPressureMessage` re-opens the body color right after the link and after the target's name. Print and sound are independent toggles, and with both off nothing fires.

When an id appears in two rows, the lookup credits it to the last one, and `BuildCategories` renders it under that row only, so one id never draws two checkboxes.

## Thank You Buttons

`Data.THANK_YOU_BUTTONS` in `Data/Data.lua` is the whole feature. One row per button, holding the profile key it stores under, the macro it offers to create, the slash command that macro runs, and whether it picks one chosen emote or randomizes over a checklist:

```lua
{ profileKey = "slash",  macroName = "- Thank",  command = "/thankyou" },
{ profileKey = "slash2", macroName = "- TFTB 2", command = "/thankyou2", singleEmote = true },
```

Everything else is generated from that list: the defaults in `Data/Default-Settings.lua`, the options sections in `Options/Options-Thank-You-Button.lua` (order numbers spaced a hundred apart per button), the slash registrations in `Options/Options.lua` (`SlashCmdList` keys `TFTB_THANKYOU<n>`), and the macros in `Features/Thank-You-Button.lua`. Nothing counts the buttons.

Button 1 is the original and keeps its on-by-default settings and its friendly default whisper. Buttons 2 through 5 ship fully switched off (no macro, no whisper text, no emote), so a fresh install behaves exactly as it did before they existed. An empty message sends no whisper and an empty emote token performs no emote, both by existing logic, so "off" needs no extra guard. All five macro names lead with a dash so the family sorts together at the top of the macro list. Unticking a button's Create Macro toggle collapses its whisper and emote rows, but the typed command keeps working with the stored settings.

`singleEmote` changes the stored shape as well as the control: `emote` (one token, `""` meaning none) rather than `emotes` (a set). The single-emote dropdown is built from the **client's** emote catalog (`ns.GetEmoteCatalog`, read from the client's own `EMOTE<n>_TOKEN` globals, which are sparse and contain duplicates, so the scan neither stops at a gap nor keeps a repeat), not from the curated twelve in `Data.EMOTES`, so it offers precisely what this build can perform. `ns:DoEmoteToken` validates against that catalog before calling `C_ChatInfo.PerformEmote`, because a bad token is a silent no-op, which is indistinguishable from a broken button. A stored token this client lacks displays as "none" rather than blank.

`ns.ReconcileMacros` is the only macro path, and it runs in both directions: create the enabled macros that are missing, delete the disabled ones that are still there. It runs at login, on every profile change, and from the Create Macro toggle itself, so a profile switch moves the macros with it instead of leaving the previous profile's on the bars until a reload. The account cap (`Data.MAX_GLOBAL_MACROS`, 120) is re-read *inside* the loop, because each macro this call creates counts against it. Deletion resolves the index from the button's exact name first, so the existence check and the delete agree on the same macro.

`ns.RunThankYou` requires a player target that is not you, emotes at it, and whispers only when the target shares your faction and the message is non-empty. On Forever a target whose identity is secret still gets the emote (it only needs the `target` token) but no whisper. The whisper body is sent verbatim and is unbranded by design: a human-sounding message, deliberately without the marker or add-on name. Its edit box caps at `ns.CHAT_MESSAGE_MAX_LENGTH` (255 bytes) through `ns.TrimToBytes`, which steps back off a UTF-8 continuation byte so a cut never lands mid-character.

## Diagnostics

`Diagnostics/` is the house Diagnostic Tools framework, copied from Magic Eraser: five tabs (Run Tests, Settings, Code, Data, Localization) under a runtime-only enable gate, a report runner that runs one report at a time a frame apart, and Validate Data, which exports everything the client knows about every spell and item id in this client's data folder as TSV. `ns.diagnostics` is runtime-only and **nothing persists to SavedVariables**. Strings live in `ns.DiagnosticsStrings` as plain English and never go through `Locales/`, because they are developer-facing. The panel registers as its builder, so while the gate is off the tabs are left out of the table, and turning it off stops the event log and clears every report.

TFTB's own surface is `Diagnostics/Manifests.lua`: the API rows, the context probe, Emote Extract, the combat-cast and aura probes, the name lookups, the message builders, and the data-source manifest (`ns.DIAGNOSTIC_DATA_SOURCES`, one row per data file: Tracked-Abilities, Game-IDs, Peer-Pressure-Abilities). The framework's validator gained a `spell` kind for TFTB, since its data is mostly spells. On WoW Forever a secret event argument logs as `<secret>`.

The event log snapshots each argument to a string immediately (never retaining frame or table references), caps arg count and length (`EVENT_LOG_SIZE` 500, `EVENT_LOG_MAX_ARGS` 8, `EVENT_LOG_MAX_ARG_LENGTH` 255), and escapes pipes *after* truncation so a clipped argument cannot eat the next separator.

`ns.DIAGNOSTIC_EVENT_EXCLUDE` holds `COMBAT_LOG_EVENT_UNFILTERED`, since as a firehose it would bury the signal, and Forever's `UNIT_AURA`, whose update table can't be logged as text. The buff engine instead feeds one decoded line per `SPELL_CAST_SUCCESS` and `SPELL_RESURRECT`, and per `SPELL_AURA_APPLIED` or `SPELL_AURA_REFRESH` landing on you (labelled `AURA`), through `ns:LogCombatCast`, recorded *before* any of the engine's own filtering, so a portal, feast or buff that arrives but is dropped is still visible. An aura on you, and a cast or revive TFTB acts on (a tracked entry, a Good News buff, a Peer Pressure cooldown), writes a full line through `ns:LogEventNow`. Every other cast is counted by spell id in the log's summary through `ns:CountUncorrelated`, so a busy raid can't push the signal out of the 500-line buffer, and a portal missing from the data still shows its id and name there. `UNIT_SPELLCAST_SUCCEEDED`, which fires for every unit the client tracks, gets the same treatment through `ns.MESSAGE_ID_FILTERED_EVENTS`: its spell id logs in full when `ns.IsCorrelatedMessage` finds it in the cast or Good News lookups, and is counted otherwise. Counters are kept per event and id, and a secret id on Forever counts as `<secret>`. Each full line carries the spell id and name, the source, the decoded affiliation and reaction flags, and `tracked` / `watched` flags to tell a data problem from a downstream one. Resurrects are labelled `REZ` rather than `CAST` specifically so a failed jolt (a `CAST` with no `REZ` after it) can be told from a working one by eye. On Forever, `OnUnitAura` writes each added helpful aura through `ns:LogAuraUpdate` before its gates run: the spell id and name, the aura's source unit, `tracked` / `watched`, and a verdict naming the first gate that stops it (`not ready`, `no db`, `in combat`, `auras secret`, `full update`) or `read` when it goes on to be classified.

Two Settings reports are TFTB's own. **Add-on Context** reports the player, the active profile, group state, how buffs are detected on this flavor and whether that path is open right now (the post-login pause, combat, WoW Forever's secret auras), every panel's settings and picked emotes, the watched counts for every list, the praise throttles overall and for the current target (read through `ns.GetPraiseCooldownState`, which never stamps), the sound CVars (`Sound_EnableAllSound`, `Sound_MasterVolume`), the live-versus-total tracked coverage (`ns.DIAGNOSTIC_TRACKED`), `IsPlayerSpell` readouts over the tracked spells and the Peer Pressure spells for the player's class (`ns.DIAGNOSTIC_SPELLS`, `ns.PeerPressureCategories`), and, per Thank You button, its Create Macro toggle, whether its macro exists, its whisper length and its emotes, against the account macro count and `Data.MAX_GLOBAL_MACROS`. That is where most "nothing happens when I get buffed" reports resolve. **Emote Extract** dumps every emote the running client can perform as a tab-separated table, so the same build produces the same list on any flavor without a code change. The framework's **Taint Log** buttons are the only state the panel ever writes.

The **Localization** tab holds **Locale Context** (`GetLocale()`, the `textLocale` and `audioLocale` CVars, and how many keys `ns.L` defines), **Game Names** (one row per game record TFTB names by ID, from `ns.DIAGNOSTIC_NAME_LOOKUPS`, each through the exact call the features make, with a `NIL` row where the client returns nothing), and **Message Length**. Message Length builds every whisper and macro TFTB sends or writes from `ns.DIAGNOSTIC_MESSAGES`: the thank-you and Good News whispers through `ns:BuildAnnounceMessage` and `ns:BuildGoodNewsMessage`, carrying the longest `ns.GetBuffLink` this client's data holds (and, for Good News, a 59-second clause, the longest it ever carries), plus each Thank You button's saved whisper and macro body. Each one's byte length is printed against its ceiling (255 for both chat and macros) and flagged `OVER` past it. Nothing is sent and no macro is written; since the ceiling is in bytes, ruRU is the client to run it on. Its builders live in `Diagnostics/Locale-Reports.lua`.

## Saved Variables

One account-wide table, `TFTBDB`, managed by AceDB-3.0, holding every setting the add-on has.

**Thanks for the Buff uses the Simple saved-variables model.** `AceDB:New` is called with `true` as its third argument, so every character on the account lands on the one shared `"Default"` profile and the whole database lives under `profile`. `global` is unused: there is no mini-map button and nothing the add-on stores differs from character to character. **Reset Profile therefore clears everything, back to install defaults.** A new setting belongs in `ns.db.profile`.

The top-level keys, regenerated from `Data/Default-Settings.lua`:

- **`showWelcome`** is the login welcome message.
- **`strangers`**, **`teammates`**, and **`services`** each hold one panel's reactions: its master switch, the print / whisper / emote / sound toggles, the emote checklist, and the Praise Delay pair. `strangers` alone adds `praiseCooldown`, `cooldown`, and `minBuffDuration`; the other two carry no cooldowns, because a teammate's cooldown is worth acknowledging every time it lands. Only `strangers` is switched on by default.
- **`goodNews`** holds `whisperEnabled` (its master switch), `scope`, the editable `message`, and its own `watched` list.
- **`peerPressure`** holds `enabled`, `printEnabled`, `triggerOnOwnCasts`, `soundEnabled`, and its own `watched` list.
- **`watchedBuffs`** is the shared thank-you list behind Teammate Buffs and Service Alerts. Their ids never overlap, so one table is unambiguous.
- **`slash`** through **`slash5`** are the five Thank You buttons, one subtable each, generated from `Data.THANK_YOU_BUTTONS`.

Good News keeps its own `watched` list rather than sharing `watchedBuffs` because it reuses the *same* teammate buff ids with independent choices. One shared table could not hold both "thank someone for it" and "announce it when I cast it".

Defaults come from `ns.DATABASE_DEFAULTS` and are applied by AceDB-3.0 when a scope is first accessed; explicit user values, including `false`, are never overridden. Scalar and table defaults are physically copied into the saved table; only `*` and `**` wildcard defaults resolve through metatables.

The three watched lists (`watchedBuffs`, `goodNews.watched`, `peerPressure.watched`) start empty in the defaults and are seeded from this client's data folder, as settings maps: `PopulateWatchedBuffs` and `PopulatePeerPressureWatched` write a row's default (`received`, `given`, or the Peer Pressure default digit) for every live id the saved list holds no value for, never touch a value the player set, and prune ids not live on this client so the saved data stays client-real. A newly added data row therefore reaches existing players on their next login, and a list the player turned entirely off stays off. They run at login and again on every profile change, copy, or reset, because a profile swap replaces every setting at once. That same callback reconciles the Thank You macros and tells the open options panels to redraw, one `NotifyChange` per entry in `ns.OPTIONS_REGISTRY`.

There is no migration chain, and no migration code in the tree. The rename from `TFTB_DB` to `TFTBDB` shipped without a bridge by maintainer decision (`README-Notes.md`), so an install that predates it starts from defaults once; don't add one after the fact.

## Adding a New Tracked Buff or Cooldown

`ns.TRACKED_ABILITIES` lives in `Data/{Game}/Tracked-Abilities-{Game}.lua`, one complete copy per flavor folder. One entry is one checkbox on the Teammate Buffs, Service Alerts, or Send Good News panel.

1. Add an entry with its `class` (omit it for an item-driven row), `type` (`SOLO`, `GROUP`, or `SERVICE`), `detect` (`AURA`, `CAST`, or `RESURRECT`), the `received` and (non-service) `given` defaults, and a `triggers` list of `{ spell = id }`. Add `item = id` for item-driven buffs, and `aura = id` when the applied aura id differs from the cast id.
2. For a multi-rank or multi-variant group under one toggle, list every id in `triggers`. When one of its own items names the group (Soulstone, Scroll of Agility), set `labelItem` to that item's id and the client supplies the label in every locale. Otherwise set `name = L["GROUP_*"]`, adding the key to `Locales/enUS.lua`, but only for our own word for the group (Portals, Repair Bots), never for a game record's name. A single spell or item takes its name from the client and needs no locale key.
3. Add the row to every folder whose client has the ability, and leave it out of any folder where its id means a different ability. Look the id up in all seven folders and say in the PR which copies changed and why.
4. Set `noDuration` when the buff is spent by an event rather than by time (Fear Ward, Misdirection), so Good News drops its duration clause. It changes the outcome only for buffs *under a minute*, since longer ones are dropped by the cap regardless, but set it wherever it is true.
5. Set `opened` on a `SERVICE` to read "opened" (portals, summons) instead of "set out" (feasts, soulwells, repair bots). Use `detect = RESURRECT` for a cast that can fail, so only a confirmed revive announces; `Data/Camelot/` can't carry one. Set `receivable = false` in a folder whose client can't see the row land on you, so it reaches Good News only.
6. No code change is needed. `BuildLookups`, `PopulateWatchedBuffs`, and `BuildDisplayGroups` consume the table at login, and the new id seeds into existing profiles.

Whatever the entry, its link ends up inside a whisper capped at **255 bytes** (Style Guide → MESSAGES → Message Length), so a new `GROUP_*` label should stay short. Run Message Length on the Diagnostics Localization tab, on ruRU, after adding a long-named item.

## Adding a New Peer Pressure Ability

`ns.PEER_PRESSURE_ABILITIES` lives in `Data/{Game}/Peer-Pressure-Abilities-{Game}.lua`, one copy per flavor folder. One row per checkbox: `{ "CLASS", { spell ids }, default }`. List every rank or variant in the id list, and leave the row out of any folder where the id is a different ability. `Data/Camelot/` keeps its copy even though the Camelot TOC loads no Peer Pressure code, so every folder declares the same tables. Rows are consumed at login by `Features/Peer-Pressure.lua`; no code change is needed.

## Adding a New Thank You Button

Append one row to `Data.THANK_YOU_BUTTONS` in `Data/Data.lua`, with a unique `profileKey`, a `macroName` leading with a dash, and a `command` nobody else registers. Its defaults, options section, slash command, and macro all generate from that row, and it starts switched off. Nothing else changes. The macro body is the command literal, far under the 255-byte macro ceiling.

## Adding a New Registered Event

1. Add the event name to `ns.EVENT_NAMES` in `Features/Core.lua`. The dispatcher registers it and the diagnostics event-registration probe picks it up automatically. Never register a frame anywhere else. An event one flavor lacks is appended conditionally, the way `UNIT_AURA` and `COMBAT_LOG_EVENT_UNFILTERED` are, because registering an event the client doesn't have throws.
2. If the add-on only needs it for specific units, add those units to `ns.EVENT_UNITS` so it registers through `RegisterUnitEvent`.
3. Attach a handler in the owning feature module with `ns.SetEventHandler("EVENT_NAME", handler)`, named for the event (`OnEventName`). Only one module may own an event. On Forever, check every argument with `ns.IsPlain` before comparing it or using it as a key.
4. If it is a firehose, add it to `ns.DIAGNOSTIC_EVENT_EXCLUDE` and decode it into the log through a purpose-built helper, or to `ns.MESSAGE_ID_FILTERED_EVENTS` if per-id correlation is enough.

## Localization

- **`enUS.lua` is the source of truth.** Locale files live in `Locales/<locale>.lua`, each registered through `NewLocale("TFTB", "<code>")`, and `enUS.lua` is the only one that passes the `true` default-fallback flag. Every other locale translates its key set, and AceLocale falls back to English for anything missing at runtime. The other ten files belong to the Localization Review (`07 - Localization Review.md`); never hand-edit them during ordinary work.
- **Placeholders.** The `%s` and `%d` count, type, and order must match `enUS` per key in every locale, or the string crashes at runtime. `DEFAULT_GOOD_NEWS` is the exception that proves the rule: its `%a` is not a format placeholder at all, never reaches `string.format`, and must survive translation literally.
- **Game names never go in `Locales/`.** Spells, items and classes are stored as IDs or tokens and named by the client. The `ns.GAME_IDS` constants (`SAMPLE_GOOD_NEWS_SPELL_ID`, `SAMPLE_PEER_PRESSURE_SPELL_ID`) and every tracked or Peer Pressure spell are named through `C_Spell.GetSpellName` (and linked through `ns.GetSpellLink`); tracked items and `labelItem` groups through `C_Item.GetItemInfo`; class tokens through `LOCALIZED_CLASS_NAMES_MALE`; durations through the client's `D_SECONDS` / `D_MINUTES` / `D_HOURS`. The only tracked-row names in `Locales/` are our own group words (`GROUP_*`).
- **Quote style.** A value containing a double quote is written with single-quoted Lua delimiters and stays that way under StyLua (`BUTTON_MACRO_ENABLE`, `'Enable Macro "%s"'`, in every locale). Any script that audits key parity must accept both delimiters, or it reports that key as missing.
- **Diagnostics strings are not localized.** They live in `ns.DiagnosticsStrings` in `Diagnostics/Diagnostics-Core.lua` as plain English.

The Spanish file pairing, the overflow canary, and the output ceilings are per Style Guide → LOCALIZATION and MESSAGES → Message Length. In TFTB the sent strings that carry a live link (`MESSAGE_WHISPER_THANKS`, `DEFAULT_GOOD_NEWS`) are the ones to keep short in translation.

## Common Pitfalls

- **A `|4` plural escape in a sent message.** WoW's own duration strings (`D_MINUTES` is `"%d |4minute:minutes;"`) carry an escape the UI expands only at render time. It looks correct in a print, but `SendChatMessage` rejects any message still holding one ("Invalid escape code in chat message") and silently drops the *whole line*. `ResolvePlurals` in `Features/Announcements.lua` expands it to plain text before the whisper is queued.
- **`string.format` on a user-editable template.** The Good News body is whatever the player typed, so a stray `%` in it makes `format` raise mid-whisper. `ns:BuildGoodNewsMessage` substitutes `%a` with `gsub` and a replacement function, which also stops a `%` inside a spell link from being read as a capture reference.
- **Truncating a sent line to fit 255 bytes.** A cut can land inside a link, which the server rejects. `ns:BuildGoodNewsMessage` falls back to shorter whole templates instead; the edit boxes trim only the player's own text, and only at a character boundary (`ns.TrimToBytes`).
- **Whispering a pet name.** A whisper addressed to a pet bounces ("No player named 'X' is currently playing"). Every whisper path is guarded by `ns.IsPlayerGUID`, and pet sources are traded for their owner via `ResolveSource` / `ResolveAuraCaster`, which return nil rather than falling back to the pet.
- **Assuming your own casts come from `player`.** Roar of Sacrifice and Battle Squawk are cast by your pet. `UNIT_SPELLCAST_SENT` registers for `player` and `pet`, and a bare `unit == "player"` test silently switches Good News off for every pet-cast entry in the data.
- **Cross-realm source names.** A combat-log name is `Name-Realm` and never matches a name lookup or resolves as an emote target. Classify group membership by affiliation flags, and strip the realm with `Ambiguate(name, "short")` before passing a name to `C_ChatInfo.PerformEmote`.
- **`C_ChatInfo.PerformEmote(cmd, nil)` is not undirected.** It falls back to your *current target*, thanking a bystander. TFTB never emotes undirected either: `ns:DoRandomEmote` and `ns:DoEmoteToken` return early on a nil target, because the undirected flavor ("You thank everyone around you.") fires precisely when the buffer could not be resolved, which is itself the evidence they are gone.
- **A unit token is not proof of presence.** A party member who zoned into a dungeon is still `party2`. `CanWitnessEmote` gates on `UnitIsVisible` plus `UnitInRange`, reading `UnitInRange`'s second return so a non-group unit (or a secret answer on Forever) falls through to the visibility verdict instead of a bogus false.
- **Resolving an emote target before a delay.** `ResolveEmoteTarget` hands back a live unit token, and `target` / `focus` / `mouseover` name whoever you are pointing at *in that instant*. Resolve it when the buff lands and a delayed emote thanks whoever you moved on to. `DeliverPraise` resolves inside the timer for exactly this reason; every other gate is settled before the timer arms.
- **Iterating a saved emote table instead of `Data.EMOTES`.** Saved settings outlive the list, so a retired key (the bogus `YES` token, now `NOD`) sits in every existing profile and a random pick that lands on it is a silent no-op. `ns:DoRandomEmote` walks `Data.EMOTES` and reads the saved table by key.
- **Opening the options panel by title.** `Settings.GetCategory(<title>)`, or passing the add-on title to `Settings.OpenToCategory`, returns nil on clients that carry the Settings API. Execution falls through to `AceConfigDialog:Open` and the panel opens as a floating window instead of docking into Blizzard's settings. It still works on Classic Era, so one-flavor testing misses it. `ns:OpenOptionsPanel` captures both return values of `AddToBlizOptions` and routes by the captured id.
- **Reading a buff's duration too early.** For Good News, the aura lands a tick *after* the cast succeeds, so reading it inline reports "no duration" for every buff. Wait `AURA_SETTLE`, then read it off the recipient after re-confirming their GUID.
- **A live buff reporting 0 duration.** `ns.GetBuffDuration` returns 0 for a timerless buff and nil for absent, so callers must nil-check and never test the number for truthiness.
- **A successful cast is not a successful resurrect.** Goblin jumper cables emit `SPELL_CAST_SUCCESS` for every jolt, revived or not. Only `SPELL_RESURRECT` proves it took, which is what the `RESURRECT` detect mode exists for, and why Forever, with no combat log, carries no such row.
- **The client's native spell link in chat.** On Classic `C_Spell.GetSpellLink` omits the trailing `:0` field, which `SendChatMessage`'s validator strips on send, so whispers arrive with the link gone. `ns.GetSpellLink` builds `|Hspell:<id>:0|h` by hand and uses the native link only when the name won't resolve.
- **Reusing a spell id across flavors.** `C_Spell.DoesSpellExist` cannot tell Ice Block (Era) from Cold Snap (TBC); they share id `11958`. Each flavor folder carries only the row that id means on its client.
- **Touching a secret value on Forever.** Comparing, concatenating, or indexing with one errors, and they arrive from event arguments, unit names, aura fields, even `UnitInRange` and `PerformEmote` returns. Test with `ns.IsPlain` first, and ask `ns.IsUnitIdentitySecret` / `ns.AreAurasSecret` before reads that can go secret; skip the output rather than working around it.
- **Leaving a caption on a label-beside-control row.** AceConfig renders a widget's own `name` above it, so a `select` that keeps its caption stacks the label over the control and breaks the row. Every dropdown here (`ns.DefineSecondsSelect`, `ns.DefinePraiseDelaySelect`, the Good News scope, the single-emote picker) carries `name = ""` and pairs with an `ns.OptionsRowLabel` cell that makes up the rest of `ns.OPTIONS_ROW_WIDTH`.
- **Editing a vendored library.** `Includes/Libraries/` is refreshed from upstream by the packager on every release (`externals` in `.pkgmeta`), so a local fix is discarded at build time. Work around it in `Features/`, or fix it upstream.

## Contributing

- **Issues.** <https://github.com/Gogo1951/Thanks-for-the-Buff/issues>.
- **Bug reports.** Include game version and locale, class and level, repro steps, and the relevant chat output. The Diagnostic Tools panel produces a ready-to-paste report: enable it, press Run All on the Settings and Code tabs, and capture the Event Log on Run Tests while reproducing.
- **Discord.** <https://discord.gg/eh8hKq992Q>.
- **PRs.** Keep changes scoped. Run StyLua with its default config and `--syntax lua51` over every touched Lua file, and keep `luac -p` and `luacheck .` clean. Any change to the shape, name, or scope of saved data ships its own migration, tagged `MIGRATION (remove after YYYY-MM-DD)` and supported for 30 days. Check any sent-message change against the **255-byte** chat limit in the widest-encoding locale (Style Guide → MESSAGES → Message Length, canonical for both output ceilings), using the Message Length report on ruRU. Update this document if the architecture or file map changes.
- **PR descriptions say what a player will notice**, in plain language, the way release notes do. Commit messages carry the developer detail.
