
--[[
  Writes a message in the default chat frame
]]
--local TRACE = function(msg) ChatFrame1:AddMessage("TuckBindings: "..msg) end
local TRACE = function(msg)  end
local INFO = function(msg)  ChatFrame1:AddMessage("TuckBindings: "..msg) end
local ERROR = function(msg) ChatFrame1:AddMessage("TuckBindings: "..msg) end


--[[
  Global variables
]]
TuckBindings = {btn_count = 0, buttons = {}, human_form = "" }

local TB = TuckBindings

--[[
====================================================================================================================================================================================================
User functions for creating key bindings
====================================================================================================================================================================================================
]]

--[[
	Creates a binding for a macro
	binding: the key binding
	macro: the macro text
]]
function TuckBindings:Macro(binding, macro)
	TB:CreateMacroButton(binding, macro,true)
end

--[[
	Creates  a binding for using an item
	binding: the key binding
	item: the item name or the number of the item slot
	condition: the condition that all targets must meet
	targets: target configuration, see MakeTargetConfig
]]
function TuckBindings:UseItem(binding, item, targets)
	local target_config = TB:MakeTargetConfig(targets, binding)
	for ibinding, itargets in pairs(target_config) do
		local condition_string = TB:ConcatenateConditions(condition)
		local option_string = TB:ConcatenateTargets(itargets, condition_string)
		
		TB:CreateMacroButton(ibinding, "/use "..option_string..item,true)
	end
end

--[[
	Creates a binding for casting a spell
	binding: the key binding
	spell: the item name or the number of the item slot
	condition: the condition that all targets must meet
	targets: target configuration, see MakeTargetConfig
]]
function TuckBindings:Cast(binding, spell, condition, targets)
	local target_config = TB:MakeTargetConfig(targets, binding)
	for ibinding, itargets in pairs(target_config) do
		local condition_string = TB:ConcatenateConditions(condition)
		local option_string = TB:ConcatenateTargets(itargets, condition_string)
		
		TB:CreateMacroButton(ibinding, "/cast "..option_string..spell,true)
	end
end

--[[
	Creates a binding for casting a spell, if the caster is in the given stance. Otherwise, nothing will happen
	binding: the key binding
	spell: the item name or the number of the item slot
	condition: the condition that all targets must meet
	targets: target configuration, see MakeTargetConfig
	stances: all stances in which the spell should be cast
]]
function TuckBindings:CastNoShapeshift(binding, spell, condition, targets, stances)
	local target_config = TB:MakeTargetConfig(targets, binding)
	for ibinding, itargets in pairs(target_config) do
		local stance_string = TuckBindings:CreateStanceString(stances)
		local condition_string = TB:ConcatenateConditions(condition, stance_string)
		local option_string = TB:ConcatenateTargets(itargets, condition_string)
		
		TB:CreateMacroButton(ibinding, "/cast "..option_string..spell,true)
	end
end

--[[
	Creates a binding for casting a spell. If the caster is not in the given stance yet, he will change stances first
	binding: the key binding
	spell: the item name or the number of the item slot
	condition: the condition that all targets must meet
	targets: target configuration, see MakeTargetConfig
	stances: all stances in which the spell should be cast. If the caster is not in any of these, he will change to the first in this list
]]
function TuckBindings:CastShapeshift(binding, spell, condition, targets, stances)
	local target_config = TB:MakeTargetConfig(targets, binding)
	for ibinding, itargets in pairs(target_config) do
		local cast_string = TB:CreateStanceSwitchCastString(stances)
		local condition_string = TB:ConcatenateConditions(condition, nil)
		local option_string = TB:ConcatenateTargets(itargets, condition_string)
		
		TB:CreateMacroButton(ibinding, cast_string..option_string..spell,true)
	end
end

--[[
	Creates a binding that swaps the current target and focus
]]
function TuckBindings:SwapTargetFocus(binding)
	TuckBindings:CreateMacroButton(binding, "/cleartarget [@target, dead]\n/clearfocus [@focus, dead]\n/target focus\n/cleartarget [@focus, noexists]\n/targetlasttarget\n/focus target\n/targetlasttarget",true)
end


--[[
====================================================================================================================================================================================================
Internal functions
====================================================================================================================================================================================================
]]

