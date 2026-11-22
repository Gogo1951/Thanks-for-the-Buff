# Thanks for the Buff // Technical Reference

> Code map for working on Thanks for the Buff: where things live, how they connect, and the traps. Where this and the code disagree, the code wins. For players, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md).

## File Map

The packager installs the repo as `Interface/AddOns/TFTB/` (`package-as` in `.pkgmeta`), so `ADDON_NAME` is `TFTB` everywhere: the AceLocale name, every `ns.OPTIONS_REGISTRY` key, the sound path, the LibDataBroker and LibDBIcon name, the menu frame (`TFTBMenu`), the prefix of the custom AceGUI widget types.

```text
Thanks-for-the-Buff/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── config.yml                       Per-add-on New issue page links
│   │   ├── defect.yml                       Shared from Common-Core: the Defect form
│   │   └── request.yml                      Shared from Common-Core: the Request form
│   └── workflows/
│       ├── ci.yml                           Calls Common-Core: shared files, kits, externals, luac 5.1, luacheck, StyLua
│       ├── issue-labels.yml                 Calls Common-Core: labels a new Defect by its Issue Type
│       └── package.yml                      Calls Common-Core: library refresh, CurseForge and Wago upload
├── .gitattributes                           Shared from Common-Core
├── .gitignore                               Shared from Common-Core
├── .luacheckrc                              Lint config; a new global API goes in read_globals
├── .pkgmeta                                 Externals, package-as TFTB, ignore list (drops Data/Wrath, Data/Mainline)
├── TFTB_Vanilla.toc                         Classic Era, Season of Discovery included
├── TFTB_TBC.toc                             TBC Anniversary
├── TFTB_Camelot.toc                         WoW Forever; leaves out Good-News.lua and both Good News panels
├── TFTB_Mists.toc                           MoP Classic, the master list's Extra TOC
├── Data/
│   ├── Flavor.lua                           ns.FLAVOR from the TOC's X-Flavor, ns.EXPANSION, ns.IS_DISCOVERY, ns.DATA_FOLDER
│   ├── Data.lua                             Locale init, palette, registry, constants, Good News enums, Thank You rows, Return Buff spells, macro caps, curated emotes, links
│   ├── Message-Languages.lua                Send Messages In: each language's name and default whispers, loaded in every client
│   ├── Default-Settings.lua                 AceDB defaults; generates Thank You buttons 2 and up
│   ├── Vanilla/                             Classic Era; each file returns early on Season of Discovery
│   │   ├── Emote-Groups-Vanilla.lua         Emote token to Voice, Gesture or Pose
│   │   ├── Game-IDs-Vanilla.lua             Sample spells and the Thank You macro icons
│   │   └── Good-News-Abilities-Vanilla.lua  Good News' abilities and items; Return Buff reads the buffs too
│   ├── Discovery/                           Season of Discovery; listed after Vanilla/, inverse guard
│   ├── TBC/                                 Same three files per folder
│   ├── Camelot/                             Lists no RESURRECT row
│   ├── Mists/
│   ├── Wrath/                               Forward-prep, no TOC; empty icon list
│   └── Mainline/                            Forward-prep, no TOC; empty icon list
├── Diagnostics/                             Diagnostic Tools framework; Manifests.lua is TFTB's part
├── Features/
│   ├── Core.lua                             Version, AceDB init, prune, migrations, ApplyProfile, ns.EVENT_NAMES, dispatcher, login
│   ├── Utilities.lua                        Colors, client emote catalog, secret checks, emote blockers, mouse focus, TrimToBytes, spell links, auras, GUID to unit
│   ├── Announcements.lua                    Prints, signed-off whispers, Good News whisper and its send queue, emotes, duration strings
│   ├── Ignored-Buffs.lua                    Ignored Buffs storage by scope, character keys, current and recent buff IDs
│   ├── Praise.lua                           Praise cooldowns, emote target, whisper pick, the reaction to a stranger's buff
│   ├── Buff-Tracking.lua                    Detects a stranger's buff: combat log, or UNIT_AURA on WoW Forever; hands revives to Good News
│   ├── Good-News-Abilities.lua              Good News' ability lookup and row labels; every flavor loads it
│   ├── Good-News.lua                        Good News: recipient, pending casts, whisper; not on WoW Forever
│   ├── Thank-You-Button.lua                 The /thankyou commands' bodies and their macros
│   ├── Buff-Back.lua                        Return Buff: buffs on offer, rank by level, its macro
│   ├── Wave-To-Friends.lua                  Mouseover greeting: Custom List, Friends, Guilds, wave cooldowns
│   ├── Menu-Kit.lua                         Copied unchanged from Common-Core: the menu renderer
│   ├── Minimap-Menu.lua                     What the mini-map menu shows: feature blocks and their flyouts
│   └── Minimap-Button.lua                   LibDataBroker launcher and LibDBIcon button
├── Includes/
│   ├── Images/
│   │   ├── Menu-Arrow.tga                   Menu-Kit's sub-menu arrow
│   │   ├── Menu-Plate.tga                   Menu-Kit's plate
│   │   └── Thanks-for-the-Buff.tga          The TOCs' IconTexture
│   ├── Libraries/                           Vendored Ace3, LibDataBroker and LibDBIcon, refreshed from .pkgmeta on release
│   └── Sounds/
│       └── Buff.ogg                         The stranger-buff notification sound
├── Locales/
│   ├── enUS.lua                             Source strings
│   └── deDE.lua ... zhTW.lua                Ten translations
├── Options/
│   ├── Options-Kit.lua                      Copied unchanged from Common-Core: grid, row helpers, registration, opener, One Refresh
│   ├── Options-Utilities.lua                Kit strings, sample whisper, whisper composer, Send Messages In, ns.FEATURES, emote pickers
│   ├── Options-General.lua                  Root panel: pitch, welcome, mini-map switch, Features, /Commands, Good to Go links
│   ├── Options-Emote-Grid.lua               Custom AceGUI checklist widget; ns.DefineEmoteGrid
│   ├── Options-Give-Thanks.lua              Give Thanks: limits, whisper composer with three boxes, notifications
│   ├── Options-Emotes-List.lua              Sub-panel of Give Thanks: its emote grid
│   ├── Options-Ignored-Buffs.lua            Sub-panel of Give Thanks: scope tree, add, promote, remove
│   ├── Options-Return-Buff.lua              Sub-panel of Give Thanks: Return Buff switch, buff pick, Example
│   ├── Options-Good-News.lua                Good News: who gets it, whisper composer; inserts its ns.FEATURES row
│   ├── Options-Good-News-Abilities.lua      Sub-panel of Good News: Tracked Abilities checkboxes by class, then Items
│   ├── Options-Thank-You-Button.lua         One section per Thank You button; ns.MacroToggleRow
│   ├── Options-Wave-To-Friends.lua          Wave to Friends: rules, cooldown, Friends / Guilds / Custom List tabs
│   ├── Options-Profiles.lua                 Stock AceDBOptions table
│   ├── Options-Feedback-Support.lua
│   └── Options.lua                          Registration, /tftb and /thankyou commands
├── LICENSE
├── README.md
├── README-Notes.md                          TFTB's exceptions to the Style Guide
├── README-Technical.md                      This file
└── README-Testing.md                        Manual test plan
```

## Architecture

Five features. **Give Thanks** reacts when a friendly player outside your group buffs you. **Return Buff** keeps a macro aimed at that player with one of your own buffs; it sits under Give Thanks in the options tree but runs off its own switch. **Good News** whispers a player what you just cast on them, everywhere but WoW Forever. **Thank You Button** is up to `#Data.THANK_YOU_BUTTONS` slash commands, each with an optional macro, that emote at and whisper your target. **Wave to Friends** emotes at a friend, guildmate or listed name when you mouse over them in the world. A mini-map button opens a menu of Give Thanks' and Wave to Friends' settings. No key binding.

