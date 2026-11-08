# Thanks for the Buff // Technical Reference

This document combines architecture notes and contribution guidance for developers working on Thanks for the Buff. For end-user documentation, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md).

## File Map

The repo root is the add-on folder. The packager renames it to `TFTB` on release (`package-as` in `.pkgmeta`), which is the `ADDON_NAME` every file reads from its vararg and the installed path `Interface/AddOns/TFTB/`.

```text
Thanks-for-the-Buff/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── config.yml                Per-add-on New issue page: blank-issue link, Discord, CurseForge
│   │   ├── defect.yml                Shared from Common-Core: the Defect form
│   │   └── request.yml               Shared from Common-Core: the Request form
│   └── workflows/
│       ├── ci.yml                    Calls Common-Core: shared files, externals, luac 5.1, luacheck, StyLua
│       ├── issue-labels.yml          Calls Common-Core: labels a new Defect by its Issue Type answer
│       └── package.yml               Calls Common-Core: library refresh, then the CurseForge and Wago upload
├── .gitattributes                    Shared from Common-Core
├── .gitignore                        Shared from Common-Core
├── .luacheckrc                       Lint config
├── .pkgmeta                          Externals, package-as TFTB, packager ignore list
├── TFTB_Vanilla.toc                  Classic Era, Season of Discovery included
├── TFTB_TBC.toc                      TBC Anniversary
├── TFTB_Camelot.toc                  WoW Forever
├── TFTB_Mists.toc                    MoP Classic, the master list's one Extra TOC
├── Data/
│   ├── Flavor.lua                    Canonical flavor identity, read from the chosen TOC's X-Flavor
│   ├── Data.lua                      Locale init, palette, registry names, Thank You buttons, emotes, links
│   ├── Default-Settings.lua          AceDB defaults, all under profile; generates buttons 2 and up
│   ├── Vanilla/                      Classic Era; its file returns early on Season of Discovery
│   │   └── Game-IDs-Vanilla.lua      Sample spell and macro icons; every folder holds this one file
│   ├── Discovery/                    Season of Discovery; listed after Vanilla/, inverse guard
│   ├── TBC/                          TBC Anniversary
│   ├── Camelot/                      WoW Forever
│   ├── Mists/                        MoP Classic
│   ├── Wrath/                        Forward-prep with no TOC; ignored by .pkgmeta; no icons
│   └── Mainline/                     Forward-prep with no TOC; ignored by .pkgmeta; no icons
├── Diagnostics/                      Diagnostic Tools, copied from Magic Eraser
│   ├── Diagnostics-Core.lua          Enable gate, ns.DiagnosticsStrings, report header
│   ├── Manifests.lua                 TFTB's surface: API rows, probes, aura log lines, names, messages, data
│   ├── Event-Log.lua                 Event and Taint Logs; excludes the two detection events
│   ├── Code-Reports.lua              Event Registration, API Endpoints, Library Versions
│   ├── Settings-Reports.lua          Saved Variables, Display Context, Other Add-ons
│   ├── Validate-Data.lua             Per-file export of every ID in this client's data folder
│   ├── Localization-Reports.lua      Locale Context, Game Names, Message Length
│   ├── Report-Runner.lua             Report and tab manifests, the one-at-a-time runner
│   └── Options-Diagnostics.lua       The panel; loads in the TOC's Options block, registers last
├── Features/
│   ├── Core.lua                      Version, AceDB init, prune, migrations, ns.EVENT_NAMES, dispatcher, login
│   ├── Utilities.lua                 Colors, client emote catalog, secret checks, spell links, GUID, sound, auras
│   ├── Announcements.lua             Prints, the signed-off whisper, emotes, the stranger print, durations
│   ├── Praise.lua                    Cooldowns, emote target, the reaction to a stranger's buff
│   ├── Buff-Tracking.lua             Detects a stranger's buff: combat log, or UNIT_AURA on WoW Forever
│   └── Thank-You-Button.lua          The Thank You commands and their macros
├── Includes/
│   ├── Images/
│   │   └── Thanks-for-the-Buff.tga   The TOCs' IconTexture
│   ├── Libraries/                    Vendored Ace3 stack, refreshed from .pkgmeta on every release
│   └── Sounds/
│       └── Buff.ogg                  The Stranger Buffs sound
├── Locales/
│   ├── enUS.lua                      Source strings
│   └── deDE.lua ... zhTW.lua         Ten translations
├── Options/
│   ├── Options-Utilities.lua         Row helpers, link rows, feature switches, toggle pairs, emote grid
│   ├── Options-General.lua           Root panel: pitch, welcome, Features, /Commands, Good to Go links
│   ├── Options-Stranger-Buffs.lua    Praise and Notifications behind the Stranger Buffs switch
│   ├── Options-Thank-You-Button.lua  One section per Thank You button
│   ├── Options-Profiles.lua          Stock AceDBOptions-3.0 table, unmodified
│   ├── Options-Feedback-Support.lua  Level Up note, the four links, version
│   └── Options.lua                   Registration order, ns:OpenOptionsPanel, /tftb and /thankyou commands
├── LICENSE                           MIT
├── README.md                         End-user documentation
├── README-Notes.md                   The add-on's exceptions to the Style Guide
├── README-Technical.md               This document
└── README-Testing.md                 Manual test plan
```

