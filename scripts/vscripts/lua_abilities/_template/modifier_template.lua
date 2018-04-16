modifier_template_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_template_lua:IsHidden()
	return false
end

function modifier_template_lua:IsDebuff()
	return false
end

function modifier_template_lua:IsStunDebuff()
	return false
end

function modifier_template_lua:GetAttributes()
	return MODIFIER_ATRRIBUTE_XX + MODIFIER_ATRRIBUTE_YY 
end

function modifier_template_lua:IsPurgable()
	return true
end
--------------------------------------------------------------------------------
-- Aura
function modifier_template_lua:IsAura()
	return true
end

function modifier_template_lua:GetModifierAura()
	return "modifier_template_effect_lua"
end

function modifier_template_lua:GetAuraRadius()
	return float
end

function modifier_template_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_XX
end

function modifier_template_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_XX + DOTA_UNIT_TARGET_YY + ...
end

function modifier_template_lua:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_template_lua:OnCreated( kv )
	-- references
	self.special_value = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_template_lua:OnRefresh( kv )
	
end

function modifier_template_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_template_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_XX,
		MODIFIER_EVENT_YY,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_template_lua:CheckState()
	local state = {
	[MODIFIER_STATE_XX] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_template_lua:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_template_lua:GetEffectName()
	return "particles/string/here.vpcf"
end

function modifier_template_lua:GetEffectAttachType()
	return PATTACH_XX
end