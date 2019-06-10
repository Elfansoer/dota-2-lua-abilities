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
modifier_dark_willow_bramble_maze_lua_thinker = class({})


--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_willow_bramble_maze_lua_thinker:IsHidden()
	return false
end

function modifier_dark_willow_bramble_maze_lua_thinker:IsDebuff()
	return false
end

function modifier_dark_willow_bramble_maze_lua_thinker:IsStunDebuff()
	return false
end

function modifier_dark_willow_bramble_maze_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_willow_bramble_maze_lua_thinker:OnCreated( kv )
	-- references
	local init_delay = self:GetAbility():GetSpecialValueFor( "initial_creation_delay" )
	self.interval = self:GetAbility():GetSpecialValueFor( "latch_creation_interval" )
	self.total_count = self:GetAbility():GetSpecialValueFor( "placement_count" )
	self.duration = self:GetAbility():GetSpecialValueFor( "placement_duration" )
	self.radius = self:GetAbility():GetSpecialValueFor( "placement_range" )

	self.latch_delay = self:GetAbility():GetSpecialValueFor( "latch_creation_delay" )
	self.latch_duration = self:GetAbility():GetSpecialValueFor( "latch_duration" )
	self.latch_radius = self:GetAbility():GetSpecialValueFor( "latch_range" )
	self.latch_damage = self:GetAbility():GetSpecialValueFor( "latch_damage" )

	if not IsServer() then return end
	-- init
	self.count = 0

	-- Start delay
	self:StartIntervalThink( init_delay )

	-- play effects
	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_dark_willow_bramble_maze_lua_thinker:OnRefresh( kv )
	
end

function modifier_dark_willow_bramble_maze_lua_thinker:OnRemoved()
end

function modifier_dark_willow_bramble_maze_lua_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dark_willow_bramble_maze_lua_thinker:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_EVENT_ON_ATTACKED,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dark_willow_bramble_maze_lua_thinker:OnIntervalThink()
	if not self.delay then
		self.delay = true

		-- start creation interval
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()
		return
	end

	-- create bramble
	CreateModifierThinker(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_dark_willow_bramble_maze_lua_bramble", -- modifier name
		{
			duration = self.duration,
			root = self.latch_duration,
			radius = self.latch_radius,
			damage = self.latch_damage,
			delay = self.latch_delay,
		}, -- kv
		self:GetParent():GetOrigin() + self:GetAbility().locations[self.count],
		self:GetCaster():GetTeamNumber(),
		false
	)

	self.count = self.count+1
	if self.count>=self.total_count then
		self:StartIntervalThink( -1 )
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dark_willow_bramble_maze_lua_thinker:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_willow/dark_willow_bramble_precast.vpcf"

	for _,loc in pairs(self:GetAbility().locations) do
		local location = self:GetParent():GetOrigin() + loc

		-- Create Particle
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( effect_cast, 0, location )
		ParticleManager:SetParticleControl( effect_cast, 3, location )
		ParticleManager:ReleaseParticleIndex( effect_cast )
	end
end

function modifier_dark_willow_bramble_maze_lua_thinker:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_willow/dark_willow_bramble_cast.vpcf"
	local sound_cast = "Hero_DarkWillow.Brambles.Cast"
	local sound_target = "Hero_DarkWillow.Brambles.CastTarget"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_target, self:GetParent() )
end