TuckBindings.DRUID = {}
local TB = TuckBindings

function TuckBindings.DRUID:Init()


-- Shortcuts for target configurations
local targets_selfcast = {[""] = "target", ["SHIFT-"]="player"}
local targets_focus =    {[""] = "target", ["SHIFT-"]="focus"}

-- Forms
--TB:Cast("CTRL-1", "Bear Form")
--TB:Cast("CTRL-2", "Cat Form")
--TB:Cast("CTRL-3", "Travel Form")

TB:Cast("BUTTON3",	"Barkskin")	


TB:Macro("BUTTON5", 		"/script SetRaidTarget(\"target\", 8)") -- skull
TB:Macro("SHIFT-BUTTON5", 	"/script SetRaidTarget(\"target\", 7)") -- cross
TB:Macro("ALT-BUTTON5", 	"/script SetRaidTarget(\"target\", 5)") -- moon
TB:Macro("CTRL-BUTTON5", 	"/script SetRaidTarget(\"target\", 1)") -- star

-- Buffs
TB:Cast("0", "Mark of the Wild",	nil, targets_selfcast)
TB:Cast("9", "Thorns", 			nil, targets_selfcast)

-- Heal
TB:Cast("1", "Innervate", 		nil, targets_selfcast)
TB:Cast("2", "Regrowth",		nil, targets_selfcast)
TB:Cast("4", "Healing Touch",		nil, targets_selfcast)
TB:Cast("ALT-4", "Nourish",		nil, targets_selfcast)
TB:Cast("3", "Wild Growth",		nil, targets_selfcast)

-- DMG
TB:Cast("Z", "Moonfire", 		nil, targets_selfcast)
TB:Cast("5", "Wrath", 			nil, targets_selfcast)
TB:Cast("6", "Starfire", 			nil, targets_selfcast)

-- Crowd control
TB:Cast("B", "Entangling Roots")
TB:Cast("ALT-1", "Nature's Grasp")
TB:Cast("ALT-B", "Hibernate")

-- Shape dependent actions
TB:CastNoShapeshift("T", "Skull Bash(Bear Form)",	"harm", targets_focus, "Bear Form")
TB:CastNoShapeshift("T", "Skull Bash(Cat Form)",	"harm", targets_focus, "Cat Form")

TB:CastNoShapeshift("G", "Bash",				"harm", targets_focus, "Bear Form")

TB:CastNoShapeshift("Q", "Faerie Fire (Feral)",		"harm", targets_focus, {"Cat Form", "Bear Form"})
TB:CastNoShapeshift("Q", "Cyclone",			"harm", targets_focus, TB.human_form)

TB:Macro("E", "/startattack", true)

TB:CastNoShapeshift("E", "Pounce", 			"stealth", targets_focus, "Cat Form")

TB:CastNoShapeshift("E", "Mangle", 			"harm", targets_focus, "Bear Form")
TB:CastNoShapeshift("E", "Mangle(Cat Form)", 		"harm", targets_focus, "Cat Form")
TB:CastNoShapeshift("E", "Moonfire", 			"harm", targets_focus, TB.human_form)

TB:CastNoShapeshift("ALT-E", "Thrash", 			"harm", targets_focus, "Bear Form")

TB:CastNoShapeshift("R", "Ravage", 			"stealth", targets_focus, "Cat Form")

TB:CastNoShapeshift("R", "Maul", 				"harm", targets_focus, "Bear Form")
TB:CastNoShapeshift("R", "Shred", 				"harm", targets_focus, "Cat Form")
TB:CastNoShapeshift("R", "Entangling Roots", 		"harm", targets_focus, TB.human_form)

TB:CastNoShapeshift("ALT-R", "Swipe(Bear Form)", 	"harm", targets_focus, "Bear Form")
TB:CastNoShapeshift("ALT-R", "Swipe(Cat Form)", 	"harm", targets_focus, "Cat Form")
TB:CastNoShapeshift("ALT-R", "Nature's Grasp", 	nil, "", TB.human_form)

TB:CastNoShapeshift("F", "Growl", 				"harm", targets_focus, "Bear Form")
TB:CastNoShapeshift("F", "Cower", 				"harm", targets_focus, "Cat Form")
TB:CastNoShapeshift("F", "Remove Corruption",		"help",  targets_selfcast, TB.human_form)

TB:CastNoShapeshift("C", "Demoralizing Roar", 		nil, nil, "Bear Form")
TB:CastNoShapeshift("C", "Ferocious Bite", 		"harm", targets_focus, "Cat Form")
TB:CastNoShapeshift("C", "Rejuvenation", 		"help",  targets_selfcast, TB.human_form)

TB:CastNoShapeshift("ALT-C", "Maim", 			"harm", targets_focus, "Cat Form")
TB:CastNoShapeshift("ALT-C", "Swiftmend", 		"help", targets_selfcast, TB.human_form)

TB:CastNoShapeshift("X", "Feral Charge", 		"harm", targets_focus, "Bear Form")
TB:CastNoShapeshift("X", "Feral Charge(Cat Form)",	"harm", targets_focus, "Cat Form")
TB:CastNoShapeshift("X", "Nature's Swiftness", 	nil, "", TB.human_form)

TB:CastNoShapeshift("ALT-X", "Ravage", 			"harm", targets_focus, "Cat Form")

TB:CastNoShapeshift("V", "Lacerate", 			"harm", targets_focus, "Bear Form")
TB:CastNoShapeshift("V", "Rake", 				"harm", targets_focus, "Cat Form")
TB:CastNoShapeshift("V", "Lifebloom",  			"help",  targets_selfcast, TB.human_form)

TB:CastNoShapeshift("ALT-V", "Rip", 			"harm", targets_focus, "Cat Form")
TB:CastNoShapeshift("ALT-V", "Pulverize", 		"harm", targets_focus, "Bear Form")



end

