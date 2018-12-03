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
modifier_huskar_berserkers_blood_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_huskar_berserkers_blood_lua:IsHidden()
	return true
end

function modifier_huskar_berserkers_blood_lua:IsDebuff()
	return false
end

function modifier_huskar_berserkers_blood_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_huskar_berserkers_blood_lua:OnCreated( kv )
	-- references
	self.max_as = self:GetAbility():GetSpecialValueFor( "maximum_attack_speed" )
	self.max_mr = self:GetAbility():GetSpecialValueFor( "maximum_resistance" )
	self.max_threshold = self:GetAbility():GetSpecialValueFor( "hp_threshold_max" )
	self.range = 100-self.max_threshold
	self.max_size = 35

	-- effects
	self:PlayEffects()
end

function modifier_huskar_berserkers_blood_lua:OnRefresh( kv )
	-- references
	self.max_as = self:GetAbility():GetSpecialValueFor( "maximum_attack_speed" )
	self.max_mr = self:GetAbility():GetSpecialValueFor( "maximum_resistance" )
	self.max_threshold = self:GetAbility():GetSpecialValueFor( "hp_threshold_max" )	
	self.range = 100-self.max_threshold
end

function modifier_huskar_berserkers_blood_lua:OnRemoved()
end

function modifier_huskar_berserkers_blood_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_huskar_berserkers_blood_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}

	return funcs
end

function modifier_huskar_berserkers_blood_lua:GetModifierMagicalResistanceBonus()
	-- interpolate missing health
	local pct = math.max((self:GetParent():GetHealthPercent()-self.max_threshold)/self.range,0)
	return (1-pct)*self.max_mr
end

function modifier_huskar_berserkers_blood_lua:GetModifierAttackSpeedBonus_Constant()
	-- interpolate missing health
	local pct = math.max((self:GetParent():GetHealthPercent()-self.max_threshold)/self.range,0)
	return (1-pct)*self.max_as
end


function modifier_huskar_berserkers_blood_lua:GetModifierModelScale()
	if IsServer() then
		local pct = math.max((self:GetParent():GetHealthPercent()-self.max_threshold)/self.range,0)

		-- set dynamic effects
		ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( (1-pct)*100,0,0 ) )

		return (1-pct)*self.max_size
	end
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_huskar_berserkers_blood_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_huskar/huskar_berserkers_blood_glow.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

	-- buff particle
	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end