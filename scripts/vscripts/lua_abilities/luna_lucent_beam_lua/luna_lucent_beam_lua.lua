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
luna_lucent_beam_lua = class({})
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function luna_lucent_beam_lua:OnAbilityPhaseInterrupted()

end

function luna_lucent_beam_lua:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects1()
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function luna_lucent_beam_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor("stun_duration")
	local damage = self:GetSpecialValueFor("beam_damage")

	-- damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
	}
	ApplyDamage(damageTable)

	-- stun
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- effects
	self:PlayEffects2( target )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function luna_lucent_beam_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_luna/luna_lucent_beam_precast.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(0.4,0,0) )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	-- ParticleManager:SetParticleControlEnt(
	-- 	effect_cast,
	-- 	2,
	-- 	self:GetCaster(),
	-- 	PATTACH_POINT_FOLLOW,
	-- 	"attach_attack1",
	-- 	Vector(0,0,0), -- unknown
	-- 	true -- unknown, true
	-- )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function luna_lucent_beam_lua:PlayEffects2( target )
	local particle_cast = "particles/units/heroes/hero_luna/luna_lucent_beam.vpcf"
	local sound_cast = "Hero_Luna.LucentBeam.Cast"
	local sound_target = "Hero_Luna.LucentBeam.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_color"))(self,effect_cast)
	ParticleManager:SetParticleControl( effect_cast, 0, target:GetOrigin() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		5,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		6,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end