`Features/`, `Diagnostics/` and `Options/` are listed in TOC load order, because load order decides which captured locals exist when a file runs (Event Loop, below). `Diagnostics/Options-Diagnostics.lua` is the one file out of its folder's block: the TOCs load it inside the Options block, just before `Options/Options.lua` registers it.

There is one TOC per flavor and no unsuffixed `TFTB.toc`. The four match line for line except `## Interface`, `## X-Flavor` and their data-folder lines; every feature ships on every flavor. Each data folder holds one file, `Game-IDs-{Game}.lua`, declaring the same two tables whole: `ns.GAME_IDS` (today only `SAMPLE_BUFF_SPELL_ID`, Arcane Intellect, the spell the Stranger Buffs Example lines and the Message Length report link) and `ns.THANK_YOU_MACRO_ICONS`. The Vanilla TOC lists `Data/Vanilla/` then `Data/Discovery/`, and each of those files opens with a guard on `ns.IS_DISCOVERY`, so exactly one of them builds its tables. Wrath and Mainline have no TOC and sit in the `.pkgmeta` ignore list; their icon list is empty, so a Thank You button there can only wear the default icon.

`.github/`, the dot files, `LICENSE` and the four README files are repo-only; the `.pkgmeta` ignore list keeps them out of the zip. `Includes/Libraries/` is rewritten from `.pkgmeta` on every release, so a hand edit there is lost.

Dead files, not to be reintroduced:

- **Retired features** (Teammate Buffs, Send Good News, Service Alerts, Buff Duty and the mini-map button): `Bindings.xml`; `Features/Buff-Window.lua` and its `-Frame`, `-Castable`, `-Units`, `-Self`, `-Outsiders` and `-Keys` siblings; `Features/Good-News.lua`; `Features/Tracked-Lookups.lua`; `Features/Minimap-Button.lua` with `Includes/Libraries/LibDataBroker-1.1` and `Includes/Libraries/LibDBIcon-1.0`; `Options/Options-Teammate-Buffs.lua`, `Options/Options-Send-Good-News.lua` and `Options/Options-Service-Alerts.lua`, each with its `-Tracked.lua` sub-panel; `Options/Options-Buff-Window.lua` and its `-Buffs`, `-Self-Buffs` and `-Weapon-Buffs` sub-panels; every `Data/{Game}/Tracked-Abilities-{Game}.lua` and `Data/{Game}/Buff-Window-Spells-{Game}.lua`.
- **Peer Pressure** (moved to Control Freak): `Features/Peer-Pressure.lua`, `Options/Options-Peer-Pressure.lua`, `Includes/Sounds/Thunder.ogg`.
- **Older layouts**: the unsuffixed `TFTB.toc`, the single `Data/Tracked-Abilities.lua`, `Features/Diagnostics.lua`, and `Diagnostics/Locale-Reports.lua` (now `Diagnostics/Localization-Reports.lua`).

## Architecture

### Event Loop

`Features/Core.lua` owns the add-on's one event frame and its dispatcher; no feature file creates a frame for events or calls `RegisterEvent`. (The Event Registration report in `Diagnostics/Code-Reports.lua` registers and unregisters each event on a throwaway probe frame, and never handles one.) The complete list is `ns.EVENT_NAMES`, so the registered set, the event-log tap and that report cannot drift apart:

```
PLAYER_LOGIN · PLAYER_ENTERING_WORLD · LOADING_SCREEN_DISABLED
+ UNIT_AURA                     (WoW Forever only, for player only)
+ COMBAT_LOG_EVENT_UNFILTERED   (every other flavor)
```

WoW Forever has no usable combat log, and registering `COMBAT_LOG_EVENT_UNFILTERED` there errors, so Core appends exactly one detection event by `ns.FLAVOR == "Camelot"`. `UNIT_AURA` registers through `RegisterUnitEvent` for `player` alone, from `ns.EVENT_UNITS`, so the client never wakes the dispatcher for nameplates and raid members.

Feature files attach handlers with `ns.SetEventHandler(event, handler)`. A second call for the same event silently replaces the first, so each event has one owner:

| Event | Owner |
| --- | --- |
| `PLAYER_LOGIN`, `PLAYER_ENTERING_WORLD` | `Features/Core.lua` |
| `LOADING_SCREEN_DISABLED`, `COMBAT_LOG_EVENT_UNFILTERED`, `UNIT_AURA` | `Features/Buff-Tracking.lua` |

Buff-Tracking attaches both detection handlers on every flavor; only the one Core registered ever fires. While diagnostics logging is on, every event passes through `ns:LogEvent` first, behind one boolean check.

Core registers the events when its file loads, so a handler can fire before `PLAYER_LOGIN` creates `ns.db`. Both detection handlers return while `isReady` is false or `ns.db` is nil.

`PLAYER_LOGIN` runs the setup sequence, in a load-bearing order:

1. `InitializeDatabase`: `AceDB:New`, the other-client prune, the two migrations, then the profile callbacks. Nothing may read a setting before this.
2. `ns.RegisterOptionsPanels`, which also registers `/tftb`. The Profiles panel binds to `ns.db`, so registration can't happen at file scope.
3. `ns.SetupBuffTracking`: caches your GUID and arms the safety timer.
4. `ns:CreateAutoMacro`: reconciles the Thank You macros with the profile.

