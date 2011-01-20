TuckBindings.HUNTER = {}

function TuckBindings.HUNTER:Init()

-- attack spells

TuckBindings:CreateSpellButton("R",		"Hunter's Mark")
TuckBindings:CreateSpellButton("SHIFT-R",	"Multi-Shot")

TuckBindings:CreateMacroButton("F",		"/attack")
TuckBindings:CreateSpellButton("SHIFT-F",	"Arcane Shot")
TuckBindings:CreateSpellButton("CTRL-F",	"Concussive Shot")

TuckBindings:CreateSpellButton("C",		"Serpent Sting")
TuckBindings:CreateSpellButton("SHIFT-C",	"Viper Sting")
TuckBindings:CreateSpellButton("CTRL-C",	"Scorpid Sting")

TuckBindings:CreateSpellButton("X",		"Volley")
TuckBindings:CreateSpellButton("SHIFT-X",	"Rapid Fire")

TuckBindings:CreateSpellButton("Z",		"Flare")

-- traps

TuckBindings:CreateSpellButton("E",		"Frost Trap")
TuckBindings:CreateSpellButton("SHIFT-E",	"Freezing Trap")

TuckBindings:CreateSpellButton("T",		"Immolation Trap")
TuckBindings:CreateSpellButton("SHIFT-T",	"Explosive Trap")

-- melee

TuckBindings:CreateSpellButton("Q",		"Wing Clip")
TuckBindings:CreateSpellButton("SHIFT-Q",	"Raptor Strike")

TuckBindings:CreateSpellButton("V",		"Mongoose Bite")
TuckBindings:CreateSpellButton("SHIFT-V",	"Scare Beast")

-- defense

TuckBindings:CreateSpellButton("G",		"Feign Death")
TuckBindings:CreateSpellButton("SHIFT-G",	"Disengage")


-- pet spells

TuckBindings:CreateMacroButton("1",		"/petattack")
TuckBindings:CreateMacroButton("2",		"/petfollow")
TuckBindings:CreateMacroButton("3",		"/petstay")

TuckBindings:CreateMacroButton("SHIFT-1",	"/petaggressive")
TuckBindings:CreateMacroButton("SHIFT-2",	"/petdefensive")
TuckBindings:CreateMacroButton("SHIFT-3",	"/petpassive")

TuckBindings:CreateSpellButton("4",		"Intimidation")
TuckBindings:CreateSpellButton("SHIFT-4",	"Bestial Wrath")

-- changing aspects


TuckBindings:CreateSpellButton("CTRL-1",	"Shadowmeld")
TuckBindings:CreateSpellButton("CTRL-2",	"Aspect of the Hawk")
TuckBindings:CreateSpellButton("CTRL-3",	"Aspect of the Monkey")
TuckBindings:CreateSpellButton("CTRL-4",	"Aspect of the Pack")
TuckBindings:CreateSpellButton("CTRL-5",	"Aspect of the Wild")
TuckBindings:CreateSpellButton("CTRL-6",	"Aspect of the Beast")
TuckBindings:CreateSpellButton("CTRL-7",	"Aspect of the Cheetah")

end
