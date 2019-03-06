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
modifier_mars_arena_of_blood_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mars_arena_of_blood_lua_thinker:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mars_arena_of_blood_lua_thinker:OnCreated( kv )
	-- references
	self.delay = self:GetAbility():GetSpecialValueFor( "formation_time" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if IsServer() then
		self.thinkers = {}

		-- Start interval
		self.phase_delay = true
		self:StartIntervalThink( self.delay )

		-- play effects
		self:PlayEffects()

		self:GetParent():SetModel( "models/heroes/mars/mars_soldier.vpcf" )
		self:GetParent():SetModelScale( 2 )
	end
end

function modifier_mars_arena_of_blood_lua_thinker:OnRefresh( kv )
	
end

function modifier_mars_arena_of_blood_lua_thinker:OnRemoved()
	if not IsServer() then return end
	-- stop effects
	local sound_stop = "Hero_Mars.ArenaOfBlood.End"
	local sound_loop = "Hero_Mars.ArenaOfBlood"

	EmitSoundOn( sound_stop, self:GetParent() )
	StopSoundOn( sound_loop, self:GetParent() )
end

function modifier_mars_arena_of_blood_lua_thinker:OnDestroy()
	if not IsServer() then return end

	UTIL_Remove( self:GetParent() ) 
end

function modifier_mars_arena_of_blood_lua_thinker:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}

	return funcs
end

function modifier_mars_arena_of_blood_lua_thinker:GetModifierModelChange()
	return "models/heroes/mars/mars_soldier.vpcf"
end
--------------------------------------------------------------------------------
-- Interval Effects
function modifier_mars_arena_of_blood_lua_thinker:OnIntervalThink()
	if self.phase_delay then
		self.phase_delay = false

		-- create wall aura
		self:GetParent():AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_mars_arena_of_blood_lua_wall_aura", -- modifier name
			{  } -- kv
		)

		-- create spear thinkers around units
		self:GetParent():AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_mars_arena_of_blood_lua_spear_aura", -- modifier name
			{  } -- kv
		)

		-- add end duration
		self:StartIntervalThink( self.duration )
		self.phase_duration = true
		return
	end
	if self.phase_duration then
		self:Destroy()
		return
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_mars_arena_of_blood_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_mars/mars_arena_of_blood.vpcf"

	local sound_cast = "Hero_Mars.ArenaOfBlood.Start"
	local sound_loop = "Hero_Mars.ArenaOfBlood"
	-- Hero_Mars.Block_Projectile

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 3, self:GetParent():GetOrigin() )

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
	EmitSoundOn( sound_cast, self:GetParent() )
	EmitSoundOn( sound_loop, self:GetParent() )
end