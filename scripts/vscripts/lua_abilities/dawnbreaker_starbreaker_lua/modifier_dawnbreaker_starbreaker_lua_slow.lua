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
modifier_dawnbreaker_starbreaker_lua_slow = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_starbreaker_lua_slow:IsHidden()
	return false
end

function modifier_dawnbreaker_starbreaker_lua_slow:IsDebuff()
	return true
end

function modifier_dawnbreaker_starbreaker_lua_slow:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_starbreaker_lua_slow:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "swipe_slow" )

	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )
end

function modifier_dawnbreaker_starbreaker_lua_slow:OnRefresh( kv )
	
end

function modifier_dawnbreaker_starbreaker_lua_slow:OnRemoved()
end

function modifier_dawnbreaker_starbreaker_lua_slow:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dawnbreaker_starbreaker_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_dawnbreaker_starbreaker_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end