dazzle_weave_lua = class({})
LinkLuaModifier( "modifier_dazzle_weave_lua", "lua_abilities/dazzle_weave_lua/modifier_dazzle_weave_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function dazzle_weave_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function dazzle_weave_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local radius = self:GetSpecialValueFor("radius")
	local bDuration = self:GetSpecialValueFor("duration")
	local visionDuration = 3

	-- Find Units in Radius
	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,hero in pairs(heroes) do
		-- Add modifier
		hero:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_dazzle_weave_lua", -- modifier name
			{ duration = bDuration } -- kv
		)
	end

	-- Add viewer
	AddFOWViewer( caster:GetTeamNumber(), point, radius, visionDuration, true )

	-- Play effects
	self:PlayEffects( point )
end

--------------------------------------------------------------------------------
-- Ability Considerations
function dazzle_weave_lua:AbilityConsiderations()
	-- Scepter
	local bScepter = caster:HasScepter()

	-- Linken & Lotus
	local bBlocked = target:TriggerSpellAbsorb( self )

	-- Break
	local bBroken = caster:PassivesDisabled()

	-- Advanced Status
	local bInvulnerable = target:IsInvulnerable()
	local bInvisible = target:IsInvisible()
	local bHexed = target:IsHexed()
	local bMagicImmune = target:IsMagicImmune()

	-- Illusion Copy
	local bIllusion = target:IsIllusion()
end

--------------------------------------------------------------------------------
function dazzle_weave_lua:PlayEffects( point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dazzle/dazzle_weave.vpcf"
	local sound_cast = "Hero_Dazzle.Weave"

	-- Get Data
	local radius = self:GetSpecialValueFor("radius")

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
end