The welcome message rides `PLAYER_ENTERING_WORLD` behind a once-per-session flag, since that event refires on every loading screen.

TOC order is load-bearing too, because files capture other modules' values at load. `Features/Buff-Tracking.lua` captures `ns.HandleStrangersBuff`, so `Features/Praise.lua` loads before it. `Features/Utilities.lua` builds its color table from `ns.PALETTE`, and Announcements and the Options files capture `ns.GetColor`, so Utilities loads right after Core. In the Data block, `Data/Flavor.lua` comes first because the Season of Discovery guards read `ns.IS_DISCOVERY`; `Data/Data.lua` next because it sets `ns.L` and builds `Data.EMOTES` from it; the flavor folder after that; and `Data/Default-Settings.lua` last, because it reads `Data.EMOTES`, `Data.THANK_YOU_BUTTONS`, `ns.THANK_YOU_MACRO_ICONS` and `L["DEFAULT_WHISPER"]`.

A safety timer (`Data.SAFETY_PAUSE`, 3 seconds) runs after login and after every `LOADING_SCREEN_DISABLED`, so the burst of auras a zone-in reports is not taken for fresh buffs. While it runs, `isReady` is false. Each arm bumps a token and only the newest callback may set `isReady`, so back-to-back loading screens can't let a stale timer end the pause early.

### Combat Lockdown

- **The options panel refuses outright.** `InCombatLockdown()` is the first statement of `ns:OpenOptionsPanel`, in front of every route. It prints `CHAT_OPTIONS_IN_COMBAT` and returns; it never queues and never waits for `PLAYER_REGEN_ENABLED`, because Blizzard's Settings panel is protected in combat and a silent refusal reads as a broken command.
- **Macros are skipped, not queued.** `ns.ReconcileMacros` and `ns:DeleteAutoMacro` return in combat, since the macro API is blocked there. There is no dirty flag and no replay on leaving combat: the next login, profile change, copy or reset, Enable Macro tick or Icon pick reconciles the macro.
- **Automatic emotes are suppressed, not queued.** `HandleStrangersBuff` allows the emote only out of combat, and `DeliverPraise` checks combat again when it fires, so entering combat during a Praise Delay still drops it. The print, the sound and the whisper all fire in combat; none touches a protected function.
- **The Thank You commands still work.** `/thankyou` through `/thankyou5` are ordinary slash commands and emote and whisper in combat. On WoW Forever a target's identity goes secret in combat, so the command still emotes at `target` but skips the whisper.
- **On WoW Forever, buffs on you are not read in combat.** `OnUnitAura` returns while `InCombatLockdown()` or `ns.AreAurasSecret()` is true, so a buff landing mid-fight is never seen and never queued.

### Detect, Classify, React

The stranger-buff pipeline runs through `Features/Buff-Tracking.lua` (detect and classify), `Features/Praise.lua` (react) and `Features/Announcements.lua` (output).

1. **Detect.** `OnCombatLogEventUnfiltered` keeps `SPELL_AURA_APPLIED` and `SPELL_AURA_REFRESH` (a rebuff earns the same thanks) whose destination is your cached GUID, cheapest comparisons first, so an aura on anyone else stops at a string compare. On WoW Forever, `OnUnitAura` stands in (Buff Detection on WoW Forever, below).
2. **Classify.** A stranger buff lands on you from a friendly player outside your group. `ns.IsPlayerGUID` (a `Player-` GUID prefix) is the only proof the source is a player, since a pet's flags can claim otherwise; `COMBATLOG_OBJECT_REACTION_FRIENDLY` says whose side they are on; `COMBATLOG_OBJECT_AFFILIATION_OUTSIDER` recognizes an outsider without a `UnitIn*` scan. Affiliation decides, not a name lookup, because a cross-realm source arrives as `Name-Realm` and never matches one. Helpfulness is settled one step later: `ns.GetBuffDuration` scans only `HELPFUL` auras and returns nil for anything else.
3. **React.** `HandleStrangersBuff` returns at once while the Stranger Buffs switch (`strangers.enabled`) is off. It asks `ns.GetBuffDuration("player", spellID)`: nil means the buff is no longer on you, 0 means it has no timer and always qualifies, and anything above 0 but under `minBuffDuration` is dropped. It resolves the spell link once (`ns.GetBuffLink`), then fires the two **notifications** and settles the **praise**.

**Notifications** are the print (`ns:AnnounceStranger`) and the sound (`ns.PlayBuffSound`, on the Master channel). They are yours alone, so they fire for every qualifying buff, inline, in or out of combat, and no cooldown or delay touches them.

**Praise** is the whisper and the emote, which the other player sees. Both answer to the two praise cooldowns, and the whisper also to the per-recipient whisper floor (Cooldown Namespaces, below). Every gate is settled and stamped before `DeliverPraise` arms its timer, so a burst of buffs inside the Praise Delay can't slip past a cooldown. Neither cooldown is stamped unless some praise is cleared to go out, so a buff that arrives in combat with emotes as the only praise enabled costs nothing. `praiseDelayEnabled` off means a delay of 0 and inline delivery. Two things are decided late, inside the timer: combat, for the emote, and the emote target. `ResolveEmoteTarget` returns a live unit token, and `target`, `focus` and `mouseover` name whoever you point at in that instant, so resolving early makes a delayed emote thank whoever you moved on to.

