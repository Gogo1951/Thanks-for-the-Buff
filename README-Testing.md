# Thanks for the Buff (TFTB) — Manual Test Plan

This is the manual test plan for Thanks for the Buff (TFTB) — the steps to confirm it works before a release is tagged. For what it does, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md); for how it works, see [README-Technical.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README-Technical.md).

## How to run this plan

Run the whole list on Classic Era, then again on TBC Anniversary. Do a `/reload` before starting each flavor.

Work top to bottom. Every step names what you should see and what failure looks like — if a step doesn't match, you have found a bug. Steps are numbered continuously from 1 to 120 across the whole plan, so a bug report can just say "failed on step 47."

Some steps behave differently on the two clients. Those steps say so in place and name the flavor that historically breaks. **Never skip the flavor a step calls out** — that is the entire reason the step exists. Running only Classic Era is not a completed test pass.

## Before you start

- **Both clients installed** — Classic Era and TBC Anniversary. The add-on ships on both and must be tested on both.
- **A second player you can coordinate with** — most of this plan needs someone to buff you, group with you, and be buffed by you. A second account or a patient friend both work.
- **Characters you can log** — a **priest** (Power Infusion, Fear Ward), a **mage** (portals, Amplify Magic), a **warlock** (Soulstone, Ritual of Summoning), and a **second character of the same class as one of them** for Peer Pressure. You do not need all of them on one run; skip the class steps for classes you can't field and note which you skipped on the sign-off grid.
- **Items in your bags** — a stat scroll (Scroll of Stamina, Scroll of Agility, etc. — cheap on the auction house) for the item-driven buff path. On TBC Anniversary, a set of Drums and a feast if you can get them.
- **Somewhere busy** — a capital city, for stranger buffs from passers-by and for someone else's portals.
- **Something to fight** — a target dummy or any low-level mob, for the combat steps.
- **Out of combat** unless a step says otherwise.
- **A non-English client** — only for the optional localization spot-check at the end.

## Verify this release's changes

This section is regenerated every release. These steps cover what changed since the last shipped build, and they are the highest-value part of the plan. Run them first, on both flavors.

### Smoke test

**1.** Log in with the add-on installed. A line beginning `TFTB //` prints to chat, giving a version number and telling you where the settings live. Failure is no line at all, or a red Lua error on screen.

**2.** Type `/reload`. The client reloads and the same `TFTB //` welcome line prints again, with no Lua error. Failure is an error window, or the line never coming back.

> **Note:** an unpackaged development copy reports its version as `Dev` rather than a date. That is correct and is not a failure — a packaged release from CurseForge or Wago shows a real version number.

### Options panel routing

The way the panel opens was rewritten this release. It now jumps straight to the registered category instead of looking the panel up by its title, which is what used to leave it floating loose.

**3.** Type `/tftb`. The settings must appear **docked inside the Blizzard Options window**, with **Thanks for the Buff (TFTB)** selected in the category list on the left. Failure looks like either nothing happening at all, or a standalone TFTB window floating free of the Options frame. **This is the step that historically breaks on TBC Anniversary — run it there and do not take the Era result as proof.**

**4.** Close Options. Open it the long way instead: Game Menu (Esc) → Options → AddOns → **Thanks for the Buff (TFTB)**. The same docked panel appears with the same contents. Failure is the add-on missing from the AddOns list, or its entry opening blank.

**5.** With the Options window already open on some other category, type `/tftb` again. The window jumps to Thanks for the Buff. Failure is the window closing, staying on the other category, or a second copy of the panel opening on top.

### One shared buff sound

The two separate buff sounds were collapsed into one; `Combat-Buff.ogg` is gone from the add-on.

**6.** Open **Buffs from Strangers** and click the small speaker icon beside **Enable Sound Effect**. A short chime plays. Failure is silence, or a Lua error about a missing file.

**7.** Open **Buffs from Teammates** and click its speaker icon. **The same chime plays** — identical to step 6. Failure is silence, an error, or a different sound (that would mean the old second sound file is still wired up).

**8.** Open **Peer Pressure** and click its speaker icon. A **different**, heavier sound plays (a thunder crack). Failure is silence, or hearing the same chime as steps 6 and 7.

### Peer Pressure "Trigger on Own Casts" now defaults off

This setting used to default on. It now defaults off, because the point of the feature is what everyone else is doing.

