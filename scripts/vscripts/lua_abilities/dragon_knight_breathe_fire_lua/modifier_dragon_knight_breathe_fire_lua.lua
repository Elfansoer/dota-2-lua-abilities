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
modifier_dragon_knight_breathe_fire_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dragon_knight_breathe_fire_lua:IsHidden()
	return false
end

function modifier_dragon_knight_breathe_fire_lua:IsDebuff()
	return true
end

function modifier_dragon_knight_breathe_fire_lua:IsStunDebuff()
	return false
end

function modifier_dragon_knight_breathe_fire_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dragon_knight_breathe_fire_lua:OnCreated( kv )
	-- references
	self.reduction = self:GetAbility():GetSpecialValueFor( "reduction" )
end

function modifier_dragon_knight_breathe_fire_lua:OnRefresh( kv )
	-- references
	self.reduction = self:GetAbility():GetSpecialValueFor( "reduction" )	
end

function modifier_dragon_knight_breathe_fire_lua:OnRemoved()
end

function modifier_dragon_knight_breathe_fire_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dragon_knight_breathe_fire_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_dragon_knight_breathe_fire_lua:GetModifierDamageOutgoing_Percentage()
	return self.reduction
end