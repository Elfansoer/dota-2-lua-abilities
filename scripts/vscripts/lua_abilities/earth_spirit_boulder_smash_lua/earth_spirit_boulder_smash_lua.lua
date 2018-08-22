earth_spirit_boulder_smash_lua = class({})
LinkLuaModifier( "modifier_earth_spirit_boulder_smash_lua", "lua_abilities/earth_spirit_boulder_smash_lua/modifier_earth_spirit_boulder_smash_lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Custom KV
function earth_spirit_boulder_smash_lua:GetCastRange( vLocation, hTarget )
	if IsServer() then
		local radius = self:GetSpecialValueFor("rock_search_aoe")
		local max = self:GetSpecialValueFor("rock_distance")

		-- if there is remnant around caster, cast immediately (cast range become global)
		if self:SearchRemnant( self:GetCaster():GetOrigin(), radius ) then
			return max
		end

		-- if there is NO remnant around point, stop
		if (not hTarget) and (not self:SearchRemnant( vLocation, radius )) then
			return max
		end

		-- else, walk to target
		return self.BaseClass.GetCastRange( self, vLocation, hTarget )
	end
end

--------------------------------------------------------------------------------
-- Custom cast
function earth_spirit_boulder_smash_lua:CastFilterResultTarget( hTarget )
	-- unable to target self
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter( hTarget, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_NONE, self:GetCaster():GetTeamNumber() )
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

--------------------------------------------------------------------------------
-- Ability Start
function earth_spirit_boulder_smash_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	local radius = self:GetSpecialValueFor("rock_search_aoe")

	-- paramenters
	local dirX = 0
	local dirY = 0
	local kicked = nil
	local isRemnant = false

	-- find remnant in area
	local remnant = self:SearchRemnant( caster:GetOrigin(), radius )

	-- if remnant exists
	if remnant then
		-- set direction
		dirX = point.x-caster:GetOrigin().x
		dirY = point.y-caster:GetOrigin().y
		kicked = remnant
		isRemnant = true
	else
		-- check target exist
		if target then
			-- set direction
			dirX = target:GetOrigin().x-caster:GetOrigin().x
			dirY = target:GetOrigin().y-caster:GetOrigin().y
			kicked = target
		else
			-- nothing happened.
			self:RefundManaCost()
			self:EndCooldown()
			return
		end
	end

	-- kick target
	self:Kick( kicked, dirX, dirY, isRemnant )
end

--------------------------------------------------------------------------------
-- Projectile
function earth_spirit_boulder_smash_lua:OnProjectileHit_ExtraData( hTarget, vLocation, extraData )
	if not hTarget then return end

	-- damage
	local damageTable = {
		victim = hTarget,
		attacker = self:GetCaster(),
		damage = extraData.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- stun
	if extraData.isRemnant==1 then
		hTarget:AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_generic_stunned_lua", -- modifier name
			{
				duration = extraData.stun,
			} -- kv
		)
	end

	-- effects
	local sound_target = "Hero_EarthSpirit.BoulderSmash.Damage"
	EmitSoundOn( sound_target, hTarget )

	return false
end

--------------------------------------------------------------------------------
-- Helpers
function earth_spirit_boulder_smash_lua:SearchRemnant( point, radius )
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

function earth_spirit_boulder_smash_lua:Kick( target, x, y, isRemnant )
	-- get data
	local damage = self:GetSpecialValueFor("rock_damage")
	local stun = self:GetSpecialValueFor("stun_duration")
	local radius = self:GetSpecialValueFor("radius")
	local speed = self:GetSpecialValueFor("speed")
	local distance = self:GetSpecialValueFor("rock_distance")
	if not isRemnant then
		distance = self:GetSpecialValueFor("unit_distance")
	end

	local mod = target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_earth_spirit_boulder_smash_lua", -- modifier name
		{
			x = x,
			y = y,
			r = distance,
		} -- kv
	)

	-- create projectile
	local info = {
		Source = self:GetCaster(),
		Ability = self,
		vSpawnOrigin = target:GetOrigin(),
		
	    bDeleteOnHit = false,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = "",
	    fDistance = distance,
	    fStartRadius = radius,
	    fEndRadius =radius,
		vVelocity = Vector(x,y,0):Normalized() * speed,
	
		bHasFrontalCone = false,
		bReplaceExisting = false,
		
		bProvidesVision = false,

		ExtraData = {
			isRemnant = isRemnant,
			damage = damage,
			stun = stun,
		}
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- play effects
	self:PlayEffects1( target )
	self:PlayEffects2( target, Vector(x,y,0):Normalized(), distance/speed )
end
--------------------------------------------------------------------------------
-- Graphics and Animation
function earth_spirit_boulder_smash_lua:PlayEffects1( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_earth_spirit/espirit_bouldersmash_caster.vpcf"
	local sound_cast = "Hero_EarthSpirit.BoulderSmash.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 1, target:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function earth_spirit_boulder_smash_lua:PlayEffects2( target, direction, duration )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_earth_spirit/espirit_bouldersmash_target.vpcf"
	local sound_target = "Hero_EarthSpirit.BoulderSmash.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlForward( effect_cast, 1, direction )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_target, target )
end