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
modifier_dragon_knight_elder_dragon_form_lua_frost = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dragon_knight_elder_dragon_form_lua_frost:IsHidden()
	return false
end

function modifier_dragon_knight_elder_dragon_form_lua_frost:IsDebuff()
	return true
end

function modifier_dragon_knight_elder_dragon_form_lua_frost:IsStunDebuff()
	return false
end

function modifier_dragon_knight_elder_dragon_form_lua_frost:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dragon_knight_elder_dragon_form_lua_frost:OnCreated( kv )
	-- references
	self.frost_as = self:GetAbility():GetSpecialValueFor( "frost_bonus_attack_speed" )
	self.frost_ms = self:GetAbility():GetSpecialValueFor( "frost_bonus_movement_speed" )

	local level = self:GetAbility():GetLevel()
	if self:GetCaster():HasScepter() then
		level = level + 1
	end
	if level==4 then
		self.frost_as = self.frost_as*1.5
		self.frost_ms = self.frost_ms*1.5
	end

end

function modifier_dragon_knight_elder_dragon_form_lua_frost:OnRefresh( kv )
	-- references
	self.frost_as = self:GetAbility():GetSpecialValueFor( "frost_bonus_attack_speed" )
	self.frost_ms = self:GetAbility():GetSpecialValueFor( "frost_bonus_movement_speed" )	
end

function modifier_dragon_knight_elder_dragon_form_lua_frost:OnRemoved()
end

function modifier_dragon_knight_elder_dragon_form_lua_frost:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dragon_knight_elder_dragon_form_lua_frost:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_dragon_knight_elder_dragon_form_lua_frost:GetModifierMoveSpeedBonus_Percentage()
	return self.frost_ms
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:GetModifierAttackSpeedBonus_Constant()
	return self.frost_as
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dragon_knight_elder_dragon_form_lua_frost:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end