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
modifier_storm_spirit_overload_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_storm_spirit_overload_lua_buff:IsHidden()
	return false
end

function modifier_storm_spirit_overload_lua_buff:IsDebuff()
	return false
end

function modifier_storm_spirit_overload_lua_buff:IsStunDebuff()
	return false
end

function modifier_storm_spirit_overload_lua_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_storm_spirit_overload_lua_buff:OnCreated( kv )
	if not IsServer() then return end
	self:PlayEffects()
end

function modifier_storm_spirit_overload_lua_buff:OnRefresh( kv )
end

function modifier_storm_spirit_overload_lua_buff:OnRemoved()
end

function modifier_storm_spirit_overload_lua_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_storm_spirit_overload_lua_buff:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_overload_ambient.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end