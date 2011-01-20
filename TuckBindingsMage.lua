TuckBindings.MAGE = {}

function TuckBindings.MAGE:Init()

-- attack
TuckBindings:CreateMacroButton("T",		   "/startattack")
TuckBindings:CreateMacroButton("SHIFT-T",  "/startattack focus")
TuckBindings:CreateMacroButton("1",		   "/cast Shoot")
TuckBindings:CreateMacroButton("CAPSLOCK", "/assist")
TuckBindings:CreateMacroButton("SHIFT-CAPSLOCK", "/assist focus")

-- damage
TuckBindings:CreateSpellButton("2",        "Frostbolt")
TuckBindings:CreateSpellButton("E",        "Fireball")
TuckBindings:CreateSpellButton("SHIFT-E",  "Pyroblast")
TuckBindings:CreateSpellButton("4",		   "Scorch")
TuckBindings:CreateSpellButton("R",        "Fire Blast")
TuckBindings:CreateSpellButton("SHIFT-R",  "Cone of Cold")
TuckBindings:CreateSpellButton("SHIFT-C",  "Frost Nova")
TuckBindings:CreateSpellButton("F",        "Arcane Explosion")
TuckBindings:CreateSpellButton("7",        "Rain of Fire")

-- misc
TuckBindings:CreateSpellButton("C",        "Blink")
TuckBindings:CreateMacroButton("Q",        "/cast [nodead, harm, target=focus] Polymorph; Polymorph")


-- buffs
TuckBindings:CreateSpellButton("0",		   "Mana Shield")
TuckBindings:CreateSpellButton("-",		   "Dampen Magic", true, true)
TuckBindings:CreateSpellButton("SHIFT--",  "Amplify Magic", true, true)
TuckBindings:CreateSpellButton("=",		   "Arcane Intellect", true, true)
TuckBindings:CreateSpellButton("SHIFT-=",  "Arcane Brilliance", true, true)
end