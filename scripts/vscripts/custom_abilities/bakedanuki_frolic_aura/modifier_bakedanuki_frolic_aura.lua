modifier_bakedanuki_frolic_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bakedanuki_frolic_aura:IsHidden()
	return true
end

function modifier_bakedanuki_frolic_aura:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Aura
function modifier_bakedanuki_frolic_aura:IsAura()
	return (not self:GetParent():PassivesDisabled())
end

function modifier_bakedanuki_frolic_aura:GetModifierAura()
	return "modifier_bakedanuki_frolic_aura_effect"
end

function modifier_bakedanuki_frolic_aura:GetAuraRadius()
	return self.radius
end

function modifier_bakedanuki_frolic_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_bakedanuki_frolic_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bakedanuki_frolic_aura:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
end

function modifier_bakedanuki_frolic_aura:OnRefresh( kv )
	
end

function modifier_bakedanuki_frolic_aura:OnDestroy( kv )

end