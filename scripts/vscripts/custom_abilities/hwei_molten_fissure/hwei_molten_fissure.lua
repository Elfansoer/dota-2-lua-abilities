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
hwei_molten_fissure = class({})
LinkLuaModifier( "modifier_hwei_molten_fissure_aura", "custom_abilities/hwei_molten_fissure/modifier_hwei_molten_fissure_aura", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hwei_molten_fissure_debuff", "custom_abilities/hwei_molten_fissure/modifier_hwei_molten_fissure_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hwei_molten_fissure:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function hwei_molten_fissure:OnSpellStart()
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
	local last_thinker = nil
	while distance<range do
		distance = distance + width/2
		local thinker_position = caster:GetOrigin() + direction*distance

		-- create thinker
		last_thinker = CreateModifierThinker(
			caster, -- player source
			self, -- ability source
			"modifier_hwei_molten_fissure_aura", -- modifier name
			{ duration = duration }, -- kv
			thinker_position,
			caster:GetTeamNumber(),
			false
		)
	end

	self:PlayEffects( caster:GetOrigin(), caster:GetOrigin() + direction*distance, duration )
end

--------------------------------------------------------------------------------
-- Effects
function hwei_molten_fissure:PlayEffects( start_point, end_point, duration )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf"
	local sound_cast = "Hero_Jakiro.Macropyre.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, start_point )
	ParticleManager:SetParticleControl( effect_cast, 1, end_point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end