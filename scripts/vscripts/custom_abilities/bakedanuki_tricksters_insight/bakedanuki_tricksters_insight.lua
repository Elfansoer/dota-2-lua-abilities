bakedanuki_tricksters_insight = class({})
LinkLuaModifier( "modifier_bakedanuki_tricksters_insight", "custom_abilities/bakedanuki_tricksters_insight/modifier_bakedanuki_tricksters_insight", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bakedanuki_tricksters_insight_passive", "custom_abilities/bakedanuki_tricksters_insight/modifier_bakedanuki_tricksters_insight_passive", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function bakedanuki_tricksters_insight:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb( self ) then
		return
	end

	-- load data
	local bDuration = self:GetSpecialValueFor("crit_duration")

	-- Add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bakedanuki_tricksters_insight_passive", -- modifier name
		{ duration = bDuration } -- kv
	)
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bakedanuki_tricksters_insight", -- modifier name
		{ duration = bDuration } -- kv
	)
end

--------------------------------------------------------------------------------
-- Ability Considerations
function bakedanuki_tricksters_insight:AbilityConsiderations()
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
function bakedanuki_tricksters_insight:PlayEffects()
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