invoker_cold_snap_lua = class({})
LinkLuaModifier( "modifier_invoker_cold_snap_lua", "lua_abilities/invoker_cold_snap_lua/modifier_invoker_cold_snap_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function invoker_cold_snap_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetOrbSpecialValueFor("duration", "q")

	-- logic
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_invoker_cold_snap_lua", -- modifier name
		{ duration = duration } -- kv
	)

	self:PlayEffects( target )
end

--------------------------------------------------------------------------------
function invoker_cold_snap_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf"
	local sound_cast = "Hero_Invoker.ColdSnap.Cast"
	local sound_target = "Hero_Invoker.ColdSnap"

	-- Get Data
	local direction = target:GetOrigin()-self:GetCaster():GetOrigin()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster():GetOrigin() + direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end