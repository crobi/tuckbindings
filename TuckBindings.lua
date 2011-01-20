
--[[

]]
local TRACE = function(msg) ChatFrame1:AddMessage(msg) end


--[[

]]
TuckBindings = {btn_count = 0, buttons = {} }


--[[

]]
function TuckBindings:CreateHelpHarmButton(binding, harmspell, helpspell, selfcast, focuscast)
	TuckBindings:CreateMacroButton(binding, "/cast [harm]"..harmspell.."; "..helpspell)
	
	if (selfcast) then
		TuckBindings:CreateMacroButton("SHIFT-"..binding, "/cast [@player] "..helpspell)
	end
	
	if (focuscast) then
		TuckBindings:CreateMacroButton("CTRL-"..binding, "/cast [@focus, harm] "..harmspell.."; [@focus] "..helpspell)
	end
end

--[[

]]
function TuckBindings:CreateHelpButton(binding, spell, target2, selfcast)
	if (target2) then
		TuckBindings:CreateMacroButton(binding, "/cast [help]"..spell.."; [@"..target2..", help] "..spell)
	else
		TuckBindings:CreateMacroButton(binding, "/cast [help]"..spell)
	end
	
	if (selfcast) then
		TuckBindings:CreateMacroButton(selfcast.."-"..binding, "/cast [@player]"..spell)
	end
end

--[[

]]
function TuckBindings:CreateHarmButton(binding, spell, target2, focuscast)
	if (target2) then
		TuckBindings:CreateMacroButton(binding, "/cast [harm]"..spell.."; [harm, @"..target2.."] "..spell)
	else
		TuckBindings:CreateMacroButton(binding, "/cast [harm]"..spell)
	end

	if (focuscast) then
        if target2 == nil then
            target2 = "focus"
        end
		TuckBindings:CreateMacroButton(focuscast.."-"..binding, "/cast [@"..target2..", harm] "..spell)
	end
end

--[[

]]
function TuckBindings:CreateStealthButton(binding, stealthspell, spell, selfcast, focuscast)
	TuckBindings:CreateMacroButton(binding, "/cast [stealth]"..stealthspell.."; "..spell)
	
	if (selfcast) then
		TuckBindings:CreateMacroButton("SHIFT-"..binding, "/cast [@player, stealth] "..stealthspell.."; "..spell)
	end
	
	if (focuscast) then
		TuckBindings:CreateMacroButton("CTRL-"..binding, "/cast [@focus, stealth] "..stealthspell.."; [@focus] "..spell)
	end
end

--[[

]]
function TuckBindings:CreateSpellButton(binding, spell, selfcast, focuscast)
	TuckBindings:CreateMacroButton(binding, "/cast "..spell)
	
	if (selfcast) then
		TuckBindings:CreateMacroButton("SHIFT-"..binding, "/cast [@player] "..spell)
	end
	
	if (focuscast) then
		TuckBindings:CreateMacroButton("CTRL-"..binding, "/cast [@focus] "..spell)
	end
end

--[[

]]
function TuckBindings:CreateShapeshiftSpellButton(binding, spell, stance, shapename, selfcast, focuscast)
	TuckBindings:CreateMacroButton(binding, "/cast [nostance: "..stance.."] "..shapename.."; "..spell)
	
	if (selfcast) then
		TuckBindings:CreateMacroButton("SHIFT-"..binding, "/cast [nostance: "..stance.."] "..shapename.."; [@player] "..spell)
	end
	
	if (focuscast) then
		TuckBindings:CreateMacroButton("CTRL-"..binding, "/cast [nostance: "..stance.."] "..shapename.."; [@focus] "..spell)
	end
end

--[[

]]
function TuckBindings:CreateNoShapeshiftSpellButton(binding, spell, selfcast, focuscast)
	TuckBindings:CreateMacroButton(binding, "/cancelform [stance]\n/cast "..spell)
	
	if (selfcast) then
		TuckBindings:CreateMacroButton("SHIFT-"..binding, "/cancelform [stance]\n/cast [@player]"..spell)
	end
	
	if (focuscast) then
		TuckBindings:CreateMacroButton("CTRL-"..binding, "/cancelform [stance]\n/cast [@player]"..spell)
	end
