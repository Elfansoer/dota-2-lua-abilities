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
modifier_maple_hydra_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_hydra_debuff:IsHidden()
	return false
end

function modifier_maple_hydra_debuff:IsDebuff()
	return true
end

function modifier_maple_hydra_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_hydra_debuff:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "slow" )

	if not IsServer() then return end

	self.dps = 0
	self.interval = 0.5

	local owner = self:GetAuraOwner()
	local modifier = owner:FindModifierByName( "modifier_maple_hydra_thinker" )
	if modifier then
		self.dps = modifier.dps
	end

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps * self.interval,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_maple_hydra_debuff:OnRefresh( kv )
end

function modifier_maple_hydra_debuff:OnRemoved()
end

function modifier_maple_hydra_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_maple_hydra_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_maple_hydra_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_maple_hydra_debuff:OnIntervalThink()
	ApplyDamage(self.damageTable)
end