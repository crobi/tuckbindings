TuckBindings.MAGE = {}
local TB = TuckBindings

function TuckBindings.MAGE:Init()

-- Shortcuts for target configurations
local targets_selfcast = {[""] = "target", ["SHIFT-"]="player"}
local targets_focus =    {[""] = "target", ["SHIFT-"]="focus"}

-- attack
TB:Macro("T",		    "/startattack")
TB:Macro("SHIFT-T",         "/startattack focus")
TB:Macro("1",		    "/cast Shoot")
TB:Macro("CAPSLOCK",        "/assist")
TB:Macro("SHIFT-CAPSLOCK",  "/assist focus")

-- damage
TB:Cast("2",        "Frostbolt")
TB:Cast("E",        "Fireball")
TB:Cast("SHIFT-E",  "Pyroblast")
TB:Cast("4",        "Scorch")
TB:Cast("R",        "Fire Blast")
TB:Cast("SHIFT-R",  "Cone of Cold")
TB:Cast("SHIFT-C",  "Frost Nova")
TB:Cast("F",        "Arcane Explosion")

-- misc
TB:Cast("C",        "Blink")
TB:Cast("Q",        "Polymorph", "harm")


-- buffs
TB:Cast("0",		   "Mana Shield")
TB:Cast("-",		   "Dampen Magic")
TB:Cast("SHIFT--",         "Amplify Magic")
TB:Cast("=",		   "Arcane Intellect")

end