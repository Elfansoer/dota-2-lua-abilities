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
modifier_red_transistor_ping_cooldown = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_ping_cooldown:IsHidden()
	return true
end

function modifier_red_transistor_ping_cooldown:IsDebuff()
	return false
end

function modifier_red_transistor_ping_cooldown:IsPurgable()
	return false
end

function modifier_red_transistor_ping_cooldown:RemoveOnDeath()
	return false
end

function modifier_red_transistor_ping_cooldown:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_ping_cooldown:OnCreated( kv )
	if not IsServer() then return end

	self.cooldown = kv.cooldown
	self:SetHasCustomTransmitterData( true )
end

function modifier_red_transistor_ping_cooldown:OnRefresh( kv )
end

function modifier_red_transistor_ping_cooldown:OnRemoved()
end

function modifier_red_transistor_ping_cooldown:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter Data
function modifier_red_transistor_ping_cooldown:AddCustomTransmitterData( )
	-- on server
	local data = {
		cooldown = self.cooldown,
	}

	return data
end

function modifier_red_transistor_ping_cooldown:HandleCustomTransmitterData( data )
	-- on client
	self.cooldown = data.cooldown or 0
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_ping_cooldown:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}

	return funcs
end

function modifier_red_transistor_ping_cooldown:GetModifierPercentageCooldown( params )
	if params.ability == self:GetAbility() then
		return self.cooldown
	end

	return 0
end