**9.** On a character that has never used the add-on (or after resetting the profile — see step 94), open **Peer Pressure**. **Trigger on Own Casts** is **unchecked**. Failure is finding it checked on a fresh profile.

**10.** With it unchecked, use one of your own cooldowns that is listed and checked on the Peer Pressure panel (for a rogue, Blade Flurry; for a priest, Power Infusion). **Nothing prints and no sound plays.** Now check **Trigger on Own Casts**, wait for the cooldown, and use it again — this time a `TFTB //` line prints naming you and the spell, and the thunder sound plays. Failure is an alert firing while the box is unchecked, or no alert after checking it.

### Group Services only announce for your group

Services used to announce for any friendly player the client could see. They are now limited to your party or raid.

**11.** Stand in a capital city, **not grouped with anyone**, near a mage opening portals or anyone setting out a feast. **Nothing prints.** Failure is a `TFTB // ... opened ...` or `... set out ...` line for a player you are not grouped with.

**12.** Now group with that player (or with your second character) and have them open a portal or set out a feast. A line prints: `TFTB // Name opened [Portal: Stormwind]!` or `TFTB // Name set out [Fish Feast]!`. Failure is nothing printing once you are grouped.

### Stranger buffs are only from outside your group

Stranger detection now reads the combat log's affiliation flags, so a group member's buff can no longer leak into the strangers path.

**13.** Join a party with your second player. Open **Buffs from Strangers** and turn on **Enable Print Out Messages**. Have your teammate cast a plain buff on you that is *not* listed on the Buffs from Teammates panel (Power Word: Fortitude, Mark of the Wild, Arcane Intellect). **No `... buffed you with ...` line prints** — they are a teammate, not a stranger. Failure is a stranger line printing for someone in your own party.

**14.** Leave the party. Have that same player cast that same buff on you again from outside the group. Now a line prints: `TFTB // Name buffed you with [Power Word: Fortitude]!`, with their name in class colour. Failure is nothing printing once you are ungrouped.

### Renamed option labels

Several labels were reworded this release.

**15.** Open **Buffs from Strangers**. The first two toggles read exactly **Enable Print Out Messages** and **Enable Thank You Whispers**. Failure is seeing the old wording — "Enable Print Out Messages (Self-Only)" or "Enable Thank You Messages".

**16.** On any panel with an emote picker, hover **/whoa**. The tooltip reads "You exclaim 'Whoa!' at <Target>." Failure is the old wording, "You look at <Target> and exclaim 'Whoa!'".

**17.** Walk every panel in the category list and read the labels, descriptions, and tooltips. Everything is a readable English sentence. Failure is any ALL-CAPS underscored key showing through — `MESSAGE_GOOD_NEWS`, `STRANGERS_DESCRIPTION`, `EMOTE_WHOA_DESCRIPTION` and the like. Every locale key was renamed this release, so a key that leaks through here is exactly the breakage this step is looking for.

> When steps 1–17 pass on both Classic Era and TBC Anniversary, this release's changes are verified — proceed to `4 - Pre-Launch Review Prompt.md`.

## The add-on loads and remembers your settings

**18.** Open **Thanks for the Buff (TFTB)** (the root panel). It shows a description of the add-on, an **Enable Welcome Message** toggle, a **/Commands** section listing `/tftb` and `/thankyou`, a **Feedback & Support** section with Discord, GitHub, CurseForge, and Wago addresses, and a version line at the bottom. Failure is any of those sections missing or blank.

**19.** Click into each of the four support address boxes and select the text. Each holds a complete, readable web address. Failure is an empty box or a truncated address.

**20.** Uncheck **Enable Welcome Message**, then `/reload`. **No welcome line prints.** Re-check it and `/reload` again — the line comes back. Failure is the line printing while the box is unchecked, or the box forgetting your choice across the reload.

**21.** Change several settings across different panels (turn on Strangers whispers, turn off a tracked ability on Buffs from Teammates, edit the Thank You whisper text). `/reload`. Every change is still there. Failure is any setting snapping back to its default.

**22.** Log out to character select and back in. The same settings are still there. Failure is settings surviving a `/reload` but not a real logout — that means they never reached disk.

**23.** Log in on a *different character on the same account*. The same settings are there — the add-on shares one profile account-wide by default. Failure is a second character starting from scratch.

