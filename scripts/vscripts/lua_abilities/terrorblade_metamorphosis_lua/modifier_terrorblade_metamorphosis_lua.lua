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
modifier_terrorblade_metamorphosis_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_terrorblade_metamorphosis_lua:IsHidden()
	return false
end

function modifier_terrorblade_metamorphosis_lua:IsDebuff()
	return false
end

function modifier_terrorblade_metamorphosis_lua:IsStunDebuff()
	return false
end

function modifier_terrorblade_metamorphosis_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_terrorblade_metamorphosis_lua:OnCreated( kv )
	-- references
	self.bat = self:GetAbility():GetSpecialValueFor( "base_attack_time" )
	self.range = self:GetAbility():GetSpecialValueFor( "bonus_range" )
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.slow = self:GetAbility():GetSpecialValueFor( "speed_loss" )
	local delay = self:GetAbility():GetSpecialValueFor( "transformation_time" )

	self.projectile = 900

	if not IsServer() then return end

	-- melee/ranged
	self.attack = self:GetParent():GetAttackCapability()
	if self.attack == DOTA_UNIT_CAP_RANGED_ATTACK then
		-- no bonus for originally ranged enemies
		self.range = 0
		self.projectile = 0
	end
	self:GetParent():SetAttackCapability( DOTA_UNIT_CAP_RANGED_ATTACK )

	-- gesture
	self:GetAbility():SetContextThink(DoUniqueString( "terrorblade_metamorphosis_lua" ), function()
		self:GetParent():StartGesture( ACT_DOTA_CAST_ABILITY_3 )
	end, FrameTime())

	-- transform time
	self.stun = true
	self:StartIntervalThink( delay )

	-- play effects
	self:PlayEffects()
end

function modifier_terrorblade_metamorphosis_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_terrorblade_metamorphosis_lua:OnRemoved()
end

function modifier_terrorblade_metamorphosis_lua:OnDestroy()
	if not IsServer() then return end

	-- return attack cap
	self:GetParent():SetAttackCapability( self.attack )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_terrorblade_metamorphosis_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,

		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,

		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
	}

	return funcs
end

function modifier_terrorblade_metamorphosis_lua:GetModifierBaseAttack_BonusDamage()
	return self.damage
end

function modifier_terrorblade_metamorphosis_lua:GetModifierBaseAttackTimeConstant()
	return self.bat
end

function modifier_terrorblade_metamorphosis_lua:GetModifierMoveSpeedBonus_Constant()
	return self.slow
end

function modifier_terrorblade_metamorphosis_lua:GetModifierProjectileSpeedBonus()
	return self.projectile
end

function modifier_terrorblade_metamorphosis_lua:GetModifierAttackRangeBonus()
	return self.range
end

function modifier_terrorblade_metamorphosis_lua:GetModifierModelChange()
	return "models/heroes/terrorblade/demon.vmdl"
end

function modifier_terrorblade_metamorphosis_lua:GetModifierModelScale()
	return 80
end

function modifier_terrorblade_metamorphosis_lua:GetModifierProjectileName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf"
end

function modifier_terrorblade_metamorphosis_lua:GetAttackSound()
	return "Hero_Terrorblade_Morphed.Attack"
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_terrorblade_metamorphosis_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = self.stun,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_terrorblade_metamorphosis_lua:OnIntervalThink()
	self.stun = false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_terrorblade_metamorphosis_lua:GetEffectName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf"
end

function modifier_terrorblade_metamorphosis_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_terrorblade_metamorphosis_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf"
	local sound_cast = "Hero_Terrorblade.Metamorphosis"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end