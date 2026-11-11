# Thanks for the Buff // Technical Reference

> Code map for working on Thanks for the Buff: where things live, how they connect, and the traps. Where this and the code disagree, the code wins. For players, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md).

## File Map

The packager installs the repo as `Interface/AddOns/TFTB/` (`package-as` in `.pkgmeta`), so `ADDON_NAME` is `TFTB` everywhere: the AceLocale name, every `ns.OPTIONS_REGISTRY` key, the sound path, the prefix of both custom AceGUI widget types.

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
├── .luacheckrc                       Lint config; a new global API goes in read_globals
├── .pkgmeta                          Externals, package-as TFTB, ignore list (drops Data/Wrath, Data/Mainline)
├── TFTB_Vanilla.toc                  Classic Era, Season of Discovery included
├── TFTB_TBC.toc                      TBC Anniversary
├── TFTB_Camelot.toc                  WoW Forever
├── TFTB_Mists.toc                    MoP Classic, the master list's Extra TOC
├── Data/
│   ├── Flavor.lua                    ns.FLAVOR from the TOC's X-Flavor, ns.IS_DISCOVERY, ns.DATA_FOLDER
│   ├── Data.lua                      Locale init, palette, registry, layout widths, constants, Thank You rows, curated emotes, links
│   ├── Message-Languages.lua         Send Messages In: each language's name and default whisper, loaded in every client
│   ├── Default-Settings.lua          AceDB defaults; generates Thank You buttons 2 and up
│   ├── Vanilla/                      Classic Era; each file returns early on Season of Discovery
│   │   ├── Emote-Groups-Vanilla.lua  Emote token to Voice, Gesture or Pose
│   │   └── Game-IDs-Vanilla.lua      Sample buff spell and the Thank You macro icons
│   ├── Discovery/                    Season of Discovery; listed after Vanilla/, inverse guard
│   ├── TBC/                          Same two files per folder
│   ├── Camelot/
│   ├── Mists/
│   ├── Wrath/                        Forward-prep, no TOC; empty icon list
│   └── Mainline/                     Forward-prep, no TOC; empty icon list
├── Diagnostics/                      Diagnostic Tools framework; Manifests.lua is TFTB's part
├── Features/
│   ├── Core.lua                      Version, AceDB init, prune, ApplyProfile, ns.EVENT_NAMES, dispatcher, login
│   ├── Utilities.lua                 Colors, client emote catalog, secret checks, mouse focus, spell links, auras, GUID to unit
│   ├── Announcements.lua             Prints, signed-off whispers, emotes, duration strings
│   ├── Ignored-Buffs.lua             Ignored Buffs storage by scope, character keys, current buff IDs
│   ├── Praise.lua                    Praise cooldowns, emote target, the reaction to a stranger's buff
│   ├── Buff-Tracking.lua             Detects a stranger's buff: combat log, or UNIT_AURA on WoW Forever
│   ├── Thank-You-Button.lua          The /thankyou commands' bodies and their macros
│   └── Wave-To-Friends.lua           Mouseover greeting: Custom List, Friends, Guilds, wave cooldowns
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
│   ├── Options-Utilities.lua         Row helpers, Example lines, feature switches, HideAllExcept, emote pickers
│   ├── Options-General.lua           Root panel: pitch, welcome, Features, /Commands, Good to Go links
│   ├── Options-Emote-Grid.lua        Custom AceGUI checklist widget; ns.DefineEmoteGrid
│   ├── Options-Give-Thanks.lua       Give Thanks: limits, whisper, notifications, behind its switch
│   ├── Options-Emotes-List.lua       Sub-panel of Give Thanks: its emote grid
│   ├── Options-Ignored-Buffs.lua     Sub-panel of Give Thanks: scope tree, add, promote, remove
│   ├── Options-Thank-You-Button.lua  One section per Thank You button
│   ├── Options-Wave-To-Friends.lua   Wave to Friends: rules, cooldown, Friends / Guilds / Custom List tabs
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

Three features. **Give Thanks** reacts when a friendly player outside your group buffs you. **Thank You Button** is up to `#Data.THANK_YOU_BUTTONS` slash commands, each with an optional macro, that emote at and whisper your target. **Wave to Friends** emotes at a friend, guildmate or listed name when you mouse over them in the world. No mini-map button, no key binding.

### Event Loop

- `Features/Core.lua` owns the only event frame. `ns.EVENT_NAMES` lists every event; feature files attach with `ns.SetEventHandler(event, handler)` (one handler per event, a second attach replaces). The dispatcher calls `ns:LogEvent` first when diagnostics logging is on, then the handler.

