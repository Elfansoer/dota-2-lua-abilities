earth_spirit_magnetize_lua = class({})
LinkLuaModifier( "modifier_earth_spirit_magnetize_lua", "lua_abilities/earth_spirit_magnetize_lua/modifier_earth_spirit_magnetize_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_earth_spirit_magnetize_lua_expire", "lua_abilities/earth_spirit_magnetize_lua/modifier_earth_spirit_magnetize_lua_expire", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function earth_spirit_magnetize_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local radius = self:GetSpecialValueFor("cast_radius")
	local duration = self:GetSpecialValueFor("damage_duration")

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- apply modifier
	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_earth_spirit_magnetize_lua", -- modifier name
			{ duration = duration } -- kv
		)
	end

	-- effects
	local sound_cast = "Hero_EarthSpirit.Magnetize.Cast"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
function earth_spirit_magnetize_lua:PlayEffects()
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