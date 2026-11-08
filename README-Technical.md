# Thanks for the Buff // Technical Reference

This document combines architecture notes and contribution guidance for developers working on Thanks for the Buff. For end-user documentation, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md).

## File Map

The packager installs the repo as `Interface/AddOns/TFTB/` (`package-as` in `.pkgmeta`), so `ADDON_NAME` is `TFTB` everywhere, including the AceLocale name and every `ns.OPTIONS_REGISTRY` key.

```text
Thanks-for-the-Buff/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── config.yml                Per-add-on New issue page links
│   │   ├── defect.yml                Shared from Common-Core: the Defect form
│   │   └── request.yml               Shared from Common-Core: the Request form
│   └── workflows/
│       ├── ci.yml                    Calls Common-Core: shared files, externals, luac 5.1, luacheck, StyLua
│       ├── issue-labels.yml          Calls Common-Core: labels a new Defect by its Issue Type
│       └── package.yml               Calls Common-Core: library refresh, CurseForge and Wago upload
├── .gitattributes                    Shared from Common-Core
├── .gitignore                        Shared from Common-Core
├── .luacheckrc                       Lint config
├── .pkgmeta                          Externals, package-as TFTB, ignore list (drops Data/Wrath, Data/Mainline)
├── TFTB_Vanilla.toc                  Classic Era, Season of Discovery included
├── TFTB_TBC.toc                      TBC Anniversary
├── TFTB_Camelot.toc                  WoW Forever
├── TFTB_Mists.toc                    MoP Classic, the master list's Extra TOC
├── Data/
│   ├── Flavor.lua                    Canonical flavor identity from the TOC's X-Flavor
│   ├── Data.lua                      Locale init, palette, registry, Thank You button rows, curated emotes, links
│   ├── Default-Settings.lua          AceDB defaults, all under profile; generates buttons 2 to 5
│   ├── Vanilla/                      Classic Era; each file returns early on Season of Discovery
│   │   ├── Emote-Groups-Vanilla.lua  Emote token to Voice, Gesture or Pose
│   │   └── Game-IDs-Vanilla.lua      Sample buff spell and the Thank You macro icons
│   ├── Discovery/                    Season of Discovery; listed after Vanilla/, inverse guard
│   ├── TBC/                          Same two files per folder
│   ├── Camelot/
│   ├── Mists/
│   ├── Wrath/                        Forward-prep, no TOC; empty icon list
│   └── Mainline/                     Forward-prep, no TOC; empty icon list
├── Diagnostics/                      Diagnostic Tools, copied from Magic Eraser
│   ├── Diagnostics-Core.lua          Enable gate, strings, report header
│   ├── Manifests.lua                 TFTB's surface: API rows, probes, aura log lines, names, messages, data
│   ├── Event-Log.lua                 Event and Taint Logs; excludes the two detection events
│   ├── Code-Reports.lua
│   ├── Settings-Reports.lua
│   ├── Validate-Data.lua
│   ├── Localization-Reports.lua      Locale Context, Game Names, Message Length
│   ├── Report-Runner.lua
│   └── Options-Diagnostics.lua       The panel; loads in the TOC's Options block
├── Features/
│   ├── Core.lua                      Version, AceDB init, reset, prune, ns.EVENT_NAMES, dispatcher, login
│   ├── Utilities.lua                 Colors, client emote catalog, secret checks, spell links, GUIDs, auras
│   ├── Announcements.lua             Prints, signed-off whispers, emotes, duration strings
│   ├── Praise.lua                    Cooldowns, emote target, the reaction to a stranger's buff
│   ├── Buff-Tracking.lua             Detects a stranger's buff: combat log, or UNIT_AURA on WoW Forever
│   └── Thank-You-Button.lua          The /thankyou commands and their macros
├── Includes/
│   ├── Images/
│   │   └── Thanks-for-the-Buff.tga   The TOCs' IconTexture
│   ├── Libraries/                    Vendored Ace3, refreshed from .pkgmeta on release
│   └── Sounds/
│       └── Buff.ogg                  The stranger-buff notification sound
├── Locales/
│   ├── enUS.lua                      Source strings
│   └── deDE.lua ... zhTW.lua         Ten translations
├── Options/
│   ├── Options-Utilities.lua         Row helpers, Example lines, feature switches, toggle pairs
│   ├── Options-General.lua           Root panel: pitch, welcome, Features, /Commands, Good to Go links
│   ├── Options-Emote-Grid.lua        Custom AceGUI checklist widget for the Give Thanks emotes
│   ├── Options-Give-Thanks.lua       Give Thanks panel behind its master switch
│   ├── Options-Emotes-List.lua       Sub-panel of Give Thanks: the emote checklist
│   ├── Options-Ignored-Buffs.lua     Sub-panel of Give Thanks: All Characters + per-character buff lists
│   ├── Options-Thank-You-Button.lua  One section per Thank You button
│   ├── Options-Profiles.lua          Stock AceDBOptions table
│   ├── Options-Feedback-Support.lua
│   └── Options.lua                   Registration, opener, /tftb and /thankyou commands
├── LICENSE
├── README.md
├── README-Notes.md                   TFTB's exceptions to the Style Guide
├── README-Technical.md               This file
└── README-Testing.md                 Manual test plan
```