end

--[[

]]
function TuckBindings:CreateNoShapeshiftHelpButton(binding, spell, target2, selfcast)
	if (target2) then
		TuckBindings:CreateMacroButton(binding, "/cancelform [stance]\n/cast [help]"..spell.."; [help, @"..target2.."] "..spell)
	else
		TuckBindings:CreateMacroButton(binding, "/cancelform [stance]\n/cast [help]"..spell)
	end
	
	if (selfcast) then
		TuckBindings:CreateMacroButton(selfcast.."-"..binding, "/cancelform [stance]\n/cast [@player]"..spell)
	end
end

--[[

]]
function TuckBindings:CreateNoShapeshiftHarmButton(binding, spell, target2, selfcast)
	if (target2) then
		TuckBindings:CreateMacroButton(binding, "/cancelform [stance]\n/cast [harm]"..spell.."; [harm, @"..target2.."] "..spell)
	else
		TuckBindings:CreateMacroButton(binding, "/cancelform [stance]\n/cast [harm]"..spell)
	end
	
	if (selfcast) then
		TuckBindings:CreateMacroButton(selfcast.."-"..binding, "/cancelform [stance]\n/cast [harm, @focus]"..spell)
	end
end

--[[

]]
function TuckBindings:CreateItemButton(binding, item, selfcast, focuscast)
	TuckBindings:CreateMacroButton(binding, "/use "..item)
	
	if (selfcast) then
		TuckBindings:CreateMacroButton("SHIFT-"..binding, "/use [@player] "..item)
	end
	
	if (focuscast) then
		TuckBindings:CreateMacroButton("CTRL-"..binding, "/use [@focus] "..item)
	end
end

--[[

]]
function TuckBindings:CreateStanceButton(binding, mod,
    nostance_target, nostance_spell, mod_nostance_target, mod_nostance_spell,
    stance1, stance1_target, stance1_spell, mod_stance1_target, mod_stance1_spell, 
    stance2, stance2_target, stance2_spell, mod_stance2_target, mod_stance2_spell) 

    local macro_string = "/cast "
    
    -- default: focuscast
    if (stance1 and stance1_target and stance1_spell) then
        macro_string = macro_string.."[stance:"..stance1..", help] "..stance1_spell.."; "
        macro_string = macro_string.."[stance:"..stance1..", @"..stance1_target.."] "..stance1_spell.."; "
    end
    
    if (stance2 and stance2_target and stance2_spell) then
        macro_string = macro_string.."[stance:"..stance2..", help] "..stance2_spell.."; "
        macro_string = macro_string.."[stance:"..stance2..", @"..stance2_target.."] "..stance2_spell.."; "
    end
    
    if (nostance_target and nostance_spell) then
        macro_string = macro_string.."[help] "..nostance_spell.."; "
        macro_string = macro_string.."[@"..nostance_target.."] "..nostance_spell
    end
    
    TuckBindings:CreateMacroButton(binding, macro_string)
    
    
    -- Modifier Key
    if (mod) then

        macro_string = "/cast "

        if (stance1 and mod_stance1_target and mod_stance1_spell) then
            macro_string = macro_string.."[stance:"..stance1..", @"..mod_stance1_target.."] "..mod_stance1_spell.."; "
        end
        
        if (stance2 and mod_stance2_target and mod_stance2_spell) then
            macro_string = macro_string.."[stance:"..stance2..", @"..mod_stance2_target.."] "..mod_stance2_spell.."; "
        end

        if (mod_nostance_target and mod_nostance_spell) then
            macro_string = macro_string.."[@"..mod_nostance_target.."] "..mod_nostance_spell
        end
        
        TuckBindings:CreateMacroButton("SHIFT-"..binding, macro_string)

    end

end