## Options panel — navigation

**24.** With Options open on Thanks for the Buff, confirm the category list on the left shows these entries beneath it, in this order: **Buffs from Strangers**, **Buffs from Teammates**, **Group Services**, **Good News**, **Peer Pressure**, **Thank You Button**, **Profiles**, **Diagnostic Tools**. Failure is a missing entry, a duplicate, or a different order.

**25.** Click each of those eight entries in turn. Each opens a panel with a heading and content — none is blank, and none throws a Lua error. Failure is any empty panel.

**26.** On **Buffs from Teammates**, confirm the tracked abilities are grouped under class headings in the add-on's class colours, ordered alphabetically by class, with a plain **Items** group last. Failure is unsorted groups, an uncoloured heading, or Items appearing somewhere other than the bottom.

**27.** Within any one class group, confirm the abilities are listed alphabetically. Failure is a random or id-ordered list.

**28.** On **Buffs from Teammates** or **Group Services**, look for any entry labelled `Item #12345` or `Spell #12345`. Close the Options window and reopen the panel. Any such placeholder resolves to a real name and icon. Failure is a placeholder that is still there after reopening — the item never loaded.

**29.** On **Buffs from Teammates**, hover a grouped entry such as **Soulstone** or **Portals**. The tooltip lists every member the one checkbox covers. Failure is an empty tooltip, or a tooltip listing only one thing when the label is plural.

**30.** On **Buffs from Teammates**, hover a single ability such as **Innervate**. The tooltip shows that spell's own game description. Failure is an empty tooltip.

**31.** On **Group Services**, confirm there is **no** Enable Sound Effect toggle — that panel deliberately has none. Failure is a sound toggle appearing there.

**32.** On **Buffs from Strangers**, uncheck **Enable Emotes (When Out of Combat)**. The **Select Emotes** block below it disappears entirely. Re-check it — the block comes back with your emote choices intact. Failure is the block staying visible, or your emote selections resetting.

## Slash commands

**33.** Type `/tftb`. The docked options panel opens (same as step 3). Failure is nothing happening.

**34.** With no target selected, type `/thankyou`. A line prints: `TFTB // Select a player to thank.` Failure is silence, or an emote firing at nobody.

**35.** Target yourself and type `/thankyou`. A line prints: `TFTB // You can't thank yourself!` Failure is the add-on emoting at and whispering you.

**36.** Target a friendly player of your own faction and type `/thankyou`. You perform one of the emotes selected on the Thank You Button panel, directed at them, **and** they receive a plain whisper reading `Thanks, you're the best! (=` — with no `TFTB //` brand and no star icon on it. Failure is no emote, no whisper, or a whisper carrying the add-on brand.

**37.** Target an **opposite-faction** player and type `/thankyou`. The emote fires; **no whisper is sent**. Failure is the add-on attempting a cross-faction whisper.

**38.** Target a creature (any mob, not a player) and type `/thankyou`. A line prints: `TFTB // Select a player to thank.` Failure is an emote or whisper aimed at the mob.

## Buffs from Strangers

Run these ungrouped, in a busy city, with a second player who is **not** in your party.

**39.** Open **Buffs from Strangers** and read the description at the top: it describes a buff on you from a player outside your group. Confirm the panel has **no** master on/off switch — the print, whisper, emote, and sound toggles are the enable. Failure is a master enable toggle appearing on this panel.

**40.** On a fresh profile, confirm the defaults: **Enable Print Out Messages** off, **Enable Thank You Whispers** off, **Enable Emotes** on, **Enable Sound Effect** off, **Cooldown (Seconds)** at 3, **Minimum Buff Duration (Seconds)** at 25. Failure is any of those starting somewhere else.

**41.** Turn on **Enable Print Out Messages**. Have your ungrouped second player buff you with a long buff (Power Word: Fortitude, Mark of the Wild). A line prints: `TFTB // Name buffed you with [Power Word: Fortitude]!`, their name in class colour and the buff as a working blue link. Failure is no line, a plain-text buff name instead of a link, or an uncoloured name.

**42.** Click that spell link in chat. The spell's tooltip opens. Failure is the link doing nothing, which means it was built wrong.

**43.** Leave **Enable Print Out Messages** on and have them re-buff you several times in a row. **Every** buff prints a line — prints are deliberately not rate-limited. Failure is lines being swallowed.

