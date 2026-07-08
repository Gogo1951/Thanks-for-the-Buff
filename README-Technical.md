# Thanks for the Buff (TFTB) — Technical Reference

This document combines architecture notes and contribution guidance for developers working on Thanks for the Buff. For end-user documentation, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md).

## File Map

```
TFTB/
├── TFTB.toc                              Load order, metadata, ## SavedVariables: TFTB_DB, supported Interface versions
├── Data/
│   ├── Data.lua                          Palette, class colors, Data.TRACKED (every tracked reaction), Data.EMOTES, ns.OPTIONS_REGISTRY, constants
│   └── Default-Settings.lua              ns.DATABASE_DEFAULTS — the AceDB-3.0 defaults tree (profile + empty global)
├── Features/
│   ├── Core.lua                          Login sequence, the single event dispatcher + ns.EVENT_NAMES, AceDB init + migrations, ResetAllProfiles
│   ├── Utilities.lua                     Color accessor; spell / item / aura API compatibility shims (C_* vs. global fallbacks)
│   ├── Announcements.lua                 Print / whisper / emote helpers; message composition and branding
│   ├── Buff-Tracking.lua                 The reaction engine: lookups, display groups, combat-log & unit-cast handlers, source resolution, cooldowns
│   ├── Thank-You-Button.lua              Auto-macro creation + /thankyou command body
│   └── Diagnostics.lua                   Runtime-only bug-report probes (developer strings, never localized; nothing persisted)
├── Options/
│   ├── Options.lua                       Registers every panel with AceConfig; /tftb and /thankyou slash registration; OpenOptions
│   ├── Options-Utilities.lua             Shared option helpers + BuildBuffPanel/DefineEntryToggle scaffold reused by Teammates & Services
│   ├── Options-General.lua               General panel: welcome toggle, /commands, support links, version
│   ├── Options-Buffs-from-Strangers.lua  Strangers panel
│   ├── Options-Buffs-from-Teammates.lua  Teammates panel (one inline group per class, then a generic Items group)
│   ├── Options-Buff-Services.lua         Group Services panel (one flat tracked list)
│   ├── Options-Thank-You-Button.lua      Thank You Button panel
│   ├── Options-Profiles.lua              AceDBOptions-3.0 profiles table + the custom "Reset All Profiles" control
│   └── Options-Diagnostics.lua           Diagnostic Tools panel (every control gated behind an enable toggle)
├── Locales/
│   ├── enUS.lua                          Default locale — NewLocale(..., true); the source of truth for every string
│   └── deDE · esES · esMX · frFR · itIT · koKR · ptBR · ruRU · zhCN · zhTW   Translations
└── Includes/
    ├── Images/Thanks-for-the-Buff.tga    Addon icon (## IconTexture)
    └── Libraries/                         Vendored Ace3 (LibStub, CallbackHandler-1.0, AceLocale/DB/DBOptions/GUI/Config-3.0) — do not edit
```

The `.toc` declares `## Interface: 11508, 20506` (Classic Era 1.15.x and TBC Anniversary 2.5.x). `Data.TRACKED`, however, is a cross-client *superset* — it carries spell and item IDs from later expansions too. The build phase prunes anything the running client doesn't know via `ns.DoesSpellExist`, so a single data table serves every supported client. See **Scan → Build → React** and **API Compatibility** below.

## Architecture

### Event Loop

Every game event the addon cares about flows through **one** frame, created in [Core.lua](Features/Core.lua). Feature modules never create their own event frames; they attach handlers by name through `ns.SetEventHandler(event, handler)`:

```lua
eventFrame:SetScript("OnEvent", function(_, event, ...)
    if ns.diagnostics and ns.diagnostics.logging then
        ns:LogEvent(event, ...)          -- the single tap the Diagnostics event log relies on
    end
    local handler = eventHandlers[event]
    if handler then handler(...) end
end)
```

The single dispatcher is deliberate: it is the one place that sees every event, which is what lets the Diagnostic Tools event log capture them all from one tap. The registered set lives in `ns.EVENT_NAMES` (Core.lua) — the frame registers from it and Diagnostics reads it, so the registered events, the log's tap, and the event-registration probe can never drift. **Each event has a single owner**: attaching the same event twice replaces the earlier handler, so two modules must not claim the same event.

