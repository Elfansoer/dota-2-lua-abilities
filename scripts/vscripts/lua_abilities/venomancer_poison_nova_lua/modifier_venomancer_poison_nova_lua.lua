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
modifier_venomancer_poison_nova_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_venomancer_poison_nova_lua:IsHidden()
	return false
end

function modifier_venomancer_poison_nova_lua:IsDebuff()
	return true
end

function modifier_venomancer_poison_nova_lua:IsStunDebuff()
	return false
end

function modifier_venomancer_poison_nova_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_venomancer_poison_nova_lua:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	if self:GetCaster():HasScepter() then
		damage = self:GetAbility():GetSpecialValueFor( "damage_scepter" )
	end

	if not IsServer() then return end

	local interval = 1

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( interval )
	self:OnIntervalThink()
end

function modifier_venomancer_poison_nova_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_venomancer_poison_nova_lua:OnRemoved()
end

function modifier_venomancer_poison_nova_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_venomancer_poison_nova_lua:OnIntervalThink()
	-- check magic immune
	if self.parent:IsMagicImmune() then return end

	-- apply damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_venomancer_poison_nova_lua:GetEffectName()
	return "particles/units/heroes/hero_venomancer/venomancer_poison_debuff_nova.vpcf"
end

function modifier_venomancer_poison_nova_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_venomancer_poison_nova_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_venomancer.vpcf"
end

function modifier_venomancer_poison_nova_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end