The whisper goes out through `ns:WhisperThanks` and `ns:Announce`, whose `SignOff` prefixes the target marker (`{rt1}` Star, left off on WoW Forever, which blocks raid-marker tokens in chat), trims the body's closing punctuation and any leading Spanish opening mark, and appends ` // TFTB` (`L["ADDON_SHORT_NAME"]`). Marks are matched as whole UTF-8 sequences, including the full-width `！`, `。` and `？`, so a multi-byte character is never cut in half.

```
Template   Thanks for the %s
Sent       {rt1} Thanks for the [Arcane Intellect] // TFTB
```

`SendChatMessage` rejects anything over 255 bytes (`ns.CHAT_MESSAGE_MAX_LENGTH`), and the thank-you whisper has no fallback past that ceiling. The link inside it is whatever buff landed, so `MESSAGE_WHISPER_THANKS` must stay short in every locale; the Message Length report says how long a buff's link may run before the whisper overflows.

### Cooldown Namespaces

One `sessionCooldowns` table (key to expiry time) in `Features/Praise.lua` backs every praise throttle. The keys live in disjoint string namespaces, so two throttles on the same GUID never collide:

| Key | Window | Purpose |
| --- | --- | --- |
| `praise:all` (`PRAISE_OVERALL_KEY`) | `strangers.praiseCooldown`, default 0 (off) | Overall limit, whoever buffed you |
| `praise:<guid>` | `strangers.cooldown`, default 3s | Per-source limit |
| `whisper:<guid>` | 45s (`WHISPER_COOLDOWN`) | Per-recipient whisper floor |

Both `praise:` keys hold back the whisper and the emote alike. `whisper:<guid>` is a floor under them that no setting can lower: a 1-second praise cooldown still can't whisper the same player more than once every 45 seconds, which keeps a generous setting clear of the server's whisper squelch. `TryWhisperCooldown` checks and stamps it in one call, and only when the whisper is enabled. `SetCooldown` sweeps lapsed entries on every write, so the table can't grow across a long session. `ns.GetPraiseCooldownState` reads all three for Diagnostics without stamping.

### Secret Values and Client APIs

Spell, chat and emote access call `C_Spell`, `C_ChatInfo.SendChatMessage` and `C_ChatInfo.PerformEmote` directly, with no legacy fallback: every target client ships them, and the Retail engine behind WoW Forever has dropped the legacy globals.

WoW Forever also hands out secret values, which error when compared, concatenated, sent or used as a table key. `ns.IsPlain` (a wrapper over `issecretvalue`) guards every event argument and API return the aura path and the emote helpers touch. `ns.IsUnitIdentitySecret(unit)` and `ns.AreAurasSecret()` wrap `C_Secrets` and are always false on other flavors; they are asked before the aura path reads anything and before the Thank You command checks or whispers its target. A secret read skips that output rather than working around it.

`ns.GetSpellLink` builds the link by hand, `|cff71d5ff|Hspell:<id>:0|h[Name]|h|r`, rather than using the client's: on Classic `C_Spell.GetSpellLink` omits the trailing `:0` field, and `SendChatMessage`'s hyperlink validator strips such a link to its bare name. The native link is a fallback for a spell whose name won't resolve, and `L["UNKNOWN_SPELL"]` the one after that.

## Buff Detection on WoW Forever

Every other flavor reads buffs on you from the combat log. WoW Forever has none, so `OnUnitAura` reads them from `UNIT_AURA` for `player`, and the path differs in what it can see:

- **Only newly added auras count.** A full update is ignored, and a recast of a buff you already hold adds nothing, so a rebuff is not thanked there.
- **Nothing is read in combat** or while `ns.AreAurasSecret()` is true. A buff that lands then is skipped, never queued.
- **The caster is resolved, not named by the event.** `ResolveAuraCaster` credits the aura's `sourceUnit` when it carries one (a group token for a teammate, a nameplate token for a stranger), trading a pet for its owner through `GetPetOwnerUnit` (`pet`, `partypet1-4`, `raidpet1-40`). A group member's pet therefore reads as the group member and is left alone, and a stranger's pet resolves to nobody. With no `sourceUnit` (a stranger out of nameplate range), it reads the caster with `C_UnitAuras.GetAuraCasterGUID`, inside a `pcall`, and when that GUID maps to no unit it names them with `UnitNameFromGUID`, appending the realm with its spaces removed so a cross-realm whisper reaches them.
- **Friendliness is asked only where it can be.** A caster in your party or raid is skipped. A stranger held by a unit token must pass `UnitIsFriend` with a plain true. A stranger known only by GUID can't be asked and needn't be: the other faction can't put a helpful buff on you.

Every field read on this path goes through `ns.IsPlain` first.

## Thank You Buttons

`Data.THANK_YOU_BUTTONS` in `Data/Data.lua` is the whole feature: one row per button, with the profile key it stores under, the macro it offers to create, the slash command that macro runs, and whether it fires one chosen emote or a random one from a checklist.

