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
modifier_muerta_the_calling_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_muerta_the_calling_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_muerta_the_calling_lua_thinker:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.radius = 580
	self.hit_radius = self:GetAbility():GetSpecialValueFor( "hit_radius" )
	self.num_revenants = self:GetAbility():GetSpecialValueFor( "num_revenants" )
	
	-- self.revenant_radius = self:GetAbility():GetSpecialValueFor( "dead_zone_distance" )
	self.revenant_radius = self.radius - self.hit_radius

	if not IsServer() then return end

	self.revenants = {}
	
	for i=1,self.num_revenants do
		local revenant = class(revenant_class)
		revenant:Init( self.ability, self.parent:GetOrigin(), self.revenant_radius, math.pi/2 + 2*math.pi/self.num_revenants * i )
		self.revenants[i] = revenant
	end

	-- Start interval
	self:StartIntervalThink( 0 )

	self:PlayEffects()
end

function modifier_muerta_the_calling_lua_thinker:OnRefresh( kv )
end

function modifier_muerta_the_calling_lua_thinker:OnRemoved()
end

function modifier_muerta_the_calling_lua_thinker:OnDestroy()
	if not IsServer() then return end
	for _,revenant in pairs(self.revenants) do
		revenant:Destroy()
	end

	UTIL_Remove(self.parent)
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_muerta_the_calling_lua_thinker:OnIntervalThink()
	for _,revenant in pairs(self.revenants) do
		revenant:Update( FrameTime() )
	end
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_muerta_the_calling_lua_thinker:UpdateHorizontalMotion( me, dt )
	for _,revenant in pairs(self.revenants) do
		revenant:Update( dt )
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_muerta_the_calling_lua_thinker:IsAura()
	return true
end

function modifier_muerta_the_calling_lua_thinker:GetModifierAura()
	return "modifier_muerta_the_calling_lua_slow"
end

function modifier_muerta_the_calling_lua_thinker:GetAuraRadius()
	return self.radius
end

function modifier_muerta_the_calling_lua_thinker:GetAuraDuration()
	return 0.5
end

function modifier_muerta_the_calling_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_muerta_the_calling_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_muerta_the_calling_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_calling_aoe.vpcf"
	local sound_cast1 = "Hero_Muerta.Revenants"
	local sound_cast2 = "Hero_Muerta.Revenants.Layer"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self:GetDuration(), 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast1, self.parent )
	EmitSoundOn( sound_cast2, self.parent )
end

--------------------------------------------------------------------------------
-- Helper: Revenants
revenant_class = {}
function revenant_class:Init( ability, center, distance, angle )
	self.ability = ability
	self.caster = ability:GetCaster()

	self.center = center
	self.distance = distance
	self.current_angle = angle -- in rad

	self.accel = ability:GetSpecialValueFor( "acceleration" )
	self.init_speed = ability:GetSpecialValueFor( "speed_initial" )
	self.max_speed = ability:GetSpecialValueFor( "speed_max" )
	self.direction = ability:GetSpecialValueFor( "rotation_direction" )

	self.damage = ability:GetSpecialValueFor( "damage" )
	self.hit_radius = ability:GetSpecialValueFor( "hit_radius" )
	self.silence_duration = ability:GetSpecialValueFor( "silence_duration" )
	
	self.current_speed = self.init_speed

	local particle_cast = "particles/units/heroes/hero_muerta/muerta_calling.vpcf"
	self.effect = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )

	ParticleManager:SetParticleControl( self.effect, 0, self:GetPosition() )
	ParticleManager:SetParticleControl( self.effect, 1, Vector( self.hit_radius, self.hit_radius, self.hit_radius ) )
end

function revenant_class:Update( dt )
	-- move logic
	self.current_speed = math.min( self.current_speed + self.accel * dt, self.max_speed )
	self.current_angle = self.current_angle + self.current_speed * dt
	if self.current_angle > 2*math.pi then
		self.current_angle = self.current_angle - 2*math.pi
	end

	local position = self:GetPosition()

	-- hit logic
	local caster = self.ability:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		position,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.hit_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = caster,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability, --Optional.
	}

	for _,enemy in pairs(enemies) do
		local modifier = enemy:FindModifierByNameAndCaster( "modifier_generic_silenced_lua", caster )
		if (not modifier) or modifier.applier~=self then
			-- apply modifier and damage
			modifier = enemy:AddNewModifier(
				caster,
				self.ability,
				"modifier_generic_silenced_lua",
				{duration = self.silence_duration}
			)
			modifier.applier = self

			damageTable.victim = enemy
			ApplyDamage( damageTable )

			-- effect
			self:PlayEffects( enemy )
		end
	end

	-- particle logic
	ParticleManager:SetParticleControl( self.effect, 0, position )
end

function revenant_class:GetPosition()
	return GetGroundPosition(self.center + Vector( math.cos( self.current_angle ), math.sin( self.current_angle ), 0 ) * self.distance, nil)
end

function revenant_class:Destroy()
	ParticleManager:DestroyParticle(self.effect, false)
	ParticleManager:ReleaseParticleIndex( self.effect )
end

function revenant_class:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_calling_impact.vpcf"
	local sound_cast1 = "Hero_Muerta.Revenants.Damage.Hero"
	local sound_cast2 = "Hero_Muerta.Revenants.Silence"
	if not target:IsHero() then
		sound_cast1 = "Hero_Muerta.Revenants.Damage.Creep"
	end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- -- Create Sound
	EmitSoundOn( sound_cast1, target )
	EmitSoundOn( sound_cast2, target )
end
