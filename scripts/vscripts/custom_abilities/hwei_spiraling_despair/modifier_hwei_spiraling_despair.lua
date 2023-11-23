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
modifier_hwei_spiraling_despair = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hwei_spiraling_despair:IsHidden()
	return false
end

function modifier_hwei_spiraling_despair:IsDebuff()
	return true
end

function modifier_hwei_spiraling_despair:IsPurgable()
	return false
end

function modifier_hwei_spiraling_despair:RemoveOnDeath()
	return false
end

function modifier_hwei_spiraling_despair:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_spiraling_despair:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.base_damage = self:GetAbility():GetSpecialValueFor( "base_damage" )
	self.damage_per_unit = self:GetAbility():GetSpecialValueFor( "damage_per_unit" )
	self.slow_rate = -self:GetAbility():GetSpecialValueFor( "slow_rate" )
	self.pull_speed = self:GetAbility():GetSpecialValueFor( "pull_speed" )

	if not IsServer() then return end
	-- ability properties
	self.damage_type = self.ability:GetAbilityDamageType()

	-- Start interval
	self:StartIntervalThink( 0 )
	self:OnIntervalThink()

	-- effects
	self:PlayEffects()
	EmitSoundOn("Hero_ShadowDemon.DemonicPurge.Impact", self.parent)
end

function modifier_hwei_spiraling_despair:OnDestroy()
	if not IsServer() then return end

	-- find unit count
	local units = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- precache damage
	local damageTable = {
		-- victim = self.parent,
		attacker = self.caster,
		damage = self.base_damage + self.damage_per_unit * #units,
		damage_type = self.damage_type,
		ability = self.ability, --Optional.
	}
	
	for _,enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage( damageTable )

		-- unstick
		FindClearSpaceForUnit(enemy, enemy:GetOrigin(), true)
	end

	StopSoundOn("Hero_ShadowDemon.DemonicPurge.Impact", self.parent)
	EmitSoundOn("Hero_ShadowDemon.DemonicPurge.Damage", self.parent)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hwei_spiraling_despair:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_hwei_spiraling_despair:GetModifierMoveSpeedBonus_Percentage()
	return self:GetElapsedTime() * self.slow_rate
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_hwei_spiraling_despair:CheckState()
	local state = {
		[MODIFIER_STATE_TETHERED] = true,
		[MODIFIER_STATE_UNTARGETABLE_ALLIED] = true,
		[MODIFIER_STATE_UNTARGETABLE_SELF] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hwei_spiraling_despair:OnIntervalThink()
	local radius = self:GetElapsedTime()/self:GetDuration() * self.radius

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	
	local origin = self.parent:GetOrigin()

	for _,enemy in pairs(enemies) do
		if enemy~=self.parent then
			-- pull towards parent
			local enemy_origin = enemy:GetOrigin()
			local direction = origin - enemy_origin
			direction.z = 0
			direction = direction:Normalized()
	
			enemy:SetOrigin( GetGroundPosition( enemy_origin + direction * self.pull_speed * FrameTime(), enemy) )
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hwei_spiraling_despair:GetEffectName()
	return "particles/units/heroes/hero_shadow_demon/shadow_demon_demonic_purge.vpcf"
end

function modifier_hwei_spiraling_despair:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_hwei_spiraling_despair:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_razor/razor_plasmafield.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius/self:GetDuration(), self.radius, 1 ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end