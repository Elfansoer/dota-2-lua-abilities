centaur_warrunner_stampede_lua = class({})
LinkLuaModifier( "modifier_centaur_warrunner_stampede_lua", "lua_abilities/centaur_warrunner_stampede_lua/modifier_centaur_warrunner_stampede_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_warrunner_stampede_lua_debuff", "lua_abilities/centaur_warrunner_stampede_lua/modifier_centaur_warrunner_stampede_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function centaur_warrunner_stampede_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local bDuration = self:GetSpecialValueFor("duration")

	-- unit groups
	self.hitEnemies = {}

	-- Find Units in Radius
	local allies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,ally in pairs(allies) do
		-- Add modifier
		ally:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_centaur_warrunner_stampede_lua", -- modifier name
			{ duration = bDuration } -- kv
		)
	end

	-- Play effects
	self:PlayEffects()
end

function centaur_warrunner_stampede_lua:HasTrampled( target )
	-- search in tables
	for _,enemy in pairs(self.hitEnemies) do
		if target==enemy then return true end
	end
	return false
end

function centaur_warrunner_stampede_lua:AddTrampled( target )
	table.insert( self.hitEnemies, target )
end
--------------------------------------------------------------------------------
function centaur_warrunner_stampede_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_centaur/centaur_stampede_cast.vpcf"
	local sound_cast = "Hero_Centaur.Stampede.Cast"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end