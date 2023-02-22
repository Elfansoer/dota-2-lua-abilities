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
modifier_maple_martyrs_devotion_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_martyrs_devotion_buff:IsHidden()
	return false
end

function modifier_maple_martyrs_devotion_buff:IsDebuff()
	return false
end

function modifier_maple_martyrs_devotion_buff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_martyrs_devotion_buff:OnCreated( kv )
	-- references
	self.reduction = -self:GetAbility():GetSpecialValueFor( "damage_reduction" )

	if not IsServer() then return end
end

function modifier_maple_martyrs_devotion_buff:OnRefresh( kv )
	self.reduction = -self:GetAbility():GetSpecialValueFor( "damage_reduction" )	
end

function modifier_maple_martyrs_devotion_buff:OnRemoved()
end

function modifier_maple_martyrs_devotion_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_maple_martyrs_devotion_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_maple_martyrs_devotion_buff:GetModifierIncomingDamage_Percentage()
	return self.reduction
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_maple_martyrs_devotion_buff:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf"
end

function modifier_maple_martyrs_devotion_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end