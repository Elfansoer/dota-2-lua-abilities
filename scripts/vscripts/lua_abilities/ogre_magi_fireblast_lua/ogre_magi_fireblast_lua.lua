ogre_magi_fireblast_lua = class({})
LinkLuaModifier( "modifier_ogre_magi_fireblast_lua" , "lua_abilities/ogre_magi_fireblast_lua/modifier_ogre_magi_fireblast_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function ogre_magi_fireblast_lua:OnSpellStart()
	-- get references
	local target = self:GetCursorTarget()
	local damage = self:GetSpecialValueFor("fireblast_damage")
	local duration = self:GetSpecialValueFor("stun_duration")

	-- Apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self
	}
	ApplyDamage( damageTable )

	-- Apply Stun Modifier
	target:AddNewModifier(
		self:GetCaster(),
		self, 
		"modifier_ogre_magi_fireblast_lua", 
		{duration = duration}
	)
end