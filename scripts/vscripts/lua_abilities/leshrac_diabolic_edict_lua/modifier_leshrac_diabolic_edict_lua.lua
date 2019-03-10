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
modifier_leshrac_diabolic_edict_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_leshrac_diabolic_edict_lua:IsHidden()
	return false
end

function modifier_leshrac_diabolic_edict_lua:IsDebuff()
	return false
end

function modifier_leshrac_diabolic_edict_lua:IsPurgable()
	return false
end

function modifier_leshrac_diabolic_edict_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_leshrac_diabolic_edict_lua:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_leshrac_diabolic_edict_lua:OnCreated( kv )
	if not IsServer() then return end
	-- references
	local explosion = self:GetAbility():GetSpecialValueFor( "num_explosions" )
	local duration = self:GetAbility():GetSpecialValueFor( "duration_tooltip" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.tower_bonus = self:GetAbility():GetSpecialValueFor( "tower_bonus" )/100 + 1
	self.damage = self:GetAbility():GetAbilityDamage()

	-- init data and precache
	local interval = duration/explosion
	self.parent = self:GetParent()
	self.damageTable = {
		-- victim = target,
		attacker = self:GetParent(),
		-- damage = self:GetAbility():GetAbilityDamage(),
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( interval )
	self:OnIntervalThink()

	-- play effects
	local sound_loop = "Hero_Leshrac.Diabolic_Edict_lp"
	EmitSoundOn( sound_loop, self.parent )
end

function modifier_leshrac_diabolic_edict_lua:OnRefresh( kv )
end

function modifier_leshrac_diabolic_edict_lua:OnRemoved()
end

function modifier_leshrac_diabolic_edict_lua:OnDestroy()
	if not IsServer() then return end
	local sound_loop = "Hero_Leshrac.Diabolic_Edict_lp"
	StopSoundOn( sound_loop, self.parent )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_leshrac_diabolic_edict_lua:OnIntervalThink()
	-- find enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	local enemy = nil
	if #enemies>0 then
		enemy = enemies[1]

		-- apply damage
		self.damageTable.victim = enemy
		if enemy:IsTower() then
			self.damageTable.damage = self.damage * self.tower_bonus
		else
			self.damageTable.damage = self.damage
		end
		ApplyDamage( self.damageTable )
	end

	-- play effects
	self:PlayEffects( enemy )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_leshrac_diabolic_edict_lua:PlayEffects( unit )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_leshrac/leshrac_diabolic_edict.vpcf"
	local sound_cast = "Hero_Leshrac.Diabolic_Edict"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )

	if unit then
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			1,
			unit,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)
	else
		ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetOrigin() + RandomVector( RandomInt(0,self.radius) ) )
	end
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	if unit then
		EmitSoundOn( sound_cast, unit )
	end
end