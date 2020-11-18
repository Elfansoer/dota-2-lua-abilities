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

	-- destroy modifiers (somehow it does not automatically calls OnDestroy on modifiers)
	local modifiers = {}
	for k,v in pairs(self:GetParent():FindAllModifiers()) do
		modifiers[k] = v
	end
	for k,v in pairs(modifiers) do
		v:Destroy()
	end

	UTIL_Remove( self:GetParent() ) 
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_mars_arena_of_blood_lua_thinker:OnIntervalThink()
	if self.phase_delay then
		self.phase_delay = false

		-- create vision
		AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.radius, self.duration, false)
		
		-- create wall aura
		self:GetParent():AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_mars_arena_of_blood_lua_wall_aura", -- modifier name
			{  } -- kv
		)

		-- create spear aura
		self:GetParent():AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_mars_arena_of_blood_lua_spear_aura", -- modifier name
			{  } -- kv
		)

		-- create spear aura
		self:GetParent():AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_mars_arena_of_blood_lua_projectile_aura", -- modifier name
			{  } -- kv
		)

		-- create phantom blockers
		self:SummonBlockers()

		-- play effects
		local sound_loop = "Hero_Mars.ArenaOfBlood"
		EmitSoundOn( sound_loop, self:GetParent() )

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

function modifier_mars_arena_of_blood_lua_thinker:SummonBlockers()
	-- init data
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local teamnumber = caster:GetTeamNumber()
	local origin = self:GetParent():GetOrigin()
	local angle = 0
	local vector = origin + Vector(self.radius,0,0)
	local zero = Vector(0,0,0)
	local one = Vector(1,0,0)
	local count = 28

	local angle_diff = 360/count

	for i=0,count-1 do
		local location = RotatePosition( origin, QAngle( 0, angle_diff*i, 0 ), vector )
		local facing = RotatePosition( zero, QAngle( 0, 200+angle_diff*i, 0 ), one )

		-- callback after creation
		local callback = function( unit )
			unit:SetForwardVector( facing )
			unit:SetNeverMoveToClearSpace( true )

			-- add modifier
			unit:AddNewModifier(
				caster, -- player source
				self:GetAbility(), -- ability source
				"modifier_mars_arena_of_blood_lua_blocker", -- modifier name
				{
					duration = self.duration,
					model = i%2==0,
				} -- kv
			)
		end

		-- create unit async (to avoid high think time)
		local unit = CreateUnitByNameAsync(
			"npc_dota_mars_arena_of_blood_lua_soldier",
			location,
			false,
			caster,
			nil,
			caster:GetTeamNumber(),
			callback
		)
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_mars_arena_of_blood_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_mars/mars_arena_of_blood.vpcf"
	local sound_cast = "Hero_Mars.ArenaOfBlood.Start"
	-- Hero_Mars.Block_Projectile

	-- Get data
	-- colloseum radius = radius + 50
	local radius = self.radius + 50

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 0, 0 ) )
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

	-- Play sound
	EmitSoundOn( sound_cast, self:GetParent() )
end