| Event | Handler | File |
| --- | --- | --- |
| `PLAYER_LOGIN` | `OnPlayerLogin` | Core.lua |
| `PLAYER_ENTERING_WORLD` | `OnPlayerEnteringWorld` | Core.lua |
| `COMBAT_LOG_EVENT_UNFILTERED` | `OnCombatLogEvent` | Buff-Tracking.lua |
| `UNIT_SPELLCAST_SUCCEEDED` | `OnUnitSpellcastSucceeded` | Buff-Tracking.lua |
| `LOADING_SCREEN_DISABLED` | `OnLoadingScreenDisabled` | Buff-Tracking.lua |

`COMBAT_LOG_EVENT_UNFILTERED` is the firehose; everything in `OnCombatLogEvent` is ordered cheapest-check-first so the common case (an event we don't react to) bails fast.

### Login Sequence

`OnPlayerLogin` owns ordering, because later steps depend on earlier ones: saved variables must exist before any feature reads them, and the display groups must exist before the options panels that render them.

```
InitializeDatabase()    -- AceDB:New + one-time migrations, sets ns.db
SetupBuffTracking()     -- build lookups & display groups (spell/item APIs are live now)
SetupOptions()          -- register AceConfig panels (consume the display groups)
CreateAutoMacro()       -- create the "- Thank" macro if enabled
```

Core only calls these hooks in order; the logic lives in the feature modules. The welcome message prints later, on the first `PLAYER_ENTERING_WORLD`, guarded by a `welcomeMessageShown` flag so a mid-session zone-in never reprints it.

### Scan → Build → React

`ns.SetupBuffTracking` ([Buff-Tracking.lua](Features/Buff-Tracking.lua)) runs once at login, after the spell/item APIs return real data, and reshapes `Data.TRACKED` into the products the rest of the addon consumes:

- **`auraLookup` / `castLookup`** (`BuildLookups`) — two tables keyed by the ID the combat log carries (`SPELL_AURA_APPLIED` aura ID vs. `SPELL_CAST_SUCCESS` cast ID). Detection is a single table lookup per event. An item trigger's own `spell` id is the watched id; a spell trigger may name a separate `aura` id.
- **`ns.TeammateCategories`** (`BuildDisplayGroups`) — ordered categories for the Teammates panel: one per class (class-colored, alphabetical), then a generic **Items** group.
- **`ns.ServiceEntries`** — a flat list for the Group Services panel.
- **`ns.DIAGNOSTIC_SPELLS` / `ns.DIAGNOSTIC_TRACKED`** — per-class ability IDs and live/total coverage counts for the diagnostics context report.

Client coverage is enforced here. For each trigger, `BuildLookups` and `BuildDisplayGroups` call `ns.DoesSpellExist`; a trigger whose spell is absent on the running client is dropped, and a tracked entry left with no live triggers is skipped entirely. One `Data.TRACKED` entry becomes exactly one options toggle.

**React** happens on the live path. `OnCombatLogEvent` looks the spell ID up in `auraLookup`/`castLookup`, classifies the source by **combat-log affiliation flags** (never by name), and routes to a handler:

- **Group member** — `AFFILIATION_MINE`/`PARTY`/`RAID` set → `HandleTracked` (Teammates or Services settings).
- **Stranger** — a `HELPFUL` aura that landed on the player from a `TYPE_PLAYER`, `REACTION_FRIENDLY`, `AFFILIATION_OUTSIDER` source → `HandleStrangersBuff`.

Two source-resolution wrinkles are handled before classification:

- **Pets and guardians.** A buff's source can be a pet (a hunter's Roar of Sacrifice, for example). `ResolveSource` → `GetPetOwnerUnit` matches the pet GUID to a group pet unit and credits the **owner**, so the message names the player.
- **Cross-realm names.** A name-based group check misses cross-realm sources, whose combat-log name is `Name-Realm`. Classification therefore uses affiliation flags exclusively. The `creditGUID ~= playerGUID` guard stops a self-cast (Roar of Sacrifice on yourself) from crediting you, since `MINE` also covers your own pet.

