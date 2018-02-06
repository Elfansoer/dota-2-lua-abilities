slardar_slithereen_crush_lua = class({})
LinkLuaModifier( "modifier_slardar_slithereen_crush_lua", "lua_abilities/slardar_slithereen_crush_lua/modifier_slardar_slithereen_crush_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slardar_slithereen_crush_lua_slow", "lua_abilities/slardar_slithereen_crush_lua/modifier_slardar_slithereen_crush_lua_slow", LUA_MODIFIER_MOTION_NONE )

function slardar_slithereen_crush_lua:OnSpellStart()
	-- get references
	local radius = self:GetSpecialValueFor("crush_radius")
	local damage = self:GetAbilityDamage()
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local slow_duration = self:GetSpecialValueFor("crush_extra_slow_duration")

	-- find affected units
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	-- for each caught enemies
	for _,enemy in pairs(enemies) do
		-- Apply Damage
		local damage = {
			victim = enemy,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage( damage )

		-- Apply stun debuff
		enemy:AddNewModifier( self:GetCaster(), self, "modifier_slardar_slithereen_crush_lua", { duration = stun_duration } )

		-- Apply slow debuff
		enemy:AddNewModifier( self:GetCaster(), self, "modifier_slardar_slithereen_crush_lua_slow", { duration = stun_duration + slow_duration } )
	end
end
