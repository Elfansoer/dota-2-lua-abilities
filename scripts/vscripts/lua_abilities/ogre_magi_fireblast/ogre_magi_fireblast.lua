ogre_magi_fireblast = class({})
LinkLuaModifier( "modifier_ogre_magi_fireblast", "lua_abilities/ogre_magi_fireblast/modifier_ogre_magi_fireblast", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function ogre_magi_fireblast:OnSpellStart()
	-- get references
	local target = self:GetCursorTarget()
	local damage = self:GetSpecialValueFor("fireblast_damage")
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	-- Apply Damage
	local damage = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self
	}
	ApplyDamage( damage )

	-- Add stun modifier
	target:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_ogre_magi_fireblast",
		{ duration = stun_duration }
	)
end

--------------------------------------------------------------------------------