| Event | Handler | Purpose |
|---|---|---|
| `PLAYER_LOGIN` | `OnPlayerLogin` (Core) | `InitializeDatabase`, `ns.RegisterOptionsPanels`, `ns.SetupBuffTracking`, `ns:CreateAutoMacro`, in that order |
| `PLAYER_ENTERING_WORLD` | `OnPlayerEnteringWorld` (Core) | Welcome, once per session (`welcomeMessageShown`) |
| `LOADING_SCREEN_DISABLED` | `OnLoadingScreenDisabled` (Buff-Tracking) | Re-arms the safety pause |
| `UPDATE_MOUSEOVER_UNIT` | `OnUpdateMouseoverUnit` (Wave-To-Friends) | Wave to Friends; registered on every flavor, returns at once while the feature is off |
| `COMBAT_LOG_EVENT_UNFILTERED` | `OnCombatLogEventUnfiltered` (Buff-Tracking) | Buff detection, every flavor but WoW Forever |
| `UNIT_AURA` | `OnUnitAura` (Buff-Tracking) | Buff detection on WoW Forever only, `player` only via `ns.EVENT_UNITS` |

- **Detection event picked at load from `ns.FLAVOR`**: Core appends `UNIT_AURA` on Camelot, the combat log everywhere else. Registering the combat log on WoW Forever errors uncatchably.
- **Safety pause** (`StartSafetyTimer`, Buff-Tracking): `isReady = false` for `Data.SAFETY_PAUSE` seconds at login and after every loading screen, so the auras reapplied on zoning don't read as fresh buffs. Each call bumps `safetyToken`; only the newest timer restores readiness. Both detection handlers return at their first line while not ready.

### Combat Lockdown

Nothing queues for after combat. Each action refuses, or goes ahead without the blocked part:

- **Options opener**: `ns:OpenOptionsPanel` refuses first thing (Style Guide → Combat Guard).
- **Macros**: `ns.ReconcileMacros` and `ns:DeleteAutoMacro` return in combat. A macro toggle flipped mid-fight changes the setting; the macro catches up at the next login, profile change, toggle or icon pick.
- **Praise emotes**: `HandleStrangersBuff` counts the emote unavailable in combat, and `DeliverPraise` checks again at fire time, since the Praise Delay can carry it into a fight. Whispers still go out.
- **Notifications**: the print and sound fire in or out of combat.
- **WoW Forever detection**: `OnUnitAura` skips every update in combat or while `ns.AreAurasSecret()`. A buff that lands then is never seen.
- **Wave to Friends**: `OnUpdateMouseoverUnit` returns in combat.

### Give Thanks: Detect → Classify → Praise

**1. Detect** (`Features/Buff-Tracking.lua`)

- Combat log: only `SPELL_AURA_APPLIED` / `SPELL_AURA_REFRESH` whose dest is the cached `playerGUID`. REFRESH counts: a rebuff earns the same thanks.
- WoW Forever: `updateInfo.addedAuras` only, full updates skipped, so a recast of a buff you already have is not seen.

**2. Classify** (`Features/Buff-Tracking.lua`): a friendly player outside your group.

- Combat log: local `IsPlayerGUID(sourceGUID)` (the `Player-` prefix; the only proof the source is a player, which keeps pet names out of whispers), `COMBATLOG_OBJECT_REACTION_FRIENDLY`, `COMBATLOG_OBJECT_AFFILIATION_OUTSIDER` (affiliation, not a name lookup, because cross-realm names arrive `Name-Realm`), then `IsGroupMemberOrPet` as backstop.
- WoW Forever: `ResolveAuraCaster` credits through `aura.sourceUnit`, or with none (stranger out of nameplate range) through `C_UnitAuras.GetAuraCasterGUID` + `UnitNameFromGUID`. A pet is traded for its owner (`GetPetOwnerUnit`). Both the credited player and the raw caster are checked against the roster; `UnitIsFriend` is asked only when a unit token exists, since a GUID-only caster who buffed you can't be the other faction.
- `IsGroupMemberOrPet` scans the whole roster (members and pets) by GUID, then by name with realm spaces dropped, because the aura's unit token can be a nameplate, missing, or the pet's.

**3. Praise** (`HandleStrangersBuff`, `Features/Praise.lua`), in order:

