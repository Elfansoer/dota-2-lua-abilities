modifier_earth_spirit_magnetize_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_earth_spirit_magnetize_lua:IsHidden()
	return false
end

function modifier_earth_spirit_magnetize_lua:IsDebuff()
	return true
end

function modifier_earth_spirit_magnetize_lua:IsStunDebuff()
	return false
end

function modifier_earth_spirit_magnetize_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_earth_spirit_magnetize_lua:OnCreated( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	self.search = self:GetAbility():GetSpecialValueFor( "rock_search_radius" )
	self.explode = self:GetAbility():GetSpecialValueFor( "rock_explosion_radius" )
	self.duration = self:GetAbility():GetSpecialValueFor( "damage_duration" )
	self.expire = self:GetAbility():GetSpecialValueFor( "rock_explosion_delay" )
	
	self.interval = 0.5

	if IsServer() then
		-- precache damage
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = damage*self.interval,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
			damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
		}

		-- Start interval
		self:StartIntervalThink( self.interval )

		-- register debuff
		self:GetAbility():AddDebuff( self )
	end
end

function modifier_earth_spirit_magnetize_lua:OnRefresh( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	self.search = self:GetAbility():GetSpecialValueFor( "rock_search_radius" )
	self.explode = self:GetAbility():GetSpecialValueFor( "rock_explosion_radius" )
	self.duration = self:GetAbility():GetSpecialValueFor( "damage_duration" )
	self.expire = self:GetAbility():GetSpecialValueFor( "rock_explosion_delay" )

	if IsServer() then
		-- update damage
		self.damageTable.damage = damage*self.interval

		-- Reset interval
		self:StartIntervalThink( -1 )
		self:StartIntervalThink( self.interval )
	end
end

function modifier_earth_spirit_magnetize_lua:OnRemoved( kv )
	if IsServer() then
		-- unregister debuff
		self:GetAbility():RemoveDebuff( self )

		-- Play effects
		local sound_end = "Hero_EarthSpirit.Magnetize.End"
		EmitSoundOn( sound_end, self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_earth_spirit_magnetize_lua:OnIntervalThink()
	-- apply damage
	ApplyDamage(self.damageTable)

	-- find unused remnants
	local remnant = self:SearchRemnant( self:GetParent():GetOrigin(), self.search )
	if remnant and (not remnant:HasModifier( "modifier_earth_spirit_magnetize_lua_expire" ) ) then
		-- tag used remnant
		remnant:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_earth_spirit_magnetize_lua_expire", -- modifier name
			{ duration = self.expire } -- kv
		)

		-- find enemies within explode radius
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),	-- int, your team number
			remnant:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.explode,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		-- add/refresh modifier
		for _,enemy in pairs(enemies) do
			enemy:AddNewModifier(
				self:GetCaster(), -- player source
				self:GetAbility(), -- ability source
				"modifier_earth_spirit_magnetize_lua", -- modifier name
				{ duration = self.duration } -- kv
			)
		end

		-- play effects
		self:PlayEffects2( remnant, enemies )
	end

	-- play effects
	self:PlayEffects1()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_earth_spirit_magnetize_lua:SearchRemnant( point, radius )
	-- find remnant in area
	local remnants = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
		DOTA_UNIT_TARGET_ALL,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	local ret = nil
	for _,remnant in pairs(remnants) do
		if remnant:HasModifier( "modifier_earth_spirit_stone_remnant_lua" ) then
			return remnant
		end
	end
	return ret
end

--------------------------------------------------------------------------------
-- External function
function modifier_earth_spirit_magnetize_lua:ApplyDebuff( ability, modifier_name, duration )
	self:GetAbility():ApplyDebuff( ability, modifier_name, duration )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_earth_spirit_magnetize_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_earth_spirit/espirit_magnetize_target.vpcf"
	local sound_tick = "Hero_EarthSpirit.Magnetize.Target.Tick"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.search, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_tick, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_earth_spirit_magnetize_lua:PlayEffects2( remnant, enemies )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_earth_spirit/espirit_magnet_arclightning.vpcf"
	local sound_cast = "Hero_EarthSpirit.Magnetize.StoneBolt"

	-- Create Particle
	local effect_cast = 0
	for _,enemy in pairs(enemies) do
		effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, remnant )
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			1,
			enemy,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)
		ParticleManager:ReleaseParticleIndex( effect_cast )
	end

	-- Create Sound
	EmitSoundOn( sound_cast, remnant )
end