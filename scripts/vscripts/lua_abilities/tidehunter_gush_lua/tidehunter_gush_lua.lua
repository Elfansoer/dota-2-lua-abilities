tidehunter_gush_lua = class({})
LinkLuaModifier( "modifier_tidehunter_gush_lua", "lua_abilities/tidehunter_gush_lua/modifier_tidehunter_gush_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
function tidehunter_gush_lua:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

function tidehunter_gush_lua:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cast_range_scepter" )
	end

	return self.BaseClass.GetCastRange( self, vLocation, hTarget )
end

function tidehunter_gush_lua:GetBehavior()
	if self:GetCaster():HasScepter() then
		return DOTA_ABILITY_BEHAVIOR_POINT
	end

	return self.BaseClass.GetBehavior( self )
end

--------------------------------------------------------------------------------
-- Ability Start
function tidehunter_gush_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- check if scepter
	if caster:HasScepter() then
		if target then point = target:GetOrigin() end

		local name = "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf"
		local speed = self:GetSpecialValueFor("speed_scepter")
		local radius = self:GetSpecialValueFor("aoe_scepter")
		local range = self:GetCastRange( point, target )
		local direction = point-caster:GetOrigin()
		direction.z = 0
		direction = direction:Normalized()

		-- create linear projectile
		local info = {
			Source = caster,
			Ability = self,
			vSpawnOrigin = caster:GetAbsOrigin(),
		
			bDeleteOnHit = false,
		
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		
			EffectName = name,
			fDistance = range,
			fStartRadius = radius,
			fEndRadius = radius,
			vVelocity = direction * speed,
			ExtraData = {
				scepter = 1,
			}
		}
		ProjectileManager:CreateLinearProjectile( info )
	else

		-- load data
		local name = "particles/units/heroes/hero_tidehunter/tidehunter_gush.vpcf"
		local speed = self:GetSpecialValueFor("projectile_speed")

		-- create projectile
		local info = {
			Target = target,
			Source = caster,
			Ability = self,	
			
			EffectName = name,
			iMoveSpeed = speed,
			bDodgeable = true,                           -- Optional
			ExtraData = {
				scepter = 0,
			}
		}
		ProjectileManager:CreateTrackingProjectile(info)
	end

	-- play effects
	local sound_cast = "Ability.GushCast"
	EmitSoundOn( sound_cast, self:GetCaster() )

end
--------------------------------------------------------------------------------
-- Projectile
function tidehunter_gush_lua:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end

	-- cancel if linken
	if data.scepter==0 and target:TriggerSpellAbsorb( self ) then return end

	if data.scepter==1 then
		local vision = 200
		local duration = 2

		-- provide vision
		AddFOWViewer( self:GetCaster():GetTeamNumber(), target:GetOrigin(), vision, duration, true )
	end

	local damage = self:GetSpecialValueFor("gush_damage")
	local duration = self:GetDuration()

	-- apply debuff
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_tidehunter_gush_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- effects
	if data.scepter==0 then
		self:PlayEffects( target )

	end

	local sound_cast = "Ability.GushImpact"
	EmitSoundOn( sound_cast, target )

	return false
end

--------------------------------------------------------------------------------
function tidehunter_gush_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tidehunter/tidehunter_gush_splash.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end