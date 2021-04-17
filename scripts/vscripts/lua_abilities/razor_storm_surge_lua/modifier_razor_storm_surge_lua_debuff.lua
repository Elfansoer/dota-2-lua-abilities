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
modifier_razor_storm_surge_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_storm_surge_lua_debuff:IsHidden()
	return false
end

function modifier_razor_storm_surge_lua_debuff:IsDebuff()
	return true
end

function modifier_razor_storm_surge_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_razor_storm_surge_lua_debuff:OnCreated( kv )
	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	self.slow = kv.slow
end

function modifier_razor_storm_surge_lua_debuff:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_razor_storm_surge_lua_debuff:OnRemoved()
end

function modifier_razor_storm_surge_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_razor_storm_surge_lua_debuff:AddCustomTransmitterData()
	-- on server
	local data = {
		slow = self.slow
	}

	return data
end

function modifier_razor_storm_surge_lua_debuff:HandleCustomTransmitterData( data )
	-- on client
	self.slow = data.slow
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_storm_surge_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_razor_storm_surge_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end