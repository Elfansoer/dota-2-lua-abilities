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
modifier_red_transistor_jaunt_manacost = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_jaunt_manacost:IsHidden()
	return true
end

function modifier_red_transistor_jaunt_manacost:IsDebuff()
	return false
end

function modifier_red_transistor_jaunt_manacost:IsPurgable()
	return false
end

function modifier_red_transistor_jaunt_manacost:RemoveOnDeath()
	return false
end

function modifier_red_transistor_jaunt_manacost:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_jaunt_manacost:OnCreated( kv )
	if not IsServer() then return end

	self.manacost = kv.manacost
	self:SetHasCustomTransmitterData( true )
end

function modifier_red_transistor_jaunt_manacost:OnRefresh( kv )
end

function modifier_red_transistor_jaunt_manacost:OnRemoved()
end

function modifier_red_transistor_jaunt_manacost:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter Data
function modifier_red_transistor_jaunt_manacost:AddCustomTransmitterData( )
	-- on server
	local data = {
		manacost = self.manacost,
	}

	return data
end

function modifier_red_transistor_jaunt_manacost:HandleCustomTransmitterData( data )
	-- on client
	self.manacost = data.manacost or 0
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_jaunt_manacost:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE,
	}

	return funcs
end

function modifier_red_transistor_jaunt_manacost:GetModifierPercentageManacost( params )
	if params.ability == self:GetAbility() then
		return self.manacost
	end

	return 0
end