1. Return if `strangers.enabled` is off (the feature switch gates only this; detection and the diagnostics aura log keep running).
2. `ns.GetBuffDuration`: nil = not on you, stop. 0 = live buff with no timer, always passes.
3. Stop under `minBuffDuration`.
4. Print (`printEnabled`) and sound (`soundEnabled`). Never answer to cooldowns.
5. Stop if `ns.IsBuffIgnored(spellID)`.
6. Stop if `praise:all` or `praise:<guid>` is running.
7. Clear the whisper (toggle, non-empty `whisperMessage`, `TryWhisperCooldown`) and the emote (any `ns.GetPickableEmotes`, out of combat). Stop if neither clears.
8. Stamp the cooldowns, hand off to `DeliverPraise` (waits `praiseDelay` when `praiseDelayEnabled`).

- Every gate settles before the delay timer, so a burst of buffs can't slip past a cooldown inside the delay window.
- The emote target resolves late, at fire time: `target`, `focus`, `mouseover` name whoever you point at in that instant.

### Praise Cooldowns

`sessionCooldowns` (`Features/Praise.lua`): one in-memory table, keys namespaced so the throttles never collide on one GUID.

| Key | Duration from | Meaning |
|---|---|---|
| `praise:all` | `praiseCooldown` (0 = off) | Since you praised anyone |
| `praise:<guid>` | `cooldown` | Since you praised this player |
| `whisper:<guid>` | `WHISPER_COOLDOWN` | Since you whispered this player; a floor no setting lowers, against the server's whisper squelch |

`SetCooldown` sweeps lapsed entries on every write. Nothing saved; `/reload` clears all. `ns.GetPraiseCooldownState` reads without stamping, for Diagnostics.

### Emote Targeting

An emote that reaches nobody reads as a bug: emote at the buffer or not at all.

- **`ResolveEmoteTarget`** (Praise): `ns.GetUnitByGUID` (you, group, then `target` / `focus` / `mouseover`). A held unit must pass `CanWitnessEmote` (`UnitIsVisible`, then `UnitInRange` where it answers plainly) or the result is nil = no emote. No unit: the bare name via `Ambiguate(name, "short")`; the client never resolves `Name-Realm`.
- **`CanWitnessEmote` is deliberately loose**: emote text carries at say range, which no API measures. Loose costs an unseen emote; tight silently drops deserved thanks.
- **Known gap**: no API tests whether a name resolves, so an absent stranger reached by name still gets the undirected emote. Dropping the name fallback would drop the most common case (stranger beside you, untargeted).
- **Chokepoint**: `ns:DoRandomEmote` and `ns:DoEmoteToken` (Announcements) refuse a nil target, and `DoEmoteToken` refuses a token the client lacks.

### Client Emote Catalog and Checklists

- **`ns.GetEmoteCatalog`** (`Features/Utilities.lua`) reads the running client's `EMOTE<n>_TOKEN` / `EMOTE<n>_CMD<n>` globals instead of a data file, because the set differs per expansion. Scans to `MAXEMOTEINDEX` (`EMOTE_SCAN_CEILING` backstop) since indices are sparse; dedupes tokens listed twice; skips `SKIPPED_EMOTE_TOKENS`; sorts by slash command, case-insensitive. Built once per session. `ns.IsClientEmote` and `ns.GetEmoteCommand` read the same build.
- **`ns.GetPickableEmotes`** (Announcements) drops saved tokens this client can't perform (another flavor's emote, a retired key), since `PerformEmote` with a bad token is a silent no-op.
- **`Data.EMOTES`**: the curated praise tokens. Give Thanks' defaults and Thank You Button 1's whole checklist (`ns.DefineEmoteGroup`, Options-Utilities). Tokens only; the client writes each line in the player's language.
- **`ns.EMOTE_GROUP_BY_TOKEN`** (`Data/{Game}/Emote-Groups-{Game}.lua`) sorts tokens into `Data.EMOTE_GROUPS`; unlisted is Text (`ns.GetEmoteGroup`).
- **`ns.DefineEmoteGrid`** (`Options/Options-Emote-Grid.lua`) draws the whole catalog, grouped, in `Data.EMOTE_GROUPS` order, as one custom AceGUI widget (`WIDGET_TYPE`, `<ADDON_NAME>_EmoteChecklist`) per group, not one AceConfig toggle per emote: a toggle per emote froze the screen on every click because AceConfig rebuilds every widget after each change. The widget keeps its checkboxes; a redraw re-reads checked states; a click writes straight to the profile.
- **Grid IDs**: each grid registers a model in `models[gridId]`, and each widget's option name is `"<gridId>:<group>"`, so a recycled widget finds the right model. Three grids today: `strangers` (Emotes List, the default), `waveFriends`, `waveGuilds`. Each takes its own `key`, `defaults`, `registry` and `width` through `opts`.
- **Session caches**: `ns.GetEmoteSelectChoices` (single-emote dropdowns: Thank You Buttons 2 and up, Custom List rows) and `IconChoices` (Options-Thank-You-Button) build once, since neither list can change in a session.

