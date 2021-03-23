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
modifier_red_transistor_breach_castrange = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_breach_castrange:IsHidden()
	return false
end

function modifier_red_transistor_breach_castrange:IsDebuff()
	return false
end

function modifier_red_transistor_breach_castrange:IsPurgable()
	return false
end

function modifier_red_transistor_breach_castrange:RemoveOnDeath()
	return false
end

function modifier_red_transistor_breach_castrange:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_breach_castrange:OnCreated( kv )
	if not IsServer() then return end

	self.range_pct = kv.castrange
	self:SetHasCustomTransmitterData( true )
end

function modifier_red_transistor_breach_castrange:OnRefresh( kv )
end

function modifier_red_transistor_breach_castrange:OnRemoved()
end

function modifier_red_transistor_breach_castrange:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter Data
function modifier_red_transistor_breach_castrange:AddCustomTransmitterData( )
	-- on server
	local data = {
		range_pct = self.range_pct,
	}

	return data
end

function modifier_red_transistor_breach_castrange:HandleCustomTransmitterData( data )
	-- on client
	self.range_pct = data.range_pct or 0
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_breach_castrange:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
	}

	return funcs
end

function modifier_red_transistor_breach_castrange:GetModifierCastRangeBonus( params )
	if self.lock then return 0 end
	if params.ability ~= self:GetAbility() then return 0 end

	self.lock = true
	local range = self:GetAbility():GetCastRange( Vector(0,0,0), self:GetCaster() )
	self.lock = false

	range = self.range_pct/100 * range

	return range
end
