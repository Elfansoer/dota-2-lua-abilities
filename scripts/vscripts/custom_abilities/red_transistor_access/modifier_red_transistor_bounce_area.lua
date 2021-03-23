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
modifier_red_transistor_bounce_area = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_bounce_area:IsHidden()
	return false
end

function modifier_red_transistor_bounce_area:IsDebuff()
	return false
end

function modifier_red_transistor_bounce_area:IsStunDebuff()
	return false
end

function modifier_red_transistor_bounce_area:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_bounce_area:OnCreated( kv )
	if not IsServer() then return end
	self.area = kv
end

function modifier_red_transistor_bounce_area:OnRefresh( kv )
	
end

function modifier_red_transistor_bounce_area:OnRemoved()
end

function modifier_red_transistor_bounce_area:OnDestroy()
	if not IsServer() then return end
	self:GetAbility():ProcessArea( self.area )
	UTIL_Remove( self:GetParent() )
end