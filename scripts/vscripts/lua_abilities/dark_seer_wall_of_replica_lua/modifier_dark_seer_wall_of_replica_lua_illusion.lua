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
local MODIFIER_PRIORITY_MONKAGIGA_EXTEME_HYPER_ULTRA_REINFORCED_V9 = 10001

--------------------------------------------------------------------------------
modifier_dark_seer_wall_of_replica_lua_illusion = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_seer_wall_of_replica_lua_illusion:IsHidden()
	return true
end

function modifier_dark_seer_wall_of_replica_lua_illusion:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_seer_wall_of_replica_lua_illusion:OnCreated( kv )
	if not IsServer() then return end

	self:PlayEffects()
end

function modifier_dark_seer_wall_of_replica_lua_illusion:OnRefresh( kv )
	
end

function modifier_dark_seer_wall_of_replica_lua_illusion:OnRemoved()
end

function modifier_dark_seer_wall_of_replica_lua_illusion:OnDestroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dark_seer_wall_of_replica_lua_illusion:GetStatusEffectName()
	return "particles/status_fx/status_effect_dark_seer_illusion.vpcf"
end

function modifier_dark_seer_wall_of_replica_lua_illusion:StatusEffectPriority()
	return MODIFIER_PRIORITY_MONKAGIGA_EXTEME_HYPER_ULTRA_REINFORCED_V9
end

function modifier_dark_seer_wall_of_replica_lua_illusion:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end