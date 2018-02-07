azura_shadowform = class({})
LinkLuaModifier( "modifier_azura_shadowform", "custom_abilities/azura_shadowform/modifier_azura_shadowform", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function azura_shadowform:OnSpellStart()
	-- get references
	local duration = self:GetSpecialValueFor("duration_tooltip")

	-- remove previously cast modifier
	self:ReleaseUnits()

	-- add modifier
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_azura_shadowform",
		{ duration = duration }
	)

	self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Helper functions
azura_shadowform.affected_units = {}
function azura_shadowform:AddAffectedUnits( unit )
	table.insert(self.affected_units,unit)
end

function azura_shadowform:ReleaseUnits()
	for _,unit in pairs(self.affected_units) do
		local modifier = unit:FindModifierByNameAndCaster("modifier_azura_shadowform", self:GetCaster())
		if modifier~=nil then
			modifier:Destroy()
		end
	end
	self.affected_units = {}
end

--------------------------------------------------------------------------------
function azura_shadowform:PlayEffects()
	-- local nFXIndex = ParticleManager:CreateParticle( particle_target, PATTACH_WORLDORIGIN, nil )
	-- ParticleManager:SetParticleControl( nFXIndex, 0, target:GetOrigin() )
	-- ParticleManager:SetParticleControl( nFXIndex, 1, target:GetOrigin() )
	-- ParticleManager:ReleaseParticleIndex( nFXIndex )

	-- EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	-- EmitSoundOn( sound_target, target )
end