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
modifier_underlord_atrophy_aura_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_underlord_atrophy_aura_lua_debuff:IsHidden()
	return false
end

function modifier_underlord_atrophy_aura_lua_debuff:IsDebuff()
	return true
end

function modifier_underlord_atrophy_aura_lua_debuff:IsStunDebuff()
	return false
end

function modifier_underlord_atrophy_aura_lua_debuff:IsPurgable()
	return true
end

function modifier_underlord_atrophy_aura_lua_debuff:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_underlord_atrophy_aura_lua_debuff:OnCreated( kv )
	-- references
	self.reduction = self:GetAbility():GetSpecialValueFor( "damage_reduction_pct" )

	if not IsServer() then return end
end

function modifier_underlord_atrophy_aura_lua_debuff:OnRefresh( kv )
	-- references
	self.reduction = self:GetAbility():GetSpecialValueFor( "damage_reduction_pct" )	
end

function modifier_underlord_atrophy_aura_lua_debuff:OnRemoved()
end

function modifier_underlord_atrophy_aura_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_underlord_atrophy_aura_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_underlord_atrophy_aura_lua_debuff:GetModifierBaseDamageOutgoing_Percentage( params )
	return -self.reduction
end