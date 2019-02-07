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
modifier_midas_golden_valkyrie = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_valkyrie:IsHidden()
	return true
end

function modifier_midas_golden_valkyrie:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_valkyrie:OnCreated( kv )
	-- references
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.idle_radius = self:GetAbility():GetSpecialValueFor( "idle_radius" )
	self.attack_radius = self:GetAbility():GetSpecialValueFor( "attack_radius" )
	self.far_radius = self:GetAbility():GetSpecialValueFor( "far_radius" )
	local start_time = self:GetAbility():GetSpecialValueFor( "start_delay" )

	self.attack_rate = 1/self:GetAbility():GetSpecialValueFor( "attack_rate_mult" )
	self.attack_dmg = self:GetAbility():GetSpecialValueFor( "attack_dmg_mult" )*100 - 100
	self.use_modifier = self:GetAbility():GetSpecialValueFor( "use_modifier" )==1

	self.inside = true
	self.aggro = false
	self.nostart = true
	self.wander_time = 4
	self.ability = self:GetAbility()

	if IsServer() then
		-- Start interval
		self:StartIntervalThink( start_time )
	end
end

function modifier_midas_golden_valkyrie:OnRefresh( kv )
	
end

function modifier_midas_golden_valkyrie:OnRemoved()
end

function modifier_midas_golden_valkyrie:OnDestroy()
	if IsServer() then
		self.parent:ForceKill( false )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_midas_golden_valkyrie:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_LIFETIME_FRACTION,

		MODIFIER_PROPERTY_FIXED_ATTACK_RATE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,

		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE, -- Only for AI movement

		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_midas_golden_valkyrie:GetUnitLifetimeFraction( params )
	return ( ( self:GetDieTime() - GameRules:GetGameTime() ) / self:GetDuration() )
end

function modifier_midas_golden_valkyrie:GetModifierMoveSpeed_Absolute()
	return self.caster:GetIdealSpeedNoSlows()
end

function modifier_midas_golden_valkyrie:GetModifierFixedAttackRate()
	return self.attack_rate/self.caster:GetAttacksPerSecond()
end

function modifier_midas_golden_valkyrie:GetModifierProcAttack_Feedback( params )
	-- reduce damage
	self.ability.outgoing = self.attack_dmg

	self.caster:PerformAttack(
		params.target, --hTarget
		true, --bUseCastAttackOrb
		self.use_modifier, --bProcessProcs
		true, --bSkipCooldown
		true, --bIgnoreInvis
		false, --bUseProjectile
		false, --bFakeAttack
		true --bNeverMiss
	)

	-- return to normal
	self.ability.outgoing = nil
end

function modifier_midas_golden_valkyrie:GetModifierOverrideAttackDamage()
	return 0
end

function modifier_midas_golden_valkyrie:GetModifierBaseAttack_BonusDamage()
	self:AIMovement()
	return 0
end

function modifier_midas_golden_valkyrie:OnDeath( params )
	if params.unit~=self:GetCaster() then return end
	self:Destroy()
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_midas_golden_valkyrie:CheckState()
	local state = {
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		-- [MODIFIER_STATE_NO_UNIT_COLLISION] = self.aggro==nil,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVISIBLE] = self:GetCaster():IsInvisible(),

		[MODIFIER_STATE_STUNNED] = self.nostart,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_midas_golden_valkyrie:OnIntervalThink()
	if self.nostart then
		self.nostart = false
		self:StartIntervalThink( self.wander_time )
		return
	end

	-- when idle and inside, free roam
	if self.inside and (not self.aggro) then
		self:Wander()
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_midas_golden_valkyrie:AIMovement()
	-- Calculate distance
	local distance = (self.caster:GetOrigin()-self.parent:GetOrigin()):Length2D()

	-- if far outside, teleport
	if distance>self.far_radius then
		self:PlayEffects()
		FindClearSpaceForUnit( self.parent, self.caster:GetOrigin() + RandomVector( RandomInt( 100, self.idle_radius ) ), true )
	end

	-- check idle
	self.aggro = self.parent:GetAggroTarget()

	if self.aggro then
		-- when aggro, let her be, unless get past free radius
		if self.inside and distance>self.attack_radius then
			-- going outside, call to papa, no aggressive
			self.inside = false
			self.parent:MoveToNPC( self.caster ) -- aggro will go to false
		end
		if not self.inside and distance<self.idle_radius then
			-- inside, free to attack again
			self.inside = true
			self:Wander()
		end
	else
		-- when idle, let her roam within wander radius
		if self.inside and distance>self.idle_radius then
			-- going outside, call to papa
			self.inside = false
			self.parent:MoveToNPC( self.caster ) -- aggro will go to false
		end
		if not self.inside and distance<self.idle_radius then
			-- inside, free to attack again
			self.inside = true
			self:Wander()
		end
	end
end

function modifier_midas_golden_valkyrie:Wander()
	self.parent:MoveToPositionAggressive( self.caster:GetOrigin() + RandomVector( RandomInt( 100, self.idle_radius ) ) )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_midas_golden_valkyrie:PlayEffects()
	local particle_cast = "particles/midas_golden_touch_explode.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	
	self.parent:StartGestureWithPlaybackRate( ACT_DOTA_SPAWN, 1.1 )
end
-- function modifier_midas_golden_valkyrie:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_midas_golden_valkyrie:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_midas_golden_valkyrie:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_midas_golden_valkyrie:PlayEffects()
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