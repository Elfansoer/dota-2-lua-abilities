azura_shadowform = class({})
LinkLuaModifier( "modifier_azura_shadowform", "custom_abilities/azura_shadowform/modifier_azura_shadowform", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function azura_shadowform:OnSpellStart()
	-- get references
	local duration = self:GetSpecialValueFor("duration_tooltip")

	-- remove previously cast modifier
	self:CancelAbility()

	-- add modifier
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_azura_shadowform",
		{ duration = duration }
	)

	-- swap layout
	self:SetLayout( false )

	-- play effects
	self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Helper functions
azura_shadowform.layout_main = true		-- which ability is currently shown
azura_shadowform.affected_units = {}	-- affected units

function azura_shadowform:AddAffectedUnits( unit )
	table.insert(self.affected_units,unit)
end

function azura_shadowform:CancelAbility()
	-- release units under buffs
	for _,unit in pairs(self.affected_units) do
		local modifier = unit:FindModifierByNameAndCaster("modifier_azura_shadowform", self:GetCaster())
		if modifier~=nil then
			modifier:Destroy()
		end
	end
	self.affected_units = {}

	-- reset layout
	self:SetLayout( true )
end

--------------------------------------------------------------------------------
function azura_shadowform:SetLayout( main )
	-- if different ability is shown, swap
	if self.layout_main~=main then
		local ability_main = "azura_shadowform"
		local ability_sub = "azura_shadowform_cancel"

		-- swap
		self:GetCaster():SwapAbilities( ability_main, ability_sub, main, (not main) )
		self.layout_main = main
	end
end

function azura_shadowform:PlayEffects()
	-- local nFXIndex = ParticleManager:CreateParticle( particle_target, PATTACH_WORLDORIGIN, nil )
	-- ParticleManager:SetParticleControl( nFXIndex, 0, target:GetOrigin() )
	-- ParticleManager:SetParticleControl( nFXIndex, 1, target:GetOrigin() )
	-- ParticleManager:ReleaseParticleIndex( nFXIndex )

	-- EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	-- EmitSoundOn( sound_target, target )
end

--------------------------------------------------------------------------------
-- Helper Ability
azura_shadowform_cancel = class({})
function azura_shadowform_cancel:OnSpellStart()
	local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_azura_shadowform", self:GetCaster() )
	if modifier~=nil then
		modifier:Destroy()
	end
end