### Event Loop

- `Features/Core.lua` owns the only event frame. `ns.EVENT_NAMES` lists every event; feature files attach with `ns.SetEventHandler(event, handler)` (one handler per event, a second attach replaces). The dispatcher calls `ns:LogEvent` first when diagnostics logging is on, then the handler. Events in `ns.EVENT_UNITS` register through `RegisterUnitEvent` for those units only.

| Event | Handler | Purpose |
|---|---|---|
| `PLAYER_LOGIN` | `OnPlayerLogin` (Core) | `InitializeDatabase`, `ns.RegisterOptionsPanels`, `ns:RegisterMinimapButton`, `ns.SetupBuffTracking`, `ns.SetupGoodNews`, `ns:CreateAutoMacro`, in that order |
| `PLAYER_ENTERING_WORLD` | `OnPlayerEnteringWorld` (Core) | Welcome, once per session (`welcomeMessageShown`) |
| `LOADING_SCREEN_DISABLED` | `OnLoadingScreenDisabled` (Buff-Tracking) | Re-arms the safety pause |
| `UPDATE_MOUSEOVER_UNIT` | `OnUpdateMouseoverUnit` (Wave-To-Friends) | Wave to Friends; registered on every flavor, returns at once while the feature is off |
| `PLAYER_REGEN_ENABLED` | anonymous (Buff-Back) | Replays a Return Buff macro edit that combat held back |
| `COMBAT_LOG_EVENT_UNFILTERED` | `OnCombatLogEventUnfiltered` (Buff-Tracking) | Buff detection, every flavor but WoW Forever; your `SPELL_RESURRECT` goes to `ns.ClaimGoodNewsResurrect` |
| `UNIT_AURA` | `OnUnitAura` (Buff-Tracking) | Buff detection on WoW Forever only, `player` only |
| `UNIT_SPELLCAST_SENT` | `OnUnitSpellcastSent` (Good-News) | Good News: parks a tracked cast and its recipient; `player` and `pet`; not on WoW Forever |
| `UNIT_SPELLCAST_SUCCEEDED` | `OnUnitSpellcastSucceeded` (Good-News) | Good News: releases the parked whisper; same units and flavors |

- **Flavor-picked events, at load from `ns.FLAVOR`**: Core appends `UNIT_AURA` on Camelot; the combat log and both spellcast events everywhere else. Registering the combat log on WoW Forever errors uncatchably.
- **Safety pause** (`StartSafetyTimer`, Buff-Tracking): `isReady = false` for `Data.SAFETY_PAUSE` seconds at login and after every loading screen, so the auras reapplied on zoning don't read as fresh buffs. Each call bumps `safetyToken`; only the newest timer restores readiness. Both detection handlers return at their first line while not ready, and Good News' `OnUnitSpellcastSent` reads the same flag through `ns.IsBuffTrackingReady`.
- **Good News runs off spellcast events, never the combat log**, except the Jumper Cables case (`RESURRECT` rows), which waits for the combat log's revive.

### Combat Lockdown

Only Return Buff queues. Everything else refuses, or goes ahead without the blocked part:

- **Options opener**: `ns:OpenOptionsPanel` (Options-Kit) refuses first thing (Style Guide → Combat Guard). The menu's Edit Custom List row also skips its `SelectGroup` in combat.
- **Return Buff macro**: `ns.ReconcileBuffBack` sets `pending` in combat and returns; `PLAYER_REGEN_ENABLED` reruns it. So a stranger's buff mid-fight re-aims the macro once combat ends.
- **Thank You macros**: `ns.ReconcileMacros` and `ns:DeleteAutoMacro` return in combat, no queue. A macro toggle flipped mid-fight changes the setting; the macro catches up at the next login, profile change, toggle or icon pick.
- **Pick Up Macro** (`ns.MacroToggleRow`): disabled in combat.
- **Praise emotes**: `HandleStrangersBuff` counts the emote unavailable while `ns.GetEmoteBlocker()` names a reason, and `DeliverPraise` checks again at fire time, since the Praise Delay can carry it into a fight or a cast. Whispers still go out.
- **Notifications**: the print and sound fire in or out of combat.
- **Good News**: whispers in combat. A whisper due while `C_ChatInfo.InChatMessagingLockdown` (where the client has it) says yes, or secret, is dropped, not queued.
- **WoW Forever detection**: `OnUnitAura` skips every update in combat or while `ns.AreAurasSecret()`. A buff that lands then is never seen, so it neither thanks nor re-aims Return Buff.
- **Wave to Friends**: `OnUpdateMouseoverUnit` returns while `ns.GetEmoteBlocker()` names a reason.

### Emote Blockers

`ns.GetEmoteBlocker()` (`Features/Utilities.lua`) returns why an automatic emote must wait, or nil. Give Thanks and Wave to Friends ask it; Good News never emotes; the Thank You buttons don't, since a press is the player choosing to emote. No setting.

- `"combat"`: `InCombatLockdown()`.
- `"casting"`: `UnitCastingInfo` or `UnitChannelInfo` on `player` returns anything (a secret return counts). An animated emote cancels the cast.
- `"fishing pole"`: `ns.IsFishingPoleEquipped()`, the main-hand item's `C_Item.GetItemInfoInstant` class and subclass (Weapon, Fishing Pole), so it reads the same in every language. Covers the gap between casts as well as the Fishing channel itself.

### Give Thanks: Detect → Classify → Praise

**1. Detect** (`Features/Buff-Tracking.lua`)

- Combat log: only `SPELL_AURA_APPLIED` / `SPELL_AURA_REFRESH` whose dest is the cached `playerGUID`. REFRESH counts: a rebuff earns the same thanks.
- WoW Forever: `updateInfo.addedAuras` only, full updates skipped, so a recast of a buff you already have is not seen.

**2. Classify** (`Features/Buff-Tracking.lua`): a friendly player outside your group.

- Combat log: local `IsPlayerGUID(sourceGUID)` (the `Player-` prefix; the only proof the source is a player, which keeps pet names out of whispers), `COMBATLOG_OBJECT_REACTION_FRIENDLY`, `COMBATLOG_OBJECT_AFFILIATION_OUTSIDER` (affiliation, not a name lookup, because cross-realm names arrive `Name-Realm`), then `IsGroupMemberOrPet` as backstop.
- WoW Forever: `ResolveAuraCaster` credits through `aura.sourceUnit`, or with none (stranger out of nameplate range) through `C_UnitAuras.GetAuraCasterGUID` + `UnitNameFromGUID`. A pet is traded for its owner (`GetPetOwnerUnit`). Both the credited player and the raw caster are checked against the roster; `UnitIsFriend` is asked only when a unit token exists, since a GUID-only caster who buffed you can't be the other faction.
- `IsGroupMemberOrPet` scans the whole roster (members and pets) by GUID, then by name with realm spaces dropped, because the aura's unit token can be a nameplate, missing, or the pet's.

**3. Praise** (`HandleStrangersBuff`, `Features/Praise.lua`), in order:

