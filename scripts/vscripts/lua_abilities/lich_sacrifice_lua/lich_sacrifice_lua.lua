lich_sacrifice_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function lich_sacrifice_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local conv_pct = self:GetSpecialValueFor( "health_conversion" )

	-- get mana heal
	local mana = target:GetHealth() * (conv_pct/100)
	caster:GiveMana( mana )

	-- kill target
	target:Kill( self, caster )

	-- Play effects
	self:PlayEffects( target )
end

--------------------------------------------------------------------------------
-- Effects
function lich_sacrifice_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_lich/lich_dark_ritual.vpcf"
	local sound_cast = "Ability.DarkRitual"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	-- ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end