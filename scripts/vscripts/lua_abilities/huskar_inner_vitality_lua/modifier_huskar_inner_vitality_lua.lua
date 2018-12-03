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
modifier_huskar_inner_vitality_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_huskar_inner_vitality_lua:IsHidden()
	return false
end

function modifier_huskar_inner_vitality_lua:IsDebuff()
	return false
end

function modifier_huskar_inner_vitality_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_huskar_inner_vitality_lua:OnCreated( kv )
	-- references
	self.heal_base = self:GetAbility():GetSpecialValueFor( "heal" )
	self.heal_attrib = self:GetAbility():GetSpecialValueFor( "attrib_bonus" )
	self.heal_hurt = self:GetAbility():GetSpecialValueFor( "hurt_attrib_bonus" )
	self.hurt_threshold = self:GetAbility():GetSpecialValueFor( "hurt_percent" ) * 100

	if IsServer() then
		self.primary = self:GetParent():GetPrimaryAttribute()
	end
end

function modifier_huskar_inner_vitality_lua:OnRefresh( kv )
	-- references
	self.heal_base = self:GetAbility():GetSpecialValueFor( "heal" )
	self.heal_attrib = self:GetAbility():GetSpecialValueFor( "attrib_bonus" )
	self.heal_hurt = self:GetAbility():GetSpecialValueFor( "hurt_attrib_bonus" )
	self.hurt_threshold = self:GetAbility():GetSpecialValueFor( "hurt_percent" )	
end

function modifier_huskar_inner_vitality_lua:OnRemoved()
end

function modifier_huskar_inner_vitality_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_huskar_inner_vitality_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

function modifier_huskar_inner_vitality_lua:GetModifierConstantHealthRegen()
	if IsServer() then
		local attrib = self:GetParent():GetPrimaryStatValue()
		local heal = self.heal_base + self.heal_attrib*attrib
		if self:GetParent():GetHealthPercent()<self.hurt_threshold then
			heal = self.heal_base + self.heal_hurt*attrib
		end

		-- for client info
		self:SetStackCount( heal )

		return heal
	else
		return self:GetStackCount()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_huskar_inner_vitality_lua:GetEffectName()
	return "particles/units/heroes/hero_huskar/huskar_inner_vitality.vpcf"
end

function modifier_huskar_inner_vitality_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-- function modifier_huskar_inner_vitality_lua:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_huskar_inner_vitality_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		effect_cast,
-- 		false, -- bDestroyImmediately
-- 		false, -- bStatusEffect
-- 		-1, -- iPriority
-- 		false, -- bHeroEffect
-- 		false -- bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end