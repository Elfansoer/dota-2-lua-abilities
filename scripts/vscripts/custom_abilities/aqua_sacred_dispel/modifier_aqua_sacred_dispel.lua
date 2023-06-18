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
modifier_aqua_sacred_dispel = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_aqua_sacred_dispel:IsHidden()
	return true
end

function modifier_aqua_sacred_dispel:IsDebuff()
	return false
end

function modifier_aqua_sacred_dispel:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_aqua_sacred_dispel:OnCreated( kv )
	self.ability = self:GetAbility()

	if not IsServer() then return end

	self.filter = FilterManager:AddExecuteOrderFilter( self.OrderFilter, self )
end

function modifier_aqua_sacred_dispel:OnRefresh( kv )
end

function modifier_aqua_sacred_dispel:OnRemoved()
end

function modifier_aqua_sacred_dispel:OnDestroy()
	if not IsServer() then return end
	FilterManager:RemoveExecuteOrderFilter( self.filter )
end

function modifier_aqua_sacred_dispel:OrderFilter( params )
	if
		(not self.lock) and
		params.order_type==DOTA_UNIT_ORDER_CAST_NO_TARGET and
		self.ability:entindex()==params.entindex_ability
	then
		self.lock = true
		self.ability:CastAbility()
		self.lock = false
		return false
	end
	
	return true
end