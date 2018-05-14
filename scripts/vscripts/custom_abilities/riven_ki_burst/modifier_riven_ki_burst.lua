modifier_riven_ki_burst = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_riven_ki_burst:IsHidden()
	return false
end

function modifier_riven_ki_burst:IsDebuff()
	return false
end

function modifier_riven_ki_burst:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_riven_ki_burst:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_riven_ki_burst:OnCreated( kv )
	-- references
	self.stun_duration = self:GetAbility():GetSpecialValueFor( "stun_duration" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	
	if IsServer() then
		self.delay = kv.delay

		-- Start interval
		self:StartIntervalThink( self.delay )

		-- set ability inactive
		self:GetAbility():SetActivated( false )

		-- effects
		self:PlayEffects()
	end
end

function modifier_riven_ki_burst:OnDestroy( kv )
	if IsServer() then
		-- Stop effects
		local sound_cast = "Hero_Juggernaut.BladeFuryStart"
		StopSoundOn( sound_cast, self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_riven_ki_burst:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}

	return funcs
end
function modifier_riven_ki_burst:GetModifierBaseAttack_BonusDamage()
	if IsServer() then
		return self.bonus_damage
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_riven_ki_burst:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_riven_ki_burst:OnIntervalThink()
	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetCaster():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- attack
		self:GetCaster():PerformAttack( enemy, true, true, true, true, false, false, true)

		-- stun
		if not enemy:IsMagicImmune() then
			enemy:AddNewModifier(
				self:GetParent(), -- player source
				self:GetAbility(), -- ability source
				"modifier_generic_stunned_lua", -- modifier name
				{ duration = self.stun_duration } -- kv
			)
		end
	end

	-- end
	self:GetAbility():SetActivated( true )
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_riven_ki_burst:PlayEffects()
		-- Get Resources
	local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf"
	local sound_cast = "Hero_Juggernaut.BladeFuryStart"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 5, Vector( self.radius + 50, 0, 0 ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)

	-- Emit sound
	EmitSoundOn( sound_cast, self:GetParent() )
end