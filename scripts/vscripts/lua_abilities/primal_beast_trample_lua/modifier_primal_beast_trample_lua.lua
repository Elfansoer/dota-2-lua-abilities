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
modifier_primal_beast_trample_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_primal_beast_trample_lua:IsHidden()
	return false
end

function modifier_primal_beast_trample_lua:IsDebuff()
	return false
end

function modifier_primal_beast_trample_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_primal_beast_trample_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "effect_radius" )
	self.step_distance = self:GetAbility():GetSpecialValueFor( "step_distance" )
	self.base_damage = self:GetAbility():GetSpecialValueFor( "base_damage" )
	self.attack_damage = self:GetAbility():GetSpecialValueFor( "attack_damage" )/100

	if not IsServer() then return end

	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	-- init data
	self.distance = 0
	self.treshold = 500
	self.currentpos = self.parent:GetOrigin()

	-- Start interval
	self:StartIntervalThink( 0.1 )

	-- Trample
	self:Trample()
end

function modifier_primal_beast_trample_lua:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "effect_radius" )
	self.distance = self:GetAbility():GetSpecialValueFor( "step_distance" )
	self.base_damage = self:GetAbility():GetSpecialValueFor( "base_damage" )
	self.attack_damage = self:GetAbility():GetSpecialValueFor( "attack_damage" )/100
	
end

function modifier_primal_beast_trample_lua:OnRemoved()
end

function modifier_primal_beast_trample_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_primal_beast_trample_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return funcs
end

function modifier_primal_beast_trample_lua:GetActivityTranslationModifiers()
	return "heavy_steps"
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_primal_beast_trample_lua:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_primal_beast_trample_lua:OnIntervalThink()
	local pos = self.parent:GetOrigin()
	local dist = (pos-self.currentpos):Length2D()
	self.currentpos = pos

	-- destroy trees
	GridNav:DestroyTreesAroundPoint( pos, self.radius, false )

	-- ignore if moving too fast, like blink
	if dist>self.treshold then return end

	self.distance = self.distance + dist
	if self.distance > self.step_distance then
		self:Trample()
		self.distance = 0
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_primal_beast_trample_lua:Trample()
	local pos = self.parent:GetOrigin()
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		pos,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- precache damage
	local damage = self.base_damage + self.parent:GetAverageTrueAttackDamage(self.parent)*self.attack_damage
	local damageTable = {
		-- victim = target,
		attacker = self.parent,
		damage = damage,
		damage_type = self.abilityDamageType,
		ability = self.ability, --Optional.
	}

	for _,enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		SendOverheadEventMessage(
			nil,
			OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
			enemy,
			damage,
			nil
		)
	end

	self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_primal_beast_trample_lua:GetEffectName()
	return "particles/units/heroes/hero_primal_beast/primal_beast_disarm.vpcf"
end

function modifier_primal_beast_trample_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_primal_beast_trample_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf"
	local sound_cast = "Hero_PrimalBeast.Trample"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )

	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end
