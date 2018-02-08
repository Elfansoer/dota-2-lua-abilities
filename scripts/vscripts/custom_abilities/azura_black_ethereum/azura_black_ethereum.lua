azura_black_ethereum = class({})

--------------------------------------------------------------------------------
-- Ability Start
function azura_black_ethereum:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- get references
	local max_target = self:GetSpecialValueFor("max_target")
	local damage = self:GetSpecialValueFor("damage_tooltip")
	local search_radius = self:GetSpecialValueFor("search_radius")
	local bolt_per_unit = self:GetSpecialValueFor("bolt_per_unit")
	local modifier_name = "modifier_azura_multishot_crossbow"

	-- find affected targets
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		search_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- prepare damageTable
	local damageTable = {
		victim = target,
		attacker = caster,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage = damage,
		ability = self, --Optional.
	}

	-- prepare modifier
	local modifier = caster:FindModifierByNameAndCaster(modifier_name, caster)

	-- for each affected targets, up until max_target
	local hit_target = 0
	for _,enemy in pairs(enemies) do
		-- end if hits max_target
		if hit_target >= max_target then break end

		-- Apply Damage
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		-- Increase bolt charges
		if modifier~=nil then
			modifier:AddStack( bolt_per_unit )
		end

		-- increase hit target
		hit_target = hit_target + 1

		-- play effects
		self:PlayEffects2( enemy )
	end

	self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Effects
function azura_black_ethereum:PlayEffects()
	-- get resources
	local sound_cast = "Hero_ShadowShaman.EtherShock.Cast"

	-- -- play effects
	-- local nFXIndex = ParticleManager:CreateParticle( particle_target, PATTACH_WORLDORIGIN, nil )
	-- ParticleManager:SetParticleControl( nFXIndex, 0, target:GetOrigin() )
	-- ParticleManager:SetParticleControl( nFXIndex, 1, target:GetOrigin() )
	-- ParticleManager:ReleaseParticleIndex( nFXIndex )

	-- play sounds
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function azura_black_ethereum:PlayEffects2( target )
	-- get resources
	local particle_cast = "particles/units/heroes/hero_shadowshaman/shadowshaman_ether_shock.vpcf"
	local sound_target = "Hero_ShadowShaman.EtherShock.Target"

	-- play effects
	local nFXIndex = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, nil );
	ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetOrigin() + Vector( 0, 0, 96 ), true );
	ParticleManager:SetParticleControlEnt( nFXIndex, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true );
	ParticleManager:ReleaseParticleIndex( nFXIndex );

	-- play sounds
	EmitSoundOn( sound_target, target )
end