```lua
{ profileKey = "slash", macroName = "- Thank", command = "/thankyou" },
{ profileKey = "slash2", macroName = "- TFTB 2", command = "/thankyou2", singleEmote = true },
```

Everything else generates from that list, and nothing counts the buttons: the defaults of buttons 2 and up (`Data/Default-Settings.lua`; button 1's `slash` defaults are written out by hand because they are on by default), the options sections (`Options/Options-Thank-You-Button.lua`, order numbers a hundred apart per button so a new control never renumbers the next section), the slash registrations (`Options/Options.lua`, `SlashCmdList` keys `TFTB_THANKYOU<n>`, registered when that file loads) and the macros (`Features/Thank-You-Button.lua`).

Button 1 ships with its macro on, every curated emote ticked and the friendly `DEFAULT_WHISPER`. Buttons 2 through 5 ship fully off: no macro, no whisper text, no emote. An empty message sends no whisper and an empty token performs no emote, so "off" needs no guard of its own. Every macro name leads with a dash so the family sorts together at the top of the macro list. Unticking Enable Macro (`createMacro`) collapses that button's rows, but its command keeps working with the stored settings. Reset writes back that button's own `ns.DATABASE_DEFAULTS` message, so button 1 resets to the friendly text and the rest to empty.

`singleEmote` changes the stored shape as well as the control: `emote` (one token, `""` for none) instead of `emotes` (a set). Its dropdown is built from the client's own emote catalog (`ns.GetEmoteCatalog`, read from the `EMOTE<n>_TOKEN` and `EMOTE<n>_CMD<n>` globals up to `MAXEMOTEINDEX`), not from the twelve in `Data.EMOTES`, so it offers exactly what this build can perform. Those globals are sparse and repeat a few tokens, so the scan neither stops at a gap nor keeps a duplicate. `ns:DoEmoteToken` validates against the catalog before calling `C_ChatInfo.PerformEmote`, because a bad token is a silent no-op that looks like a broken button. A stored token this client lacks shows as "none", since profiles travel between flavors.

`ns.ReconcileMacros` brings every macro in line with the profile in both directions: it creates the enabled macros that are missing, gives existing ones their picked icon, and deletes the disabled ones still there. A button with no stored settings is never deleted. `GetNumMacros` is re-read inside the loop against `Data.MAX_GLOBAL_MACROS` (120), because each macro the call creates counts against the cap; a button that hits it is skipped silently. `ns:DeleteAutoMacro` resolves the index from the button's exact name first, so the existence check and the delete agree on one macro.

Each macro wears the icon its Icon dropdown picks. `macroIcon` stores a texture file ID: `Data.THANK_YOU_DEFAULT_ICON` (134411, `inv_misc_ribbon_01`) or one of this flavor's `ns.THANK_YOU_MACRO_ICONS`, twenty bold icons nobody keeps on a bar. An icon has no name the client can supply, and a typed name would need translating, so the dropdown shows each as its picture alone. A row's optional second field is the button that starts on it, so buttons 2 through 5 each start on their own icon and the five macros tell apart on a bar. An existing macro gets its icon through `EditMacro(index, nil, icon)`, which leaves the name and body alone. An icon this flavor's list lacks falls back to the default (`ns.GetThankYouIcon`).

`ns.RunThankYou` requires a player target that isn't you, emotes at `target`, and whispers only when the target shares your faction, the message is non-empty, and (on WoW Forever) the target's identity isn't secret. That whisper is the player's own text, sent verbatim through `ns:Whisper` with no marker and no sign-off. Its edit box caps at 255 bytes through a local `TrimToBytes`, which steps back off a UTF-8 continuation byte so a cut never lands mid-character.

## Options Panels

`Options/Options.lua` registers every panel against its `ns.OPTIONS_REGISTRY` name in tree order: General (root), Stranger Buffs, Thank You Button, Profiles, Feedback & Support, Diagnostic Tools. There are no sub-panels. Every panel registers a prebuilt table except Diagnostic Tools, which registers its builder function so each repaint rebuilds it and the enable gate can leave its tabs out of the table. `ns:OpenOptionsPanel` routes by the category ID captured from the root `AddToBlizOptions` call and reaches `AceConfigDialog:Open` only where `Settings.OpenToCategory` or that ID is missing.

The General panel ends with a Looking for Other Features? section holding Good to Go's CurseForge and Wago links (`ns.GOOD_TO_GO_LINKS`), by the exception in `README-Notes.md`.

**Feature switches.** `ns.FEATURE_SWITCHES` in `Options/Options-Utilities.lua` declares each feature's on/off switch once; today Stranger Buffs is its only entry. `ns.OptionsFeatureToggle` builds it twice, at the top of the feature's panel and in the General panel's Features section (two to a line through `ns.OptionsTogglePairs`). Both copies write through `ns.SetFeatureSwitch`, which runs the row's `onChange` if it has one and repaints every registered panel so the other copy follows at once. The switch is a real gate: `HandleStrangersBuff` returns at its first line when it is off, while detection keeps running so the diagnostics log still shows auras landing.

**Hiding behind the switch.** The Stranger Buffs panel hides everything behind its switch with a local `HideAllExcept`, applied to the finished args table. The rule is positional (everything but the intro, its spacer and the switch), so a control added later is covered, and an existing `hidden` is composed rather than replaced, which keeps the emote grid following its own toggle while the panel is on.

**Example lines.** The print and whisper toggles each carry a silver Example line, built through the real pipeline: the print Example calls `ns.GetPrintPrefix` and `ns:BuildStrangerMessage` with Portalrico, the house roster's Mage, so the name, its class color and the Arcane Intellect link agree; the whisper Example calls `ns:BuildAnnounceMessage` and draws it as the whisper the buffer receives, from `CHAT_WHISPER_GET` in the player's `ChatTypeInfo.WHISPER` color, with `{rt1}` swapped for its texture. Both re-open their color after every `|r`, since a panel falls back to white where a chat frame falls back to the line's color.

**Seconds dropdowns.** The cooldown and minimum-duration dropdowns offer `Data.SECONDS_CHOICES` (0, 1, 2, 3, 5, 8 ... 144, Fibonacci), always labeled in seconds through `ns.FormatDuration(seconds, true)`. Their `get` shows the nearest listed value without rewriting the stored one, because AceConfig draws a select whose value is missing from `values` as an empty box. That is why `minBuffDuration` defaults to 21, a step on the scale. The Praise Delay dropdown offers `Data.PRAISE_DELAY_CHOICES` (1 to 4 seconds) and shows only while its toggle is on.

Dropdowns are label-beside-control rows: the `select` carries `name = ""` and `ns.OPTIONS_CONTROL_WIDTH` beside an `ns.OptionsRowLabel` at `ns.OPTIONS_LABEL_WIDTH` (2.1), together `ns.OPTIONS_ROW_WIDTH` (3.4). The Thank You rows use a 0.9 label and give the control the rest of the row, less the 0.5 Reset button on the whisper row.

## Diagnostics

`Diagnostics/` is the house Diagnostic Tools framework copied from Magic Eraser: Run Tests, Settings, Code, Data and Localization tabs under a runtime-only enable gate (`ns.diagnostics`, never saved), and a runner that builds one report at a time, a frame apart, each in a `pcall` so a report that throws is written into the box and the run goes on. Strings live in `ns.DiagnosticsStrings` as plain English.

TFTB's own surface is mostly `Diagnostics/Manifests.lua`: the API rows, the Buff Reactions Context and Emote Extract reports on the Settings tab, the aura log lines, the Game Names rows (the sample spell, the client's seconds string, and the command for each curated emote), the Message Length rows (the thank-you whisper with the sample spell, every Thank You whisper the player has set, and each macro body against 255 bytes), and the one data source, `Game-IDs`. The features expose read-only hooks for those reports: `ns.IsBuffTrackingReady`, `ns.IsBuffTrackingSetUp`, `ns.GetPraiseCooldownState` and `ns.GetEmoteCatalog`.