--[[
	Converts the input into a table
		nil -> {default_key=default_value}
		value -> {default_key=value}
]]
function TuckBindings:MakeTable(input, default_value, default_key)
	if input == nil then
		return {default_key=default_value}
	elseif type(input) == "table" then
		return input
	else
		return {default_key=input}
	end
end

--[[
	Performs the following conversions:
		nil -> {binding={"target"}}
		value -> {binding={value}}
		{value} -> {binding={value}}
		{value=value} -> {value={value}}
		{value={value}} -> {value={value}}
]]
function TuckBindings:MakeTargetConfig(input, binding)	
	if input == nil then
		return {[binding]={"target"}}
	elseif type(input) == "table" then
		local result = {}
		for k, v in pairs(input) do

			-- fix the key
			local key
			if type(k) == "string" then
				key = k..binding
			else
				key = binding
			end
			
			
			-- fix the value
			local value = v
			if v == nil then
				value = "target"
			elseif type(v) == "table" then
				value = v
			else
				value = {v}
			end
			
			-- add to result
			if result[key] then
				for ri, rv in pairs(value) do
					tinsert(result[key], rv)
				end
			else
				result[key] = value
			end
		end
		return result
	else
		return {[binding]={input}}
	end
end

--[[
    Returs a string of the form "" or "condition1, condition2, ..."
    Input: string or table of strings
]]
function TuckBindings:ConcatenateConditions(condition, other_condition)
	local condition_string = ""    
	if type(condition) == "table" then
		for ci, cn in ipairs(condition) do
			if condition_string ~= "" then
				condition_string = condition_string..","
			end
			condition_string = condition_string..cn
		end
	elseif condition then
		condition_string = condition
	end
	
	if other_condition and other_condition ~= "" then
		if condition_string ~= "" then
			condition_string = condition_string..","
		end
		condition_string = condition_string..other_condition
	end

	return condition_string
end

--[[
    Returns a string of the form "[@target, condition_string]" or "[@target1, condition_string][@target2, condition_string]..."
    Input: nil or string or table of strings
]]
function TuckBindings:ConcatenateTargets(target, condition_string)
	-- adding targets
	local tbl_targets = TB:MakeTable(target, 1, "target")
	
	-- build macro string
	local result_string = ""
	for ti, target_string in pairs(tbl_targets) do
		--if target_string ~= "target" then
			result_string = result_string.."[@"..target_string
		--else
		--	result_string = result_string.."["
		--end
		if condition_string and condition_string ~= "" then
			--if target_string ~= "target" then
				result_string = result_string..","
			--end
			result_string = result_string..condition_string
		end
		result_string = result_string.."]"
	end

	return result_string
end

--[[
    Returns true if the given stance name corresponds to the human form/no stance
]]
function TuckBindings:IsHumanForm(stance_name)
	return stance_name == TB.human_form or stance_name == "Human"
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
	local stance_string, first_stance = TB:CreateStanceString(stance)
	if stance_string and TB:IsHumanForm(first_stance) then
		return "/cancelform [no"..stance_string.."]\n/cast "
	elseif stance_string then
		return "/cast [no"..stance_string.."]"..first_stance.."; "
	else
		return "/cast "
	end
end

--[[

]]
function TuckBindings:CreateMacroButton(binding, macrotext, add_to_existing)
    local btn = TuckBindings.buttons[binding]
    TRACE(binding..":    "..macrotext)
    
    if add_to_existing and btn then
        local old_text = btn:GetAttribute("*macrotext*")
        local new_text = old_text.."\n"..macrotext
	if (string.len(new_text)>255) then
		ERROR("Macro for binding"..binding.."too long")
	end
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

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
TuckBindings.initialized = false

f:SetScript("OnEvent", function(self, event, ...)

	if (event == "PLAYER_ENTERING_WORLD") then
		TuckBindings.initialized = true
	elseif (not TuckBindings.initialized) then
		return
	end
	
	-- clear old config
	TuckBindings:ResetMacroButtons()
	
	-- load default actions
	if TuckBindings.common then
		TuckBindings.common:Init()
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

	INFO(""..TuckBindings.btn_count.." key bindings configured")
	
end)
