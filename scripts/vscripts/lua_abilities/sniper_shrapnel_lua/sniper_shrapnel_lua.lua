sniper_shrapnel_lua = class({})
LinkLuaModifier( "modifier_sniper_shrapnel_lua", "lua_abilities/sniper_shrapnel_lua/modifier_sniper_shrapnel_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_lua_charges", "lua_abilities/sniper_shrapnel_lua/modifier_sniper_shrapnel_lua_charges", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_lua_thinker", "lua_abilities/sniper_shrapnel_lua/modifier_sniper_shrapnel_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sniper_shrapnel_lua:GetIntrinsicModifierName()
	return "modifier_sniper_shrapnel_lua_charges"
end

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function sniper_shrapnel_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function sniper_shrapnel_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- logic
	CreateModifierThinker(
		caster,
		self,
		"modifier_sniper_shrapnel_lua_thinker",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)

	-- effects
	self:PlayEffects( point )
end

--------------------------------------------------------------------------------
function sniper_shrapnel_lua:PlayEffects( point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf"
	local sound_cast = "Hero_Sniper.ShrapnelShoot"

	-- Get Data
	local height = 2000

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetCaster():GetOrigin(), -- unknown
		false -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, point + Vector( 0, 0, height ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end