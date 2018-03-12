modifier_wraith_king_mortal_strike_lua_spawn = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wraith_king_mortal_strike_lua_spawn:IsHidden()
	return false
end

function modifier_wraith_king_mortal_strike_lua_spawn:IsDebuff()
	return false
end

function modifier_wraith_king_mortal_strike_lua_spawn:IsStunDebuff()
	return false
end

function modifier_wraith_king_mortal_strike_lua_spawn:GetAttributes()
	return MODIFIER_ATRRIBUTE_XX + MODIFIER_ATRRIBUTE_YY 
end

function modifier_wraith_king_mortal_strike_lua_spawn:IsPurgable()
	return true
end
--------------------------------------------------------------------------------
-- Aura
function modifier_wraith_king_mortal_strike_lua_spawn:IsAura()
	return true
end

function modifier_wraith_king_mortal_strike_lua_spawn:GetModifierAura()
	return "modifier_wraith_king_mortal_strike_lua_spawn_effect"
end

function modifier_wraith_king_mortal_strike_lua_spawn:GetAuraRadius()
	return float
end

function modifier_wraith_king_mortal_strike_lua_spawn:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_XX
end

function modifier_wraith_king_mortal_strike_lua_spawn:GetAuraSearchType()
	return DOTA_UNIT_TARGET_XX + DOTA_UNIT_TARGET_YY + ...
end

function modifier_wraith_king_mortal_strike_lua_spawn:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wraith_king_mortal_strike_lua_spawn:OnCreated( kv )
	-- references
	self.special_value = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_wraith_king_mortal_strike_lua_spawn:OnRefresh( kv )
	
end

function modifier_wraith_king_mortal_strike_lua_spawn:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wraith_king_mortal_strike_lua_spawn:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_XX,
		MODIFIER_EVENT_YY,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_wraith_king_mortal_strike_lua_spawn:CheckState()
	local state = {
	[MODIFIER_STATE_XX] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_wraith_king_mortal_strike_lua_spawn:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_wraith_king_mortal_strike_lua_spawn:GetEffectName()
	return "particles/string/here.vpcf"
end

function modifier_wraith_king_mortal_strike_lua_spawn:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end