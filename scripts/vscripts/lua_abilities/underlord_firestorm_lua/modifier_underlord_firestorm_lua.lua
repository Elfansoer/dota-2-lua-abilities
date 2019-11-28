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
modifier_underlord_firestorm_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_underlord_firestorm_lua:IsHidden()
	return false
end

function modifier_underlord_firestorm_lua:IsDebuff()
	return true
end

function modifier_underlord_firestorm_lua:IsStunDebuff()
	return false
end

function modifier_underlord_firestorm_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_underlord_firestorm_lua:OnCreated( kv )
	-- references
	if not IsServer() then return end
	local interval = kv.interval
	self.damage_pct = kv.damage/100

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		-- damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( interval )
end

function modifier_underlord_firestorm_lua:OnRefresh( kv )
	self.damage_pct = kv.damage/100
end

function modifier_underlord_firestorm_lua:OnRemoved()
end

function modifier_underlord_firestorm_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_underlord_firestorm_lua:OnIntervalThink()
	-- check health
	local damage = self:GetParent():GetMaxHealth() * self.damage_pct

	-- apply damage
	self.damageTable.damage = damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_underlord_firestorm_lua:GetEffectName()
	return "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf"
end

function modifier_underlord_firestorm_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end