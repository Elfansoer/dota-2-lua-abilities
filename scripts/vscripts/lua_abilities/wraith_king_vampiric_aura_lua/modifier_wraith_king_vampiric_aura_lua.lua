modifier_wraith_king_vampiric_aura_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wraith_king_vampiric_aura_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Aura
function modifier_wraith_king_vampiric_aura_lua:IsAura()
	return true
end

function modifier_wraith_king_vampiric_aura_lua:GetModifierAura()
	return "modifier_wraith_king_vampiric_aura_lua_lifesteal"
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraRadius()
	return self.aura_radius
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraSearchTeam()
	if not self:GetParent():PassivesDisabled() then
		return DOTA_UNIT_TARGET_TEAM_FRIENDLY
	end
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraSearchType()
	if self:GetAbility():GetToggleState() then
		return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	end
	
	return DOTA_UNIT_TARGET_HERO
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_wraith_king_vampiric_aura_lua:OnCreated( kv )
	-- references
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "vampiric_aura_radius" ) -- special value
end

function modifier_wraith_king_vampiric_aura_lua:OnRefresh( kv )
	-- references
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "vampiric_aura_radius" ) -- special value
end