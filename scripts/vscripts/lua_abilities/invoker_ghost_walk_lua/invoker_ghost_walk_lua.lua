invoker_ghost_walk_lua = class({})
LinkLuaModifier( "modifier_invoker_ghost_walk_lua", "lua_abilities/invoker_ghost_walk_lua/modifier_invoker_ghost_walk_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_ghost_walk_lua_debuff", "lua_abilities/invoker_ghost_walk_lua/modifier_invoker_ghost_walk_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function invoker_ghost_walk_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_invoker_ghost_walk_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Effects
	self:PlayEffects()
end

function invoker_ghost_walk_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_invoker/invoker_ghost_walk.vpcf"
	local sound_cast = "Hero_Invoker.GhostWalk"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, caster )
end