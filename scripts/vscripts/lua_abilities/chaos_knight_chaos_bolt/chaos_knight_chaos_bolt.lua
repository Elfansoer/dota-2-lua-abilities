chaos_knight_chaos_bolt = class({})
LinkLuaModifier( "modifier_chaos_knight_chaos_bolt", "lua_abilities/chaos_knight_chaos_bolt/modifier_chaos_knight_chaos_bolt", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function chaos_knight_chaos_bolt:OnSpellStart()
	-- get references
	local target = self:GetCursorTarget()
	local bolt_speed = self:GetSpecialValueFor("chaos_bolt_speed")

	-- Create Tracking Projectile
	local info = {
		Source = self:GetCaster(),
		Target = target,
		Ability = self,
		iMoveSpeed = bolt_speed,
		EffectName = "particles/units/heroes/hero_chaos_knight/chaos_knight_chaos_bolt.vpcf",
		bDodgeable = true,
	}
	ProjectileManager:CreateTrackingProjectile( info )
end

function chaos_knight_chaos_bolt:OnProjectileHit( hTarget, vLocation )
	-- get references
	local damage_min = self:GetSpecialValueFor("damage_min")
	local damage_max = self:GetSpecialValueFor("damage_max")
	local stun_min = self:GetSpecialValueFor("stun_min")
	local stun_max = self:GetSpecialValueFor("stun_max")

	-- calculate damage and stun values
	local rand = math.random()
	local damage_act = self:Expand(rand,damage_min,damage_max)
	local stun_act = self:Expand(1-rand,stun_min,stun_max)

	-- Apply damage
	local damage = {
		victim = hTarget,
		attacker = self:GetCaster(),
		damage = damage_act,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self
	}
	ApplyDamage( damage )

	-- Add stun modifier
	hTarget:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_chaos_knight_chaos_bolt",
		{ duration = stun_act }
	)
end

function chaos_knight_chaos_bolt:Expand( value, min, max )
	return (max-min)*value + min
end

--------------------------------------------------------------------------------
