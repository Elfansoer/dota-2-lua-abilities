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
outworld_devourer_sanitys_eclipse_lua = class({})

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function outworld_devourer_sanitys_eclipse_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function outworld_devourer_sanitys_eclipse_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local radius = self:GetSpecialValueFor( "radius" )
	local mana_loss = self:GetSpecialValueFor( "mana_drain" )
	local int_mult = self:GetSpecialValueFor( "damage_multiplier" )

	-- precache int and damage
	local caster_int = caster:GetIntellect()
	local damageTable = {
		-- victim = target,
		attacker = caster,
		-- damage = 500,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}

	-- find enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- check for normal or inside astral
		local astral = enemy:HasModifier( "modifier_outworld_devourer_astral_imprisonment_lua" )
		if enemy:IsOutOfGame() == astral then

			-- mana loss
			local mana = enemy:GetMaxMana() * mana_loss/100
			enemy:Script_ReduceMana( mana, self )

			-- damage if hero and have intelligence 
			if enemy.GetIntellect then
				damageTable.victim = enemy

				-- get damage
				local enemy_int = enemy:GetIntellect()
				damageTable.damage = math.max( caster_int-enemy_int, 0 ) * int_mult

				-- bypass invulnerable if on astral
				if astral then
					damageTable.damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY
				else
					damageTable.damage_flags = 0
				end

				ApplyDamage(damageTable)

			end
		end
	end

	-- play effects
	self:PlayEffects( point, radius )
end

--------------------------------------------------------------------------------
function outworld_devourer_sanitys_eclipse_lua:PlayEffects( point, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_sanity_eclipse_area.vpcf"
	local sound_cast1 = "Hero_ObsidianDestroyer.Sanityeclipse.Cast"
	local sound_cast2 = "Hero_ObsidianDestroyer.Sanityeclipse"

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast1, self:GetCaster() )
	EmitSoundOnLocationWithCaster( point, sound_cast2, self:GetCaster() )
end