1. `ns.SetBuffBackTarget(sourceName, sourceGUID)`: Return Buff's target, before any Give Thanks gate.
2. Return if `strangers.enabled` is off (the feature switch gates only what follows; detection, Return Buff and the diagnostics aura log keep running).
3. `ns.GetBuffDuration`: nil = not on you, stop. 0 = live buff with no timer, always passes.
4. Stop under `minBuffDuration`.
5. Print (`printEnabled`) and sound (`soundEnabled`). Never answer to cooldowns. Then `ns.RecordRecentBuff` for the Ignored Buffs picker and the menu's Recent list.
6. Stop if `ns.IsBuffIgnored(spellID)`.
7. Stop if `praise:all` or `praise:<guid>` is running.
8. Clear the whisper (toggle, `PickWhisper` finds a filled box, `TryWhisperCooldown`) and the emote (any `ns.GetPickableEmotes`, no `ns.GetEmoteBlocker()`). Stop if neither clears.
9. Stamp the cooldowns, hand off to `DeliverPraise` (waits `praiseDelay` when `praiseDelayEnabled`).

- Every gate settles before the delay timer, so a burst of buffs can't slip past a cooldown inside the delay window.
- **Three whisper boxes** (`whisperMessage`, `whisperMessage2`, `whisperMessage3`): `PickWhisper` picks one filled box at random at send time; empty boxes are skipped.
- The emote target resolves late, at fire time: `target`, `focus`, `mouseover` name whoever you point at in that instant.

### Praise Cooldowns

`sessionCooldowns` (`Features/Praise.lua`): one in-memory table, keys namespaced so the throttles never collide on one GUID.

| Key | Duration from | Meaning |
|---|---|---|
| `praise:all` | `praiseCooldown` (0 = off) | Since you praised anyone |
| `praise:<guid>` | `cooldown` | Since you praised this player |
| `whisper:<guid>` | `WHISPER_COOLDOWN` | Since you whispered this player; a floor no setting lowers, against the server's whisper squelch |

`SetCooldown` sweeps lapsed entries on every write. Nothing saved; `/reload` clears all. `ns.GetPraiseCooldownState` reads without stamping, for Diagnostics.

### Return Buff

Player name Return Buff; code name Buff Back (`Features/Buff-Back.lua`, `profile.buffBack`, `char.buffBack*`, Diagnostics' Buff Back Context). Panel `Options/Options-Return-Buff.lua`; data `Data.RETURN_BUFF_SPELLS`, `Data.RETURN_BUFF_RANK_GAP`, `Data.BUFF_BACK_MACRO`.

- **Buffs on offer** (`ns.GetBuffBackChoices`, read fresh each call since a character learns spells): this class's rank lists in `Data.RETURN_BUFF_SPELLS` (ranks this client has and this character knows), then this class's `AURA` rows from `ns.GetGoodNewsRows` that it knows. One entry per spell name, since the macro casts by name; sorted by name. Fills `ranksByChoice`.
- **Pick**: `char.buffBackSpell`, per character. `PickedSpell` falls back to the first on offer and saves it, so switching on makes a macro at once.
- **Target**: `ns.SetBuffBackTarget` (from Praise) saves `char.buffBackTarget` and `char.buffBackTargetLevel` (`LevelOf`: a held unit or a nameplate; false when unseen or secret), then reconciles while on.
- **Rank** (`ns.GetBuffBackRank`): only where `ns.EXPANSION <= 3` (spell ranks exist). The highest known rank whose learned level minus `RETURN_BUFF_RANK_GAP` the target's level reaches; the lowest when none does; no rank text for your highest. Rank text is `C_Spell.GetSpellSubtext`.
- **Macro** (`ns.ReconcileBuffBack`, chained from the end of `ns.ReconcileMacros`, so it runs at login, on profile change and on every Thank You reconcile): one account-wide macro, `/targetexact <name>` + `/cast <spell>(<rank>)` + `/targetlasttarget`, or a bare `/cast` before anyone has buffed this character. Created only under `Data.MAX_GLOBAL_MACROS`; edited when the body or icon (`Data.THANK_YOU_DEFAULT_ICON`) differs; deleted when switched off. A copy at an index past `Data.MAX_GLOBAL_MACROS` (a per-character macro from an earlier build) is deleted first.
- **No buff to cast** (a Warrior): the macro is left as the last character wrote it. The panel says so (`RETURN_BUFF_NONE`), and `ns.IsBuffBackBlockedByMacroCap` drives the macros-full line.

### Good News: Sent → Succeeded → Whisper

Two files. `Features/Good-News-Abilities.lua` (every flavor, since Return Buff reads it) builds the lookup; `Features/Good-News.lua` (not in `TFTB_Camelot.toc`) runs the feature. Settings in `ns.db.profile.goodNews`; rows in `ns.GOOD_NEWS_ABILITIES` (`Data/{Game}/Good-News-Abilities-{Game}.lua`).

- **Row shape**: `class` (nil = Items group), `detect` (`Data.GOOD_NEWS_DETECT`: `AURA`, `CAST`, `RESURRECT`), optional `labelItem` and `noDuration`, and `triggers`, each `{ spell, aura, item }` (one per rank or variant).
- **Lookup** (`BuildLookup`, once at login via `ns.SetupGoodNews`, lazily otherwise): `castLookup` is keyed by the trigger's **cast** spell ID, what the spellcast events carry. Each record holds its `watchedId` (the aura ID on an `AURA` row, else the cast), `itemId`, and `auraId` (the watched ID on an `AURA` row without `noDuration`, else nil = no duration in the whisper). A trigger whose spell and watched ID both fail `C_Spell.DoesSpellExist` is dropped; a row left empty is skipped. `RESURRECT` rows are skipped on Camelot. Every item named is `C_Item.RequestLoadItemDataByID`'d here so labels and links have names later. `ns.GetGoodNewsRows` serves the same build to the panel, Return Buff and Diagnostics; `ns.GetGoodNewsCastRecord` to the feature; `ns.GetGoodNewsRowLabel` labels a row.
- **Watched**: `ns.IsGoodNewsWatched(watchedId)` is `watched[id] ~= false`, so a row with no saved choice is ticked.
- **1. Sent** (`OnUnitSpellcastSent`): gates on `ns.db`, `ns.IsBuffTrackingReady()`, `enabled`, plain args, a watched record. `ResolveUnitByName` maps the target name back to a unit (`target`, `mouseover`, `focus`, then party or raid), skipping secret identities; an unmatched name is dropped, never guessed. The unit's GUID must start `Player-` and not be you. `scope ~= "ALWAYS"` requires `IsGroupMember` (a secret answer counts as no). The cast parks in `pending[castGUID]` with name, GUID, unit, `auraId`, the link (`AbilityLink`: the item's link for an item row, else `ns.GetBuffLink`) and a `resurrect` flag.
- **2. Succeeded** (`OnUnitSpellcastSucceeded`): pops the parked cast and calls `Announce`. A `resurrect` cast stays parked: Jumper Cables succeed whether or not the target gets up, so its whisper waits for `ns.ClaimGoodNewsResurrect` (called from Buff-Tracking on your `SPELL_RESURRECT`, matched on dest GUID and spell, since the combat log carries no castGUID).
- **3. Whisper** (`Announce`): `recent["guid:spellID"]` suppresses a repeat within `REPEAT_GAP`. After `AURA_SETTLE` it reads the duration off the held unit with `ns.GetBuffDuration`, only while auras and identity are plain and `ns.UnitHasGUID` still matches (the player may have retargeted), under `pcall`; then `ns:WhisperGoodNews`.
- **Lifetimes**: `Sweep` (on every Sent and claim) drops `pending` past `PENDING_TTL` (an interrupted cast) and `recent` past `REPEAT_GAP`. All in memory.
- **Whisper shape** (`Features/Announcements.lua`): `ns.FillGoodNewsWhisper` swaps `{spell}` for the whole ability phrase and `{name}` for the short name, then `SignOff`. The phrase is the link plus `ns.GetGoodNewsDurationClause` (`goodNewsFor` in the language messages go out in, `|4` plural resolved by `ResolvePlurals`) only when the rounded duration is between 0 and `GOOD_NEWS_MAX_SECONDS`, so one template covers buffs and one-shots:

  ```text
  {rt1} Good News! You have [Power Infusion] for 15 Seconds // TFTB
  ```

  `ns:BuildGoodNewsWhisper` falls back to `ns.GetDefaultGoodNewsWhisper()` past `ns.CHAT_MESSAGE_MAX_LENGTH`, like Give Thanks.
