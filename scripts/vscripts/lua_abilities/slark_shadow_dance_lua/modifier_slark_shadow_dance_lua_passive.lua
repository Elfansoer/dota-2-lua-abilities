modifier_slark_shadow_dance_lua_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_slark_shadow_dance_lua_passive:IsHidden()
	return self.active
end

function modifier_slark_shadow_dance_lua_passive:IsDebuff()
	return false
end

function modifier_slark_shadow_dance_lua_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_shadow_dance_lua_passive:OnCreated( kv )
	-- references
	self.interval = self:GetAbility():GetSpecialValueFor( "activation_delay" ) -- special value
	self.neutral_disable = self:GetAbility():GetSpecialValueFor( "neutral_disable" ) -- special value
	self.bonus_regen = self:GetAbility():GetSpecialValueFor( "bonus_regen_pct" ) -- special value
	self.bonus_movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" ) -- special value

	if IsServer() then
		self.active = false

		-- Start interval
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()
	end
end

function modifier_slark_shadow_dance_lua_passive:OnRefresh( kv )
	-- references
	self.interval = self:GetAbility():GetSpecialValueFor( "activation_delay" ) -- special value
	self.neutral_disable = self:GetAbility():GetSpecialValueFor( "neutral_disable" ) -- special value
end

function modifier_slark_shadow_dance_lua_passive:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slark_shadow_dance_lua_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_slark_shadow_dance_lua_passive:GetModifierHealthRegenPercentage()
	if self.active then
		return self.bonus_regen
	end
end
function modifier_slark_shadow_dance_lua_passive:GetModifierMoveSpeedBonus_Percentage()
	if self.active then
		return self.bonus_movespeed
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_slark_shadow_dance_lua_passive:OnIntervalThink()
	
end