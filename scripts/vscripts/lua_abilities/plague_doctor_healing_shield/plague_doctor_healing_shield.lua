plague_doctor_healing_shield = class({})
LinkLuaModifier( "modifier_plague_doctor_healing_shield", "lua_abilities/plague_doctor_healing_shield/modifier_plague_doctor_healing_shield", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function plague_doctor_healing_shield:GetIntrinsicModifierName()
	return "modifier_plague_doctor_healing_shield"
end
