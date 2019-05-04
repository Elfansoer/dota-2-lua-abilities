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
modifier_disruptor_static_storm_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_disruptor_static_storm_lua:IsHidden()
	return false
end

function modifier_disruptor_static_storm_lua:IsDebuff()
	return true
end

function modifier_disruptor_static_storm_lua:IsStunDebuff()
	return false
end

function modifier_disruptor_static_storm_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_disruptor_static_storm_lua:OnCreated( kv )
	-- scepter should known both client and server
	self.scepter = self:GetCaster():HasScepter()

	if not IsServer() then return end

	-- check if it is thinker or aura targets
	self.owner = kv.isProvidedByAura~=1
	if not self.owner then return end

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.pulses = self:GetAbility():GetSpecialValueFor( "pulses" )
	local duration = self:GetAbility():GetSpecialValueFor( "duration" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage_max" )
	if self.scepter then
		self.pulses = self:GetAbility():GetSpecialValueFor( "pulses_scepter" )
		duration = self:GetAbility():GetSpecialValueFor( "duration_scepter" )
	end
	
	-- calculate interval
	local interval = duration/self.pulses

	-- calculate damage
	local max_tick_damage = damage*interval
	self.tick_damage = max_tick_damage/self.pulses
	self.pulse = 0

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		-- damage = 500,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}

	-- Start interval
	self:StartIntervalThink( interval )
	-- self:OnIntervalThink()

	-- play effects
	self:PlayEffects1( duration )
	self.sound_loop = "Hero_Disruptor.StaticStorm"
	EmitSoundOn( self.sound_loop, self:GetParent() )
end

function modifier_disruptor_static_storm_lua:OnRefresh( kv )
	
end

function modifier_disruptor_static_storm_lua:OnRemoved()
end

function modifier_disruptor_static_storm_lua:OnDestroy()
	if not IsServer() then return end

	if self.owner then
		-- end sound
		StopSoundOn( self.sound_loop, self:GetParent() )
		local sound_stop = "Hero_Disruptor.StaticStorm.End"
		EmitSoundOn( sound_stop, self:GetParent() )

		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_disruptor_static_storm_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = self.scepter,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_disruptor_static_storm_lua:OnIntervalThink()
	-- increment pulse
	self.pulse = self.pulse + 1

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- set damage
	self.damageTable.damage = self.tick_damage * self.pulse

	for _,enemy in pairs(enemies) do
		-- damage enemies
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )

		-- effects
		self:PlayEffects2(enemy)
	end

	-- check for pulses
	if self.pulse >= self.pulses then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_disruptor_static_storm_lua:IsAura()
	return self.owner
end

function modifier_disruptor_static_storm_lua:GetModifierAura()
	return "modifier_disruptor_static_storm_lua"
end

function modifier_disruptor_static_storm_lua:GetAuraRadius()
	return self.radius
end

function modifier_disruptor_static_storm_lua:GetAuraDuration()
	return 0.3
end

function modifier_disruptor_static_storm_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_disruptor_static_storm_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_disruptor_static_storm_lua:PlayEffects1( duration )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_static_storm.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_disruptor_static_storm_lua:PlayEffects2( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_static_storm_bolt_hero.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end