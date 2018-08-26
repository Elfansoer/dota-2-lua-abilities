grimstroke_phantoms_embrace_lua = class({})
LinkLuaModifier( "modifier_grimstroke_phantoms_embrace_lua", "lua_abilities/grimstroke_phantoms_embrace_lua/modifier_grimstroke_phantoms_embrace_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_grimstroke_phantoms_embrace_lua_thinker", "lua_abilities/grimstroke_phantoms_embrace_lua/modifier_grimstroke_phantoms_embrace_lua_thinker", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_grimstroke_phantoms_embrace_lua_target", "lua_abilities/grimstroke_phantoms_embrace_lua/modifier_grimstroke_phantoms_embrace_lua_target", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_grimstroke_phantoms_embrace_lua_debuff", "lua_abilities/grimstroke_phantoms_embrace_lua/modifier_grimstroke_phantoms_embrace_lua_debuff", LUA_MODIFIER_MOTION_NONE )
local tempTable = require("util/tempTable")
--------------------------------------------------------------------------------
-- Ability Start
function grimstroke_phantoms_embrace_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- add target modifier
	local modifier = target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_grimstroke_phantoms_embrace_lua_target", -- modifier name
		{  } -- kv
	)
	local mod = tempTable:AddATValue( modifier )

	-- create phantom
	local spawnPos = caster:GetOrigin() + caster:GetForwardVector()*150
	local phantom = CreateUnitByName( "npc_dota_grimstroke_ink_creature", spawnPos, true, nil, nil, self:GetCaster():GetTeamNumber() )

	-- add movement modifier
	phantom:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_grimstroke_phantoms_embrace_lua_thinker", -- modifier name
		{ target = mod } -- kv
	)

	-- play effects
	self:PlayEffects()
end
--------------------------------------------------------------------------------
-- Projectile
function grimstroke_phantoms_embrace_lua:OnProjectileHit( target, location )
	self:EndCooldown()

	-- play effects
	local sound_cast = "Hero_Grimstroke.InkCreature.Returned"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

--------------------------------------------------------------------------------
-- Ability Considerations
function grimstroke_phantoms_embrace_lua:AbilityConsiderations()
	-- Scepter
	local bScepter = caster:HasScepter()

	-- Linken & Lotus
	local bBlocked = target:TriggerSpellAbsorb( self )

	-- Break
	local bBroken = caster:PassivesDisabled()

	-- Advanced Status
	local bInvulnerable = target:IsInvulnerable()
	local bInvisible = target:IsInvisible()
	local bHexed = target:IsHexed()
	local bMagicImmune = target:IsMagicImmune()

	-- Illusion Copy
	local bIllusion = target:IsIllusion()
end

--------------------------------------------------------------------------------
function grimstroke_phantoms_embrace_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_cast_phantom.vpcf"
	local sound_cast = "Hero_Grimstroke.InkCreature.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end