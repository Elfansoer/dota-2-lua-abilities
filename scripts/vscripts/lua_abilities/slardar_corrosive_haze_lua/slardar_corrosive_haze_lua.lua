slardar_corrosive_haze_lua = class({})
LinkLuaModifier( "modifier_slardar_corrosive_haze_lua", "lua_abilities/slardar_corrosive_haze_lua/modifier_slardar_corrosive_haze_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function slardar_corrosive_haze_lua:OnSpellStart()
	-- unit identifier
	caster = self:GetCaster()
	target = self:GetCursorTarget()
	point = self:GetCursorPosition()

	-- load data
	local debuff_duration = self:GetSpecialValueFor("duration")

	-- Add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_slardar_corrosive_haze_lua", -- modifier name
		{ duration = debuff_duration } -- kv
	)
end

--------------------------------------------------------------------------------
function slardar_corrosive_haze_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )

	-- Control Particle
	-- Set vector attachment
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )

	-- Set entity attachment
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)

	-- Set particle orientation
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )

	-- Release Particle
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )

	PATTACH_ABSORIGIN 				-- Attaches the particle to the an origin.
	PATTACH_ABSORIGIN_FOLLOW		-- Attaches the particle to an origin, and causes it to follow the unit that is considered the source of the particle.
	PATTACH_CUSTOMORIGIN			-- Attaches the particle to a custom origin. (Requires passing a vector to the Control points)
	PATTACH_CUSTOMORIGIN_FOLLOW
	PATTACH_POINT
	PATTACH_POINT_FOLLOW
	PATTACH_EYES_FOLLOW				-- Attaches the particle to the "eyes" of the entity.
	PATTACH_OVERHEAD_FOLLOW			-- Attaches the particle to be set above the head of the entity.
	PATTACH_WORLDORIGIN				-- Attaches the particle to the ground.
	PATTACH_ROOTBONE_FOLLOW
	PATTACH_RENDERORIGIN_FOLLOW
	PATTACH_MAIN_VIEW
	PATTACH_WATERWAKE
	"attach_hitloc"
	"attach_origin"
	"attach_attack1"
	"attach_attack2"
	"attach_chest"
	"attach_head"
	"attach_foot1"
	"attach_foot2"

	-- buff particle
	buff:AddParticle(
		nFXIndex,
		bDestroyImmediately,
		bStatusEffect,
		iPriority,
		bHeroEffect,
		bOverheadEffect
	)

end
