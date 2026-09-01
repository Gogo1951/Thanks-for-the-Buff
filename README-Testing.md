# Thanks for the Buff (TFTB) // Manual Test Plan

This is the manual test plan for Thanks for the Buff (TFTB), the steps to confirm it works before a release is tagged. For what it does, see [README.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README.md); for how it works, see [README-Technical.md](https://github.com/Gogo1951/Thanks-for-the-Buff/blob/main/README-Technical.md).

## Before you start

**Run the whole list on Classic Era, then `/reload` and run it again on TBC Anniversary.** Steps are numbered continuously so you can report "failed on step N."

What you need on hand:

- **A second character of your own class**, on a second account or a patient friend. The worked examples use two **priests**: Power Infusion lasts 15 seconds, which is short enough to show a duration clause, and it is a Peer Pressure cooldown on both flavors. Any same-class pair works if you swap in one of your own tracked cooldowns and one buff of yours that runs a minute or longer.
- **A mage or a warlock**, yours or a friend's, for two steps: opening a portal or dropping a soulwell (step 21), and casting a long buff such as Amplify Magic or a Soulstone (step 11).
- **Goblin Jumper Cables in your bags**, plus a partner willing to die once, for step 14. This is the heaviest fixture in the plan. Skip only this step if you cannot field it, and say so in your report.
- **A capital city**, so a player outside your group can buff you in passing.
- **A target dummy or any low-level mob**, for the in-combat steps.
- **Out of combat** unless a step says otherwise.
- **A non-English client**, only for the optional last step.

This plan deliberately skips the full per-class tracked-ability matrix, the Profiles panel, the praise cooldown and delay timing, the sound toggles, and the Good News scope dropdown. It covers the paths this release changed and the ones that break quietly.

## Verify this release's changes

**Saved settings**

**1.** Log in for the first time on this build, on a character whose TFTB settings you had already customised. A line beginning `TFTB //` prints your version and points you at **Options > AddOns > Thanks for the Buff (TFTB)**, and every setting is back at its shipped default: the Thank You Button whisper reads "Thanks, you're the best! (=", Stranger Buffs shows a **21 Seconds** minimum buff duration, and your old watched-ability ticks are gone. That one-time reset is expected this release and belongs in the release notes. Failure is a red Lua error on login, or the settings resetting **again** on a second login.

**2.** Open **Thank You Button** and set Button 1's Whisper Message to `test one`. Type `/reload`. The box still reads `test one` afterwards. Failure is the message back at the default, which means nothing is being saved at all.

**Panel list**

**3.** Type `/tftb` and read the category list on the left. Under **Thanks for the Buff (TFTB)** the children read, top to bottom: **Stranger Buffs**, **Teammate Buffs**, **Send Good News**, **Service Alerts**, **Peer Pressure**, **Thank You Button**, **Profiles**, **Diagnostic Tools**. Failure is any old name still showing (Buffs from Strangers, Buffs from Teammates, Group Services, or a bare "Good News"), or Service Alerts sitting above Send Good News.

**Master switches**

**4.** Open **Stranger Buffs**. Directly under the description sits a full-width **Enable Thanks for Stranger Buffs** checkbox, ticked. Untick it: everything below vanishes, leaving only the description and the checkbox. Tick it again and the whole panel returns. Do the same on **Teammate Buffs** (Enable Thanks for Teammate Buffs) and **Service Alerts** (Enable Service Alerts). Failure is a header, a stray gold label, or an emote grid left stranded on a switched-off panel.

**5.** Leave **Teammate Buffs** switched **off** and close the Options Interface. Group with your partner and have them cast Power Infusion on you. Nothing happens at all: no chat line, no whisper, no emote. Switch it back on and have them cast again: `TFTB // <Partner> gave you [Power Infusion]!` prints to your chat and they receive a whisper. Failure is the buff still being announced while the switch is off.

**Seconds dropdowns**

**6.** On **Stranger Buffs**, look at **Praise Cooldown**, **Same-Player Praise Cooldown** and **Minimum Buff Duration**. Each is a dropdown sitting to the right of its gold label, not a slider, and each has a silver line of help text underneath it rather than behind a hover. Open one: it offers exactly twelve choices, 0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89 and 144 Seconds, in that order, every one labelled in seconds. The three ship set to **0 Seconds**, **3 Seconds** and **21 Seconds**. Leave them as they are. Failure is a slider, an empty box, a choice reading "1 Minute" or "2 Minutes", or help text you can only reach by hovering.

**Thank You Buttons**

**7.** Open **Thank You Button**. There are five sections, headed **TFTB Button 1** through **TFTB Button 5**. Button 1 shows **Enable Macro "- Thank"** ticked, a Whisper Message reading "Thanks, you're the best! (=", a Reset button, and a grid of twelve emote checkboxes all ticked. Buttons 2 through 5 each show a single unticked checkbox, **Enable Macro "- TFTB 2"** and so on, and nothing else. Failure is one long undivided section, or buttons 2 to 5 arriving with their settings already filled in.

**8.** Tick **Enable Macro "- TFTB 2"**. The section expands to a Whisper Message row, a Reset button, and an **Emote** dropdown reading **None**, which is a dropdown rather than a grid of checkboxes. Type `/macro`: a macro named `- TFTB 2` now sits next to `- Thank`. Untick the box and look again: `- TFTB 2` is gone. Failure is the macro only appearing after a `/reload`, or surviving the untick.

**9.** Tick **Enable Macro "- TFTB 2"** again, set its Whisper Message to `Ping!` and its Emote to `/cheer`. Target your partner and type `/thankyou2`. You cheer at them and they receive a whisper reading exactly `Ping!`. Now type `/thankyou`: you perform one of Button 1's twelve emotes at them and they receive "Thanks, you're the best! (=". Failure is either command doing the other's job, or `/thankyou2` doing nothing at all.

**Good News message**

**10.** Open **Send Good News**. Under a **Good News Messages** header there is a **Whisper Message** box reading `You have %a!`, a **Reset** button beside it, and a silver line reading "Maximum length: 120. %a becomes the ability link." Below that sits a live sample: a Star icon, then `TFTB // You have [Power Infusion] for 15 Seconds!`. Change the box to `Heads up, %a incoming!` and click away: the sample rewrites itself to match. Press **Reset**: box and sample both go back. Failure is a sample that ignores your edit, or a box you can leave empty.

**11.** With the message back at its default, cast **Power Infusion** on your partner. They receive one whisper: `TFTB // You have [Power Infusion] for 15 Seconds!`, opening with a Star icon and carrying a clickable spell link. Now log your mage or warlock and cast Amplify Magic or a Soulstone on them: that whisper reads `TFTB // You have [Amplify Magic]!` with **no** duration clause at all. Failure is a duration on the long buff ("for 10 Minutes"), or a missing duration on Power Infusion.

**Emotes**

**12.** On **Teammate Buffs**, tick **Enable Emotes**, then in **Select Emotes** untick everything except `/yes`. Group with your partner and have them cast Power Infusion on you. You **nod at your partner by name**, and the emote text on your screen names them. Failure is nothing happening at all, or an emote aimed at nobody: a bare "You nod." with no name, or "You thank everyone around you."

**Peer Pressure now watches your group only**

**13.** Still grouped with your same-class partner, have them cast Power Infusion on you. Alongside the teammate thank-you from step 5, a Peer Pressure line prints in your class colour, `TFTB // <Partner> used [Power Infusion] on <You>!`, and the Thunder sound plays. Now have them **leave the group** and cast it on you again while standing beside you. Neither the Peer Pressure line nor the Thunder sound appears. Failure is the Peer Pressure line or its sound still firing for a player outside your group.

**Jumper cables**

**14.** With Goblin Jumper Cables in your bags and Good News switched on, use them on your dead partner. If they get up, they receive exactly one `TFTB //` whisper naming the cables. If the jolt fails and they stay down, they receive **nothing**. Failure is a whisper after a jolt that did not revive them, or two whispers after one that did.

When steps 1 to 14 pass on both flavors, this release's changes are verified. Proceed to `4 - Pre-Launch Review Prompt.md`.

## Core checks

**15.** Log in and watch your chat and your screen for ten seconds, then type `/reload` and watch again. The `TFTB //` welcome line prints both times and no red Lua error appears. A development copy reporting its version as `Dev` rather than a date is correct, not a failure.

**16.** Type `/tftb`. The settings appear **docked inside the Blizzard Options window**, with **Thanks for the Buff (TFTB)** selected in the category list on the left. Close it, open the Blizzard Options window yourself, and click **Thanks for the Buff (TFTB)** in that list: the same panel appears. Failure looks like either nothing happening at all, or a standalone TFTB window floating free of the Options frame. **TBC Anniversary is the flavor that historically breaks this**, so a tester who ran only Classic Era has not finished this step.

**17.** Attack a target dummy or a mob so you are **in combat**, then type `/tftb`. One line prints, word for word: `TFTB // As a safety precaution, the Options Interface cannot be opened during combat.` The panel does not open. Ask twice more: the same line prints every single time. Now leave combat. The panel does not spring open by itself, and `/tftb` then opens it normally. Failure is the panel opening anyway, silence on a repeat attempt, or a red `ADDON_ACTION_BLOCKED` error naming Thanks for the Buff.

**18.** With nothing targeted, type `/thankyou`: `TFTB // Select a player to thank.` prints. Target a creature and type it again: the same line prints. Target yourself and type it again: `TFTB // You can't thank yourself!` prints. Failure is silence, an emote at a mob, or a whisper sent to yourself.

**19.** Have your partner **leave your group** and buff you with something lasting at least 21 seconds, such as Power Word: Fortitude. Standing in a capital city and waiting for a passer-by works too. You perform an emote at them and **nothing prints to your chat**: out of the box, a stranger's buff earns an emote and nothing else. Failure is a chat line or a whisper you never switched on, or no reaction at all to a long buff from outside your group.

**20.** Group up again and have your partner cast Power Infusion on you. `TFTB // <Partner> gave you [Power Infusion]!` prints to your chat with the spell name as a clickable blue link, and they receive a whisper reading `TFTB // Thanks for the [Power Infusion]!`, opening with a Star icon. Failure is a missing link, a raw spell number where the name belongs, or no whisper reaching them.

**21.** Have your mage or warlock friend open a portal or drop a soulwell while grouped with you. One `TFTB //` line prints, naming them and what they opened or set out. Failure is silence, or the same line printing several times for one portal.

**22.** Read the messages from steps 20 and 21 back. Each is one complete sentence opening with `TFTB //`, and every spell or item name inside it is a clickable link rather than plain text or a bare number. Then, on **Send Good News**, paste something well over 120 characters into the Whisper Message box and click away: the text is cut short, and what remains ends on a whole readable character. Failure is a sentence that reads as though a word is missing, a link rendered as raw text, or a garbled box-shaped character at the cut.

**23.** Open **Diagnostic Tools**. The panel shows a warning and one unticked **Enable Diagnostic Tools** toggle and nothing else: the gate ships off at every login, whatever you left it on last session. Tick it, then press **Run Event Checks** and **Run API Checks**. Every line reads `[PASS]`; if any reads `[FAIL]`, report which endpoint and on which flavor. Press **Extract Emotes**: a tab-separated list of this client's emotes appears, and its length differs between Classic Era and TBC Anniversary, which is correct. Failure is an empty report, or the Enable toggle remembering that it was on.

**24.** *(Optional, non-English client.)* Log in on a non-English client and repeat steps 16, 20 and 23. Every label and message reads in that language with no raw keys showing through (nothing like `TAB_STRANGERS` or `MESSAGE_GAVE_YOU`), and the numbers land sensibly: the seconds dropdown uses that language's word for seconds, and the Good News duration clause names a real unit rather than a stray `%s`. Failure is an untranslated key, a doubled or missing number, or a message cut off mid-word.

When every step passes on both Classic Era and TBC Anniversary, manual testing is complete. Proceed to `4 - Pre-Launch Review Prompt.md`.
