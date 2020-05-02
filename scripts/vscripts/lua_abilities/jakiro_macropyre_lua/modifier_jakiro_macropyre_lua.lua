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
modifier_jakiro_macropyre_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_jakiro_macropyre_lua:IsHidden()
	return false
end

function modifier_jakiro_macropyre_lua:IsDebuff()
	return true
end

function modifier_jakiro_macropyre_lua:IsStunDebuff()
	return false
end

function modifier_jakiro_macropyre_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_jakiro_macropyre_lua:OnCreated( kv )
	if not IsServer() then return end
	local interval = kv.interval
	local damage = kv.damage
	local damage_type = kv.damage_type

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = damage_type,
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( interval )
end

function modifier_jakiro_macropyre_lua:OnRefresh( kv )
	if not IsServer() then return end
	local damage = kv.damage
	local damage_type = kv.damage_type

	-- update damage
	self.damageTable.damage = damage
	self.damageTable.damage_type = damage_type
end

function modifier_jakiro_macropyre_lua:OnRemoved()
end

function modifier_jakiro_macropyre_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_jakiro_macropyre_lua:OnIntervalThink()
	-- apply damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_jakiro_macropyre_lua:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_jakiro_macropyre_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end