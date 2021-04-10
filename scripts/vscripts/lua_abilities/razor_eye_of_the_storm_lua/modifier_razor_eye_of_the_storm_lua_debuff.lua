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
modifier_razor_eye_of_the_storm_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_eye_of_the_storm_lua_debuff:IsHidden()
	return false
end

function modifier_razor_eye_of_the_storm_lua_debuff:IsDebuff()
	return true
end

function modifier_razor_eye_of_the_storm_lua_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_razor_eye_of_the_storm_lua_debuff:OnCreated( kv )
	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	self.armor = kv.armor
	self:SetStackCount( self.armor )
end

function modifier_razor_eye_of_the_storm_lua_debuff:OnRefresh( kv )
	if not IsServer() then return end
	self.armor = self.armor + kv.armor
	self:SetStackCount( self.armor )
end

function modifier_razor_eye_of_the_storm_lua_debuff:OnRemoved()
end

function modifier_razor_eye_of_the_storm_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_razor_eye_of_the_storm_lua_debuff:AddCustomTransmitterData()
	-- on server
	local data = {
		armor = self.armor
	}

	return data
end

function modifier_razor_eye_of_the_storm_lua_debuff:HandleCustomTransmitterData( data )
	-- on client
	self.armor = data.armor
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_eye_of_the_storm_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_razor_eye_of_the_storm_lua_debuff:GetModifierPhysicalArmorBonus()
	return -self.armor
end