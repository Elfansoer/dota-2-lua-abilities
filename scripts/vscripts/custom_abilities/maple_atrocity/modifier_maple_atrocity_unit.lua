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
modifier_maple_atrocity_unit = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_atrocity_unit:IsHidden()
	return true
end

function modifier_maple_atrocity_unit:IsDebuff()
	return false
end

function modifier_maple_atrocity_unit:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_atrocity_unit:OnCreated( kv )
	if not IsServer() then return end
end

function modifier_maple_atrocity_unit:OnRefresh( kv )
end

function modifier_maple_atrocity_unit:OnRemoved()
end

function modifier_maple_atrocity_unit:OnDestroy()
	if not IsServer() then return end
	self:GetParent():ForceKill( false )
	local modifier = self:GetCaster():FindModifierByName("modifier_maple_atrocity")
	if modifier then
		modifier:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_maple_atrocity_unit:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_LIFETIME_FRACTION,
	}

	return funcs
end

function modifier_maple_atrocity_unit:GetUnitLifetimeFraction( params )
	return ( ( self:GetDieTime() - GameRules:GetGameTime() ) / self:GetDuration() )
end