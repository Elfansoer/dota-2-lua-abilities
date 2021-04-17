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
modifier_spirit_breaker_charge_of_darkness_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spirit_breaker_charge_of_darkness_lua_debuff:IsHidden()
	if IsClient() then
		return GetLocalPlayerTeam()~=self:GetCaster():GetTeamNumber()
	end

	return true
end

function modifier_spirit_breaker_charge_of_darkness_lua_debuff:IsDebuff()
	return true
end

function modifier_spirit_breaker_charge_of_darkness_lua_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spirit_breaker_charge_of_darkness_lua_debuff:OnCreated( kv )
	if not IsServer() then return end
	self:PlayEffects()
end

function modifier_spirit_breaker_charge_of_darkness_lua_debuff:OnRefresh( kv )
	
end

function modifier_spirit_breaker_charge_of_darkness_lua_debuff:OnRemoved()
end

function modifier_spirit_breaker_charge_of_darkness_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spirit_breaker_charge_of_darkness_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}

	return funcs
end

function modifier_spirit_breaker_charge_of_darkness_lua_debuff:GetModifierProvidesFOWVision()
	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_spirit_breaker_charge_of_darkness_lua_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_spirit_breaker_charge_of_darkness_lua_debuff:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge_target.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent(), self:GetCaster():GetTeamNumber() )

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