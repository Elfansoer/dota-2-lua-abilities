grimstroke_soulbind_lua = class({})
LinkLuaModifier( "modifier_grimstroke_soulbind_lua", "lua_abilities/grimstroke_soulbind_lua/modifier_grimstroke_soulbind_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function grimstroke_soulbind_lua:GetAOERadius()
	return self:GetSpecialValueFor( "chain_latch_radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function grimstroke_soulbind_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local duration = self:GetSpecialValueFor( "chain_duration" )

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_grimstroke_soulbind_lua", -- modifier name
		{ 
			duration = duration,
			primary = true,
		 } -- kv
	)

	-- play effects
	self:PlayEffects( target )
end

--------------------------------------------------------------------------------
function grimstroke_soulbind_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_cast_soulchain.vpcf"
	local sound_cast = "Hero_Grimstroke.SoulChain.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_color"))(self,effect_cast)
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
end