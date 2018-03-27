bakedanuki_futatsuiwas_curse = class({})
LinkLuaModifier( "modifier_bakedanuki_futatsuiwas_curse", "custom_abilities/bakedanuki_futatsuiwas_curse/modifier_bakedanuki_futatsuiwas_curse", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Cast Filter
-- function bakedanuki_futatsuiwas_curse:CastFilterResult()
-- 	if self:GetCaster() == hTarget then
-- 		return UF_FAIL_CUSTOM
-- 	end

-- 	local nResult = UnitFilter(
-- 		hTarget,
-- 		DOTA_UNIT_TARGET_TEAM_BOTH,
-- 		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
-- 		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
-- 		self:GetCaster():GetTeamNumber()
-- 	)
-- 	if nResult ~= UF_SUCCESS then
-- 		return nResult
-- 	end

-- 	return UF_SUCCESS
-- end

-- function bakedanuki_futatsuiwas_curse:GetCustomCastErrorTarget( hTarget )
-- 	if self:GetCaster() == hTarget then
-- 		return "#dota_hud_error_cant_cast_on_self"
-- 	end

-- 	return ""
-- end
--------------------------------------------------------------------------------
-- Ability Phase Start
-- function bakedanuki_futatsuiwas_curse:OnAbilityPhaseInterrupted()

-- end
function bakedanuki_futatsuiwas_curse:OnAbilityPhaseStart()
	self:PlayEffects()
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function bakedanuki_futatsuiwas_curse:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local hexDuration = self:GetSpecialValueFor( "hex_duration" )
	local radius = self:GetSpecialValueFor( "search_radius" )
	local range = self:GetSpecialValueFor( "search_range" )
	local point = caster:GetOrigin() + caster:GetForwardVector() * range

	-- find enemies in front of caster
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_FARTHEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- if no unit found, return
	if #enemies<1 then
		return
	end

	-- filter target unit: hero, creep-hero, illusion, summon, creep
	local filter = {}
	local target = nil
	for _,enemy in pairs(enemies) do
		if enemy:IsRealHero() then
			filter[1] = enemy
		elseif enemy:IsConsideredHero() then
			filter[2] = enemy
		elseif enemy:IsOwnedByAnyPlayer() then
			filter[3] = enemy
		else
			filter[4] = enemy
		end
	end
	for i=1,4 do
		if filter[i] then
			target = filter[i]
			break
		end
	end

	-- Add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bakedanuki_futatsuiwas_curse", -- modifier name
		{ duration = hexDuration } -- kv
	)
end

--------------------------------------------------------------------------------
-- Ability Considerations
function bakedanuki_futatsuiwas_curse:AbilityConsiderations()
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
function bakedanuki_futatsuiwas_curse:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell_ring.vpcf"

	-- Get data
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor( "search_radius" )
	local range = self:GetSpecialValueFor( "search_range" )
	local point = caster:GetOrigin() + caster:GetForwardVector() * range
	
	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius, radius, radius) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end