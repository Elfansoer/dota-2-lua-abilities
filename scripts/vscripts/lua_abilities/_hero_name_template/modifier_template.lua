modifier_template = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_template:IsHidden()
	return false
end

function modifier_template:IsDebuff()
	return false
end

function modifier_template:IsStunDebuff()
	return false
end

function modifier_template:GetAttributes()
	return MODIFIER_ATRRIBUTE_XX + MODIFIER_ATRRIBUTE_YY 
end

function modifier_template:IsPurgable()
	return true
end
--------------------------------------------------------------------------------
-- Aura
function modifier_template:IsAura()
	return true
end

function modifier_template:GetModifierAura()
	return "modifier_template_effect"
end

function modifier_template:GetAuraRadius()
	return float
end

function modifier_template:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_XX
end

function modifier_template:GetAuraSearchType()
	return DOTA_UNIT_TARGET_XX + DOTA_UNIT_TARGET_YY + ...
end

function modifier_template:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_template:OnCreated( kv )
	-- references
	self.special_value = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_template:OnRefresh( kv )
	
end

function modifier_template:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_template:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_XX,
		MODIFIER_EVENT_YY,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_template:CheckState()
	local state = {
	[MODIFIER_STATE_XX] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_template:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_template:GetEffectName()
	return "particles/string/here.vpcf"
end

function modifier_template:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end