local stance_indices = {}
-- all
stance_indices["None"] = 0
stance_indices["No Stance"] = 0
stance_indices["Human Form"] = 0
stance_indices["Human"] = 0
-- warrior
stance_indices["Battle Stance"] = 1
stance_indices["Defensive Stance"] = 2
stance_indices["Berserker Stance"] = 3
-- druid
stance_indices["Bear Form"] = 1
stance_indices["Dire Bear Form"] = 1
stance_indices["Aquatic Form"] = 2
stance_indices["Cat Form"] = 3
stance_indices["Travel Form"] = 4
stance_indices["Moonkin Form"] = 5
stance_indices["Tree of Life"] = 5
stance_indices["Flight Form"] = 6 -- or 5, if no moonkin/tree of life present. will not work correctly
-- priest
stance_indices["Shadowform"] = 1
-- rogue
stance_indices["Stealth"] = 1
-- shaman
stance_indices["Ghost Wolf"] = 1
-- paladin
stance_indices["Devotion Aura"] = 1
stance_indices["Retribution Aura"] = 2
stance_indices["Concentration Aura"] = 3
stance_indices["Shadow Resistance Aura"] = 4
stance_indices["Frost Resistance Aura"] = 5
stance_indices["Fire Resistance Aura"] = 6
stance_indices["Crusader Aura"] = 7

--[[
    Returns the index of the given stance
]]
function TuckBindings:StanceToIndex(stance_name)
    --ChatFrame1:AddMessage("Getting stance index of: "..stance_name)
    if stance_name == nil or stance_name == "Human" or stance_name == "Human Form" or stance_name == "No Stance" then
        return 0
    end
    
    local i
    local stance_count = GetNumShapeshiftForms()
    for i = 1, stance_count do
        local icon, name = GetShapeshiftFormInfo(i);
        if name == stance_name then
            return i
        end
    end
    
    return nil
end

--[[
    Returns the name of the first known spell or an empty string
    Input: table of strings or string
]]
function TuckBindings:FindKnownSpell(spellname)
    -- find spell name
    local spellname_string = ""
    if type(spellname) == "table" then 
        -- look for known spell
        for si, sn in ipairs(spellname) do
            if TuckBindings:HasSpell(sn) then
                spellname_string = sn
                break
            end
        end
    else
        if TuckBindings:HasSpell(spellname) then
            spellname_string = spellname
        end
    end
    
    return spellname_string
end

--[[
    Returs a string of the form "" or ", condition1, condition2, ..."
    Input: string or table of strings
]]
function TuckBindings:ConcatenateConditions(condition)
    local condition_string = ""
    if type(condition) == "table" then
        for ci, cn in ipairs(condition) do
            condition_string = condition_string..", "..cn
        end
    elseif condition ~= nil then
        condition_string = ", "..condition
    end
    
    return condition_string
end

--[[
    Returns a string of the form "[target=target, condition_string]" or "[target=target1, condition_string][target=target2, condition_string]..."
    Input: nil or string or table of strings
]]
function TuckBindings:ConcatenateTargets(target, condition_string)
    -- adding targets
    local tbl_targets
    if type(target) == "table" then 
        tbl_targets = target
    elseif target == nil then 
        tbl_targets = {"target"}
    else
        tbl_targets = {target}
    end
    
    -- build macro string
    local result_string = ""
    for ti, target_string in ipairs(tbl_targets) do
        result_string = result_string.."[@"..target_string..condition_string.."]"
    end

    return result_string
end

--[[
    Returns a string of the form "" or "stance:1" or "stance:1/2/3..."
    Input: nil or string or table of strings
]]
function TuckBindings:CreateStanceString(stance)
    -- stance handling stuff
    if stance == nil then
        return ""
    else
        local stance_list = ""
        local stance_count = 0
        if type(stance) == "table" then
            for i, v in ipairs(stance) do
                local stance_index = TuckBindings:StanceToIndex(stance[i])
                if stance_index then
                    if stance_count > 0 then
                        stance_list = stance_list.. "/"
                    end
                    stance_list = stance_list..stance_index
                    stance_count = stance_count + 1
                end
            end
        else
            stance_list = TuckBindings:StanceToIndex(stance)
        end
        
        if stance_list then
            return "stance:"..stance_list
        else
            return ""
        end
    end
end

