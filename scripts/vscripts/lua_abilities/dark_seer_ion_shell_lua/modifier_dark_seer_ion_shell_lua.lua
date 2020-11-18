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
modifier_dark_seer_ion_shell_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_seer_ion_shell_lua:IsHidden()
	return false
end

function modifier_dark_seer_ion_shell_lua:IsDebuff()
	return self:GetParent():GetTeamNumber()~=self:GetCaster():GetTeamNumber()
end

function modifier_dark_seer_ion_shell_lua:IsStunDebuff()
	return false
end

function modifier_dark_seer_ion_shell_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_seer_ion_shell_lua:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.team = self.caster:GetTeamNumber()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	local tick = self:GetAbility():GetSpecialValueFor( "tick_interval" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = damage*tick,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(), --Optional.
	}

	-- Start interval
	self:StartIntervalThink( tick )
	self:OnIntervalThink()

	self:PlayEffects1()
end

function modifier_dark_seer_ion_shell_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dark_seer_ion_shell_lua:OnRemoved()
end

function modifier_dark_seer_ion_shell_lua:OnDestroy()
	if not IsServer() then return end

	-- Play effects
	local sound_loop = "Hero_Dark_Seer.Ion_Shield_lp"
	local sound_end = "Hero_Dark_Seer.Ion_Shield_end"
	StopSoundOn( sound_loop, self.parent )
	EmitSoundOn( sound_end, self.parent )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dark_seer_ion_shell_lua:OnIntervalThink()
	-- find enemies
	local enemies = FindUnitsInRadius(
		self.team,	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		self.abilityTargetType,	-- int, type filter
		self.abilityTargetFlags,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		if enemy~=self.parent then
			-- damage
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )

			-- effect
			self:PlayEffects2( enemy )
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dark_seer_ion_shell_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell.vpcf"
	local sound_cast = "Hero_Dark_Seer.Ion_Shield_Start"
	local sound_loop = "Hero_Dark_Seer.Ion_Shield_lp"

	-- Get Data
	local hull1 = 40
	local hull2 = 40

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( hull1, hull2, 0 ) )

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
	EmitSoundOn( sound_loop, self.parent )
end

function modifier_dark_seer_ion_shell_lua:PlayEffects2( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell_damage.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end