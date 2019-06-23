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
modifier_alchemist_chemical_rage_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_alchemist_chemical_rage_lua:IsHidden()
	return false
end

function modifier_alchemist_chemical_rage_lua:IsDebuff()
	return false
end

function modifier_alchemist_chemical_rage_lua:IsStunDebuff()
	return false
end

function modifier_alchemist_chemical_rage_lua:IsPurgable()
	return false
end

function modifier_alchemist_chemical_rage_lua:AllowIllusionDuplicate()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_alchemist_chemical_rage_lua:OnCreated( kv )
	-- references
	self.bat = self:GetAbility():GetSpecialValueFor( "base_attack_time" )
	self.health = self:GetAbility():GetSpecialValueFor( "bonus_health" )
	self.health_regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "bonus_mana_regen" )
	self.movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movespeed" )

	if not IsServer() then return end

	-- disjoint & purge
	ProjectileManager:ProjectileDodge( self:GetParent() )
	self:GetParent():Purge( false, true, false, false, false )

	-- play effects
	self:PlayEffects()
end

function modifier_alchemist_chemical_rage_lua:OnRefresh( kv )
	-- references
	self.bat = self:GetAbility():GetSpecialValueFor( "base_attack_time" )
	self.health = self:GetAbility():GetSpecialValueFor( "bonus_health" )
	self.health_regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "bonus_mana_regen" )
	self.movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movespeed" )

	if not IsServer() then return end

	-- disjoint & purge
	ProjectileManager:ProjectileDodge( self:GetParent() )
	self:GetParent():Purge( false, true, false, false, false )
end

function modifier_alchemist_chemical_rage_lua:OnRemoved()
end

function modifier_alchemist_chemical_rage_lua:OnDestroy()
	if not IsServer() then return end

	-- stop effects
	local sound_cast = "Hero_Alchemist.ChemicalRage"
	StopSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_alchemist_chemical_rage_lua:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_alchemist_chemical_rage_lua:GetModifierBaseAttackTimeConstant()
	return self.bat
end
function modifier_alchemist_chemical_rage_lua:GetModifierConstantHealthRegen()
	return self.health_regen
end
function modifier_alchemist_chemical_rage_lua:GetModifierHealthBonus()
	return self.health
end
function modifier_alchemist_chemical_rage_lua:GetModifierConstantManaRegen()
	return self.mana_regen
end
function modifier_alchemist_chemical_rage_lua:GetModifierMoveSpeedBonus_Constant()
	return self.movespeed
end
-- --------------------------------------------------------------------------------
-- -- Status Effects
-- function modifier_alchemist_chemical_rage_lua:CheckState()
-- 	local state = {
-- 		[MODIFIER_STATE_INVULNERABLE] = true,
-- 	}

-- 	return state
-- end

-- --------------------------------------------------------------------------------
-- -- Interval Effects
-- function modifier_alchemist_chemical_rage_lua:OnIntervalThink()
-- end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_alchemist_chemical_rage_lua:GetHeroEffectName()
	return "particles/units/heroes/hero_alchemist/alchemist_chemical_rage_hero_effect.vpcf"
end

function modifier_alchemist_chemical_rage_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf"
	local sound_cast = "Hero_Alchemist.ChemicalRage"

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

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
	EmitSoundOn( sound_cast, self:GetParent() )
end