**44.** Turn on **Enable Thank You Whispers**. Have them buff you. They receive a whisper reading `TFTB // Thanks for the [Power Word: Fortitude]!` with a **Star icon** at the front and a working spell link. Failure is no whisper, a missing star, or the spell link arriving as bare text with the brackets gone.

**45.** Have them buff you again immediately. **No second whisper is sent** — whispers to the same player are limited to one per 45 seconds. Wait out the 45 seconds, have them buff you once more, and the whisper arrives again. Failure is repeat whispers inside the window, or no whisper ever coming back after it.

**46.** Turn on **Enable Sound Effect**. Have them buff you. You hear the chime from step 6. Failure is silence.

**47.** With **Enable Emotes** on, have them buff you while they are standing in front of you. You perform one of your selected emotes **directed at them** — the emote text names them. Failure is an undirected emote ("You cheer.") when they are plainly visible, or an emote aimed at whoever you happen to have targeted.

**48.** Set **Cooldown (Seconds)** to 30. Have the same player buff you twice in quick succession. You emote for the first buff only. Have a *different* player buff you in that same window — you emote for them immediately, because the cooldown is per-player. Failure is emoting twice for the same player inside 30 seconds, or the second player's buff being swallowed.

**49.** Set **Minimum Buff Duration (Seconds)** to 60. Have a priest or druid put a short heal-over-time on you (Renew, Rejuvenation). **Nothing fires** — no print, no whisper, no emote. Have them cast a long buff instead and everything fires normally. Failure is the short buff triggering a reaction.

**50.** Set **Minimum Buff Duration (Seconds)** to 0. The short heal-over-time now triggers a reaction. Failure is 0 still filtering things out.

## Buffs from Teammates

Run these in a party with your second player.

**51.** On a fresh profile, open **Buffs from Teammates** and confirm the defaults: **Enable Print Out Messages** on, **Enable Thank You Whispers** on, **Enable Emotes** off, **Enable Sound Effect** off. Failure is any of those starting somewhere else.

**52.** Have your teammate cast a tracked cooldown on you — a priest's **Power Infusion**, a druid's **Innervate**, a paladin's **Hand of Protection**. A line prints: `TFTB // Name gave you [Power Infusion]!` and they receive a `TFTB // Thanks for the [Power Infusion]!` whisper with a Star icon. Failure is either half not arriving.

**53.** Have a teammate use a **stat scroll** on you (Scroll of Stamina and the like). A line prints in the form `TFTB // Name used their [Scroll of Stamina] on you!` — the link is to the **item**, not the spell, and the middle word is a pronoun matching their character's gender ("his", "her", or "their"). Failure is a spell link instead of an item link, or a `nil` where the pronoun should be.

**54.** Have a teammate use something that is cast *on* you rather than leaving a lasting buff — a druid's **Rebirth**, or Jumper Cables if you can arrange it. The line reads `TFTB // Name used [Rebirth] on you!`. Failure is the "gave you" wording, or nothing printing.

**55.** *(TBC Anniversary)* Have a teammate use **Drums** in the group. The line reads `TFTB // Name gave your group [Drums of Battle]!` — "your group", not "you". Failure is the solo wording. Drums do not exist on Classic Era, so this step applies to the Anniversary run only.

**56.** On **Buffs from Teammates**, uncheck a tracked ability (say Power Infusion). Have your teammate cast it on you. **Nothing fires.** Re-check it and have them cast again — the reaction returns. Failure is an unchecked ability still reacting.

**57.** Uncheck an ability on **Buffs from Teammates**, then open **Good News** and find the same ability. **It is still checked there** — the two panels keep independent lists over the same abilities. Failure is unchecking on one panel silently unchecking on the other.

**58.** Have your teammate buff you three times in a row with the same tracked cooldown. **Every one prints**, but they receive **at most one whisper** in a 45-second window. Failure is missing prints, or repeated whispers.

**59.** Turn on **Enable Sound Effect** and have a teammate buff you. You hear the chime. Failure is silence.

**60.** Turn on **Enable Emotes**, stand facing your teammate, and have them buff you. You emote at them by name. Failure is an undirected emote while they are standing right there.

## Group Services

Run these in a party with your second player. On Classic Era the list of services is short; on TBC Anniversary it is longer.

