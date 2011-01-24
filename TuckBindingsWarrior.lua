TuckBindings.WARRIOR = {}
local TB = TuckBindings

function TuckBindings.WARRIOR:Init()



-- Shortcuts for target configurations
local targets_selfcast = {[""] = "target", ["SHIFT-"]="player"}
local targets_focus =    {[""] = "target", ["SHIFT-"]="focus"}

-- Forms
TB:Cast("CTRL-1", "Defensive Stance")
TB:Cast("CTRL-2", "Battle Stance")
TB:Cast("CTRL-3", "Berserker Stance")


-- Shape dependent actions
TB:Cast("G", "Charge",	nil, targets_focus)
TB:Cast("F", "Taunt",	nil, targets_focus)

TB:CastShapeshift("V", "Hamstring",       nil, targets_focus, {"Battle Stance", "Berserker Stance"})
TB:CastShapeshift("C", "Thunder Clap",       nil, targets_focus, {"Battle Stance", "Defensive Stance"})
TB:CastShapeshift("R", "Shield Bash",        nil, targets_focus, {"Battle Stance", "Defensive Stance"})
TB:CastShapeshift("ALT-R", "Shield Block",   nil, targets_focus, {"Battle Stance", "Defensive Stance"})
TB:Cast          ("Q", "Sunder Armor",       nil, targets_focus)
TB:Cast          ("ALT-C", "Rend",           nil, targets_focus)
TB:Cast          ("E", "Heroic Strike",      nil, targets_focus)
TB:Cast          ("ALT-E", "Cleave",         nil, targets_focus)
TB:Cast          ("X", "Victory Rush",       nil, targets_focus)

end