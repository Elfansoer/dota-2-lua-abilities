modifier_sand_king_epicenter_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sand_king_epicenter_lua:IsHidden()
	return false
end

function modifier_sand_king_epicenter_lua:IsDebuff()
	return false
end

function modifier_sand_king_epicenter_lua:IsPurgable()
	return false
end

function modifier_sand_king_epicenter_lua:DestroyOnExpire()
	return false
end

function modifier_sand_king_epicenter_lua:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sand_king_epicenter_lua:OnCreated( kv )
	-- references
	self.pulses = self:GetAbility():GetSpecialValueFor( "epicenter_pulses" ) -- special value
	self.damage = self:GetAbility():GetSpecialValueFor( "epicenter_damage" ) -- special value
	self.slow = self:GetAbility():GetSpecialValueFor( "epicenter_slow_duration_tooltip" ) -- special value

	if IsServer() then
		-- initialize
		self.pulse = 0
		local interval = kv.duration/self.pulses

		-- precache damage
		self.damageTable = {
			-- victim = target,
			attacker = self:GetParent(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}

		-- Start interval
		self:StartIntervalThink( interval )
	end
end

function modifier_sand_king_epicenter_lua:OnRefresh( kv )
	
end

function modifier_sand_king_epicenter_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sand_king_epicenter_lua:OnIntervalThink()
	-- get radius
	self.pulse = self.pulse + 1
	local radius = self:GetAbility():GetLevelSpecialValueFor( "epicenter_radius", self.pulse )

	-- find enemies caught
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- damage enemies
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)

		-- add slow debuff
		enemy:AddNewModifier(
			self:GetParent(), -- player source
			self:GetAbility(), -- ability source
			"modifier_sand_king_epicenter_lua_slow", -- modifier name
			{ duration = self.slow } -- kv
		)
	end

	-- effects
	self:PlayEffects( radius )

	-- end pulses
	if self.pulse>=self.pulses then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_sand_king_epicenter_lua:PlayEffects( radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_sandking/sandking_epicenter.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_sandking/sandking_epicenter_ring.vpcf"


	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_color"))(self,effect_cast)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	local effect_cast = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_color"))(self,effect_cast)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end