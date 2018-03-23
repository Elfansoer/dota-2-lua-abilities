chaos_knight_reality_rift_lua = class({})
LinkLuaModifier( "modifier_chaos_knight_reality_rift_lua", "lua_abilities/chaos_knight_reality_rift_lua/modifier_chaos_knight_reality_rift_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function chaos_knight_reality_rift_lua:OnAbilityPhaseInterrupted()
	-- StopEffects
	-- local sound_cast = "Hero_ChaosKnight.RealityRift"
	-- StopSoundOn( sound_cast, self:GetCaster() )
end
function chaos_knight_reality_rift_lua:OnAbilityPhaseStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- Generate data
	local min_loc = 50
	local max_loc = 55

	-- set central point
	self.point = SplineVectors( caster:GetOrigin(), target:GetOrigin(), RandomInt(min_loc,max_loc)/100 )

	-- PlayEffects
	self:PlayEffects1( caster, target, self.point )

	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function chaos_knight_reality_rift_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then
		return
	end

	-- load data
	local point = self.point
	local bDuration = self:GetSpecialValueFor("armor_duration")
	
	-- generate data
	local search_radius = 1375
	local distance = 64
	self.point = nil

	-- Set caster position
	local relative = (point - caster:GetOrigin()):Normalized() * distance
	selfLoc = point + relative

	-- Find illusion within radius
	local heroes = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		search_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	local illusions = {}
	for _,hero in pairs(heroes) do
		if hero:IsIllusion() and hero:GetPlayerOwnerID()==caster:GetPlayerOwnerID() then
			table.insert( illusions, hero )
		end
	end

	-- Move everything and set aggresive stance
	target:SetOrigin( point )
	FindClearSpaceForUnit( target, point, true )

	caster:SetOrigin( selfLoc )
	FindClearSpaceForUnit( caster, selfLoc, true )
	caster:SetForwardVector( (target:GetOrigin()-caster:GetOrigin()):Normalized() )
	caster:MoveToTargetToAttack( target )

	for _,illusion in pairs(illusions) do
		illusion:SetOrigin( point )
		FindClearSpaceForUnit( illusion, point, false )
		illusion:SetForwardVector( (target:GetOrigin()-illusion:GetOrigin()):Normalized() )
		illusion:MoveToTargetToAttack( target )
	end

	-- Add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_chaos_knight_reality_rift_lua", -- modifier name
		{ duration = bDuration } -- kv
	)

	-- Play Effects
	self:PlayEffects( caster, target )
end

--------------------------------------------------------------------------------
-- Ability Considerations
function chaos_knight_reality_rift_lua:AbilityConsiderations()
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
function chaos_knight_reality_rift_lua:PlayEffects( caster, target )
	-- Get Resources
	local sound_target = "Hero_ChaosKnight.RealityRift.Target"

	-- Create Sound
	EmitSoundOn( sound_target, target )
end

function chaos_knight_reality_rift_lua:PlayEffects1( caster, target, point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_chaos_knight/chaos_knight_reality_rift.vpcf"
	local sound_cast = "Hero_ChaosKnight.RealityRift"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( self.effect_cast, 2, point )
	ParticleManager:SetParticleControlForward( self.effect_cast, 2, (target:GetOrigin()-caster:GetOrigin()):Normalized() )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	EmitSoundOn( sound_cast, caster )
end