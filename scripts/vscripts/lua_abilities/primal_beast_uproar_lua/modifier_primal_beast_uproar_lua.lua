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
modifier_primal_beast_uproar_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_primal_beast_uproar_lua:IsHidden()
	return self:GetStackCount()<1
end

function modifier_primal_beast_uproar_lua:IsDebuff()
	return false
end

function modifier_primal_beast_uproar_lua:IsPurgable()
	return false
end

-- Optional Classifications
function modifier_primal_beast_uproar_lua:RemoveOnDeath()
	return false
end

function modifier_primal_beast_uproar_lua:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_primal_beast_uproar_lua:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.damage_limit = self:GetAbility():GetSpecialValueFor( "damage_limit" )
	self.stack_limit = self:GetAbility():GetSpecialValueFor( "stack_limit" )
	self.duration = self:GetAbility():GetSpecialValueFor( "stack_duration" )
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )

	if not IsServer() then return end
end

function modifier_primal_beast_uproar_lua:OnRefresh( kv )
	-- references
	self.damage_limit = self:GetAbility():GetSpecialValueFor( "damage_limit" )
	self.stack_limit = self:GetAbility():GetSpecialValueFor( "stack_limit" )
	self.duration = self:GetAbility():GetSpecialValueFor( "stack_duration" )	
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
end

function modifier_primal_beast_uproar_lua:OnRemoved()
end

function modifier_primal_beast_uproar_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_primal_beast_uproar_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

function modifier_primal_beast_uproar_lua:OnTakeDamage( params )
	if self.parent:PassivesDisabled() then return end
	if self.parent:HasModifier( "modifier_primal_beast_uproar_lua_buff" ) then return end

	if params.unit~=self.parent then return end
	if not params.attacker:IsConsideredHero() then return end

	-- increment stack, refresh duration
	if self:GetStackCount()<self.stack_limit then
		self:IncrementStackCount()

		-- roar
		if self:GetStackCount()==self.stack_limit then
			EmitSoundOn( "Hero_PrimalBeast.Uproar.MaxStacks", self.parent )
		end
	end
	self:SetDuration( self.duration, true )
	self:StartIntervalThink(self.duration)
end

function modifier_primal_beast_uproar_lua:GetModifierPreAttack_BonusDamage()
	return self.damage
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_primal_beast_uproar_lua:OnIntervalThink()
	self:ResetStack()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_primal_beast_uproar_lua:ResetStack()
	self:SetStackCount(0)
end