**61.** Open **Group Services** and read the description: a party or raid member's raid-wide help. Confirm the panel is one flat list of services with no class headings. Failure is class headings appearing here.

**62.** On a fresh profile, confirm **Enable Print Out Messages** is on and **Enable Thank You Whispers** is off. Failure is either starting the other way round.

**63.** Have a grouped mage open a portal. A line prints: `TFTB // Name opened [Portal: Stormwind]!` — "opened", with the actual portal spell linked, not the word "Portals". Failure is the "set out" wording, or the panel's group label appearing in the message instead of the real spell.

**64.** Have a grouped warlock cast **Ritual of Summoning**. The line reads `TFTB // Name opened [Ritual of Summoning]!`. Failure is nothing printing.

**65.** *(TBC Anniversary)* Have a grouped warlock cast **Ritual of Souls**, or anyone set out a feast. The line reads `TFTB // Name set out [Ritual of Souls]!` — "set out", not "opened". Failure is the wrong verb. Neither exists on Classic Era, so this step applies to the Anniversary run only.

**66.** Have the same grouped mage open several portals back to back within ten seconds. **Only the first prints** — services are rate-limited to one announcement per caster per ten seconds. Failure is a line for every portal.

**67.** Cast a service yourself (open your own portal, set out your own feast). **Nothing prints** — the add-on never announces your own services. Failure is announcing yourself.

**68.** Uncheck a service on the panel and have a teammate perform it. **Nothing prints.** Re-check it and it returns. Failure is an unchecked service still announcing.

## Good News

Good News whispers the people **you** buff. Run these with your second player, both grouped and ungrouped.

**69.** Open **Good News**. On a fresh profile, **Enable Good News** is checked and the dropdown beside it reads **Anyone You Buff**. Failure is either starting elsewhere.

**70.** Uncheck **Enable Good News**. Everything below it — the dropdown, the sample message, and the whole tracked list — disappears. Re-check it and everything comes back. Failure is content staying visible with the feature off.

**71.** Read the sample message shown on the panel. It renders as a Star icon followed by `TFTB // Good News! You have [Power Infusion] for 15 seconds!`, with a working blue spell link. Failure is a raw `{rt1}` showing as text, a broken link, or a missing duration.

**72.** Cast a tracked buff on your grouped teammate — Power Infusion, Innervate, Blessing of Kings. **They** receive a whisper reading `TFTB // Good News! You have [Power Infusion] for 15 seconds!`, led by a Star icon. Failure is no whisper, or a whisper to the wrong person.

**73.** Check the duration in that whisper against the buff's real remaining time. It reads as a rounded whole unit in your client's own words — "15 seconds", "10 minutes", "1 hour". Failure is "0 seconds", a raw number with no unit, or text containing stray characters like `|4`.

**74.** Cast a buff that leaves no lasting aura — a druid's **Rebirth** on a dead teammate. The whisper reads `TFTB // Good News! You have [Rebirth]!` with **no** duration clause. Failure is a nonsense duration being appended.

**75.** Cast **Fear Ward** (priest) or **Misdirection** (hunter) on a teammate. The whisper arrives with **no** duration clause — those are spent by an event, not by time. Failure is a "for 10 minutes" clause on either.

**76.** Recast the same buff on the same person immediately. **No second whisper is sent** within ten seconds. Wait past ten seconds and recast — the whisper arrives again. Failure is a whisper on every recast.

**77.** Begin casting a tracked buff on your teammate and **interrupt it** (move, or press Escape). **No whisper is sent.** Failure is a whisper going out for a cast that never landed.

**78.** Cast a tracked buff on your **pet** (or any non-player). **No whisper is sent** and no error appears in chat. Failure is a bounced whisper: "No player named 'X' is currently playing."

**79.** Leave the party. With the dropdown on **Anyone You Buff**, buff that same player from outside the group. **They still receive the Good News whisper.** Failure is nothing arriving — this out-of-group case is the feature's main purpose.

**80.** Set the dropdown to **Only Group Members** and buff that ungrouped player again. **No whisper is sent.** Re-group with them, buff them, and the whisper returns. Failure is a stranger being whispered while the setting says group only.

**81.** Uncheck an ability on the **Good News** tracked list, then cast it on a teammate. **No whisper is sent** for that ability, while other checked abilities still whisper normally. Failure is an unchecked ability still announcing.

