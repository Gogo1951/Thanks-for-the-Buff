# Thanks for the Buff (TFTB) — Manual Test Plan

This is the manual test plan for Thanks for the Buff (TFTB) — the steps to confirm it works before a release is tagged. For what it does, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md); for how it works, see [README-Technical.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README-Technical.md).

## How to run this plan

Run the whole list on Classic Era, then again on TBC Anniversary. Do a `/reload` before starting each flavor.

Work top to bottom. Every step names what you should see and what failure looks like — if a step doesn't match, you have found a bug. Steps are numbered continuously from 1 to 138 across the whole plan, so a bug report can just say "failed on step 47."

Some steps behave differently on the two clients. Those steps say so in place and name the flavor that historically breaks. **Never skip the flavor a step calls out** — that is the entire reason the step exists. Running only Classic Era is not a completed test pass.

## Before you start

- **Both clients installed** — Classic Era and TBC Anniversary. The add-on ships on both and must be tested on both.
- **A second player you can coordinate with** — most of this plan needs someone to buff you, group with you, and be buffed by you. A second account or a patient friend both work.
- **A third player, briefly** — for step 15 (a cooldown cast on someone other than you) and step 53 (praising one player must not block praising another).
- **Characters you can log** — a **priest** (Power Infusion, Fear Ward), a **mage** (portals, Amplify Magic), a **warlock** (Soulstone, Ritual of Summoning), a **druid** (Innervate, Rebirth), and **two paladins** for the Peer Pressure steps, which need a same-class player casting on a third person. You do not need all of them on one run; skip the class steps for classes you can't field and note which you skipped on the sign-off grid.
- **Items in your bags** — a stat scroll (Scroll of Stamina, Scroll of Agility, etc. — cheap on the auction house) for the item-driven buff path. On TBC Anniversary, a set of Drums and a feast if you can get them.
- **Somewhere busy** — a capital city, for stranger buffs from passers-by and for someone else's portals.
- **Something to fight** — a target dummy or any low-level mob, for the combat steps.
- **Out of combat** unless a step says otherwise.
- **A non-English client** — only for the optional localization spot-check at the end.

## Verify this release's changes

This section is regenerated every release. These steps cover what changed since the last shipped build, and they are the highest-value part of the plan. Run them first, on both flavors.

### Smoke test

**1.** Log in with the add-on installed. A line beginning `TFTB //` prints to chat, giving a version number and pointing you at **Options > AddOns > Thanks for the Buff (TFTB)** — the name in that sentence now carries the `(TFTB)` suffix, matching the entry you actually see in the Options list. Failure is no line at all, a red Lua error on screen, or the sentence still ending at "Thanks for the Buff" with no suffix.

**2.** Type `/reload`. The client reloads and the same `TFTB //` welcome line prints again, with no Lua error. Failure is an error window, or the line never coming back.

> **Note:** an unpackaged development copy reports its version as `Dev` rather than a date. That is correct and is not a failure — a packaged release from CurseForge or Wago shows a real version number.

**3.** Type `/tftb`. The settings appear **docked inside the Blizzard Options window**, with **Thanks for the Buff (TFTB)** selected in the category list on the left. Failure looks like either nothing happening at all, or a standalone TFTB window floating free of the Options frame. **This step historically breaks on TBC Anniversary — run it there and do not take the Era result as proof.**

### The Options Interface refuses to open in combat

New this release: asking for the settings mid-fight now gets a polite refusal instead of an error.

**4.** Attack a target dummy or a mob so you are **in combat**, then type `/tftb`. A single line prints, word for word: `TFTB // As a safety precaution, the Options Interface cannot be opened during combat.` The panel does **not** open. Failure is the panel opening anyway, nothing printing at all, or a red `ADDON_ACTION_BLOCKED` error naming Thanks for the Buff.

**5.** Still in combat, type `/tftb` twice more. The same line prints **every single time** you ask. Failure is silence on the second and third attempt — a command that quietly does nothing reads as broken.

**6.** Leave combat. The panel must **not** spring open by itself now that the fight is over. Type `/tftb` — it opens normally, docked, exactly as in step 3. Failure is a panel appearing on its own the moment combat drops, or `/tftb` still refusing once you are out of combat.

### The /Commands section

**7.** Open the root **Thanks for the Buff (TFTB)** panel and find the **/Commands** section. It holds exactly two lines. The first is `/tftb` in blue followed by **Opens the Options Interface for this add-on.** The second is `/thankyou` in blue followed by **Emotes at and whispers your current target.** Failure is the `/tftb` line still reading "Opens the Thanks for the Buff options interface.", either line missing, or the header showing as a raw key instead of the words **/Commands**.

**8.** Look at the gap between those two lines. There is a **full blank line** between them — the same breathing room you see between two ordinary settings — not a tight line break with the two commands stacked against each other. Failure is the two lines touching.

### Labels now sit beside their controls

A batch of settings that used to stack a caption above its box now put the label and the box on one line.

**9.** On the root panel, look at **Feedback & Support**. Discord, GitHub, CurseForge, and Wago each appear as a gold label with its address box **on the same line, to the right of it** — four rows in total, in that order. Failure is a label sitting on its own line above its box, giving you eight rows instead of four.

