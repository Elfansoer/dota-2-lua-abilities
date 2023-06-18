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
modifier_darkness_vanguard = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_darkness_vanguard:IsHidden()
	return true
end

function modifier_darkness_vanguard:IsDebuff()
	return false
end

function modifier_darkness_vanguard:IsPurgable()
	return false
end

function modifier_darkness_vanguard:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_darkness_vanguard:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.min_miss = self:GetAbility():GetSpecialValueFor( "min_miss" )
	self.max_miss = self:GetAbility():GetSpecialValueFor( "max_miss" )
	self.heal_pct = self:GetAbility():GetSpecialValueFor( "heal_pct" )
	self.damage_pct = self:GetAbility():GetSpecialValueFor( "outgoing_pct" )

	if not IsServer() then return end
end

function modifier_darkness_vanguard:OnRefresh( kv )
	-- references
	self.min_miss = self:GetAbility():GetSpecialValueFor( "min_miss" )
	self.max_miss = self:GetAbility():GetSpecialValueFor( "max_miss" )
	self.heal_pct = self:GetAbility():GetSpecialValueFor( "heal_pct" )
	self.damage_pct = self:GetAbility():GetSpecialValueFor( "outgoing_pct" )
end

function modifier_darkness_vanguard:OnRemoved()
end

function modifier_darkness_vanguard:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_darkness_vanguard:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_darkness_vanguard:OnAttackFail( params )
	if params.attacker~=self.parent then return end

	self.parent:Heal(params.damage, self.ability)
	self:PlayEffects( self.parent )
end

function modifier_darkness_vanguard:GetModifierMiss_Percentage()
	if not IsServer() then return end
	return math.min( math.max( self.min_miss, 100-self.parent:GetHealthPercent() ), self.max_miss )
end

function modifier_darkness_vanguard:GetModifierDamageOutgoing_Percentage()
	return self.damage_pct
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_darkness_vanguard:CheckState()
	local state = {
		[MODIFIER_STATE_CANNOT_MISS] = false,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_darkness_vanguard:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end