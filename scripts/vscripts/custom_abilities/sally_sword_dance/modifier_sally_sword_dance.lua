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
modifier_sally_sword_dance = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sally_sword_dance:IsHidden()
	return false
end

function modifier_sally_sword_dance:IsDebuff()
	return false
end

function modifier_sally_sword_dance:IsPurgable()
	return false
end

function modifier_sally_sword_dance:AllowIllusionDuplicate()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sally_sword_dance:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "stack_attack_speed" )
	self.evasion = self:GetAbility():GetSpecialValueFor( "stack_evasion" )
	self.max_stack = self:GetAbility():GetSpecialValueFor( "max_stack" )

	if not IsServer() then return end
end

function modifier_sally_sword_dance:OnRefresh( kv )
	-- references
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "stack_attack_speed" )
	self.evasion = self:GetAbility():GetSpecialValueFor( "stack_evasion" )	
	self.max_stack = self:GetAbility():GetSpecialValueFor( "max_stack" )
end

function modifier_sally_sword_dance:OnRemoved()
end

function modifier_sally_sword_dance:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sally_sword_dance:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_sally_sword_dance:GetModifierEvasion_Constant( params )
	return self:GetStackCount() * self.evasion
end

function modifier_sally_sword_dance:GetModifierAttackSpeedBonus_Constant( params )
	return self:GetStackCount() * self.attack_speed
end

function modifier_sally_sword_dance:OnDeath( params )
	if params.unit==self.parent then
		self:SetStackCount( 0 )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sally_sword_dance:EvadeSuccess()
	self:SetStackCount( math.min( self:GetStackCount() + 1, self.max_stack ) )
	self.ability:EndCooldown()
end

function modifier_sally_sword_dance:EvadeFail()
	self:SetStackCount( math.max( self:GetStackCount() - 1, 0 ) )
end