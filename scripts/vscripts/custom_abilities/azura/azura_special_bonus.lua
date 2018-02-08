special_bonus_unique_azura_a = class({})
special_bonus_unique_azura_b = class({})
special_bonus_unique_azura_c = class({})
special_bonus_unique_azura_d = class({})
LinkLuaModifier( "modifier_special_bonus_unique_azura_a", "custom_abilities/azura/azura_special_bonus", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_special_bonus_unique_azura_b", "custom_abilities/azura/azura_special_bonus", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_special_bonus_unique_azura_c", "custom_abilities/azura/azura_special_bonus", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_special_bonus_unique_azura_d", "custom_abilities/azura/azura_special_bonus", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function special_bonus_unique_azura_a:GetIntrinsicModifierName()
	return "modifier_special_bonus_unique_azura_a"
end
function special_bonus_unique_azura_b:GetIntrinsicModifierName()
	return "modifier_special_bonus_unique_azura_b"
end
function special_bonus_unique_azura_c:GetIntrinsicModifierName()
	return "modifier_special_bonus_unique_azura_c"
end
function special_bonus_unique_azura_d:GetIntrinsicModifierName()
	return "modifier_special_bonus_unique_azura_d"
end

--------------------------------------------------------------------------------
-- Passive Modifier
modifier_special_bonus_unique_azura_a = class({})
modifier_special_bonus_unique_azura_b = class({})
modifier_special_bonus_unique_azura_c = class({})
modifier_special_bonus_unique_azura_d = class({})
function modifier_special_bonus_unique_azura_a:IsHidden()
	return false
end
function modifier_special_bonus_unique_azura_b:IsHidden()
	return false
end
function modifier_special_bonus_unique_azura_c:IsHidden()
	return false
end
function modifier_special_bonus_unique_azura_d:IsHidden()
	return false
end
function modifier_special_bonus_unique_azura_a:OnCreated( kv )

end

-- Failed code for generally modifying values
function modifier_special_bonus_unique_azura_a:Unused( kv )
	if IsServer() then
		-- get associated ability name and modified key name
		local ability_name = self:GetAbility():GetAbilityKeyValues()["AbilityTarget"]
		local ability_key_name = self:GetAbility():GetAbilityKeyValues()["AbilityKeyName"]

		-- get ability handle
		local ability = self:GetParent():FindAbilityByName( ability_name )

		-- get modified key
		if ability~=nil then
			-- get ability special values
			local ability_special = ability:GetAbilityKeyValues().AbilitySpecial

			-- search linked name
			local linked_id = ""
			local linked_type = ""
			local linked_value = ""
			local found = false
			for key,value in pairs( ability_special ) do
			 	if value[ability_key_name] then
			 		linked_id = key
			 		linked_type = value["var_type"]
			 		linked_value = value[ability_key_name]
			 		found = true
			 		break
				end
			end
		end
	end
end