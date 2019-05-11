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
modifier_doom_devour_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_doom_devour_lua:IsHidden()
	return false
end

function modifier_doom_devour_lua:IsDebuff()
	return false
end

function modifier_doom_devour_lua:IsPurgable()
	return false
end

function modifier_doom_devour_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_doom_devour_lua:RemoveOnDeath()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_doom_devour_lua:OnCreated( kv )
	-- references
	self.bonus_gold = self:GetAbility():GetSpecialValueFor( "bonus_gold" )
	self.bonus_regen = self:GetAbility():GetSpecialValueFor( "regen" )
end

function modifier_doom_devour_lua:OnRefresh( kv )
	
end

function modifier_doom_devour_lua:OnRemoved()
end

function modifier_doom_devour_lua:OnDestroy()
	if not IsServer() then return end
	-- grant bonus gold if alive
	if self:GetParent():IsAlive() then
		PlayerResource:ModifyGold( self:GetParent():GetPlayerOwnerID(), self.bonus_gold, false, DOTA_ModifyGold_Unspecified )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_doom_devour_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

function modifier_doom_devour_lua:GetModifierConstantHealthRegen()
	return self.bonus_regen
end