## Peer Pressure

Peer Pressure fires when **another player of your class** pops a cooldown. You need a second player of the same class, close enough that you see their casts.

**82.** Open **Peer Pressure**. On a fresh profile, **Enable Peer Pressure** is checked, **Enable Print Out Messages** is checked, **Trigger on Own Casts** is unchecked, and **Enable Sound Effect** is checked. Failure is any of those starting elsewhere.

**83.** Uncheck **Enable Peer Pressure**. Everything below it disappears. Re-check it and everything returns. Failure is content staying visible with the feature off.

**84.** Read the sample message on the panel. It renders as `TFTB // Expektor used [Blade Flurry]!` with the name and sentence in rogue yellow and the spell link in link blue. Failure is an uncoloured line or a broken link.

**85.** Have your same-class second player use a cooldown that is checked on the panel. A line prints naming them and the spell, in your class's colour, and the thunder sound plays. Failure is nothing firing.

**86.** Have a player of a **different** class use one of their cooldowns nearby. **Nothing fires** — Peer Pressure only reacts to your own class. Failure is an alert for another class.

**87.** Have your same-class player use a cooldown **on someone else** — a rogue's Tricks of the Trade, a paladin's Hand of Protection. The line reads `TFTB // Name used [Tricks of the Trade] on Othername!`. Failure is the target being dropped from the sentence, or a self-cast wrongly showing an "on X" clause.

**88.** Uncheck **Enable Print Out Messages** but leave the sound on. Have them use a cooldown — **you hear the sound but see no line**. Failure is a line printing anyway.

**89.** Uncheck both **Enable Print Out Messages** and **Enable Sound Effect**. Have them use a cooldown — **nothing at all happens**. Failure is any reaction with both off.

**90.** Uncheck a specific ability in the tracked list, then have them use it. **Nothing fires**, while their other checked cooldowns still fire. Failure is an unchecked cooldown still alerting.

**91.** Confirm the panel lists cooldowns for **every** class, not just your own, each under a class-coloured heading. This is intentional — the profile is shared account-wide so you can configure any class from any character. Failure is only your own class appearing.

## Thank You Button

**92.** Open **Thank You Button**. On a fresh profile, **Create Macro** is checked and the **Whisper Message** field reads `Thanks, you're the best! (=`. Failure is either starting elsewhere.

**93.** Hover the **Create Macro** toggle. The tooltip names the macro `- Thank` in gold. Failure is a tooltip showing a placeholder such as `%s` instead of the name.

**94.** Open your macro list (Game Menu → Macros). A macro named **- Thank** exists, with a hand icon, and its body is exactly `/thankyou`. Failure is no macro, an empty body, or a differently named one.

**95.** Drag the **- Thank** macro to an action bar, target a friendly player of your faction, and click it. It behaves exactly like step 36 — an emote at them plus the plain whisper. Failure is the button doing nothing.

**96.** Delete the **- Thank** macro and `/reload`. It is recreated automatically. Failure is the macro staying gone.

**97.** Uncheck **Create Macro**, delete the macro, and `/reload`. It is **not** recreated. Failure is the macro coming back with the setting off.

**98.** Edit the **Whisper Message** field to something of your own, then use `/thankyou` on a friendly target. They receive **your** text, verbatim, with no add-on branding. Failure is the default text still being sent, or your text arriving with a `TFTB //` prefix attached.

**99.** Clear the **Whisper Message** field entirely and use `/thankyou` on a friendly target. The emote fires; **no whisper is sent** and no error appears. Failure is an empty whisper going out.

**100.** Click **Reset**. The field returns to `Thanks, you're the best! (=`. Failure is the field staying on your custom text or going blank.

**101.** In the **Select Emotes** block, uncheck everything except `/salute`. Use `/thankyou` on a friendly target several times — you salute every time. Failure is any other emote firing.

## Profiles

**102.** Open **Profiles**. It shows the standard profile controls: the current profile, a list of existing profiles, and options to create, copy, delete, and reset. Failure is a blank or broken panel.

**103.** Change a few distinctive settings, then create a **new** profile from the panel. The settings return to their defaults on the new profile. Switch back to the previous profile — your changes are still there. Failure is settings bleeding between profiles.

