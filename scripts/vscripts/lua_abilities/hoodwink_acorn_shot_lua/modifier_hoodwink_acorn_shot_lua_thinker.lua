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
modifier_hoodwink_acorn_shot_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications

--------------------------------------------------------------------------------
-- Initializations
function modifier_hoodwink_acorn_shot_lua_thinker:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.projectile_name = "particles/units/heroes/hero_hoodwink/hoodwink_acorn_shot_tracking.vpcf"

	self.projectile_speed = self:GetAbility():GetSpecialValueFor( "projectile_speed" )
	self.bounces = self:GetAbility():GetSpecialValueFor( "bounce_count" )+1
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.delay = self:GetAbility():GetSpecialValueFor( "bounce_delay" )
	self.range = self:GetAbility():GetSpecialValueFor( "bounce_range" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

	-- precache projectile
	self.info = {
		-- Target = self.target,
		-- Source = self.parent,
		Ability = self.ability,	
		
		EffectName = self.projectile_name,
		iMoveSpeed = self.projectile_speed,
		bDodgeable = true,                           -- Optional
	
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,

		bVisibleToEnemies = true,                         -- Optional
		bProvidesVision = true,                           -- Optional
		iVisionRadius = 400,                              -- Optional
		iVisionTeamNumber = self.caster:GetTeamNumber(),        -- Optional
		ExtraData = {
			thinker = self.parent:entindex()
		}
	}

	-- Start bounce in next frame
	self:StartIntervalThink( 0 )
end

function modifier_hoodwink_acorn_shot_lua_thinker:OnRefresh( kv )
	
end

function modifier_hoodwink_acorn_shot_lua_thinker:OnRemoved()
end

function modifier_hoodwink_acorn_shot_lua_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hoodwink_acorn_shot_lua_thinker:OnIntervalThink()
	self.bounces = self.bounces-1
	if self.bounces<0 then
		self:Destroy()
		return
	end

	self:StartIntervalThink(-1)

	local first = 0
	if not self.first then
		self.first = true
		first = 1
		self.info.iMoveSpeed = self.projectile_speed
	else
		self.source = self.target

		-- Find enemies
		local enemies = FindUnitsInRadius(
			self.caster:GetTeamNumber(),	-- int, your team number
			self.target:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)
		if #enemies<1 then
			self:Destroy()
			return
		end

		local next_target
		for _,enemy in pairs(enemies) do
			if enemy~=self.target then
				next_target = enemy
				break
			end
		end
		if not next_target then
			self:Destroy()
			return
		end
		self.target = next_target

		self.info.iMoveSpeed = self.caster:GetProjectileSpeed()
	end

	-- launch projectile
	self.info.Source = self.source
	self.info.Target = self.target
	self.info.ExtraData.first = first
	ProjectileManager:CreateTrackingProjectile( self.info )

	-- play effects
	local sound_cast = "Hero_Hoodwink.AcornShot.Bounce"
	EmitSoundOn( sound_cast, self.source )
end

--------------------------------------------------------------------------------
-- Helper
function modifier_hoodwink_acorn_shot_lua_thinker:Bounce()
	self:StartIntervalThink( self.delay )
end