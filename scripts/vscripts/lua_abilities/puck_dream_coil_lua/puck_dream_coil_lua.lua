puck_dream_coil_lua = class({})
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_puck_dream_coil_lua", "lua_abilities/puck_dream_coil_lua/modifier_puck_dream_coil_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_puck_dream_coil_lua_thinker", "lua_abilities/puck_dream_coil_lua/modifier_puck_dream_coil_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function puck_dream_coil_lua:GetAOERadius()
	return self:GetSpecialValueFor( "coil_radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function puck_dream_coil_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local radius = self:GetSpecialValueFor("coil_radius")
	local duration = self:GetSpecialValueFor("coil_duration")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	if caster:HasScepter() then
		duration = self:GetSpecialValueFor("coil_duration_scepter")
	end

	-- center point
	local center = CreateModifierThinker(
		self:GetCaster(),
		self,
		"modifier_puck_dream_coil_lua_thinker",
		{ duration = duration },
		point,
		self:GetCaster():GetTeamNumber(),
		false
	)

	-- find enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_generic_stunned_lua", -- modifier name
			{ duration = stun_duration } -- kv
		)

		local modifier = enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_puck_dream_coil_lua", -- modifier name
			{
				duration = duration,
				coil_x = point.x,
				coil_y = point.y,
				coil_z = point.z,
			} -- kv
		)
	end

	-- play effects
	self:PlayEffects( point, duration )
end

--------------------------------------------------------------------------------
function puck_dream_coil_lua:PlayEffects( point, duration )
	-- Get Resources
	local sound_cast = "Hero_Puck.Dream_Coil"
	EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
end