shaco_haunting_presence = class({})
LinkLuaModifier( "modifier_shaco_haunting_presence", "custom_abilities/shaco_haunting_presence/modifier_shaco_haunting_presence", LUA_MODIFIER_MOTION_HORIZONTAL )
local tempTable = require("util/tempTable")
--------------------------------------------------------------------------------
-- Ability Start
function shaco_haunting_presence:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- add modifier
	enemy = tempTable:AddATValue(target)
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_shaco_haunting_presence", -- modifier name
		{ 
			duration = duration,
			target = enemy,
		} -- kv
	)

	print("target:", target:GetUnitName(),", Illusion",target:IsIllusion())
end

--------------------------------------------------------------------------------
function shaco_haunting_presence:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end