**10.** Click into each of those four boxes in turn and select the text. Each holds a complete, readable web address, and the box is wide enough that the end of the address is reachable. Failure is an empty box, or an address whose tail you cannot scroll to or read.

**11.** Open **Thank You Button**. **Whisper Message** is a label with its text box **on the same line, to the right**, and the **Reset** button follows. The box holds `Thanks, you're the best! (=` and shows enough of it to edit comfortably. Failure is the caption sitting above the box, or the box on a line of its own.

**12.** Open **Good News**. **Enable Good News** and the recipient dropdown share **one row**, dropdown to the right of the toggle. Open the dropdown and read both entries — **Anyone You Buff** and **Only Group Members** — then select each in turn. Neither value is clipped or cut short in the closed dropdown. Failure is the dropdown dropping to its own line, or a value that doesn't fit.

**13.** Open **Buffs from Strangers** and check **Enable Praise Delay**. The length dropdown appears **on the same row, to its right**, and carries **no caption of its own** — the old **Delay** label above it is gone. Failure is a "Delay" caption reappearing, or the dropdown falling onto its own line.

**14.** Confirm the same one-row layout for **Enable Praise Delay** on **Buffs from Teammates** and on **Group Services**. Failure is either panel putting the dropdown on its own line, or restoring the caption.

### Peer Pressure names the target in their own class color

**15.** With two paladins (you and your same-class second player) and a **third player of a different class**, have your second paladin cast **Hand of Protection** or **Lay on Hands** on that third player. A line prints: `TFTB // Name used [Hand of Protection] on Othername!`. The caster's name and the words of the sentence are in **your class's color**, the spell link is link blue, and **the target's name is in that player's own class color**. Failure is the target's name coming out in the caster's color or plain white, or the rest of the sentence losing its color after the target's name.

**16.** Have that same paladin cast a cooldown **on themselves** (Divine Shield), and then one **on their pet or a non-player** if they have one. Both read as the plain `TFTB // Name used [Divine Shield]!` with **no "on X" clause**. Failure is an "on X" clause naming the caster themselves, or naming a pet.

> When steps 1–16 pass on both Classic Era and TBC Anniversary, this release's changes are verified — proceed to `4 - Pre-Launch Review Prompt.md`.

## The add-on loads and remembers your settings

**17.** Open **Thanks for the Buff (TFTB)** (the root panel). It shows, top to bottom: a description of the add-on, an **Enable Welcome Message** toggle, the **/Commands** section, a **Feedback & Support** section with Discord, GitHub, CurseForge, and Wago, and a gray version line at the very bottom. Failure is any of those sections missing or blank.

**18.** Uncheck **Enable Welcome Message**, then `/reload`. **No welcome line prints.** Re-check it and `/reload` again — the line comes back. Failure is the line printing while the box is unchecked, or the box forgetting your choice across the reload.

**19.** Change several settings across different panels (turn on Strangers whispers, turn off a tracked ability on Buffs from Teammates, edit the Thank You whisper text). `/reload`. Every change is still there. Failure is any setting snapping back to its default.

**20.** Log out to character select and back in. The same settings are still there. Failure is settings surviving a `/reload` but not a real logout — that means they never reached disk.

**21.** Log in on a *different character on the same account*. The same settings are there — the add-on shares one profile account-wide by default. Failure is a second character starting from scratch.

**22.** Read the version line at the foot of the root panel. It reads **Version** followed by the same value the welcome line printed in step 1. Failure is the two disagreeing, or the line showing an empty value.

## Options panel — navigation

**23.** Close Options. Open it the long way instead: Game Menu (Esc) → Options → AddOns → **Thanks for the Buff (TFTB)**. The same docked panel appears with the same contents. Failure is the add-on missing from the AddOns list, or its entry opening blank.

**24.** With the Options window already open on some other category, type `/tftb` again. The window jumps to Thanks for the Buff. Failure is the window closing, staying on the other category, or a second copy of the panel opening on top.

**25.** With Options open on Thanks for the Buff, confirm the category list on the left shows these entries beneath it, in this order: **Buffs from Strangers**, **Buffs from Teammates**, **Group Services**, **Good News**, **Peer Pressure**, **Thank You Button**, **Profiles**, **Diagnostic Tools**. Failure is a missing entry, a duplicate, or a different order.

**26.** Click each of those eight entries in turn. Each opens a panel with a heading and content — none is blank, and none throws a Lua error. Failure is any empty panel.

**27.** On **Buffs from Teammates**, confirm the tracked abilities are grouped under class headings in the add-on's class colours, ordered alphabetically by class, with a plain **Items** group last. Failure is unsorted groups, an uncoloured heading, or Items appearing somewhere other than the bottom.

**28.** Within any one class group, confirm the abilities are listed alphabetically. Failure is a random or id-ordered list.

**29.** On **Buffs from Teammates** or **Group Services**, look for any entry labelled `Item #12345` or `Spell #12345`. Close the Options window and reopen the panel. Any such placeholder resolves to a real name and icon. Failure is a placeholder that is still there after reopening — the item never loaded.

