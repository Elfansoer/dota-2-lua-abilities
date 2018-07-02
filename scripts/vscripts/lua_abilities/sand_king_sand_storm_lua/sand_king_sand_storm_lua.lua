sand_king_sand_storm_lua = class({})
LinkLuaModifier( "modifier_sand_king_sand_storm_lua", "lua_abilities/sand_king_sand_storm_lua/modifier_sand_king_sand_storm_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sand_king_sand_storm_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("AbilityDuration")

	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_sand_king_sand_storm_lua", -- modifier name
		{
			duration = duration,
			start = true,
		} -- kv
	)

end

--------------------------------------------------------------------------------
-- Ability Channeling
-- function sand_king_sand_storm_lua:GetChannelTime()

-- end

function sand_king_sand_storm_lua:OnChannelFinish( bInterrupted )
	local delay = self:GetSpecialValueFor("sand_storm_invis_delay")
	self:GetCaster():AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_sand_king_sand_storm_lua", -- modifier name
		{
			duration = delay,
			start = false,
		} -- kv
	)
end

--------------------------------------------------------------------------------
-- function sand_king_sand_storm_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end