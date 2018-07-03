sand_king_burrowstrike_lua = class({})
LinkLuaModifier( "modifier_sand_king_burrowstrike_lua", "lua_abilities/sand_king_burrowstrike_lua/modifier_sand_king_burrowstrike_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_knockback_lua", "lua_abilities/generic/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Custom KV
-- function sand_king_burrowstrike_lua:GetCooldown( level )
-- 	if self:GetCaster():HasScepter() then
-- 		return self:GetSpecialValueFor( "cooldown_scepter" )
-- 	end

-- 	return self.BaseClass.GetCooldown( self, level )
-- end

--------------------------------------------------------------------------------
-- Ability Start
function sand_king_burrowstrike_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
	if target then point = target:GetOrigin() end
	local origin = caster:GetOrigin()

	-- load data
	local anim_time = self:GetSpecialValueFor("burrow_anim_time")

	-- projectile data
	local projectile_name = "particles/units/heroes/hero_sandking/sandking_burrowstrike.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("burrow_width")
	local projectile_end_radius = projectile_start_radius
	local projectile_direction = (point-origin)
	projectile_direction.z = 0
	projectile_direction:Normalized()
	local projectile_speed = self:GetSpecialValueFor("burrow_speed")
	local projectile_distance = (point-origin):Length2D()

	-- create projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    bDeleteOnHit = false,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = projectile_name,
	    fDistance = projectile_distance,
	    fStartRadius = projectile_start_radius,
	    fEndRadius =projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- add modifier to caster
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_sand_king_burrowstrike_lua", -- modifier name
		{ 
			duration = anim_time,
			pos_x = point.x,
			pos_y = point.y,
			pos_z = point.z,
		} -- kv
	)

	self:PlayEffects( origin, point )
end
--------------------------------------------------------------------------------
-- Projectile
function sand_king_burrowstrike_lua:OnProjectileHit( target, location )
	if not target then return end

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- apply stun
	local duration = self:GetSpecialValueFor( "burrow_duration" )
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- apply knockback
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_generic_knockback_lua", -- modifier name
		{
			duration = 0.52,
			z = 350,
			IsStun = true,
		} -- kv
	)

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = self:GetAbilityDamage(),
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end

--------------------------------------------------------------------------------
function sand_king_burrowstrike_lua:PlayEffects( origin, target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_sandking/sandking_burrowstrike.vpcf"
	local sound_cast = "Ability.SandKing_BurrowStrike"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, origin )
	ParticleManager:SetParticleControl( effect_cast, 1, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end