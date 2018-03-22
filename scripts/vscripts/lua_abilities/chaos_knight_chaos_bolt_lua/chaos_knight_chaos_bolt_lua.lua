chaos_knight_chaos_bolt_lua = class({})
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

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

	self:PlayEffect1()
end

function chaos_knight_chaos_bolt_lua:OnProjectileHit( hTarget, vLocation )
	if hTarget==nil or hTarget:IsInvulnerable() then
		return
	end

	if hTarget:TriggerSpellAbsorb( self ) then
		return
	end

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
		"modifier_generic_stunned_lua",
		{ duration = stun_act }
	)

	self:PlayEffect2( hTarget, stun_act, damage_act )
end

function chaos_knight_chaos_bolt_lua:Expand( value, min, max )
	return (max-min)*value + min
end

function chaos_knight_chaos_bolt_lua:PlayEffect1()
	-- load resources
	local sound_cast = "Hero_ChaosKnight.ChaosBolt.Cast"

	-- play sound
	EmitSoundOn(sound_cast, self:GetCaster())
end

function chaos_knight_chaos_bolt_lua:PlayEffect2( target, stun, damage )
	-- load resources
	local particle_target = "particles/units/heroes/hero_chaos_knight/chaos_knight_bolt_msg.vpcf"
	local sound_target = "Hero_ChaosKnight.ChaosBolt.Impact"

	-- calculate controls
	local digit = 4
	if damage < 100 then digit = 3 end
	local digit1 = damage%10
	local digit2 = math.floor((damage%100)/10)
	local digit3 = math.floor((damage%1000)/100)
	local number = digit3*100 + digit2*10 + digit1

	-- play particles
	local nFXIndex = ParticleManager:CreateParticle( particle_target, PATTACH_OVERHEAD_FOLLOW, target )
	ParticleManager:SetParticleControl( nFXIndex, 0, target:GetOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 0, number, 3 ) )
	ParticleManager:SetParticleControl( nFXIndex, 2, Vector( 2, digit, 0 ) )
	ParticleManager:SetParticleControl( nFXIndex, 3, Vector( 0,	stun, 4 ) )
	ParticleManager:SetParticleControl( nFXIndex, 4, Vector( 2,	2, 0 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	-- play sound
	EmitSoundOn( sound_target, target )
end
