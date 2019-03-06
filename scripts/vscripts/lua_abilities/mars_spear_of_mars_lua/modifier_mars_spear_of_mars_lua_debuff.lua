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
modifier_mars_spear_of_mars_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mars_spear_of_mars_lua_debuff:IsHidden()
	return false
end

function modifier_mars_spear_of_mars_lua_debuff:IsDebuff()
	return true
end

function modifier_mars_spear_of_mars_lua_debuff:IsStunDebuff()
	return true
end

function modifier_mars_spear_of_mars_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mars_spear_of_mars_lua_debuff:OnCreated( kv )
	if not IsServer() then return end
	self.projectile = kv.projectile
	self:GetParent():SetForwardVector( -self:GetAbility().projectiles[self.projectile].direction )
end

function modifier_mars_spear_of_mars_lua_debuff:OnRefresh( kv )
end

function modifier_mars_spear_of_mars_lua_debuff:OnRemoved()
	if not IsServer() then return end
	-- destroy tree
	local tree = self:GetAbility().projectiles[self.projectile].tree
	if tree then
		tree:CutDown( -1 )
	end

	-- delete data
	self:GetAbility().projectiles:Destroy( self.projectile )
end

function modifier_mars_spear_of_mars_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_mars_spear_of_mars_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_mars_spear_of_mars_lua_debuff:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_mars_spear_of_mars_lua_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_mars_spear_of_mars_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_mars/mars_spear_impact_debuff.vpcf"
end

function modifier_mars_spear_of_mars_lua_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_mars_spear_of_mars_lua_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_mars_spear.vpcf"
end