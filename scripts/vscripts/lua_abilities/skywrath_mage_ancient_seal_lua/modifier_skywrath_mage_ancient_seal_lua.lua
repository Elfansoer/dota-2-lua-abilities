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
modifier_skywrath_mage_ancient_seal_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_skywrath_mage_ancient_seal_lua:IsHidden()
	return false
end

function modifier_skywrath_mage_ancient_seal_lua:IsDebuff()
	return true
end

function modifier_skywrath_mage_ancient_seal_lua:IsStunDebuff()
	return false
end

function modifier_skywrath_mage_ancient_seal_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_skywrath_mage_ancient_seal_lua:OnCreated( kv )
	-- references
	self.magic_resist = self:GetAbility():GetSpecialValueFor( "resist_debuff" )

	if not IsServer() then return end
	-- play effect
	self:PlayEffects()
end

function modifier_skywrath_mage_ancient_seal_lua:OnRefresh( kv )
	-- references
	self.magic_resist = self:GetAbility():GetSpecialValueFor( "resist_debuff" )

	if not IsServer() then return end
	-- play effect
	local sound_cast = "Hero_SkywrathMage.AncientSeal.Target"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_skywrath_mage_ancient_seal_lua:OnRemoved()
end

function modifier_skywrath_mage_ancient_seal_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_skywrath_mage_ancient_seal_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}

	return funcs
end

function modifier_skywrath_mage_ancient_seal_lua:GetModifierMagicalResistanceBonus()
	return self.magic_resist
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_skywrath_mage_ancient_seal_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_skywrath_mage_ancient_seal_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_ancient_seal_debuff.vpcf"
	local sound_cast = "Hero_SkywrathMage.AncientSeal.Target"

	local parent = self:GetParent()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		parent,
		PATTACH_OVERHEAD_FOLLOW,
		"",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

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
	EmitSoundOn( sound_cast, parent )
end