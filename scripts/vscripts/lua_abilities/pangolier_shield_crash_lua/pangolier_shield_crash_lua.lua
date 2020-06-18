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
pangolier_shield_crash_lua = class({})
LinkLuaModifier( "modifier_pangolier_shield_crash_lua", "lua_abilities/pangolier_shield_crash_lua/modifier_pangolier_shield_crash_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

-- --------------------------------------------------------------------------------
-- -- Custom KV
-- function pangolier_shield_crash_lua:GetCooldown( level )
-- 	if self:GetCaster():HasScepter() then
-- 		return self:GetSpecialValueFor( "cooldown_scepter" )
-- 	end

-- 	return self.BaseClass.GetCooldown( self, level )
-- end

--------------------------------------------------------------------------------
-- Ability Start
function pangolier_shield_crash_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local damage = self:GetSpecialValueFor( "damage" )
	local radius = self:GetSpecialValueFor( "radius" )
	local distance = self:GetSpecialValueFor( "jump_horizontal_distance" )
	local duration = self:GetSpecialValueFor( "jump_duration" )
	local height = self:GetSpecialValueFor( "jump_height" )
	local buff_duration = self:GetSpecialValueFor( "duration" )

	-- arc
	local arc = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			distance = distance,
			duration = duration,
			height = height,
			fix_duration = false,
			isForward = true,
			isStun = true,
			activity = ACT_DOTA_FLAIL,
		} -- kv
	)
	arc:SetEndCallback(function()
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

		-- precache damage
		local damageTable = {
			-- victim = target,
			attacker = caster,
			damage = damage,
			damage_type = self:GetAbilityDamageType(),
			ability = self, --Optional.
		}

		local stack = 0
		for _,enemy in pairs(enemies) do
			-- damage
			damageTable.victim = enemy
			ApplyDamage(damageTable)

			-- count stack
			if enemy:IsHero() and not enemy:IsIllusion() then
				stack = stack + 1
			end

			-- play effects
			self:PlayEffects4( enemy )
		end

		-- add buff
		if stack>0 then
			caster:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_pangolier_shield_crash_lua", -- modifier name
				{
					duration = buff_duration,
					stack = stack,
				} -- kv
			)
		end

		-- play effects
		self:PlayEffects2()
		if stack>0 then
			self:PlayEffects3()
		end
	end)

	-- play effects
	self:PlayEffects1( arc )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function pangolier_shield_crash_lua:PlayEffects1( modifier )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_pangolier/pangolier_tailthump_cast.vpcf"
	local sound_cast = "Hero_Pangolier.TailThump.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )

	-- buff particle
	modifier:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function pangolier_shield_crash_lua:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf"
	local sound_cast = "Hero_Pangolier.TailThump"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function pangolier_shield_crash_lua:PlayEffects3()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_pangolier/pangolier_tailthump_hero.vpcf"
	local sound_cast = "Hero_Pangolier.TailThump.Shield"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function pangolier_shield_crash_lua:PlayEffects3()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_pangolier/pangolier_tailthump_hero.vpcf"
	local sound_cast = "Hero_Pangolier.TailThump.Shield"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function pangolier_shield_crash_lua:PlayEffects4( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_pangolier/pangolier_tailthump_shield_impact.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end