The event log excludes both detection events (`ns.DIAGNOSTIC_EVENT_EXCLUDE` in `Diagnostics/Event-Log.lua`): the combat log is a firehose, and `UNIT_AURA`'s update table can't be written as text. In their place Buff-Tracking writes decoded lines while logging is on. `ns:LogAuraApplied` logs every aura landing on you, before any classification guard, with its type, reaction and affiliation flags and the duration Stranger Buffs would read; a stranger's buff reads `player=true friendly=true aff=OUTSIDER`. On WoW Forever `ns:LogAuraUpdate` logs each added helpful aura with a verdict naming the first gate that stops it (`not ready`, `no db`, `in combat`, `auras secret`, `full update`) or `read`. A secret argument logs as `<secret>`.

## Saved Variables

One account-wide table, `TFTBDB`, managed by AceDB-3.0, holds every setting.

**Thanks for the Buff uses the Simple model, so Reset Profile clears everything on the active profile back to install defaults.** `AceDB:New` takes `true` as its third argument, every character starts on the shared `"Default"` profile, and every setting lives under `profile`, because nothing the add-on stores differs from character to character. `global` is unused. A new setting belongs in `ns.db.profile`. The Profiles panel is stock, so a player can still create and switch profiles, which is why the migrations walk every entry in `ns.db.profiles`.

The shape of `profile` is whatever `Data/Default-Settings.lua` declares; read it there. In outline: `showWelcome`; `strangers`, holding the switch, the praise and notification toggles, the two cooldowns, the minimum duration, the Praise Delay and the `emotes` set; and `slash` through `slash5`, the Thank You buttons.

AceDB applies `ns.DATABASE_DEFAULTS` itself when a scope is first accessed, never overriding a saved value, an explicit `false` included; there is no hand-rolled merge. There is no ID list to seed. The only sets are the emote tables, filled inside the defaults from `Data.EMOTES` by `GetDefaultEmoteSettings`: every emote on for Stranger Buffs and button 1. A later checklist-shaped button would start with every emote off; buttons 2 through 5 store a single `emote` token starting at `""`.

Right after `AceDB:New`, `PruneOtherClientCharacters` drops characters copied in from another game version's WTF folder (a `"Name - Realm"` key on WoW Forever, a `"First Last"` key on a realm client), with their `char` section, `profileKeys` entry and, unless a staying character uses it, their own profile. It runs at every load and is not a migration.

