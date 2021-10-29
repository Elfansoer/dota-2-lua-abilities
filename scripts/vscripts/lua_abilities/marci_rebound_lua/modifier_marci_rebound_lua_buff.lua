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
modifier_marci_rebound_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_marci_rebound_lua_buff:IsHidden()
	return false
end

function modifier_marci_rebound_lua_buff:IsDebuff()
	return false
end

function modifier_marci_rebound_lua_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_marci_rebound_lua_buff:OnCreated( kv )
	-- references
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "ally_movespeed_pct" )

	if not IsServer() then return end

	-- play effects
	EmitSoundOn( "Hero_Marci.Rebound.Ally", self:GetParent() )

end

function modifier_marci_rebound_lua_buff:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_marci_rebound_lua_buff:OnRemoved()
end

function modifier_marci_rebound_lua_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_marci_rebound_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_marci_rebound_lua_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_marci_rebound_lua_buff:GetEffectName()
	return "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf"
end

function modifier_marci_rebound_lua_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end