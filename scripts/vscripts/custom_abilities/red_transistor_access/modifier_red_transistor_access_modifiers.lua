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
modifier_red_transistor_access_modifiers = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_access_modifiers:IsHidden()
	return true
end

function modifier_red_transistor_access_modifiers:IsDebuff()
	return false
end

function modifier_red_transistor_access_modifiers:IsPurgable()
	return false
end

function modifier_red_transistor_access_modifiers:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_red_transistor_access_modifiers:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_access_modifiers:OnCreated( kv )
	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	self.slot_type = kv.slot_type
	self:GetAbility().passive = kv.slot_type=="passive"
end

function modifier_red_transistor_access_modifiers:OnRefresh( kv )
	
end

function modifier_red_transistor_access_modifiers:OnRemoved()
end

function modifier_red_transistor_access_modifiers:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_red_transistor_access_modifiers:AddCustomTransmitterData()
	-- on server
	local data = {
		slot_type = self.slot_type
	}

	return data
end

function modifier_red_transistor_access_modifiers:HandleCustomTransmitterData( data )
	-- on client
	self.slot_type = data.slot_type

	self:GetAbility().passive = data.slot_type=="passive"
end