`OnProfileChanged` in `Features/Core.lua`, registered for the profile change, copy and reset callbacks, reconciles the Thank You macros and calls `NotifyChange` on every entry in `ns.OPTIONS_REGISTRY`. The macros are the only state applied imperatively; everything else reads the database live.

### Migration Chain

Both run in `InitializeDatabase` (`Features/Core.lua`), after the prune, over every profile:

- **`peerPressure`** (`MIGRATION (remove after 2026-11-21)`): Peer Pressure moved to Control Freak, which imports nothing from `TFTBDB`, so the subtable is deleted.
- **Retired features** (`MIGRATION (remove after 2026-12-07)`): Teammate Buffs, Send Good News, Service Alerts, Buff Duty and the mini-map button were retired, so `minimap`, `teammates`, `services`, `goodNews`, `buffWindow` and `watchedBuffs` are deleted.

## Adding a New Thank You Button

1. Append a row to `Data.THANK_YOU_BUTTONS` in `Data/Data.lua`: a unique `profileKey`, a `macroName` leading with a dash, a `command` nothing else registers, and `singleEmote = true` unless it should randomize over a checklist.
2. For it to start on its own icon, add a `{ texture file ID, <button index> }` row to `ns.THANK_YOU_MACRO_ICONS` in every shipped `Data/{Game}/Game-IDs-{Game}.lua`; without one it starts on the default icon.
3. Add its `SlashCmdList` key (`TFTB_THANKYOU<n>`) to the `SlashCmdList` fields in `.luacheckrc`.

Its defaults, options section, command and macro all generate from that row, and it ships switched off. The macro body is the command literal, far under the 255-byte macro ceiling (Style Guide → MESSAGES → Message Length); the Message Length report lists it.

## Adding a New Feature Switch

1. Add a row to `ns.FEATURE_SWITCHES` in `Options/Options-Utilities.lua`: `key` (the profile subtable), `setting` (its on/off field), `name` and `desc` (locale keys), and `onChange` only if something must react the moment either copy flips.
2. Declare the subtable and its switch in `Data/Default-Settings.lua`, and make the feature's engine return early while it is off, as `HandleStrangersBuff` does.
3. Place it at the top of its panel with `ns.OptionsFeatureToggle(ns.GetFeatureSwitch(key), order)` and hide the rest of the panel behind it. The General panel's Features section picks it up on its own.

## Adding a New Registered Event

1. Add the event to `ns.EVENT_NAMES` in `Features/Core.lua`, so the dispatcher registers it and the Event Registration report probes it together. An event a flavor lacks is appended conditionally, the way the two detection events are, because registering an unknown event throws.
2. If it is a unit event needed for one or two units, add them to `ns.EVENT_UNITS` so it registers through `RegisterUnitEvent`.
3. Attach its handler in the owning feature file with `ns.SetEventHandler`, named for the event (`OnEventName`). A second consumer is called from the owner's handler. The handler can fire before login, so guard on `ns.db`, and on WoW Forever check every argument with `ns.IsPlain` before comparing it or using it as a key.
4. If it fires constantly, add it to `ns.DIAGNOSTIC_EVENT_EXCLUDE` or the per-ID filter in `Diagnostics/Event-Log.lua`, and log what matters through a decoder like `ns:LogAuraApplied`.

## Adding a New Flavor TOC

1. Copy an existing TOC to `TFTB_{Flavor}.toc` and change only `## Interface` (the number `01 - Local Setup.md` gives it), `## X-Flavor` and its data-folder line.
2. Remove `Data/{Flavor}` from the `.pkgmeta` ignore list in the same change, or that client installs a TOC whose data never shipped.
3. Fill that folder's `ns.THANK_YOU_MACRO_ICONS` with icons present on the client; an empty list leaves only the default icon.
4. If the client has no usable combat log, extend Core's flavor branch so it registers `UNIT_AURA`, and the `C_Secrets` checks in `Features/Utilities.lua`, only once a test shows the difference.

## Localization

- **`enUS.lua` is the source of truth.** Every locale file registers through `NewLocale("TFTB", "<code>")`, and only `enUS.lua` passes the `true` default-fallback flag; AceLocale falls back to English for any key a locale lacks. The other ten files belong to the Localization Review (`07 - Localization Review.md`); never hand-edit them during ordinary work.
- **Placeholders.** The `%s` and `%d` count, type and order must match `enUS` per key in every locale, or the string errors at runtime.
- **Game names never go in `Locales/`.** They are stored as IDs, tokens or GlobalStrings and named by the client:
  - Spells: `ns.GAME_IDS.SAMPLE_BUFF_SPELL_ID`, and every buff that lands on you, through `C_Spell.GetSpellName` inside `ns.GetSpellLink`.
  - Emotes: tokens in `Data.EMOTES` and the client catalog, named by the client's `EMOTE<n>_CMD<n>` globals (`ns.GetEmoteCommand`). The `EMOTE_*_DESCRIPTION` tooltips are our own words.
  - Durations: `D_SECONDS`, `D_MINUTES` and `D_HOURS`, through `ns.FormatDuration`.
  - Class colors by class token (`Data.CLASS_COLORS`, read from `GetPlayerInfoByGUID`), and the whisper Example's frame from `CHAT_WHISPER_GET`.
