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
modifier_spirit_breaker_nether_strike_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spirit_breaker_nether_strike_lua:IsHidden()
	if IsClient() then
		return GetLocalPlayerTeam()~=self:GetCaster():GetTeamNumber()
	end

	return true
end

function modifier_spirit_breaker_nether_strike_lua:IsDebuff()
	return true
end

function modifier_spirit_breaker_nether_strike_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spirit_breaker_nether_strike_lua:OnCreated( kv )
	if not IsServer() then return end
end

function modifier_spirit_breaker_nether_strike_lua:OnRefresh( kv )
	
end

function modifier_spirit_breaker_nether_strike_lua:OnRemoved()
end

function modifier_spirit_breaker_nether_strike_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spirit_breaker_nether_strike_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}

	return funcs
end

function modifier_spirit_breaker_nether_strike_lua:GetModifierProvidesFOWVision()
	return 1
end