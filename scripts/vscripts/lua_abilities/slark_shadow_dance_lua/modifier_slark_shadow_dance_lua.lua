modifier_slark_shadow_dance_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_slark_shadow_dance_lua:IsHidden()
	return false
end

function modifier_slark_shadow_dance_lua:IsDebuff()
	return false
end

function modifier_slark_shadow_dance_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Aura
function modifier_slark_shadow_dance_lua:IsAura()
	return self.scepter
end

function modifier_slark_shadow_dance_lua:GetModifierAura()
	return "modifier_slark_shadow_dance_lua"
end

function modifier_slark_shadow_dance_lua:GetAuraRadius()
	return self.radius
end

function modifier_slark_shadow_dance_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_slark_shadow_dance_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_slark_shadow_dance_lua:GetAuraDuration()
	return 0.5
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_shadow_dance_lua:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "scepter_aoe" ) -- special value

	-- generate data
	self.parent = self:GetParent()==self:GetCaster()
	self.scepter = self.parent and self:GetCaster():HasScepter()
end

function modifier_slark_shadow_dance_lua:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "scepter_aoe" ) -- special value
	
	-- generate data
	self.parent = self:GetParent()==self:GetCaster()
	self.scepter = self.parent and self:GetCaster():HasScepter()
end

function modifier_slark_shadow_dance_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_slark_shadow_dance_lua:CheckState()
	local state = {
	[MODIFIER_STATE_INVISIBLE] = true,
	[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
