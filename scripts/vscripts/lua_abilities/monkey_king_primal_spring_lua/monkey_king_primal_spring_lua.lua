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
monkey_king_primal_spring_lua = class({})
LinkLuaModifier( "modifier_monkey_king_primal_spring_lua", "lua_abilities/monkey_king_primal_spring_lua/modifier_monkey_king_primal_spring_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_custom_indicator", "lua_abilities/generic/modifier_generic_custom_indicator", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Passive Modifier
function monkey_king_primal_spring_lua:GetIntrinsicModifierName()
	return "modifier_generic_custom_indicator"
end

--------------------------------------------------------------------------------
-- Ability Cast Filter (For custom indicator)
function monkey_king_primal_spring_lua:CastFilterResultLocation( vLoc )
	-- Custom indicator block start
	if IsClient() then
		-- check custom indicator
		if self.custom_indicator then
			-- register cursor position
			self.custom_indicator:Register( vLoc )
		end
	end
	-- Custom indicator block end

	return UF_SUCCESS
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator
function monkey_king_primal_spring_lua:CreateCustomIndicator()
	-- references
	local particle_cast = "particles/ui_mouseactions/range_finder_aoe.vpcf"

	-- get data
	local radius = self:GetSpecialValueFor( "impact_radius" )

	-- create particle
	self.effect_indicator = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl( self.effect_indicator, 3, Vector( radius, radius, radius ) )
end

function monkey_king_primal_spring_lua:UpdateCustomIndicator( loc )
	-- limit distance
	local max_distance = self:GetSpecialValueFor( "max_distance" )
	local origin = self:GetCaster():GetAbsOrigin()
	local direction = (loc-origin)
	direction.z = 0
	if direction:Length2D()>max_distance then
		loc = origin + direction:Normalized() * max_distance
	end

	-- update particle position
	ParticleManager:SetParticleControl( self.effect_indicator, 2, loc )
end

function monkey_king_primal_spring_lua:DestroyCustomIndicator()
	-- destroy particle
	ParticleManager:DestroyParticle( self.effect_indicator, false )
	ParticleManager:ReleaseParticleIndex( self.effect_indicator )
end

--------------------------------------------------------------------------------
-- Ability Start
function monkey_king_primal_spring_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local max_distance = self:GetSpecialValueFor( "max_distance" )
	local radius = self:GetSpecialValueFor( "impact_radius" )
	local duration = self:GetSpecialValueFor( "impact_slow_duration" )

	-- limit distance
	local direction = (point-caster:GetOrigin())
	direction.z = 0
	if direction:Length2D()>max_distance then
		point = caster:GetOrigin() + direction:Normalized() * max_distance
		point.z = GetGroundHeight( point, caster )
	end

	-- give vision
	AddFOWViewer( caster:GetTeamNumber(), point, radius, duration, true )

	-- set spring ability as inactive
	self:SetActivated( false )

	-- swap to sub-ability
	if not self.sub then
		local sub = caster:FindAbilityByName( 'monkey_king_primal_spring_early_lua' )
		if not sub then
			sub = caster:AddAbility( 'monkey_king_primal_spring_early_lua' )
		end
		self.sub = sub
		self.sub.main = self
	end
	self.sub:SetLevel( self:GetLevel() )
	caster:SwapAbilities(
		'monkey_king_primal_spring_lua',
		'monkey_king_primal_spring_early_lua',
		false,
		true
	)

	-- play effects
	self:PlayEffects1()
	self:PlayEffects2( point )
end

--------------------------------------------------------------------------------
-- Ability Channeling
function monkey_king_primal_spring_lua:OnChannelFinish( bInterrupted )
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local channel_pct = (GameRules:GetGameTime() - self:GetChannelStartTime())/self:GetChannelTime()

	-- limit distance
	local max_distance = self:GetSpecialValueFor( "max_distance" )
	local direction = (point-caster:GetOrigin())
	direction.z = 0
	if direction:Length2D()>max_distance then
		point = caster:GetOrigin() + direction:Normalized() * max_distance
		point.z = GetGroundHeight( point, caster )
	end

	-- load data
	local damage = self:GetSpecialValueFor( "impact_damage" )*channel_pct
	local slow = self:GetSpecialValueFor( "impact_movement_slow" )*channel_pct
	local duration = self:GetSpecialValueFor( "impact_slow_duration" )
	local radius = self:GetSpecialValueFor( "impact_radius" )

	local speed = self:GetSpecialValueFor( "spring_leap_speed" )
	local distance = (point-caster:GetOrigin()):Length2D()

	local arc_height = self:GetSpecialValueFor( "top_level_height" )
	local perch_height = self:GetSpecialValueFor( "perched_spot_height" )

	-- data above is fake news
	local perch_height = 256
	local height = 150

	-- jump
	local arc = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			target_x = point.x,
			target_y = point.y,
			distance = distance,
			speed = speed,
			height = height,
			fix_end = false,
			isStun = true,
			start_offset = perch_height,
		} -- kv
	)
	arc:SetEndCallback(function()
		-- find units
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			caster:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
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
			damage = damage,
			damage_type = self:GetAbilityDamageType(),
			ability = self, --Optional.
		}

		for _,enemy in pairs(enemies) do
			-- damage
			damageTable.victim = enemy
			ApplyDamage(damageTable)

			-- slow
			enemy:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_monkey_king_primal_spring_lua", -- modifier name
				{
					slow = slow,
					duration = duration,
				} -- kv
			)
		end

		-- play effects
		self:PlayEffects3( point, radius )
	end)

	-- swap abilities
	if self.sub then
		caster:SwapAbilities(
			'monkey_king_primal_spring_lua',
			'monkey_king_primal_spring_early_lua',
			true,
			false
		)
	end

	-- play effects
	self:PlayEffects4( arc )
	self:StopEffects()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function monkey_king_primal_spring_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_monkey_king/monkey_king_spring_channel.vpcf"

	-- Get Data
	local caster = self:GetCaster()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	-- ParticleManager:ReleaseParticleIndex( effect_cast )
	self.effect_cast1 = effect_cast
end

function monkey_king_primal_spring_lua:PlayEffects2( point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_monkey_king/monkey_king_spring_cast.vpcf"
	local sound_cast = "Hero_MonkeyKing.Spring.Channel"

	-- Get Data
	local caster = self:GetCaster()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_WORLDORIGIN, caster, caster:GetTeamNumber() )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 4, point )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, caster )

	self.effect_cast2 = effect_cast
end

function monkey_king_primal_spring_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast1, false )
	ParticleManager:DestroyParticle( self.effect_cast2, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast1 )
	ParticleManager:ReleaseParticleIndex( self.effect_cast2 )

	local sound_cast = "Hero_MonkeyKing.Spring.Channel"
	StopSoundOn( sound_cast, caster )
end

function monkey_king_primal_spring_lua:PlayEffects3( point, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_monkey_king/monkey_king_spring.vpcf"
	local sound_cast = "Hero_MonkeyKing.Spring.Impact"

	-- Get Data
	local caster = self:GetCaster()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, caster )
end

function monkey_king_primal_spring_lua:PlayEffects4( modifier )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf"
	local sound_cast = "Hero_MonkeyKing.TreeJump.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )

	-- buff particle
	modifier:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

--------------------------------------------------------------------------------
-- Cancel ability
--------------------------------------------------------------------------------
monkey_king_primal_spring_early_lua = class({})
function monkey_king_primal_spring_early_lua:OnSpellStart()
	self.main:EndChannel( true )
end