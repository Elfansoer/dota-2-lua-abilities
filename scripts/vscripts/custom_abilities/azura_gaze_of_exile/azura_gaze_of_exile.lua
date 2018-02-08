azura_gaze_of_exile = class({})
LinkLuaModifier( "modifier_azura_gaze_of_exile", "custom_abilities/azura_gaze_of_exile/modifier_azura_gaze_of_exile", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_azura_gaze_of_exile_buff", "custom_abilities/azura_gaze_of_exile/modifier_azura_gaze_of_exile_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_azura_gaze_of_exile_debuff", "custom_abilities/azura_gaze_of_exile/modifier_azura_gaze_of_exile_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function azura_gaze_of_exile:OnSpellStart()
	-- unit identifier
	caster = self:GetCaster()
	target = self:GetCursorTarget()
	point = self:GetCursorPosition()

	-- load data
	local duration_tooltip = self:GetSpecialValueFor("duration_tooltip")

	-- Add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_azura_gaze_of_exile", -- modifier name
		{ duration = duration_tooltip } -- kv
	)

	-- play effects
	self:PlayEffects()
end

--------------------------------------------------------------------------------
function azura_gaze_of_exile:PlayEffects()
	-- local nFXIndex = ParticleManager:CreateParticle( particle_target, PATTACH_WORLDORIGIN, nil )
	-- ParticleManager:SetParticleControl( nFXIndex, 0, target:GetOrigin() )
	-- ParticleManager:SetParticleControl( nFXIndex, 1, target:GetOrigin() )
	-- ParticleManager:ReleaseParticleIndex( nFXIndex )

	-- EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	-- EmitSoundOn( sound_target, target )
end