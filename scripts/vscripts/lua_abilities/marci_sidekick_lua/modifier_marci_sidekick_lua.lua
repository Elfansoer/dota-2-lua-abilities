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
modifier_marci_sidekick_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_marci_sidekick_lua:IsHidden()
	return false
end

function modifier_marci_sidekick_lua:IsDebuff()
	return false
end

function modifier_marci_sidekick_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_marci_sidekick_lua:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.lifesteal = self:GetAbility():GetSpecialValueFor( "lifesteal_pct" )/100

	if not IsServer() then return end

	-- play effects
	self:PlayEffects1()
end

function modifier_marci_sidekick_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_marci_sidekick_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_marci_sidekick_lua:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end

	if params.target:GetTeamNumber()==self.parent:GetTeamNumber() then return end
	if params.target:IsBuilding() or params.target:IsOther() then return end

	self.attack_record = params.record
end

function modifier_marci_sidekick_lua:OnTakeDamage( params )
	if not IsServer() then return end
	if self.attack_record ~= params.record then return end

	-- get heal value
	local heal = params.damage * self.lifesteal
	self.parent:Heal( heal, self.ability )
	self:PlayEffects2()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_marci_sidekick_lua:GetEffectName()
-- 	return "particles/units/heroes/hero_marci/marci_sidekick_buff.vpcf"
-- end

-- function modifier_marci_sidekick_lua:GetEffectAttachType()
-- 	return PATTACH_OVERHEAD_FOLLOW
-- end

function modifier_marci_sidekick_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_marci_sidekick.vpcf"
end

function modifier_marci_sidekick_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_marci_sidekick_lua:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_marci_sidekick_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_sidekick_self_buff.vpcf"
	if self.parent~=self.caster then
		particle_cast = "particles/units/heroes/hero_marci/marci_sidekick_buff.vpcf"
	end

	local sound_target = "Hero_Marci.Guardian.Applied"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetOrigin() )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_target, self.parent )
end