crystal_maiden_frostbite_lua = class({})
LinkLuaModifier("modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_frostbite_lua", "lua_abilities/crystal_maiden_frostbite_lua/modifier_crystal_maiden_frostbite_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function crystal_maiden_frostbite_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- set duration
	local bduration = self:GetSpecialValueFor("duration")
	if target:IsCreep() and (target:GetLevel()<=6) then
		bduration = self:GetSpecialValueFor("creep_duration")
	end

	local stun_duration = 0.1

	-- Add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_crystal_maiden_frostbite_lua", -- modifier name
		{ duration = bduration } -- kv
	)
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = stun_duration } -- kv
	)

	self:PlayEffects( caster, target )
end

--------------------------------------------------------------------------------
-- Ability Considerations
function crystal_maiden_frostbite_lua:AbilityConsiderations()
	-- Scepter
	local bScepter = caster:HasScepter()

	-- Linken & Lotus
	local bBlocked = target:TriggerSpellAbsorb( self )

	-- Break
	local bBroken = caster:PassivesDisabled()

	-- Advanced Status
	local bInvulnerable = target:IsInvulnerable()
	local bInvisible = target:IsInvisible()
	local bHexed = target:IsHexed()
	local bMagicImmune = target:IsMagicImmune()

	-- Illusion Copy
	local bIllusion = target:IsIllusion()
end

--------------------------------------------------------------------------------
function crystal_maiden_frostbite_lua:PlayEffects( caster, target )
	-- Create Projectile
	local projectile_name = "particles/units/heroes/hero_crystalmaiden/maiden_frostbite.vpcf"
	local projectile_speed = 1000
	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		vSourceLoc= caster:GetAbsOrigin(),                -- Optional (HOW)

		bDodgeable = false,                                -- Optional
	}
	projectile = ProjectileManager:CreateTrackingProjectile(info)
end