- **Send queue** (`QueueWhisper`): whispers go out `WHISPER_GAP` apart so a run of casts (scrolls round a raid) doesn't trip the chat squelch; an empty queue sends at once. `SendWhisper` drops a whisper while `C_ChatInfo.InChatMessagingLockdown()` returns true or secret. `ns:WhisperGoodNewsTest` (Send Test to Me) bypasses the queue.
- **Absent on WoW Forever**: `ns.ClaimGoodNewsResurrect`, `ns.BuildGoodNewsOptions` and the Good News `ns.FEATURES` row don't exist there. Buff-Tracking, `ns.RegisterOptionsPanels`, Manifests' wrapper and the Good News Context report each test for them first.

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

All in `Features/Announcements.lua` unless named.

- **Prints** open with `ns.GetPrintPrefix()` (`TFTB //`, a `README-Notes.md` exception). `ns:PrintMessage` wraps the body in the TEXT color only when it holds no `|c`, so an outer `|r` never cuts off an embedded link or class color. The stranger print is `MESSAGE_BUFFED` with the name class-colored from `GetPlayerInfoByGUID`.
- **Give Thanks whisper**: `ns.FillThanksWhisper` swaps `{spell}` in the picked box for the link and `{name}` for the buffer's short name (`Ambiguate`), then `SignOff` gives it the marker-and-brand shape:

  ```text
  {rt1} Thanks for the [Arcane Intellect] // TFTB
  ```

  `TrimSentBody` strips trailing `CLOSING_MARKS` and a leading `OPENING_MARKS` entry, matched as whole UTF-8 sequences. `ns:BuildThanksWhisper` is what sends: past `ns.CHAT_MESSAGE_MAX_LENGTH` with the link in, it sends `ns.GetDefaultThanksWhisper()` instead of being rejected.
- **Send Messages In** (`profile.messageLanguage`, read through `ns.GetMessageLanguage`) is the language other players read, separate from the UI's locale, one setting for Give Thanks and Good News. AceLocale loads only the client's own Locales file, so every language's sent defaults (`giveThanks`, `goodNews`, `goodNewsFor`) live in `Data.MESSAGE_LANGUAGES` (`Data/Message-Languages.lua`), which loads everywhere. English (`Data.DEFAULT_MESSAGE_LANGUAGE`) whatever the client; a saved code no longer listed reads as English. Spell links still carry the sender's client's spell name.
- **Language switch** (`ns.SetMessageLanguage`, Options-Utilities, called by the panel and the menu): for each `LANGUAGE_DEFAULTS` entry, swaps `whisperMessage` to the new language's default only when it still equals the old language's default; nobody's own words change.
- **Thank You whispers** go out unbranded through `ns:Whisper`, exactly as typed (a `README-Notes.md` exception), only to a same-faction target. `ns.FillThankYouWhisper` (Thank-You-Button) swaps `{name}` and cuts to `ns.CHAT_MESSAGE_MAX_LENGTH` with `ns.TrimToBytes`; the box is also cut on save. Default text is the client locale's `DEFAULT_WHISPER`, not a Send Messages In language (a `README-Notes.md` exception).
- **Spell links** are hand-built in `ns.GetSpellLink` (Utilities) as `|Hspell:<id>:0|h` in `ns.SPELL_LINK_COLOR`. Classic's native link lacks `:0`, and `SendChatMessage`'s validator strips such a link to the bare name. Native is the fallback only for a spell with no name.
- **Durations** (`ns.FormatDuration`) use the client's `D_SECONDS` / `D_MINUTES` / `D_HOURS`. `ResolvePlurals` expands their `|4singular:plural;` escape, which `SendChatMessage` rejects; handles three-form Slavic plurals. `forceSeconds` keeps a fixed seconds menu in one unit; Wave's cooldown dropdown omits it and reads in minutes.

### Thank You Button

- **`Data.THANK_YOU_BUTTONS` is the whole definition**: per row `profileKey`, `macroName`, `command`, optional `singleEmote`. Defaults (`Data/Default-Settings.lua`), options sections (`AddButtonSection`), slash commands (`SlashCmdList["TFTB_THANKYOU<n>"]`, `Options/Options.lua`), macros and Diagnostics' Message Length rows are all generated from it.
- **`singleEmote` changes the stored shape**: `emote` (one token, `""` = none, a dropdown) instead of `emotes` (a set, a checklist). Button 1 has no `singleEmote` and is on by default; the rest start off. `RunThankYou` and the options panel branch on it.
- **`ns.ReconcileMacros`** makes the macro list match the profile: creates missing switched-on macros, re-icons ones that differ (`EditMacro(index, nil, icon)` keeps name and body), deletes switched-off ones, then calls `ns.ReconcileBuffBack`. Runs at login, from `ns:ApplyProfile` (profile change / copy / reset), and on an icon pick. Re-reads `GetNumMacros()` per macro, stopping at `Data.MAX_GLOBAL_MACROS`. A button with no settings table is never reconciled downward.
- **Macro caps**: `Data.MAX_GLOBAL_MACROS` and `Data.MAX_CHARACTER_MACROS` read `Constants.MacroConsts` (Mists' engine), then the `MAX_ACCOUNT_MACROS` / `MAX_CHARACTER_MACROS` globals (Classic's), then a literal fallback.
- **Icons**: `ns.GetThankYouIcon` falls back to `Data.THANK_YOU_DEFAULT_ICON` when the saved icon isn't in this client's `ns.THANK_YOU_MACRO_ICONS`, since profiles travel between flavors. An icon row's second field names the button that starts on it (`startingIcons` in Default-Settings).
- **Pick Up Macro**: `ns.MacroToggleRow` (Options-Thank-You-Button) puts the macro switch and a `PickupMacro` button on one row; Return Buff's panel uses it too.
- **`ns.RunThankYou`** requires a player target that isn't you. When the target's identity is secret (WoW Forever), it skips both checks and the whisper but still emotes at `"target"`.

### Wave to Friends

`Features/Wave-To-Friends.lua`, settings in `ns.db.profile.wave`.

