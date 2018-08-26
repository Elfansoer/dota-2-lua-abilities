modifier_grimstroke_ink_swell_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_grimstroke_ink_swell_lua:IsHidden()
	return false
end

function modifier_grimstroke_ink_swell_lua:IsDebuff()
	return false
end

function modifier_grimstroke_ink_swell_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_grimstroke_ink_swell_lua:OnCreated( kv )
	-- references
	self.interval = self:GetAbility():GetSpecialValueFor( "tick_rate" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_tick" )
	self.speed = self:GetAbility():GetSpecialValueFor( "movespeed_bonus_pct" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	self.base_damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.base_stun = self:GetAbility():GetSpecialValueFor( "debuff_duration" )
	self.max_multiplier = self:GetAbility():GetSpecialValueFor( "max_bonus_multiplier" )

	if IsServer() then
		-- set up counter
		self.counter = 0
		self.max_counter = 20

		-- precache damage tick
		self.damageTable = {
			-- victim = hTarget,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}

		-- Start interval
		self:StartIntervalThink( self.interval )

		-- play effects
		self:PlayEffects1()
	end
end

function modifier_grimstroke_ink_swell_lua:OnRefresh( kv )
	-- references
	self.interval = self:GetAbility():GetSpecialValueFor( "tick_rate" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_tick" )
	self.speed = self:GetAbility():GetSpecialValueFor( "movespeed_bonus_pct" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	self.base_damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.base_stun = self:GetAbility():GetSpecialValueFor( "debuff_duration" )
	self.max_multiplier = self:GetAbility():GetSpecialValueFor( "max_bonus_multiplier" )

	if IsServer() then
		-- precache damage tick
		self.damageTable.damage = damage
	end
end

function modifier_grimstroke_ink_swell_lua:OnDestroy( kv )
	if IsServer() then
		-- find enemies
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

		-- set up multipliers
		local multiplier = math.min(self.counter/self.max_counter,1)
		local stun = self.base_stun + self.base_stun*self.max_multiplier*multiplier
		self.damageTable.damage = self.base_damage + self.base_damage*self.max_multiplier*multiplier
		
		for _,enemy in pairs(enemies) do
			-- damage
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )

			-- stun
			enemy:AddNewModifier(
				self:GetCaster(), -- player source
				self:GetAbility(), -- ability source
				"modifier_generic_stunned_lua", -- modifier name
				{ duration = stun } -- kv
			)
		end

		-- play effects
		self:PlayEffects3()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_grimstroke_ink_swell_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_grimstroke_ink_swell_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.speed
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_grimstroke_ink_swell_lua:CheckState()
	local state = {
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_grimstroke_ink_swell_lua:OnIntervalThink()
	-- find enemies
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

	for _,enemy in pairs(enemies) do
		-- damage
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)

		-- add to counter
		self.counter = self.counter + 1

		-- play effects
		self:PlayEffects2( enemy )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_grimstroke_ink_swell_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_grimstroke_ink_swell.vpcf"
end


function modifier_grimstroke_ink_swell_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_buff.vpcf"
	local sound_target = "Hero_Grimstroke.InkSwell.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		true
	)

	-- Create Sound
	EmitSoundOn( sound_target, self:GetParent() )
end


function modifier_grimstroke_ink_swell_lua:PlayEffects2( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_tick_damage.vpcf"
	local sound_target = "Hero_Grimstroke.InkSwell.Damage"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_target, target )
end

function modifier_grimstroke_ink_swell_lua:PlayEffects3()
	-- stop sound
	local sound_end = "Hero_Grimstroke.InkSwell.Target"
	StopSoundOn( sound_end, self:GetParent() )
	
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_aoe.vpcf"
	local sound_target = "Hero_Grimstroke.InkSwell.Stun"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_target, self:GetParent() )
end