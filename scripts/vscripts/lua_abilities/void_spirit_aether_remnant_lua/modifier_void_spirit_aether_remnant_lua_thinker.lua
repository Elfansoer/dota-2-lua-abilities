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
modifier_void_spirit_aether_remnant_lua_thinker = class({})
local STATE_RUN = 1
local STATE_DELAY = 2
local STATE_WATCH = 3
local STATE_PULL = 4
--------------------------------------------------------------------------------
-- Classifications

--------------------------------------------------------------------------------
-- Initializations
function modifier_void_spirit_aether_remnant_lua_thinker:OnCreated( kv )
	-- references
	self.interval = self:GetAbility():GetSpecialValueFor( "think_interval" )
	self.delay = self:GetAbility():GetSpecialValueFor( "activation_delay" )
	self.speed = self:GetAbility():GetSpecialValueFor( "projectile_speed" )

	self.width = self:GetAbility():GetSpecialValueFor( "remnant_watch_radius" )
	self.distance = self:GetAbility():GetSpecialValueFor( "remnant_watch_distance" )
	self.watch_vision = self:GetAbility():GetSpecialValueFor( "watch_path_vision_radius" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	self.damage = self:GetAbility():GetSpecialValueFor( "impact_damage" )
	self.pull_duration = self:GetAbility():GetSpecialValueFor( "pull_duration" )
	self.pull = self:GetAbility():GetSpecialValueFor( "pull_destination" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

	-- get direction & target
	self.origin = self:GetParent():GetOrigin()
	-- local end_pos = Vector( kv.end_x, kv.end_y, 0 )
	-- self.direction = end_pos-self.origin
	-- if self.direction:Length2D()<0.05 then
	-- 	self.direction = self.origin-self:GetCaster():GetOrigin()
	-- end
	self.direction = Vector( kv.dir_x, kv.dir_y, 0 )
	-- self.direction.z = 0
	-- self.direction = self.direction:Normalized()
	self.target = GetGroundPosition( self.origin + self.direction * self.distance, nil )

	-- calculate delay from running to position
	local run_dist = (self.origin-self:GetCaster():GetOrigin()):Length2D()
	local run_delay = run_dist/self.speed

	-- set init state
	self.state = STATE_RUN
	-- self:SetDuration( 0, false )
	self:StartIntervalThink( run_delay )
	self:PlayEffects1()
end

function modifier_void_spirit_aether_remnant_lua_thinker:OnRefresh( kv )
	if not IsServer() then return end
	self.state = kv.state
end

function modifier_void_spirit_aether_remnant_lua_thinker:OnRemoved()
end

function modifier_void_spirit_aether_remnant_lua_thinker:OnDestroy()
	if not IsServer() then return end
	local sound_cast = "Hero_VoidSpirit.AetherRemnant.Spawn_lp"
	StopSoundOn( sound_cast, self:GetParent() )
	self:PlayEffects5()

	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_void_spirit_aether_remnant_lua_thinker:OnIntervalThink()
	if self.state == STATE_RUN then
		-- change state
		self.state = STATE_DELAY
		self:StartIntervalThink( self.delay )

		-- play delay effects
		self:PlayEffects2()
		return
	elseif self.state == STATE_DELAY then
		-- change state
		self.state = STATE_WATCH
		self:StartIntervalThink( self.interval )

		-- start remnant duration
		self:SetDuration( self.duration, false )

		-- play remnant effects
		self:PlayEffects3()
		return
	elseif self.state == STATE_WATCH then
		self:WatchLogic()
	else -- self.state == STATE_PULL
		-- stop looping
		self:StartIntervalThink( -1 )
		

	end
end

function modifier_void_spirit_aether_remnant_lua_thinker:WatchLogic()
	-- provides vision
	AddFOWViewer( self:GetParent():GetTeamNumber(), self.origin, self.watch_vision, 0.1, true)
	AddFOWViewer( self:GetParent():GetTeamNumber(), self.origin + self.direction*self.distance/2, self.watch_vision, 0.1, true)
	AddFOWViewer( self:GetParent():GetTeamNumber(), self.target, self.watch_vision, 0.1, true)

	-- find units in line
	local enemies = FindUnitsInLine(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self.origin,	-- point, center point
		self.target,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.width,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		self.abilityTargetTeam,	-- int, team filter
		self.abilityTargetType,	-- int, type filter
		self.abilityTargetFlags	-- int, flag filter
	)

	if #enemies==0 then return end

	-- grab first enemy
	local enemy = enemies[1]

	-- damage
	local damageTable = {
		victim = enemy,
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(), --Optional.
	}
	ApplyDamage(damageTable)

	if not enemy:IsHero() then
		self.pull_duration = self.interval
	end

	-- add debuff
	enemy:AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_void_spirit_aether_remnant_lua", -- modifier name
		{
			duration = self.pull_duration,
			pos_x = self.origin.x,
			pos_y = self.origin.y,
			pull = self.pull,
		} -- kv
	)

	-- change remnant state
	self.state = STATE_PULL
	self:SetDuration( self.pull_duration, false )

	-- provides pull vision
	local direction = enemy:GetOrigin()-self.origin
	local dist = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()
	AddFOWViewer( self:GetParent():GetTeamNumber(), self.origin, self.watch_vision, self.pull_duration, true)
	AddFOWViewer( self:GetParent():GetTeamNumber(), self.origin + direction*dist/2, self.watch_vision, self.pull_duration, true)
	AddFOWViewer( self:GetParent():GetTeamNumber(), enemy:GetOrigin(), self.watch_vision, self.pull_duration, true)

	-- Play effects
	self:PlayEffects4( enemy )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_void_spirit_aether_remnant_lua_thinker:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_run.vpcf"
	local sound_cast = "Hero_VoidSpirit.AetherRemnant"

	-- get data
	local direction = self.origin-self:GetCaster():GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, direction * self.speed )
	ParticleManager:SetParticleControlForward( effect_cast, 0, -direction )
	ParticleManager:SetParticleShouldCheckFoW( effect_cast, false )

	-- store for later use
	self.effect_cast = effect_cast

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_void_spirit_aether_remnant_lua_thinker:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pre.vpcf"

	-- Destroy previous effect
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self.origin )
	ParticleManager:SetParticleControlForward( effect_cast, 0, self.direction )
		ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleShouldCheckFoW( effect_cast, false )

	-- store for later use
	self.effect_cast = effect_cast
