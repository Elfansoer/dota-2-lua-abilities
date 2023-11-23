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
hwei_fleeting_current = class({})
LinkLuaModifier( "modifier_hwei_fleeting_current", "custom_abilities/hwei_fleeting_current/modifier_hwei_fleeting_current", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hwei_fleeting_current_aura", "custom_abilities/hwei_fleeting_current/modifier_hwei_fleeting_current_aura", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hwei_fleeting_current:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_hwei_windrunner.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hwei_fleeting_current/hwei_fleeting_current.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function hwei_fleeting_current:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local width = self:GetSpecialValueFor( "width" )
	local duration = self:GetSpecialValueFor( "duration" )
	local range = self:GetCastRange( point, nil )

	local direction = point-caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- spawn thinkers
	local distance = 0
	while distance<range do
		distance = distance + width/2
		local thinker_position = caster:GetOrigin() + direction*distance

		-- create thinker
		CreateModifierThinker(
			caster, -- player source
			self, -- ability source
			"modifier_hwei_fleeting_current_aura", -- modifier name
			{ duration = duration }, -- kv
			thinker_position,
			caster:GetTeamNumber(),
			false
		)
	end

	self:PlayEffectsCast( caster:GetOrigin(), caster:GetOrigin() + distance * direction, duration )
end

function hwei_fleeting_current:PlayEffectsCast( start_point, end_point, duration )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_jakiro/jakiro_ice_path_b.vpcf"
	local sound_cast = "Hero_Jakiro.IcePath"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, start_point )
	ParticleManager:SetParticleControl( effect_cast, 1, end_point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 9, start_point )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end