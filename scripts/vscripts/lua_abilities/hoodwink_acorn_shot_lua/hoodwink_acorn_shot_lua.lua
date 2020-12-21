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
hoodwink_acorn_shot_lua = class({})
LinkLuaModifier( "modifier_hoodwink_acorn_shot_lua", "lua_abilities/hoodwink_acorn_shot_lua/modifier_hoodwink_acorn_shot_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hoodwink_acorn_shot_lua_thinker", "lua_abilities/hoodwink_acorn_shot_lua/modifier_hoodwink_acorn_shot_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hoodwink_acorn_shot_lua_debuff", "lua_abilities/hoodwink_acorn_shot_lua/modifier_hoodwink_acorn_shot_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hoodwink_acorn_shot_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_hoodwink.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_acorn_shot_tracking.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_acorn_shot_slow.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_acorn_shot_tree.vpcf", context )
	PrecacheResource( "particle", "particles/tree_fx/tree_simple_explosion.vpcf", context )
end

function hoodwink_acorn_shot_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Custom KV
function hoodwink_acorn_shot_lua:GetCastRange( vLocation, hTarget )
	return self:GetCaster():Script_GetAttackRange() + self:GetSpecialValueFor( "bonus_range" )
end

--------------------------------------------------------------------------------
-- Ability Start
function hoodwink_acorn_shot_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- Hardcoded as it has no kv value
	self.tree_duration = 20
	self.tree_vision = 300

	-- create thinker
	local thinker = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_hoodwink_acorn_shot_lua_thinker", -- modifier name
		{  }, -- kv
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)
	local mod = thinker:FindModifierByName( "modifier_hoodwink_acorn_shot_lua_thinker" )

	if not target then
		target = thinker
		thinker:SetOrigin( point )
	end
	mod.source = caster
	mod.target = target

	-- play effects
	local sound_cast = "Hero_Hoodwink.AcornShot.Cast"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
-- Projectile
function hoodwink_acorn_shot_lua:OnProjectileHit_ExtraData( target, location, ExtraData )
	local caster = self:GetCaster()
	local thinker = EntIndexToHScript( ExtraData.thinker )
	local mod = thinker:FindModifierByName( "modifier_hoodwink_acorn_shot_lua_thinker" )
	if not mod then return end

	-- bounce
	thinker:SetOrigin( location )
	mod:Bounce()

	-- only on first shot, if target dodges or no target, create tree
	if ExtraData.first==1 then
		if target==thinker then
			self:CreateTree( location )
			return
		end

		-- if no enemy
		if not target then
			self:CreateTree( location )
			mod.target = thinker
			return
		end
		
		if target:TriggerSpellAbsorb( self ) then
			mod:Destroy()
			return
		end
	end

	-- check target
	if not target then
		mod:Destroy()
		return
	end

	local duration = self:GetSpecialValueFor( "debuff_duration" )

	-- attack enemy
	local mod = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_hoodwink_acorn_shot_lua", -- modifier name
		{} -- kv
	)
	caster:PerformAttack(
		target,
		true,
		true,
		true,
		true,
		false,
		false,
		true
	)
	mod:Destroy()

	-- debuff
	if not target:IsMagicImmune() then
		target:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_hoodwink_acorn_shot_lua_debuff", -- modifier name
			{ duration = duration } -- kv
		)

		-- play effects
		local sound_slow = "Hero_Hoodwink.AcornShot.Slow"
		EmitSoundOn( sound_slow, target )
	end

	-- play effects
	local sound_target = "Hero_Hoodwink.AcornShot.Target"
	EmitSoundOn( sound_target, target )
end

function hoodwink_acorn_shot_lua:CreateTree( location )
	-- vision
	AddFOWViewer( self:GetCaster():GetTeamNumber(), location, self.tree_vision, self.tree_duration, false )

	-- tree
	local tree = CreateTempTreeWithModel( location, self.tree_duration, "models/heroes/hoodwink/hoodwink_tree_model.vmdl" )

	-- move everyone on tree collision so they don't get stuck
	local units = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		location,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		100,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
		DOTA_UNIT_TARGET_ALL,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	for _,unit in pairs(units) do
		FindClearSpaceForUnit( unit, unit:GetOrigin(), true )
	end

	self:PlayEffects1( tree, location )
	self:PlayEffects2( tree, location )
end

--------------------------------------------------------------------------------
-- Effects
function hoodwink_acorn_shot_lua:PlayEffects1( tree, location )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_acorn_shot_tree.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, tree )
	ParticleManager:SetParticleControl( effect_cast, 0, tree:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 1, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function hoodwink_acorn_shot_lua:PlayEffects2( tree, location )
	-- Get Resources
	local particle_cast = "particles/tree_fx/tree_simple_explosion.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, tree:GetOrigin()+Vector(1,0,0) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end