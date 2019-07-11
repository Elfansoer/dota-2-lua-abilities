-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
timbersaw_whirling_death_lua = class({})
LinkLuaModifier( "modifier_timbersaw_whirling_death_lua", "lua_abilities/timbersaw_whirling_death_lua/modifier_timbersaw_whirling_death_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function timbersaw_whirling_death_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local radius = self:GetSpecialValueFor( "whirling_radius" )
	local damage = self:GetSpecialValueFor( "whirling_damage" )
	local duration = self:GetSpecialValueFor( "duration" )
	local tree_damage = self:GetSpecialValueFor( "tree_damage_scale" )

	-- calculate number of trees, then cut down
	local trees = GridNav:GetAllTreesAroundPoint( caster:GetOrigin(), radius, false )
	GridNav:DestroyTreesAroundPoint( caster:GetOrigin(), radius, false )

	-- calculate and precache damage
	damage = damage + #trees * tree_damage
	local damageTable = {
		-- victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- find enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	local hashero = false
	for _,enemy in pairs(enemies) do
		-- debuff if hero
		if enemy:IsHero() then
			enemy:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_timbersaw_whirling_death_lua", -- modifier name
				{ duration = duration } -- kv
			)

			hashero = true
		end

		-- damage
		damageTable.victim = enemy
		ApplyDamage( damageTable )
	end

	-- Play effects
	self:PlayEffects( radius, hashero )
end

--------------------------------------------------------------------------------
function timbersaw_whirling_death_lua:PlayEffects( radius, hashero )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_shredder/shredder_whirling_death.vpcf"
	local sound_cast = "Hero_Shredder.WhirlingDeath.Cast"
	local sound_target = "Hero_Shredder.WhirlingDeath.Damage"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CENTER_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	if hashero then
		EmitSoundOn( sound_target, self:GetCaster() )
	end
end