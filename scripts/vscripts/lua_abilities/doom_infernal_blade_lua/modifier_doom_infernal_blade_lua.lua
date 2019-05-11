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
modifier_doom_infernal_blade_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_doom_infernal_blade_lua:IsHidden()
	return false
end

function modifier_doom_infernal_blade_lua:IsDebuff()
	return true
end

function modifier_doom_infernal_blade_lua:IsStunDebuff()
	return false
end

function modifier_doom_infernal_blade_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_doom_infernal_blade_lua:OnCreated( kv )
	if not IsServer() then return end

	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "burn_damage" )
	self.damage_pct = self:GetAbility():GetSpecialValueFor( "burn_damage_pct" )
	local interval = 1

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		-- damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self, --Optional.
	}

	-- Start interval
	self:StartIntervalThink( interval )

	-- Play effects
	self:PlayEffects()
end

function modifier_doom_infernal_blade_lua:OnRefresh( kv )
	if not IsServer() then return end
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "burn_damage" )
	self.damage_pct = self:GetAbility():GetSpecialValueFor( "burn_damage_pct" )
	local interval = 1

	-- Start interval
	self:StartIntervalThink( interval )

	-- Play effects
	self:PlayEffects()
end

function modifier_doom_infernal_blade_lua:OnRemoved()
end

function modifier_doom_infernal_blade_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_doom_infernal_blade_lua:OnIntervalThink()
	-- update damage
	self.damageTable.damage = self.damage + (self.damage_pct/100)*self:GetParent():GetMaxHealth()

	-- apply damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_doom_infernal_blade_lua:GetEffectName()
	return "particles/units/heroes/hero_doom_bringer/doom_infernal_blade_debuff.vpcf"
end

function modifier_doom_infernal_blade_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_doom_infernal_blade_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf"
	local sound_cast = "Hero_DoomBringer.InfernalBlade.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end