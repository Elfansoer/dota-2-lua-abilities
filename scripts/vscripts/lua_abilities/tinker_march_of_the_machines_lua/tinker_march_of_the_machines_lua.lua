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
	self:PlayEffects()
end
--------------------------------------------------------------------------------
-- Projectile
function tinker_march_of_the_machines_lua:OnProjectileHit_ExtraData( target, location, extraData )
	if not target then return true end

	-- find units in radius
	local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),	-- int, your team number
			location,	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			extraData.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

	-- explode
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = extraData.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	for _,enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
	end

	return true
end

--------------------------------------------------------------------------------
function tinker_march_of_the_machines_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_motm.vpcf"
	local sound_cast = "Hero_Tinker.March_of_the_Machines.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationForAllies( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
end