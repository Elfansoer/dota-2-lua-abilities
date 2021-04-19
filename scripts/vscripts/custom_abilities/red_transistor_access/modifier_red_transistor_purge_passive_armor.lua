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
modifier_red_transistor_purge_passive_armor = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_purge_passive_armor:IsHidden()
	return false
end

function modifier_red_transistor_purge_passive_armor:IsDebuff()
	return true
end

function modifier_red_transistor_purge_passive_armor:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_purge_passive_armor:OnCreated( kv )
	-- references

	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	self.armor = kv.armor
end

function modifier_red_transistor_purge_passive_armor:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_red_transistor_purge_passive_armor:OnRemoved()
end

function modifier_red_transistor_purge_passive_armor:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_red_transistor_purge_passive_armor:AddCustomTransmitterData()
	-- on server
	local data = {
		armor = self.armor
	}

	return data
end

function modifier_red_transistor_purge_passive_armor:HandleCustomTransmitterData( data )
	-- on client
	self.armor = data.armor
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_purge_passive_armor:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_red_transistor_purge_passive_armor:GetModifierPhysicalArmorBonus()
	return -self.armor
end