**Group services take a second path.** Portals, summons, feasts, soulwells and repair bots don't reliably reach `COMBAT_LOG_EVENT_UNFILTERED`, so they are announced from `UNIT_SPELLCAST_SUCCEEDED` (`OnUnitSpellcastSucceeded`) instead, for any unit the client tracks (party/raid, target, focus). `SERVICE` casts that *do* surface on the combat log are dropped there to avoid a double-announce. A service has no per-you destination, so crediting the casting unit is all that's needed — which is also why solo casts (Rebirth, Lay on Hands) stay on the combat log, where the destination confirms the buff landed on *you*.

### Combat Lockdown & Safety Timer

Two gates suppress reactions; neither uses a deferral queue.

- **Safety Timer (`isReady`).** `StartSafetyTimer` clears `isReady` and re-arms it after `Data.SAFETY_PAUSE` (3s) via `C_Timer.After`. It fires at login and on every `LOADING_SCREEN_DISABLED`, so buffs that "land" while the world is still settling are ignored rather than spamming you on every zone-in. A monotonic `safetyToken` invalidates earlier timers, so back-to-back loading screens can't let a stale callback flip readiness back on mid-pause.
- **Combat.** Emotes are visible and social, so they are held back while `InCombatLockdown()` is true (`HandleTracked`, `HandleStrangersBuff`). **Messages still fire** — print is self-only and whispers go to the buffer, so they always reflect the buff that just landed. Macro creation also bails in combat (`CreateAutoMacro`) and simply retries at the next login. There is no replay: combat-suppressed emotes are dropped, not queued.

### Item Data Caching

`GetItemInfo` returns `nil` on a cold call and resolves asynchronously, so item names and links are never assumed at file-load time:

- `WarmItemCache` touches `ns.GetItemInfo` for every tracked item at login to start the async fill.
- The Teammates and Services panels are registered with AceConfig as **functions, not prebuilt tables** ([Options.lua](Options/Options.lua)), so the tracked list is rebuilt and re-sorted each time the panel opens — by which point the cache is usually warm.
- `ns.DefineEntryToggle` ([Options-Utilities.lua](Options/Options-Utilities.lua)) reads item names/icons lazily inside `name`/`desc` closures and falls back to `L["COMBAT_ITEM_PENDING"]` ("Item #%d") for a still-cold entry.

### API Compatibility

[Utilities.lua](Features/Utilities.lua) resolves each spell, item, and aura API to a single function **once**, by availability, so call sites never branch on client version (`C_Spell`/`C_Item`/`C_UnitAuras` with legacy-global fallbacks):

```lua
ns.GetSpellName    = C_Spell.GetSpellName  or (C_Spell.GetSpellInfo ...) or GetSpellInfo
ns.DoesSpellExist  = C_Spell.DoesSpellExist or (GetSpellInfo(id) ~= nil)
ns.GetBuffDuration = C_UnitAuras.GetBuffDataByIndex scan  or  UnitAura scan
```

`ns.GetSpellName` is rank-agnostic, which is how multiple spell ranks collapse into one tracked group. `ns.DoesSpellExist` is the client-coverage gate used by the build phase. `ns.GetSpellLink` is built by hand as `|Hspell:<id>:0|h[name]|h` rather than via the native `GetSpellLink`: on Classic the native link omits the trailing `:0` glyph field, which `SendChatMessage`'s hyperlink validator strips on send — so whispered links arrived as bare spell names. `ns.GetBuffDuration` can legitimately return `0` for a live buff with no timer, so callers must nil-check the result rather than test it for truthiness.

## Reaction Channels: Print, Whisper, Emote

Each buff category exposes three independent toggles — print, whisper, emote — and **they are the enable.** There is no master on/off switch; with all three off, the announce helpers and the emote both no-op, so nothing fires. ([Announcements.lua](Features/Announcements.lua) owns all three.)

- **Print (self-only)** — `ns:PrintMessage` prefixes the branded header. Messages that already embed color codes (spell links, class-colored names) are passed through untouched so an outer `|r` doesn't terminate the embedded coloring early.

  ```
  |cff00BBFFTFTB|r |cffAAAAAA//|r <message>
  ```

