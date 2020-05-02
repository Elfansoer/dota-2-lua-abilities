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
modifier_jakiro_ice_path_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_jakiro_ice_path_lua_thinker:IsHidden()
	return false
end

function modifier_jakiro_ice_path_lua_thinker:IsDebuff()
	return false
end

function modifier_jakiro_ice_path_lua_thinker:IsStunDebuff()
	return false
end

function modifier_jakiro_ice_path_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_jakiro_ice_path_lua_thinker:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()

	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.range = self:GetAbility():GetCastRange( self.parent:GetAbsOrigin(), nil ) + self.caster:GetCastRangeBonus()
	self.delay = self:GetAbility():GetSpecialValueFor( "path_delay" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self.radius = self:GetAbility():GetSpecialValueFor( "path_radius" )

	if not IsServer() then return end

	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

	-- set up data
	self.delayed = true
	self.targets = {}
	local start_range = 12

	self.direction = Vector( kv.x, kv.y, 0 )
	self.startpoint = self.parent:GetOrigin() + self.direction + start_range
	self.endpoint = self.startpoint + self.direction * self.range

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( self.delay )

	-- play effects
	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_jakiro_ice_path_lua_thinker:OnRefresh( kv )
end

function modifier_jakiro_ice_path_lua_thinker:OnRemoved()
end

function modifier_jakiro_ice_path_lua_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_jakiro_ice_path_lua_thinker:OnIntervalThink()
	if self.delayed then
		-- after the delay
		self.delayed = false
		self:SetDuration( self.duration, false )
		self:StartIntervalThink( 0.03 )

		-- create vision along line
		local step = 0
		while step < self.range do
			local loc = self.startpoint + self.direction * step
			AddFOWViewer(
				self.caster:GetTeamNumber(),
				loc,
				self.radius,
				self.duration,
				false
			)

			step = step + self.radius
		end

		-- play effects
		return
	end

	-- continuously find units in line
	local enemies = FindUnitsInLine(
		self.caster:GetTeamNumber(),	-- int, your team number
		self.startpoint,	-- point, center point
		self.endpoint,
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		self.abilityTargetTeam,	-- int, team filter
		self.abilityTargetType,	-- int, type filter
		self.abilityTargetFlags	-- int, flag filter
	)

	for _,enemy in pairs(enemies) do

		-- only for uncaught enemies
		if not self.targets[enemy] then

			-- set as caught
			self.targets[enemy] = true

			-- apply damage
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )

			local duration = self:GetRemainingTime()

			-- add modifier
			enemy:AddNewModifier(
				self.caster, -- player source
				self:GetAbility(), -- ability source
				"modifier_jakiro_ice_path_lua", -- modifier name
				{ duration = duration } -- kv
			)
		end
	end

end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_jakiro_ice_path_lua_thinker:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_jakiro/jakiro_ice_path.vpcf"
	local sound_cast = "Hero_Jakiro.IcePath.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, self.startpoint )
	ParticleManager:SetParticleControl( effect_cast, 1, self.endpoint )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 0, 0, self.delay ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_jakiro_ice_path_lua_thinker:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_jakiro/jakiro_ice_path_b.vpcf"
	local sound_cast = "Hero_Jakiro.IcePath"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, self.startpoint )
	ParticleManager:SetParticleControl( effect_cast, 1, self.endpoint )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.delay + self.duration, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 9, self.startpoint )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		9,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end