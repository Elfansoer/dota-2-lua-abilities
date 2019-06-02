-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_luna_moon_glaive_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_luna_moon_glaive_lua_thinker:IsHidden()
	return true
end

function modifier_luna_moon_glaive_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_luna_moon_glaive_lua_thinker:OnCreated( kv )
	-- references
	self.bounces = self:GetAbility():GetSpecialValueFor( "bounces" )
	self.range = self:GetAbility():GetSpecialValueFor( "range" )
	self.reduction = self:GetAbility():GetSpecialValueFor( "damage_reduction_percent" )
	self.reduction = (100-self.reduction)/100

	if IsServer() then
		self.parent = self:GetParent()
		self.caster = self:GetCaster()
		self.bounce = 0
		self.targets = {}
		
		-- set properties
		self.parent:SetOrigin( self.parent:GetOrigin() + Vector( 0, 0, 100 ) )
		self.parent:SetAttackCapability( self.caster:GetAttackCapability() )
		self.parent:SetRangedProjectileName( self.caster:GetRangedProjectileName() )
		self.projectile_speed = self.parent:GetProjectileSpeed()

		-- tag target unit as true (for nice bouncing)
		local units = FindUnitsInRadius(
			self.caster:GetTeamNumber(),	-- int, your team number
			self.parent:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			1,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
			FIND_CLOSEST,	-- int, order filter
			false	-- bool, can grow cache
		)
		if #units>0 then
			self.targets[units[1]] = true
		end

		self:Attack()
	end
end

function modifier_luna_moon_glaive_lua_thinker:OnRemoved()
end

function modifier_luna_moon_glaive_lua_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_luna_moon_glaive_lua_thinker:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK_FAIL,

		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
	}

	return funcs
end

function modifier_luna_moon_glaive_lua_thinker:GetModifierProjectileSpeedBonus()
	if not IsServer() then return end

	-- base is 900
	return self.caster:GetProjectileSpeed() - (self.projectile_speed or 900)
end

function modifier_luna_moon_glaive_lua_thinker:GetAttackSound()
	print("here")
	return "Hero_Luna.MoonGlaive.Impact"
end

function modifier_luna_moon_glaive_lua_thinker:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end
	-- perform actual attack
	self:GetAbility().outgoing = math.pow( self.reduction, self.bounce )*100 - 100
	self.caster:PerformAttack(
		params.target,
		false,
		false,
		true,
		true,
		false,
		false,
		true
	)
	self:GetAbility().outgoing = 0

	-- move thinker
	self.parent:SetOrigin( params.target:GetOrigin() + Vector( 0, 0, 100 ) )

	-- check bounce
	if self.bounce>=self.bounces then
		self:Destroy()
	else
		-- bounce
		self:StartIntervalThink( 0.05 )
	end

	-- Play effects
	local sound_cast = "Hero_Luna.MoonGlaive.Impact"
	EmitSoundOn( sound_cast, params.target )
end

function modifier_luna_moon_glaive_lua_thinker:OnAttackFail( params )
	if not IsServer() then return end
	if params.attacker==self.parent then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_luna_moon_glaive_lua_thinker:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_luna_moon_glaive_lua_thinker:OnIntervalThink()
	self:StartIntervalThink( -1 )
	self:Attack()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_luna_moon_glaive_lua_thinker:Attack()
	-- add counter
	self.bounce = self.bounce+1

	-- find units
	local units = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- no bounce in range
	if #units<2 then
		self:Destroy()
		return
	end

	-- determine unit
	local unit = nil
	for i=2,#units do -- first unit is self
		unit = units[i]
		-- check if not already hit
		if not self.targets[unit] then
			self.targets[unit] = true
			break
		end

		unit = nil
	end

	-- if all have been hit, reset
	if unit == nil then
		self.targets = {}

		-- set current target as have been hit, just for nice bouncing
		self.targets[units[1]] = true

		unit = units[2]
	end

	-- perform bounce
	self.parent:PerformAttack(
		unit,
		false,
		true,
		true,
		true,
		true,
		true,
		true
	) -- hTarget, bUseCastAttackOrb, bProcessProcs, bSkipCooldown, bIgnoreInvis, bUseProjectile, bFakeAttack, bNeverMiss 
end