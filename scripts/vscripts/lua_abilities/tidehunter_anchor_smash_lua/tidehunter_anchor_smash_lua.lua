tidehunter_anchor_smash_lua = class({})
LinkLuaModifier( "modifier_tidehunter_anchor_smash_lua", "lua_abilities/tidehunter_anchor_smash_lua/modifier_tidehunter_anchor_smash_lua", LUA_MODIFIER_MOTION_NONE )
--------------------------------------------------------------------------------

function tidehunter_anchor_smash_lua:OnSpellStart()
	-- get references
	local reduction_radius = self:GetSpecialValueFor("radius")
	local reduction_duration = self:GetSpecialValueFor("reduction_duration")
	local ability_damage = self:GetAbilityDamage()

	-- get list of affected enemies
	local enemies = FindUnitsInRadius (
		self:GetCaster():GetTeamNumber(),
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
	for _,enemy in pairs(enemies) do
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
			"modifier_tidehunter_anchor_smash_lua",
			{ duration = reduction_duration }
		)
	end

	self:PlayEffects()
end

function tidehunter_anchor_smash_lua:PlayEffects()
	-- get resources
	local particle_cast = "particles/units/heroes/hero_tidehunter/tidehunter_anchor_hero.vpcf"
	local sound_cast = "Hero_Tidehunter.AnchorSmash"

	-- play effects
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- play sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end