### Chat Output

All in `Features/Announcements.lua`.

- **Prints** open with `ns.GetPrintPrefix()` (`TFTB //`, a `README-Notes.md` exception). `ns:PrintMessage` wraps the body in the TEXT color only when it holds no `|c`, so an outer `|r` never cuts off an embedded link or class color. The stranger print is `MESSAGE_BUFFED` with the name class-colored from `GetPlayerInfoByGUID`.
- **Give Thanks whisper**: `ns.FillThanksWhisper` swaps `{spell}` in `whisperMessage` for the link and `{name}` for the buffer's short name (`Ambiguate`), then `SignOff` gives it the marker-and-brand shape:

  ```text
  {rt1} Thanks for the [Arcane Intellect] // TFTB
  ```

  `TrimSentBody` strips trailing `CLOSING_MARKS` and a leading `OPENING_MARKS` entry, matched as whole UTF-8 sequences. `ns:BuildThanksWhisper` is what sends: past `ns.CHAT_MESSAGE_MAX_LENGTH` with the link in, it sends `ns.GetDefaultThanksWhisper()` instead of being rejected.
- **Send Messages In** (`profile.messageLanguage`, read through `ns.GetMessageLanguage`) is the language other players read, separate from the UI's locale. AceLocale loads only the client's own Locales file, so every language's default whisper lives in `Data.MESSAGE_LANGUAGES` (`Data/Message-Languages.lua`), which loads everywhere. English (`Data.DEFAULT_MESSAGE_LANGUAGE`) whatever the client; a saved code no longer listed reads as English. Spell links still carry the sender's client's spell name.
- **Thank You whispers** go out unbranded through `ns:Whisper`, exactly as typed (a `README-Notes.md` exception), only to a same-faction target. `TrimToBytes` (Options-Thank-You-Button) caps the input on save without splitting a UTF-8 character.
- **Spell links** are hand-built in `ns.GetSpellLink` as `|Hspell:<id>:0|h` in `ns.SPELL_LINK_COLOR`. Classic's native link lacks `:0`, and `SendChatMessage`'s validator strips such a link to the bare name. Native is the fallback only for a spell with no name.
- **Durations** (`ns.FormatDuration`) use the client's `D_SECONDS` / `D_MINUTES` / `D_HOURS`. `ResolvePlurals` expands their `|4singular:plural;` escape, which `SendChatMessage` rejects; handles three-form Slavic plurals. `forceSeconds` keeps a fixed seconds menu in one unit; Wave's cooldown dropdown omits it and reads in minutes.

### Thank You Button

- **`Data.THANK_YOU_BUTTONS` is the whole definition**: per row `profileKey`, `macroName`, `command`, optional `singleEmote`. Defaults (`Data/Default-Settings.lua`), options sections (`AddButtonSection`), slash commands (`SlashCmdList["TFTB_THANKYOU<n>"]`, `Options/Options.lua`), macros and Diagnostics' Message Length rows are all generated from it.
- **`singleEmote` changes the stored shape**: `emote` (one token, `""` = none, a dropdown) instead of `emotes` (a set, a checklist). Button 1 has no `singleEmote` and is on by default; the rest start off. `RunThankYou` and the options panel branch on it.
- **`ns.ReconcileMacros`** makes the macro list match the profile: creates missing switched-on macros, re-icons ones that differ (`EditMacro(index, nil, icon)` keeps name and body), deletes switched-off ones. Runs at login, from `ns:ApplyProfile` (profile change / copy / reset), and on an icon pick. Re-reads `GetNumMacros()` per macro, stopping at `Data.MAX_GLOBAL_MACROS`. A button with no settings table is never reconciled downward.
- **Icons**: `ns.GetThankYouIcon` falls back to `Data.THANK_YOU_DEFAULT_ICON` when the saved icon isn't in this client's `ns.THANK_YOU_MACRO_ICONS`, since profiles travel between flavors. An icon row's second field names the button that starts on it (`startingIcons` in Default-Settings).
- **`ns.RunThankYou`** requires a player target that isn't you. When the target's identity is secret (WoW Forever), it skips both checks and the whisper but still emotes at `"target"`.

### Wave to Friends

`Features/Wave-To-Friends.lua`, settings in `ns.db.profile.wave`.