- **Quote style.** StyLua writes a value containing a double quote with single-quoted delimiters (`BUTTON_MACRO_ENABLE`, `'Enable Macro "%s"'`), so a script auditing key parity must accept both.

The Spanish file pairing, the overflow canary and the output ceilings follow Style Guide → LOCALIZATION and MESSAGES → Message Length. The sent string to keep short is `MESSAGE_WHISPER_THANKS`, since it carries a live link. `ADDON_TITLE` (`Thanks for the Buff (TFTB)`) and `ADDON_SHORT_NAME` (`TFTB`) are written the same in every locale.

## Common Pitfalls

- **A `|4` plural escape in a sent message**: WoW's duration strings (`D_MINUTES` is `"%d |4minute:minutes;"`) carry an escape the UI expands only when it renders, and `SendChatMessage` drops a whole line that still holds one. `ResolvePlurals` in `Features/Announcements.lua` expands it, with a three-form rule for Slavic locales, so `ns.FormatDuration` output is safe in chat.
- **Whispering a pet**: a whisper to a pet's name bounces. The combat-log path requires `ns.IsPlayerGUID`, the WoW Forever path trades a pet for its owner and returns nil rather than the pet, and the Thank You command requires `UnitIsPlayer`.
- **Cross-realm names**: a combat-log name is `Name-Realm` and never matches a name lookup or resolves as an emote target. Group membership is classified by affiliation flags, and `ResolveEmoteTarget` strips the realm with `Ambiguate(name, "short")`.
- **`C_ChatInfo.PerformEmote(token, nil)` is not undirected**: it falls back to your current target and thanks a bystander. `ns:DoRandomEmote` and `ns:DoEmoteToken` return on a nil target. A bare name the client can't resolve still degrades to the undirected emote; closing that would mean dropping the name fallback, and with it the most common thank of all.
- **A unit token is not proof of presence**: a party member who zoned into a dungeon is still `party2`. `CanWitnessEmote` requires `UnitIsVisible` plus `UnitInRange`, and reads `UnitInRange`'s second return so a stranger, or a secret answer on WoW Forever, falls through to the visibility verdict.
- **Resolving the emote target before the delay**: `target`, `focus` and `mouseover` change with where you point. `DeliverPraise` resolves inside the timer.
- **Iterating a saved emote table**: a profile can hold keys that are not real tokens, and a random pick of one is a silent no-op. `ns:DoRandomEmote` walks `Data.EMOTES` and reads the saved table by key.
- **Treating a buff's duration as truthy**: `ns.GetBuffDuration` returns 0 for a timerless buff and nil for one that isn't there. Callers nil-check, and `minBuffDuration` drops only a duration above 0 and below it.
- **Using the client's spell link in chat**: on Classic it lacks the trailing `:0`, and `SendChatMessage` strips it to a bare name. Build links through `ns.GetSpellLink`.
- **Registering `COMBAT_LOG_EVENT_UNFILTERED` on WoW Forever**: it errors there. Core appends it or `UNIT_AURA` by flavor, never both.
- **Touching a secret value on WoW Forever**: comparing, concatenating or indexing with one errors, and they arrive in event arguments, unit names, aura fields, and even `UnitInRange` and `PerformEmote` returns. Test with `ns.IsPlain`, and ask `ns.IsUnitIdentitySecret` or `ns.AreAurasSecret` before a read that can go secret.
- **A handler firing before login**: events register when Core loads, so a detection event can arrive while `ns.db` is nil. Both detection handlers check `isReady` and `ns.db` first.
- **Leaving a caption on a dropdown**: AceConfig draws a widget's own `name` above it in header gold. Every `select` carries `name = ""` and pairs with an `ns.OptionsRowLabel` or its enabling toggle.
- **A stored value missing from a select's `values`**: AceConfig draws it as an empty box. The seconds dropdowns snap their `get` to the nearest choice, and the emote and icon dropdowns show an unknown token or icon as none or Default.
- **Editing a vendored library**: `Includes/Libraries/` is refreshed from `.pkgmeta` externals on every release, so a local fix is discarded. Work around it in the add-on's own files, or fix it upstream.

## Contributing

- **Issues.** <https://github.com/Gogo1951/Thanks-for-the-Buff/issues>
- **Bug reports.** Include game version and locale, class and level, repro steps, and the chat output or whisper text involved. The Diagnostic Tools panel builds a ready-to-paste report: turn it on, press Run All on the Settings and Code tabs, and capture the Event Log on Run Tests while reproducing.
- **Discord.** <https://discord.gg/eh8hKq992Q>
- **PRs.** Keep each change scoped. Run StyLua with its default config and `--syntax lua51` over every touched Lua file, and keep `luac -p` and `luacheck .` clean. Any change to the shape, name or scope of saved data ships its own migration, tagged `MIGRATION (remove after YYYY-MM-DD)` 30 days out. Check any sent-message or macro change against the 255-byte ceiling in the widest-encoding locale, usually ruRU, with the Message Length report (Style Guide → MESSAGES → Message Length). Update this document if the architecture or file map changes.
- **PR descriptions say what a player will notice**, in plain language, the way release notes do. Commit messages carry the developer detail.
