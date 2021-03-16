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
modifier_venomancer_poison_sting_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_venomancer_poison_sting_lua_debuff:IsHidden()
	return false
end

function modifier_venomancer_poison_sting_lua_debuff:IsDebuff()
	return true
end

function modifier_venomancer_poison_sting_lua_debuff:IsStunDebuff()
	return false
end

function modifier_venomancer_poison_sting_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_venomancer_poison_sting_lua_debuff:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()

	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.slow = self:GetAbility():GetSpecialValueFor( "movement_speed" )

	if not IsServer() then return end

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_HPLOSS, --Optional.
	}
	-- ApplyDamage(damageTable)

	self:StartIntervalThink( 1 )
	self:OnIntervalThink()
end

function modifier_venomancer_poison_sting_lua_debuff:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_venomancer_poison_sting_lua_debuff:OnRemoved()
end

function modifier_venomancer_poison_sting_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_venomancer_poison_sting_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_venomancer_poison_sting_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end


--------------------------------------------------------------------------------
-- Interval Effects
function modifier_venomancer_poison_sting_lua_debuff:OnIntervalThink()
	ApplyDamage( self.damageTable )

	-- overhead damage info
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
		self.parent,
		self.damageTable.damage,
		self.caster:GetPlayerOwner()
	)
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_venomancer_poison_sting_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_venomancer/venomancer_poison_debuff.vpcf"
end

function modifier_venomancer_poison_sting_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end