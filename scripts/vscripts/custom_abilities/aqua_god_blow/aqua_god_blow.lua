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
aqua_god_blow = class({})
LinkLuaModifier( "modifier_aqua_god_blow", "custom_abilities/aqua_god_blow/modifier_aqua_god_blow", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_vector_target", "lua_abilities/generic/modifier_generic_vector_target", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function aqua_god_blow:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur_warrunner.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tusk.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", context )
	PrecacheResource( "particle", "particles/ui_mouseactions/range_finder_generic_aoe_nocenter.vpcf", context )
end

function aqua_god_blow:Spawn()
	-- register custom indicator
	if not IsServer() then
		CustomIndicator:RegisterAbility( self )
		return
	end
end

--------------------------------------------------------------------------------
-- Custom KV
function aqua_god_blow:GetCastRange( vLocation, hTarget )
	return self:GetSpecialValueFor( "fix_castrange" ) - self:GetCaster():GetCastRangeBonus()
end

--------------------------------------------------------------------------------
-- Passive Modifier
function aqua_god_blow:GetIntrinsicModifierName()
	return "modifier_generic_vector_target"
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator (using CustomIndicator library, this section is Client Lua only)
function aqua_god_blow:CreateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor( "radius" )

	-- primary cast unit
	self.client_vector_unit = unit or self:GetCaster()

	local particle_cast = "particles/ui_mouseactions/range_finder_generic_aoe_nocenter.vpcf"
	self.indicator = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.client_vector_unit )
	ParticleManager:SetParticleControl( self.indicator, 3, Vector( radius, 0, 0 ) )

	-- do logic that is similar to update func
	self:UpdateCustomIndicator( position, unit, behavior )
end

function aqua_god_blow:UpdateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local caster = self:GetCaster()
	local min_range = self:GetSpecialValueFor( "min_distance" )
	local max_range = self:GetSpecialValueFor( "max_distance" ) + caster:GetCastRangeBonus()
	local vector_origin = self.client_vector_unit:GetAbsOrigin()

	local enemy_pct = self:GetSpecialValueFor( "enemy_distance" )
	if self.client_vector_unit:GetTeamNumber()~=caster:GetTeamNumber() then
		max_range = max_range * enemy_pct/100
	end

	-- min/max jump distance
	local jump_direction = position - vector_origin
	local jump_distance = jump_direction:Length2D()
	jump_direction.z = 0
	jump_direction = jump_direction:Normalized()

	local jump_position = vector_origin + jump_direction * math.max( min_range, math.min( jump_distance, max_range ) )
	
	ParticleManager:SetParticleControl( self.indicator, 0, self.client_vector_unit:GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.indicator, 1, self.client_vector_unit:GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.indicator, 2, jump_position )
	ParticleManager:SetParticleControl( self.indicator, 12, jump_position )
end

function aqua_god_blow:DestroyCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- destroy particle
	ParticleManager:DestroyParticle(self.indicator, false)
	ParticleManager:ReleaseParticleIndex(self.indicator)

	self.client_vector_unit  = nil
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function aqua_god_blow:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function aqua_god_blow:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function aqua_god_blow:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self.vector_position

	-- load data
	local damage = self:GetSpecialValueFor( "damage" )
	local duration = self:GetSpecialValueFor( "duration" )
	local slow = self:GetSpecialValueFor( "slow" )
	local radius = self:GetSpecialValueFor( "radius" )

	local speed = self:GetSpecialValueFor( "speed" )
	local min_distance = self:GetSpecialValueFor( "min_distance" )
	local max_distance = self:GetSpecialValueFor( "max_distance" ) + caster:GetCastRangeBonus()
	local enemy_pct = self:GetSpecialValueFor( "enemy_distance" )
	if target:GetTeamNumber()~=caster:GetTeamNumber() then
		max_distance = max_distance * enemy_pct/100
	end

	local height = 100

	local origin =  target:GetOrigin()
	local direction = point - origin
	local distance = direction:Length2D()
	distance = math.min(math.max(distance,min_distance),max_distance)

	direction.z = 0
	direction = direction:Normalized()

	target:SetForwardVector( direction )

	-- create arc
	local arc = target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{ 
			dir_x = direction.x,
			dir_y = direction.y,
			speed = speed,
			distance = distance,
			height = height,
			fix_end = false,
			fix_height = false,
			isStun = false,
			isForward = true,
			activity = ACT_DOTA_FLAIL,
		} -- kv
	)
	arc:SetEndCallback( function( interrupted )
		-- find enemies
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			target:GetOrigin(),	-- point, center point
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
			damage_type = DAMAGE_TYPE_MAGICAL,
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
				"modifier_aqua_god_blow", -- modifier name
				{ duration = duration } -- kv
			)
		end

		-- play effects
		self:PlayEffects( target, radius )
	end)

	EmitSoundOn( "Hero_Tusk.WalrusKick.Target", target )
end

function aqua_god_blow:PlayEffects( target, radius )
	-- get particles
	local particle_cast = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
	local sound_cast = "Hero_Centaur.HoofStomp"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 0, target:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius, radius, radius) )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hoof_L",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hoof_R",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOnLocationWithCaster( target:GetOrigin(), sound_cast, target )
end