- **Gates, in `OnUpdateMouseoverUnit` order**: `wave.enabled`; `restingOnly` vs `IsResting()`; no `ns.GetEmoteBlocker()` (combat, casting, fishing pole); `ns.IsMouseOverWorld()` (cursor on `WorldFrame`, never a unit frame or nameplate; `GetMouseFoci` or `GetMouseFocus` picked once at load); identity not secret; a player, not you; not in your party or raid; a plain GUID not on cooldown.
- **`PickGreeting`, first match wins**: Custom List (`customEnabled`, `players[full]` then `players[bare]`) → Friends (`friendsEnabled`, `C_FriendList.IsFriend`, plus `C_BattleNet.GetAccountInfoByGUID` when `bnetFriends`) → Guilds (`guilds[normalized]`, or your own guild when `myGuildEnabled`). Custom List returns one token (`ns:DoEmoteToken`); Friends and Guilds return a token set (`ns:DoRandomEmote`).
- **A Custom List entry set to None** returns `""`: still a match, so it blocks Friends and Guilds and spends the cooldown, and `DoEmoteToken` plays nothing. That is how a name is kept from ever being waved at.
- **Cooldown**: `waveCooldowns[guid]`, in memory, swept on write. `cooldown` comes from `Data.WAVE_COOLDOWN_CHOICES`; 0 is Once per Session, stored in the table as `math.huge` so the sweep never drops it and only a `/reload` ends it.
- **Name keys** (`ns.NormalizeWaveName`, `UnitKeys`): realm clients key `name` (any realm) or `name-realm`, with the realm's spaces, hyphens and apostrophes dropped (`NormalizeRealm`), because the client says `AzjolNerub` where players type `Azjol-Nerub`. WoW Forever (`REALM_FREE`) keys `first last` or `first`, a typed hyphen read as the space; `UnitNameUnmodified` is read first because `UnitName` can return the first name alone. Guild keys are `ns.NormalizeGuildName` (case and runs of spaces folded); the value keeps the name as typed.

### Ignored Buffs

`Features/Ignored-Buffs.lua`; panel in `Options/Options-Ignored-Buffs.lua`. Each entry matches one exact spell ID (a `README-Notes.md` exception).

- **Scopes**: All Characters in `ns.db.global.ignoredBuffs`, each character in its `char.ignoredBuffs`, all `[spellId] = true`. `ns.IsBuffIgnored` checks both for the character being played.
- **Scope keys**: `ns.LIST_SCOPE_GLOBAL` (asterisks, which no character name can contain) or an AceDB char key. `ns.GetIgnoredBuffsForScope` resolves the current character through `ns.db.char` (the table the praise check reads) and every other one straight from `ns.db.sv.char`, since AceDB materializes only the current character and strips empty tables at logout. Reads return nil there; writes pass `createIfMissing`.
- **Promote, not copy**: `ns.SetBuffIgnoredInScope(LIST_SCOPE_GLOBAL, id, true)` clears that ID off every character's list. Removing from All Characters restores it to no one.
- **Tree**: All Characters, a disabled blank row, then each character in class color (`ns.GetCharacterDisplayName`, from the `classToken` each saves at login). The current character always shows; others only with a non-empty list. Scope groups are keyed by scope key, not position, so the tree's remembered selection never jumps to another character. `Kit.PrepareTree` (in `ns.RegisterOptionsPanels`) seeds the sidebar width and reselects the current character on every hide.
- **Adding**: a picker (`RecentChoices`) offering current buffs (`ns.GetPlayerBuffIds`, empty while auras are secret) then this session's worn-off stranger buffs (`ns.GetRecentBuffs`, labelled with the caster in class color), or a box taking a spell ID or shift-clicked link (`ParseSpellId`). A buff All Characters already covers isn't offered or added to a character pane.
- **Recent buffs** (`ns.RecordRecentBuff`, called by `HandleStrangersBuff` after the notification and before the ignore check): in memory, newest first, one entry per spell (latest caster wins), capped at `RECENT_BUFFS_MAX`. It exists because a player decides to ignore a buff right after its thank-you, by when a short one has worn off.

### Mini-map Button and Menu

- **Button** (`Features/Minimap-Button.lua`): a LibDataBroker launcher (`ns.dataBrokerObject`) wearing `Data.THANK_YOU_DEFAULT_ICON`, registered with LibDBIcon at login against `ns.db.profile.minimap`. `OnEnter` shows the menu on hover; `OnClick` hands every click to `ns.minimapMenu:HandleClick`. `ns:ApplyMinimapButton` re-reads the profile's table (from `ns:ApplyProfile` and the General panel's switch, which writes `minimap.hide`).
- **On Camelot and Mainline** the icon is sized, anchored and circle-masked directly on the LibDBIcon button rather than through `SetButtonIcon`.
- **Menu** (`Features/Minimap-Menu.lua` on `Features/Menu-Kit.lua`): `Kit.CreateMenu` with `BuildMainEntries` (header, one `Kit.FeatureBlock` per `ns.FEATURES` row that has a `BLOCKS` entry, then `Kit.OptionsRow`), `FLYOUTS` and `afterChange = ns.RefreshSettings`.
- **`BLOCKS`**, keyed by the feature's `setting`: Give Thanks (Right-Click, `giveThanks` flyout), Wave to Friends (Middle-Click, `wave` flyout). Good News has no block, so it stays panel-only. Shift + Middle-Click opens the options; Left-Click opens and holds the menu.
- **Flyouts**: `giveThanks` (whisper switch, Send Messages In, print, sound, the three limits, Praise Delay as one Off-or-length pick list, Emotes List count with a link to the panel, Recent buffs where a click ignores on this character, the ignored list where a click un-ignores in both scopes, capped by `IGNORED_LIST_MAX`); `wave` (resting, cooldown, who waves, a link to the Custom List tab). Both return nothing while their feature is off. Rows write the profile directly and the menu's `afterChange` refreshes.
- **Dropdown reads match the panels**: `Nearest` mirrors Give Thanks' `NearestChoice`, and `WaveCooldown` keeps 0 apart, so the menu and panel show the same choice for an off-scale saved value.

### Options Panels

All on `Options/Options-Kit.lua` (`ns.OptionsKit`): rows, widths, `Kit.Example`, `Kit.ResetRow`, `Kit.HideAllExcept`, `Kit.FeatureSwitch(es)`, `Kit.RegisterPanel`, `ns:OpenOptionsPanel`, and `ns.RefreshSettings`, which notifies every `ns.OPTIONS_REGISTRY` panel and redraws the open menu. Every setter ends there.

- **Registration** (`ns.RegisterOptionsPanels`, `Options/Options.lua`), tree order: General (root), Give Thanks, then its Emotes List, Ignored Buffs and Return Buff; Wave to Friends; Good News and Tracked Abilities (skipped on WoW Forever); Thank You Button; Profiles; Feedback & Support; Diagnostic Tools. Every panel registers as its builder, rebuilt on every repaint. A child passes its parent's registry key; the kit resolves it to the captured category ID.
- **Feature switches**: `ns.FEATURES` (Options-Utilities) lists Give Thanks and Wave to Friends; `Options/Options-Good-News.lua` inserts Good News at position 2 at load. General's Features section (`Kit.FeatureSwitches`), each feature panel's `Kit.FeatureSwitch` and the menu's blocks all read it. Return Buff is not in it: its switch is the macro toggle on its own panel.
- **`Kit.HideAllExcept`** hides every arg not in `keep` while the switch is off, run over the finished args table. Wave's tabs are the exception: left out of the table while off (see Pitfalls). Emotes List, Ignored Buffs and Tracked Abilities stay open while their feature is off and show a `Kit.StatusLine` saying so.
- **Seconds dropdowns** (Give Thanks) offer `Data.SECONDS_CHOICES`, worded in seconds. `NearestChoice` shows the closest listed value without rewriting the saved one. Wave's cooldown `get` does the same but never snaps to or from 0.
- **Example lines** go through the real builders: print through `ns.GetPrintPrefix` + `ns:BuildStrangerMessage` with `ns.SAMPLE_NAMES.MAGE` (matching the Arcane Intellect sample); whispers through `ns.SampleWhisper` (`CHAT_WHISPER_GET`, the player's `ChatTypeInfo.WHISPER` color), with `{rt1}` swapped for its texture by `ns.MarkerAsTexture`. Return Buff's Example names the saved target (or the house Priest) and the rank the macro would cast.
- **Whisper composer** (`ns.DefineWhisperComposer(args, spec, order)`, Options-Utilities), used by Give Thanks and Good News: Send Messages In; the message row (label, Star caption `ns.MARKER_TEXTURE`, box, `// TFTB` caption), repeated uncaptioned for each `spec.extraFields` box; the tokens line (plus `spec.tokensSuffix`); a red Too Long line once any filled box's `spec.fill` passes the chat ceiling in bytes (no live count, since AceConfig redraws only on save); Reset; the Example line (`spec.build`) and Send Test to Me (`spec.test`). Fills `order` through `order + 0.36`. The marker and sign-off are captions, not text in the box, because `SignOff` adds them.
- **Samples**: Give Thanks measures with `SAMPLE_BUFF_SPELL_ID` and `ns.SAMPLE_NAMES.MAGE`; Good News with `SAMPLE_GOOD_NEWS_SPELL_ID` (Power Infusion), the Mage, and `SAMPLE_SECONDS`, so its Example, Too Long and test all carry the duration clause.
- **Tracked Abilities** (`Options/Options-Good-News-Abilities.lua`): one full-width toggle per `ns.GetGoodNewsRows` row, inline groups per class (sorted by `LOCALIZED_CLASS_NAMES_MALE`, titled in class color) then Items; rows sorted by label. Arg keys are `"row" .. watchedIds[1]`; `set` writes every watched ID of the row.
- **Reset Emotes** on each grid is a confirmed `execute` writing back that grid's `defaults` (Give Thanks' is a `README-Notes.md` exception). General ends with Good to Go's links (`ns.GOOD_TO_GO_LINKS`), another exception.

