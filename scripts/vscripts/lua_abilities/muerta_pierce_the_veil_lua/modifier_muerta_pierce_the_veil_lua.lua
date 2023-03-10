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
modifier_muerta_pierce_the_veil_lua = class({})

local disarm_modifier_whitelist = {
	["modifier_item_ethereal_blade_ethereal"] = true,
	["modifier_ghost_state"] = true,
}
local disarm_modifier_blacklist = {
	["modifier_heavens_halberd_debuff"] = true,
}

--------------------------------------------------------------------------------
-- Classifications
function modifier_muerta_pierce_the_veil_lua:IsHidden()
	return false
end

function modifier_muerta_pierce_the_veil_lua:IsDebuff()
	return false
end

function modifier_muerta_pierce_the_veil_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_muerta_pierce_the_veil_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.modelscale = self:GetAbility():GetSpecialValueFor( "modelscale" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.transform_duration = self:GetAbility():GetSpecialValueFor( "transform_duration" )

	self.transforming = true
	self:StartIntervalThink( self.transform_duration )

	if not IsServer() then return end

	self.undisarm_modifier = nil
	self:PlayEffectsStart()
end

function modifier_muerta_pierce_the_veil_lua:OnRefresh( kv )
end

function modifier_muerta_pierce_the_veil_lua:OnRemoved()
end

function modifier_muerta_pierce_the_veil_lua:OnDestroy()
	if not IsServer() then return end

	if self.undisarm_modifier then
		self.undisarm_modifier:Destroy()
		self.undisarm_modifier = nil
	end

	self:PlayEffectsEnd()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_muerta_pierce_the_veil_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,

		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL, -- allow attack ethereal units
		
		MODIFIER_PROPERTY_ALWAYS_ALLOW_ATTACK, -- allow attack while disarmed (with twists)
		MODIFIER_EVENT_ON_ATTACK_FINISHED,
		MODIFIER_EVENT_ON_ATTACK_CANCELLED,

		-- -- not working
		-- MODIFIER_PROPERTY_ALWAYS_ETHEREAL_ATTACK,
		-- MODIFIER_PROPERTY_PROCATTACK_CONVERT_PHYSICAL_TO_MAGICAL,
		-- MODIFIER_PROPERTY_PHYSICALDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_muerta_pierce_the_veil_lua:GetModifierModelChange()
	return "models/heroes/muerta/muerta_ult.vmdl"
end

function modifier_muerta_pierce_the_veil_lua:GetModifierModelScale()
	return self.modelscale
end

function modifier_muerta_pierce_the_veil_lua:GetModifierProjectileName()
	return "particles/units/heroes/hero_muerta/muerta_ultimate_projectile.vpcf"
end

function modifier_muerta_pierce_the_veil_lua:GetAttackSound()
	return "Hero_Muerta.PierceTheVeil.Attack"
end

function modifier_muerta_pierce_the_veil_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_muerta_pierce_the_veil_lua:GetOverrideAttackMagical( params )
	return 1
end

function modifier_muerta_pierce_the_veil_lua:GetModifierTotalDamageOutgoing_Percentage( params )
	if params.inflictor then return 0 end
	if params.damage_category~=DOTA_DAMAGE_CATEGORY_ATTACK then return 0 end
	if params.damage_type~=DAMAGE_TYPE_PHYSICAL then return 0 end

	if not params.target:IsMagicImmune() then
		local damageTable = {
			victim = params.target,
			attacker = self.parent,
			damage = params.original_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flag = DOTA_DAMAGE_FLAG_MAGIC_AUTO_ATTACK,
			ability = self.ability, --Optional.
		}
		ApplyDamage( damageTable )

		EmitSoundOn( "Hero_Muerta.PierceTheVeil.ProjectileImpact", params.target )
	else
		EmitSoundOn( "Hero_Muerta.PierceTheVeil.ProjectileImpact.MagicImmune", params.target )
	end

	return -200
end

--[[
	NOTES:
	- when attempting to attack while disarmed, this procs.
	- procs before OnAttackStart, and somehow procs multiple times
	- params.unit is the attack target
	- regarding MODIFIER_STATE_DISARMED, if 2 conflicting modifiers which has DISARMED=false and DISARMED=true:
		- higher priority wins: DISARMED=false modifier with higher priority will allow attacks
		- applied first wins: DISARMED=true modifier which applied later won't disarm unit
			- ideally later wins, but whatever
]]
function modifier_muerta_pierce_the_veil_lua:GetAlwaysAllowAttack( params )
	-- filter disarm sources (ideally uses whitelist instead, e.g. ethereal modifiers)
	local should_disarm = false
	for modifier,_ in pairs(disarm_modifier_blacklist) do
		if self.parent:HasModifier(modifier) then
			should_disarm = true
			break
		end
	end
	if should_disarm then return 0 end

	-- add undisarm_modifier modifier 
	self.undisarm_modifier = self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_muerta_pierce_the_veil_lua_undisarm",
		{duration = 1}
	)

	return 1
end

function modifier_muerta_pierce_the_veil_lua:OnAttackFinished( params )
	if params.attacker~=self.parent then return end
	if self.undisarm_modifier then
		self.undisarm_modifier:Destroy()
		self.undisarm_modifier = nil
	end
end

-- same as above
function modifier_muerta_pierce_the_veil_lua:OnAttackCancelled( params )
	self:OnAttackFinished( params )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_muerta_pierce_the_veil_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = self.transforming,
		[MODIFIER_STATE_CANNOT_TARGET_BUILDINGS] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_muerta_pierce_the_veil_lua:OnIntervalThink()
	self.transforming = false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_muerta_pierce_the_veil_lua:GetEffectName()
	return "particles/units/heroes/hero_muerta/muerta_ultimate_form_ethereal.vpcf"
end

function modifier_muerta_pierce_the_veil_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_muerta_pierce_the_veil_lua:PlayEffectsStart()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_ultimate_form_screen_effect.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(1,0,0) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end

function modifier_muerta_pierce_the_veil_lua:PlayEffectsEnd()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_ultimate_form_finish.vpcf"
	local sound_cast = "Hero_Muerta.PierceTheVeil.End"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end