- **Whisper (to the buffer)** — automated thank-yous are branded with the raid-target marker so recipients recognize them as addon output:

  ```
  {rt1} TFTB // <message>   -- ns:Announce, via ns:BuildAnnounceMessage
  ```

- **Emote** — `ns:DoRandomEmote` picks one enabled emote at random from the per-category selection and directs it at the source, but only at a *resolved unit token* (`ResolveEmoteUnit`), never a raw name — `DoEmote` can't reliably direct at a name, and cross-realm `Name-Realm` names match no unit. It emotes undirected when no unit resolves.

The Thank You Button is the deliberate exception: `ns:Whisper` sends an **unbranded, natural-language** message (no marker, no addon name) so the manual thank-you reads as human.

**Rate-limiting differs on purpose** (all cooldowns live in `sessionCooldowns`, see **State Encoding**):

- **Prints and emotes for teammates/services are *not* throttled** — each cast is a distinct cooldown a teammate spent, so every one is acknowledged.
- **Whispers *are* throttled per-recipient** (`TryWhisperCooldown`, 45s) — a player who rebuffs you repeatedly is thanked at most once per window, which also keeps clear of Blizzard's whisper squelch.
- **The stranger emote** is additionally gated by a per-source cooldown (`db.strangers.cooldown`, default 3s) so you don't visibly emote at the same player over and over. The cooldown is only spent when an emote actually fires, so the first buff after you leave combat still reacts immediately.
- **Service casts** carry a per-source `service:` cooldown that both rate-limits a mage opening several portals and dedupes the multiple unit tokens (`party1`, `target`) a single cast fires.

## The Three Buff Categories

The category determines which settings table is read, how the message reads, and which panel the toggle lives on. Codes live in `Data.BUFF` and `Data.DETECT`.

| Category | `Data.BUFF` | Settings table | Source test | Message verb (example key) |
| --- | --- | --- | --- | --- |
| **Strangers** | — | `ns.db.profile.strangers` | friendly `OUTSIDER` aura on you | "buffed you with" (`MSG_BUFFED`) |
| **Teammates** | `SOLO` / `GROUP` | `ns.db.profile.teammates` | group member, aura/cast lands on you | "gave you" / "gave your group" (`MSG_GAVE_YOU`, `MSG_GAVE_GROUP`) |
| **Services** | `SERVICE` | `ns.db.profile.services` | group member, no per-you aura (unit-cast path) | "set out" / "opened" (`MSG_SET_OUT`, `MSG_OPENED`) |

`AnnounceTracked` selects the verb from the entry's `type`/`detect`: a service "set out" (or "opened" when `entry.opened`), a group buff "gave your group", an item used on you "used [their] X on you", a bare cast "used X on you", everything else "gave you". Item-driven reactions link the source **item**; everything else links the spell.

> **Terminology:** the three live categories are **Strangers / Teammates / Services**. An earlier "Combat" category was retired. The `COMBAT_*` locale-key prefix is a leftover naming convention shared by the Teammates and Services panels — it is not a fourth category. See **Common Pitfalls**.

## Thank You Button & Auto-Macro

A manual, target-driven thank-you ([Thank-You-Button.lua](Features/Thank-You-Button.lua)), separate from the automatic buff reactions.

- **Auto-macro.** When `slash.createMacro` is on, `ns:CreateAutoMacro` creates a global macro named `- Thank` (`Data.MACRO_NAME`) whose entire body is `/thankyou`. It bails in combat, skips if the macro already exists, and respects the 120-macro global cap.

  ```lua
  CreateMacro("- Thank", 134411, "/thankyou", nil)
  ```

- **`/thankyou`.** Registered in [Options.lua](Options/Options.lua); the body is `ns.RunThankYou`. It requires a player target that isn't you, emotes at the target, and whispers `slash.message` — but **only same-faction**, since you can't whisper the enemy faction.

The macro body is fixed and short, so the **255-character macro limit** is not a live concern for this feature. The relevant length limit here is `SendChatMessage`'s 255-character cap on the whisper/announce body (see **Common Pitfalls**).

## Diagnostic Tools

Runtime-only environment probing for bug reports ([Diagnostics.lua](Features/Diagnostics.lua), [Options-Diagnostics.lua](Options/Options-Diagnostics.lua)). Nothing here persists to SavedVariables, and every control is hidden until the user flips the panel's enable toggle.