**30.** On **Buffs from Teammates**, hover a grouped entry such as **Soulstone**, or **Portals** on **Group Services**. The tooltip lists every member the one checkbox covers. Failure is an empty tooltip, or a tooltip listing only one thing when the label is plural.

**31.** On **Buffs from Teammates**, hover a single ability such as **Innervate**. The tooltip shows that spell's own game description. If you find an entry whose tooltip falls back to the add-on's own wording instead, it reads **Toggle tracking for Name.** — one sentence, ending in a full stop. Failure is an empty tooltip, or that fallback sentence running on with no full stop.

**32.** On **Buffs from Strangers**, uncheck **Enable Emotes (When Out of Combat)**. The **Select Emotes** block below it disappears entirely. Re-check it — the block comes back with your emote choices intact. Failure is the block staying visible, or your emote selections resetting.

## Every buff panel is split into Praise and Notifications

Each buff panel separates what the other player sees from what only you get.

**33.** Open **Buffs from Strangers**. Below the description you see a ruled section header reading **Praise Messages & Emotes**, and further down a second ruled header reading **Notifications**. Both are full-width horizontal rules with the title set into them — the same style as the **/Commands** header on the root panel. Failure is a plain yellow line of text with no rule through it, or either header missing.

**34.** On that same panel, read the order of controls under **Praise Messages & Emotes**: **Enable Emotes (When Out of Combat)** first, then the **Select Emotes** block, then **Enable Thank You Whispers**, then **Enable Praise Delay**, then the three sliders. Failure is whispers appearing above emotes.

**35.** Confirm the **Notifications** section below holds **Enable Print Out Messages** and **Enable Sound Effects** (with its speaker icon), and nothing else. Failure is a print or sound toggle appearing up in the Praise section.

**36.** Open **Buffs from Teammates** and then **Group Services**. Both have the same two headers in the same order, with emotes above whispers, and **neither carries any cooldown sliders** — those live only on Buffs from Strangers. Failure is either panel showing a single combined header, or a cooldown slider turning up where it doesn't belong.

**37.** Open **Peer Pressure**. The sample alert line sits **directly under Enable Peer Pressure**, before any header. Below it, the one section header reads **Notifications** — Peer Pressure sends nothing outward, so it has no Praise section. Failure is the sample buried at the bottom near the tracked list, or a Praise header appearing here.

## Slash commands

**38.** Type `/tftb` out of combat. The docked options panel opens (same as step 3). Failure is nothing happening.

**39.** With no target selected, type `/thankyou`. A line prints: `TFTB // Select a player to thank.` Failure is silence, or an emote firing at nobody.

**40.** Target yourself and type `/thankyou`. A line prints: `TFTB // You can't thank yourself!` Failure is the add-on emoting at and whispering you.

**41.** Target a friendly player of your own faction and type `/thankyou`. You perform one of the emotes selected on the Thank You Button panel, directed at them, **and** they receive a plain whisper reading `Thanks, you're the best! (=` — with no `TFTB //` brand and no star icon on it. Failure is no emote, no whisper, or a whisper carrying the add-on brand.

**42.** Target an **opposite-faction** player and type `/thankyou`. The emote fires; **no whisper is sent**. Failure is the add-on attempting a cross-faction whisper.

**43.** Target a creature (any mob, not a player) and type `/thankyou`. A line prints: `TFTB // Select a player to thank.` Failure is an emote or whisper aimed at the mob.

## Buffs from Strangers

Run these ungrouped, in a busy city, with a second player who is **not** in your party.

**44.** Open **Buffs from Strangers** and read the description at the top: it describes a buff on you from a player outside your group. Confirm the panel has **no** master on/off switch — the print, whisper, emote, and sound toggles are the enable. Failure is a master enable toggle appearing on this panel.

**45.** On a fresh profile, confirm the defaults: **Enable Emotes** on, **Enable Thank You Whispers** off, **Enable Praise Delay** off, **Praise Cooldown (Seconds)** at 0, **Same-Source Praise Cooldown (Seconds)** at 3, **Minimum Buff Duration (Seconds)** at 25, **Enable Print Out Messages** off, **Enable Sound Effects** off. Failure is any of those starting somewhere else.

**46.** Turn on **Enable Print Out Messages**. Have your ungrouped second player buff you with a long buff (Power Word: Fortitude, Mark of the Wild). A line prints: `TFTB // Name buffed you with [Power Word: Fortitude]!`, their name in class colour and the buff as a working blue link. Failure is no line, a plain-text buff name instead of a link, or an uncoloured name.

**47.** Click that spell link in chat. The spell's tooltip opens. Failure is the link doing nothing, which means it was built wrong.

**48.** Leave **Enable Print Out Messages** on and have them re-buff you several times in a row. **Every** buff prints a line — prints are deliberately not rate-limited. Failure is lines being swallowed.

**49.** Turn on **Enable Thank You Whispers**. Have them buff you. They receive a whisper reading `TFTB // Thanks for the [Power Word: Fortitude]!` with a **Star icon** at the front and a working spell link. Failure is no whisper, a missing star, or the spell link arriving as bare text with the brackets gone.

