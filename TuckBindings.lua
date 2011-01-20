
--[[
  Writes a message in the default chat frame
]]
local TRACE = function(msg) ChatFrame1:AddMessage("TuckBindings: "..msg) end
local ERROR = function(msg) ChatFrame1:AddMessage("TuckBindings: "..msg) end


--[[
  Global variables
]]
TuckBindings = {btn_count = 0, buttons = {} }

local TB = TuckBindings
local human_form = ""

--[[
	Converts the input into a table
		nil -> {default_key=default_value}
		value -> {default_key=value}
]]
function TuckBindings::MakeTable(input, default_value, default_key)
	if input == nil then
		return {default_key=default_value}
	elseif type(input) == "table" then
		return input
	elseif
		return {default_key=input}
	end
end

--[[
	Performs the following conversions:
		nil -> {binding={"target"}}
		value -> {binding={value}}
		{value} -> {binding={value}}
		{value=value} -> {value={value}}
]]
function TuckBindings::MakeTargetConfig(input, binding)
	if input == nil then
		return {binding={"target"}}
	elseif type(input) == "table"
		local result = {}
		for k, v in ipairs(input) do
			-- fix the key
			local key = k
			if type(k)=="number" then
				key = binding
			end
			
			-- fix the value
			local value = v
			if v == nil then
				value = "target"
			elseif type(v) == "table"
				value = v
			else
				value = {v}
			end
			
			-- add to result
			result[key] = value
		end
		return result
	else
		return {binding={input}}
	end
end

Macro(binding)
UseItem(binding, item, targets)
Cast(binding, condition, targets, altcast)
CastNoShapeshift(binding, condition, targets, altcast, stances)
CastShapeshift(binding, condition, targets, altcast, stances)
TargetFocusSwap(binding)



--[[

]]
function TuckBindings:UseItem(binding, item, targets)
	TB:CreateMacroButton(binding, "/use "..item)
	
	if (selfcast) then
		TB:CreateMacroButton("SHIFT-"..binding, "/use [@player] "..item)
	end
	
	if (focuscast) then
		TB:CreateMacroButton("CTRL-"..binding, "/use [@focus] "..item)
	end
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
    Returns a string of the form "[@target, condition_string]" or "[@target1, condition_string][@target2, condition_string]..."
    Input: nil or string or table of strings
]]
function TuckBindings:ConcatenateTargets(target, condition_string)
    -- adding targets
    local tbl_targets = TB::MakeTable(target, 1, "target")
    
    -- build macro string
    local result_string = ""
    for ti, target_string in ipairs(tbl_targets) do
        result_string = result_string.."[@"..target_string..condition_string.."]"
    end

    return result_string
end

--[[
    Returns true if the given stance name corresponds to the human form/no stance
]]
function TuckBindings::IsHumanForm(stance_name)
	return stance_name == human_form or stance_name == "Human"
end

--[[
    Returns the index of the given stance
]]
function TuckBindings:StanceToIndex(stance_name)
	if stance_name == nil  then
		return nil
	end
	
	if TB:IsHumanForm(stance_name) then
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
    Returns a string of the form "" or "stance:1" or "stance:1/2/3..."
    Input: nil or string or table of strings
]]
function TuckBindings:CreateStanceString(stance)
	-- stance handling stuff
	if stance == nil then
		return nil, nil
	else
		local stance_list = ""
		local first_stance = nil
		local stance_count = 0
		if type(stance) == "table" then
			for i, v in ipairs(stance) do
				local stance_index = TB:StanceToIndex(v)
				if stance_index ~= nil then
					if stance_count > 0 then
						stance_list = stance_list.. "/"
					end
					stance_list = stance_list..stance_index
					stance_count = stance_count + 1
					if first_stance == nil then
						first_stance = v
					end
				end
			end
		else
			stance_list = TB:StanceToIndex(stance)
			first_stance = stance
			stance_count = 1
		end

		if stance_count > 0 then
			return "stance:"..stance_list, first_stance
		else
			ERROR("requested stance not found, stance switching ignored for the current binding")
			return nil, nil
		end
	end
end

--[[
    Returns a string of the form "/cast " or "/cast [nostance:1/2/3]Stance1; "
    This effectively switches to the first given stance if the character is not in any of the given stances before casting a spell.
    Input: nil or string or table of strings.
]]
function TuckBindings:CreateStanceSwitchCastString(stance)
	local stance_string, first_stance = CreateStanceString(stance)
	if stance_string and TB:IsHumanForm(first_stance) then
		return "/cancelform [no"..stance_string.."]\n/cast "
	elseif stance_string then
		return "/cast [no"..stance_string.."]"..first_stance.."; "
	else
		return "/cast "
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
    TuckBindings:CreateMacroButton(binding, "/cleartarget [@target, dead]\n/clearfocus [@focus, dead]\n/target focus\n/cleartarget [@focus, noexists]\n/targetlasttarget\n/focus target\n/targetlasttarget")
end

--[[

]]
function TuckBindings:CreateMacroButton(binding, macrotext, add_to_existing)
    local btn = TuckBindings.buttons[binding]
    
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
function TuckBindings:ResetMacroButtons()
	for i, v in ipairs(TuckBindings.buttons) do
		local btn = TuckBindings.buttons[v]
		btn:SetAttribute("*macrotext*", "")
	end
end

--[[
	Returns two boolean values indicating whether a button for the given binding exits and if it has a macro set
]]
function TuckBindings:HasMacroButton(binding)
	local exists = false
	local empty = nil
	for i, v in ipairs(TuckBindings.buttons) do
		if i == binding then
			exists = true
			local btn = TuckBindings.buttons[v]
			local text = btn:GetAttribute("*macrotext*", "")
			if text == "" or text == nil then
				empty = true
			else
				empty = false
			end
		end
	end
	
	return exits, empty
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

--[[

]]
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
f:RegisterEvent("PLAYER_TALENT_UPDATE")

f:SetScript("OnEvent", function(self, event, ...)

	-- clear old config
	TuckBindings::ResetMacroButtons()
	
	-- load default actions
	if TuckBindings["common"] then
		TuckBindings["common"]:Init()
	else
		ERROR("common bindings not found")
	end
	
	-- load profile specific actions
	local player_class = select(2, UnitClass("player"))
	if (TuckBindings[player_class]) then
		TuckBindings[player_class]:Init()
	else
		ERROR("bindings for class "..player_class.." not found")
	end

	TRACE(""..TuckBindings.btn_count.." key bindings configured")
	
end)
