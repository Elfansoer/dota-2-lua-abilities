sandra_ability_b = class({})
LinkLuaModifier( "modifier_sandra_ability_b_heal", "lua_abilities/sandra_ability_b/modifier_sandra_ability_b_heal", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sandra_ability_b:OnSpellStart()
	-- get info
	local val_self_damage = self:GetSpecialValueFor("self_damage")
	local val_bonus_regen = self:GetSpecialValueFor("bonus_regen")
	local val_duration = self:GetSpecialValueFor("duration")

	-- apply damage
	local damage = {
			victim = self:GetCaster(),
			attacker = self:GetCaster(),
			damage = val_self_damage,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL,
			ability = self,
		}
	ApplyDamage( damage )

	-- apply heal
	self:GetCaster():AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_sandra_ability_b_heal", -- modifier name
		{ duration = val_duration } -- kv
	)
end