**50.** Turn on **Enable Sound Effects**. Click the speaker icon beside it — the chime plays even with the toggle off. Then have them buff you: you hear the chime. Failure is a silent speaker, or silence once the toggle is on.

**51.** With **Enable Emotes** on, have them buff you while they are standing in front of you. You perform one of your selected emotes **directed at them** — the emote text names them. Failure is an undirected emote ("You cheer.") when they are plainly visible, or an emote aimed at whoever you happen to have targeted.

**52.** Set **Same-Source Praise Cooldown** to 30, with emotes on and whispers on. Have the same ungrouped player buff you twice in quick succession. You praise for the first buff only — one emote, one whisper. Failure is a second emote or whisper inside the 30 seconds; this slider covers whispers as well as emotes.

**53.** Leave **Praise Cooldown** at 0 and have a **different** player buff you inside that same 30-second window. You praise them immediately, because the same-source limit is per player. Now set **Praise Cooldown** to 30 as well and repeat with two different players — the second player's buff produces **no** praise until the 30 seconds are up. Failure is the overall slider having no effect.

**54.** Set **Praise Cooldown** to 0 and **Same-Source Praise Cooldown** to its lowest value of 1, leave whispers on, and have the same player buff you repeatedly. You still send **at most one whisper per 45 seconds** to that player, no matter how low the sliders go. Failure is repeat whispers inside 45 seconds — that safety floor is deliberate and no setting may lower it.

**55.** Throughout steps 52–54, confirm the **chat line and sound fire every single time**, regardless of either cooldown. Failure is a notification being swallowed by a praise cooldown.

**56.** Hover **Minimum Buff Duration (Seconds)**. Its tooltip says plainly that a buff below the threshold is ignored completely — no message, sound, whisper, or emote. Set it to 60, turn every reaction on, and have a priest or druid put a short heal-over-time on you (Renew, Rejuvenation). **Nothing happens at all — not even the chat line or the sound.** Failure is a chat line or sound still appearing for the short buff, or a tooltip that mentions only thank-yous.

**57.** Set **Minimum Buff Duration (Seconds)** to 0. That same short heal-over-time now triggers a reaction. Failure is 0 still filtering things out.

**58.** Join a party with that player. Have them cast a plain buff on you that is *not* listed on the Buffs from Teammates panel (Power Word: Fortitude, Mark of the Wild, Arcane Intellect). **No `... buffed you with ...` line prints** — they are a teammate, not a stranger. Leave the party and have them cast it again: the stranger line returns. Failure is a stranger line printing for someone in your own party, or nothing printing once you are ungrouped again.

## Praise Delay

An optional pause before your thanks goes out, offered by all three buff panels. Run these on **Buffs from Strangers** with an ungrouped second player.

**59.** On a fresh profile, find **Enable Praise Delay**. It is **unchecked**, and there is **no dropdown beside it**. Failure is finding it checked, or a dropdown visible while the toggle is off.

**60.** Check **Enable Praise Delay**. A dropdown appears beside it offering **1 second, 2 seconds, 3 seconds, 4 seconds**, with **2 seconds** already selected. The wording comes from your game client, so on a non-English client it reads in that language. Failure is no dropdown, an empty dropdown, or entries reading as raw numbers with no unit.

**61.** Set the delay to 4 seconds with **Enable Print Out Messages**, **Enable Sound Effects**, **Enable Thank You Whispers**, and **Enable Emotes** all on, then have an ungrouped player buff you. The chat line prints and the sound plays **immediately**; the whisper and the emote arrive about four seconds later. Failure is the print or sound being delayed too, or the whisper and emote firing instantly.

**62.** With the delay still on, have them buff you and **change your target while the delay is running** — target anyone else, or just move your mouse over another player. When the emote fires, it is still directed at **the player who buffed you**. Failure is the emote naming whoever you switched to.

**63.** With the delay still on, have them buff you and **enter combat before the delay expires** (attack a dummy). The whisper still goes out; **no emote is performed**. Failure is an emote firing while you are in combat.

**64.** Uncheck **Enable Praise Delay** and have them buff you again. Everything fires immediately. Failure is a lingering delay with the toggle off.

## Buffs from Teammates

Run these in a party with your second player.

**65.** On a fresh profile, open **Buffs from Teammates** and confirm the defaults: **Enable Emotes** off, **Enable Thank You Whispers** on, **Enable Praise Delay** off, **Enable Print Out Messages** on, **Enable Sound Effects** off. Failure is any of those starting somewhere else.

**66.** Have your teammate cast a tracked cooldown on you — a priest's **Power Infusion**, a druid's **Innervate**, a paladin's **Hand of Protection**. A line prints: `TFTB // Name gave you [Power Infusion]!` and they receive a `TFTB // Thanks for the [Power Infusion]!` whisper with a Star icon. Failure is either half not arriving.

**67.** Have a teammate use a **stat scroll** on you (Scroll of Stamina and the like). A line prints in the form `TFTB // Name used their [Scroll of Stamina] on you!` — the link is to the **item**, not the spell, and the middle word is a pronoun matching their character's gender ("his", "her", or "their"). Failure is a spell link instead of an item link, or a `nil` where the pronoun should be.

