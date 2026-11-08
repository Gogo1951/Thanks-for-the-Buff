local _, ns = ...

if ns.IS_DISCOVERY then
	return
end

--[[
    [emote token] = group. An emote this client offers that is not listed is a
    Text emote: it prints its line and does nothing else.
]]
ns.EMOTE_GROUP_BY_TOKEN = {
	-- Voice
	ATTACKMYTARGET = "Voice",
	BORED = "Voice",
	BYE = "Voice",
	CHARGE = "Voice",
	CHEER = "Voice",
	CONGRATULATE = "Voice",
	FLEE = "Voice",
	FLIRT = "Voice",
	FOLLOW = "Voice",
	HEALME = "Voice",
	HELLO = "Voice",
	HELPME = "Voice",
	INCOMING = "Voice",
	JOKE = "Voice",
	MOO = "Voice",
	NO = "Voice",
	NOD = "Voice",
	OOM = "Voice",
	OPENFIRE = "Voice",
	RASP = "Voice",
	SIGH = "Voice",
	THANK = "Voice",
	TRAIN = "Voice",
	WAIT = "Voice",
	WELCOME = "Voice",
	WHISTLE = "Voice",
	YAWN = "Voice",
	-- Gesture
	ANGRY = "Gesture",
	APPLAUD = "Gesture",
	BASHFUL = "Gesture",
	BEG = "Gesture",
	BLAME = "Gesture",
	BLUSH = "Gesture",
	BOGGLE = "Gesture",
	BOOP = "Gesture",
	BOW = "Gesture",
	CACKLE = "Gesture",
	CHICKEN = "Gesture",
	CHUCKLE = "Gesture",
	CLAP = "Gesture",
	COMMEND = "Gesture",
	CONFUSED = "Gesture",
	CRY = "Gesture",
	CURIOUS = "Gesture",
	CURTSEY = "Gesture",
	DISAGREE = "Gesture",
	DOUBT = "Gesture",
	DRINK = "Gesture",
	EAT = "Gesture",
	FAIL = "Gesture",
	FLEX = "Gesture",
	GASP = "Gesture",
	GIGGLE = "Gesture",
	GLOAT = "Gesture",
	GOLFCLAP = "Gesture",
	GREET = "Gesture",
	GROVEL = "Gesture",
	GROWL = "Gesture",
	GUFFAW = "Gesture",
	HAIL = "Gesture",
	INSULT = "Gesture",
	KISS = "Gesture",
	LAUGH = "Gesture",
	LOST = "Gesture",
	MERCY = "Gesture",
	MOURN = "Gesture",
	OBJECT = "Gesture",
	OOPS = "Gesture",
	PLEAD = "Gesture",
	POINT = "Gesture",
	PONDER = "Gesture",
	PRAY = "Gesture",
	PUZZLE = "Gesture",
	ROAR = "Gesture",
	ROFL = "Gesture",
	RUDE = "Gesture",
	SALUTE = "Gesture",
	SHOUT = "Gesture",
	SHRUG = "Gesture",
	SHY = "Gesture",
	SING = "Gesture",
	SURRENDER = "Gesture",
	TALK = "Gesture",
	TALKEX = "Gesture",
	TALKQ = "Gesture",
	TAUNT = "Gesture",
	TOAST = "Gesture",
	VICTORY = "Gesture",
	VIOLIN = "Gesture",
	WAVE = "Gesture",
	WHOA = "Gesture",
	YW = "Gesture",
	-- Pose
	DANCE = "Pose",
	KNEEL = "Pose",
	LAYDOWN = "Pose",
	SIT = "Pose",
	SLEEP = "Pose",
	STAND = "Pose",
}

--[[
How We Got the Data

Last Validated
	2026-11-08, Classic Era 1.15.9.70576

Source
	wago.tools DB2 exports for build 1.15.9.70576: EmotesText, Emotes and EmotesTextSound.

Notes
	- Each EmotesText row (the token) links to an Emotes row (its animation).
	- Pose: the animation loops until you move (Emotes.EmoteSpecProc 1 or 2).
	- Voice: the token has EmotesTextSound rows, or its animation carries an EventSoundID.
	- Gesture: a one-shot animation (Emotes.AnimID above 0) with no sound.
	- Text: everything else. Checked first to last in that order, so no token sits in two groups.
	- Counts: Text 157, Voice 27, Gesture 65, Pose 6.
	- Which emotes exist still comes from the running client (ns.GetEmoteCatalog); this file only sorts them.
]]
