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
modifier_razor_plasma_field_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_plasma_field_lua:IsHidden()
	return false
end

function modifier_razor_plasma_field_lua:IsDebuff()
	return true
end

function modifier_razor_plasma_field_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_razor_plasma_field_lua:OnCreated( kv )
	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	-- references
	self.slow = kv.slow
	self:SetStackCount( self.slow )
end

function modifier_razor_plasma_field_lua:OnRefresh( kv )
	if not IsServer() then return end
	-- references
	self.slow = math.max(kv.slow,self.slow)
	self:SetStackCount( self.slow )
end

function modifier_razor_plasma_field_lua:OnRemoved()
end

function modifier_razor_plasma_field_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_razor_plasma_field_lua:AddCustomTransmitterData()
	-- on server
	local data = {
		slow = self.slow
	}

	return data
end

function modifier_razor_plasma_field_lua:HandleCustomTransmitterData( data )
	-- on client
	self.slow = data.slow
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_plasma_field_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_razor_plasma_field_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end