## Architecture

TFTB has two features. **Give Thanks** reacts automatically when a friendly player outside your group buffs you. **Thank You Button** is up to five slash commands, each with its own optional macro, that emote at and whisper your current target. There is no mini-map button and no key binding.

### Event Loop

`Features/Core.lua` owns the only event frame. `ns.EVENT_NAMES` lists every event, and feature files attach handlers with `ns.SetEventHandler(event, handler)` (one handler per event; attaching again replaces it). The dispatcher calls `ns:LogEvent` first when diagnostics logging is on, then the handler.

| Event | Handler | Purpose |
|---|---|---|
| `PLAYER_LOGIN` | `OnPlayerLogin` (Core) | AceDB, options panels, buff tracking setup, macro reconcile, in that order |
| `PLAYER_ENTERING_WORLD` | `OnPlayerEnteringWorld` (Core) | Welcome message, once per session |
| `LOADING_SCREEN_DISABLED` | `OnLoadingScreenDisabled` (Buff-Tracking) | Re-arms the 3-second safety pause |
| `COMBAT_LOG_EVENT_UNFILTERED` | `OnCombatLogEventUnfiltered` (Buff-Tracking) | Buff detection, every flavor except WoW Forever |
| `UNIT_AURA` | `OnUnitAura` (Buff-Tracking) | Buff detection on WoW Forever only, registered for `player` only |

The detection event is chosen at load from `ns.FLAVOR`: Core appends `UNIT_AURA` on Camelot and `COMBAT_LOG_EVENT_UNFILTERED` everywhere else. Registering the combat log on WoW Forever raises `ADDON_ACTION_FORBIDDEN`, which `pcall` can't catch. `ns.EVENT_UNITS` routes `UNIT_AURA` through `RegisterUnitEvent(event, "player")`, so nameplates and raid members never wake the dispatcher.

**Safety pause.** `StartSafetyTimer` sets `isReady = false` and, `Data.SAFETY_PAUSE` (3) seconds later, back to true. It runs at login and after every loading screen. Each call bumps a token, and only the newest timer may restore readiness, so back-to-back loading screens can't end the pause early. While not ready, both detection handlers return at their first line; this keeps the flood of auras reapplied on zoning from reading as fresh buffs.

### Combat Lockdown

Nothing in TFTB queues for after combat. Each combat-sensitive action either refuses or goes ahead without the blocked part:

- **Options opener.** `ns:OpenOptionsPanel` checks `InCombatLockdown()` first, prints `CHAT_OPTIONS_IN_COMBAT` and returns.
- **Macros.** `ns.ReconcileMacros` and `ns:DeleteAutoMacro` return in combat. A Thank You macro toggle flipped mid-fight changes the saved setting but leaves the macro as it is until the next login, profile change or toggle.
- **Praise emotes.** `HandleStrangersBuff` counts the emote as unavailable in combat, and `DeliverPraise` checks again when the emote fires, since the Praise Delay can carry it into a fight. Whispers still go out in combat.
- **Notifications.** The print and the sound fire for every qualifying buff, in or out of combat.
- **WoW Forever detection.** `OnUnitAura` skips every update while in combat or while `C_Secrets.ShouldAurasBeSecret()` is true. A buff that lands then is never seen.

### Detect → Classify → Praise

Give Thanks runs in three phases across two files.

**1. Detect** (`Features/Buff-Tracking.lua`). The combat-log path keeps only `SPELL_AURA_APPLIED` and `SPELL_AURA_REFRESH` whose destination is your cached GUID; REFRESH counts because a rebuff earns the same thanks. The WoW Forever path reads `updateInfo.addedAuras` only (full updates are skipped), so a recast of a buff you already have is not seen there.

**2. Classify** (`Features/Buff-Tracking.lua`). A buff qualifies when it comes from a friendly player outside your group:

- Combat log: `ns.IsPlayerGUID(sourceGUID)` (the GUID's `Player-` prefix, the only proof a source is a player), `COMBATLOG_OBJECT_REACTION_FRIENDLY`, `COMBATLOG_OBJECT_AFFILIATION_OUTSIDER`, then `IsGroupMemberOrPet` as a backstop.
- WoW Forever: `ResolveAuraCaster` credits the caster through the aura's `sourceUnit`, or, with none (a stranger out of nameplate range), through `C_UnitAuras.GetAuraCasterGUID` and `UnitNameFromGUID`. A pet is traded for its owner via `GetPetOwnerUnit`. The credited player and the raw caster are both checked against the roster, and `UnitIsFriend` is asked only when a unit token exists, since a GUID-only caster who just buffed you can't be the other faction.

`IsGroupMemberOrPet` scans the whole roster (party or raid, members and pets) by GUID, then by name with the realm's spaces dropped, because the unit token an aura carries can be a nameplate, missing, or the pet's.

**3. Praise** (`Features/Praise.lua`, `HandleStrangersBuff`). In order:

1. Return if `strangers.enabled` is off.
2. Read the buff's duration off your auras (`ns.GetBuffDuration`). nil means the buff isn't on you, so stop. 0 is a live buff with no timer and always passes.
3. Stop if the duration is under `minBuffDuration`.
4. Print (`printEnabled`) and play the sound (`soundEnabled`). These never answer to cooldowns.
5. Stop if the spell ID is on the All Characters or this character's Ignored Buffs list (`ns.IsBuffIgnored`).
6. Stop if the overall (`praise:all`) or per-source (`praise:<guid>`) cooldown is running.
7. Clear the whisper (toggle on, message not empty, 45-second per-recipient floor) and the emote (at least one pickable emote, out of combat). Stop if neither is cleared.
8. Stamp the cooldowns, then hand off to `DeliverPraise`, which waits `praiseDelay` seconds when the delay is enabled.

Every gate is settled before the delay timer starts, so a burst of buffs can't slip past a cooldown inside the delay window. The emote target is resolved late, when the emote fires, because `target`, `focus` and `mouseover` name whoever you point at in that instant.

### State Encoding

`sessionCooldowns` in `Features/Praise.lua` is one in-memory table keyed by namespaced strings, so the three throttles never collide on the same GUID:

| Key | Set from | Meaning |
|---|---|---|
| `praise:all` | `praiseCooldown` (0 = off) | Time since you praised anyone |
| `praise:<guid>` | `cooldown` | Time since you praised this player |
| `whisper:<guid>` | `WHISPER_COOLDOWN` (45) | Time since you whispered this player, a floor no setting lowers |

`SetCooldown` sweeps lapsed entries on every write, so the table can't grow across a long session. Nothing is saved; a `/reload` clears every cooldown.

## Emote Targeting

An emote that reaches nobody reads as a bug, so the emote path is built to emote at the buffer or not at all.

- **`ResolveEmoteTarget`** maps the buffer's GUID to a unit we hold (`ns.GetUnitByGUID`: you, the group, then `target`, `focus`, `mouseover`). A held unit must pass `CanWitnessEmote`: `UnitIsVisible`, then `UnitInRange` where it answers. A unit that fails returns nil, meaning no emote. With no unit, the bare name (`Ambiguate(name, "short")`) is used, since the client resolves only the bare form, never `Name-Realm`.
- **`ns:DoRandomEmote` refuses a nil target.** `C_ChatInfo.PerformEmote(token, nil)` is not undirected: it falls back to your current target and thanks a bystander. Refusing at this one chokepoint keeps the rule out of every caller.
- **Known gap:** no API tests whether a name will resolve, so an absent stranger reached by name still gets the undirected emote. Dropping the name fallback would also drop the most common case, a stranger standing next to you untargeted.
- **`CanWitnessEmote` is deliberately loose.** Emote text carries only at say range, which no API measures. Erring loose costs an emote nobody sees; erring tight silently drops thanks the buffer was there for.
- **Picks are checked against the client.** `ns.GetPickableEmotes` drops any saved token the running client can't perform (an emote from another flavor, a retired key), since `PerformEmote` with a bad token is a silent no-op.

## Client Emote Catalog

`ns.GetEmoteCatalog` (`Features/Utilities.lua`) reads every emote from the running client's `EMOTE<n>_TOKEN` and `EMOTE<n>_CMD<n>` globals instead of a data file, because the set differs per expansion and a hand-kept list would be right on one client only. It scans to `MAXEMOTEINDEX` (falling back to 1000), since indices are sparse (Era jumps from 171 to 304); dedupes tokens that appear twice (`INCOMING`, `FLEE`); skips `UNUSED`; and sorts by slash command, case-insensitive. It builds once on first use.

Three things sit on top of it:

- **`Data.EMOTES`** (`Data/Data.lua`) is the twelve curated praise tokens: the Give Thanks defaults and Thank You Button 1's whole list. Tokens only; the client writes each emote's line in the player's language. `/yes` is the `NOD` token.
- **`ns.EMOTE_GROUP_BY_TOKEN`** (`Data/{Game}/Emote-Groups-{Game}.lua`) sorts tokens into Voice, Gesture and Pose. Anything unlisted is Text (`ns.GetEmoteGroup`).
- **The Give Thanks emote grid** (`Options/Options-Emote-Grid.lua`) shows the whole catalog, grouped, four to a line. Each group is one custom AceGUI widget (`TFTB-EmoteChecklist`) rather than one AceConfig toggle per emote: about 255 toggles froze the screen for a second on every click, because AceConfig rebuilds every widget after each change. The widget keeps its checkboxes, a redraw only re-reads checked states, and a click writes straight to the profile.

## Chat Output

All output is in `Features/Announcements.lua`.

**Prints** open with `TFTB //` (`ns.GetPrintPrefix`, a `README-Notes.md` exception). `ns:PrintMessage` wraps the body in `C_TEXT` only when it holds no `|c`, so an outer `|r` never cuts off an embedded spell link or class color. The stranger print is `MESSAGE_BUFFED`, with the name in its class color from `GetPlayerInfoByGUID`.

**The Give Thanks whisper** is the player's `whisperMessage` with `{spell}` swapped for the buff's link, signed off:

```text
{rt1} Thanks for the [Arcane Intellect] // TFTB
```

`TrimSentBody` strips trailing `! . ?` and their full-width forms, plus a leading `¡` or `¿`, matched as whole UTF-8 sequences. When the finished line runs past `ns.CHAT_MESSAGE_MAX_LENGTH` (255 bytes) once the link is in, `ns:BuildThanksWhisper` sends the default text instead of having the line rejected.

**Thank You whispers** go out unbranded through `ns:Whisper`, exactly as typed (a `README-Notes.md` exception), and only to a target of your own faction. The input is cut to 255 bytes on save by `TrimToBytes`, which steps back off any UTF-8 continuation byte so a character is never split.

**Spell links** are built by hand in `ns.GetSpellLink` as `|cff71d5ff|Hspell:<id>:0|h[Name]|h|r`. Classic's native `GetSpellLink` omits the trailing `:0`, and `SendChatMessage`'s link validator strips such a link down to the bare name. The native call is a fallback only for a spell with no name.

**Durations** use the client's own `D_SECONDS`, `D_MINUTES` and `D_HOURS`. `ResolvePlurals` expands their `|4singular:plural;` escape, which the UI resolves only at render time and `SendChatMessage` rejects outright. It handles three-form Slavic plurals; zhCN and koKR carry no escape.

## Thank You Button

`Data.THANK_YOU_BUTTONS` is the whole definition: one row per button with `profileKey`, `macroName`, `command` and an optional `singleEmote`. Defaults (`Data/Default-Settings.lua`), options sections (`AddButtonSection`), slash commands (`Options/Options.lua`, `SlashCmdList["TFTB_THANKYOU<n>"]`), macros and Diagnostics' Message Length rows are all generated from it.

| Button | Macro | Command | Emote |
|---|---|---|---|
| 1 | `- Thank` | `/thankyou` | Random from a checklist of `Data.EMOTES`; on by default |
| 2 to 5 | `- TFTB 2` ... `- TFTB 5` | `/thankyou2` ... `/thankyou5` | One emote picked from the whole client catalog; off by default |

The stored shape follows `singleEmote`: `emote` (one token, `""` for none) instead of `emotes` (a set). Every macro body is just the command, and every macro name leads with a dash so the family sorts together.

**`ns.ReconcileMacros`** makes the macro list match the profile: creates switched-on macros that are missing, re-icons ones whose icon differs (`EditMacro(index, nil, icon)` keeps name and body), and deletes switched-off ones. It runs at login, on every profile change, copy and reset (`OnProfileChanged` in Core), and when an icon is picked. It re-reads `GetNumMacros()` inside the loop and stops at `Data.MAX_GLOBAL_MACROS` (120). A button with no settings table is never reconciled downward. `ns.GetThankYouIcon` falls back to `Data.THANK_YOU_DEFAULT_ICON` when the saved icon isn't in this client's `ns.THANK_YOU_MACRO_ICONS`, since profiles travel between flavors.

**`ns.RunThankYou`** requires a player target that isn't you. On WoW Forever, where target identity can go secret, it skips both checks and the whisper but still emotes at `"target"`.

## Options Panels

`ns.RegisterOptionsPanels` (`Options/Options.lua`) registers, in tree order: General (root), Give Thanks, Ignored Buffs (child of Give Thanks), Thank You Button, Profiles, Feedback & Support, Diagnostic Tools. Ignored Buffs and Diagnostic Tools register their builder function, so every repaint rebuilds them. Ignored Buffs passes Give Thanks' captured category ID as its parent, because `AddToBlizOptions` resolves a parent by name only among top-level panels.

- **Feature switch.** `ns.FEATURE_SWITCHES` (`Options/Options-Utilities.lua`) declares Give Thanks' switch once. `ns.OptionsFeatureToggle` draws it on Give Thanks and in General's Features section; both write through `ns.SetFeatureSwitch`, which repaints every panel. The switch gates `HandleStrangersBuff` only, so detection and the diagnostics aura log keep running while it is off.
- **`HideAllExcept`** (`Options/Options-Give-Thanks.lua`) hides everything on Give Thanks but the intro, its spacer and the switch while the feature is off. It runs over the finished args table, so a control added later is covered, and it composes with any existing `hidden` rather than replacing it.
- **Seconds dropdowns** offer `Data.SECONDS_CHOICES` (0, 1, 2, 3, 5 ... 144, Fibonacci), always worded in seconds (`ns.FormatDuration(seconds, true)`). `get` shows the nearest listed value without rewriting the saved one, because AceConfig draws a select whose value isn't in `values` as an empty box. `minBuffDuration` defaults to 21 for that reason.
- **Example lines** go through the real builders: the print Example through `ns.GetPrintPrefix` and `ns:BuildStrangerMessage` with Portalrico (Mage, matching the Arcane Intellect sample), the whisper Example through `ns:BuildThanksWhisper`, drawn from `CHAT_WHISPER_GET` in `ChatTypeInfo.WHISPER` with `{rt1}` swapped for its texture.
- **Ignored Buffs** offers your current buffs (`ns.GetPlayerBuffIds`, empty while auras are secret) and a box that takes a spell ID or a shift-clicked link (`ParseSpellId`). Each entry is one exact spell ID (a `README-Notes.md` exception). The panel is a tree like Magic Eraser's Erase List: All Characters (`ns.LIST_SCOPE_GLOBAL`), a blank row, then each character in class color (the one being played always; others only when their list is non-empty). Every pane adds to its own scope; a character row's All Characters button promotes the buff, clearing it off every character's list. The tree opens on the character being played each visit (`ns.PrepareIgnoredBuffsTree`).
- **Reset Emotes** on Give Thanks is a confirmed `execute` that puts the checklist back to `Data.EMOTES` (a `README-Notes.md` exception).
- General ends with the Looking for Other Features? section and Good to Go's links (`ns.GOOD_TO_GO_LINKS`), another `README-Notes.md` exception.

## Diagnostics

`Diagnostics/` is the house framework copied from Magic Eraser. TFTB's own parts are in `Diagnostics/Manifests.lua`:

- **Buff Reactions Context** and **Emote Extract** on the Settings tab. The probes read feature state through `ns.IsBuffTrackingReady`, `ns.IsBuffTrackingSetUp`, `ns.GetPraiseCooldownState` (never stamps) and `ns.GetEmoteCatalog`, so they show what the features act on.
- **Aura log lines.** The event log excludes both detection events (`ns.DIAGNOSTIC_EVENT_EXCLUDE`): the combat log is a firehose and `UNIT_AURA`'s update table can't be written as text. Instead `ns:LogAuraApplied` logs every aura landing on you, before any filter, with its flags and duration; a stranger's buff reads `player=true friendly=true aff=OUTSIDER`. On WoW Forever, `LogAuraUpdate` logs each added helpful aura with the first gate that would stop it (`not ready`, `no db`, `in combat`, `auras secret`) or `read`.
- **Message Length** measures the thank-you whisper with the sample spell, every Thank You whisper the player has set, and reports how long a buff link the whisper can take before it falls back to the default.
- **Data sources**: `Game-IDs` (`GAME_IDS`, `THANK_YOU_MACRO_ICONS`) and `Emote-Groups` (`EMOTE_GROUP_BY_TOKEN`).

## Saved Variables

`TFTBDB` is the one SavedVariables table, managed by AceDB-3.0.

**TFTB uses the Simple model** (`AceDB:New("TFTBDB", ns.DATABASE_DEFAULTS, true)`): one shared `Default` profile. Ignored Buffs live outside the profile: `global.ignoredBuffs` (All Characters) and `char.ignoredBuffs` (each character), both `[spellId] = true`, plus `char.classToken` for the tree's class colors. Reset Profile puts every profile setting back to install defaults but leaves the Ignored Buffs lists alone.

Top-level profile keys: `showWelcome`; `strangers` (Give Thanks: switch, notifications, whisper, cooldowns, delay, minimum duration, `emotes`); and `slash`, `slash2` ... `slash5` (one per Thank You button). Read `Data/Default-Settings.lua` for the fields.

AceDB applies `ns.DATABASE_DEFAULTS` itself when a scope is first read and keeps an explicit `false`; there is no hand-rolled merge. Before `AceDB:New`, a saved table not stamped `settingsReset = SETTINGS_RESET` is replaced whole, silently; bump the constant in `Features/Core.lua` to start every player over. `PruneOtherClientCharacters` runs right after `AceDB:New`, then the class token is saved, then the profile callbacks.

**Default seeding.** `GetDefaultEmoteSettings(enabled)` builds `strangers.emotes` and `slash.emotes` with every `Data.EMOTES` token true, and buttons 2 to 5 are generated off, each starting on the icon whose second field in `ns.THANK_YOU_MACRO_ICONS` names it. There is no seeded flag: the emote sets are settings maps, so a token added to `Data.EMOTES` appears ticked in every profile that never saved that key. An unticked default is stored as `false`, never nil, or AceDB fills it back in.

### Migration Chain

Each runs over every profile in `ns.db.profiles`, in `InitializeDatabase`:

1. **Remove after 2026-11-21:** nils `peerPressure` (moved to Control Freak).
2. **Remove after 2026-12-07:** nils `minimap`, `teammates`, `services`, `goodNews`, `buffWindow`, `watchedBuffs` (retired features and the mini-map button).
3. **Remove after 2026-12-08:** folds a test build's `strangers.situations.buffs` into `strangers.emotes` and `whisperEnabled`; turns `emotesEnabled == false` into every curated emote stored false with every other pick cleared; nils `emotesEnabled`.

## Adding a New Thank You Button

1. Add a row to `Data.THANK_YOU_BUTTONS` in `Data/Data.lua`: a new `profileKey`, a `macroName` that starts with `- `, a unique `command`, and `singleEmote = true` unless it should randomize over the curated checklist.
2. In each flavor's `Data/{Game}/Game-IDs-{Game}.lua`, give the button a starting icon by setting an unused icon row's second field to its index. Without one it starts on the default icon.
3. Nothing else: defaults, the options section (`BUTTON_SECTION` formats the number), the slash command, the macro and the Message Length row are generated. The whisper stays under 255 bytes through `TrimToBytes`.

## Adding a New Curated Emote

1. Add `{ token = "TOKEN" }` to `Data.EMOTES`. Use the token, never the slash command, and confirm it in Diagnostics' Emote Extract on every TOC'd client.
2. If it isn't a Text emote, add it to every `Data/{Game}/Emote-Groups-{Game}.lua`.
3. It appears ticked for every profile that never saved that key, on Give Thanks and Thank You Button 1. Mention it in the release notes. The Game Names report picks it up on its own.

## Adding a New Event

1. Add it to `ns.EVENT_NAMES` in `Features/Core.lua`. An event only one flavor has is appended under an `ns.FLAVOR` check, as the detection events are, since registering an event the client lacks throws.
2. A unit event wanted for fixed units goes in `ns.EVENT_UNITS`.
3. Attach the handler from the feature file with `ns.SetEventHandler`, named for the event (`On<EventName>`). Never create a frame or call `RegisterEvent` anywhere else; Diagnostics' Event Registration reads the same list.

## Adding a Data Table

1. Declare it whole in all seven `Data/{Game}/` folders (an empty table where a flavor has no rows), with the Discovery guard pair in `Vanilla/` and `Discovery/`, and a `How We Got the Data` block.
2. List the file in each TOC's Data block, between `Data/Data.lua` and `Data/Default-Settings.lua`.
3. Add a row to `ns.DIAGNOSTIC_DATA_SOURCES` in `Diagnostics/Manifests.lua`.

## Localization

- **`Locales/enUS.lua` is the source of truth** and the only file that passes `true` to `NewLocale("TFTB", ...)`. The other ten translate its key set and are owned by the Localization Review (`07 - Localization Review.md`); never hand-edit them in ordinary work.
- **Placeholders** must match enUS per key, in count, type and order: `MESSAGE_BUFFED` (`%s %s`), `EMOTE_GROUP_COUNT` (`%s %d %d`), `BUTTON_SECTION` (`%d`), `BUTTON_MACRO_ENABLE` and its description (`%s`), `IGNORED_BUFFS_NOT_FOUND`, `SAMPLE_EXAMPLE`, `OPTIONS_VERSION` and `CHAT_LOADED` (`%s`). `{spell}` in `DEFAULT_GIVE_THANKS_WHISPER` is a gsub token, not a format code, and must stay verbatim.
- **Game names never go in `Locales/`.** The sample buff is `ns.GAME_IDS.SAMPLE_BUFF_SPELL_ID`, named by `C_Spell.GetSpellName` inside `ns.GetSpellLink`. Emote commands come from the client's `EMOTE<n>_CMD1` globals (`ns.GetEmoteCommand`), emote lines from the client itself, duration words from `D_SECONDS` / `D_MINUTES` / `D_HOURS`, and the whisper Example's frame from `CHAT_WHISPER_GET`.

The whisper ceiling is 255 bytes, so test overflow in ruRU, the widest-encoding locale.

## Common Pitfalls

- **Registering the combat log on WoW Forever**: raises `ADDON_ACTION_FORBIDDEN`, uncatchable. Core picks `UNIT_AURA` on Camelot instead.
- **Testing a secret value on WoW Forever**: comparing, concatenating or sending one errors. Every value from an aura, unit or `PerformEmote` passes `ns.IsPlain` before it is tested, and `ns.AreAurasSecret` / `ns.IsUnitIdentitySecret` are asked before reads that can go secret.
- **`PerformEmote(token, nil)`**: emotes at your current target, not at nobody. `ns:DoRandomEmote` and `ns:DoEmoteToken` refuse a nil target.
- **Directing an emote at `Name-Realm`**: the client never resolves it. `ResolveEmoteTarget` strips the realm with `Ambiguate`.
- **Whispering a pet**: bounces with "No player named...". `ns.IsPlayerGUID` guards every credited source.
- **Native spell links in chat**: Classic's lack `:0` and get stripped to the bare name. Use `ns.GetSpellLink`.
- **Client duration strings in chat**: their `|4` escape gets the whole line rejected. Run them through `ns.FormatDuration`.
- **Leaving an unticked default emote nil**: AceDB refills it at the next login. Store `false` (`model.SetChecked`, the migration).
- **One AceConfig toggle per emote**: froze the panel on every click. Keep the custom `TFTB-EmoteChecklist` widget.
- **A saved seconds value off the scale**: AceConfig draws an empty dropdown. `NearestChoice` shows the closest step without rewriting it.
- **Testing a buff duration for truthiness**: a live buff with no timer reports 0. `ns.GetBuffDuration` returns nil only when absent; check for nil.
- **Welcome on `PLAYER_ENTERING_WORLD`**: refires on every loading screen. `welcomeMessageShown` holds it to once per session.
- **Stale safety timers**: a timer from an earlier loading screen could end a newer pause. The token in `StartSafetyTimer` prevents it.
- **Nesting a sub-panel by title**: `AddToBlizOptions` can't find a non-top-level parent by name. Pass the captured category ID.
- **Hoisting the macro count**: enabling several buttons on a nearly full list would overshoot 120. `ReconcileMacros` re-reads it per macro.

## Contributing

- **Issues:** [GitHub Issues](https://github.com/Gogo1951/Thanks-for-the-Buff/issues).
- **Bug reports:** game version and locale, class and level, steps to reproduce, and the chat output or macro body involved. For "nobody got thanked", turn on Diagnostic Tools and include the Event Log and Buff Reactions Context.
- **Discord:** <https://discord.gg/eh8hKq992Q>.
- **Pull requests:**
    - Keep each PR to one change, in StyLua-default formatting, with `luac -p` and `luacheck .` clean.
    - Any change to saved data ships a tagged 30-day migration in `InitializeDatabase`.
    - Any change to a whisper keeps it within 255 bytes in ruRU; check Diagnostics' Message Length.
    - Update this document when the architecture or file map changes.
    - Write the PR description as release notes: what a player will notice, in plain language. Commit messages carry the developer detail.
