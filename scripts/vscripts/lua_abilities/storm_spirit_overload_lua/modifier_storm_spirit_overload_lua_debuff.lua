-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_storm_spirit_overload_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_storm_spirit_overload_lua_debuff:IsHidden()
	return false
end

function modifier_storm_spirit_overload_lua_debuff:IsDebuff()
	return true
end

function modifier_storm_spirit_overload_lua_debuff:IsStunDebuff()
	return false
end

function modifier_storm_spirit_overload_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_storm_spirit_overload_lua_debuff:OnCreated( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "overload_attack_slow" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "overload_move_slow" )

	if not IsServer() then return end
end

function modifier_storm_spirit_overload_lua_debuff:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_storm_spirit_overload_lua_debuff:OnRemoved()
end

function modifier_storm_spirit_overload_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_storm_spirit_overload_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_storm_spirit_overload_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_storm_spirit_overload_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end