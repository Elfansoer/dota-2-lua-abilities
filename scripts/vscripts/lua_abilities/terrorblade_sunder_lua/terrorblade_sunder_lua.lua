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
terrorblade_sunder_lua = class({})
LinkLuaModifier( "modifier_terrorblade_sunder_lua", "lua_abilities/terrorblade_sunder_lua/modifier_terrorblade_sunder_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function terrorblade_sunder_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade_sunder_lua/terrorblade_sunder_lua.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function terrorblade_sunder_lua:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO,
		0,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function terrorblade_sunder_lua:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function terrorblade_sunder_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local min_pct = self:GetSpecialValueFor( "hit_point_minimum_pct" )

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- get health
	local health1 = math.max( min_pct, caster:GetHealthPercent() )/100
	local health2 = math.max( min_pct, target:GetHealthPercent() )/100

	-- swap health
	caster:ModifyHealth( caster:GetMaxHealth() * health2, self, false, DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DIRECTOR_EVENT )
	target:ModifyHealth( target:GetMaxHealth() * health1, self, false, DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DIRECTOR_EVENT )

	-- play effects
	self:PlayEffects( target )
end

--------------------------------------------------------------------------------
-- Effects
function terrorblade_sunder_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf"
	local sound_cast = "Hero_Terrorblade.Sunder.Cast"
	local sound_target = "Hero_Terrorblade.Sunder.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	-- ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
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
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end