### Diagnostics

`Diagnostics/` is the house framework. TFTB's parts are in `Diagnostics/Manifests.lua`:

- **Settings tab**: Buff Reactions Context (`ns:BuildContextReport`), Wave to Friends Context (`ns:BuildWaveContextReport`), Good News Context (`ns:BuildGoodNewsContextReport`, which says Good News isn't loaded on WoW Forever), Buff Back Context (`ns:BuildBuffBackContextReport`), Emote Extract (`ns:BuildEmoteReport`), then the framework's Saved Variables, Display Context and add-on list. Probes read feature state through accessors (`ns.IsBuffTrackingReady`, `ns.GetPraiseCooldownState`, `ns.GetEmoteCatalog`, `ns.GetGoodNewsRows`, `ns.GetBuffBackChoices`, `ns.GetBuffBackTarget` and the like) so they show what the features act on.
- **Framework files carry TFTB edits**: `Report-Runner.lua` (`ns.DIAGNOSTIC_REPORTS` / `ns.DIAGNOSTIC_SECTIONS`: the `wave`, `goodNews` and `buffBack` reports), `Diagnostics-Core.lua` (`WAVE_*`, `GOOD_NEWS_*`, `BUFF_BACK_*` strings), `Settings-Reports.lua` (the Saved Variables report's description of TFTB's settings), `Event-Log.lua` (`ns.DIAGNOSTIC_EVENT_EXCLUDE`, `ns.MESSAGE_ID_FILTERED_EVENTS`, `IsCorrelatedSpell`).
- **Aura log lines**: `ns.DIAGNOSTIC_EVENT_EXCLUDE` drops both detection events (firehose; `UNIT_AURA`'s table can't print). Instead `ns:LogAuraApplied` logs every aura landing on you before any filter, with decoded flags and duration; `ns:LogAuraUpdate` (WoW Forever) logs each added helpful aura with the first gate that stopped it, or `read`; a `read` aura also carries its caster (`AuraCasterText`, read the way `ResolveAuraCaster` finds it) and its duration as Give Thanks reads it.
- **Spellcast log lines**: `ns.MESSAGE_ID_FILTERED_EVENTS` names the spell ID's position in both spellcast events. `IsCorrelatedSpell` (built from `ns.GetGoodNewsRows`' `spellIds`, so it can't drift from the lookup) lets a tracked cast log in full; every other cast folds into a counter printed at the end.
- **Revive log line**: Manifests wraps `ns.ClaimGoodNewsResurrect` at load, where it exists, to log `RESURRECT` (spell, dest GUID) under `COMBAT_LOG_EVENT_UNFILTERED` before handing on, since the combat log itself is excluded. A Jumper Cables SUCCEEDED with no RESURRECT after it revived nobody.
- **API rows** (`ns.DIAGNOSTIC_API_CHECKS`) are flavor-split: WoW Forever adds the aura-caster, secret and `UnitNameUnmodified` rows; the rest add the combat-log and `GetNormalizedRealmName` rows. The macro calls Return Buff uses (`GetMacroBody`, `IsPlayerSpell`) are rows too.
- **Game Names** (`ns.DIAGNOSTIC_NAME_LOOKUPS`): `ns.GAME_IDS` spells, the duration strings, `Data.EMOTES` plus Wave's default tokens, each Good News row by its panel label then every other item a row casts, and each class heading.
- **Message Length** (`ns.DIAGNOSTIC_MESSAGES`): each filled Give Thanks box with the sample spell, plus how long a buff link it can take; the Good News whisper (where loaded) with the longest link this client tracks (`LongestGoodNewsLink`) at `GOOD_NEWS_LONGEST_SECONDS`; each set Thank You whisper; each Thank You macro body; the Return Buff macro at its longest for this character.
- **Data sources** (`ns.DIAGNOSTIC_DATA_SOURCES`): `Game-IDs` (`GAME_IDS`, `THANK_YOU_MACRO_ICONS`), `Emote-Groups` (`EMOTE_GROUP_BY_TOKEN`), `Good-News-Abilities` (`GOOD_NEWS_ABILITIES`, once as spells, once as items, via `CollectAbilityIds`). `Data.RETURN_BUFF_SPELLS` lives in `Data/Data.lua` and has no row.

## Files That Change Together

- **New event**: `ns.EVENT_NAMES` in `Features/Core.lua` (under the `ns.FLAVOR` check if one client lacks it); `ns.EVENT_UNITS` for a fixed-unit event; handler via `ns.SetEventHandler`. Never another frame; Diagnostics' Event Registration reads the same list.
- **New setting**: `ns.DATABASE_DEFAULTS` key; options row; its locale keys in `enUS.lua` and every other Locales file; a row in the feature's menu flyout when players change it mid-session; a line in the feature's context report in `Diagnostics/Manifests.lua`.
- **New feature switch**: an `ns.FEATURES` row (Options-Utilities, or inserted by the feature's own panel file when only some TOCs load it); locale keys; `Kit.FeatureSwitch` + `Kit.HideAllExcept` on the feature's panel. General picks it up; the menu needs a `BLOCKS` entry and a `FLYOUTS` function in `Features/Minimap-Menu.lua` to show it.
- **New options panel**: `ns.OPTIONS_REGISTRY` key (`Data/Data.lua`); its `Build...Options`; `Kit.RegisterPanel` in `ns.RegisterOptionsPanels` at its tree position (a child passes its parent's key); a line in each TOC's Options block that loads its feature. `ns.RefreshSettings` notifies it from then on.
- **New Thank You button**: a `Data.THANK_YOU_BUTTONS` row (`macroName` leading with `- `, unique `command`, `singleEmote` unless it randomizes over `Data.EMOTES`); optionally a starting icon in each `Game-IDs-{Game}.lua` (an unused row's second field). Defaults, section, command, macro and Message Length row generate.
- **New Return Buff buff**: a rank list, lowest first, under its class in `Data.RETURN_BUFF_SPELLS`. A class's Good News `AURA` rows join on their own, so a buff already there needs nothing.
- **New curated emote**: `Data.EMOTES` (token, never the command; confirm in Emote Extract on every TOC'd client); every `Emote-Groups-{Game}.lua` unless Text; release notes, since it appears ticked in every profile that never saved that key.
- **New emote grid**: `ns.DefineEmoteGrid` with a unique `id`, its own `key` / `defaults` / `registry` / `width`, in an args table no other grid shares.
- **New Wave greeting tier or list**: `PickGreeting` in `Features/Wave-To-Friends.lua`; `ns.DATABASE_DEFAULTS.profile.wave`; a tab in `Options/Options-Wave-To-Friends.lua`; the `wave` flyout; `WaveTargetLines` and `ns:BuildWaveContextReport` in Manifests.
- **New feature file**: every TOC that loads the feature, in load order (a Good News file goes in all but `TFTB_Camelot.toc`, and shared code nil-checks its `ns` functions). Files that cache an `ns` function into a local at load (`local GetColor = ns.GetColor`; `Buff-Tracking.lua`'s `ns.HandleStrangersBuff`) must load after the file that defines it.
- **New global API call**: `.luacheckrc` `read_globals`; a row in `ns.DIAGNOSTIC_API_CHECKS` (flavor-split block when only one flavor has it).
- **New data table**: all seven `Data/{Game}/` folders (empty table where a flavor has no rows; Discovery guard pair in `Vanilla/` and `Discovery/`; a How We Got the Data block); each TOC's Data block with the other flavor files, after `Data/Data.lua` and ahead of `Data/Message-Languages.lua` and `Data/Default-Settings.lua`; a `ns.DIAGNOSTIC_DATA_SOURCES` row.
- **New sent-message language**: a `Data.MESSAGE_LANGUAGES` row (locale code, the language's own name, `giveThanks`, `goodNews`, and `goodNewsFor` with its `|4` plural). The dropdown, the menu's language flyout, Reset and the fallback pick it up.
- **New sent-message field** (another composer's default): a key in every `Data.MESSAGE_LANGUAGES` row; a `ns.GetDefault...Whisper` getter in `Data/Message-Languages.lua`; the `ns.DATABASE_DEFAULTS` default built from it; a `LANGUAGE_DEFAULTS` entry in Options-Utilities so Send Messages In swaps it; a `ns.DefineWhisperComposer` call with its `spec`; a Message Length row in Manifests.
- **New Good News ability**: a row in each `Good-News-Abilities-{Game}.lua` whose client has it, every rank as its own trigger. The lookup, panel, log filter, Game Names, Validate Data and (for a class `AURA` row) Return Buff all read the rows. A cast whose ID differs from its aura needs `aura` on an `AURA` trigger; one with no aura is `CAST`; one that can fail is `RESURRECT` and never goes in the Camelot file.
- **Good News' duration cap**: `GOOD_NEWS_MAX_SECONDS` (`Features/Announcements.lua`) and `GOOD_NEWS_LONGEST_SECONDS` (`Diagnostics/Manifests.lua`, one under it) move together.
- **New context report**: builder in `Manifests.lua`; entry in `ns.DIAGNOSTIC_REPORTS` and its section's `reports` list in `ns.DIAGNOSTIC_SECTIONS` (`Report-Runner.lua`); title and description in `ns.DiagnosticsStrings` (`Diagnostics-Core.lua`).

## Saved Variables

- `TFTBDB`: the one SavedVariables table (`ns.SAVED_VARIABLES_NAME`), AceDB-3.0.
- **Simple model** (`AceDB:New("TFTBDB", ns.DATABASE_DEFAULTS, true)`): one shared `Default` profile holds every setting: Give Thanks' three whisper boxes, Good News' text and ticked abilities, Wave to Friends' Custom List and guilds, the Return Buff switch, and the mini-map button's place and switch. **Reset Profile** puts all of that back to install defaults, so it empties the Custom List and guild list, re-ticks every Good News ability, shows the mini-map button at its default place, and turns Return Buff off; `ns:ApplyProfile` then deletes its macro and any Thank You 2–5 macros.
- **Outside the profile**: `global.ignoredBuffs` (All Characters) and, per character, `char.ignoredBuffs`, `char.buffBackSpell`, `char.buffBackTarget` and `char.buffBackTargetLevel` (a `README-Notes.md` exception to the model rule), plus `char.classToken`. Reset Profile and profile switches never touch them.
- **Init order** (`InitializeDatabase`): `MigrateMessageLanguage`, `AceDB:New`, `PruneOtherClientCharacters`, the `messageLanguageMigrated` stamp, the settingsReset migration, the Good News key cleanup, `classToken`, then the `ApplyProfile` callbacks.
- **Default seeding**: `GetDefaultEmoteSettings(enabled)` builds `strangers.emotes` and `slash.emotes` with every `Data.EMOTES` token true; buttons 2 and up are generated off. Wave's `friendEmotes` / `guildEmotes` default to their own sets. All are settings maps, no seeded flag: a new default token appears ticked wherever the key was never saved. An unticked default is stored `false` (`model.SetChecked`), never nil. Good News' `watched` starts empty and reads absent as ticked, so a new ability row arrives ticked; an untick is stored `false` under every watched ID of the row.
- **Whisper text defaults** (`strangers.whisperMessage`, `goodNews.whisperMessage`) are built in English (`Data.DEFAULT_MESSAGE_LANGUAGE`) at load, whatever `messageLanguage` holds. `whisperMessage2` and `whisperMessage3` start empty.

### Migration Chain

1. `MIGRATION (remove after 2027-02-11)`, `MigrateMessageLanguage` (Core): before `AceDB:New`, on the raw `TFTBDB`, every profile with whispers on and no `messageLanguage` gets the client's locale (when TFTB lists it and it isn't English), and the default text in it where none was saved. Stamped `sv.messageLanguageMigrated` once per account, fresh installs included, so a later pick of English sticks. Touches only `strangers`.
2. `MIGRATION (remove after 2026-12-09)`, `InitializeDatabase`: nils the retired `ns.db.sv.settingsReset` stamp.
3. `MIGRATION (remove after 2026-12-14)`, `InitializeDatabase`: in every profile, nils an earlier TFTB's `goodNews.whisperEnabled` and `goodNews.message` (a `%a`-token text this version doesn't read). `scope` and `watched` already use today's keys and carry over.

## Pitfalls & Why

- **Registering the combat log on WoW Forever**: `ADDON_ACTION_FORBIDDEN`, uncatchable by `pcall`. Core picks `UNIT_AURA` on Camelot.
- **Testing a secret value on WoW Forever**: comparing, concatenating or sending one errors. Every value from an aura, unit, friend lookup or `PerformEmote` passes `ns.IsPlain` first; `ns.AreAurasSecret` / `ns.IsUnitIdentitySecret` are asked before reads that can go secret. `UnitInRange` answers strangers with secrets even out of combat.
- **Calling Good News code on WoW Forever**: `Good-News.lua` and its panels aren't loaded there, so `ns.ClaimGoodNewsResurrect`, `ns.BuildGoodNewsOptions` and the Good News `ns.FEATURES` row are nil. Test before calling. `Good-News-Abilities.lua` must stay in every TOC: Return Buff reads `ns.GetGoodNewsRows`.
- **Two names for one feature**: players see Return Buff; the code, saved keys and Diagnostics say Buff Back. Search both.
- **Editing a macro in combat**: the game refuses. Return Buff defers through `pending` and `PLAYER_REGEN_ENABLED`; the Thank You macros skip and catch up at the next reconcile.
- **`[target=Name]` in the Return Buff macro**: resolves only a party or raid member, never a stranger. The body uses `/targetexact`, `/cast`, `/targetlasttarget`.
- **Deleting the Return Buff macro on a class with no buff**: it is account-wide, so that would pull it off every character's bars. `ns.ReconcileBuffBack` leaves it as the last character wrote it; only switching off deletes it.
- **Offering a buff twice under one name**: the macro casts by name, so two entries named alike would cast the same thing. `ns.GetBuffBackChoices` keeps one entry per name.
- **Rank text off Wrath and earlier**: later clients have no ranks. `ns.GetBuffBackRank` returns the plain spell unless `ns.EXPANSION <= 3` (WoW Forever counts as 1).
- **`PerformEmote(token, nil)`**: emotes at your current target, not at nobody. `ns:DoRandomEmote` / `ns:DoEmoteToken` refuse a nil target.
- **Directing an emote at `Name-Realm`**: the client never resolves it. `ResolveEmoteTarget` strips the realm.
- **Whispering a pet**: bounces with "No player named...". `IsPlayerGUID` guards every credited source.
- **Native spell links in chat**: Classic's lack `:0` and get stripped. Use `ns.GetSpellLink`.
- **Client duration strings in chat**: the `|4` escape gets the line rejected. Go through `ns.FormatDuration`.
- **Testing a buff duration for truthiness**: a live buff with no timer reports 0. `ns.GetBuffDuration` returns nil only when absent.
- **Leaving an unticked default emote nil**: AceDB refills it next login. Store `false`.
- **One AceConfig toggle per emote**: froze the panel on every click. Keep the emote checklist widget.
- **A bare custom widget type name**: AceGUI's widget registry is shared by every add-on, and `RegisterWidgetType` ignores a same-named type unless its version is higher, so another add-on's widget could draw TFTB's controls. The emote checklist's type is built from `ADDON_NAME`; a new one follows suit.
- **Two emote grids in one args table**: `ns.DefineEmoteGrid` writes fixed arg keys (`emoteGridDesc`, `emoteGrid_<group>`, `emoteGridReset`), so the second overwrites the first. Wave puts each grid in its own tab.
- **Reusing a grid ID**: `models[gridId]` is overwritten and the first grid's widgets draw the second's settings.
- **Hiding Wave's tabs instead of omitting them**: AceConfigDialog still draws the empty bordered tab frame, because it reads a child group's `hidden` against the parent's path. `ns.BuildWaveToFriendsOptions` leaves them out while off; it is rebuilt every repaint, so they return on the switch.
- **A Custom List None returning nil**: nil falls through to Friends and Guilds and waves anyway. `PickGreeting` returns `""`, a match that plays nothing.
- **Once per Session as a duration**: stored as setting `0`; `SetCooldown` turns it into `math.huge`. Treating 0 as zero seconds would wave on every mouseover, and snapping it to the nearest timer in a `get` (panel or menu) would show the wrong choice.
- **`UPDATE_MOUSEOVER_UNIT` from unit frames**: fires for raid frames and nameplates too. `ns.IsMouseOverWorld` keeps waves to the 3D world.
- **Reading a Forever surname with `UnitName`**: can return the first name alone, so a `first last` entry never matches. `UnitKeys` tries `UnitNameUnmodified` first.
- **Comparing realms as typed**: the client drops spaces, hyphens and apostrophes. `NormalizeRealm` folds both sides.
- **Writing another character's Ignored Buffs through `ns.db.char`**: that is the current character only. Go through `ns.GetIgnoredBuffsForScope`, which reaches `ns.db.sv.char` for the rest.
- **Keying tree groups by position**: the tree remembers the selection by arg key, so a shifting index reselects a different character. Key by scope.
- **A saved seconds value off the scale**: AceConfig draws an empty dropdown. `NearestChoice` (and the menu's `Nearest`) shows the closest step without rewriting.
- **Welcome on `PLAYER_ENTERING_WORLD`**: refires every loading screen. `welcomeMessageShown` holds it to once.
- **Stale safety timers**: an earlier timer could end a newer pause. `safetyToken` prevents it.
- **Hoisting the macro count**: enabling several buttons on a nearly full list would overshoot. `ReconcileMacros` re-reads `GetNumMacros()` per macro.
- **LibDBIcon's `SetButtonIcon` on WoW Forever and Mainline**: it runs `ResetButtonIcon`, which calls `icon:UpdateCoord()` and errors when another add-on has replaced the button's icon. `ns:RegisterMinimapButton` sizes and masks the icon directly.
- **Refreshing `Diagnostics/` from the framework source**: overwrites TFTB's edits to `Report-Runner.lua`, `Diagnostics-Core.lua`, `Settings-Reports.lua` and `Event-Log.lua`, dropping the Wave to Friends, Good News and Buff Back Context reports and the spellcast filter. Re-apply them.
- **Extra whisper boxes and the language switch**: Reset, Send Messages In's swap, the Example and Send Test to Me all read `whisperMessage` only. Boxes 2 and 3 keep whatever language they were typed in.
- **`{spell}`, `{name}` and `{seconds}` in `Data.MESSAGE_LANGUAGES`**: gsub tokens, not format codes; translations must keep them verbatim. The whisper ceiling is bytes, so test overflow in ruRU.
- **Default whisper text in a Locales file**: only the client's own file loads, so an English client sending German would have no German text. Defaults for sent messages go in `Data.MESSAGE_LANGUAGES`.
- **A plain unit word after `{seconds}` in `goodNewsFor`**: reads "1 Seconds". Write it as `|4one:many;` (three forms for ruRU); `GoodNewsAbility` resolves it through `ResolvePlurals`, since `SendChatMessage` rejects a raw `|4`.
- **Keying Good News by the aura ID**: the spellcast events carry the cast ID, which differs from the aura on rows like Misdirection. `castLookup` is keyed by cast; the checkbox is saved under the watched (aura) ID.
- **Saving one rank's checkbox**: the other ranks still read ticked. The toggle's `set` writes every `watchedIds` entry.
- **Announcing Jumper Cables on SUCCEEDED**: the cast succeeds whether or not the target revives. `RESURRECT` casts stay parked until `ns.ClaimGoodNewsResurrect`; `Sweep` runs first there so a failed jolt's stale record can't be claimed by a later revive.
- **A `RESURRECT` row on WoW Forever**: its combat log is closed to add-ons, so the whisper would never release. `BuildLookup` drops such rows on Camelot, and the Camelot file lists none.
- **Caching `ns.ClaimGoodNewsResurrect` in a local**: Manifests replaces it at load with a logging wrapper, so Buff-Tracking reads it through `ns` at call time; a cached copy would bypass the RESURRECT log line.
- **Reading the duration at SUCCEEDED**: the aura hasn't landed yet. `Announce` waits `AURA_SETTLE` and re-checks `ns.UnitHasGUID`, since `target` or `mouseover` may name someone else by then.
- **Guessing a recipient from the cast's target name**: `UNIT_SPELLCAST_SENT` gives a name, no unit or GUID, and nothing proves a bare name isn't a pet (a whisper to one bounces). `ResolveUnitByName` must find a held unit with a `Player-` GUID or the cast is dropped.
- **Sending each Good News whisper at once**: a run of casts trips the server's chat squelch. `QueueWhisper` spaces them `WHISPER_GAP` apart.
- **A stale or unknown `goodNews.scope`**: anything but `"ALWAYS"` reads as `GROUP`, in the feature and the dropdown's `get`, so a bad value whispers fewer people and never shows blank.
- **Good News text on a profile already set to another language**: `goodNews.whisperMessage` defaults to the English text, and `ns.SetMessageLanguage` swaps only text equal to the current language's default, so such a profile shows and sends English until Reset. `MigrateMessageLanguage` covers Give Thanks only.
