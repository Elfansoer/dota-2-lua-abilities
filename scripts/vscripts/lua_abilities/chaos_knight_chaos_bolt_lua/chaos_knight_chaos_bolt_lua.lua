chaos_knight_chaos_bolt_lua = class({})
LinkLuaModifier( "modifier_chaos_knight_chaos_bolt_lua", "lua_abilities/chaos_knight_chaos_bolt_lua/modifier_chaos_knight_chaos_bolt_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function chaos_knight_chaos_bolt_lua:OnSpellStart()
	-- get references
	local target = self:GetCursorTarget()
	local bolt_lua_speed = self:GetSpecialValueFor("chaos_bolt_speed")
	local projectile = "particles/units/heroes/hero_chaos_knight/chaos_knight_chaos_bolt.vpcf"

	-- Create Tracking Projectile
	local info = {
		Source = self:GetCaster(),
		Target = target,
		Ability = self,
		iMoveSpeed = bolt_lua_speed,
		EffectName = projectile,
		bDodgeable = true,
	}
	ProjectileManager:CreateTrackingProjectile( info )
end

function chaos_knight_chaos_bolt_lua:OnProjectileHit( hTarget, vLocation )
	-- get references
	local damage_min = self:GetSpecialValueFor("damage_min")
	local damage_max = self:GetSpecialValueFor("damage_max")
	local stun_min = self:GetSpecialValueFor("stun_min")
	local stun_max = self:GetSpecialValueFor("stun_max")

	-- calculate damage and stun values
	local x = math.random()
	local y = 1-x
	local damage_act = self:Expand(x,damage_min,damage_max)
	local stun_act = self:Expand(y,stun_min,stun_max)

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
		"modifier_chaos_knight_chaos_bolt_lua",
		{ duration = stun_act }
	)
end

function chaos_knight_chaos_bolt_lua:Expand( value, min, max )
	return (max-min)*value + min
end