**104.** On the fresh profile, open **Buffs from Teammates**. The tracked list is fully populated with its default checkboxes — a new profile re-seeds its list rather than starting empty. Failure is an empty tracked list.

**105.** Use **Copy From** to copy your configured profile onto the current one. The settings and every tracked-ability checkbox come across. Failure is a partial copy, or the tracked lists emptying.

**106.** Use **Reset Profile**. Everything returns to the documented defaults, and the tracked lists refill. Failure is a reset leaving lists empty or settings half-changed.

## Diagnostic Tools

**107.** Open **Diagnostic Tools**. On a fresh install it shows only a warning paragraph and a single **Enable Diagnostic Tools** toggle, and that toggle is **off**. Failure is the tools being on by default, or their content showing before you enable them.

**108.** Check **Enable Diagnostic Tools**. Sections appear: Event Log, Event Registration, API Endpoints, Add-on Context, Other Add-ons, Saved Variables, Library Versions, Taint Log, External Tools. Failure is a missing section or a Lua error.

**109.** Click **Show Log** without having started logging. The output box is empty. Failure is stale content appearing from nowhere.

**110.** Click **Start Logging**, move around and let a few buffs land, then click **Stop Logging** and **Show Log**. The box fills with recent events and their values. Failure is an empty box after logging was clearly running.

**111.** Click **Run Event Checks**, **Run API Checks**, **Show Context**, **List Add-ons**, **Dump Saved Variables**, and **List Libraries** in turn. Each fills its own output box with readable text. Failure is any button producing an empty box or an error.

**112.** In the **Add-on Context** output, find the counts of tracked abilities and watched ids. They are non-zero. Failure is zeroes, which would mean the add-on found none of its abilities on this client.

**113.** Select the text in any output box. It highlights and can be copied — these reports exist to be pasted into a bug report. Failure is text that can't be selected.

**114.** Uncheck **Enable Diagnostic Tools**. Every section disappears and logging stops. Failure is sections lingering, or the log continuing to grow.

**115.** `/reload` with diagnostics left **on**. It comes back **off**, with all reports cleared — diagnostics are runtime-only and never saved. Failure is the setting or any report surviving the reload.

## Combat behavior

**116.** Turn on **Enable Emotes** for **Buffs from Teammates**. Get into combat with a target dummy or a mob, and have your teammate buff you with a tracked cooldown while you are fighting. The chat line prints and the sound plays, but **no emote is performed**. Failure is emoting mid-fight.

**117.** Leave combat, then have them buff you again. The emote fires normally on this next buff. Failure is emotes staying suppressed after combat ends. (An emote skipped during combat is skipped for good — it is not replayed later. That is correct behaviour, not a bug.)

**118.** While still in combat, confirm the **whisper** still went out to your teammate. Only emotes are held back in combat. Failure is whispers being swallowed mid-fight.

**119.** While in combat, type `/tftb`. The options panel opens as usual with no Lua error. Failure is an error window or a blocked-action message.

**120.** Immediately after a loading screen — a zone change, a portal, a dungeon entrance — have someone buff you within the first two or three seconds. Reactions are deliberately paused for a moment while the world settles, then resume normally. Failure is reactions never coming back after the pause, or a Lua error during the loading screen.

## Flavor differences to watch

These are the places Classic Era and TBC Anniversary genuinely differ. Do not let a clean Era run stand in for either of them.

- **The options panel dock (step 3).** This is the big one. The panel docks correctly on Classic Era but has historically floated free on TBC Anniversary. The Anniversary run of step 3 is the single most important step in this plan — if the panel floats or fails to open there, the release is not shippable, because `/tftb` and the Options window are the *only* ways into the settings. There is no minimap button to fall back on.
- **The tracked lists are shorter on Classic Era.** Buffs from Teammates and Group Services list only what exists on the running client. TBC Anniversary should show strictly more — Drums, Ritual of Souls, Ritual of Refreshment, Fisherman's Feast. Failure is an entry appearing on Era for content that does not exist there, or an entry stuck at `Spell #12345` / `Item #12345` on either flavor.
- **Peer Pressure's mage rows differ by design.** Classic Era lists **Cold Snap** and **Ice Block**. TBC Anniversary lists **Cold Snap**, **Icy Veins**, and **Ice Block**. Blizzard reuses the same spell ids for different abilities across the two clients, so check that no ability is listed **twice** and none is listed under the **wrong name** on either flavor.
- **Peer Pressure's warrior Death Wish** appears exactly once on each flavor. Two entries, or none, is a failure.
- **Class availability.** Death Knight abilities appear on neither of these clients. Seeing a Death Knight group on the Buffs from Teammates or Peer Pressure panel is a failure on both flavors.

