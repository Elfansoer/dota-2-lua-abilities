chaos_knight_phantasm_lua = class({})
LinkLuaModifier( "modifier_chaos_knight_phantasm_lua", "lua_abilities/chaos_knight_phantasm_lua/modifier_chaos_knight_phantasm_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_illusion_lua", "lua_abilities/generic/modifier_generic_illusion_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Behavior
function chaos_knight_phantasm_lua:GetBehavior()
	if self:GetCaster():HasScepter() then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

--------------------------------------------------------------------------------
-- Ability Start
function chaos_knight_phantasm_lua:OnSpellStart()
	-- get references
	local inv_duration = self:GetSpecialValueFor("invuln_duration")

	local target = self:GetCaster()
	if target:HasScepter() then
		target = self:GetCursorTarget()
	end

	-- Add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_chaos_knight_phantasm_lua", -- modifier name
		{ duration = inv_duration } -- kv
	)
end

--------------------------------------------------------------------------------
-- Ability Considerations
function chaos_knight_phantasm_lua:AbilityConsiderations()
	-- Scepter
	local bScepter = caster:HasScepter()

	-- Linken & Lotus
	local bBlocked = target:TriggerSpellAbsorb( self )

	-- Break
	local bBroken = caster:PassivesDisabled()

	-- Advanced Status
	local bInvulnerable = target:IsInvulnerable()
	local bInvisible = target:IsInvisible()
	local bHexed = target:IsHexed()
	local bMagicImmune = target:IsMagicImmune()

	-- Illusion Copy
	local bIllusion = target:IsIllusion()
end

--------------------------------------------------------------------------------
-- Helpers
chaos_knight_phantasm_lua.illusions = {}

--------------------------------------------------------------------------------
function chaos_knight_phantasm_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )

	-- Control Particle
	-- Set vector attachment
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )

	-- Set entity attachment
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)

	-- Set particle orientation
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )

	-- Release Particle
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	buff:AddParticle(
		nFXIndex,
		bDestroyImmediately,
		bStatusEffect,
		iPriority,
		bHeroEffect,
		bOverheadEffect
	)

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end