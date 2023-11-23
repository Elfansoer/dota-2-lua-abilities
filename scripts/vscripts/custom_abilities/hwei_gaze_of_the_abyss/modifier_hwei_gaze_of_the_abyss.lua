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
modifier_hwei_gaze_of_the_abyss = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hwei_gaze_of_the_abyss:IsHidden()
	return false
end

function modifier_hwei_gaze_of_the_abyss:IsDebuff()
	return true
end

function modifier_hwei_gaze_of_the_abyss:IsStunDebuff()
	return false
end

function modifier_hwei_gaze_of_the_abyss:IsPurgable()
	return true
end

function modifier_hwei_gaze_of_the_abyss:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_gaze_of_the_abyss:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then return end

	self.damage_type = self.ability:GetAbilityDamageType()
	self.interval = 0.5
	self.damage = self.ability:GetSpecialValueFor( "damage" ) * self.interval

	self:StartIntervalThink( self.interval )

	-- play effects
	local hero = self:GetParent():IsHero()
	local sound_cast = "Hero_AbyssalUnderlord.Pit.TargetHero"
	if not hero then
		sound_cast = "Hero_AbyssalUnderlord.Pit.Target"
	end

	EmitSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hwei_gaze_of_the_abyss:OnIntervalThink()
	-- damage
	local damageTable = {
		victim = self.parent,
		attacker = self.caster,
		damage = self.damage,
		damage_type = self.damage_type,
		ability = self.ability, --Optional.
	}
	ApplyDamage( damageTable )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_hwei_gaze_of_the_abyss:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
		[MODIFIER_STATE_ROOTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hwei_gaze_of_the_abyss:GetEffectName()
	return "particles/units/heroes/heroes_underlord/abyssal_underlord_pitofmalice_stun.vpcf"
end

function modifier_hwei_gaze_of_the_abyss:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end