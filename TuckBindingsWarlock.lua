TuckBindings.WARLOCK = {}
local TB = TuckBindings

function TuckBindings.WARLOCK:Init()

-- Shortcuts for target configurations
local targets_selfcast = {[""] = "target", ["SHIFT-"]="player"}
local targets_focus =    {[""] = "target", ["SHIFT-"]="focus"}
local targets_tank = 	{[""] = {"target", "targettarget"}, ["SHIFT-"]={"focus", "focustarget"}}


TB:Cast("1", 			"Hand of Gul'dan", 	"harm", targets_focus)
TB:Cast("2",			"Incinerate", 		"harm", targets_focus)
TB:Cast("ALT-2",			"Sould Fire", 		"harm", targets_focus)
TB:Cast("3",			"Shadow Bolt", 		"harm", targets_focus)
TB:Cast("4",			"Immolate", 		"harm", targets_focus)
TB:Cast("ALT-4",			"Fel Flame", 		"harm", targets_focus)
TB:Cast("5", 			"Searing Pain", 		"harm", targets_focus)
TB:Cast("6",			"Hellfire", 			"harm", targets_focus)
TB:Cast("7",			"Rain of Fire", 		"harm", targets_focus)

TB:Cast("C",			"Corruption", 		"harm", targets_focus)
TB:Cast("ALT-C",			"Seed of Corruption", 	"harm", targets_focus)
TB:Cast("F",			"Bane of Agony", 		"harm", targets_focus)
TB:Cast("ALT-F",			"Bane of Doom", 		"harm", targets_focus)
TB:Cast("V",			"Curse of the Elements","harm", targets_focus)
TB:Cast("ALT-V",			"Curse of Tonges",	"harm", targets_focus)
TB:Cast("R",			"Fear",			"harm", targets_focus)
TB:Cast("ALT-R",			"Death Coil",		"harm", targets_focus)
TB:Cast("Q",			"Banish",			"harm", targets_focus)
TB:Cast("X",			"Life Tap")

TB:Macro("T", 			"/petattack")
TB:Macro("SHIFT-T", 		"/petattack [@focus]")
TB:Cast("E",			"Axe Toss",			"harm", targets_focus)
TB:Cast("ALT-E",			"Pursuit",			"harm", targets_focus)
TB:Cast("ALT-T",			"Felstorm")

end