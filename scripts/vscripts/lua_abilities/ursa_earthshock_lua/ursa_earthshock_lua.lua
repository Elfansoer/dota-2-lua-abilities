ursa_earthshock_lua = class({})
LinkLuaModifier( "modifier_ursa_earthshock_lua", "lua_abilities/ursa_earthshock_lua/modifier_ursa_earthshock_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function ursa_earthshock_lua:OnSpellStart()
	-- get references
	local slow_radius = self:GetSpecialValueFor("shock_radius")
	local slow_duration = self:GetDuration()
	local ability_damage = self:GetAbilityDamage()

	-- get list of affected enemies
	local enemies = FindUnitsInRadius (
		self:GetCaster():GetTeamNumber(),
		self:GetOrigin(),
		nil,
		slow_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	-- Do for each affected enemies
	for _,enemy in pairs(enemies) do
		-- Apply damage
		local damage = {
			victim = enemy,
			attacker = self:GetCaster(),
			damage = ability_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self
		}
		ApplyDamage( damage )

		-- Add slow modifier
		enemy:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_ursa_earthshock_lua",
			{ duration = slow_duration }
		)
	end
end
