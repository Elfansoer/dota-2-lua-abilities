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
modifier_ogre_magi_bloodlust_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_ogre_magi_bloodlust_lua:IsHidden()
	return true
end

function modifier_ogre_magi_bloodlust_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_ogre_magi_bloodlust_lua:OnCreated( kv )
	if not IsServer() then return end

	-- references
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.radius = self.ability:GetCastRange( self.caster:GetOrigin(), self.caster )
	local interval = 1

	if not IsServer() then return end

	-- Start interval
	self:StartIntervalThink( interval )
end

function modifier_ogre_magi_bloodlust_lua:OnRefresh( kv )
	
end

function modifier_ogre_magi_bloodlust_lua:OnRemoved()
end

function modifier_ogre_magi_bloodlust_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_ogre_magi_bloodlust_lua:OnIntervalThink()
	-- check autocast state
	if not self.ability:GetAutoCastState() then return end

	-- check castability
	if not self.ability:IsFullyCastable() then return end

	-- somehow silenced is not included in castability
	if self.caster:IsSilenced() then return end

	-- find allied hero in radius
	local allies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		self.caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,ally in pairs(allies) do
		-- check if ally doesn't have buff yet
		if not ally:HasModifier( "modifier_ogre_magi_bloodlust_lua_buff" ) then
			-- cast ability
			self.caster:CastAbilityOnTarget( ally, self.ability, self.caster:GetPlayerOwnerID() )
			break
		end
	end
end