omniknight_guardian_angel_lua = class({})
LinkLuaModifier( "modifier_omniknight_guardian_angel_lua", "lua_abilities/omniknight_guardian_angel_lua/modifier_omniknight_guardian_angel_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function omniknight_guardian_angel_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local buffDuration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
	local targets = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC

	if caster:HasScepter() then
		buffDuration = self:GetSpecialValueFor("duration_scepter")
		radius = FIND_UNITS_EVERYWHERE
		targets = DOTA_UNIT_TARGET_ALL
	end

	-- Find Units in Radius
	local allies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		targets,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,ally in pairs(allies) do
		-- Add modifier
		ally:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_omniknight_guardian_angel_lua", -- modifier name
			{ duration = buffDuration } -- kv
		)
	end

	-- Play Effects
	local sound_cast = "Hero_Omniknight.GuardianAngel.Cast"
	EmitSoundOn( sound_cast, caster )
end