end

function modifier_void_spirit_aether_remnant_lua_thinker:PlayEffects3()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_watch.vpcf"
	local sound_cast = "Hero_VoidSpirit.AetherRemnant.Spawn_lp"

	-- Destroy previous effect
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self.origin )
	ParticleManager:SetParticleControl( effect_cast, 1, self.target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, 0, self.direction )
	ParticleManager:SetParticleControlForward( effect_cast, 2, self.direction )

	-- store for later use
	self.effect_cast = effect_cast

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end


function modifier_void_spirit_aether_remnant_lua_thinker:PlayEffects4( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pull.vpcf"
	local sound_cast = "Hero_VoidSpirit.AetherRemnant.Triggered"
	local sound_target = "Hero_VoidSpirit.AetherRemnant.Target"

	-- Destroy previous effect
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	-- get data
	local direction = target:GetOrigin()-self.origin
	direction.z = 0
	direction = -direction:Normalized()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self.origin )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, 2, direction )
	ParticleManager:SetParticleControl( effect_cast, 3, self.origin )

	-- store for later use
	self.effect_cast = effect_cast

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
	EmitSoundOn( sound_target, target )
end

function modifier_void_spirit_aether_remnant_lua_thinker:PlayEffects5()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_flash.vpcf"
	local sound_target = "Hero_VoidSpirit.AetherRemnant.Destroy"

	-- Destroy previous effect
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 3, self:GetParent():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_target, self:GetParent() )
end