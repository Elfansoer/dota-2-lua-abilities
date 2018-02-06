shadow_fiend_shadowraze_b_lua = class({})
LinkLuaModifier( "modifier_shadow_fiend_shadowraze_lua", "lua_abilities/shadow_fiend_shadowraze_lua/modifier_shadow_fiend_shadowraze_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function shadow_fiend_shadowraze_b_lua:OnSpellStart()
	-- get references
	local distance = self:GetSpecialValueFor("shadowraze_range")
	local front = self:GetCaster():GetForwardVector():Normalized()
	local target_pos = front * distance
	local target_radius = self:GetSpecialValueFor("shadowraze_radius")
	local base_damage = self:GetSpecialValueFor("shadowraze_damage")
	local stack_damage = self:GetSpecialValueFor("stack_bonus_damage")
	local stack_duration = self:GetSpecialValueFor("duration")

	-- get affected enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		target_pos,
		nil,
		target_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	-- for each affected enemies
	for _,enemy in pairs(enemies) do
		-- Get Stack
		local modifier = enemy:FindModifierByNameAndCaster("modifier_shadow_fiend_shadowraze_lua", self:GetCaster())
		local stack = 0
		if modifier~=nil then
			stack = modifier:GetStackCount()
		end

		-- Apply damage
		local damageTable = {
			victim = enemy,
			attacker = self:GetCaster(),
			damage = base_damage + stack*stack_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		}
		ApplyDamage( damageTable )

		-- Add stack
		if modifier==nil then
			enemy:AddNewModifier(
				self:GetCaster(),
				self,
				"modifier_shadow_fiend_shadowraze_lua",
				{duration = stack_duration}
			)
		else
			modifier:IncrementStackCount()
			modifier:ForceRefresh()
	end
end

function shadow_fiend_shadowraze_b_lua:OnUpgrade()
	-- Set all three abilities to the same level
	local linkedAbility = self:GetCaster():FindAbilityByName("shadow_fiend_shadowraze_c_lua")
	if linkedAbility~=nil then
		if linkedAbility:GetLevel()~=self:GetLevel() then
			linkedAbility:SetLevel(self:GetLevel())
		end
	end
end
