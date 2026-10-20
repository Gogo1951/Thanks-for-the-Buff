# Thanks for the Buff // Technical Reference

This document combines architecture notes and contribution guidance for developers working on Thanks for the Buff. For end-user documentation, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md).

## File Map

The repo root *is* the add-on folder; the packager renames it to `TFTB` on release (`package-as` in `.pkgmeta`), which is why the installed path is `Interface/AddOns/TFTB/`. Players see the feature built in the `Buff-Window` files as **Buff Duty**; the code and the saved settings call it the Buff Window.

```
Thanks-for-the-Buff/
├── .github/
│   ├── ISSUE_TEMPLATE/                         Common-Core issue forms; config.yml is this add-on's own
│   │   ├── config.yml
│   │   ├── defect.yml
│   │   └── request.yml
│   └── workflows/
│       ├── ci.yml                              Calls Common-Core: Lua 5.1 syntax, luacheck and StyLua on every PR and push to main
│       ├── issue-labels.yml                    Calls Common-Core: labels a new issue from the Defect form's Issue Type
│       └── package.yml                         Calls Common-Core: packages and uploads a pushed tag; a manual run is a dry run
├── .gitattributes                              Shared from Common-Core
├── .gitignore                                  Shared from Common-Core
├── .luacheckrc                                 Lint config
├── .pkgmeta                                    Packager manifest: package-as, externals, ignore list
├── Bindings.xml                                The two Buff Keys' key bindings; loaded by the client, not the TOCs
├── TFTB_Camelot.toc                            WoW Forever; leaves out Peer Pressure
├── TFTB_TBC.toc                                TBC Anniversary
├── TFTB_Vanilla.toc                            Classic Era, Season of Discovery included
├── Data/
│   ├── Flavor.lua                              Flavor identity and the loaded data folder (canonical copy)
│   ├── Data.lua                                Locale init, palette, registry names, layout widths, Thank You buttons, Buff Duty choices, emotes
│   ├── {Game}/                                 One folder per flavor: Vanilla, Discovery, TBC, Camelot, Wrath, Mists, Mainline
│   │   ├── Tracked-Abilities-{Game}.lua        What other players spend on you (ns.TRACKED_ABILITIES)
│   │   ├── Peer-Pressure-Abilities-{Game}.lua  Same-class cooldowns (ns.PEER_PRESSURE_ABILITIES)
│   │   ├── Buff-Window-Spells-{Game}.lua       Buff Duty's buffs, self buffs, weapon buffs, Soulstone, resurrections, pet icons
│   │   └── Game-IDs-{Game}.lua                 The panels' sample spells and Phase Shift (ns.GAME_IDS), Thank You macro icons
│   └── Default-Settings.lua                    AceDB defaults (ns.DATABASE_DEFAULTS), one shared profile
├── Diagnostics/                                Diagnostic Tools, copied from Magic Eraser
│   ├── Diagnostics-Core.lua                    Enable gate, ns.DiagnosticsStrings, client header, tooltip readers
│   ├── Manifests.lua                           TFTB's own surface: API rows, context probes, log decoders, names, messages, data sources
│   ├── Event-Log.lua                           Event and Taint Logs, with TFTB's exclude and per-id filter tables
│   ├── Code-Reports.lua                        Event Registration, API Endpoints, Library Versions
│   ├── Settings-Reports.lua                    Display Context (the Buff Duty window's placement), Other Add-ons, Saved Variables
│   ├── Validate-Data.lua                       Per-file export of every id in this client's data folder
│   ├── Localization-Reports.lua                Locale Context, Game Names, Message Length
│   ├── Report-Runner.lua                       Report and tab manifests, the one-at-a-time runner
│   └── Options-Diagnostics.lua                 The Diagnostic Tools panel
├── Features/
│   ├── Core.lua                                Version, AceDB lifecycle, event dispatcher, login order
│   ├── Utilities.lua                           Colors, emote catalog, secret-value checks, spell links, GUID, sound, aura and tooltip helpers
│   ├── Announcements.lua                       Prints, sent messages, emotes, durations, Good News whisper queue
│   ├── Tracked-Lookups.lua                     Tracked lookups, watched-list seeding, display groups, item-name repaint
│   ├── Praise.lua                              Cooldowns, emote targets, reactions to a classified buff
│   ├── Buff-Tracking.lua                       The reaction engine's event side: detect and classify; owns UNIT_AURA
│   ├── Good-News.lua                           Your own casts: recipient capture, release, dedup
│   ├── Peer-Pressure.lua                       Same-class cooldown alert, tapped from the combat log
│   ├── Thank-You-Button.lua                    The Thank You buttons: macros and command bodies
│   ├── Buff-Window-Frame.lua                   Buff Duty's secure click-to-cast frames
│   ├── Buff-Window-Castable.lua                What you can cast: lookups, audience seeding, ranks; creates ns.BuffWindow
│   ├── Buff-Window-Units.lua                   Unit reads: aura cache, roles, range, labels, icons, pets
│   ├── Buff-Window-Self.lua                    Self-Buffs section: self buffs, weapon buffs, Soulstone
│   ├── Buff-Window-Outsiders.lua               Return the Favor and Target sections
│   ├── Buff-Window.lua                         Party sections, refresh, events, setup
│   ├── Buff-Window-Keys.lua                    The Buff Keys: two key-bound secure buttons that cast the next buff
│   └── Minimap-Button.lua                      LDB launcher: feature-switch clicks, tooltip, LibDBIcon registration
├── Includes/
│   ├── Images/                                 Thanks-for-the-Buff.tga, the TOC IconTexture
│   ├── Libraries/                              Vendored LibStub, Ace3, LibDataBroker and LibDBIcon; never hand-edited
│   └── Sounds/                                 Buff.ogg (any buff on you), Thunder.ogg (Peer Pressure)
├── Locales/                                    AceLocale-3.0 strings
├── Options/
│   ├── Options-Utilities.lua                   Shared helpers, feature switches, Example lines, control factories
│   ├── Options-General.lua                     Root panel: pitch, welcome toggle, feature switches, /Commands
│   ├── Options-Stranger-Buffs.lua
│   ├── Options-Teammate-Buffs.lua
│   ├── Options-Teammate-Buffs-Tracked.lua      Each *-Tracked.lua is its panel's Tracked Abilities sub-panel
│   ├── Options-Send-Good-News.lua
│   ├── Options-Send-Good-News-Tracked.lua
│   ├── Options-Service-Alerts.lua
│   ├── Options-Service-Alerts-Tracked.lua
│   ├── Options-Peer-Pressure.lua
│   ├── Options-Peer-Pressure-Tracked.lua
│   ├── Options-Buff-Window.lua                 Buff Duty: the window's rows, lock, Hide in Combat, Buff Keys
│   ├── Options-Buff-Window-Buffs.lua           Buff Duty > Tracked Abilities: who each buff is offered to
│   ├── Options-Buff-Window-Self-Buffs.lua      Buff Duty > Self-Buffs: when each self buff shows
│   ├── Options-Buff-Window-Weapon-Buffs.lua    Buff Duty > Weapon Buffs: one Reapply timing, a checkbox per choice per hand
│   ├── Options-Thank-You-Button.lua
│   ├── Options-Profiles.lua                    Stock AceDBOptions-3.0 table, returned as-is
│   ├── Options-Feedback-Support.lua            Feedback & Support panel: Level Up note, links, version
│   └── Options.lua                             Registration order, panel routing, slash commands
├── LICENSE                                     MIT
├── README.md                                   End-user documentation
├── README-Notes.md                             Where TFTB departs from the Style Guide
├── README-Technical.md                         This document
└── README-Testing.md                           Manual test plan
```

`.pkgmeta`'s ignore list keeps the `.github/` files, the dotfiles, `LICENSE` and the README files other than `README.md` out of the player zip, along with `Data/Wrath/`, `Data/Mists/` and `Data/Mainline/`, which no TOC lists yet. Those three are forward-prep: every folder declares the same tables, and the forward folders declare the Buff Duty tables, and their `ns.THANK_YOU_MACRO_ICONS`, empty. `Data/Mists/` and `Data/Mainline/` also leave `PHASE_SHIFT_SPELL_ID` out of `ns.GAME_IDS`, which the range check tolerates.

`Includes/Libraries/` is committed *and* declared as packager `externals`, so every tagged release re-pulls each library from upstream and commits the result back to `main`. A hand-edit to a vendored file is discarded on the next build.

Dead files, not to be reintroduced: `Diagnostics/Locale-Reports.lua` (its reports live in `Diagnostics/Localization-Reports.lua`), the single `Data/Tracked-Abilities.lua` and `Data/Peer-Pressure-Abilities.lua` (replaced by the flavor folders), the unsuffixed `TFTB.toc` (replaced by the three flavor TOCs), and `Features/Diagnostics.lua` with its old `Options/Options-Diagnostics.lua` (replaced by `Diagnostics/`).

## Architecture

### Event Loop

`Features/Core.lua` owns one frame and one dispatcher; feature files never create an event frame or call `RegisterEvent`. (The one other frame that registers events is the Event Registration probe in `Diagnostics/Code-Reports.lua`, which registers and immediately unregisters each one on its own throwaway frame.) The complete event list is `ns.EVENT_NAMES`, so the registered set, the diagnostics event-log tap and the Event Registration probe can never drift apart:

```
PLAYER_LOGIN · PLAYER_ENTERING_WORLD · UNIT_SPELLCAST_SENT · UNIT_SPELLCAST_SUCCEEDED
LOADING_SCREEN_DISABLED · UNIT_AURA · GROUP_ROSTER_UPDATE · SPELLS_CHANGED
PLAYER_REGEN_DISABLED · PLAYER_REGEN_ENABLED · PLAYER_TARGET_CHANGED · UNIT_PET
SPELL_UPDATE_COOLDOWN · GET_ITEM_INFO_RECEIVED · UNIT_INVENTORY_CHANGED
BAG_UPDATE_DELAYED · REPLACE_ENCHANT
+ COMBAT_LOG_EVENT_UNFILTERED  (every flavor but Camelot)
```

Feature modules attach handlers with `ns.SetEventHandler(event, handler)`. Attaching the same event twice silently replaces the earlier handler, so each event has exactly one owner, and a second consumer is called by the owner rather than registered beside it:

| Event | Owner | Also calls, first |
| --- | --- | --- |
| `UNIT_AURA` | `Features/Buff-Tracking.lua` | `ns.OnBuffWindowAura` |
| `COMBAT_LOG_EVENT_UNFILTERED` | `Features/Buff-Tracking.lua` | `ns.CheckPeerPressure` (mid-handler) |
| `UNIT_SPELLCAST_SUCCEEDED` | `Features/Buff-Tracking.lua` | `ns.OnBuffKeyCastSucceeded`, then `ns.ClaimPendingGiven` |
| `GET_ITEM_INFO_RECEIVED` | `Features/Tracked-Lookups.lua` | `ns.OnBuffWindowItemInfo` |
| `REPLACE_ENCHANT` | `Features/Buff-Window-Self.lua` | |
| `SPELL_UPDATE_COOLDOWN` | `Features/Buff-Window-Frame.lua` | |
| `UNIT_INVENTORY_CHANGED`, `BAG_UPDATE_DELAYED`, roster, target, pet, spells, regen | `Features/Buff-Window.lua` | |

Every event first passes through `ns:LogEvent` while diagnostics logging is on, behind a single boolean check.

`UNIT_SPELLCAST_SENT` (for `player` and `pet`) and `UNIT_INVENTORY_CHANGED` (for `player`) register through `RegisterUnitEvent`, from `ns.EVENT_UNITS`. `UNIT_AURA` registers unfiltered on every flavor: the Buff Window reads every group member, and `RegisterUnitEvent` takes two units at most. `ns.OnBuffWindowAura` therefore filters the unit token itself, and Forever's buff detection returns at once for any unit but `player`.

