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
modifier_maple_indomitable_guardian_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_indomitable_guardian_buff:IsHidden()
	return false
end

function modifier_maple_indomitable_guardian_buff:IsDebuff()
	return false
end

function modifier_maple_indomitable_guardian_buff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_indomitable_guardian_buff:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.min_health = self:GetAbility():GetSpecialValueFor( "min_health_pct" )

	if not IsServer() then return end
	self.parent:Purge(false, true, false, true, true)
end

function modifier_maple_indomitable_guardian_buff:OnRefresh( kv )
	self:OnCreated(kv)
end

function modifier_maple_indomitable_guardian_buff:OnRemoved()
end

function modifier_maple_indomitable_guardian_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_maple_indomitable_guardian_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}

	return funcs
end

function modifier_maple_indomitable_guardian_buff:GetMinHealth()
	return self.parent:GetMaxHealth() * self.min_health/100
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_maple_indomitable_guardian_buff:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_shallow_grave.vpcf"
end

function modifier_maple_indomitable_guardian_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end