--[[
    Returns a string of the form "/cast " or "/cast [nostance:1/2/3]Stance1; "
    This effectively switches to the first given stance if the character is not in any of the given stances before casting a spell.
    Input: nil or string or table of strings.
]]
function TuckBindings:CreateStanceSwitchCastString(stance)
    -- stance handling stuff
    if stance == nil then
        return "/cast "
    else
        local stance_list = ""
        local first_stance = ""
        local stance_count = 0
        if type(stance) == "table" then
            for i, v in ipairs(stance) do
                local stance_index = TuckBindings:StanceToIndex(stance[i])
                if stance_index then
                    if stance_count > 0 then
                        stance_list = stance_list.. "/"
                    end
                    stance_list = stance_list..stance_index
                    stance_count = stance_count + 1
                    if first_stance == "" then
                        first_stance = stance[i]
                    end
                end
            end
        else
            stance_list = TuckBindings:StanceToIndex(stance)
            first_stance = stance
        end
        
        if stance_list then
            return "/cast [nostance:"..stance_list.."]"..first_stance.."; "
        else
            return "/cast "
        end
    end
end

--[[
    Use if you want a key to do different things in different stances. The action is only
    executed if you are in any of the given stances. Does not switch stances.
    See TuckBindings:CreateSpellBinding for options.

]]
function TuckBindings:CreateStanceBinding(binding, spellname, condition, target, altcast_mod, altcast_target, stance, add_to_existing)
   
    -- find spell name
    local spellname_string = TuckBindings:FindKnownSpell(spellname)

    -- abort if no spell found
    if spellname_string == "" then
        TRACE("No spell in the spell list known by player, binding skipped")
        return
    end
    
    -- concatenate conditions
    local condition_string = TuckBindings:ConcatenateConditions(condition)
    
    -- add correct stance
    local stance_string = TuckBindings:CreateStanceString(stance)
    if (stance_string ~= "") then
        condition_string = condition_string..", "..stance_string
    end
    
    -- cast string
    local macro_string = "/cast "
      
    -- build macro string
    local option_string = TuckBindings:ConcatenateTargets(target, condition_string)

    -- create macro
   TuckBindings:CreateMacroButton(binding, macro_string.." "..option_string.." "..spellname_string, true)
    
    -- alternate cast
    
    if (altcast_mod) then
        local altcast_option_string = TuckBindings:ConcatenateTargets(altcast_target, condition_string)
	local altcast_binding = altcast_mod.."-"..binding
        TuckBindings:CreateMacroButton(altcast_binding, macro_string.." "..altcast_option_string.." "..spellname_string, true)
    end
end

--[[
    Creates a Spell Binding.
    For classes with stances, use this if you want to have for each ability its own key. The player will shift to the desired stance if the spell
        is not available in the current stance.
    
    binding:            [NOT NIL] Name of the bound key, e.g. "Q". 
    spellname:          [NOT NIL] Name of the spell, e.g. "Cyclone". If this argument is a table, the first known spell in the list will be used.
    condition:          [NIL] Conditions that the target must meet, e.g. "harm". If this argument is a table, all of the conditions must be met.
    target:             [NIL] Target of the spell, e.g. "party1". If this argument is a table, 
                        the targets are tried in order until one meets the condition. Default: "target"
                        
    altcast_modifier:   [NIL] Modifier key for casting the spell on an alternate target.
    altcast_target:     [NIL] Alternate target for the spell. Can be a table. Use for self-casting.
    
    stance:             [NIL] Stance that you must be in to be able to use the ability. If you are not in that stances, you will change stances first.
                        If this argument is a table, you must be in any of these stances and will shift to the first one if not.
]]
function TuckBindings:CreateSpellBinding(binding, spellname, condition, target, altcast_modifier, altcast_target, stance)
    -- find spell name
    local spellname_string = TuckBindings:FindKnownSpell(spellname)

    -- abort if no spell found
    if spellname_string == "" then
        TRACE("No spell in the spell list known by player, binding skipped")
        return
    end
    
    -- concatenate conditions
    local condition_string = TuckBindings:ConcatenateConditions(condition)
    
    -- stance handling stuff
    local macro_string = TuckBindings:CreateStanceSwitchCastString(stance)
      
    -- build macro string
    local option_string = TuckBindings:ConcatenateTargets(target, condition_string)

    -- create macro
   TuckBindings:CreateMacroButton(binding, macro_string.." "..option_string.." "..spellname_string)
    
    -- alternate cast
    if altcast_modifer then
        local option_string = TuckBindings:ConcatenateTargets(altcast_target, condition_string)
        TuckBindings:CreateMacroButton(altcast_modifer.."-"..binding, macro_string.." "..option_string.." "..spellname_string)
    end