**68.** Have a teammate use something that is cast *on* you rather than leaving a lasting buff — a druid's **Rebirth**, or Jumper Cables if you can arrange it. The line reads `TFTB // Name used [Rebirth] on you!`. Failure is the "gave you" wording, or nothing printing.

**69.** *(TBC Anniversary)* Have a teammate use **Drums** in the group. The line reads `TFTB // Name gave your group [Drums of Battle]!` — "your group", not "you". Failure is the solo wording. Drums do not exist on Classic Era, so this step applies to the Anniversary run only.

**70.** Uncheck a tracked ability (say Power Infusion). Have your teammate cast it on you. **Nothing fires.** Re-check it and have them cast again — the reaction returns. Failure is an unchecked ability still reacting.

**71.** Uncheck an ability on **Buffs from Teammates**, then open **Good News** and find the same ability. **It is still checked there** — the two panels keep independent lists over the same abilities. Failure is unchecking on one panel silently unchecking on the other.

**72.** Have your teammate buff you three times in a row with the same tracked cooldown. **Every one prints**, but they receive **at most one whisper** in a 45-second window. Failure is missing prints, or repeated whispers.

**73.** Turn on **Enable Sound Effects** and have a teammate buff you. You hear the chime. Failure is silence.

**74.** Turn on **Enable Emotes**, stand facing your teammate, and have them buff you. You emote at them by name. Failure is an undirected emote while they are standing right there.

## Group Services

Run these in a party with your second player. On Classic Era the list of services is short; on TBC Anniversary it is longer.

**75.** Open **Group Services** and read the description: a party or raid member's raid-wide help. Confirm the tracked list is one flat list of services with no class headings. Failure is class headings appearing here.

**76.** On a fresh profile, confirm **Enable Print Out Messages** is on, **Enable Thank You Whispers** is off, and **Enable Sound Effects** is off. Failure is any of them starting the other way round.

**77.** Have a grouped mage open a portal. A line prints: `TFTB // Name opened [Portal: Stormwind]!` — "opened", with the actual portal spell linked, not the word "Portals". Failure is the "set out" wording, or the panel's group label appearing in the message instead of the real spell.

**78.** Have a grouped warlock cast **Ritual of Summoning**. The line reads `TFTB // Name opened [Ritual of Summoning]!`. Failure is nothing printing.

**79.** *(TBC Anniversary)* Have a grouped warlock cast **Ritual of Souls**, or anyone set out a feast. The line reads `TFTB // Name set out [Ritual of Souls]!` — "set out", not "opened". Failure is the wrong verb. Neither exists on Classic Era, so this step applies to the Anniversary run only.

**80.** Have the same grouped mage open several portals back to back within ten seconds. **Only the first prints** — services are rate-limited to one announcement per caster per ten seconds. Failure is a line for every portal.

**81.** Cast a service yourself (open your own portal, set out your own feast). **Nothing prints** — the add-on never announces your own services. Failure is announcing yourself.

**82.** Stand **ungrouped** near a mage opening portals or anyone setting out a feast. **Nothing prints.** Failure is a service line for a player you are not grouped with.

**83.** Uncheck a service on the panel and have a teammate perform it. **Nothing prints.** Re-check it and it returns. Failure is an unchecked service still announcing.

**84.** Click the speaker icon beside **Enable Sound Effects** — the chime plays even with the toggle off. Check the toggle, then have a grouped player set out a feast or open a portal: you hear the chime. Failure is a silent speaker, or no sound once enabled.

## Good News

Good News whispers the people **you** buff. Run these with your second player, both grouped and ungrouped.

**85.** Open **Good News**. On a fresh profile, **Enable Good News** is checked and the dropdown beside it reads **Anyone You Buff**. Failure is either starting elsewhere.

**86.** Uncheck **Enable Good News**. Everything below it — the dropdown, the sample message, and the whole tracked list — disappears. Re-check it and everything comes back. Failure is content staying visible with the feature off.

**87.** Read the sample message shown on the panel. It renders as a Star icon followed by `TFTB // Good News! You have [Power Infusion] for 15 seconds!`, with a working blue spell link. Failure is a raw `{rt1}` showing as text, a broken link, or a missing duration.

**88.** Cast a tracked buff on your grouped teammate — Power Infusion, Innervate, Blessing of Kings. **They** receive a whisper reading `TFTB // Good News! You have [Power Infusion] for 15 seconds!`, led by a Star icon. Hold this against the sample from step 87: the two read the **same shape** — same star, same brand, same link style, same duration phrasing. Failure is no whisper, a whisper to the wrong person, or a real message that looks nothing like the sample the panel advertises.

**89.** Check the duration in that whisper against the buff's real remaining time. It reads as a rounded whole unit in your client's own words — "15 seconds", "10 minutes", "1 hour". Failure is "0 seconds", a raw number with no unit, or text containing stray characters like `|4`.

**90.** Cast a buff that leaves no lasting aura — a druid's **Rebirth** on a dead teammate. The whisper reads `TFTB // Good News! You have [Rebirth]!` with **no** duration clause. Failure is a nonsense duration being appended.

