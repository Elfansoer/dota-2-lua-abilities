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
modifier_maple_devour_active = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_devour_active:IsHidden()
	return true
end

function modifier_maple_devour_active:IsDebuff()
	return false
end

function modifier_maple_devour_active:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_devour_active:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.mana_pct = self:GetAbility():GetSpecialValueFor( "mana_conversion" )
	self.mana_duration = self:GetAbility():GetSpecialValueFor( "mana_duration" )

	if not IsServer() then return end
end

function modifier_maple_devour_active:OnRefresh( kv )
	-- references
	self.mana_pct = self:GetAbility():GetSpecialValueFor( "mana_conversion" )
	self.mana_duration = self:GetAbility():GetSpecialValueFor( "mana_duration" )	
end

function modifier_maple_devour_active:OnRemoved()
end

function modifier_maple_devour_active:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_maple_devour_active:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_maple_devour_active:GetModifierIncomingDamage_Percentage( params )
	if not IsServer() then return 0 end

	if params.attacker:GetTeamNumber()~=self.parent:GetTeamNumber() then
		local mana = math.ceil(params.damage * self.mana_pct/100)
		local mana_excess = mana + self.parent:GetMana() - self.parent:GetMaxMana()

		-- create mana crystals if excess
		if mana_excess > 0 then
			self.parent:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_maple_devour_crystal",
				{
					duration = self.mana_duration,
					mana = mana_excess,
				}
			)	
		end
		
		self:GetParent():GiveMana(mana)
	
		-- use charges
		self.ability:CastAbility()
	
		-- if no more charges, turn off
		if self.ability:GetCurrentAbilityCharges() < 1 and self.ability:GetToggleState() then
			self.ability:ToggleAbility()
		end

		self:PlayEffects( params.damage )

		return -100
	end

	return 0
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_maple_devour_active:GetEffectName()
	return "particles/units/heroes/hero_medusa/medusa_mana_shield.vpcf"
end

function modifier_maple_devour_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_maple_devour_active:PlayEffects( damage )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_medusa/medusa_mana_shield_impact.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( damage, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end