end

--[[

]]
function TuckBindings:CreateTargetSwapButton(binding)
	--TuckBindings:CreateMacroButton(binding, "/target focus\n/targetlasttarget\n/focus\n/targetlasttarget")
    TuckBindings:CreateMacroButton(binding, "/cleartarget [@target, dead]\n/clearfocus [@focus, dead]\n/target focus\n/cleartarget [@focus, noexists]\n/targetlasttarget\n/focus target\n/targetlasttarget")
end

--[[

]]
function TuckBindings:CreateTotemStompButton(binding)
    TuckBindings:CreateMacroButton(binding, "/petattack [@Healing Stream Totem]\n/petattack [@Mana Spring Totem]\n/petattack [@Windfury Totem]\n/petattack [@Tremor Totem]\n/petattack [@Grounding Totem]\n/petattack [@Mana Tide Totem]")
end

--[[

]]
function TuckBindings:CreateMacroButton(binding, macrotext, add_to_existing)
	
    local btn = TuckBindings.buttons[binding]
    ChatFrame1:AddMessage(binding.."  |  "..macrotext)
    
    if add_to_existing and btn then
        local old_text = btn:GetAttribute("*macrotext*")
        local new_text = old_text.."\n"..macrotext
        btn:SetAttribute("*macrotext*", new_text)
    else
        btn = CreateFrame("Button", "TuckBindingsButton"..TuckBindings.btn_count, nil, "SecureActionButtonTemplate")
        btn:SetAttribute("*type*", "macro")
        btn:SetAttribute("*macrotext*", macrotext)
        SetBindingClick(binding, btn:GetName())
        TuckBindings.btn_count = TuckBindings.btn_count + 1
        TuckBindings.buttons[binding] = btn
    end
end

--[[

]]
function TuckBindings:HasSpell(name)
	local i = 1
	while true do
	   local spellName, spellSubType = GetSpellBookItemName(i, BOOKTYPE_SPELL)
	   if not spellName then
		  return false
	   end
	   
	   if spellName == name then 
	      return true
	   end
	   
	   i = i + 1
	end
end

function TuckBindings:HasPetSpell(name)
	local i = 1
	while true do
	   local spellName, spellSubType = GetSpellBookItemName(i, BOOKTYPE_PET)
	   if not spellName then
		  return false
	   end
	   
	   if spellName == name then 
	      return true
	   end
	   
	   i = i + 1
	end
end


--[[

]]
local f = CreateFrame("Frame")

f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function(self, event, ...)
	
	-- default actions: assist unit
	TuckBindings:CreateMacroButton("CAPSLOCK", "/assist")
	TuckBindings:CreateMacroButton("ALT-CAPSLOCK", "/assist focus")

	-- default actions: focus targets, target swapping
	TuckBindings:CreateTargetSwapButton("§")
	TuckBindings:CreateMacroButton("SHIFT-§","/focus")
	TuckBindings:CreateMacroButton("ALT-§","/targetlasttarget")

	-- default actions: bandage self
	TuckBindings:CreateMacroButton("CTRL-BUTTON3",  "/use [@player] Heavy Netherweave Bandage")


	-- load profile specific actions
	local player_class = select(2, UnitClass("player"))
	if (TuckBindings[player_class]) then
		TuckBindings[player_class]:Init()
	else
		ChatFrame1:AddMessage("unknown class "..player_class)
	end

	ChatFrame1:AddMessage("Number of bindings: "..TuckBindings.btn_count)
	
end)
