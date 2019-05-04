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
modifier_generic_custom_indicator = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_custom_indicator:IsHidden()
	return false
end

function modifier_generic_custom_indicator:IsPurgable()
	return true
end

function modifier_generic_custom_indicator:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_custom_indicator:OnCreated( kv )
	if IsServer() then return end

	-- register modifier to ability
	self:GetAbility().custom_indicator = self
end

function modifier_generic_custom_indicator:OnRefresh( kv )
end

function modifier_generic_custom_indicator:OnRemoved()
end

function modifier_generic_custom_indicator:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_custom_indicator:OnIntervalThink()
	if IsClient() then
		-- end
		self:StartIntervalThink(-1)

		-- destroy effect
		if self.effect_cast == nil then return end
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
		self.effect_cast = nil
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_generic_custom_indicator:Register( loc )
	-- TODO: check if self.ability can persist through disconnect if declared in OnCreated
	local ability = self:GetAbility()

	-- init
	if (not self.effect_cast) and ability.GetCustomIndicator then
		self.effect_cast = ability:GetCustomIndicator()
	end

	-- update
	if ability.UpdateCustomIndicator then
		ability:UpdateCustomIndicator( self.effect_cast, loc )
	end

	-- start interval
	self:StartIntervalThink( 0.1 )
end
