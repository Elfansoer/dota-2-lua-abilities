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
modifier_hwei_stirring_lights = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hwei_stirring_lights:IsHidden()
	return false
end

function modifier_hwei_stirring_lights:IsDebuff()
	return false
end

function modifier_hwei_stirring_lights:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_stirring_lights:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.instances = self:GetAbility():GetSpecialValueFor( "instances" )
	self.linger = self:GetAbility():GetSpecialValueFor( "linger" )
	self.damage_to_mana_pct = self:GetAbility():GetSpecialValueFor( "damage_to_mana_pct" )

	if not IsServer() then return end

	self.ability_table = {}
	self:SetStackCount( self.instances )

	self:PlayEffects()
end

function modifier_hwei_stirring_lights:OnRefresh( kv )
	self:OnCreated(kv)
end

function modifier_hwei_stirring_lights:OnRemoved()
end

function modifier_hwei_stirring_lights:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hwei_stirring_lights:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_hwei_stirring_lights:OnTakeDamage( params )
	if params.attacker~=self.parent then return end
	if params.unit==self.parent then return end
	if not params.inflictor then return end

	-- check if damage from this ability is the first instance,
	-- or first instance has elapsed more than linger time
	local current_time = GameRules:GetGameTime()
	local first_inflicted = self.ability_table[ params.inflictor ] or 0

	if current_time > first_inflicted + self.linger then
		-- register new ability to mana steal
		if self:GetStackCount()>0 then
			self.ability_table[ params.inflictor ] = current_time
			self:DecrementStackCount()

			if self:GetStackCount()<=0 then
				self:SetDuration( self.linger, false )
			end
		end
	end

	-- only mana steal from registered ability
	if self.ability_table[ params.inflictor ] then
		local mana = params.damage * self.damage_to_mana_pct/100
		self.parent:GiveMana( mana )		

		self:PlayEffectsMana()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hwei_stirring_lights:ShouldUseOverheadOffset()
	return true
end

function modifier_hwei_stirring_lights:GetStatusEffectName()
	return "particles/status_fx/status_effect_marci_sidekick.vpcf"
end

function modifier_hwei_stirring_lights:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_hwei_stirring_lights:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_sidekick_self_buff.vpcf"
	local sound_target = "Hero_Marci.Guardian.Applied"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetOrigin() )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		1, -- iPriority
		false, -- bHeroEffect
		true -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_target, self.parent )
end

function modifier_hwei_stirring_lights:PlayEffectsMana()
	local particle_cast = "particles/items3_fx/octarine_core_lifesteal.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end