## Localization spot-check

Optional, and only worth running if you can start a non-English client. Every locale key in the add-on was renamed this release, so this pass has more value than usual.

**Run steps 17, 41, 52, 53, 71, and 84 again on a non-English client**, and check the following:

- **No raw keys.** Every label, description, and chat line is real translated text. Anything showing as `MESSAGE_GAVE_YOU`, `STRANGERS_DESCRIPTION`, or similar is an untranslated or misnamed key.
- **Placeholders resolve.** Chat lines name a real player and link a real spell or item. A literal `%s`, a `%d`, or the word `nil` appearing in a sentence is a failure, as is a name or spell appearing twice in one line.
- **Durations read naturally.** Good News durations use the client's own words for minutes and seconds. Stray characters such as `|4` mean the message will be rejected by chat entirely — check the whisper actually **arrives** on the recipient's screen, not just that it looks right on yours.
- **Portuguese word order is intentional.** In ptBR, the "used their X on you" line puts the item before the pronoun. That is a deliberate reordering to match Portuguese grammar and is not a bug.
- **Russian is the width canary.** ruRU produces the longest byte-for-byte lines. Confirm the Good News and thank-you whispers still arrive intact there with their spell links rendered — a line over the chat limit is dropped silently, so a *missing* whisper is what failure looks like, not a truncated one.
- **Custom whisper text.** The Thank You Button whisper field is yours to fill; if you type a very long message in a non-Latin locale it can exceed the chat limit and be dropped. Confirm a long custom message either arrives or is visibly rejected — never silently lost.

## Sign-off

When every step above passes on **both** Classic Era and TBC Anniversary, manual testing is complete and the add-on is ready for `4 - Pre-Launch Review Prompt.md`.

A pass on one flavor is not a pass. Fill in both rows.

| Flavor | Tester | Date | Result | Notes / failed steps |
| --- | --- | --- | --- | --- |
| Classic Era | | | ☐ Pass ☐ Fail | |
| TBC Anniversary | | | ☐ Pass ☐ Fail | |

## Guide Feedback

**Pass:** README-Testing generation
**Add-on:** Thanks for the Buff (TFTB)

One item.

**1. Section 5's cold-generation fallback discards change data that is reliably available.**

- **Current wording:** "When this plan is generated right after a Code Review + fixes (the issues are in this session) or from the session's diff (dev copies carry no changelog — the permission pass deletes it), list one concrete test per change… If there are **no** recent changes in context (the plan is being written cold), replace this with a short **Smoke test**."
- **The reality:** this session had neither a Code Review nor a session diff, so by the rule as written the correct output was a generic smoke test. But the add-on folders are not a git repo and the dev copy sits alongside the **last shipped build in the sibling flavor folder** — `_anniversary_/Interface/AddOns/TFTB/` still carried version `2026.07.17.A`. Diffing the two recovered the full release delta: the options-panel opener rewrite, `triggerOnOwnCasts` flipping from `true` to `false`, the two buff sounds collapsing into one and `Combat-Buff.ogg` being deleted, Group Services gaining a party/raid filter, stranger detection gaining the affiliation-flag test, and a full locale key rename across all eleven locale files. Every one of those is user-observable and became a concrete step. A smoke test would have shipped none of them, and the flipped default and the deleted sound file in particular are exactly the kind of change a tester would otherwise never think to check.
- **Suggested edit:** add the sibling flavor folder as a third named change source in section 5, ahead of the smoke-test fallback — e.g. "…or from a diff of the working copy against the last shipped build, which for these add-ons is usually the copy installed in the other flavor's `Interface/AddOns/` folder (compare the TOC `## Version` lines to confirm which is older)." Keep the smoke-test fallback for when that diff is empty or unavailable.

Paste the line below into a **new Cowork session with the Add-on Creation Factory folder connected** — do not run it in this code session.

```
Triage the Guide Feedback above using References/Guide Feedback Triage Prompt.md — consolidate the items, then ask me one multiple-choice approve/reject question per proposed change before editing anything.
```
