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
modifier_darkness_decoy_taunt = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_darkness_decoy_taunt:IsHidden()
	return false
end

function modifier_darkness_decoy_taunt:IsDebuff()
	return true
end

function modifier_darkness_decoy_taunt:IsPurgable()
	return true
end

-- Optional Classifications
function modifier_darkness_decoy_taunt:IsStunDebuff()
	return true
end

function modifier_darkness_decoy_taunt:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_darkness_decoy_taunt:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	local force_ultimate = self:GetAbility():GetSpecialValueFor( "allow_ultimates" )

	-- references
	if not IsServer() then return end
	self.target_ability = nil

	-- find ability to cast
	local abilities = {}
	local ultimate = {}
	local unit_target = {}
	local point_target = {}
	local no_target = {}

	if force_ultimate==1 then
		table.insert( abilities, ultimate )
	end
	table.insert( abilities, unit_target )
	table.insert( abilities, point_target )
	table.insert( abilities, no_target )

	for i=0,5 do
		local ability = self.parent:GetAbilityByIndex(i)

		if ability and ability:IsFullyCastable() then
			local behavior = ability:GetBehaviorInt()

			if ability:GetAbilityType() == ABILITY_TYPE_ULTIMATE then
				table.insert( ultimate, ability )

			elseif hasBehavior( behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ) then
				local target_team = ability:GetAbilityTargetTeam()
				if 
					hasBehavior( target_team, DOTA_UNIT_TARGET_TEAM_ENEMY ) or
					hasBehavior( target_team, DOTA_UNIT_TARGET_TEAM_BOTH )	
				then
					table.insert( unit_target, ability )
				end

			elseif hasBehavior( behavior, DOTA_ABILITY_BEHAVIOR_POINT )  then
				table.insert( point_target, ability )

			elseif hasBehavior( behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET ) then
				table.insert( no_target, ability )

			end
		end
	end

	for i,abilitytype in ipairs(abilities) do
		if #abilitytype > 0 then
			-- select random
			local rand = RandomInt(1, #abilitytype)
			local ability_to_cast = abilitytype[ rand ]
			if ability_to_cast then
				self.target_ability = ability_to_cast
				break
			end	
		end
	end

	-- Start interval
	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()
end

function modifier_darkness_decoy_taunt:OnRefresh( kv )
	
end

function modifier_darkness_decoy_taunt:OnRemoved()
end

function modifier_darkness_decoy_taunt:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_darkness_decoy_taunt:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_darkness_decoy_taunt:OnAbilityFullyCast( params )
	if params.ability==self.target_ability then
		-- destroy after cast
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_darkness_decoy_taunt:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_TAUNTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_darkness_decoy_taunt:OnIntervalThink()
	if not self.target_ability then
		self.parent:MoveToTargetToAttack( self.caster )
		return
	end

	if not self.target_ability:IsInAbilityPhase() then
		local behavior = self.target_ability:GetBehaviorInt()
		local castrange = self.target_ability:GetEffectiveCastRange( self.caster:GetOrigin(), self.caster )
		local distance = (self.parent:GetOrigin() - self.caster:GetOrigin()):Length2D()
		
		-- check if able to cast ability
		if hasBehavior( behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET ) or (castrange<=1) or (distance < castrange) then

			-- cast ability
			if hasBehavior( behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ) then
				self.parent:SetCursorCastTarget( self.caster )
				self.parent:CastAbilityOnTarget(self.caster, self.target_ability, self.parent:GetPlayerID())

			elseif hasBehavior( behavior, DOTA_ABILITY_BEHAVIOR_POINT ) then
				self.parent:SetCursorPosition( self.caster:GetOrigin() )
				self.parent:CastAbilityOnPosition(self.caster:GetOrigin(), self.target_ability, self.parent:GetPlayerID())

			elseif hasBehavior( behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET ) then
				self.parent:CastAbilityNoTarget(self.target_ability, self.parent:GetPlayerID())

			end

		else
			-- can't cast, could be out of range
			self.parent:MoveToPosition( self.caster:GetOrigin() )
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_darkness_decoy_taunt:GetStatusEffectName()
	return "particles/status_fx/status_effect_beserkers_call.vpcf"
end


function hasBehavior( behavior, target_behavior )
	return bit.band( behavior, target_behavior ) ~= 0
end