**91.** Cast **Fear Ward** (priest) or **Misdirection** (hunter) on a teammate. The whisper arrives with **no** duration clause — those are spent by an event, not by time. Failure is a "for 10 minutes" clause on either.

**92.** Recast the same buff on the same person immediately. **No second whisper is sent** within ten seconds. Wait past ten seconds and recast — the whisper arrives again. Failure is a whisper on every recast.

**93.** Begin casting a tracked buff on your teammate and **interrupt it** (move, or press Escape). **No whisper is sent.** Failure is a whisper going out for a cast that never landed.

**94.** Cast a tracked buff on your **pet** (or any non-player). **No whisper is sent** and no error appears in chat. Failure is a bounced whisper: "No player named 'X' is currently playing."

**95.** Leave the party. With the dropdown on **Anyone You Buff**, buff that same player from outside the group. **They still receive the Good News whisper.** Failure is nothing arriving — this out-of-group case is the feature's main purpose.

**96.** Set the dropdown to **Only Group Members** and buff that ungrouped player again. **No whisper is sent.** Re-group with them, buff them, and the whisper returns. Failure is a stranger being whispered while the setting says group only.

**97.** Uncheck an ability on the **Good News** tracked list, then cast it on a teammate. **No whisper is sent** for that ability, while other checked abilities still whisper normally. Failure is an unchecked ability still announcing.

## Peer Pressure

Peer Pressure fires when **another player of your class** pops a cooldown. You need a second player of the same class, close enough that you see their casts.

**98.** Open **Peer Pressure**. On a fresh profile, **Enable Peer Pressure** is checked, **Enable Print Out Messages** is checked, **Trigger on Own Casts** is unchecked, and **Enable Sound Effects** is checked. Failure is any of those starting elsewhere.

**99.** Uncheck **Enable Peer Pressure**. Everything below it — the sample line, the Notifications section, and the tracked list — disappears. Re-check it and everything returns. Failure is content staying visible with the feature off.

**100.** Read the sample message sitting directly under **Enable Peer Pressure**. It renders as `TFTB // Expektor used [Blade Flurry]!` with the name and sentence in rogue yellow and the spell link in link blue. Failure is an uncoloured line or a broken link.

**101.** Have your same-class second player use a cooldown that is checked on the panel. A line prints naming them and the spell, in your class's colour, and the thunder sound plays. Compare it to the sample from step 100 — the real line has the same shape, colouring, and link style. Failure is nothing firing, or a real alert that looks nothing like the sample.

**102.** With **Trigger on Own Casts** unchecked, use one of your own listed cooldowns. **Nothing prints and no sound plays.** Now check the box, wait for the cooldown, and use it again — this time the line prints naming you, and the thunder sound plays. Failure is an alert firing while the box is unchecked, or no alert after checking it.

**103.** Have a player of a **different** class use one of their cooldowns nearby. **Nothing fires** — Peer Pressure only reacts to your own class. Failure is an alert for another class.

**104.** Have your same-class player use a cooldown **on someone else** — a paladin's **Hand of Protection**, a priest's **Fear Ward**. The line reads `TFTB // Name used [Hand of Protection] on Othername!`, with the target's name in that player's own class colour (see step 15). Failure is the target being dropped from the sentence, or a self-cast wrongly showing an "on X" clause.

**105.** Uncheck **Enable Print Out Messages** but leave the sound on. Have them use a cooldown — **you hear the sound but see no line**. Failure is a line printing anyway.

**106.** Uncheck both **Enable Print Out Messages** and **Enable Sound Effects**. Have them use a cooldown — **nothing at all happens**. Failure is any reaction with both off.

**107.** Uncheck a specific ability in the tracked list, then have them use it. **Nothing fires**, while their other checked cooldowns still fire. Failure is an unchecked cooldown still alerting.

**108.** Confirm the panel lists cooldowns for **every** class, not just your own, each under a class-coloured heading. This is intentional — the profile is shared account-wide so you can configure any class from any character. Failure is only your own class appearing.

## Thank You Button

**109.** Open **Thank You Button**. On a fresh profile, **Create Macro** is checked and the **Whisper Message** field reads `Thanks, you're the best! (=`. Failure is either starting elsewhere.

**110.** Hover the **Create Macro** toggle. The tooltip names the macro `- Thank` in gold. Failure is a tooltip showing a placeholder such as `%s` instead of the name.

**111.** Open your macro list (Game Menu → Macros). A macro named **- Thank** exists, with a hand icon, and its body is exactly `/thankyou`. Failure is no macro, an empty body, or a differently named one.

**112.** Drag the **- Thank** macro to an action bar, target a friendly player of your faction, and click it. It behaves exactly like step 41 — an emote at them plus the plain whisper. Failure is the button doing nothing.

**113.** Delete the **- Thank** macro and `/reload`. It is recreated automatically. Failure is the macro staying gone.

**114.** Uncheck **Create Macro**, delete the macro, and `/reload`. It is **not** recreated. Failure is the macro coming back with the setting off.

**115.** Edit the **Whisper Message** field to something of your own, then use `/thankyou` on a friendly target. They receive **your** text, verbatim, with no add-on branding. Failure is the default text still being sent, or your text arriving with a `TFTB //` prefix attached.

