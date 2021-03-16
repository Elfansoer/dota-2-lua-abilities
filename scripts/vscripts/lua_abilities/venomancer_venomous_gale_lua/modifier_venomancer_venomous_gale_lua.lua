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
modifier_venomancer_venomous_gale_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_venomancer_venomous_gale_lua:IsHidden()
	return false
end

function modifier_venomancer_venomous_gale_lua:IsDebuff()
	return true
end

function modifier_venomancer_venomous_gale_lua:IsStunDebuff()
	return false
end

function modifier_venomancer_venomous_gale_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_venomancer_venomous_gale_lua:OnCreated( kv )
	self.particles = self:GetAbility().particles
	self.sounds = self:GetAbility().sounds

	-- references
	self.tick_interval = self:GetAbility():GetSpecialValueFor( "tick_interval" )
	self.tick_damage = self:GetAbility():GetSpecialValueFor( "tick_damage" )
	self.init_damage = self:GetAbility():GetSpecialValueFor( "strike_damage" )
	self.slow = self:GetAbility():GetSpecialValueFor( "movement_slow" )
	self.slow_tick = 0.3

	if not IsServer() then return end

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.init_damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}

	-- init damage
	ApplyDamage( self.damageTable )

	-- set tick damage
	self.damageTable.damage = self.tick_damage

	-- Start interval
	self:StartIntervalThink( self.tick_interval )
end

function modifier_venomancer_venomous_gale_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_venomancer_venomous_gale_lua:OnRemoved()
end

function modifier_venomancer_venomous_gale_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_venomancer_venomous_gale_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_venomancer_venomous_gale_lua:GetModifierMoveSpeedBonus_Percentage()
	local time = (GameRules:GetGameTime()-self:GetLastAppliedTime())

	local slow = math.min( 0, self.slow + time/self.slow_tick )

	return slow
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_venomancer_venomous_gale_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SPECIALLY_DENIABLE] = self:GetParent():GetHealthPercent()<25,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_venomancer_venomous_gale_lua:OnIntervalThink()
	ApplyDamage( self.damageTable )

	-- overhead damage info
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
		self:GetParent(),
		self.damageTable.damage,
		self:GetCaster():GetPlayerOwner()
	)
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_venomancer_venomous_gale_lua:GetEffectName()
	return self.particles[3]
end

function modifier_venomancer_venomous_gale_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end