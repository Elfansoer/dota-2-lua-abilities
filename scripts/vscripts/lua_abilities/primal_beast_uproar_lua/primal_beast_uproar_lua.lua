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
primal_beast_uproar_lua = class({})
LinkLuaModifier( "modifier_primal_beast_uproar_lua", "lua_abilities/primal_beast_uproar_lua/modifier_primal_beast_uproar_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_uproar_lua_buff", "lua_abilities/primal_beast_uproar_lua/modifier_primal_beast_uproar_lua_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_uproar_lua_debuff", "lua_abilities/primal_beast_uproar_lua/modifier_primal_beast_uproar_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function primal_beast_uproar_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_primal_beast.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_uproar_magic_resist.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_status_effect_slow.vpcf", context )
end

function primal_beast_uproar_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Custom KV
function primal_beast_uproar_lua:GetBehavior()
	if self:GetCaster():GetModifierStackCount( "modifier_primal_beast_uproar_lua", self:GetCaster() )<1 then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end

	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function primal_beast_uproar_lua:GetAbilityTextureName(  )
	local stack = self:GetCaster():GetModifierStackCount( "modifier_primal_beast_uproar_lua", self:GetCaster() )
	if stack==0 then
		return "primal_beast_uproar_none"
	elseif stack== self:GetSpecialValueFor("stack_limit") then
		return "primal_beast_uproar_max"
	else
		return "primal_beast_uproar_mid"
	end
end

function primal_beast_uproar_lua:IsRefreshable()
	return false
end

--------------------------------------------------------------------------------
-- Passive Modifier
function primal_beast_uproar_lua:GetIntrinsicModifierName()
	return "modifier_primal_beast_uproar_lua"
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function primal_beast_uproar_lua:CastFilterResult()
	if self:GetCaster():GetModifierStackCount( "modifier_primal_beast_uproar_lua", self:GetCaster() )<1 then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function primal_beast_uproar_lua:GetCustomCastError( hTarget )
	if self:GetCaster():GetModifierStackCount( "modifier_primal_beast_uproar_lua", self:GetCaster() )<1 then
		return "#dota_error_no_uproar_stack"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function primal_beast_uproar_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "roar_duration" )
	local radius = self:GetSpecialValueFor( "radius" )
	local slow = self:GetSpecialValueFor( "slow_duration" )

	-- find modifier
	local stack = 0
	local modifier = caster:FindModifierByName( "modifier_primal_beast_uproar_lua" )
	if modifier then
		stack = modifier:GetStackCount()
		modifier:ResetStack()
	end

	-- add buff
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_primal_beast_uproar_lua_buff", -- modifier name
		{
			duration = duration,
			stack = stack,
		} -- kv
	)

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

	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_primal_beast_uproar_lua_debuff", -- modifier name
			{
				duration = slow,
				stack = stack,
			} -- kv
		)
	end

	-- cooldown
	self:StartCooldown( duration )

	-- effects
	self:PlayEffects( radius )
	self:PlayEffects2()
end

--------------------------------------------------------------------------------
-- Effects
function primal_beast_uproar_lua:PlayEffects( radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_roar_aoe.vpcf"
	local sound_cast = "Hero_PrimalBeast.Uproar.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function primal_beast_uproar_lua:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_roar.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_jaw_fx",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end


