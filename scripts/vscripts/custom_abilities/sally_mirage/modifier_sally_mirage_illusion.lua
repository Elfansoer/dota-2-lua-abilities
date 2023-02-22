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
modifier_sally_mirage_illusion = class({})

local copy_ability = {
	["sally_super_acceleration"] = true,
	["sally_sword_dance"] = true,
}

--------------------------------------------------------------------------------
-- Classifications
function modifier_sally_mirage_illusion:IsHidden()
	return true
end

function modifier_sally_mirage_illusion:IsDebuff()
	return false
end

function modifier_sally_mirage_illusion:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sally_mirage_illusion:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	-- references
	self.max_attack = self:GetAbility():GetSpecialValueFor( "max_attack" )
	self.max_damage = self:GetAbility():GetSpecialValueFor( "max_damage_pct" )
	self.search_radius = self:GetAbility():GetSpecialValueFor( "search_radius" )

	if not IsServer() then return end
	self.current_target = self:FindTarget( 0 ) -- random
	self.kill_health_pct = self.parent:GetHealthPercent() - self.max_damage

	self:StartIntervalThink( 0 )
	self:OnIntervalThink()
end

function modifier_sally_mirage_illusion:OnRefresh( kv )
end

function modifier_sally_mirage_illusion:OnRemoved()
end

function modifier_sally_mirage_illusion:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sally_mirage_illusion:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_ORDER,
	}

	return funcs
end

function modifier_sally_mirage_illusion:OnAttack( params )
	if params.attacker==self.parent then
		self:IncrementStackCount()

		if self:GetStackCount() >= self.max_attack then
			self.parent:ForceKill(false)
		end
	end
end

function modifier_sally_mirage_illusion:OnTakeDamage( params )
	if params.unit==self.parent then
		if self.parent:GetHealthPercent() < self.kill_health_pct then
			self.parent:ForceKill(false)
		end
	end
end

function modifier_sally_mirage_illusion:OnOrder( params )
	if
		params.unit==self.caster and
		params.ability and
		copy_ability[params.ability:GetAbilityName()]
	then
		local ability = self.parent:FindAbilityByName(params.ability:GetAbilityName())
		if ability then
			ability:OnSpellStart()
		end
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sally_mirage_illusion:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sally_mirage_illusion:OnIntervalThink()
	-- check if target still valid
	if self.current_target then
		if 
			not self.parent:CanEntityBeSeenByMyTeam(self.current_target) or
			not self.current_target:IsAlive() or
			self.current_target:IsAttackImmune() or
			(self.parent:GetOrigin() - self.current_target:GetOrigin()):Length2D() > self.search_radius
		then
			self.current_target = nil
		end
	end

	-- search for valid target if no target
	if not self.current_target then
		-- find nearby target
		self.current_target = self:FindTarget( FIND_CLOSEST )
	end

	-- attack order to target
	if self.current_target then
		self.parent:MoveToTargetToAttack(self.current_target)
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_sally_mirage_illusion:FindTarget( find_order )
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.search_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,	-- int, flag filter
		find_order,	-- int, order filter
		false	-- bool, can grow cache
	)

	if #enemies > 0 then
		-- prioritize hero
		local creep = enemies[1]
		local hero = nil
		for _,enemy in pairs(enemies) do
			if enemy:IsHero() then
				hero = enemy
				break
			end
		end
		return hero or creep
	end
end
