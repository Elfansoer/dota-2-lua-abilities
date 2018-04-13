tinker_march_of_the_machines_lua = class({})
LinkLuaModifier( "modifier_tinker_march_of_the_machines_lua_thinker", "lua_abilities/tinker_march_of_the_machines_lua/modifier_tinker_march_of_the_machines_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function tinker_march_of_the_machines_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- create thinker
	CreateModifierThinker(
		caster,
		self,
		"modifier_tinker_march_of_the_machines_lua_thinker",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)

	-- Play effects
end
--------------------------------------------------------------------------------
-- Projectile
function tinker_march_of_the_machines_lua:OnProjectileHit_ExtraData( target, location, extraData )

end

--------------------------------------------------------------------------------
function tinker_march_of_the_machines_lua:PlayEffects()
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