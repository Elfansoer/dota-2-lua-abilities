shaco_deceive = class({})
LinkLuaModifier( "modifier_shaco_deceive", "custom_abilities/shaco_deceive/modifier_shaco_deceive", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function shaco_deceive:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local max_range = self:GetSpecialValueFor("max_range")
	local min_duration = self:GetSpecialValueFor("min_duration")
	local max_duration = self:GetSpecialValueFor("max_duration")

	-- calculate point
	local range = (point-caster:GetOrigin()):Length2D()
	if range>max_range then
		point = (point-caster:GetOrigin()):Normalized() * max_range
		range = max_range
	end

	-- calculate duration
	duration = min_duration + (1-range/max_range) * (max_duration-min_duration)

	-- Invis and move
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_shaco_deceive", -- modifier name
		{
			duration = duration,
			target_x = point.x,
			target_y = point.y,
		} -- kv
	)
end

--------------------------------------------------------------------------------
function shaco_deceive:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end