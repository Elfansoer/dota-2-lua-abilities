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
maple_hydra = class({})
LinkLuaModifier( "modifier_maple_hydra", "custom_abilities/maple_hydra/modifier_maple_hydra", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_maple_hydra_thinker", "custom_abilities/maple_hydra/modifier_maple_hydra_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_maple_hydra_debuff", "custom_abilities/maple_hydra/modifier_maple_hydra_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function maple_hydra:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function maple_hydra:GetManaCost( level )
	return self:GetCaster():GetMaxMana() * self:GetSpecialValueFor( "manacost_pct" )/100
end

--------------------------------------------------------------------------------
-- Ability Start
function maple_hydra:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local radius = self:GetSpecialValueFor( "radius" )
	local count = self:GetSpecialValueFor( "count" )
	local duration = self:GetSpecialValueFor( "duration" )
	local base_dps = self:GetSpecialValueFor( "base_dps" )
	local mana_dps = self:GetSpecialValueFor( "manacost_dps" )

	-- find units, prioritizing heroes
	-- needs better algorithm
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	local heroes = {}
	local creeps = {}
	for _,enemy in pairs(enemies) do
		if enemy:IsHero() then
			table.insert( heroes, enemy )
		else
			table.insert( creeps, enemy )
		end
	end
	for i,v in ipairs(creeps) do
		table.insert( heroes, v )
	end

	-- calculate dps
	local manacost = self:GetManaCost(-1)
	local dps = base_dps + manacost * mana_dps/100

	-- create thinker that manages hydras each cast
	local intrinsic = CreateModifierThinker(
		caster,
		self,
		"modifier_maple_hydra",
		{},
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	):FindModifierByName("modifier_maple_hydra")

	for i=1,count do
		-- create hydra head
		local head = class(hydra_head)
		local direction = RotatePosition( Vector(0,0,0), QAngle( 0, 360/count * (i-1), 0 ), caster:GetForwardVector() )
		head:Init( self, caster:GetOrigin(), direction, heroes[i], dps )
		
		-- register hydra
		intrinsic:AddHydra( head, duration )
	end
end

--------------------------------------------------------------------------------
-- Semi-class for Hydra Heads
hydra_head = {}
function hydra_head:Init( ability, position, direction, target, dps )
	self.owner = ability:GetCaster()
	self.ability = ability
	self.dps = dps
	
	-- movement
	self.position = position
	self.direction = direction
	self.turn_rate = ability:GetSpecialValueFor( "turn_rate" )
	self.speed = ability:GetSpecialValueFor( "speed" )
	
	-- target search
	self.search_radius = ability:GetSpecialValueFor( "radius" )
	self.target = target

	-- trail
	self.trail_radius = ability:GetSpecialValueFor( "trail_radius" )
	self.trail_duration = ability:GetSpecialValueFor( "trail_duration" )
	self.last_thinker_pos = position
	self:CreateTrail()

	-- effect
	self.effect_cast = self:CreateEffect()
end

function hydra_head:Destroy()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

function hydra_head:CreateTrail()
	local modifier = CreateModifierThinker(
		self.owner,
		self.ability,
		"modifier_maple_hydra_thinker",
		{
			duration = self.trail_duration,
			dps = self.dps,
		},
		self.position,
		self.owner:GetTeamNumber(),
		false
	):FindModifierByName("modifier_maple_hydra_thinker")

	modifier:SetDPS( self.dps )

end

function hydra_head:IntervalThink( dt )
	-- trail logic
	local distance = (self.position - self.last_thinker_pos):Length2D()
	if distance > self.trail_radius/2 then
		self.last_thinker_pos = self.position

		-- create trail
		self:CreateTrail()
	end

	-- target check logic
	if self.target then
		if
			not self.target:IsAlive() or
			self.target:IsInvulnerable() or
			self.target:IsMagicImmune()
		then
			self.target = nil
		end
	end

	-- search logic
	if not self.target then
		-- find units, prioritizing heroes
		local enemies = FindUnitsInRadius(
			self.owner:GetTeamNumber(),	-- int, your team number
			self.position,	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.search_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			FIND_CLOSEST,	-- int, order filter
			false	-- bool, can grow cache
		)
		local heroes = {}
		local creeps = {}
		for _,enemy in pairs(enemies) do
			if enemy:IsHero() then
				table.insert( heroes, enemy )
			else
				table.insert( creeps, enemy )
			end
		end

		if #heroes > 0 then
			self.target = heroes[1]
		elseif #creeps > 0 then
			self.target = creeps[1]
		end
	end

	-- turn logic
	if self.target then
		local parent_angle =  VectorToAngles( self.direction ).y

		-- go to slightly in front of target 
		local target_angle = VectorToAngles( self.target:GetOrigin() + self.target:GetForwardVector()*20 - self.position ).y 
		local angle_diff = AngleDiff(target_angle, parent_angle);
		
		parent_angle = parent_angle + angle_diff/math.abs(angle_diff) * self.turn_rate * dt

		self.direction = Vector( math.cos( math.rad(parent_angle) ), math.sin( math.rad(parent_angle) ), 0 )
	end

	-- move logic
	self.position = self.position + self.direction * self.speed * dt


	-- update particle
	ParticleManager:SetParticleControl( self.effect_cast, 1, self.position + Vector(0,0,50) )
end

function hydra_head:CreateEffect()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_maple/maple_hydra.vpcf"
	
	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.position + Vector(0,0,50) )
	ParticleManager:SetParticleControl( effect_cast, 1, self.position + Vector(0,0,50) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.speed, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 5, Vector( self.trail_duration, self.trail_radius, 0 ) )

	return effect_cast
end