- **Gates, in `OnUpdateMouseoverUnit` order**: `wave.enabled`; `restingOnly` vs `IsResting()`; not in combat; `ns.IsMouseOverWorld()` (cursor on `WorldFrame`, never a unit frame or nameplate; `GetMouseFoci` or `GetMouseFocus` picked once at load); identity not secret; a player, not you; not in your party or raid; a plain GUID not on cooldown.
- **`PickGreeting`, first match wins**: Custom List (`customEnabled`, `players[full]` then `players[bare]`) → Friends (`friendsEnabled`, `C_FriendList.IsFriend`, plus `C_BattleNet.GetAccountInfoByGUID` when `bnetFriends`) → Guilds (`guilds[normalized]`, or your own guild when `myGuildEnabled`). Custom List returns one token (`ns:DoEmoteToken`); Friends and Guilds return a token set (`ns:DoRandomEmote`).
- **A Custom List entry set to None** returns `""`: still a match, so it blocks Friends and Guilds and spends the cooldown, and `DoEmoteToken` plays nothing. That is how a name is kept from ever being waved at.
- **Cooldown**: `waveCooldowns[guid]`, in memory, swept on write. `cooldown` comes from `Data.WAVE_COOLDOWN_CHOICES`; 0 is Once per Session, stored in the table as `math.huge` so the sweep never drops it and only a `/reload` ends it.
- **Name keys** (`ns.NormalizeWaveName`, `UnitKeys`): realm clients key `name` (any realm) or `name-realm`, with the realm's spaces, hyphens and apostrophes dropped (`NormalizeRealm`), because the client says `AzjolNerub` where players type `Azjol-Nerub`. WoW Forever (`REALM_FREE`) keys `first last` or `first`, a typed hyphen read as the space; `UnitNameUnmodified` is read first because `UnitName` can return the first name alone. Guild keys are `ns.NormalizeGuildName` (case and runs of spaces folded); the value keeps the name as typed.

### Ignored Buffs

`Features/Ignored-Buffs.lua`; panel in `Options/Options-Ignored-Buffs.lua`. Each entry matches one exact spell ID (a `README-Notes.md` exception).

- **Scopes**: All Characters in `ns.db.global.ignoredBuffs`, each character in its `char.ignoredBuffs`, all `[spellId] = true`. `ns.IsBuffIgnored` checks both for the character being played.
- **Scope keys**: `ns.LIST_SCOPE_GLOBAL` (asterisks, which no character name can contain) or an AceDB char key. `ns.GetIgnoredBuffsForScope` resolves the current character through `ns.db.char` (the table the praise check reads) and every other one straight from `ns.db.sv.char`, since AceDB materializes only the current character and strips empty tables at logout. Reads return nil there; writes pass `createIfMissing`.
- **Promote, not copy**: `ns.SetBuffIgnoredInScope(LIST_SCOPE_GLOBAL, id, true)` clears that ID off every character's list. Removing from All Characters restores it to no one.
- **Tree**: All Characters, a disabled blank row, then each character in class color (`ns.GetCharacterDisplayName`, from the `classToken` each saves at login). The current character always shows; others only with a non-empty list. Scope groups are keyed by scope key, not position, so the tree's remembered selection never jumps to another character. `ns.PrepareIgnoredBuffsTree` seeds `treewidth` and reselects the current character on every hide.
- **Adding**: from current buffs (`ns.GetPlayerBuffIds`, empty while auras are secret) or a box taking a spell ID or shift-clicked link (`ParseSpellId`). A buff All Characters already covers isn't offered or added to a character pane.

### Options Panels

- **Registration** (`ns.RegisterOptionsPanels`, `Options/Options.lua`), tree order: General (root), Give Thanks, Emotes List and Ignored Buffs (children of Give Thanks), Thank You Button, Wave to Friends, Profiles, Feedback & Support, Diagnostic Tools.
- **Registered as builder functions** (rebuilt every repaint): Ignored Buffs, Wave to Friends, Diagnostic Tools. Everything else is built once at login.
- **Sub-panels** pass Give Thanks' captured category ID (`ns.optionsFrames.strangersID`) as parent: `AddToBlizOptions` resolves a parent by name only among top-level panels.
- **Feature switches**: `ns.FEATURE_SWITCHES` (Options-Utilities) declares each switch once (Give Thanks, Wave to Friends). `ns.OptionsFeatureToggle` places it on the feature's panel and in General's Features section (`ns.OptionsTogglePairs`); both write through `ns.SetFeatureSwitch`, which repaints every panel.
- **`ns.HideAllExcept`** hides every arg not in `keep` while the switch is off. Runs over the finished args table, so later controls are covered; composes with an existing `hidden`. Wave's tabs are the exception: left out of the table while off (see Pitfalls).
- **Seconds dropdowns** (Give Thanks) offer `Data.SECONDS_CHOICES`, worded in seconds. `NearestChoice` shows the closest listed value without rewriting the saved one. Wave's cooldown `get` does the same but never snaps to or from 0.
- **Example lines** go through the real builders: print through `ns.GetPrintPrefix` + `ns:BuildStrangerMessage` with `ns.SAMPLE_NAMES.MAGE` (matching the Arcane Intellect sample); whispers through `ns.SampleWhisper` (`CHAT_WHISPER_GET`, the player's `ChatTypeInfo.WHISPER` color), with `{rt1}` swapped for its texture.
- **Whisper composer** (`DefineWhisperComposer`, Options-Give-Thanks), the house pattern for a message the player words and TFTB sends: Send Messages In, then label, Star caption, box, `// TFTB` caption and Reset on one row; under it the tokens, a red Too Long line once the message passes the chat ceiling in bytes (`ns.FillThanksWhisper` with the sample buff and `ns.SAMPLE_NAMES.MAGE`; no live count, since AceConfig redraws only on save), the Example line and Send Test to Me (`ns:WhisperThanksTest`, a real whisper to yourself). The marker and sign-off are captions, not text in the box, because `SignOff` adds them. Changing the language swaps the text only while it is still the old language's default.
- **Reset Emotes** on each grid is a confirmed `execute` writing back that grid's `defaults` (Give Thanks' is a `README-Notes.md` exception). General ends with Good to Go's links (`ns.GOOD_TO_GO_LINKS`), another exception.

