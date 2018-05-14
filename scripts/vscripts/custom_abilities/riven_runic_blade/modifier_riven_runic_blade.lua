modifier_riven_runic_blade = class({})
local tempTable = require("util/tempTable")
--------------------------------------------------------------------------------
-- Classifications
function modifier_riven_runic_blade:IsHidden()
	return self:GetStackCount()==0
end

function modifier_riven_runic_blade:IsDebuff()
	return false
end

function modifier_riven_runic_blade:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_riven_runic_blade:OnCreated( kv )
	-- references
	self.crit_per_stack = self:GetAbility():GetSpecialValueFor( "crit_per_stack" )
	self.stack_duration = self:GetAbility():GetSpecialValueFor( "stack_duration" )

	-- data
	self.current_stack = 0
end

function modifier_riven_runic_blade:OnRefresh( kv )
	-- references
	self.crit_per_stack = self:GetAbility():GetSpecialValueFor( "crit_per_stack" )
	self.stack_duration = self:GetAbility():GetSpecialValueFor( "stack_duration" )	
end

function modifier_riven_runic_blade:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_riven_runic_blade:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end
function modifier_riven_runic_blade:OnAbilityFullyCast( params )
	if IsServer() then
		if params.unit~=self:GetParent() or self:GetParent():PassivesDisabled() or params.ability:IsItem() then return end
		self:AddStack()
	end
end

function modifier_riven_runic_blade:GetModifierPreAttack_CriticalStrike()
	return 100 + self:GetStackCount()
end

--------------------------------------------------------------------------------
-- Helper functions
function modifier_riven_runic_blade:RefreshStack()
	self:SetStackCount( self.current_stack * self.crit_per_stack )
end

function modifier_riven_runic_blade:AddStack()
	self.current_stack = self.current_stack + 1
	self:RefreshStack()

	local parent = tempTable:AddATValue( self )
	self:GetParent():AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_riven_runic_blade_stack", -- modifier name
		{
			duration = self.stack_duration,
			parent = parent,
		} -- kv
	)
end

function modifier_riven_runic_blade:RemoveStack()
	self.current_stack = self.current_stack - 1
	self:RefreshStack()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_riven_runic_blade:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_riven_runic_blade:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_riven_runic_blade:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		nFXIndex,
-- 		bDestroyImmediately,
-- 		bStatusEffect,
-- 		iPriority,
-- 		bHeroEffect,
-- 		bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end