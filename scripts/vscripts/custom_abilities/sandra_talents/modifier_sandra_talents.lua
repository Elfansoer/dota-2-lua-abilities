-- Created by Elfansoer
--[[
]]
--------------------------------------------------------------------------------
special_bonus_unique_sandra_spellblock = class({})

--------------------------------------------------------------------------------
-- Classifications
function special_bonus_unique_sandra_spellblock:IsHidden()
	return false
end

function special_bonus_unique_sandra_spellblock:IsDebuff()
	return false
end

function special_bonus_unique_sandra_spellblock:IsPurgable()
	return false
end

function special_bonus_unique_sandra_spellblock:RemoveOnDeath()
	return false
end

function special_bonus_unique_sandra_spellblock:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function special_bonus_unique_sandra_spellblock:OnCreated( kv )
	if not IsServer() then return end
	self.cooldown = self:GetAbility():GetSpecialValueFor( "cooldown" )
	self.ready = true
end

function special_bonus_unique_sandra_spellblock:OnRefresh( kv )
	
end

function special_bonus_unique_sandra_spellblock:OnRemoved()
end

function special_bonus_unique_sandra_spellblock:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function special_bonus_unique_sandra_spellblock:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSORB_SPELL,
	}

	return funcs
end

function special_bonus_unique_sandra_spellblock:OnAttack( params )

end

function special_bonus_unique_sandra_spellblock:GetAbsorbSpell()
	if not self.ready then return 0 end
	self.ready = false
	self:StartIntervalThink( self.cooldown )
	self:SetDuration( self.cooldown, true )
	self:PlayEffects( self:GetCaster(), 300 )
	return 1
end

--------------------------------------------------------------------------------
-- Interval Effects
function special_bonus_unique_sandra_spellblock:OnIntervalThink()
	self.ready = true
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function special_bonus_unique_sandra_spellblock:PlayEffects( target, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf"
	local particle_target = "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf"

	-- Create Target Effects
	local effect_target = ParticleManager:CreateParticle( particle_target, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_target, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_target )
	EmitSoundOn( sound_target, target )

	-- Create Caster Effects
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end