### Diagnostics

`Diagnostics/` is the house framework. TFTB's parts are in `Diagnostics/Manifests.lua`:

- **Settings tab**: Buff Reactions Context (`ns:BuildContextReport`), Wave to Friends Context (`ns:BuildWaveContextReport`), Emote Extract (`ns:BuildEmoteReport`). Probes read feature state through accessors (`ns.IsBuffTrackingReady`, `ns.IsBuffTrackingSetUp`, `ns.GetPraiseCooldownState`, `ns.GetEmoteCatalog`, `ns.GetPickableEmotes`) so they show what the features act on.
- **Framework files carry TFTB edits**: `Report-Runner.lua` (`ns.DIAGNOSTIC_REPORTS` / `ns.DIAGNOSTIC_SECTIONS`: the `wave` report added, Display Context removed), `Diagnostics-Core.lua` (`WAVE_TITLE` / `WAVE_DESCRIPTION`), `Settings-Reports.lua` (Display Context removed).
- **Aura log lines**: `ns.DIAGNOSTIC_EVENT_EXCLUDE` drops both detection events (firehose; `UNIT_AURA`'s table can't print). Instead `ns:LogAuraApplied` logs every aura landing on you before any filter, with decoded flags and duration; `ns:LogAuraUpdate` (WoW Forever) logs each added helpful aura with the first gate that stopped it, or `read`; a `read` aura also carries its caster (`AuraCasterText`: GUID type, `self`, and group and friend flags where the aura names a unit, read the same way `ResolveAuraCaster` finds it) and its duration as Give Thanks reads it.
- **API rows** are flavor-split: WoW Forever adds the aura-caster, secret and `UnitNameUnmodified` rows; the rest add the combat-log and `GetNormalizedRealmName` rows.
- **Game Names** (`ns.DIAGNOSTIC_NAME_LOOKUPS`): `ns.GAME_IDS` spells, the duration strings, `Data.EMOTES` plus Wave's default tokens.
- **Message Length** (`ns.DIAGNOSTIC_MESSAGES`): the Give Thanks whisper with the sample spell, plus how long a buff link it can take; each set Thank You whisper; each macro body.
- **Data sources** (`ns.DIAGNOSTIC_DATA_SOURCES`): `Game-IDs` (`GAME_IDS`, `THANK_YOU_MACRO_ICONS`), `Emote-Groups` (`EMOTE_GROUP_BY_TOKEN`).

## Files That Change Together

