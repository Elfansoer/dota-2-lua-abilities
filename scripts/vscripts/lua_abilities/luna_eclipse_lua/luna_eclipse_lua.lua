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
luna_eclipse_lua = class({})
LinkLuaModifier( "modifier_luna_eclipse_lua", "lua_abilities/luna_eclipse_lua/modifier_luna_eclipse_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function luna_eclipse_lua:GetAOERadius()
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "radius" )
	end
	return 0
end

function luna_eclipse_lua:GetBehavior()
	if self:GetCaster():HasScepter() then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_OPTIONAL_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end

	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function luna_eclipse_lua:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cast_range_tooltip_scepter" )
	end
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Phase Start
-- function luna_eclipse_lua:OnAbilityPhaseInterrupted()

-- end
-- function luna_eclipse_lua:OnAbilityPhaseStart()
-- 	return true -- if success
-- end

--------------------------------------------------------------------------------
-- Ability Start
function luna_eclipse_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- find damage
	local damage = 0
	if self.damage then
		-- if stolen
		damage = self.damage
	else
		local ability = caster:FindAbilityByName( "luna_lucent_beam_lua" )
		if ability and ability:GetLevel()>0 then
			damage = ability:GetLevelSpecialValueFor( "beam_damage", ability:GetLevel()-1 ) -- zero-based
		end
	end

	-- check scepter
	local unit = caster
	if caster:HasScepter() then
		if target then
			unit = target
		else
			unit = nil
		end
	end

	-- add eclipse modifier
	if unit then
		unit:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_luna_eclipse_lua", -- modifier name
			{
				damage = damage,
			} -- kv
		)
	else
		caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_luna_eclipse_lua", -- modifier name
			{
				damage = damage,
				point = 1,
				pointx = point.x,
				pointy = point.y,
				pointz = point.z,
			} -- kv
		)
	end

	-- begin night
	GameRules:BeginTemporaryNight( 10 )
end

function luna_eclipse_lua:OnStolen( hSourceAbility )
	self.damage = 0
	local ability = hSourceAbility:GetCaster():FindAbilityByName( "luna_lucent_beam_lua" )
	if ability and ability:GetLevel()>0 then
		self.damage = ability:GetLevelSpecialValueFor( "beam_damage", ability:GetLevel()-1 ) -- zero-based
	end
end
--------------------------------------------------------------------------------
-- function luna_eclipse_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end