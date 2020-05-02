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
jakiro_liquid_fire_lua = class({})
LinkLuaModifier( "modifier_generic_orb_effect_lua", "lua_abilities/generic/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_liquid_fire_lua", "lua_abilities/jakiro_liquid_fire_lua/modifier_jakiro_liquid_fire_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function jakiro_liquid_fire_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

--------------------------------------------------------------------------------
-- Ability Start
function jakiro_liquid_fire_lua:OnSpellStart()
end

--------------------------------------------------------------------------------
-- Orb Effects
function jakiro_liquid_fire_lua:GetProjectileName()
	return "particles/units/heroes/hero_jakiro/jakiro_base_attack_fire.vpcf"
end

function jakiro_liquid_fire_lua:OnOrbFire( params )
	-- play effects
	local sound_cast = "Hero_Jakiro.LiquidFire"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function jakiro_liquid_fire_lua:OnOrbImpact( params )
	local caster = self:GetCaster()

	-- get data
	local duration = self:GetDuration()
	local radius = self:GetSpecialValueFor( "radius" )

	-- find enemy in radius
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		params.target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- add modifier
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_jakiro_liquid_fire_lua", -- modifier name
			{ duration = duration } -- kv
		)
		
	end

	-- play effects
	self:PlayEffects( params.target, radius )
end

function jakiro_liquid_fire_lua:PlayEffects( target, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf"
	local sound_cast = "Hero_Jakiro.LiquidFire"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end