tidehunter_anchor_smash = class({})
LinkLuaModifier( "modifier_tidehunter_anchor_smash", "lua_abilities/tidehunter_anchor_smash/modifier_tidehunter_anchor_smash", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function tidehunter_anchor_smash:OnSpellStart()
	-- get references
	local reduction_radius = self:GetSpecialValueFor("radius")
	local reduction_duration = self:GetSpecialValueFor("reduction_duration")
	local ability_damage = self:GetAbilityDamage()

	-- get list of affected enemies
	local enemies = FindUnitsInRadius (
		self:GetCaster():GetTeamNumber,
		self:GetOrigin(),
		nil,
		reduction_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	-- Do for each affected enemies
	for _,enemy in pairs(ene) do
		-- Apply damage
		local damage = {
			victim = enemy,
			attacker = self:GetCaster(),
			damage = ability_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = self
		}
		ApplyDamage( damage )

		-- Add reduction modifier
		enemy:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_tidehunter_anchor_smash",
			{ duration = reduction_duration }
		)
	end
end
