phantom_assassin_phantom_strike_lua = class({})
LinkLuaModifier( "modifier_phantom_assassin_phantom_strike_lua", "lua_abilities/phantom_assassin_phantom_strike_lua/modifier_phantom_assassin_phantom_strike_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Cast Filter
function phantom_assassin_phantom_strike_lua:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local result = UnitFilter(
		hTarget,	-- Target Filter
		DOTA_UNIT_TARGET_TEAM_BOTH,	-- Team Filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,	-- Unit Filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- Unit Flag
		self:GetCaster():GetTeamNumber()	-- Team reference
	)
	
	if result ~= UF_SUCCESS then
		return result
	end

	return UF_SUCCESS
end

--------------------------------------------------------------------------------
-- Ability Cast Error Message
function phantom_assassin_phantom_strike_lua:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function phantom_assassin_phantom_strike_lua:OnSpellStart()
	-- unit identifier
	caster = self:GetCaster()
	target = self:GetCursorTarget()

	-- Get data
	local buff_duration = self:GetDuration()

	-- Generate data
	local blinkDistance = 50
	local blinkDirection = (caster:GetOrigin() - target:GetOrigin()).Normalized() * blinkDistance
	local blinkPosition = target:GetOrigin() + blinkDirection

	-- Blink
	caster:SetOrigin( blinkPosition )
	FindClearSpaceForUnit( caster, blinkPosition, true )

	-- Add modifier
	if target:GetTeamNumber()==caster:GetTeamNumber() then
		caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_phantom_assassin_phantom_strike_lua", -- modifier name
			{ duration = buff_duration } -- kv
		)
	end
end

--------------------------------------------------------------------------------
function phantom_assassin_phantom_strike_lua:PlayEffects()
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
