TuckBindings.PRIEST = {}
local TB = TuckBindings

function TuckBindings.PRIEST:Init()

-- Shortcuts for target configurations
local targets_selfcast = {[""] = "target", ["SHIFT-"]="player"}
local targets_focus =    {[""] = "target", ["SHIFT-"]="focus"}
local targets_tank = 	{[""] = {"target", "targettarget"}, ["SHIFT-"]={"focus", "focustarget"}}

-- attack
TB:Macro("ALT-7",		"/cast !Shoot")

-- talent dependent spells
if TB:HasSpell("Mind Flay") then
	TB:Cast("G",   		"Silence",			"harm", targets_focus)
	TB:Cast("ALT-G",   	"Psychic Horror",		"harm", targets_focus)
	TB:Cast("T",		"Mind Flay",			"harm", targets_focus)
	TB:Cast("ALT-T",		"Vampiric Touch", 	"harm", targets_focus)
	TB:Cast("BUTTON3",	"Dispersion")
elseif TB:HasSpell("Penance") then
	TB:Cast("G",   		"Pain Suppression",	"help", targets_selfcast)
	TB:Cast("T",		"Power Infusion", 		"help", targets_selfcast)
	
end

if TB:HasSpell("Desperate Prayer") then
	TB:Cast("BUTTON3",	"Desperate Prayer")	
end

-- crowd controlS
TB:Cast("Q",   			"Mind Control", 		"harm", targets_focus)
TB:Cast("ALT-Q",   		"Shackle Undead",	"harm", targets_focus)
TB:Cast("E",    			"Psychic Scream")

-- mana efficiency
TB:Cast("X",			"Inner Focus")
TB:Macro("ALT-X",		"/cast Shadowfiend\n/petaggressive")
TB:Cast("CTRL-X",		"Mana Burn",		"harm", targets_focus)

-- dispel
TB:Cast("R", 			"Power Word: Shield", 	"help", targets_selfcast)
TB:Cast("ALT-R", 		"!Power Word: Barrier")
TB:Cast("F", 			"Dispel Magic", 		nil, targets_selfcast)
TB:Cast("ALT-F", 		"!Mass Dispel")
TB:Cast("CTRL-F", 		"Cure Disease", 		"help", targets_selfcast)

-- defense stuff
TB:Cast("ALT-SHIFT-E",  	"Holy Nova")
TB:Cast("ALT-E",    		"Stoneform")
TB:Cast("SHIFT-E",    		"Fade")

TB:Cast("BUTTON3",   		"Desperate Prayer")
TB:Macro("ALT-BUTTON3",   	"/use 13")
TB:Macro("SHIFT-BUTTON3", "/use 14")

-- healing
TB:Cast("C",			"Renew",			"help", targets_selfcast)
TB:Cast("V", 			"Prayer of Mending", 	"help", targets_selfcast)
TB:Cast("1",			"Penance", 			"help", targets_selfcast)
TB:Cast("2",			"Flash Heal", 		"help", targets_selfcast)
TB:Cast("ALT-2",			"Binding Heal")
TB:Cast("3",			"Prayer of Healing")
TB:Cast("ALT-3", 		"Divine Hymn")
TB:Cast("4",			"Greater Heal", 		"help", targets_selfcast)
TB:Cast("ALT-4",			"Heal", 			"help", targets_selfcast)

-- damage
TB:Cast("ALT-C",			"Shadow Word: Pain",	"harm", targets_tank)
TB:Cast("ALT-V",			"Devouring Plague",	"harm", targets_tank)
TB:Cast("5",       			"Mind Blast",		"harm", targets_focus)
TB:Cast("ALT-5", 		"Shadow Word: Death",	"harm", targets_focus)
TB:Cast("Y",       		"Mind Spike", 		"harm", targets_focus)
TB:Cast("6",       			"Smite",			"harm", targets_tank)
TB:Cast("ALT-6",  		"Holy Fire",			"harm", targets_tank)
TB:Cast("7",       			"Mana Burn",		"harm", targets_focus)

TB:Cast("0",        		"Cure Disease")

-- buffs
TB:Cast("8",			"Fear Ward", 		"help", targets_selfcast)
TB:Cast("ALT-8",			"Inner Fire")
TB:Cast("9",        		"Resurrection")
TB:Cast("^",		   	"Shadow Protection")
TB:Cast("'",		   		"Power Word: Fortitude")

end