- **Event Log** — captures recent events and their arguments, leaning on the single dispatcher's tap. The firehose events (`COMBAT_LOG_EVENT_UNFILTERED`, defensively `UNIT_AURA`) are excluded via `ns.DIAGNOSTIC_EVENT_EXCLUDE` so they can't bury the signal. Argument values are length-capped and pipe-escaped. Because the combat-log firehose is excluded, the buff engine calls `ns:LogCombatCast` directly for each nearby `SPELL_CAST_SUCCESS` (raw spell id + name, decoded affiliation/reaction flags, and whether the addon `tracked`/`watched` it) so a "why isn't this portal announced" case is visible before any filtering drops it.
- **Reports** — Event Registration, API Endpoints, Add-on Context, Other Add-ons, Saved Variables (depth- and width-limited dump), Library Versions, Taint Log. The **Context** report is the one to ask a reporter for first: it shows class/level/faction, whether the group/stranger paths are reachable, watched-buff counts, live tracked-trigger coverage, and `IsPlayerSpell` results for the player's class.

All strings in this file are **developer-facing and intentionally never localized** — they go in `ns.DiagnosticsStrings`, not `Locales/`.

## Saved Variables

One SavedVariables table, `TFTB_DB` (declared in [TFTB.toc](TFTB.toc)), owned by AceDB-3.0. After `AceDB:New` every user setting lives under `ns.db.profile`; `global` is reserved for profile-independent account-wide state and is empty (there is no minimap button).

| `profile` field | Holds |
| --- | --- |
| `showWelcome` | Whether to print the load message on the first `PLAYER_ENTERING_WORLD`. |
| `strangers` | `{ printEnabled, whisperEnabled, emotesEnabled, cooldown, minBuffDuration, emotes }` |
| `teammates` | `{ printEnabled, whisperEnabled, emotesEnabled, emotes }` |
| `services` | `{ printEnabled, whisperEnabled, emotesEnabled, emotes }` |
| `slash` | Thank You Button: `{ createMacro, message, emotes }` |
| `watchedBuffs` | `{ [spellID] = boolean }` — shared by the Teammates and Services panels. |

`emotes` is `{ [EMOTE_CMD] = boolean }`, keyed by the commands in `Data.EMOTES` (`CHEER`, `DRINK`, …). AceDB also keeps its own bookkeeping keys (`profiles`, `profileKeys`, …) at the `TFTB_DB` root; the Profiles panel ([Options-Profiles.lua](Options/Options-Profiles.lua)) is the stock AceDBOptions-3.0 table plus one custom `Reset All Profiles` control wired to `ns:ResetAllProfiles` (`ns.db:ResetDB`).

### Migration Chain

Run from `InitializeDatabase` ([Core.lua](Features/Core.lua)) right after `AceDB:New`, in order. Both migrations are dated for removal:

- **`MigrateFlatToProfile`** *(remove after 2026-10-05)* — the pre-AceDB build stored settings as flat keys at the `TFTB_DB` root; AceDB now owns the root, so those orphaned keys are lifted into the profile once (via `LiftInto`, a recursive overlay that keeps AceDB's default-fill for keys the user never set) and then removed. Copies that already hold a real AceDB `profiles` table are adopted by `AceDB:New` directly and never reach this path.
- **`ApplyFieldMigrations`** *(remove after 2026-09-28)* — three field-level cleanups from the flat era, now applied to the profile:
  - Drop the retired tri-state `strangers.messaging` dropdown and the `strangers.enabled` master switch (the print/whisper/emote toggles are the enable now).
  - Rename `welcomeMessage` → `showWelcome`.
  - Split the old combined `groupBuffs` config into independent `teammates` + `services` settings, carrying the player's messaging prefs into both and preserving their `watchedBuffs` list, so upgrading resets nothing.

Defaults come from `ns.DATABASE_DEFAULTS` and are applied lazily by AceDB-3.0 via metatables — nothing is copied into the saved table, and explicit user values (including `false`) are never overridden.

`watchedBuffs` re-seeds on empty: `PopulateWatchedBuffs` defaults every live aura/cast id **on** whenever the saved list has no entry for it (a fresh or reset profile starts empty), and prunes any persisted id not live on the running client so the saved list and the diagnostics counts stay client-real. It re-runs on every profile switch/copy/reset via the AceDB `OnProfile*` callbacks, which also refresh any open panels.

## Adding a New Tracked Reaction

A reaction is one entry in `Data.TRACKED` ([Data.lua](Data/Data.lua)). One entry == one options checkbox; nothing merges across entries.

1. Add a table to `Data.TRACKED` with:
   - `type` — `BUFF.SOLO` (cast on you), `BUFF.GROUP` (party/raid-wide), or `BUFF.SERVICE` (set out, no aura on you — announced from the unit-cast path).
   - `detect` — `DETECT.AURA` (matches `SPELL_AURA_APPLIED`) or `DETECT.CAST` (matches `SPELL_CAST_SUCCESS`).
   - `class` — the class bucket for the Teammates panel. Omit for the generic Items / Group Services lists.
   - `opened` — `SERVICE` only: announce as "opened" (portals, summons) instead of the default "set out" (feasts, soulwells, repair bots).
   - `triggers` — the rank(s)/variant(s) this one toggle covers: `{spell = id}`, `{spell = id, aura = id}` when the aura ID differs from the cast ID, or `{item = id, spell = id}` for an item (shows its icon/name; a grouped toggle lists every member in the tooltip).
   - `name` — *optional* display label. Omit it to use the localized spell name of the first trigger; set it only for a group whose members differ (e.g. `"Portals"`).
2. **Verify every ID against the client's expansion** on Wowhead — the comments in `Data.lua` name the spell but do not guarantee the ID exists on a given client. An ID absent on the running client is silently pruned at login by `DoesSpellExist`; that is by design (the table is a cross-client superset) but it also means a wrong ID just *never fires* with no error. See **Common Pitfalls**.
3. Collapse spell ranks into a single entry by listing every rank in `triggers` — `ns.GetSpellName` is rank-agnostic, so one toggle covers them all.
4. The watched state defaults **on** for any new ID (`PopulateWatchedBuffs`), so existing users start tracking it after the next login.

No locale work is needed when the label comes from the spell name. **But an explicit `name = "..."` is an English literal** — it is not run through `Locales/`. Reserve `name` for proper nouns/groupings; prefer the localized spell name otherwise.

## Adding a New Emote

1. Add an entry to `Data.EMOTES`: `{cmd = "PRAISE", displayName = "/praise", desc = L["EMOTE_PRAISE_DESC"]}`. `cmd` must be a valid `DoEmote` token.
2. Add `L["EMOTE_PRAISE_DESC"]` to **every** file in `Locales/`. The emote becomes available everywhere automatically — `Default-Settings.lua` seeds it on (`GetDefaultEmoteSettings` iterates `Data.EMOTES`), and all four emote pickers (Strangers, Teammates, Services, Thank You) build their toggles from the same list.

Watch **locale overflow**: emote descriptions are tooltips and the longer translations (German is the usual canary) should stay readable.

## Adding a New Event

1. Add the event name to `ns.EVENT_NAMES` in [Core.lua](Features/Core.lua) — the dispatcher registers the frame from this list and Diagnostics reads it, so a new event is picked up by the event log and the registration probe together.
2. Attach its handler with `ns.SetEventHandler("YOUR_EVENT", handler)` from the owning feature module — never create a second event frame.
3. Remember each event has a single owner; a second `SetEventHandler` for the same event silently replaces the first.

## Adding a New Locale

Copy `Locales/enUS.lua` to `Locales/<locale>.lua`. Drop the `true` argument from `NewLocale("TFTB", "<locale>", true)` — that flag marks the default fallback; only `enUS.lua` should set it. Translate every string. Add the file to the `.toc` immediately after `Locales/enUS.lua`.

The two Spanish locales (`esES`, `esMX`) are maintained as independent full translations — there is no shared-`strings`-table between them, so a string change to one is not automatically reflected in the other.

## Common Pitfalls

- **Editing the macro in combat**: `CreateAutoMacro` silently bails under `InCombatLockdown()`. It is not deferred via a dirty flag — it simply retries at the next login. Don't add a combat-time macro write.
- **Expecting emotes during combat**: emotes are suppressed in combat by design and are *not* queued for replay. Messages still fire. Don't "fix" the missing emote.
- **Reactions right after a loading screen**: the Safety Timer drops all reactions for `Data.SAFETY_PAUSE` seconds after login or any zone-in. A buff that doesn't react in the first ~3 seconds is expected, not a bug.
- **Announcing a service from the combat log**: portals/summons/feasts don't reliably reach `COMBAT_LOG_EVENT_UNFILTERED`, so they run through `UNIT_SPELLCAST_SUCCEEDED`. `OnCombatLogEvent` deliberately drops any `SERVICE` entry that surfaces there — don't "restore" it or you'll double-announce.
- **Treating `COMBAT_*` as a category**: the `COMBAT_*` locale keys are shared by the Teammates and Services panels; there is no "Combat" panel (it was retired). Don't add one, and don't rename the keys without touching both panels.
- **Name-based group/source checks**: cross-realm sources arrive as `Name-Realm`, so name lookups miss them. Classification uses combat-log affiliation flags only — keep it that way.
- **Crediting a pet instead of its owner**: pet/guardian buffs (Roar of Sacrifice) must run through `ResolveSource`/`GetPetOwnerUnit`, or the message names the pet.
- **Directing an emote at a name**: `DoEmote` needs a live unit token. Always route through `ResolveEmoteUnit` (which returns `nil` for an unmatchable/cross-realm source) rather than passing a combat-log name.
- **Trusting `Data.lua` ID comments across clients**: a comment naming a spell doesn't mean that ID is the right one on this client's expansion. A bad ID is pruned silently and the reaction never fires — verify on Wowhead for the target client.
- **Adding an ID to both panels**: `watchedBuffs` is one shared table keyed by ID. The disjoint-namespace invariant is load-bearing; an ID listed under both Teammates and Services would collide on one shared toggle state.
- **Assuming `GetItemInfo` at file load**: it is `nil` on a cold call. Item names/links resolve async — that's why the Teammates/Services panels are registered as functions and toggles read item data lazily.
- **Using the native spell link in a whisper**: on Classic it drops the trailing `:0` and `SendChatMessage` strips the whole link on send. Build it via `ns.GetSpellLink`.
- **Putting Diagnostics strings in `Locales/`**: they are intentionally English-only developer strings in `ns.DiagnosticsStrings`.
- **`SendChatMessage` length**: a branded whisper is `{rt1} TFTB // <body>` where the body carries an item/spell link. A long localized template plus a long link can approach the 255-character cap — keep translated message templates tight.

## Contributing

- **Issues**: <https://github.com/Gogo1951/Thanks-for-the-Buff/issues>
- **Bug reports** should include: game version + locale, class + level, repro steps, and the relevant chat output or macro body. The fastest way to gather this is the **Diagnostic Tools → Add-on Context** report (enable the panel, click *Show Context*, paste the output).
- **Discord**: <https://discord.gg/eh8hKq992Q>
- **PR guidelines**:
  - Keep changes scoped; match the existing code style (4-space indent, section banners, the `local _, ns = ...` header, the `ns.*` namespace — no new globals).
  - Localize every user-facing string through `Locales/` (the Diagnostics panel is the only deliberate exception).
  - Migration discipline: never silently drop a user's setting — add a dated migration step in `InitializeDatabase` and let AceDB's metatable defaults fill only the gaps.
  - Run the 255-character check for any change that alters a macro body or a `SendChatMessage` template (longest-locale + link).
  - Update this document if the architecture or file map changes.
- **Commit and PR descriptions require a User Story.** Don't just say "I changed X" or "I fixed Y." Frame the change in terms of who it helps and why:

   **Format:** *As a [role], I [needed / wanted] [behavior] so that [outcome]. This change [does X].*

   **Example:** *As a healer who lands a lot of short HoTs on strangers in the open world, I wanted Thanks for the Buff to ignore brief buffs so it wouldn't emote at me over a one-second tick. This change adds `strangers.minBuffDuration` and filters buffs shorter than it in `HandleStrangersBuff`.*

   The User Story makes review faster and gives future maintainers context the diff alone won't carry.