Core registers every event when its file loads, not at login, so a handler can fire before `ns.db` exists. Every handler guards itself (`ns.db`, `isReady`, or the Buff Window's `isSetUp`); a new one must too.

Forever has no combat log, and registering `COMBAT_LOG_EVENT_UNFILTERED` there errors, so Core appends it only when `ns.FLAVOR ~= "Camelot"` (from `Data/Flavor.lua`). Peer Pressure has no other source, so the Camelot TOC leaves out `Features/Peer-Pressure.lua`, `Options/Options-Peer-Pressure.lua` and `Options/Options-Peer-Pressure-Tracked.lua` together, and everything that reaches into them checks that they loaded (`ns.CheckPeerPressure`, `ns.SetupPeerPressure`, `ns.PopulatePeerPressureWatched`, `ns.BuildPeerPressureOptions`, `ns.PeerPressureCategories`, the General panel's switch through its `loaded` function). `Data/Camelot/Peer-Pressure-Abilities-Camelot.lua` still loads and still has readers: the Count as Tanks class list, Game Names and Validate Data. `Data/Camelot/` has no Jumper Cables row (only `SPELL_RESURRECT` proves a revive) and marks every non-service `CAST` row, Rebirth, Lay on Hands and Divine Grace among them, `receivable = false`: Forever's `UNIT_AURA` path consults only the aura lookup, so their landing on you is invisible there, and they get no Teammate Buffs toggle. Your own casts of them still reach Good News through `UNIT_SPELLCAST_SUCCEEDED`, which is why Good News renders its own `ns.GoodNewsCategories` rather than reusing the teammate list.

Forever also hands out *secret values*. `ns.IsPlain` guards every event argument and API return that is compared, concatenated, sent, or used as a table key. Unit identity and aura data go secret in combat there, so `ns.IsUnitIdentitySecret(unit)` and `ns.AreAurasSecret()` (thin wrappers over `C_Secrets`, always false on other flavors) are asked before Good News resolves a recipient or reads a duration, before a group service credits its caster, before the Thank You command checks or whispers its target, and before the Buff Window reads anything. A secret read skips that output rather than working around it.

`PLAYER_LOGIN` runs the setup sequence, and the order is load-bearing: `AceDB:New` first (nothing may read a setting before it exists), then `ns.RegisterOptionsPanels` (the Profiles panel binds to `ns.db`; panels that render login-built lists register as builders and draw them on open), then `ns.SetupBuffTracking`, `ns.SetupPeerPressure` and `ns.SetupBuffWindow` (which need the spell and item APIs live), then `ns:CreateAutoMacro`. The welcome message rides `PLAYER_ENTERING_WORLD` behind a once-per-session flag, since that event refires on every loading screen.

The TOC order is load-bearing too. Feature files call `ns.SetEventHandler` and capture other modules' functions as locals at load (`Features/Buff-Tracking.lua` takes helpers from Utilities, Tracked-Lookups and Praise), so Core loads first and each file after what it captures. `Data/Default-Settings.lua` loads after the flavor folder because it reads `ns.THANK_YOU_MACRO_ICONS`.

A safety timer (`Data.SAFETY_PAUSE`, 3 seconds) runs after login and after every `LOADING_SCREEN_DISABLED`, so the burst of auras a zone-in reports is not mistaken for fresh buffs. While it runs, `isReady` is false and `OnCombatLogEventUnfiltered` returns at its first line, which silences buff reactions, Peer Pressure, resurrect releases and Return the Favor alike; Service Alerts, Good News and Forever's `UNIT_AURA` path check it too. A token invalidates earlier timers, so back-to-back loading screens cannot let a stale callback flip `isReady` back on mid-pause. The Buff Window does not read it (it shows state, not events), and neither do the Buff Keys, which hear their own casts go off whatever the timer says.

### Combat Lockdown

Six things answer to combat, each its own way.

**The options panel refuses outright.** `InCombatLockdown()` is the first statement of `ns:OpenOptionsPanel`, one gate in front of the whole routing chain. It prints `CHAT_OPTIONS_IN_COMBAT` and returns. It never queues the panel and never registers `PLAYER_REGEN_ENABLED` to finish the job: Blizzard's Settings panel is protected in combat, and a silent refusal reads as a broken command.

**The Buff Window freezes, then catches up.** Its icons are `SecureActionButtonTemplate` buttons, whose attributes, position and visibility can only change out of combat. `PLAYER_REGEN_DISABLED` sets an `inCombat` flag; while it is set (or `InCombatLockdown()` is true), `Refresh` returns, `ns.OnBuffWindowAura`, the inventory and bag triggers and the backstop ticker queue nothing, and `ns.RenderBuffWindow` and `ns.HideBuffWindow` refuse. `ns.ApplyBuffWindowSettings` (the Hide in Combat state driver and the saved position) returns false in combat, which sets `settingsPending`. `PLAYER_REGEN_ENABLED` clears the flag, replays any pending settings, marks every unit dirty and requests one refresh. Mid-fight only the range fade (alpha, which the client allows on a protected frame) and the cooldown swipes (plain children of the buttons) keep updating. With Hide in Combat on, a secure state driver (`[combat] hide; show`) hides the window's anchor; with it off, the window keeps showing the list as it stood when combat began. Dragging is refused in combat.

**The Buff Keys cast nothing.** Their `PreClick` writes no attributes in combat and shows the client's `ERR_NOT_IN_COMBAT`, and `PostClick` leaves the (already empty) attributes alone, so a press mid-fight is a no-op with a reason.

**Macros are skipped, not queued.** `ns.ReconcileMacros` and `ns:DeleteAutoMacro` return early in combat, because the macro API is unavailable there. A Create Macro toggle or Icon pick made mid-fight leaves the macro alone; the next login, profile change, toggle or icon pick reconciles it. There is no dirty flag and no replay.

**Emotes are suppressed, not queued.** The reaction paths themselves run in combat: prints, sounds and outgoing whispers all fire whether or not you are fighting, because they touch no protected function. Emotes are visible and social, so `HandleTracked` and `HandleStrangersBuff` allow them only when `not InCombatLockdown()`, and `DeliverPraise` tests combat again when the emote fires, so entering combat during a Praise Delay still suppresses it. A Stranger Buffs praise cooldown is not spent on a buff whose only enabled praise is an emote blocked by combat, so the next qualifying buff after combat reacts at once. One that was cleared before the delay and blocked during it is already spent.

**On Forever, buffs on you are not read in combat.** `OnUnitAura` returns while `InCombatLockdown()` or `ns.AreAurasSecret()` is true, so a buff that lands mid-fight is never seen there, and is not queued for later.

### Praise vs Notifications

The reactions split into two kinds, which is also how the Stranger Buffs, Teammate Buffs and Service Alerts panels are laid out:

- **Praise** is the thank-you whisper and the emote. Both go outward to the player who buffed you, so both answer to the Praise Delay and to the 45-second per-recipient whisper floor, and on Stranger Buffs to its two praise cooldowns as well. Teammate Buffs and Service Alerts carry no praise cooldowns: a teammate's cooldown is worth acknowledging every time it lands. Both are delivered by `DeliverPraise` in `Features/Praise.lua`.
- **Notifications** are the print and the sound. Self-only, never delayed, fired inline the moment the buff qualifies. What qualifies is the panel's own gate: a stranger buff must still be on you and clear `minBuffDuration`, and a service passes its 10-second `service:` cooldown first.

`DeliverPraise` receives decisions, not permissions to re-derive: every gate (the toggles, the cooldowns, the whisper throttle, the combat check) is settled and stamped before the timer is armed, so a burst of buffs landing inside the delay window cannot slip past a cooldown. `praiseDelayEnabled` off means a delay of 0 and inline delivery. The emote *target* is the deliberate exception, resolved inside the timer: `ResolveEmoteTarget` returns a live unit token, and `target`, `focus` and `mouseover` all name whoever you are pointing at in that instant, so resolving early makes a delayed emote thank whoever you moved on to.

### Detect, Classify, React

The reaction pipeline runs across `Features/Buff-Tracking.lua` (detect and classify, against the lookups in `Features/Tracked-Lookups.lua`), `Features/Praise.lua` (react), `Features/Good-News.lua` (your own casts) and `Features/Announcements.lua` (output):

1. **Detect.** `OnCombatLogEventUnfiltered` taps `SPELL_AURA_APPLIED` and `SPELL_AURA_REFRESH` (buffs landing; a rebuff earns the same thanks), `SPELL_CAST_SUCCESS`, and `SPELL_RESURRECT`. On Forever, `OnUnitAura` stands in for the aura half. `OnUnitSpellcastSucceeded` taps group services and hands your own casts to Good News (`ns.ClaimPendingGiven`); `OnUnitSpellcastSent` in `Features/Good-News.lua` captures the recipient of your own casts. The three lookups (`auraLookup`, `castLookup`, `givenLookup`) are each keyed by the id the relevant event actually carries.
2. **Classify.** `MatchTracked` requires the subevent to match the entry's own `detect` mode rather than merely finding the id in a lookup, which is what keeps a `RESURRECT` entry from firing on the `SPELL_CAST_SUCCESS` it shares a lookup with, and a `CAST` entry from firing on a stray `SPELL_RESURRECT`. `ResolveSource` trades a pet GUID for its owner (through `ns.GetPetOwnerUnit`, which knows `pet`, `partypet1-4` and `raidpet1-40`) and returns nil, dropping the event, when no owner unit resolves; a guardian never resolves. Cross-realm sources arrive as `Name-Realm` and never match a name lookup, so group membership is decided by the combat-log affiliation flags (`MINE`, `PARTY`, `RAID`), and a stranger is a friendly player GUID carrying `AFFILIATION_OUTSIDER` whose aura landed on you. Service entries surfacing in the combat log are dropped here, since they announce from `UNIT_SPELLCAST_SUCCEEDED` instead.
3. **React.** `HandleTracked` and `HandleStrangersBuff` route to the announcement helpers. Beside the stranger call, Buff-Tracking calls `ns.NoteFavor` for the Buff Window's Return the Favor list; that call is independent of Stranger Buffs, so it runs with the panel switched off and ignores `minBuffDuration`, answering only to `buffWindow.favorEnabled`. Sent messages go through `SignOff` in `Features/Announcements.lua`, which adds the target marker (`{rt1}` Star, left off on Forever, which blocks raid-marker tokens in chat), trims the body's closing punctuation (whole UTF-8 marks, including full-width and Spanish opening marks), and appends ` // TFTB` (`L["ADDON_SHORT"]`). The sign-off trails rather than leads by the exception in `README-Notes.md`. Sent messages carry a spell or item link; `SendChatMessage` rejects anything over **255 bytes** (`ns.CHAT_MESSAGE_MAX_LENGTH`). The thank-you whisper has no fallback of its own past that ceiling, which is why its locale strings must stay short.

Each feature carries a master switch (`strangers.enabled`, `teammates.enabled`, `services.enabled`, `peerPressure.enabled`, `buffWindow.enabled`, and Good News's own `whisperEnabled`), declared once in `ns.FEATURE_SWITCHES` and built by `ns.OptionsFeatureToggle`. Each is placed twice, at the top of its panel and, two to a line (`ns.OptionsTogglePairs`), in the General panel's Features section; flipping either repaints every panel, and a switch with an `onChange` (Buff Duty's calls `ns.RefreshBuffWindow`) reacts at once. The switch is a real gate in the engine, not only a way to hide controls: `HandleTracked`, `HandleStrangersBuff`, `ns.CheckPeerPressure`, `OnUnitSpellcastSent` and the Buff Window's `Refresh` each return early when their feature is off.

### Item Data Caching

Item names and links come from `C_Item.GetItemInfo`, which returns nil on a cold cache and fills asynchronously. Nothing is stored by the add-on; the client's cache is the cache.

- **Tracked items.** `WarmItemCache` runs at login (from `ns.BuildTrackedData`) and touches every tracked item so its name and link are warm by the time an options panel or a "used their X on you" message needs it. Where a name is not ready, the toggle shows the `TRACKED_ITEM_PENDING` placeholder (`Item #%d`); a spell name not ready shows `TRACKED_SPELL_PENDING` (`Spell #%d`). `GET_ITEM_INFO_RECEIVED` for a tracked item calls `NotifyChange` on the three Tracked Abilities sub-panels that list items (Teammate Buffs, Send Good News, Service Alerts).
- **Buff Duty items.** `BuildLookup` collects every poison, oil, stone, lure and Soulstone id and asks for each with `C_Item.RequestLoadItemDataByID`. `ns.OnBuffWindowItemInfo` repaints the Weapon Buffs sub-panel when one of them arrives (`ns.IsBuffWindowItem`).

The sub-panels register as builder functions and sort through `ns.SortedEntries` at build time, so a reopened panel also sorts by the resolved name.

Spell *descriptions* have the same problem for a different reason: Classic keeps tooltip data only for spells the character has known, and these panels list every class. Every ability on the panels shows the game's own tooltip on hover, through AceConfig's `tooltipHyperlink`: a tracked toggle (a lone item, a spell or a rank group; a group of several items or named spells lists its members instead), and the name beside each Buff Duty dropdown, which is an `InteractiveLabel` (`ns.OptionsAbilityLabel`) because a plain label takes no mouse. Its dropdown keeps a line saying what it sets. `ns.SpellTooltipLink` calls `C_Spell.RequestLoadSpellData` for every id when the panel is built and picks the spell again at each hover: the highest id the client describes, so a rank group shows the rank you actually cast. A weapon hand's caption shows whatever is picked on it, the poison line's best item or the imbue.

Item and spell access calls `C_Item` and `C_Spell` directly, with no legacy fallback: every client TFTB targets ships them, and the Retail engine behind WoW Forever has dropped the legacy globals. Chat and emotes go through `C_ChatInfo.SendChatMessage` and `C_ChatInfo.PerformEmote` for the same reason.

### Cooldown Namespaces

A single `sessionCooldowns` table (key to expiry) in `Features/Praise.lua` backs every reaction throttle, with disjoint string namespaces so keys on the same GUID never collide:

| Key | Window | Purpose |
| --- | --- | --- |
| `praise:all` (`PRAISE_OVERALL_KEY`) | `strangers.praiseCooldown` (default 0, off) | Overall stranger praise limit |
| `praise:<guid>` | `strangers.cooldown` (default 3s) | Per-source stranger praise |
| `whisper:<guid>` | 45s (`WHISPER_COOLDOWN`) | Per-recipient outgoing whisper throttle, every panel |
| `service:<guid>` | 10s (`SetCooldown`'s default) | Group-service rate limit *and* multi-token dedup |
| `goodnews:<guid>:<spellID>` | 10s (`GOODNEWS_DEDUP`) | Good News per-recipient-per-spell dedup |

Both `praise:` keys gate the whisper and the emote alike, and neither is stamped unless praise is cleared to go out. `whisper:<guid>` is a floor underneath them that no setting can lower: a 1-second praise cooldown still cannot whisper the same player more than once every 45 seconds, which keeps a generous setting clear of the server's chat squelch. The `service:` key is per caster across every service, so it dedupes the several unit tokens one cast can fire on (`party1` and `target` for the same caster resolve to one GUID), and a feast set out within 10 seconds of the same mage's portal is dropped too. `ns.GetPraiseCooldownState` reads `praise:all`, `praise:<guid>` and `whisper:<guid>` for diagnostics without stamping. `SetCooldown` sweeps lapsed entries on each write, so the table cannot grow unbounded across a long session.

Two timers live outside this table: the Buff Keys' own `recent` and `pending` records (Buff Keys, below) and the Good News whisper queue's `nextWhisperAt`.

### Options Panels

`Options/Options.lua` registers every panel against its `ns.OPTIONS_REGISTRY` name, in the order Blizzard's settings tree shows them: General (root), Stranger Buffs, Teammate Buffs, Send Good News, Service Alerts, Peer Pressure, Buff Duty, Thank You Button, Profiles, Feedback & Support, and Diagnostic Tools last. The tree order *is* the order of the `AddToBlizOptions` calls, each behind an `if ns.Build*Options then` guard, which is what drops Peer Pressure on Forever. Teammate Buffs, Send Good News, Service Alerts and Peer Pressure each carry a Tracked Abilities sub-panel; Buff Duty carries three, Tracked Abilities, Self-Buffs and Weapon Buffs. Each sub-panel nests by the category id its parent's `AddToBlizOptions` call returned. Its tree label is the plain name, while the title drawn at its top reads "Parent > Name" (`ns.SubPanelTitle`). Only the root's category id is kept, in `ns.optionsFrames`.

`/tftb` is registered inside `ns.RegisterOptionsPanels`, at login. The Thank You commands (`/thankyou` to `/thankyou5`, `SlashCmdList` keys `TFTB_THANKYOU<n>`) register when `Options/Options.lua` loads.

Feature switches flip through `ns.SetFeatureSwitch(key, value)`, which writes the setting, runs the switch's `onChange` and repaints every panel; both copies of each toggle, the mini-map button and Buff Duty's close button all go through it, and `ns.IsFeatureOn(key)` reads one. The General panel's **Enable Mini-map Button** writes `profile.minimap.hide` (inverted) and calls `ns.RefreshMinimapButton`.

Each panel file owns its own layout and order numbers; the controls come from factories in `Options/Options-Utilities.lua`. The ones that bind a setting (`ns.DefinePrintToggle`, `ns.DefineWhisperToggle`, `ns.DefineEmotesToggle`, `ns.DefineEmoteGroup`, `ns.DefineSoundToggle`, `ns.DefinePraiseDelayToggle`, `ns.DefinePraiseDelaySelect`, `ns.DefineSecondsSelect`) take a `settings` accessor returning the profile subtable they bind to, so one definition serves Stranger Buffs, Teammate Buffs and Service Alerts without those three sharing a layout. `ns.DefineEntryToggle` (a tracked checkbox, bound to a watched list), `ns.DefineSoundPreview` and `ns.DefineSpellSelectRow` (a Buff Duty dropdown row) take their target directly. Beside them sit the row helpers (`ns.OptionsHeader`, `ns.OptionsDesc`, `ns.OptionsSpacer`, `ns.OptionsRowLabel`, `ns.OptionsAbilityLabel`, `ns.OptionsExample`, `ns.OptionsFeaturesNote`), the Example builders, `ns.TrimToBytes`, `ns.SortedEntries` and `ns.EmotesHidden`. `ns.BuffWindowRefreshValues`, the minutes-left choices, lives in `Options-Buff-Window-Self-Buffs.lua` and is reused by Weapon Buffs.

Two registration shapes coexist deliberately. Panels whose contents are fixed at login register a **prebuilt table** (General, Stranger Buffs, Thank You Button, Profiles, Feedback & Support). Panels that render login-built lists register the **builder function itself** (Teammate Buffs, Send Good News, Service Alerts, Peer Pressure, Buff Duty, and every sub-panel), so the table is rebuilt on open once lazily loaded names and the class lists exist. Registration runs before the feature setups in the login sequence, so a prebuilt table could not see those lists. Diagnostic Tools also registers its builder, so the enable gate can leave the tabs out of the table while it is off.

Stranger Buffs, Teammate Buffs and Service Alerts hide everything behind their master switch with `ns.HideAllExcept(args, isHidden, keep)`, applied to the finished args table rather than threaded through every factory. The rule is positional (everything except the intro and the switch), so a control added later is covered automatically, and existing `hidden` values are composed rather than replaced, which keeps the emote grid following its own toggle inside a panel that is switched on. Send Good News, Peer Pressure and Buff Duty pass their own hidden predicate to each control instead. No sub-panel hides anything behind its parent's switch: which abilities to track, and who each buff is for, are worth deciding before turning a feature on.

Every print or whisper toggle carries a silver **Example** line under it, built through the real pipeline rather than a hand-written mock. `ns.DefinePrintExample` adds the print prefix (`ns.GetPrintPrefix`) and calls a builder the panel passes, which is the same `ns:BuildStrangerMessage` / `ns:BuildTrackedMessage` the print uses, with a sample mage named Expektor. `ns.DefineWhisperExample` calls `ns:BuildAnnounceMessage`. Good News calls `ns:BuildGoodNewsMessage` with a live link to `ns.GAME_IDS.SAMPLE_GOOD_NEWS_SPELL_ID` and 15 seconds, and Peer Pressure calls `ns:BuildPeerPressureMessage` with `SAMPLE_PEER_PRESSURE_SPELL_ID`, both through `ns.OptionsExample`. `ns.MarkerAsTexture` swaps `{rt1}` for its texture, since panel text does not render the chat token. A sample built any other way drifts from what players receive the first time the format changes.

Dropdowns are label-beside-control rows: the `select` carries `name = ""` and `ns.OPTIONS_CONTROL_WIDTH`, paired with an `ns.OptionsRowLabel` at `ns.OPTIONS_LABEL_WIDTH` (2.1), so the two total `ns.OPTIONS_ROW_WIDTH` (3.4). Inside a class's inline group the label gives back 0.3 (`ns.OPTIONS_INLINE_LABEL_WIDTH`) for the box's inset and border, and a row outside a box that must line up with boxed rows uses `ns.OPTIONS_ALIGNED_LABEL_WIDTH`. The Thank You Button dropdowns use a 0.9 label and the rest of the row. Praise Delay and Return the Favor's seconds pair their dropdown with the toggle that enables it, sized to the label width, instead of a label. `ns.DefineSecondsSelect` shows the nearest value on `Data.SECONDS_CHOICES` (a Fibonacci scale, always labelled in seconds through `ns.FormatDuration`'s `forceSeconds`) without rewriting the stored one, because AceConfig draws a select whose value is missing from `values` as an empty box.

`ns:OpenOptionsPanel` backs `/tftb`. It routes by the **category ID captured from `AddToBlizOptions`**, never by panel title, and falls back to `AceConfigDialog:Open` only where `Settings.OpenToCategory` or the id is missing; Common Pitfalls says why.

## Reaction Sources: Combat Log vs Cast Events

Why the same feature set reads three different event streams:

- **Buffs on you (Stranger Buffs, Teammate Buffs)** ride the combat log. `SPELL_AURA_APPLIED` and `SPELL_AURA_REFRESH` say a buff landed and on whom; a teammate row with `detect = CAST` rides `SPELL_CAST_SUCCESS` and a `RESURRECT` row rides `SPELL_RESURRECT`, with the destination checked as you.
- **Group services (feasts, soulwells, portals, summons, repair bots)** ride `UNIT_SPELLCAST_SUCCEEDED`, *not* the combat log. These utility casts do not reliably emit `SPELL_CAST_SUCCESS` there, but they do fire the unit event for any unit the client tracks. A service has no per-you destination, so crediting the casting unit is all that is needed. Because the event's reach (target, focus, nameplates) is far wider than the feature's, the caster must pass `UnitInParty` / `UnitInRaid`, and `UnitIsPlayer` drops group pets; otherwise a stranger opening a portal across a capital city announces as a service.
- **Good News (buffs you cast on others)** rides `UNIT_SPELLCAST_SENT` plus `UNIT_SPELLCAST_SUCCEEDED`. The combat log is scoped to you, your group, and units in combat, so buffing a player *outside* your group produces no `SPELL_AURA_APPLIED` at all, and that is the most common case for this feature. `SENT` is also the only event that names the recipient; `SUCCEEDED` confirms the cast went off, so an interrupted cast stays silent.

On Forever, **buffs on you** ride `UNIT_AURA` instead (`OnUnitAura`). Only newly added helpful auras count, a full update is ignored, and nothing is read in combat, so a buff that lands mid-fight, or a recast of one you already hold, is not seen. Only the aura lookup is consulted, so a `CAST`-detect teammate row can never fire there. `ResolveAuraCaster` credits the aura's `sourceUnit` when it carries one; when it doesn't (a stranger out of nameplate range), it reads the caster with `C_UnitAuras.GetAuraCasterGUID` and names them with `UnitNameFromGUID`, appending the realm (spaces removed) for a cross-realm whisper. A caster in your party or raid goes to `HandleTracked` (services excluded); any other player goes to `HandleStrangersBuff`. A stranger held by a unit token must pass `UnitIsFriend` with a plain true. A stranger known only by GUID can't be asked, and doesn't need to be: the other faction can't put a helpful buff on you.

The one deliberate crossover is the `RESURRECT` detect mode. Goblin jumper cables and Defibrillate report `SPELL_CAST_SUCCESS` on every jolt, revived or not, so a Good News record for one of those casts is *parked* at `SUCCEEDED` instead of announced, and only the `SPELL_RESURRECT` a working jolt produces releases it (`ns.ClaimPendingResurrect`, matched on recipient and spell, since the combat log carries no cast GUID). A jolt that revives nobody is swept by `PENDING_TTL` and stays silent. Forever has no `SPELL_RESURRECT`, so no `RESURRECT` row exists in `Data/Camelot/`.

## Good News

Good News whispers the player *you* just buffed to tell them what they got and, when the number is short enough to act on, how long it lasts. It is the only feature driven by your own casts.

The whisper is assembled from a player-editable template holding one token:

```
Template   You have %a
Sent       {rt1} You have [Power Infusion] for 15 Seconds // TFTB
```

`%a` carries the whole ability phrase, link plus optional duration clause (`GOOD_NEWS_DURATION_CLAUSE`). Folding the duration into the token instead of exposing a second placeholder lets one template cover both cases: a one-shot cast with nothing to report leaves no dangling clause, so the template needs no conditional. Substitution is `gsub` with a replacement **function**, never `string.format`: the template is user-editable, so a stray `%` would otherwise raise an error mid-whisper, and a `%` inside a spell link would be read back as a capture reference. The marker, the closing-punctuation trim, and the ` // TFTB` sign-off are added by `ns:BuildGoodNewsMessage` and are deliberately out of reach, because they are how a recipient recognizes where the whisper came from.

The edit box caps at 120 bytes (`MESSAGE_MAX` in `Options/Options-Send-Good-News.lua`) through `ns.TrimToBytes`, and emptying it restores the default rather than sending a sign-off with nothing before it. Because `%a` may appear more than once, the finished line can still pass 255 bytes, so `ns:BuildGoodNewsMessage` falls back in two steps: first to `DEFAULT_GOOD_NEWS`, then to the default without the duration. It never truncates, because a cut can land inside a link.

Because `SENT` and `SUCCEEDED` carry the **cast** id, `givenLookup` is keyed by cast id, and each record carries `watchedId` (the id the panel toggle and the settings list use) and `auraId` (the id to read the recipient's remaining duration with). `auraId` is set only for an `AURA`-detect row without `noDuration`. A message ends up without a duration clause in exactly three ways, and only the last looks at a real timer:

1. **No aura to read.** Any `CAST` or `RESURRECT` row (Rebirth, Lay on Hands, jumper cables) carries no `auraId`. Settled at login, in `BuildLookups`.
2. **`noDuration`.** An aura spent by an event rather than by time (Fear Ward, Misdirection, Tricks of the Trade, Intervene) also carries no `auraId`. Also settled at login.
3. **A minute or longer.** `GOOD_NEWS_MAX_SECONDS` (60) in `Features/Announcements.lua`. "for 15 Seconds" is a cue to use it now; "for 10 Minutes" is a number nobody paces themselves off, and it pushes the ability name further from the front of a one-job whisper. Checked per cast, on the value read off the recipient.

A secret aura or recipient on Forever also yields no clause, since the duration is never read. The cap is compared against the duration **pre-rounded** the way `FormatDuration` would round it, so a 59.7s aura is tested as the "60 Seconds" it would print as. Good News has no *lower* bound; the `minBuffDuration` floor (default 21s) belongs to Stranger Buffs alone.

"Your own cast" includes your **pet's**. Roar of Sacrifice and Battle Squawk are cast by the pet and never by the player, so `UNIT_SPELLCAST_SENT` registers for `player` and `pet`. Recipients are resolved by name back to a unit token (`ResolveUnitByName`: target, mouseover, focus, then party or raid members, matching the full or the short name and skipping secret identities), which proves the recipient is a player rather than a pet and gives something to read the duration off later. A name that resolves to nothing is dropped, never guessed at. `scope` decides who qualifies: `ALWAYS` whispers anyone you buff, and anything else means group members only, with unrecognized values failing closed into the group check (the dropdown shows any stored value but `ALWAYS` as Group). The switch, the watched list and the scope are all decided at `SENT`; `SUCCEEDED` only releases what `SENT` vetted.

Four timing constants shape the flow:

- `AURA_SETTLE` (0.1s, `Features/Good-News.lua`). The aura lands a beat *after* the cast succeeds, so `AnnounceGivenCast` waits before reading the duration, re-checking that the unit still holds the recipient's GUID.
- `PENDING_TTL` (15s). A `SENT` whose `SUCCEEDED` never arrives, or a parked resurrect that never took, is swept from `pendingGiven`. The sweep runs on the next `SENT` or resurrect claim, not on a timer.
- `GOODNEWS_DEDUP` (10s). A quick recast on the same person does not whisper twice.
- `WHISPER_GAP` (0.35s, `Features/Announcements.lua`). The whispers are **queued, not sent inline** (`QueueWhisper`), so a run of them cannot burst into the server-side chat squelch, which drops whispers silently. `SENT` names one recipient, so one cast yields at most one whisper; the queue spaces whispers from separate casts. An empty queue still sends immediately, so the common case feels instant.

Durations render through the client's own localized `D_HOURS`, `D_MINUTES` and `D_SECONDS` templates, so the units are correct in every language without TFTB shipping copies. Those templates carry a `|4singular:plural;` escape that `SendChatMessage` rejects outright, so `ResolvePlurals` expands it to plain text first, with a three-form rule for Slavic locales. With the cap in place no whisper reaches `FormatDuration`'s minute or hour rung, but the ladder stays, because the helper formats whatever it is handed and the Praise Delay, Refresh and Return the Favor dropdowns label themselves with it.

## Buff Duty (the Buff Window)

Buff Duty is a click-to-cast window listing who is missing a buff *you* can give: your own self buffs and weapons, your target, strangers who just buffed you, and each party of your group. It shows only while someone needs something, so a fully buffed raid shows no window at all. It is self-only and on by default.

### Files and Shared State

The six logic files share state through one table, `ns.BuffWindow`, which `Features/Buff-Window-Castable.lua` creates. They capture its fields as locals when they load, so the TOC order (`Buff-Window-Frame`, `Buff-Window-Castable`, `Buff-Window-Units`, `Buff-Window-Self`, `Buff-Window-Outsiders`, `Buff-Window`, `Buff-Window-Keys`) is load-bearing. The fields that are replaced rather than refilled (`soulstoneEntry`, `soulstoneBuff`, `resurrection`, `refreshSeconds`, `isSetUp`) are the exception: every reader looks them up on `ns.BuffWindow` at the time.

- **Castable** turns this client's data into `entries` (one per row with a live single-target id), `selfEntries`, `weaponEntries`, `weaponItemEntries` and `soulstoneEntry`, plus the `exclusiveIds` family sets and `weaponByEnchant`; works out what this character can put up right now (`buffs`, `selfBuffs`, `weaponBuffs`, `soulstoneBuff`, `resurrection`); seeds the per-buff settings; and picks ranks.
- **Units** reads one unit: the aura cache, `Has`, `Wants`, roles, range, row labels, icons, pets, and the group's member list.
- **Self** builds the Self-Buffs section: self buffs, the poison, imbue, oil, stone or lure on each weapon, and the Soulstone. It owns `REPLACE_ENCHANT`.
- **Outsiders** builds the Return the Favor and Target sections.
- **Buff-Window** builds the party sections (`BuildSections` assembles all of them, for the window and the keys alike), owns the refresh, its events, and setup.
- **Keys** owns the two Buff Keys, which cast from the same sections the window draws, through two secure buttons of its own.
- **Frame** loads before `ns.BuffWindow` exists and never reads it. It draws the plain section tables the others build, and owns range, cooldown swipes, the redraw signature and `SPELL_UPDATE_COOLDOWN`; the other files reach it only through `ns.RenderBuffWindow`, `ns.HideBuffWindow`, `ns.ApplyBuffWindowSettings`, `ns.SetBuffButtonAttributes` and `ns.IsBuffSpecInRange`.

### Data

`Data/{Game}/Buff-Window-Spells-{Game}.lua` declares eight tables. One row from each, as Classic Era has them:

```lua
-- ns.BUFF_WINDOW_SPELLS
{ class = "MAGE", single = { { 1459, 1 }, { 1460, 14 }, { 1461, 28 }, { 10156, 42 }, { 10157, 56 } },
  group = { 23028 }, manaOnly = true, default = ALL }, -- Arcane Intellect
-- ns.BUFF_WINDOW_PET_ICONS
beast = 883, demons = { [416] = 688 }, -- Call Pet; Imp -> Summon Imp
-- ns.BUFF_WINDOW_SELF_SPELLS
{ class = "MAGE", ranks = { { 6117, 34 }, { 22782, 46 }, { 22783, 58 } }, exclusive = MAGE_ARMOR, default = 5 }, -- Mage Armor
-- ns.BUFF_WINDOW_WEAPON_ENCHANTS
{ class = "ROGUE", items = { { 5237, 24, 35 }, { 6951, 38, 23 }, { 9186, 52, 643 } } }, -- Mind-numbing Poison
-- ns.BUFF_WINDOW_WEAPON_HANDS
ROGUE = { MAIN, OFF_HAND }, SHAMAN = { MAIN },
-- ns.BUFF_WINDOW_WEAPON_ITEMS
{ 2862, 1, 40, 33219, STONE, 5 }, -- Rough Sharpening Stone
-- ns.BUFF_WINDOW_SOULSTONE
class = "WARLOCK", create = { { 693, 18 }, ... }, auras = { 20707, ... }, items = { 5232, ... }, default = MISSING,
-- ns.BUFF_WINDOW_RESURRECTIONS
{ class = "PRIEST", ranks = { 2006, 2010, 10880, 10881, 20770 } }, -- Resurrection
```

- **`ns.BUFF_WINDOW_SPELLS`** rows carry `class`, single-target ranks as `single = { { spell id, level learned } }`, bare `group` and `greater` id lists, an optional `exclusive` family, `manaOnly` / `noCasters` filters, and a `default` audience from `Data.BUFF_AUDIENCE`.
- **`ns.BUFF_WINDOW_PET_ICONS`** maps a warlock demon's creature ID (read out of the pet's GUID) to its summoning spell, and gives every other pet `beast` (Call Pet). A `demons` row also marks that pet as a warlock's (`PetOwnerClass`).
- **`ns.BUFF_WINDOW_SELF_SPELLS`** rows carry `class`, `ranks` as `{ spell id, level learned }`, an optional `exclusive` family, optional `auras` (the buffs a cast leaves when they aren't its own id: Demonic Sacrifice's, Soul Link's 25228), an optional `needsPet` (Soul Link asks only with a living pet out, `HasPet`), and a `default` from `Data.SELF_REFRESH_CHOICES`.
- **`ns.BUFF_WINDOW_WEAPON_ENCHANTS`** rows are a shaman imbue (`class`, `ranks` as `{ spell id, level learned, enchant id }`, where the enchant id may be a list when one rank lands several, as TBC's Rockbiter does per weapon speed, and `duration` in minutes) or a rogue poison (`class`, `items` as `{ item id, level required, enchant id }`).
- **`ns.BUFF_WINDOW_WEAPON_HANDS`** names the hands each class is asked about: a Classic Era shaman can't dual wield, a TBC or Season of Discovery one can.
- **`ns.BUFF_WINDOW_WEAPON_ITEMS`** is every other temporary weapon enchant, for any class (oils, sharpening stones, weightstones, fishing lures), each a positional `{ item id, level required, enchant id, weapon types, kind, item level }`. Weapon types is the item spell's weapon-subclass mask from SpellEquippedItems (0 for any weapon but a fishing pole); kind (`OIL`, `STONE` or `LURE`, in `Data.WEAPON_ITEM_KINDS` order) is the Weapon Buffs panel box it is listed in; a lure is main hand only (`Data.WEAPON_ITEM_KIND_HANDS`: a fishing pole is always two-handed). Item level (ItemSparse) ranks it, strongest first, in that box and in the window, since every lure and some oils need level 0.
- **`ns.BUFF_WINDOW_SOULSTONE`** is the one Soulstone row: its Create Soulstone ranks, its Soulstone Resurrection auras, its stones lowest first, and a `default` showing time.
- **`ns.BUFF_WINDOW_RESURRECTIONS`** lists each class's resurrection ranks as bare ids (priests and paladins only), for the Buff Keys; `BuildBuffs` keeps the first one you know as `BuffWindow.resurrection`, cast by its bare name.

Only ids are stored; names and icons come from the client.

At setup `BuildLookup` keeps the spell ids `C_Spell.DoesSpellExist` confirms, keys each entry by its first *live* single-target (or rank) id, and folds the single, group and Greater ids into one `auraIds` set, since any version on a target counts as buffed. Item ids (poisons, weapon items, stones) are not checked against the client: an item it doesn't know is one no bag ever holds. An imbue row with no live rank is dropped, and `soulstoneEntry` needs both a live Create rank and a live aura. `BuildBuffs` (at setup, on `SPELLS_CHANGED` after setup, and through `ns.RefreshBuffWindow` on every setting and profile change) keeps your class's rows whose audience is set and not `OFF` and that you know a single-target rank *or* the group version of, sorts the known single-target ranks by learn level, and records the group version by the first known id. A buff you know only the group version of gets no single-target icons, only party group icons. Each buff gets a `column`, shared by its single and group icons so a party's group buff sits over the single one it replaces.

### Refresh

Every trigger funnels into `ns.RequestBuffWindowRefresh`, which runs one `Refresh` 0.3 seconds after the first request and folds every request inside that window into it (long enough to fold a raid-wide buff landing on 40 people into one redraw). The triggers:

- `UNIT_AURA` for a unit the window reads (`player`, `pet`, `target`, `targetpet`, `party*`, `raid*`, `partypet*`, `raidpet*`), which marks that one GUID dirty. It is ignored before setup, in combat, with the feature off, with nothing to offer, or for a secret unit token.
- `GROUP_ROSTER_UPDATE`, `UNIT_PET`, `PLAYER_TARGET_CHANGED`, `SPELLS_CHANGED` and `PLAYER_REGEN_ENABLED`, which mark every record dirty.
- `UNIT_INVENTORY_CHANGED` for the player and `BAG_UPDATE_DELAYED` (a weapon enchant, a weapon swap, a poison or Soulstone used up), which redraw without marking anyone dirty.
- Every Buff Duty setting and every profile change (through `ns.RefreshBuffWindow`), a stranger buffing you (`ns.NoteFavor`), and a 3-second backstop ticker.

The backstop exists because no event reaches the window when a buff runs down under the threshold, or when a member dies, revives, or drops offline. It is skipped in combat or with the feature off.

`Refresh` returns without touching the window before setup and in combat. Otherwise it hides the window when the feature is off, nothing is castable, or `ns.AreAurasSecret()` is true, and builds sections in display order (Self-Buffs, Target, Return the Favor, each party). No sections means hide.

Aura reads go through a cache keyed by GUID, so an aura change reported on any of a player's tokens marks the one record. `MarkAurasDirty(unit)` flags one GUID, or falls back to marking everything when the GUID is nil or secret; `MarkAllAurasDirty` (roster, pet, target and spell changes, end of combat, every setting or profile change, every Buff Key press) bumps a generation counter and drops every record not read since the last bump, so the cache holds only players the window still looks at. A record also re-reads when its unit has died, revived, or changed connection since the read, which is what lets the backstop redraw without re-reading anyone else: a buff running low needs no re-read, since `Has` compares the cached expiration with the clock. A raid's aura traffic therefore re-reads only the members it touched. A unit whose GUID can't be read gets a scratch record read fresh every time.

`ReadAuras` walks `C_UnitAuras.GetBuffDataByIndex(unit, i, "HELPFUL")` up to 40 and records each aura's expiration, duration, and whether it is yours (`sourceUnit == "player"`). A secret expiration or duration is stored as 0, which `Has` reads as "no timer", so the buff counts as had. `Has` reads the record the *last* `ReadAuras` call selected, so it must follow a `ReadAuras` of the same unit.

### What Counts as Missing

`Has(buff, unit)` decides, after `ReadAuras(unit)`:

- **Running low counts as missing.** The threshold is the buff's own `refreshSeconds` when it has one (each self buff and the Soulstone, from `selfRefresh`), and otherwise `refreshMinutes` (3, 5 or 10; default 5) for every buff you give others, single-target and group alike. A buff with no timer never runs out, and one whose whole duration is no longer than the threshold counts only once it is gone; otherwise a 10-minute Thorns under a 10-minute setting would read as missing the moment it landed, forever. Weapons never go through `Has` (see Self-Buffs, below).
- **A lower rank counts as missing.** A single-target rank below the one you would cast on that unit does not satisfy the check, so a stranger's Rank 2 Arcane Intellect doesn't hide your Rank 5. The same holds for self buffs against your own level, so an old rank still up reads as missing after you learn a new one. Group and Greater versions always count, any Soulstone counts, and when the target is too low for any rank the comparison is skipped.
- **Exclusive families.** A buff with `exclusive` also counts as had when the unit carries *another of yours* from the same family (the aura's `sourceUnit` is `player`), even one running low: casting this one would replace yours rather than add to it. With none of yours on them, every one you turned on is offered. The families are `BLESSING` for paladin blessings and, for self buffs, `ASPECT`, `MAGE_ARMOR`, `PALADIN_AURA`, `SHAMAN_SHIELD`, `WARLOCK_ARMOR` and `WARLOCK_DEMON` (Demonic Sacrifice and Soul Link). `exclusiveIds` is one table for both data tables, so a family name must never be reused across them.

`Wants(buff, class, role)` decides who is offered a buff at all: `manaOnly` skips `Data.NO_MANA_CLASSES`, `noCasters` skips `Data.CASTER_CLASSES`, and a Tanks or Healers audience needs the matching role. `RoleOf` takes the raid's Main Tank mark first, then the group-finder role (an assigned `DAMAGER` counts too), then (for the player only, with no role assigned) the roles ticked in the group finder's listing via `GetLFGRoles`, Tank first, then Healer, if ticked; anyone with none of these is a `TANK` when Count as Tanks (`tankWhen`, keyed by class token, each `NEVER`, `SOLO` or `ALWAYS`) says their class is right now, and otherwise `DAMAGER`. The classes that can fight in melee (druids, paladins, rogues, shamans, warriors) and pets start on `SOLO`, and a class with no entry reads `NEVER`. An actual role always beats the class setting, and the role icon on each row follows the same answer. Each group API is looked up by name, so a client without one falls through to the next answer.

### Ranks and Casting

`RankFor(buff, level)` returns the highest known rank whose learn level is within 10 of the target's level (`RANK_LEVEL_GAP`); casting higher fails with "Target is too low level", and a target too low for any rank gets no icon. An unknown level (a stranger out of sight, or `UnitLevel`'s -1) takes the top rank.

Buttons cast a single-target buff by its rank text, `Power Word: Fortitude(Rank 2)`, which the secure template passes to `CastSpellByName`. A bare name casts your highest rank and fails on anyone too low for it; a spell ID goes to `CastSpellByID`, and on Classic Era a lower rank's ID casts nothing. Group buffs pass the bare name. Target, party and pet icons cast at their unit token. Every Return the Favor icon runs a macro instead, even when the stranger is momentarily your mouseover or focus, because a stranger has no unit token that lasts:

```
/targetexact Kiib
/cast [help] Arcane Intellect(Rank 5)
```

The macro uses the stored full name (`Name-Realm` across realms); the row label uses the short one. `[help]` stops the cast if the name isn't found, so it never falls through to your current target or yourself. Leaving the stranger targeted is deliberate: it is how the window sees the buff land and drops the icon.

### Sections

- **Self-Buffs.** Skipped entirely while you are dead or a ghost. Your self-only buffs (`selfEnabled`), as icons on the header, in their own grid (`grid = "self"`). Each self buff's `selfRefresh` is Off, When Missing, or 10, 5 or 3 minutes left. The Soulstone follows them on the header, also behind `selfEnabled`, and your weapons (`weaponEnabled`, their own switch) are rows under it; the header stands with weapon rows alone:
  - **Weapons.** A row per hand, flush with the header (`row.indent`), labelled with the equipped weapon's icon and the client's `INVTYPE_WEAPONMAINHAND` or `INVTYPE_WEAPONOFFHAND`, holding the poisons, imbues, oils, stones or lures it needs. Each hand's row has its own grid (`row.grid`, `weaponMAIN` or `weaponOFF`), so its icons start at the left. `SortWeaponIcons` orders a hand's icons as the row is drawn: your class's poisons or imbues first, then the weapon items, each by the level of what it uses (a poison's required level, an imbue rank's learn level, an oil's, stone's or lure's item level), highest first, ties by id, so Instant Poison IV (44) sits left of Deadly Poison II (38) and Solid Sharpening Stone left of Rough. Every choice is ticked or not per hand (`weaponPicks`, keyed `ROGUE_MAIN` and so on, then by the row's first id; the weapon items in `weaponItems`, keyed `MAIN` or `OFF`, then by item id), read through `BuffWindow.WeaponChoiceOn`, which counts one never set as ticked, and every ticked one is a pick. All of them share one timing, `weaponRefresh` (When Missing or minutes left, from `Data.WEAPON_REFRESH_CHOICES`), checked through `PickHolds`. `GetWeaponEnchantInfo` gives the time left and, on clients that return four values per hand rather than three, the enchant id; `ReadWeaponEnchants` works out which by counting the returns. Every poison item, imbue rank and weapon item in the data carries the enchant id it puts on (each pick's `enchants` set; two items can share one), so `PicksToOffer` knows which pick a weapon holds. A weapon holding one of its picks with time enough left shows nothing; one running low shows just that pick, to top it up; a bare weapon, or one holding something not picked, shows every pick, and the player chooses. A client that names no enchant lets any enchant count, held to the most lenient pick. An imbue row carries its whole `duration` (5 minutes on Classic Era, 30 on TBC, 60 on Forever), and one no longer than its timing counts only once it's gone, as in `Has`. A hand shows only when its slot holds a weapon (not a shield or an off-hand item), and a pick only when it takes on that weapon (`PickFits`, a `bit.band` of the mask against the weapon's subclass): a sharpening stone wants an edge, a weightstone a blunt weapon, a lure a fishing pole, and a poison, an imbue or an item naming none takes any weapon but a fishing pole. A poison or weapon item icon uses the best item of the pick in your bags that your level allows, with `target-slot` set to the hand's slot: the secure template picks that weapon once the item leaves the cursor waiting on one. An imbue can't be pointed at a weapon: it goes on the main hand, unless the main hand has an enchant and a bare off-hand weapon is waiting. So only the hand the next cast lands on is offered, and an off hand running low waits until it's gone, since casting then would replace the main hand's. The Buff Keys pass every weapon icon by: putting one on is a click on the window.
  - **Replacing an enchant.** Putting a pick on a weapon that holds another enchant raises the game's "replace your enchant?" popup. Every weapon icon sets `confirmReplace`, so its left-click `PreClick` calls `ns.ExpectReplaceEnchant` (it has to be `PreClick`: the secure click raises the popup before `PostClick` runs). `REPLACE_ENCHANT` within two seconds (`REPLACE_WINDOW`) of that is accepted with `C_Item.ReplaceEnchant()`, and the `REPLACE_ENCHANT` popup is hidden at once and again on the next frame, since it may open before or after the event.
  - **Soulstone.** While no buffable member of your group carries a Soulstone Resurrection aura with more left than the Soulstone's own `selfRefresh` (When Missing by default), one icon: the best stone in your bags, used on a group member whose role is Healer (one in range first, else the first healer), or on you with no healer or no group. Healer here is `RoleOf` without a class: the Main Tank mark, an assigned role or the group-finder listing, never Count as Tanks. With no stone in your bags, it casts your best Create Soulstone by its bare name. The item's own cooldown shows on the icon.
- **Target** (`targetEnabled`). A targeted player outside your group (`UnitCanAssist`), with their pet (`targetpet`) under them; or a targeted outsider pet as one row named "Pet (Owner)". The owner's name comes from the pet's tooltip (`ns.GetUnitTooltipLines`: `C_TooltipInfo.GetUnit` on Forever, a hidden scan tooltip elsewhere), matched against patterns built at first use from the client's `UNITNAME_TITLE_PET`, `_MINION`, `_GUARDIAN`, `_CREATION`, `_CHARM` and `_COMPANION`, so it reads every locale; the owner's class comes from the pet first (`PetOwnerClass`: a known demon is a warlock's, a Focus pet a hunter's) and from the tooltip wording only as a fallback.
- **Return the Favor** (`favorEnabled`). Strangers who just buffed you, fed by `ns.NoteFavor` from the stranger path (combat log, or `UNIT_AURA` on Forever). Each is kept `favorSeconds` (20, 40 or 60) from their latest buff, at most `Data.BUFF_WINDOW_FAVOR_MAX` (5) at once with the oldest evicted, newest first. A favor is dropped, when the section is next built, once they join your group, once they need nothing more, or on right-click of any of their icons (`ns.DismissFavor`, which the icon's tooltip hints at). Out of sight their auras can't be read, so a `given` set remembers what was seen on them while readable; it is never cleared for that favor's lifetime.
- **Parties.** In a raid, one section per subgroup (`GetRaidRosterInfo`, labelled with the client's `GROUP_NUMBER`); otherwise you and your party as one (`GROUP`). A party's group-buff icon appears once any member misses that buff and you are grouped; solo there is none, since the single version does the same for no reagent. The group icon targets the first missing member in range (`PickGroupTarget`). A member's pet sits indented under them and keeps the member listed until it is buffed too; a dead or offline owner still gets a label-only row when their pet needs something. A pet takes buffs for Everyone, Tanks buffs only while Count as Tanks' Pets row applies (`tankWhen.PET`, `SOLO` by default), never Healers buffs; `manaOnly` is read off its power type, so a demon gets Intellect and a beast doesn't. Pets never count toward a group icon.

Target claims a player before Return the Favor, so each outsider is listed once and the list you asked for by targeting never loses them. There is no "players in range" list: the game reveals nearby players to add-ons only through friendly nameplates, which most players leave off.

### Frame

`Features/Buff-Window-Frame.lua` stacks two frames so combat visibility and the add-on's own never fight: the `anchor`, clamped to the screen at MEDIUM strata, belongs to the Hide in Combat state driver while `hideInCombat` is on (otherwise the driver is unregistered and the anchor shown), and `content` (the backdrop, labels and buttons) is shown and hidden by the code, out of combat only. Buttons and labels are pooled; `SetIcon` hands every spec to `ns.SetBuffButtonAttributes`, which writes `type1`, `spell`, `item`, `unit`, `target-slot` and `macrotext` on every use, nil included, because a pooled button still carries its last spec. Buttons bind only `type1`, so a right-click casts nothing and is free for dismissing a favor, and they register `AnyUp` and `AnyDown` because the secure template acts on whichever `ActionButtonUseKeyDown` names.

`ns.RenderBuffWindow` builds a signature string of everything a redraw would write (column, cast text or item, unit, `target-slot`, macro text, labels) and skips the redraw when it is unchanged, which is the usual result of a raid's aura traffic. `ns.ApplyBuffWindowSettings`, run on every setting and profile change, clears it so those always redraw. Layout is two passes: every label is measured first, because the icon column starts where the longest name ends (clamped to 80 to 260 pixels). Icons sit in a grid with one column per buff, keeping only columns some icon uses, so a buff lines up down the whole window and a buff nobody needs leaves no gap. A row or section can name its own grid (Self-Buffs and each weapon hand's row do), so its icons start at the left whatever the rest holds. The sections before the parties run across the top; the parties (marked `party` by `AddGroupSections`) go under them in columns of four (`PARTIES_PER_COLUMN`), filled in order, so a fifth party showing starts a second column, `COLUMN_GAP` (16) pixels past the first, and a full raid stands four groups high instead of running off the screen. Every party column shares the main grid and starts level, and the window is as tall as its tallest column. Icons are `Data.BUFF_WINDOW_ICON_SIZE` (20) pixels.

Out-of-range icons fade to 0.35 alpha on a 0.5-second ticker that runs only while the window shows (`ns.IsBuffSpecInRange`: `C_Item.IsItemInRange` first for an item aimed at another unit, then `ns.IsBuffInRange`, which counts you and a unitless favor as in range, then rules out a pet in Phase Shift, `ns.GAME_IDS.PHASE_SHIFT_SPELL_ID`, which can't be targeted however close it stands, then asks the spell's own range check, then `UnitIsVisible` plus a checked `UnitInRange`; an unknown or secret answer reads as in range, since a wrong "out of range" would hide a castable buff). Each button's `CooldownFrameTemplate` child draws the action-bar swipe on `SPELL_UPDATE_COOLDOWN` and on every render, with its countdown font set to `GameFontHighlightSmallOutline` because the template is sized for a 36-pixel button. A title bar tops `content`: "TFTB // Buff Duty" in the print prefix's colors, and a `UIPanelCloseButton` whose script is replaced with `ns.CloseBuffWindow` (the template's own hides its parent, which the secure icons make protected). Closing turns Buff Duty off through `ns.SetFeatureSwitch` and prints how to turn it back on, since the window would otherwise reopen on the next roster or aura change; in combat it stays up until combat ends. The close button is centered over the far-right icon column, and a list too short to fill the title bar widens its name column instead, so the icons slide right until the last column sits under the X. The window drags by `content` with the left button, unless `locked` or in combat. The position is saved as the anchor's top-left corner in `buffWindow.point`, so a window that grows or shrinks keeps its top edge where the player put it; until first dragged it sits a little left of and above center.

### Buff Keys

`Features/Buff-Window-Keys.lua` gives Buff Duty two key bindings modelled on Pally Power's auto-buff keys. `Bindings.xml` (loaded by the client on its own, not from the TOCs) declares `CLICK TFTBBuffIndividual:LeftButton` and `CLICK TFTBBuffGroup:LeftButton` under the AddOns category; the file names them through `BINDING_HEADER_TFTB` and `BINDING_NAME_CLICK ...`, and the Buff Duty panel's Keybinds rows bind the same commands (`ns.BUFF_KEY_COMMANDS`): each first unbinds every key the command held, then calls `SetBinding` and `SaveBindings`, and is disabled in combat. A macro presses the same buttons with `/click TFTBBuffIndividual` or `/click TFTBBuffGroup` (`ns.BUFF_KEY_MACROS`, shown under each row), as Pally Power's macros click its buttons. There is no `/tftb` command for it: an add-on's slash command runs insecure code, which can't cast.

Each command clicks a hidden `SecureActionButtonTemplate` button. Casting from a key press is protected, so the pick happens in `PreClick`, out of combat only: it marks every aura record dirty, calls `BuildSections`, walks the result in priority order, and writes the first castable icon's attributes onto the button with `ns.SetBuffButtonAttributes`, the writer the window's own icons use. The template then casts it, and `PostClick` clears every attribute out of combat. A press does nothing with the feature off, auras secret, before setup, or while you are dead or a ghost.

- **Individual Buff Button:** a resurrection on your target if they are a dead (not released), connected, friendly player with none already incoming; then the Self-Buffs icons, weapons aside; then Return the Favor; then your target's icons (the whole Target section with its pet row, or any party icon aimed at your target); then every party row, party by party in subgroup order.
- **Group Buff Button:** the same resurrection and Self-Buffs; then the group-buff icons of your target's party; then every other party's. A group icon carries `members`, the units missing that buff, and is skipped while any of them is out of range (`ns.IsBuffInRange` with the group spell), so a cast never leaves someone needing a second reagent. Dead, offline and already-buffed members don't hold a party up.

A candidate is skipped while its spell or item is on a cooldown longer than the global one (a used Soulstone, Fear Ward), and while it is out of reach (`ns.IsBuffSpecInRange`). The global cooldown is anything at or under `GLOBAL_COOLDOWN` (1.5 seconds), by the exception in `README-Notes.md`. One the client refuses for a reason other than mana (no reagent, no Soul Shard) is passed over too, but cast anyway when nothing else can go and it is in reach, so the game's own error says why; an item is never "unusable", only ready or cooling down. With nothing to cast, the key shows "Waiting on <name> to get in range." for the first player it skipped for range, or "Nothing left to buff.", in `UIErrorsFrame`.

A key press reaches the button twice, down and up, but a macro's `/click` sends a single up click (`down` false unless the macro says otherwise). So the buttons set `useOnKeyDown` to false, and the template acts on the up half for both, whatever `ActionButtonUseKeyDown` says; left to the CVar, a key-down player's `/click` would cast nothing. The binding therefore casts on key release. Both halves write the attributes, so a client acting on the other half would still cast; only the up half remembers the cast and shows a message.

What it remembers is one `pending` record (a new press replaces it), held `PENDING_SECONDS` (15, long enough for a 10-second Resurrection) and matched by spell ID in `ns.OnBuffKeyCastSucceeded` against every rank the press could go off as (a group buff's group ids, a resurrection's ranks), for `player` casts only. Buff-Tracking's `UNIT_SPELLCAST_SUCCEEDED` handler calls it before the safety-timer gate. A matched cast keeps the key off that player and buff (or that party, for a group buff) for `BUFF_SKIP_SECONDS` (3), long enough for the aura to show, or `RESURRECTION_SKIP_SECONDS` (60) for a resurrection, the time its target has to accept. Skip keys are `<GUID>:<spell name>` or `party<n>:<spell name>`, by name so every rank shares one. A Return the Favor icon targets by name and can't tell a miss, so its key (`favor:<GUID>:<spell name>`, apart from Target's) is skipped for `FAVOR_RETRY_SECONDS` (30) from the press, cut to 3 when the cast goes off. Using a Soulstone item has no skip key and is never remembered.

## Per-Flavor Tracking Data

Each flavor TOC names its flavor in `## X-Flavor`, and `Data/Flavor.lua` turns that into `ns.FLAVOR`, `ns.EXPANSION`, `ns.IS_DISCOVERY`, and `ns.DATA_FOLDER`; code never works the client out for itself. Every flavor has its own complete copy of the data in `Data/{Game}/`, and each TOC lists only its own folder. The Vanilla TOC lists `Data/Vanilla/` then `Data/Discovery/`, and each file in that pair opens with a Season of Discovery guard so exactly one set of tables is built. A Classic Era change therefore usually lands in both files.

Rows carry no flavor columns: a row's folder says where it is true. `ns.TRACKED_ABILITIES` rows carry scalar `received` and `given` defaults, `ns.PEER_PRESSURE_ABILITIES` rows are positional, `{ "CLASS", { spell ids }, default }`, and Buff Window rows carry a `default` audience or showing time. Blizzard reuses spell ids across flavors for entirely different abilities (id `11958` is Ice Block on Era but Cold Snap on TBC; `12472` is Cold Snap on Era but Icy Veins on TBC), which `C_Spell.DoesSpellExist` cannot detect, so each folder carries only the rows whose ids mean that ability on its client. At login, ids that don't exist on the running client are dropped (a tracked trigger survives when either its cast id or its watched id exists) and an entry with none left is skipped, so a row the client lacks costs nothing.

## Peer Pressure

Peer Pressure alerts you when another player of your class in your group pops a tracked cooldown, so you can join in. `Features/Peer-Pressure.lua` builds a spell-keyed lookup from `ns.PEER_PRESSURE_ABILITIES`, and `ns.CheckPeerPressure` is called from the combat-log tap for every `SPELL_CAST_SUCCESS`, so only a cooldown that reports one can be tracked. Spells are class-locked, so "the caster is your class" needs no GUID inspection: the entry's class tag against your own is the whole test. The watched list is keyed by the exact id cast, each rank seeded on its own. It does not exist on Forever (see Event Loop).

Two filters matter. `IsGroupAffiliated` drops passers-by, because Era's combat log is proximity-scoped rather than group-scoped, so a paladin popping Lay on Hands across a capital city arrives exactly like a raid member's cast. And the `MINE` flag deliberately lets your own casts through to the Trigger on Own Casts check (`triggerOnOwnCasts`, default off), which owns that decision; this is also why the Peer Pressure tap sits *above* the own-source drop in `OnCombatLogEventUnfiltered`.

When the cast had a real player target other than the caster, the message names them ("Expektor used [Blade Flurry] on Sally!"); self-buffs and pet targets read as plain. The body renders in the caster's class color, the spell link keeps the standard link blue, and the target's name wears the target's class color. A closing `|r` resets the fontstring to white, so `ns:BuildPeerPressureMessage` re-opens the body color right after the link and after the target's name. Print and sound are independent toggles, and with both off nothing fires.

When an id appears in two rows, the lookup credits it to the last one, and `BuildCategories` renders it under that row only, so one id never draws two checkboxes.

## Thank You Buttons

`Data.THANK_YOU_BUTTONS` in `Data/Data.lua` is the whole feature. One row per button, holding the profile key it stores under, the macro it offers to create, the slash command that macro runs, and whether it picks one chosen emote or randomizes over a checklist:

```lua
{ profileKey = "slash", macroName = "- Thank", command = "/thankyou" },
{ profileKey = "slash2", macroName = "- TFTB 2", command = "/thankyou2", singleEmote = true },
```

Everything else is generated from that list: the defaults of buttons 2 and up in `Data/Default-Settings.lua` (button 1's `slash` defaults are written out by hand, since they are the on-by-default ones), the options sections in `Options/Options-Thank-You-Button.lua` (order numbers spaced a hundred apart per button), the slash registrations in `Options/Options.lua` (`SlashCmdList` keys `TFTB_THANKYOU<n>`), and the macros in `Features/Thank-You-Button.lua`. Nothing counts the buttons.

Button 1 keeps its on-by-default settings and its friendly default whisper. Buttons 2 through 5 ship fully switched off (no macro, no whisper text, no emote). An empty message sends no whisper and an empty emote token performs no emote, both by existing logic, so "off" needs no extra guard. All five macro names lead with a dash so the family sorts together at the top of the macro list. Unticking a button's Create Macro toggle collapses its whisper, emote and icon rows, but the typed command keeps working with the stored settings.

`singleEmote` changes the stored shape as well as the control: `emote` (one token, `""` meaning none) rather than `emotes` (a set). The single-emote dropdown is built from the **client's** emote catalog (`ns.GetEmoteCatalog`, read from the client's own `EMOTE<n>_TOKEN` globals up to `MAXEMOTEINDEX`, which are sparse and contain duplicates, so the scan neither stops at a gap nor keeps a repeat), not from the curated twelve in `Data.EMOTES`, so it offers precisely what this build can perform. `ns:DoEmoteToken` validates against that catalog before calling `C_ChatInfo.PerformEmote`, because a bad token is a silent no-op, indistinguishable from a broken button. A stored token this client lacks displays as "none" rather than blank, since profiles travel between flavors.

`ns.ReconcileMacros` brings every macro in line with the profile in both directions: create the enabled macros that are missing, give existing ones their picked icon, delete the disabled ones still there. It runs at login (through `ns:CreateAutoMacro`), on every profile change, when Create Macro is ticked, and on every Icon pick, so a profile switch moves the macros with it; unticking Create Macro calls `ns:DeleteAutoMacro` for that one button. A button with no stored settings is never deleted. The macro count (`GetNumMacros`) is re-read *inside* the loop against the account cap (`Data.MAX_GLOBAL_MACROS`, 120), because each macro this call creates counts against it. Deletion resolves the index from the button's exact name first, so the existence check and the delete agree on the same macro.

Each button's macro wears the icon its Icon dropdown picks. `macroIcon` stores a texture file ID: the macros' own icon, `Data.THANK_YOU_DEFAULT_ICON` (`inv_misc_ribbon_01`), or one of `ns.THANK_YOU_MACRO_ICONS` in `Data/{Game}/Game-IDs-{Game}.lua`. Those are twenty bold icons nobody keeps on a bar, each checked against wago.tools' `ManifestInterfaceData` to exist under the same ID on Classic Era, TBC Anniversary and WoW Forever. An icon has no name the client can give, and a name we typed would need translating, so the dropdown shows each one as its picture alone, in list order under Default. Button 1 starts on the default icon, and each of buttons 2 through 5 starts on the row whose second field names it, so the five macros tell apart on a bar. `ns.ReconcileMacros` gives an existing macro its picked icon through `EditMacro(index, nil, icon)`, which leaves the name and body alone as the game's own macro window does, and only while Create Macro is on. An icon this client's list lacks falls back to the default and shows as Default, since profiles travel between flavors. Like every macro change, a pick made in combat waits for the next reconcile.

`ns.RunThankYou` requires a player target that is not you, emotes at it, and whispers only when the target shares your faction and the message is non-empty. On Forever a target whose identity is secret still gets the emote (it only needs the `target` token) but no whisper. The whisper body is sent verbatim and is unbranded by design: a human-sounding message, without the marker or add-on name. Its edit box caps at `ns.CHAT_MESSAGE_MAX_LENGTH` (255 bytes) through `ns.TrimToBytes`, which steps back off a UTF-8 continuation byte so a cut never lands mid-character.

## Diagnostics

`Diagnostics/` is the house Diagnostic Tools framework, copied from Magic Eraser: five tabs (Run Tests, Settings, Code, Data, Localization) under a runtime-only enable gate, and a report runner that runs one report at a time, a frame apart, each inside a `pcall` so one that throws is written into the box and the run goes on. `ns.diagnostics` is runtime-only and never reaches SavedVariables; the one lasting write is the Run Tests Taint Log button's `taintLog` CVar. Strings live in `ns.DiagnosticsStrings` as plain English, mostly in `Diagnostics/Diagnostics-Core.lua`, and never go through `Locales/`; the one localized string they read is `ns.L["ADDON_TITLE"]`. The panel registers as its builder, so while the gate is off the tabs are left out of the table, and turning it off stops the event log and clears every report.

TFTB's own surface is mostly `Diagnostics/Manifests.lua`: the API rows (modern and legacy halves listed in pairs, so a FAIL on one half is expected), the context probes, the event-log decoders, `ns.IsCorrelatedMessage`, the name lookups, the message builders, `ns.DIAGNOSTIC_SPELLS`, `ns.DIAGNOSTIC_TRACKED`, and the data-source manifest (`ns.DIAGNOSTIC_DATA_SOURCES`, one row per data file: Tracked-Abilities, Game-IDs, Peer-Pressure-Abilities, Buff-Window-Spells). A data-source label must match its file name's prefix, since `ns.DataSourceFileName` builds `<folder>/<label>-<folder>.lua` from it. The event-log filter tables live in `Diagnostics/Event-Log.lua`, and Display Context in `Diagnostics/Settings-Reports.lua`. On WoW Forever a secret event argument logs as `<secret>`.

The Settings tab runs six reports, in this order:

- **Buff Reactions Context** answers "nothing happens when I get buffed": the player and profile, where `/tftb` routes, whether the buff engine set up and how buffs are detected on this flavor, whether that path is open now (the post-loading-screen pause, combat, Forever's secret auras), every panel's switches and picked emotes, watched counts, the praise throttles (through `ns.GetPraiseCooldownState`, which never stamps), the sound settings, the Good News template (default or custom, with its byte count) and per-spell state, live-versus-total tracked coverage (`ns.DIAGNOSTIC_TRACKED`), which tracked and Peer Pressure spells of your class you know and watch, and what stops each Thank You button, including a macro whose body was edited.
- **Buff Window Context** answers "the window never shows" or "it doesn't offer X": whether it set up, every setting, each gate `Refresh` checks (dead, anything to offer), every buff and self buff your class has here with its audience, known ranks and the rank and group version it would cast, your pet and your own self-buff state, each weapon hand (picks, items in bags, slot contents, enchant time left and the row it matches), the Soulstone, the Buff Keys' bindings, buttons and resurrection, the Return the Favor list, then every group member and your target with which of your buffs they have or miss. The group read is skipped in combat, as the window skips it.
- **Emote Extract** dumps every emote the running client can perform, read from its own globals, so each flavor's client produces its own list with no code change.
- **Saved Variables** dumps `TFTBDB`.
- **Display Context** reads the screen, UI scale, and the window's saved corner against the current screen, for "the window is gone".
- **Other Add-ons** lists what else is loaded.

The event log snapshots each argument to a string immediately, caps arg count and length (`EVENT_LOG_SIZE` 500, `EVENT_LOG_MAX_ARGS` 8, `EVENT_LOG_MAX_ARG_LENGTH` 255), and escapes pipes *after* truncation so a clipped argument cannot eat the next separator. `ns.DIAGNOSTIC_EVENT_EXCLUDE` drops three events outright: `COMBAT_LOG_EVENT_UNFILTERED` (a firehose), `UNIT_AURA` (its update table can't be logged as text), and `SPELL_UPDATE_COOLDOWN` (fires on every global cooldown and carries no id). In their place the buff engine writes decoded lines:

- `ns:LogCombatCast`, for every `SPELL_CAST_SUCCESS` and `SPELL_RESURRECT`, and every `SPELL_AURA_APPLIED` or `SPELL_AURA_REFRESH` on you (labelled `AURA`), once the safety timer has passed but before any of the engine's own filtering. An aura on you, and a cast or revive TFTB acts on (a tracked entry, a Good News buff, a Peer Pressure cooldown), logs in full with spell id and name, source, decoded affiliation and reaction flags, and `tracked` / `watched`; every other cast is counted by spell id in the summary (`ns:CountUncorrelated`), so a busy raid can't push the signal out of the 500-line buffer. Resurrects are labelled `REZ` rather than `CAST` so a failed jolt (a `CAST` with no `REZ` after it) shows by eye.
- `ns:LogAuraUpdate`, on Forever only, for each added helpful aura on you, with a verdict naming the first gate that stops it (`not ready`, `no db`, `in combat`, `auras secret`, `full update`) or `read`.

`ns.MESSAGE_ID_FILTERED_EVENTS` classifies two firehoses per firing instead: `UNIT_SPELLCAST_SUCCEEDED` (spell id, argument 3) and `GET_ITEM_INFO_RECEIVED` (item id, argument 1). A firing whose id `ns.IsCorrelatedMessage` recognizes logs in full: for a cast, an id in the cast or Good News lookups or any spell the Buff Window data names; for an item, a tracked item or any Buff Duty item (`ns.IsBuffWindowItem`: poisons, oils, stones, lures, Soulstones). The rest are counted, keeping the argument after the id as their text. A firing with no plain id there logs in full, and a secret one on Forever counts as `<secret>`. `UNIT_INVENTORY_CHANGED`, `BAG_UPDATE_DELAYED` and `REPLACE_ENCHANT` are in neither table, so they log in full.

The **Localization** tab holds **Locale Context**, **Game Names** and **Message Length**. Game Names has one row per record TFTB names by ID, from `ns.DIAGNOSTIC_NAME_LOOKUPS`: every `ns.GAME_IDS` spell, every class token the tracked, Peer Pressure, buff and self-buff data carry, the duration strings, the pet-owner tooltip formats, the Buff Window's group labels and hand names, `ERR_NOT_IN_COMBAT`, and the curated emote commands, each through the exact call the features make; it polls late-loading names and settles one still missing as NIL. Message Length builds every whisper and macro TFTB sends or writes from `ns.DIAGNOSTIC_MESSAGES`: the thank-you whisper carrying the longest `ns.GetBuffLink` this client's data holds, the Good News whisper carrying the longest Good News link with a 59-second clause (the longest it ever carries), each Thank You button's saved whisper (when not empty) and macro body, and a Return the Favor macro per single-target buff you can give right now, with a 12-letter name plus your realm. Each is printed against its 255-byte ceiling and flagged `OVER` past it. Nothing is sent and no macro is written; since the ceiling is in bytes, ruRU is the client to run it on.

The **Data** tab runs Validate Data per data file in batches, with each row's status (OK, NOT ON CLIENT, INCOMPLETE, ERROR, TABLE MISSING, NO TITLE, NO NAME). It flags a weapon enchant (poison item, imbue rank or weapon item) with no enchant id as ERROR, since the window could never see it on a weapon, and prints each spell's `SPELL_LEVEL_LEARNED` beside the data's learn level.

## Saved Variables

One account-wide table, `TFTBDB`, managed by AceDB-3.0, holding every setting the add-on has.

**Thanks for the Buff uses the Simple saved-variables model.** `AceDB:New` is called with `true` as its third argument, so every character on the account lands on the one shared `"Default"` profile and the whole database lives under `profile`. `global` is unused: nothing the add-on stores differs from character to character. **Reset Profile therefore clears everything, back to install defaults**, the Buff Window's saved position and the mini-map button's (`profile.minimap`, LibDBIcon's own table) included; `OnProfileChanged` calls `ns.RefreshMinimapButton` so the button follows the incoming profile. A new setting belongs in `ns.db.profile`.

The top-level keys of `profile`, regenerated from `Data/Default-Settings.lua`:

- **`showWelcome`**, the login welcome message.
- **`strangers`**, **`teammates`** and **`services`**, one buff panel each: its master switch, the print / whisper / emote / sound toggles, the emote checklist, and the Praise Delay pair. `strangers` alone adds `praiseCooldown`, `cooldown` and `minBuffDuration`.
- **`goodNews`**, holding `whisperEnabled` (its master switch), `scope`, the editable `message`, and its own `watched` list.
- **`peerPressure`**, holding its switches and its own `watched` list.
- **`buffWindow`**, holding the window's switches (`enabled`, `locked`, `hideInCombat`, `selfEnabled`, `weaponEnabled`, `favorEnabled`, `targetEnabled`), `refreshMinutes`, `favorSeconds`, `tankWhen` (Count as Tanks, keyed by class token and `PET`), `audience` (who each buff is offered to), `selfRefresh` (when each self buff and the Soulstone show), `weaponPicks` (each hand's poisons or imbues, keyed `ROGUE_MAIN` and so on), `weaponRefresh` (the one Reapply timing for every weapon buff), `weaponItems` (each hand's oils, stones and lures, keyed `MAIN` or `OFF`), and `point`, which is absent until the window is first dragged. The per-buff maps are keyed by a row's first id that exists on this client (a poison row by its first item id).
- **`watchedBuffs`**, the shared thank-you list behind Teammate Buffs and Service Alerts. Their ids never overlap, so one table is unambiguous.
- **`slash`** through **`slash5`**, the five Thank You buttons.

Good News keeps its own `watched` list rather than sharing `watchedBuffs` because it reuses the *same* teammate buff ids with independent choices: one table could not hold both "thank someone for it" and "announce it when I cast it".

AceDB applies `ns.DATABASE_DEFAULTS` itself when a scope is first accessed, copying scalar and table defaults into the saved table and never overriding an explicit user value, `false` included; there is no hand-rolled merge.

The per-id lists start empty in the defaults and are seeded from this client's data folder as settings maps:

- `PopulateWatchedBuffs` writes a boolean into `watchedBuffs` and `goodNews.watched` for every live id the list holds no value for, keyed by the watched id (the `aura` id for an `AURA` row, otherwise the cast id): `received` or `given` of 0 seeds off, anything else, or nothing, seeds on. Service rows never reach `goodNews.watched`, and `receivable = false` rows never reach `watchedBuffs`.
- `PopulatePeerPressureWatched` does the same from the Peer Pressure default digit (0 off, anything else on).
- `ns.PopulateBuffWindowAudience` seeds `audience` and `selfRefresh` (the Soulstone's from `ns.BUFF_WINDOW_SOULSTONE.default`) from each row's `default`, first dropping any stored value the dropdown doesn't offer, drops any `tankWhen` value not in `Data.TANK_WHEN`, and tidies the weapon settings: `weaponPicks` and `weaponItems` keep only true or false (unset reads as ticked, so nothing is seeded), and `weaponRefresh` falls back to `Data.WEAPON_REFRESH_DEFAULT` (3) when it isn't a choice.

A tick for an id this client has no row for is kept, so an Occult Poison ticked on Season of Discovery survives a Classic Era login. None of them touches a value the player set, and none prunes an id this client lacks, because Classic Era and Season of Discovery share one profile. A new data row therefore reaches existing players on their next login, and a list the player turned entirely off stays off. All three run at login and again on every profile change, copy, or reset (`OnProfileChanged` in `Features/Core.lua`), which also refreshes the Buff Window, reconciles the Thank You macros, and calls `NotifyChange` for every entry in `ns.OPTIONS_REGISTRY`.

### Migration Chain

- **`tankWhen.PET`** (`PopulateBuffWindowAudience`, `Features/Buff-Window-Castable.lua`, `MIGRATION (remove after 2026-11-18)`): 2026.10.19.A's `petsAsTanks` toggle and `petsAsTanksWhen` become `tankWhen.PET`; `petsAsTanks == false` becomes `NEVER`, `petsAsTanksWhen == "ALWAYS"` becomes `ALWAYS`, anything else keeps the `SOLO` default.

`TFTBDB` carries nothing over from the older `TFTB_DB` table by maintainer decision (`Features/Core.lua`), so an install from before the rename starts from defaults; no bridge is to be added.

## Adding a New Tracked Buff or Cooldown

`ns.TRACKED_ABILITIES` lives in `Data/{Game}/Tracked-Abilities-{Game}.lua`, one complete copy per flavor folder. A non-service entry is one checkbox on the Teammate Buffs and one on the Send Good News Tracked Abilities sub-panels (`receivable = false` drops the Teammate one); a service entry is one checkbox on Service Alerts.

1. Add an entry with its `class` (omit it for an item-driven row), `type` (`SOLO`, `GROUP`, or `SERVICE`), `detect` (`AURA`, `CAST`, or `RESURRECT`), the `received` and (non-service) `given` defaults (0 seeds off, 1 on), and a `triggers` list of `{ spell = id }`. Add `item = id` beside the spell for an item-driven buff, and `aura = id` when the applied aura id differs from the cast id.
2. For a multi-rank or multi-variant group under one toggle, list every id in `triggers`. With no label of its own the toggle takes the first live trigger's spell name, which suits ranks of one spell. When one of its own items names the group (Soulstone, Scroll of Agility), set `labelItem` to that item's id and the client supplies the label in every locale. When the members have different names, set `name = L["GROUP_*"]` (today `GROUP_PORTALS`, `GROUP_RESISTANCE_CAULDRONS`, `GROUP_REPAIR_BOTS`), adding the key to `Locales/enUS.lua`, but only for our own word for the group, never for a game record's name.
3. Add the row to every folder whose client has the ability, both `Vanilla` and `Discovery` for Classic Era, and leave it out of any folder where its id means a different ability. Look the id up in all seven folders and say in the PR which copies changed and why.
4. Set `noDuration` when the buff is spent by an event rather than by time (Fear Ward, Misdirection), so Good News drops its duration clause.
5. Set `opened` on a `SERVICE` to read "opened" (portals, summons) instead of "set out" (feasts, soulwells, repair bots). Use `detect = RESURRECT` for a cast that can fail, so only a confirmed revive announces; `Data/Camelot/` can't carry one. Set `receivable = false` in a folder whose client can't see the row land on you (every non-service `CAST` row in `Data/Camelot/`), so it reaches Good News only.
6. No code change is needed. `ns.BuildTrackedData` (`BuildLookups`, `PopulateWatchedBuffs`, `BuildDisplayGroups`) consumes the table at login, and the new id seeds into existing profiles.

Its link ends up inside a whisper capped at **255 bytes** (Style Guide → MESSAGES → Message Length), so a new `GROUP_*` label should stay short. Run Message Length on the Diagnostics Localization tab, on ruRU, after adding a long-named item. A new class in this table also gets a Count as Tanks row.

## Adding a New Peer Pressure Ability

`ns.PEER_PRESSURE_ABILITIES` lives in `Data/{Game}/Peer-Pressure-Abilities-{Game}.lua`, one copy per flavor folder. One row per checkbox: `{ "CLASS", { spell ids }, default }`, where the class is the caster's and the default is 0 (off) or 1 (on). List every rank or variant in the id list; each is watched on its own. The spell must report `SPELL_CAST_SUCCESS` in the combat log. Leave the row out of any folder where the id is a different ability. `Data/Camelot/` keeps its copy even though the Camelot TOC loads no Peer Pressure code, so every folder declares the same tables and the Count as Tanks list sees the same classes. Rows are consumed at login by `Features/Peer-Pressure.lua`; no code change is needed.

## Adding a New Buff Duty Buff

1. Add a row to `ns.BUFF_WINDOW_SPELLS` in `Data/{Game}/Buff-Window-Spells-{Game}.lua` for every folder whose client has the spell: `class`, `single` as `{ spell id, level learned }` per rank (the learn level drives `RankFor`, so check it against Validate Data's `SPELL_LEVEL_LEARNED` column), `group` and `greater` id lists when they exist, and a `default` from `Data.BUFF_AUDIENCE` (any other value is dropped and re-seeded at every login).
2. Set `exclusive` when the target can hold only one of yours from a family (paladin blessings share `"BLESSING"`), `manaOnly` when the buff is worthless to a class without mana, and `noCasters` when it is worthless to mages, priests and warlocks.
3. A self buff goes in `ns.BUFF_WINDOW_SELF_SPELLS` instead, with `class`, `ranks` as `{ spell id, level learned }`, an `exclusive` family when only one can be up (never a name `ns.BUFF_WINDOW_SPELLS` uses), `auras` when the buff it leaves isn't the cast's own id, `needsPet` when it means nothing without a pet, and a `default` from `Data.SELF_REFRESH_CHOICES` (`"OFF"`, `MISSING` (0), or 10, 5 or 3 minutes left). A family of two or more needs its `BUFF_WINDOW_SELF_NOTE_<family>` string in `Locales/enUS.lua`.
4. A poison or imbue goes in `ns.BUFF_WINDOW_WEAPON_ENCHANTS` with its `class`: `items` as `{ item id, level required, enchant id }` for a poison, `ranks` as `{ spell id, level learned, enchant id }` and a `duration` in minutes for an imbue. The enchant id is the `ENCHANT_ITEM_TEMPORARY` effect's misc value in this client's SpellEffect table, through ItemEffect for an item; a spell that enchants through a script effect instead, like TBC's Rockbiter, takes the list of its variants by name from SpellItemEnchantment. Every row starts ticked for every hand. A class that can newly hold one on a hand gets that hand in `ns.BUFF_WINDOW_WEAPON_HANDS`.
5. An oil, stone or lure any class can use goes in `ns.BUFF_WINDOW_WEAPON_ITEMS` instead, positional: `{ item id, level required (ItemSparse), enchant id, weapon types (SpellEquippedItems' EquippedItemSubclass for the item's spell), kind, item level (ItemSparse) }`. The kind must be one of `Data.WEAPON_ITEM_KINDS`; any other is offered in the window but never drawn on the panel, so it can't be unticked. A new kind needs its `Data.WEAPON_ITEM_KINDS` entry, its `BUFF_WINDOW_WEAPON_KIND_<KIND>` string, and a `Data.WEAPON_ITEM_KIND_HANDS` entry if only one hand can carry it.
6. A new warlock demon's icon is one `[creature ID] = summoning spell id` row in `ns.BUFF_WINDOW_PET_ICONS.demons`, which also marks that pet as a warlock's.
7. A new class in any of these tables gets a Count as Tanks row automatically; a melee class that should start on `SOLO` also needs its `tankWhen` default in `Data/Default-Settings.lua`.
8. No code change is needed: `BuffWindow.BuildLookup`, `BuildBuffs` and `ns.PopulateBuffWindowAudience` pick the row up at login, and the panels list it under its class (a weapon item under its kind's box on Weapon Buffs). Validate Data flags a weapon enchant with no enchant id as ERROR.

The Return the Favor macro (`/targetexact <name>` then `/cast [help] <rank text>`) is a 255-byte macro body; Message Length builds one per castable single-target buff with a 12-letter name plus your realm.

## Adding a New Thank You Button

1. Append one row to `Data.THANK_YOU_BUTTONS` in `Data/Data.lua`, with a unique `profileKey`, a `macroName` leading with a dash, a `command` nobody else registers, and `singleEmote = true` unless it should randomize over a checklist.
2. For it to start on its own icon, add a `{ texture file ID, <button index> }` row to `ns.THANK_YOU_MACRO_ICONS` in each `Data/{Game}/Game-IDs-{Game}.lua`; without one it starts on the default icon.

Its defaults, options section, slash command (`TFTB_THANKYOU<n>`, which Buff Reactions Context checks) and macro all generate from that row, and it starts switched off. The macro body is the command literal, far under the 255-byte macro ceiling.

## Adding a New Registered Event

1. Add the event name to `ns.EVENT_NAMES` in `Features/Core.lua`. The dispatcher registers it and the diagnostics Event Registration probe picks it up automatically. Never register a frame anywhere else. An event one flavor lacks is appended conditionally, the way `COMBAT_LOG_EVENT_UNFILTERED` is, because registering an event the client doesn't have throws.
2. If the add-on only needs it for one or two units, add them to `ns.EVENT_UNITS` so it registers through `RegisterUnitEvent`.
3. Attach a handler in the owning feature module with `ns.SetEventHandler("EVENT_NAME", handler)`, named for the event (`OnEventName`). Only one module may own an event, and a second `SetEventHandler` silently replaces the first; a second consumer is called from the owner's handler. The handler can fire before `PLAYER_LOGIN`, so guard on `ns.db` or the module's own setup flag. On Forever, check every argument with `ns.IsPlain` before comparing it or using it as a key.
4. If it is a firehose, add it to `ns.DIAGNOSTIC_EVENT_EXCLUDE` in `Diagnostics/Event-Log.lua` and decode it into the log through a purpose-built helper, or to `ns.MESSAGE_ID_FILTERED_EVENTS` there with its id position and a branch in `ns.IsCorrelatedMessage` (`Diagnostics/Manifests.lua`), which otherwise counts every firing. A `CHAT_MSG_*` event makes the Event Log panel warn that it captures message bodies.

## Localization

- **`enUS.lua` is the source of truth.** Each locale file registers through `NewLocale("TFTB", "<code>")`, and `enUS.lua` is the only one that passes the `true` default-fallback flag. Every other locale translates its key set, and AceLocale falls back to English for anything missing. The other ten files belong to the Localization Review (`07 - Localization Review.md`); never hand-edit them during ordinary work.
- **Placeholders.** The `%s` and `%d` count, type and order must match `enUS` per key in every locale, or the string crashes at runtime. `DEFAULT_GOOD_NEWS` is the exception: its `%a` is not a format placeholder, never reaches `string.format`, and must survive translation literally. The Good News help text is three keys joined in code for the same reason: `GOOD_NEWS_MESSAGE_INPUT_DESCRIPTION`, then `GOOD_NEWS_MESSAGE_LIMIT`, which carries a real `%d` (the 120-byte cap), then `GOOD_NEWS_MESSAGE_TOKENS`, which carries a literal `%a` and never reaches `format`.
- **Game names never go in `Locales/`.** Spells, items, classes and Blizzard labels are stored as IDs, tokens or GlobalStrings and named by the client:
  - Spells: the `ns.GAME_IDS` sample constants (`SAMPLE_BUFF_SPELL_ID`, `SAMPLE_GOOD_NEWS_SPELL_ID`, `SAMPLE_PEER_PRESSURE_SPELL_ID`, `SAMPLE_SERVICE_SPELL_ID`) and every tracked, Peer Pressure, Buff Window and imbue spell through `C_Spell.GetSpellName`, linked through `ns.GetSpellLink`. `PHASE_SHIFT_SPELL_ID` is read as an aura, never shown.
  - Items: tracked items, `labelItem` groups, and Buff Duty's poisons, oils, stones and lures through `C_Item.GetItemInfo`, each panel repainted on `GET_ITEM_INFO_RECEIVED` as a cold item loads.
  - Class tokens through `LOCALIZED_CLASS_NAMES_MALE`; durations through `D_SECONDS` / `D_MINUTES` / `D_HOURS`; party headers through `GROUP` and `GROUP_NUMBER`; weapon hands through `INVTYPE_WEAPONMAINHAND` / `INVTYPE_WEAPONOFFHAND`; the Buff Keys' combat refusal through `ERR_NOT_IN_COMBAT`; pet owners through the `UNITNAME_TITLE_*` formats; emote commands through the client's `EMOTE<n>_CMD<n>` globals.
  - The only tracked-row names in `Locales/` are our own group words (`GROUP_*`).
- **Quote style.** A value containing a double quote is written with single-quoted Lua delimiters and stays that way under StyLua (`BUTTON_MACRO_ENABLE`, `'Enable Macro "%s"'`). Any script that audits key parity must accept both delimiters.
- **Diagnostics strings are not localized.** They live in `ns.DiagnosticsStrings` as plain English.

The Spanish file pairing, the overflow canary and the output ceilings are per Style Guide → LOCALIZATION and MESSAGES → Message Length. In TFTB the sent strings that carry a live link (`MESSAGE_WHISPER_THANKS`, `DEFAULT_GOOD_NEWS`) are the ones to keep short in translation.

## Common Pitfalls

- **A `|4` plural escape in a sent message**: WoW's duration strings (`D_MINUTES` is `"%d |4minute:minutes;"`) carry an escape the UI expands only at render time. It looks right in a print, but `SendChatMessage` rejects any message still holding one and silently drops the *whole line*. `ResolvePlurals` in `Features/Announcements.lua` expands it first.
- **`string.format` on a user-editable template**: a stray `%` in the Good News body makes `format` raise mid-whisper. `ns:BuildGoodNewsMessage` substitutes `%a` with `gsub` and a replacement function, which also stops a `%` inside a link from being read as a capture reference.
- **Truncating a sent line to fit 255 bytes**: a cut can land inside a link, which the server rejects. `ns:BuildGoodNewsMessage` falls back to shorter whole templates; the edit boxes trim only the player's own text, at a character boundary (`ns.TrimToBytes`).
- **Whispering a pet name**: a whisper to a pet bounces ("No player named 'X' is currently playing"). Every whisper recipient is proven a player first (`ns.IsPlayerGUID` on the reaction and Good News paths, `UnitIsPlayer` for services and the Thank You command), and pet sources are traded for their owner via `ResolveSource` / `ResolveAuraCaster`, which return nil rather than falling back to the pet.
- **Assuming your own casts come from `player`**: Roar of Sacrifice and Battle Squawk are cast by your pet. `UNIT_SPELLCAST_SENT` registers for `player` and `pet`; a bare `unit == "player"` test silently switches Good News off for every pet-cast entry.
- **Cross-realm source names**: a combat-log name is `Name-Realm` and never matches a name lookup or resolves as an emote target. Classify group membership by affiliation flags, and strip the realm with `Ambiguate(name, "short")` before passing a name to `C_ChatInfo.PerformEmote`.
- **`C_ChatInfo.PerformEmote(cmd, nil)` is not undirected**: it falls back to your *current target*, thanking a bystander. `ns:DoRandomEmote` and `ns:DoEmoteToken` return early on a nil target. A stranger with no unit token is emoted at by bare name; a name the client can't resolve still degrades to the undirected emote, a hole that closes only by dropping the name fallback and with it the commonest thank of all.
- **A unit token is not proof of presence**: a party member who zoned into a dungeon is still `party2`. `CanWitnessEmote` gates on `UnitIsVisible` plus `UnitInRange`, reading `UnitInRange`'s second return so a non-group unit (or a secret answer on Forever) falls through to the visibility verdict.
- **Resolving an emote target before a delay**: `target`, `focus` and `mouseover` name whoever you point at *in that instant*. `DeliverPraise` resolves inside the timer; every other gate is settled before it arms.
- **Iterating a saved emote table**: a saved profile can hold keys that are not real emote tokens, and a random pick of one is a silent no-op. `ns:DoRandomEmote` walks `Data.EMOTES` and reads the saved table by key.
- **Opening the options panel by title**: `Settings.GetCategory(<title>)`, or the title passed to `Settings.OpenToCategory`, returns nil on clients with the Settings API, so the panel opens as a floating window. It still works on Classic Era, so one-flavor testing misses it. `ns:OpenOptionsPanel` routes by the captured category id.
- **Reading a buff's duration too early**: for Good News the aura lands a tick *after* the cast succeeds. Wait `AURA_SETTLE`, then read it off the recipient after re-confirming their GUID.
- **A live buff reporting 0 duration**: `ns.GetBuffDuration` returns 0 for a timerless buff and nil for absent, so callers nil-check and never test the number for truthiness.
- **A successful cast is not a successful resurrect**: jumper cables emit `SPELL_CAST_SUCCESS` for every jolt. Only `SPELL_RESURRECT` proves it took, which is what the `RESURRECT` detect mode exists for.
- **The client's native spell link in chat**: on Classic `C_Spell.GetSpellLink` omits the trailing `:0` field, and `SendChatMessage`'s validator strips the link on send. `ns.GetSpellLink` builds `|Hspell:<id>:0|h` by hand and uses the native link only when the name won't resolve.
- **Reusing a spell id across flavors**: `C_Spell.DoesSpellExist` cannot tell Ice Block (Era) from Cold Snap (TBC); they share id `11958`. Each flavor folder carries only the row that id means on its client.
- **Touching a secret value on Forever**: comparing, concatenating or indexing with one errors, and they arrive from event arguments, unit names, aura fields, and even `UnitInRange`, `UnitPowerType` and `PerformEmote` returns. Test with `ns.IsPlain` first, and ask `ns.IsUnitIdentitySecret` / `ns.AreAurasSecret` before reads that can go secret.
- **A handler firing before login**: Core registers every event when it loads, so `UNIT_AURA` or `GET_ITEM_INFO_RECEIVED` can arrive while `ns.db` is nil. Every handler checks `ns.db`, `isReady` or `isSetUp` before reading a setting.
- **Changing a secure button in combat**: the Buff Window's buttons are protected, so setting an attribute, moving or showing one in combat is blocked. Everything that lays the window out refuses in combat and the caller replays on `PLAYER_REGEN_ENABLED` (`settingsPending` for settings, a full refresh for the list). Only alpha and the cooldown children may change mid-fight.
- **Casting a rank by spell ID**: the secure template hands a number to `CastSpellByID`, and on Classic Era a lower rank's ID casts nothing. Buttons set `spell` to the rank text, `Name(Rank N)`, and `RankFor` keeps that rank within 10 levels of the target, or the cast fails as too low level.
- **A pooled secure button keeps its last attributes**: a macro button reused for a spell would still run its macro, and an item button would still aim at its weapon slot. `ns.SetBuffButtonAttributes` writes `type1`, `spell`, `item`, `unit`, `target-slot` and `macrotext` on every use, nil included.
- **Registering only `AnyUp`**: the secure template acts on the half `ActionButtonUseKeyDown` names, so an up-only button is dead for anyone casting on key down. Buff Window buttons register both. The Buff Keys go the other way and set `useOnKeyDown` false, because a macro's `/click` sends only an up click.
- **Reading `Has` off the wrong unit**: `Has` reads whichever record the last `ReadAuras` selected, so calling it for one unit after reading another silently answers for the other. Always `ReadAuras(unit)` first.
- **A short buff under a long Refresh Under**: a buff whose whole duration is at or under the threshold would read as missing the moment it landed and never stop. `Has` counts such a buff as missing only once it is gone; weapon imbues follow the same rule.
- **Counting `GetWeaponEnchantInfo`'s returns**: some clients return three values per hand and others four (the enchant id last), so a fixed stride misreads the off hand on one of them. `ReadWeaponEnchants` works out the stride from the return count.
- **Building the outsider sections with `ipairs({ target, favor })`**: `ipairs` stops at the first nil, so an empty Target would drop Return the Favor. `AddOutsiderSections` appends each section on its own.
- **Reading a pet's owner class from tooltip wording**: on Classic Era the tooltip named the owner without the wording that gives the class away. `PetOwnerClass` reads the pet first (demon creature ID, Focus power) and uses the wording only as a fallback.
- **Leaving a caption on a label-beside-control row**: AceConfig renders a widget's own `name` above it, so a `select` that keeps its caption stacks the label over the control. Every dropdown carries `name = ""` and pairs with an `ns.OptionsRowLabel` cell or its enabling toggle.
- **Editing a vendored library**: `Includes/Libraries/` is refreshed from upstream on every release (`externals` in `.pkgmeta`), so a local fix is discarded at build time. Work around it in `Features/`, or fix it upstream.

## Contributing

- **Issues.** <https://github.com/Gogo1951/Thanks-for-the-Buff/issues>.
- **Bug reports.** Include game version and locale, class and level, repro steps, and the relevant chat output or whisper text. The Diagnostic Tools panel produces a ready-to-paste report: enable it, press Run All on the Settings and Code tabs, and capture the Event Log on Run Tests while reproducing.
- **Discord.** <https://discord.gg/eh8hKq992Q>.
- **PRs.** Keep changes scoped. Run StyLua with its default config and `--syntax lua51` over every touched Lua file, and keep `luac -p` and `luacheck .` clean. Any change to the shape, name, or scope of saved data ships its own migration, tagged `MIGRATION (remove after YYYY-MM-DD)` and supported for 30 days. Check any sent-message or macro change against the **255-byte** ceiling in the widest-encoding locale (Style Guide → MESSAGES → Message Length), using the Message Length report on ruRU. Update this document if the architecture or file map changes.
- **PR descriptions say what a player will notice**, in plain language, the way release notes do. Commit messages carry the developer detail.
