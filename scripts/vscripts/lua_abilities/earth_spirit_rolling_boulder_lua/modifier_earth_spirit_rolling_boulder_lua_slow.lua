modifier_earth_spirit_rolling_boulder_lua_slow = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_earth_spirit_rolling_boulder_lua_slow:IsHidden()
	return false
end

function modifier_earth_spirit_rolling_boulder_lua_slow:IsDebuff()
	return true
end

function modifier_earth_spirit_rolling_boulder_lua_slow:IsStunDebuff()
	return false
end

function modifier_earth_spirit_rolling_boulder_lua_slow:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_earth_spirit_rolling_boulder_lua_slow:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "move_slow" ) -- special value
end

function modifier_earth_spirit_rolling_boulder_lua_slow:OnRefresh( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "move_slow" ) -- special value	
end

function modifier_earth_spirit_rolling_boulder_lua_slow:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_earth_spirit_rolling_boulder_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_earth_spirit_rolling_boulder_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end