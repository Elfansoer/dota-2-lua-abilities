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
maple_cover_move = class({})
LinkLuaModifier( "modifier_maple_cover_move", "custom_abilities/maple_cover_move/modifier_maple_cover_move", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Cast Filter
function maple_cover_move:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function maple_cover_move:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function maple_cover_move:OnAbilityPhaseInterrupted()

end
function maple_cover_move:OnAbilityPhaseStart()
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function maple_cover_move:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local origin = caster:GetOrigin()
	local point = target:GetOrigin()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- teleport
	ProjectileManager:ProjectileDodge( caster )
	FindClearSpaceForUnit( caster, point, true )

	-- add shield modifier
	target:AddNewModifier(
		caster,
		self,
		"modifier_maple_cover_move",
		{duration = duration}
	)

	-- Play effects
	self:PlayEffects( origin, caster:GetOrigin() )
end

--------------------------------------------------------------------------------
-- Effects
function maple_cover_move:PlayEffects( origin, target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, origin )
	ParticleManager:SetParticleControl( effect_cast, 1, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end
