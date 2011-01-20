local TB = TuckBindings

TuckBindings.common = {}
function TuckBindings.common:Init()

-- default actions: assist unit
TB:Macro("CAPSLOCK", "/assist")
TB:Macro("ALT-CAPSLOCK", "/assist focus")

-- default actions: focus targets, target swapping
TB:SwapTargetFocus("§")
TB:Macro("SHIFT-§","/focus")
TB:Macro("ALT-§","/targetlasttarget")

end