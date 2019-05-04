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
modifier_disruptor_kinetic_field_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_disruptor_kinetic_field_lua:IsHidden()
	return false
end

function modifier_disruptor_kinetic_field_lua:IsDebuff()
	return true
end

function modifier_disruptor_kinetic_field_lua:IsPurgable()
	return true
end

function modifier_disruptor_kinetic_field_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_disruptor_kinetic_field_lua:OnCreated( kv )
	if not IsServer() then return end
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	self.owner = kv.isProvidedByAura~=1

	if self.owner then
		-- thinker references
		self.delay = self:GetAbility():GetSpecialValueFor( "formation_time" )
		self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
		
		-- set duration
		self:SetDuration( self.delay + self.duration, false )

		-- add delay
		self.formed = false
		self:StartIntervalThink( self.delay )

		-- play effects
		self:PlayEffects1()
		self.sound_loop = "Hero_Disruptor.KineticField"
		EmitSoundOn( self.sound_loop, self:GetParent() )
	else
		-- aura references
		self.aura_origin = Vector( kv.aura_origin_x, kv.aura_origin_y, 0 )
		self.parent = self:GetParent()
		self.width = 100
		self.max_speed = 550
		self.min_speed = 0.1
		self.max_min = self.max_speed-self.min_speed

		-- check inside/outside
		self.inside = (self.parent:GetOrigin()-self.aura_origin):Length2D() < self.radius
	end
end

function modifier_disruptor_kinetic_field_lua:OnRefresh( kv )
	
end

function modifier_disruptor_kinetic_field_lua:OnRemoved()
end

function modifier_disruptor_kinetic_field_lua:OnDestroy()
	if not IsServer() then return end
	if self.owner then
		-- stop sound
		StopSoundOn( self.sound_loop, self:GetParent() )
		local sound_end = "Hero_Disruptor.KineticField.End"
		EmitSoundOn( sound_end, self:GetParent() )

		-- remove thinker
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_disruptor_kinetic_field_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_disruptor_kinetic_field_lua:GetModifierMoveSpeed_Limit( params )
	if not IsServer() then return end
	-- do nothing if thinker
	if self.owner then return 0 end

	-- get data
	local parent_vector = self.parent:GetOrigin()-self.aura_origin
	local parent_direction = parent_vector:Normalized()

	-- check inside/outside
	local actual_distance = parent_vector:Length2D()
	local wall_distance = actual_distance-self.radius
	local over_walls = false
	if self.inside ~= (wall_distance<0) then
		-- moved to other side, check buffer
		if math.abs( wall_distance )>self.width then
			-- flip
			self.inside = not self.inside
		else
			over_walls = true
		end
	end	

	-- no limit if outside width
	wall_distance = math.abs(wall_distance)
	if wall_distance>self.width then return 0 end

	-- calculate facing angle
	local parent_angle = 0
	if self.inside then
		parent_angle = VectorToAngles(parent_direction).y
	else
		parent_angle = VectorToAngles(-parent_direction).y
	end
	local unit_angle = self:GetParent():GetAnglesAsVector().y
	local wall_angle = math.abs( AngleDiff( parent_angle, unit_angle ) )

	-- calculate movespeed limit
	local limit = 0
	if wall_angle<=90 then
		-- facing and touching wall
		if over_walls then
			limit = self.min_speed
			self:RemoveMotions()
		else
			-- interpolate
			limit = (wall_distance/self.width)*self.max_min + self.min_speed
		end
	else
		-- no limit if facing away
		limit = 0
	end

	return limit
end

--------------------------------------------------------------------------------
-- Helper
function modifier_disruptor_kinetic_field_lua:RemoveMotions()
	local modifiers = self.parent:FindAllModifiers(  )

	for _,modifier in pairs(modifiers) do
		-- print("modifier:",modifier,modifier:GetName())
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_disruptor_kinetic_field_lua:OnIntervalThink()
	self:StartIntervalThink( -1 )
	self.formed = true

	-- play effects
	self:PlayEffects2()
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_disruptor_kinetic_field_lua:IsAura()
	return self.owner and self.formed
end

function modifier_disruptor_kinetic_field_lua:GetModifierAura()
	return "modifier_disruptor_kinetic_field_lua"
end

function modifier_disruptor_kinetic_field_lua:GetAuraRadius()
	return self.radius
end

function modifier_disruptor_kinetic_field_lua:GetAuraDuration()
	return 0.3
end

function modifier_disruptor_kinetic_field_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_disruptor_kinetic_field_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_disruptor_kinetic_field_lua:GetAuraSearchFlags()
	return 0
end

function modifier_disruptor_kinetic_field_lua:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_disruptor_kinetic_field_lua:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_disruptor_kinetic_field_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_disruptor_kinetic_field_lua:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

function modifier_disruptor_kinetic_field_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_kineticfield_formation.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.delay, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_disruptor_kinetic_field_lua:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_kineticfield.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end