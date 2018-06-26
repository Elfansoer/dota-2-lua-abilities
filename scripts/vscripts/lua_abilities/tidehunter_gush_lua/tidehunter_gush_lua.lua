tidehunter_gush_lua = class({})
LinkLuaModifier( "modifier_tidehunter_gush_lua", "lua_abilities/tidehunter_gush_lua/modifier_tidehunter_gush_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- function tidehunter_gush_lua:GetCooldown( level )
-- 	if self:GetCaster():HasScepter() then
-- 		return self:GetSpecialValueFor( "cooldown_scepter" )
-- 	end

-- 	return self.BaseClass.GetCooldown( self, level )
-- end

--------------------------------------------------------------------------------
-- Ability Start
function tidehunter_gush_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	-- local point = self:GetCursorPosition()

	-- load data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- create projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)

	-- play effects
	local sound_cast = "Ability.GushCast"
	EmitSoundOn( sound_cast, self:GetCaster() )

end
--------------------------------------------------------------------------------
-- Projectile
function tidehunter_gush_lua:OnProjectileHit( target, location )
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
	self:PlayEffects( target )
end

--------------------------------------------------------------------------------
function tidehunter_gush_lua:PlayEffects( target )
	-- Get Resources
	-- local particle_cast = "string"
	local sound_cast = "Ability.GushImpact"

	-- Get Data

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	-- ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	-- ParticleManager:SetParticleControlEnt(
	-- 	effect_cast,
	-- 	iControlPoint,
	-- 	hTarget,
	-- 	PATTACH_NAME,
	-- 	"attach_name",
	-- 	vOrigin, -- unknown
	-- 	bool -- unknown, true
	-- )
	-- ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	-- SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end