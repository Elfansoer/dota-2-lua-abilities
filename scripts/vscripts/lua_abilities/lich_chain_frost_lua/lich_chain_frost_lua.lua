lich_chain_frost_lua = class({})
LinkLuaModifier( "modifier_lich_chain_frost_lua", "lua_abilities/lich_chain_frost_lua/modifier_lich_chain_frost_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lich_chain_frost_lua_thinker", "lua_abilities/lich_chain_frost_lua/modifier_lich_chain_frost_lua_thinker", LUA_MODIFIER_MOTION_NONE )
local tempTable = require( "util/tempTable" )

--------------------------------------------------------------------------------
-- Custom KV
function lich_chain_frost_lua:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cast_range_scepter" )
	end

	return self.BaseClass.GetCastRange( self, vLocation, hTarget )
end

function lich_chain_frost_lua:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

--------------------------------------------------------------------------------
-- Ability Start
function lich_chain_frost_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local damage = self:GetSpecialValueFor("damage")
	local scepter = false
	if caster:HasScepter() then
		damage = self:GetSpecialValueFor("damage_scepter")
		scepter = true
	end

	-- store data
	local castTable = {
		damage = damage,
		scepter = scepter,
		jump = 0,
		jumps = self:GetSpecialValueFor("jumps"),
		jump_range = self:GetSpecialValueFor("jump_range"),
		as_slow = self:GetSpecialValueFor("slow_attack_speed"),
		ms_slow = self:GetSpecialValueFor("slow_movement_speed"),
		slow_duration = self:GetSpecialValueFor("slow_duration"),
	}
	local key = tempTable:AddATValue( castTable )

	-- load projectile
	local projectile_name = "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_vision = self:GetSpecialValueFor("vision_radius")

	local projectile_info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = false,                           -- Optional
	
		bVisibleToEnemies = true,                         -- Optional
		bProvidesVision = true,                           -- Optional
		iVisionRadius = projectile_vision,                              -- Optional
		iVisionTeamNumber = caster:GetTeamNumber(),        -- Optional
		ExtraData = {
			key = key,
		}
	}
	castTable.projectile = projectile_info
	ProjectileManager:CreateTrackingProjectile( castTable.projectile )

	-- play effects
	local sound_cast = "Hero_Lich.ChainFrost"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
-- Projectile
function lich_chain_frost_lua:OnProjectileHit_ExtraData( target, location, kv )
	-- load data
	local bounce_delay = 0.2
	local castTable = tempTable:GetATValue( kv.key )

	-- bounce thinker
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_lich_chain_frost_lua_thinker", -- modifier name
		{
			key = kv.key,
			duration = bounce_delay,
		} -- kv
	)

	-- apply damage and slow
	if (not target:IsMagicImmune()) and (not target:IsInvulnerable()) then
		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = castTable.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)

		target:AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_lich_chain_frost_lua", -- modifier name
			{
				duration = castTable.slow_duration,
				as_slow = castTable.as_slow,
				ms_slow = castTable.ms_slow,
			} -- kv
		)
	end

	-- play effects
	local sound_target = "Hero_Lich.ChainFrostImpact.Creep"
	if target:IsConsideredHero() then
		sound_target = "Hero_Lich.ChainFrostImpact.Hero"
	end
	EmitSoundOn( sound_target, target )
end