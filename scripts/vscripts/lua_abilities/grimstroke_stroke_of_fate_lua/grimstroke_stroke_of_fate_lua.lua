grimstroke_stroke_of_fate_lua = class({})
LinkLuaModifier( "modifier_grimstroke_stroke_of_fate_lua", "lua_abilities/grimstroke_stroke_of_fate_lua/modifier_grimstroke_stroke_of_fate_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function grimstroke_stroke_of_fate_lua:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects1()

	return true -- if success
end
function grimstroke_stroke_of_fate_lua:OnAbilityPhaseInterrupted()
	self:StopEffects1()
end

--------------------------------------------------------------------------------
-- Ability Start
function grimstroke_stroke_of_fate_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local spawnDelta = 150
	local value1 = self:GetSpecialValueFor("some_value")

	-- set up projectile
	local projectile_name = "particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_proj.vpcf"
	local distance = self:GetCastRange( point, nil )
	local start_radius = self:GetSpecialValueFor("start_radius")
	local end_radius = self:GetSpecialValueFor("end_radius")
	local speed = self:GetSpecialValueFor("projectile_speed")

	local spawnPos = caster:GetOrigin() + caster:GetRightVector()*(-spawnDelta)
	local direction = point-spawnPos
	direction.z = 0
	direction = direction:Normalized()

	-- create linear projectile
	local info = {
		Source = self:GetCaster(),
		Ability = self,
		vSpawnOrigin = spawnPos,
		
	    bDeleteOnHit = false,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = projectile_name,
	    fDistance = distance,
	    fStartRadius = start_radius,
	    fEndRadius =end_radius,
		vVelocity = direction * speed,
	
		bHasFrontalCone = false,
		bReplaceExisting = false,
		
		bProvidesVision = false,
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- effects
	local sound_cast1 = "Hero_Grimstroke.DarkArtistry.Cast"
	local sound_cast2 = "Hero_Grimstroke.DarkArtistry.Cast.Layer"
	-- local sound_cast_proj = "Hero_Grimstroke.DarkArtistry.Projectile"
	EmitSoundOn( sound_cast1, caster )
	EmitSoundOn( sound_cast2, caster )
end
--------------------------------------------------------------------------------
-- Projectile
grimstroke_stroke_of_fate_lua.active_proj = {}
function grimstroke_stroke_of_fate_lua:OnProjectileHitHandle( target, location, handle )
	if IsServer() then
		if not target then
			-- unregister projectile
			self.active_proj[handle] = nil
			return true
		end

		-- register new projectile
		if not self.active_proj[handle] then
			self.active_proj[handle] = 0
		end

		-- get data
		local multiplier = self.active_proj[handle]
		local base_damage = self:GetAbilityDamage()
		local plus_damage = self:GetSpecialValueFor( "bonus_damage_per_target" )
		local slow = self:GetSpecialValueFor( "slow_duration" )

		-- damage
		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = base_damage + multiplier*plus_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)

		-- debuff
		target:AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_grimstroke_stroke_of_fate_lua", -- modifier name
			{
				duration = slow,
			} -- kv
		)

		-- add stack
		self.active_proj[handle] = multiplier + 1

		-- play effects
		self:PlayEffects2( target )
	end
end

--------------------------------------------------------------------------------
function grimstroke_stroke_of_fate_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_cast2_ground.vpcf"
	local sound_precast = "Hero_Grimstroke.DarkArtistry.PreCastPoint"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		Vector( 0,0,0 ), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_precast, self:GetCaster() )
end
function grimstroke_stroke_of_fate_lua:StopEffects1()
	-- stop effects
	local sound_precast = "Hero_Grimstroke.DarkArtistry.PreCastPoint"
	StopSoundOn( sound_precast, self:GetCaster() )
end

function grimstroke_stroke_of_fate_lua:PlayEffects2( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_dmg.vpcf"
	local sound_target = "Hero_Grimstroke.DarkArtistry.Damage"
	local sound_creep = "Hero_Grimstroke.DarkArtistry.Damage.Creep"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	if target:IsCreep() then
		EmitSoundOn( sound_creep, target )
	else
		EmitSoundOn( sound_target, target )
	end
end