**116.** Paste a very long message into the **Whisper Message** field — several sentences, or the same sentence repeated until the box will take no more — and use `/thankyou` on a friendly target. Either the whisper **arrives in full** on their screen, or nothing is sent at all. Failure is the whisper arriving cut in half, or you seeing it in your own chat while it never reaches them: an over-length line is dropped silently by the server, so the only way to catch it is to have the recipient confirm.

**117.** Clear the **Whisper Message** field entirely and use `/thankyou` on a friendly target. The emote fires; **no whisper is sent** and no error appears. Failure is an empty whisper going out.

**118.** Click **Reset**. The field returns to `Thanks, you're the best! (=`. Failure is the field staying on your custom text or going blank.

**119.** In the **Select Emotes** block, uncheck everything except `/salute`. Use `/thankyou` on a friendly target several times — you salute every time. Failure is any other emote firing.

## Profiles

**120.** Open **Profiles**. It shows the standard profile controls: the current profile, a list of existing profiles, and options to create, copy, delete, and reset. Failure is a blank or broken panel.

**121.** Change a few distinctive settings, then create a **new** profile from the panel. The settings return to their defaults on the new profile. Switch back to the previous profile — your changes are still there. Failure is settings bleeding between profiles.

**122.** On the fresh profile, open **Buffs from Teammates**. The tracked list is fully populated with its default checkboxes — a new profile re-seeds its list rather than starting empty. Failure is an empty tracked list.

**123.** Use **Copy From** to copy your configured profile onto the current one. The settings and every tracked-ability checkbox come across. Failure is a partial copy, or the tracked lists emptying.

**124.** Use **Reset Profile**. Everything returns to the documented defaults, and the tracked lists refill. Failure is a reset leaving lists empty or settings half-changed.

## Diagnostic Tools

**125.** Open **Diagnostic Tools**. On a fresh install it shows only a warning paragraph and a single **Enable Diagnostic Tools** toggle, and that toggle is **off**. Failure is the tools being on by default, or their content showing before you enable them.

**126.** Check **Enable Diagnostic Tools**. Sections appear, each under its own ruled header with a blank line beneath it: Event Log, Event Registration, API Endpoints, Add-on Context, Other Add-ons, Saved Variables, Library Versions, Taint Log, External Tools. Failure is a missing section or a Lua error.

**127.** Click **Start Logging**, then let a few buffs land and have someone nearby open a portal or set out a feast. Click **Stop Logging**, then **Show Log**. The box fills with recent entries. Each nearby spell cast appears as **one decoded line beginning `CAST`**, carrying the spell id and name, who cast it, and `tracked=` / `watched=` values. You will **not** see raw combat-log lines — that firehose is deliberately kept out of the log and replaced by these decoded lines, so their absence is correct. Failure is an empty box after logging was clearly running, or a flood of raw combat-log traffic burying everything else.

**128.** Click **Run Event Checks**. The output lists six events — PLAYER_LOGIN, PLAYER_ENTERING_WORLD, COMBAT_LOG_EVENT_UNFILTERED, UNIT_SPELLCAST_SENT, UNIT_SPELLCAST_SUCCEEDED, LOADING_SCREEN_DISABLED — each marked `[PASS]`, and closes with "All events register on this client." Failure is any `[FAIL]` line, or a count of events that failed to register.

**129.** Click **Run API Checks**, **Show Context**, **List Add-ons**, **Dump Saved Variables**, and **List Libraries** in turn. Each fills its own output box with readable text. Failure is any button producing an empty box or an error.

**130.** In the **Add-on Context** output, find the **Strangers** line. It lists `sound`, `praiseDelay`, `praiseCooldown`, `minDuration`, and `cooldown` alongside the print/whisper/emote settings; the **Teammates** and **Services** lines each list `sound` and `praiseDelay`; and the **Peer Pressure** line lists `enabled`, `print`, `ownCasts`, and `sound`. The values match what the panels currently show. Failure is any of those fields missing — the report is what a bug reporter pastes back, so a missing setting makes a "nothing happened" ticket unanswerable.

**131.** In that same output, find the counts of tracked triggers and watched buffs. They are non-zero. Failure is zeroes, which would mean the add-on found none of its abilities on this client.

**132.** Select the text in any output box. It highlights and can be copied — these reports exist to be pasted into a bug report. Failure is text that can't be selected.

**133.** Uncheck **Enable Diagnostic Tools**. Every section disappears and logging stops. Failure is sections lingering, or the log continuing to grow.

**134.** `/reload` with diagnostics left **on**. It comes back **off**, with all reports cleared — diagnostics are runtime-only and never saved. Failure is the setting or any report surviving the reload.

## Combat behavior

**135.** Turn on **Enable Emotes** for **Buffs from Teammates**. Get into combat with a target dummy or a mob, and have your teammate buff you with a tracked cooldown while you are fighting. The chat line prints, the sound plays, and the **whisper still goes out**, but **no emote is performed**. Failure is emoting mid-fight, or whispers being swallowed.

