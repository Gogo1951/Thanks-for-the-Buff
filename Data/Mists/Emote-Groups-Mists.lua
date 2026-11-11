local _, ns = ...

-- [emote token] = group
ns.EMOTE_GROUP_BY_TOKEN = {
	-- Voice
	ATTACKMYTARGET = "Voice",
	BEG = "Voice",
	BORED = "Voice",
	BYE = "Voice",
	CACKLE = "Voice",
	CHARGE = "Voice",
	CHEER = "Voice",
	CHICKEN = "Voice",
	CHUCKLE = "Voice",
	CONGRATULATE = "Voice",
	CRY = "Voice",
	DRINK = "Voice",
	EAT = "Voice",
	FLEE = "Voice",
	FLIRT = "Voice",
	FOLLOW = "Voice",
	GIGGLE = "Voice",
	GLOAT = "Voice",
	GUFFAW = "Voice",
	HEALME = "Voice",
	HELLO = "Voice",
	HELPME = "Voice",
	INCOMING = "Voice",
	JOKE = "Voice",
	KISS = "Voice",
	LAUGH = "Voice",
	MOO = "Voice",
	MOURN = "Voice",
	NO = "Voice",
	NOD = "Voice",
	OOM = "Voice",
	OPENFIRE = "Voice",
	RASP = "Voice",
	ROAR = "Voice",
	ROFL = "Voice",
	SIGH = "Voice",
	TAUNT = "Voice",
	THANK = "Voice",
	TRAIN = "Voice",
	VIOLIN = "Voice",
	WAIT = "Voice",
	WELCOME = "Voice",
	WHISTLE = "Voice",
	YAWN = "Voice",
	YW = "Voice",
	-- Gesture
	ANGRY = "Gesture",
	APPLAUD = "Gesture",
	BASHFUL = "Gesture",
	BLAME = "Gesture",
	BLUSH = "Gesture",
	BOGGLE = "Gesture",
	BOOP = "Gesture",
	BOW = "Gesture",
	CLAP = "Gesture",
	COMMEND = "Gesture",
	CONFUSED = "Gesture",
	CURIOUS = "Gesture",
	CURTSEY = "Gesture",
	DISAGREE = "Gesture",
	DOUBT = "Gesture",
	FAIL = "Gesture",
	FLEX = "Gesture",
	GASP = "Gesture",
	GOLFCLAP = "Gesture",
	GREET = "Gesture",
	GROVEL = "Gesture",
	GROWL = "Gesture",
	HAIL = "Gesture",
	INSULT = "Gesture",
	LOST = "Gesture",
	MERCY = "Gesture",
	MOUNTSPECIAL = "Gesture",
	OBJECT = "Gesture",
	OOPS = "Gesture",
	PLEAD = "Gesture",
	POINT = "Gesture",
	PONDER = "Gesture",
	PRAY = "Gesture",
	PUZZLE = "Gesture",
	RUDE = "Gesture",
	SALUTE = "Gesture",
	SCARED = "Gesture",
	SHOUT = "Gesture",
	SHRUG = "Gesture",
	SHY = "Gesture",
	SING = "Gesture",
	SNIFF = "Gesture",
	SURRENDER = "Gesture",
	TALK = "Gesture",
	TALKEX = "Gesture",
	TALKQ = "Gesture",
	TOAST = "Gesture",
	VICTORY = "Gesture",
	WAVE = "Gesture",
	WHOA = "Gesture",
	-- Pose
	COWER = "Pose",
	DANCE = "Pose",
	KNEEL = "Pose",
	LAYDOWN = "Pose",
	READ = "Pose",
	SIT = "Pose",
	SLEEP = "Pose",
	STAND = "Pose",
}

--[[
How We Got the Data

Last Validated
	2026-11-08, Mists of Pandaria Classic 5.5.4.70631

Notes
	- Sorts every emote that does more than print a line into the group the Give Thanks emote grid shows it under (ns.GetEmoteGroup in Features/Utilities.lua). An emote this client offers that isn't listed is a Text emote: it prints its line and does nothing else.
	- Each EmotesText row (the token) links to an Emotes row (its animation).
	- Pose: the animation loops until you move (Emotes.EmoteSpecProc 1 or 2).
	- Voice: the token has EmotesTextSound rows, or its animation carries an EventSoundID.
	- Gesture: a one-shot animation (Emotes.AnimID above 0) with no sound.
	- Text: everything else. Checked first to last in that order, so no token sits in two groups.
	- Counts: Text 154, Voice 45, Gesture 50, Pose 8.
	- Which emotes exist still comes from the running client (ns.GetEmoteCatalog); this file only sorts them.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/EmotesText?build=5.5.4.70631
	https://wago.tools/db2/Emotes?build=5.5.4.70631
	https://wago.tools/db2/EmotesTextSound?build=5.5.4.70631

QuestieDB
	None.
]]
