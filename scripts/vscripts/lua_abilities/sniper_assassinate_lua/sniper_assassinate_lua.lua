sniper_assassinate_lua = class({})
LinkLuaModifier( "modifier_sniper_assassinate_lua", "lua_abilities/sniper_assassinate_lua/modifier_sniper_assassinate_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
-- function sniper_assassinate_lua:GetAOERadius()
-- 	return self:GetSpecialValueFor( "radius" )
-- end

--------------------------------------------------------------------------------
-- Ability Phase Start
function sniper_assassinate_lua:OnAbilityPhaseInterrupted()
	if self.modifier then
		local modifier = self:RetATValue( self.modifier )
		if not modifier:IsNull() then
			modifier:Destroy()
		end
		self.modifier = nil
	end
end

function sniper_assassinate_lua:OnAbilityPhaseStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local debuff_duration = 4

	local modifier = target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_sniper_assassinate_lua", -- modifier name
		{ duration = debuff_duration } -- kv
	)

	self.modifier = self:AddATValue( modifier )

	-- play effects
	local sound_cast = "Ability.AssassinateLoad"
	EmitSoundOnClient( sound_cast, caster:GetPlayerOwner() )

	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function sniper_assassinate_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	-- local point = self:GetCursorPosition()

	-- load data
	local projectile_name = "particles/units/heroes/hero_sniper/sniper_assassinate.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,                           -- Optional
		ExtraData = { modifier = self.modifier }
	}
	ProjectileManager:CreateTrackingProjectile(info)
	self.modifier = nil

	-- effects
	local sound_cast = "Ability.Assassinate"
	EmitSoundOn( sound_cast, caster )
	local sound_target = "Hero_Sniper.AssassinateProjectile"
	EmitSoundOn( sound_cast, target )
end
--------------------------------------------------------------------------------
-- Projectile
function sniper_assassinate_lua:OnProjectileHit_ExtraData( target, location, extradata )
	-- cancel if gone
	if (not target) or target:IsInvulnerable() or target:IsOutOfGame() or target:TriggerSpellAbsorb( self ) then
		return
	end

	-- apply damage
	local damage = self:GetAbilityDamage()
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- stun
	target:Interrupt()
	local modifier = self:RetATValue( extradata.modifier )
	if not modifier:IsNull() then
		modifier:Destroy()
	end

	-- effects
	local sound_cast = "Hero_Sniper.AssassinateDamage"
	EmitSoundOn( sound_cast, target )
end

--------------------------------------------------------------------------------
-- Helper: Ability Table (AT)
function sniper_assassinate_lua:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function sniper_assassinate_lua:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function sniper_assassinate_lua:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function sniper_assassinate_lua:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end