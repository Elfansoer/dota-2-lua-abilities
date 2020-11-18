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
modifier_terrorblade_reflection_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_terrorblade_reflection_lua:IsHidden()
	return false
end

function modifier_terrorblade_reflection_lua:IsDebuff()
	return true
end

function modifier_terrorblade_reflection_lua:IsStunDebuff()
	return false
end

function modifier_terrorblade_reflection_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_terrorblade_reflection_lua:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "move_slow" )

	if not IsServer() then return end

	self.distance = 72

	-- create illusion
	local illusions = CreateIllusions(
		-- self:GetParent(), -- hOwner
		self:GetCaster(), -- hOwner
		self:GetParent(), -- hHeroToCopy
		{
			outgoing_damage = self.outgoing,
			duration = self:GetDuration(),
		}, -- hModiiferKeys
		1, -- nNumIllusions
		self.distance, -- nPadding
		false, -- bScramblePosition
		true -- bFindClearSpace
	)
	local illusion = illusions[1]

	-- add illusion buff
	illusion:AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_terrorblade_reflection_lua_illusion", -- modifier name
		{ duration = self:GetDuration() } -- kv
	)

	self:GetAbility():SetContextThink( self:GetAbility():GetAbilityName(), function()
		-- command to attack target
		local order = {
			UnitIndex = illusion:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = self:GetParent():entindex(),
		}
		ExecuteOrderFromTable( order )
	end, FrameTime())

	-- add to illusion table
	self.illusions = self.illusions or {}
	self.illusions[ illusion ] = true

	-- start interval
	self:StartIntervalThink( 0.1 )
end

function modifier_terrorblade_reflection_lua:OnRefresh( kv )
	self:OnCreated( kv )	
end

function modifier_terrorblade_reflection_lua:OnRemoved()
end

function modifier_terrorblade_reflection_lua:OnDestroy()
	if not IsServer() then return end

	-- destroy all illusions
	for illusion,_ in pairs( self.illusions ) do
		if not illusion:IsNull() then
			illusion:ForceKill( false )
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_terrorblade_reflection_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_terrorblade_reflection_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_terrorblade_reflection_lua:OnIntervalThink()
	local parent = self:GetParent()
	local origin = parent:GetOrigin()
	local seen = self:GetCaster():CanEntityBeSeenByMyTeam( parent )

	if not seen then
		for illusion,_ in pairs( self.illusions ) do
			if not illusion:IsNull() and (illusion:GetOrigin()-origin):Length2D()>self.distance/2 then
				-- move to position
				illusion:MoveToPosition( origin )
			end
		end
	else
		for illusion,_ in pairs( self.illusions ) do
			if not illusion:IsNull() and illusion:GetAggroTarget()~=parent then
				-- command to attack target
				local order = {
					UnitIndex = illusion:entindex(),
					OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
					TargetIndex = parent:entindex(),
				}
				ExecuteOrderFromTable( order )
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_terrorblade_reflection_lua:GetEffectName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf"
end

function modifier_terrorblade_reflection_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end