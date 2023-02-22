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
modifier_sally_super_acceleration_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sally_super_acceleration_buff:IsHidden()
	return false
end

function modifier_sally_super_acceleration_buff:IsDebuff()
	return false
end

function modifier_sally_super_acceleration_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sally_super_acceleration_buff:OnCreated( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )

	if not IsServer() then return end
end

function modifier_sally_super_acceleration_buff:OnRefresh( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
end

function modifier_sally_super_acceleration_buff:OnRemoved()
end

function modifier_sally_super_acceleration_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sally_super_acceleration_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

function modifier_sally_super_acceleration_buff:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end