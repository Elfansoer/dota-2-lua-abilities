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
marci_dispose_lua = class({})
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function marci_dispose_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_dispose_aoe_damage.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_dispose_debuff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_dispose_land_aoe.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_grapple.vpcf", context )
end

function marci_dispose_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function marci_dispose_lua:CastFilterResultTarget( hTarget )
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

function marci_dispose_lua:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function marci_dispose_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local duration = self:GetSpecialValueFor( "air_duration" )
	local height = self:GetSpecialValueFor( "air_height" )
	local distance = self:GetSpecialValueFor( "throw_distance_behind" )

	local radius = self:GetSpecialValueFor( "landing_radius" )
	local stun = self:GetSpecialValueFor( "stun_duration" )
	local damage = self:GetSpecialValueFor( "impact_damage" )

	-- set target pos
	local targetpos = caster:GetOrigin() - caster:GetForwardVector() * distance
	local totaldist = (target:GetOrigin() - targetpos):Length2D()

	-- create arc
	local arc = target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			target_x = targetpos.x,
			target_y = targetpos.y,
			duration = duration,
			distance = totaldist,
			height = height,
			fix_end = false,
			fix_duration = false,
			isStun = true,
			isForward = true,
			activity = ACT_DOTA_FLAIL,
		} -- kv
	)
	arc:SetEndCallback( function()
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
			-- stun
			enemy:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_generic_stunned_lua", -- modifier name
				{ duration = stun } -- kv
			)
			
			-- damage
			damageTable.victim = enemy
			ApplyDamage(damageTable)

			-- play effects
			self:PlayEffects2( enemy:GetOrigin() )

		end

		-- destroy trees
		GridNav:DestroyTreesAroundPoint( target:GetOrigin(), radius, false )

		-- play effects
		local allied = target:GetTeamNumber()==caster:GetTeamNumber()
		self:PlayEffects1( target:GetOrigin(), radius, allied )
	end)

	-- play effects
	self:PlayEffects3( caster, target, duration )
	self:PlayEffects4( caster )

end

--------------------------------------------------------------------------------
-- Effects
function marci_dispose_lua:PlayEffects1( point, radius, allied )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_dispose_land_aoe.vpcf"
	local sound_cast = "Hero_Marci.Grapple.Impact"
	if allied then
		sound_cast = "Hero_Marci.Grapple.Impact.Ally"
	end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius, 0, 0) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
end

function marci_dispose_lua:PlayEffects2( point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_dispose_aoe_damage.vpcf"
	local sound_cast = "Hero_Marci.Grapple.Stun"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
end

function marci_dispose_lua:PlayEffects3( caster, target, duration )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_dispose_debuff.vpcf"
	local sound_cast = "Hero_Marci.Grapple.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 5, Vector( duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end

function marci_dispose_lua:PlayEffects4( caster )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_grapple.vpcf"
	local sound_cast = "Hero_Marci.Grapple.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, caster )
end