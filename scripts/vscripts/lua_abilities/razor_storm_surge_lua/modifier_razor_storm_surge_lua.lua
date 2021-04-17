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
modifier_razor_storm_surge_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_storm_surge_lua:IsHidden()
	return true
end

function modifier_razor_storm_surge_lua:IsDebuff()
	return false
end

function modifier_razor_storm_surge_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_razor_storm_surge_lua:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.movespeed = self:GetAbility():GetSpecialValueFor( "self_movement_speed_pct" )

	if not IsServer() then return end
	self.radius = 900
	self.max_targets = 2
	self.damage = 120
	self.slow = 50
	self.duration = 1.5
	self.chance = 18
end

function modifier_razor_storm_surge_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_razor_storm_surge_lua:OnRemoved()
end

function modifier_razor_storm_surge_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_storm_surge_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACKED,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_razor_storm_surge_lua:OnAttacked( params )
	if not IsServer() then return end
	if params.target~=self.parent then return end

	-- roll chance
	if not RollPercentage( self.chance ) then return end

	-- procs
	self:ShardProc( params.attacker )

	-- play effects
	local sound_cast = "Hero_Razor.UnstableCurrent.Strike"
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_razor_storm_surge_lua:OnAbilityExecuted( params )
	if not IsServer() then return end

	if params.target~=self.parent then return end

	-- procs
	self:ShardProc( params.unit )

	-- play effects
	local sound_cast = "Hero_Razor.UnstableCurrent.Strike"
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_razor_storm_surge_lua:GetModifierMoveSpeedBonus_Percentage()
	if self.parent:PassivesDisabled() then return 0 end
	return self.movespeed
end

--------------------------------------------------------------------------------
-- Helper
function modifier_razor_storm_surge_lua:ShardProc( enemy )
	local targets = {}
	table.insert( targets, enemy )
	local ctr = 0

	-- find other enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		enemy:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,other_enemy in pairs(enemies) do
		if other_enemy~=enemy then
			table.insert( targets, other_enemy )
			ctr = ctr + 1
		end

		if ctr>self.max_targets then break end
	end

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = self.parent,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}

	for i,target in ipairs(targets) do
		-- damage
		damageTable.victim = target
		ApplyDamage(damageTable)

		-- slow
		target:AddNewModifier(
			self.parent, -- player source
			self:GetAbility(), -- ability source
			"modifier_razor_storm_surge_lua_debuff", -- modifier name
			{
				duration = self.duration,
				slow = self.slow,
			} -- kv
		)
	end

	-- play effects
	local sound_cast = "Hero_Razor.UnstableCurrent.Target"
	EmitSoundOn( sound_cast, enemy )
end