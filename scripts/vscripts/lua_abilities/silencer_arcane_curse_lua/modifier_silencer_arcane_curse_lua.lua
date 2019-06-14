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
modifier_silencer_arcane_curse_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_silencer_arcane_curse_lua:IsHidden()
	return false
end

function modifier_silencer_arcane_curse_lua:IsDebuff()
	return true
end

function modifier_silencer_arcane_curse_lua:IsStunDebuff()
	return false
end

function modifier_silencer_arcane_curse_lua:IsPurgable()
	return true
end

function modifier_silencer_arcane_curse_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_silencer_arcane_curse_lua:OnCreated( kv )
	-- references
	self.penalty = self:GetAbility():GetSpecialValueFor( "penalty_duration" )
	self.slow = self:GetAbility():GetSpecialValueFor( "movespeed" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )

	if not IsServer() then return end
	self.interval = 1

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( self.interval )

	-- play effects
	local sound_cast = "Hero_Silencer.Curse.Impact"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_silencer_arcane_curse_lua:OnRefresh( kv )
	
end

function modifier_silencer_arcane_curse_lua:OnRemoved()
end

function modifier_silencer_arcane_curse_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_silencer_arcane_curse_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,

		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_silencer_arcane_curse_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_silencer_arcane_curse_lua:OnAbilityFullyCast( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end
	if params.ability:IsItem() then return end

	-- extend duration
	self:SetDuration( self:GetRemainingTime() + self.penalty, true )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_silencer_arcane_curse_lua:OnIntervalThink()
	-- pause if silenced
	if self:GetParent():IsSilenced() then
		-- extend duration by interval
		self:SetDuration( self:GetRemainingTime() + self.interval, true )
		return
	end

	-- damage
	ApplyDamage( self.damageTable )

	-- play effect
	local sound_cast = "Hero_Silencer.Curse_Tick"
	EmitSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_silencer_arcane_curse_lua:GetEffectName()
	return "particles/units/heroes/hero_silencer/silencer_curse.vpcf"
end

function modifier_silencer_arcane_curse_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end