- **New event**: `ns.EVENT_NAMES` in `Features/Core.lua` (under an `ns.FLAVOR` check if one client lacks it); `ns.EVENT_UNITS` for a fixed-unit event; handler via `ns.SetEventHandler` named `On<EventName>`. Never another frame; Diagnostics' Event Registration reads the same list.
- **New setting**: `ns.DATABASE_DEFAULTS` key; options row; enUS keys (translations are `07 - Localization Review.md`'s); a line in the feature's context report in `Diagnostics/Manifests.lua`.
- **New feature switch**: `ns.FEATURE_SWITCHES` row; locale keys; `ns.OptionsFeatureToggle` + `ns.HideAllExcept` on the feature's panel. General picks it up.
- **New options panel**: `ns.OPTIONS_REGISTRY` key (`Data/Data.lua`); its `Build...Options`; registration in `ns.RegisterOptionsPanels` at its tree position; a line in all four TOCs' Options block. `ns:ApplyProfile` and `ns.SetFeatureSwitch` notify every registry entry on their own.
- **New Thank You button**: a `Data.THANK_YOU_BUTTONS` row (`macroName` leading with `- `, unique `command`, `singleEmote` unless it randomizes over `Data.EMOTES`); optionally a starting icon in each `Game-IDs-{Game}.lua` (an unused row's second field). Defaults, section, command, macro and Message Length row generate.
- **New curated emote**: `Data.EMOTES` (token, never the command; confirm in Emote Extract on every TOC'd client); every `Emote-Groups-{Game}.lua` unless Text; release notes, since it appears ticked in every profile that never saved that key.
- **New emote grid**: `ns.DefineEmoteGrid` with a unique `id`, its own `key` / `defaults` / `registry` / `width`, in an args table no other grid shares.
- **New Wave greeting tier or list**: `PickGreeting` in `Features/Wave-To-Friends.lua`; `ns.DATABASE_DEFAULTS.profile.wave`; a tab in `Options/Options-Wave-To-Friends.lua`; `WaveTargetLines` and `ns:BuildWaveContextReport` in Manifests.
- **New feature file**: all four TOCs, in load order. Files that cache an `ns` function into a local at load (`local GetColor = ns.GetColor`; `Buff-Tracking.lua`'s `ns.HandleStrangersBuff`) must load after the file that defines it.
- **New global API call**: `.luacheckrc` `read_globals`; a row in `ns.DIAGNOSTIC_API_CHECKS` (flavor-split block when only one flavor has it).
- **New data table**: all seven `Data/{Game}/` folders (empty table where a flavor has no rows; Discovery guard pair in `Vanilla/` and `Discovery/`; a How We Got the Data block); each TOC's Data block with the other flavor files, after `Data/Data.lua` and ahead of `Data/Message-Languages.lua` and `Data/Default-Settings.lua`; a `ns.DIAGNOSTIC_DATA_SOURCES` row.
- **New sent-message language**: a `Data.MESSAGE_LANGUAGES` row (locale code, the language's own name, a default for every sent message). The dropdown, Reset and the fallback pick it up.
- **New context report**: builder in `Manifests.lua`; entry in `ns.DIAGNOSTIC_REPORTS` and its section in `ns.DIAGNOSTIC_SECTIONS` (`Report-Runner.lua`); title and description in `ns.DiagnosticsStrings` (`Diagnostics-Core.lua`).

## Saved Variables

- `TFTBDB`: the one SavedVariables table (`ns.SAVED_VARIABLES_NAME`), AceDB-3.0.
- **Simple model** (`AceDB:New("TFTBDB", ns.DATABASE_DEFAULTS, true)`): one shared `Default` profile holds every setting, Wave to Friends' Custom List and guilds included. **Reset Profile** puts all of that back to install defaults, so it empties the Custom List and guild list too.
- **Outside the profile**: `global.ignoredBuffs` (All Characters) and `char.ignoredBuffs` (per character, a `README-Notes.md` exception to the model rule), plus `char.classToken`. Reset Profile and profile switches never touch them.
- **Init order** (`InitializeDatabase`): `MigrateMessageLanguage`, `AceDB:New`, `PruneOtherClientCharacters`, the `messageLanguageMigrated` stamp, the settingsReset migration, `classToken`, then the `ApplyProfile` callbacks.
- **Default seeding**: `GetDefaultEmoteSettings(enabled)` builds `strangers.emotes` and `slash.emotes` with every `Data.EMOTES` token true; buttons 2 and up are generated off. Wave's `friendEmotes` / `guildEmotes` default to their own sets. All are settings maps, no seeded flag: a new default token appears ticked wherever the key was never saved. An unticked default is stored `false` (`model.SetChecked`), never nil.

### Migration Chain

1. `MIGRATION (remove after 2026-12-09)`, `InitializeDatabase`: nils the retired `ns.db.sv.settingsReset` stamp.
2. `MIGRATION (remove after 2027-02-11)`, `MigrateMessageLanguage` (Core): before `AceDB:New`, on the raw `TFTBDB`, every profile with whispers on and no `messageLanguage` gets the client's locale (when TFTB lists it and it isn't English), and the default text in it where none was saved. Stamped `sv.messageLanguageMigrated` once per account, fresh installs included, so a later pick of English sticks.

## Pitfalls & Why

- **Registering the combat log on WoW Forever**: `ADDON_ACTION_FORBIDDEN`, uncatchable by `pcall`. Core picks `UNIT_AURA` on Camelot.
- **Testing a secret value on WoW Forever**: comparing, concatenating or sending one errors. Every value from an aura, unit, friend lookup or `PerformEmote` passes `ns.IsPlain` first; `ns.AreAurasSecret` / `ns.IsUnitIdentitySecret` are asked before reads that can go secret. `UnitInRange` answers strangers with secrets even out of combat.
- **`PerformEmote(token, nil)`**: emotes at your current target, not at nobody. `ns:DoRandomEmote` / `ns:DoEmoteToken` refuse a nil target.
- **Directing an emote at `Name-Realm`**: the client never resolves it. `ResolveEmoteTarget` strips the realm.
- **Whispering a pet**: bounces with "No player named...". `IsPlayerGUID` guards every credited source.
- **Native spell links in chat**: Classic's lack `:0` and get stripped. Use `ns.GetSpellLink`.
- **Client duration strings in chat**: the `|4` escape gets the line rejected. Go through `ns.FormatDuration`.
- **Testing a buff duration for truthiness**: a live buff with no timer reports 0. `ns.GetBuffDuration` returns nil only when absent.
- **Leaving an unticked default emote nil**: AceDB refills it next login. Store `false`.
- **One AceConfig toggle per emote**: froze the panel on every click. Keep the emote checklist widget.
- **A bare custom widget type name**: AceGUI's widget registry is shared by every add-on, and `RegisterWidgetType` ignores a same-named type unless its version is higher, so another add-on's widget could draw TFTB's controls. Both TFTB types (`Options-Emote-Grid.lua`, `Options-Utilities.lua`) are built from `ADDON_NAME`; a new one follows suit.
- **Two emote grids in one args table**: `ns.DefineEmoteGrid` writes fixed arg keys (`emoteGridDesc`, `emoteGrid_<group>`, `emoteGridReset`), so the second overwrites the first. Wave puts each grid in its own tab.
- **Reusing a grid ID**: `models[gridId]` is overwritten and the first grid's widgets draw the second's settings.
- **Hiding Wave's tabs instead of omitting them**: AceConfigDialog still draws the empty bordered tab frame, because it reads a child group's `hidden` against the parent's path. `ns.BuildWaveToFriendsOptions` leaves them out while off and is registered as a builder so they return on the switch.
- **A Custom List None returning nil**: nil falls through to Friends and Guilds and waves anyway. `PickGreeting` returns `""`, a match that plays nothing.
- **Once per Session as a duration**: stored as setting `0`; `SetCooldown` turns it into `math.huge`. Treating 0 as zero seconds would wave on every mouseover, and snapping it to the nearest timer in `get` would show the wrong choice.
- **`UPDATE_MOUSEOVER_UNIT` from unit frames**: fires for raid frames and nameplates too. `ns.IsMouseOverWorld` keeps waves to the 3D world.
- **Reading a Forever surname with `UnitName`**: can return the first name alone, so a `first last` entry never matches. `UnitKeys` tries `UnitNameUnmodified` first.
- **Comparing realms as typed**: the client drops spaces, hyphens and apostrophes. `NormalizeRealm` folds both sides.
- **Writing another character's Ignored Buffs through `ns.db.char`**: that is the current character only. Go through `ns.GetIgnoredBuffsForScope`, which reaches `ns.db.sv.char` for the rest.
- **Keying tree groups by position**: the tree remembers the selection by arg key, so a shifting index reselects a different character. Key by scope.
- **Nesting a sub-panel by title**: `AddToBlizOptions` can't find a non-top-level parent by name. Pass the captured category ID.
- **A saved seconds value off the scale**: AceConfig draws an empty dropdown. `NearestChoice` shows the closest step without rewriting.
- **Welcome on `PLAYER_ENTERING_WORLD`**: refires every loading screen. `welcomeMessageShown` holds it to once.
- **Stale safety timers**: an earlier timer could end a newer pause. `safetyToken` prevents it.
- **Hoisting the macro count**: enabling several buttons on a nearly full list would overshoot. `ReconcileMacros` re-reads `GetNumMacros()` per macro.
- **Refreshing `Diagnostics/` from the framework source**: overwrites TFTB's edits to `Report-Runner.lua`, `Diagnostics-Core.lua` and `Settings-Reports.lua`, dropping Wave to Friends Context and restoring Display Context. Re-apply them.
- **`{spell}` and `{name}` in `Data.MESSAGE_LANGUAGES`**: gsub tokens, not format codes; translations must keep them verbatim. The whisper ceiling is bytes, so test overflow in ruRU.
- **Default whisper text in a Locales file**: only the client's own file loads, so an English client sending German would have no German text. Defaults for sent messages go in `Data.MESSAGE_LANGUAGES`.
