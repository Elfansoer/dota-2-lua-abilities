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
modifier_spectre_haunt_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_haunt_lua:IsHidden()
	return true
end

function modifier_spectre_haunt_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_haunt_lua:OnCreated( kv )
	-- references
	local delay = self:GetAbility():GetSpecialValueFor( "attack_delay" )

	if not IsServer() then return end
	self.target = EntIndexToHScript( kv.target )
	self.distance = 70

	self.disarm = true

	-- start delay interval
	self:StartIntervalThink( delay )

	-- activate sub ability
	local ability = self:GetCaster():FindAbilityByName( "spectre_reality_lua" )
	if ability and not ability:IsActivated() then
		ability:SetActivated( true )
	end
end

function modifier_spectre_haunt_lua:OnRefresh( kv )
	
end

function modifier_spectre_haunt_lua:OnRemoved()
end

function modifier_spectre_haunt_lua:OnDestroy()
	if not IsServer() then return end

	-- find other haunts
	local haunts = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetCaster():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	local found = false
	for _,haunt in pairs(haunts) do
		if haunt~=self:GetParent() and haunt:HasModifier( "modifier_spectre_haunt_lua" ) then
			found = true
			break
		end
	end

	if found then return end

	-- deactivate sub ability
	local ability = self:GetCaster():FindAbilityByName( "spectre_reality_lua" )
	if ability and ability:IsActivated() then
		ability:SetActivated( false )
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_spectre_haunt_lua:CheckState()
	local state = {
		-- [MODIFIER_STATE_INVULNERABLE] = true,
		-- [MODIFIER_STATE_UNSELECTABLE] = true,
		-- [MODIFIER_STATE_UNTARGETABLE] = true,
		-- [MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_DISARMED] = self.disarm,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		
		-- [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		-- [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		-- [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_spectre_haunt_lua:OnIntervalThink()
	if self.disarm then
		self:StartIntervalThink( 0.1 )
		self.disarm = false
	else
		self:FollowThink()
	end
end

function modifier_spectre_haunt_lua:FollowThink()
	-- kill if target is dead
	if not self.target:IsAlive() then
		self:GetParent():ForceKill( false )
		self:Destroy()
		return
	end

	local parent = self:GetParent()
	local origin = self.target:GetOrigin()
	local seen = self:GetCaster():CanEntityBeSeenByMyTeam( self.target )

	if not seen then
		if (parent:GetOrigin()-origin):Length2D()>self.distance/2 then
			-- move to position
			parent:MoveToPosition( origin )
		end
	else
		if parent:GetAggroTarget()~=self.target then
			-- command to attack target
			local order = {
				UnitIndex = parent:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				TargetIndex = self.target:entindex(),
			}
			ExecuteOrderFromTable( order )
		end
	end
end