**136.** Leave combat, then have them buff you again. The emote fires normally on this next buff. Failure is emotes staying suppressed after combat ends. (An emote skipped during combat is skipped for good — it is not replayed later. That is correct behaviour, not a bug.)

**137.** Immediately after a loading screen — a zone change, a portal, a dungeon entrance — have someone buff you within the first two or three seconds. Reactions are deliberately paused for a moment while the world settles, then resume normally. Failure is reactions never coming back after the pause, or a Lua error during the loading screen.

**138.** Ungrouped and in combat, with **Buffs from Strangers** set to print, whisper, sound, and emote, have a stranger buff you. The line prints, the sound plays, and the whisper goes out; only the **emote** is held back until you are out of combat. Failure is the print or whisper being suppressed by combat.

## Flavor differences to watch

These are the places Classic Era and TBC Anniversary genuinely differ. Do not let a clean Era run stand in for either of them.

- **The options panel dock (step 3).** This is the big one. The panel docks correctly on Classic Era but has historically floated free on TBC Anniversary. The Anniversary run of step 3 is the single most important step in this plan — if the panel floats or fails to open there, the release is not shippable, because `/tftb` and the Options window are the *only* ways into the settings. There is no minimap button to fall back on.
- **The combat refusal (steps 4–6).** The refusal has to read the same on both clients. Anniversary is where a missed gate shows up as a red `ADDON_ACTION_BLOCKED` error instead of the polite line, so run those three steps there even if Era passed cleanly.
- **The praise-delay dropdown reads from your client (step 60).** The "2 seconds" wording comes from the game's own duration text, not from the add-on. Confirm it reads naturally on both flavors, and on a non-English client if you run the localization pass.
- **The tracked lists are shorter on Classic Era.** Buffs from Teammates and Group Services list only what exists on the running client. TBC Anniversary should show strictly more — Drums, Ritual of Souls, Ritual of Refreshment, Fisherman's Feast. Failure is an entry appearing on Era for content that does not exist there, or an entry stuck at `Spell #12345` / `Item #12345` on either flavor.
- **Peer Pressure's mage rows differ by design.** Classic Era lists **Cold Snap** and **Ice Block**. TBC Anniversary lists **Cold Snap**, **Icy Veins**, and **Ice Block**. Blizzard reuses the same spell ids for different abilities across the two clients, so check that no ability is listed **twice** and none is listed under the **wrong name** on either flavor.
- **Peer Pressure's warrior Death Wish** appears exactly once on each flavor. Two entries, or none, is a failure.
- **Class availability.** Death Knight abilities appear on neither of these clients. Seeing a Death Knight group on the Buffs from Teammates or Peer Pressure panel is a failure on both flavors. The same goes for any Wrath-only cooldown — a rogue's **Tricks of the Trade** belongs on neither client's Peer Pressure list.

## Localization spot-check

Optional, and only worth running if you can start a non-English client. Four strings changed or arrived this release — the combat refusal, the `/Commands` header, and the `/tftb` command's description — so this pass has more value than usual.

**Run steps 1, 4, 7, 31, 33, 46, 60, 67, 87, and 100 again on a non-English client**, and check the following:

- **No raw keys.** Every label, description, and chat line is real translated text. Anything showing as `CHAT_OPTIONS_IN_COMBAT`, `OPTIONS_COMMANDS_HEADER`, `OPTIONS_COMMAND_DESCRIPTION`, `PRAISE_HEADER`, or similar is an untranslated or misnamed key. Those first three are the newest strings, so check them first. The `/tftb` literal itself is deliberately identical in every language — only the sentence beside it translates.
- **Placeholders resolve.** Chat lines name a real player and link a real spell or item. A literal `%s`, a `%d`, or the word `nil` appearing in a sentence is a failure, as is a name or spell appearing twice in one line.
- **Durations read naturally.** Good News durations and the praise-delay dropdown both use the client's own words for minutes and seconds. Stray characters such as `|4` in a whisper mean the message will be rejected by chat entirely — check the whisper actually **arrives** on the recipient's screen, not just that it looks right on yours.
- **Portuguese word order is intentional.** In ptBR, the "used their X on you" line puts the item before the pronoun. That is a deliberate reordering to match Portuguese grammar and is not a bug.
- **Russian is the width canary.** ruRU produces the longest byte-for-byte lines, and the chat ceiling is measured in bytes. Confirm the Good News and thank-you whispers still arrive intact there with their spell links rendered — a line over the limit is dropped silently, so a *missing* whisper is what failure looks like, not a truncated one.
- **Custom whisper text.** The Thank You Button whisper field is yours to fill; if you type a very long message in a non-Latin locale it can exceed the chat limit and be dropped. Confirm a long custom message either arrives or is visibly rejected — never silently lost.

## Sign-off

When every step above passes on **both** Classic Era and TBC Anniversary, manual testing is complete and the add-on is ready for `4 - Pre-Launch Review Prompt.md`.

A pass on one flavor is not a pass. Fill in both rows.

| Flavor | Tester | Date | Result | Notes / failed steps |
| --- | --- | --- | --- | --- |
| Classic Era | | | ☐ Pass ☐ Fail | |
| TBC Anniversary | | | ☐ Pass ☐ Fail | |
