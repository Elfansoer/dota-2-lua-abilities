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
modifier_fairy_queen_quell = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_quell:IsHidden()
	return false
end

function modifier_fairy_queen_quell:IsDebuff()
	return false
end

function modifier_fairy_queen_quell:IsPurgable()
	return true
end

function modifier_fairy_queen_quell:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_quell:OnCreated( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "as_bonus" )
end

function modifier_fairy_queen_quell:OnRefresh( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "as_bonus" )
end

function modifier_fairy_queen_quell:OnRemoved()
end

function modifier_fairy_queen_quell:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_fairy_queen_quell:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_fairy_queen_quell:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end