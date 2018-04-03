modifier_centaur_warrunner_stampede_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_centaur_warrunner_stampede_lua:IsHidden()
	return false
end

function modifier_centaur_warrunner_stampede_lua:IsDebuff()
	return false
end

function modifier_centaur_warrunner_stampede_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_centaur_warrunner_stampede_lua:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" ) -- special value
	local base_damage = self:GetAbility():GetSpecialValueFor( "base_damage" ) -- special value
	local strength_pct = self:GetAbility():GetSpecialValueFor( "strength_damage" ) -- special value

	self.interval = 0.1
	self.haste = 550

	-- Start interval
	if IsServer() then
		-- Apply Damage	 
		self.damageTable = {
			-- victim = target,
			attacker = self:GetParent(),
			damage = base_damage + self:GetParent():GetStrength()*strength_pct,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}

		-- Stampede
		self:StartIntervalThink( self.interval )

		-- Effects
		self:PlayEffects1()
	end
end

function modifier_centaur_warrunner_stampede_lua:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" ) -- special value
	local base_damage = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
	local strength_pct = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value

	-- Start interval
	if IsServer() then
		-- Apply Damage	 
		self.damageTable = {
			-- victim = target,
			attacker = self:GetParent(),
			damage = base_damage + self:GetParent():GetStrength()*strength_pct,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}

		self:StartIntervalThink( self.interval )
	end
end

function modifier_centaur_warrunner_stampede_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_centaur_warrunner_stampede_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}

	return funcs
end
function modifier_centaur_warrunner_stampede_lua:GetModifierMoveSpeed_AbsoluteMin()
	return self.haste
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_centaur_warrunner_stampede_lua:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_centaur_warrunner_stampede_lua:OnIntervalThink()
	-- Find Units in Radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	local target = nil
	for _,enemy in pairs(enemies) do
		if not self:GetAbility():HasTrampled( enemy ) then
			target = enemy
			self:GetAbility():AddTrampled( enemy )
		end
	end

	if target then
		-- Damage
		self.damageTable.victim = target
		ApplyDamage( self.damageTable )

		-- Debuff
		target:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_centaur_warrunner_stampede_lua_debuff",
			{ duration = self.slow_duration }
		)

		-- Effects
		self:PlayEffects2( target )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_centaur_warrunner_stampede_lua:GetEffectName()
	return "particles/units/heroes/hero_centaur/centaur_stampede_overhead.vpcf"
end

function modifier_centaur_warrunner_stampede_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_centaur_warrunner_stampede_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_centaur/centaur_stampede.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_centaur/centaur_stampede_haste.vpcf"
	local sound_cast = "Hero_Centaur.Stampede.Movement"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	local effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	self:AddParticle(
		effect_cast2,
		false,
		false,
		-1,
		false,
		false
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_centaur_warrunner_stampede_lua:PlayEffects2( target )
	local sound_cast = "Hero_Centaur.Stampede.Stun"
	EmitSoundOn( sound_cast, target )
end