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
modifier_fairy_queen_whisk = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_whisk:IsHidden()
	return false
end

function modifier_fairy_queen_whisk:IsDebuff()
	return false
end

function modifier_fairy_queen_whisk:IsPurgable()
	return true
end

function modifier_fairy_queen_whisk:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_whisk:OnCreated( kv )
	-- references
	self.reduction = self:GetAbility():GetSpecialValueFor( "ally_amp" )
end

function modifier_fairy_queen_whisk:OnRefresh( kv )
	-- references
	self.reduction = self:GetAbility():GetSpecialValueFor( "ally_amp" )
end

function modifier_fairy_queen_whisk:OnRemoved()
end

function modifier_fairy_queen_whisk:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_fairy_queen_whisk:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_fairy_queen_whisk:GetModifierIncomingDamage_Percentage()
	return self.reduction
end