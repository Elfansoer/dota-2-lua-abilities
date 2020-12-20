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

--[[
NOTE:
- Difference: can use Stop command instead to launch early.
- No projectile sound, don't want to create dummy just for sound
]]

--------------------------------------------------------------------------------
hoodwink_sharpshooter_lua = class({})
LinkLuaModifier( "modifier_generic_knockback_lua", "lua_abilities/generic/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_hoodwink_sharpshooter_lua", "lua_abilities/hoodwink_sharpshooter_lua/modifier_hoodwink_sharpshooter_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hoodwink_sharpshooter_lua_debuff", "lua_abilities/hoodwink_sharpshooter_lua/modifier_hoodwink_sharpshooter_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hoodwink_sharpshooter_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_hoodwink.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_impact.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_target.vpcf", context )
	PrecacheResource( "particle", "particles/items_fx/force_staff.vpcf", context )
end

function hoodwink_sharpshooter_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function hoodwink_sharpshooter_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor( "misfire_time" )

	-- add secondary ability if doesn't exist
	if not caster:FindAbilityByName( "hoodwink_sharpshooter_release_lua" ) then
		local ability = caster:AddAbility( "hoodwink_sharpshooter_release_lua" )
		ability:SetLevel( 1 )
	end

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_hoodwink_sharpshooter_lua", -- modifier name
		{
			duration = duration,
			x = point.x,
			y = point.y,
		} -- kv
	)
end
--------------------------------------------------------------------------------
-- Projectile
function hoodwink_sharpshooter_lua:OnProjectileHit_ExtraData( target, location, ExtraData )
	if not target then return end

	local caster = self:GetCaster()

	-- damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = ExtraData.damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
	}
	ApplyDamage(damageTable)

	-- modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_hoodwink_sharpshooter_lua_debuff", -- modifier name
		{
			duration = ExtraData.duration,
			x = ExtraData.x,
			y = ExtraData.y
		} -- kv
	)


	-- play effects
	local direction = Vector( ExtraData.x, ExtraData.y, 0 ):Normalized()
	self:PlayEffects( target, direction )

	return true
end

--------------------------------------------------------------------------------
-- Effects
function hoodwink_sharpshooter_lua:PlayEffects( target, direction )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_impact.vpcf"
	local sound_cast = "Hero_Hoodwink.Sharpshooter.Target"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 0, target:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, target:GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 1, direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end


--------------------------------------------------------------------------------
-- Secondary Ability
hoodwink_sharpshooter_release_lua = class({})
function hoodwink_sharpshooter_release_lua:OnSpellStart()
	-- find modifier
	local mod = self:GetCaster():FindModifierByName( "modifier_hoodwink_sharpshooter_lua" )
	if not mod then return end

	mod:Destroy()
end