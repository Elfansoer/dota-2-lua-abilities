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
pudge_meat_hook_lua = class({})
LinkLuaModifier( "modifier_pudge_meat_hook_lua", "lua_abilities/pudge_meat_hook_lua/modifier_pudge_meat_hook_lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_pudge_meat_hook_lua_self", "lua_abilities/pudge_meat_hook_lua/modifier_pudge_meat_hook_lua_self", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function pudge_meat_hook_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_pudge.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_pudge/pudge_meathook.vpcf", context )
end

function pudge_meat_hook_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function pudge_meat_hook_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local projectile_name = ""
	local projectile_distance = self:GetSpecialValueFor( "hook_distance" )
	local projectile_speed = self:GetSpecialValueFor( "hook_speed" )
	local projectile_radius = self:GetSpecialValueFor( "hook_width" )

	-- calculate direction
	local origin = caster:GetOrigin()
	local dir = point - origin
	dir.z = 0
	local projectile_direction = dir:Normalized()

	-- calculate target
	local target = origin + projectile_direction * projectile_distance

	-- create projectiles
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
	
		bDeleteOnHit = true,
	
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	
		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = projectile_radius,
		fEndRadius = projectile_radius,
		vVelocity = projectile_direction * projectile_speed,
	}
	local id = ProjectileManager:CreateLinearProjectile(info)

	-- create projectile data
	local data = {}
	data.cast_location = origin
	self.projectiles[id] = data

	-- add self stun modifier
	local duration = projectile_distance/projectile_speed
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_pudge_meat_hook_lua_self", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	self:PlayEffects( target, data )
end

--------------------------------------------------------------------------------
-- Projectile
pudge_meat_hook_lua.projectiles = {}
function pudge_meat_hook_lua:OnProjectileHitHandle( target, location, handle )
	local data = self.projectiles[handle]
	if not data then return true end

	if not target then
		-- remove ref
		self.projectiles[handle] = nil

		-- set effects
		self:SetEffects1( data )

		return true
	end

	if target==self:GetCaster() then
		-- pass
		return false
	end

	-- add drag modifier
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_pudge_meat_hook_lua", -- modifier name
		{ handle = handle } -- kv
	)

	-- damage
	if target:GetTeamNumber()~=self:GetCaster():GetTeamNumber() then
		local damage = self:GetSpecialValueFor( "damage" )
		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)

		if target:IsCreep() and not target:IsCreepHero() and not target:IsAncient() then
			target:Kill( self, self:GetCaster() )
		end
	end

	-- add FOW
	local radius = self:GetSpecialValueFor( "vision_radius" )
	local duration = self:GetSpecialValueFor( "vision_duration" )
	AddFOWViewer( self:GetCaster():GetTeamNumber(), target:GetOrigin(), radius, duration, false )

	-- set effects
	self:SetEffects2( data, target )

	return true
end

--------------------------------------------------------------------------------
-- Effects
function pudge_meat_hook_lua:PlayEffects( point, data )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_pudge/pudge_meathook.vpcf"
	local sound_cast = "Hero_Pudge.AttackHookExtend"

	-- Get Data
	local speed = self:GetSpecialValueFor( "hook_speed" )
	local distance = self:GetSpecialValueFor( "hook_distance" )
	local radius = self:GetSpecialValueFor( "hook_width" )
	local duration = distance/speed * 2

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( speed, distance, radius ) )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( duration, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 4, Vector( 1, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 5, Vector( 0, 0, 0 ) )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		7,
		self:GetCaster(),
		PATTACH_CUSTOMORIGIN,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleAlwaysSimulate( effect_cast )
	ParticleManager:SetParticleShouldCheckFoW( effect_cast, false )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )

	-- store effect
	data.effect_cast = effect_cast
end

function pudge_meat_hook_lua:SetEffects1( data )
	-- set return effect
	ParticleManager:SetParticleControlEnt(
		data.effect_cast,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( data.effect_cast )

	EmitSoundOn( "Hero_Pudge.AttackHookRetract", self:GetCaster() )
end

function pudge_meat_hook_lua:SetEffects2( data, target )
	-- set effects
	ParticleManager:SetParticleControlEnt(
		data.effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( data.effect_cast, 4, Vector( 0, 0, 0 ) )
	ParticleManager:SetParticleControl( data.effect_cast, 5, Vector( 1, 0, 0 ) )

	EmitSoundOn( "Hero_Pudge.AttackHookImpact", target )
	EmitSoundOn( "Hero_Pudge.AttackHookRetract", self:GetCaster() )
end