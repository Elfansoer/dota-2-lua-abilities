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
huskar_inner_vitality_lua = class({})
LinkLuaModifier( "modifier_huskar_inner_vitality_lua", "lua_abilities/huskar_inner_vitality_lua/modifier_huskar_inner_vitality_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function huskar_inner_vitality_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetDuration()

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_huskar_inner_vitality_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	self:PlayEffects( target )
end

-- --------------------------------------------------------------------------------
function huskar_inner_vitality_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_huskar/huskar_inner_vitality_cast.vpcf"
	local sound_cast = "Hero_Huskar.Inner_Vitality"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	local sound_cast = "Hero_Huskar.Inner_Vitality"
	EmitSoundOn( sound_cast, target )
end