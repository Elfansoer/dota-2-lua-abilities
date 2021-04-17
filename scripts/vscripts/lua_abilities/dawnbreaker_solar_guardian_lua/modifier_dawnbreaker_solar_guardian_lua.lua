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
modifier_dawnbreaker_solar_guardian_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_solar_guardian_lua:IsHidden()
	return false
end

function modifier_dawnbreaker_solar_guardian_lua:IsDebuff()
	return false
end

function modifier_dawnbreaker_solar_guardian_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_solar_guardian_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "base_damage" )
	self.heal = self:GetAbility():GetSpecialValueFor( "base_heal" )
	self.interval = self:GetAbility():GetSpecialValueFor( "pulse_interval" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	self.point = Vector( kv.x, kv.y, 0 )

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self.parent,
		damage = self.damage,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()

	-- play effects
	self:PlayEffects1()
	self:PlayEffects2( self.point, self.radius )
end

function modifier_dawnbreaker_solar_guardian_lua:OnRefresh( kv )	
end

function modifier_dawnbreaker_solar_guardian_lua:OnRemoved()
end

function modifier_dawnbreaker_solar_guardian_lua:OnDestroy()
	if not IsServer() then return end
	FindClearSpaceForUnit( self.parent, self.parent:GetOrigin(), false )

	-- stop effects
	local sound_cast1 = "Hero_Dawnbreaker.Solar_Guardian.Channel"
	local sound_cast2 = "Hero_Dawnbreaker.Solar_Guardian.Target"
	StopSoundOn( sound_cast1, self.parent )
	StopSoundOn( sound_cast2, self.parent )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_dawnbreaker_solar_guardian_lua:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dawnbreaker_solar_guardian_lua:OnIntervalThink()
	-- find enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	for _,enemy in pairs(enemies) do
		-- damage
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
	end

	-- find allies
	local allies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	for _,ally in pairs(allies) do
		-- heal
		ally:Heal( self.heal, self.ability )

		-- effects
		self:PlayEffects4( ally )
		SendOverheadEventMessage(
			nil,
			OVERHEAD_ALERT_HEAL,
			ally,
			self.heal,
			self.parent:GetPlayerOwner()
		)
	end

	-- play effects
	self:PlayEffects3( self.point, self.radius )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dawnbreaker_solar_guardian_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian.vpcf"
	local sound_cast = "Hero_Dawnbreaker.Solar_Guardian.Channel"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
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
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_dawnbreaker_solar_guardian_lua:PlayEffects2( point, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_aoe.vpcf"
	local sound_cast = "Hero_Dawnbreaker.Solar_Guardian.Target"

	-- Get Data
	point = GetGroundPosition( point, self.parent )

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )

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
	EmitSoundOnLocationWithCaster( point, sound_cast, self.parent )
end

function modifier_dawnbreaker_solar_guardian_lua:PlayEffects3( point, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_damage.vpcf"
	local sound_cast = "Hero_Dawnbreaker.Solar_Guardian.Damage"

	-- Get Data
	point = GetGroundPosition( point, self.parent )

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, self.parent )
end

function modifier_dawnbreaker_solar_guardian_lua:PlayEffects4( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_healing_buff.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end