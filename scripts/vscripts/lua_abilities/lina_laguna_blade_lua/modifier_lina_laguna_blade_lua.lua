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
modifier_lina_laguna_blade_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lina_laguna_blade_lua:IsHidden()
	return true
end

function modifier_lina_laguna_blade_lua:IsPurgable()
	return false
end

function modifier_lina_laguna_blade_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lina_laguna_blade_lua:OnCreated( kv )
	if not IsServer() then return end
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	if self:GetCaster():HasScepter() then
		self.type = DAMAGE_TYPE_PURE
	else
		self.type = DAMAGE_TYPE_MAGICAL
	end
end

function modifier_lina_laguna_blade_lua:OnRefresh( kv )
end

function modifier_lina_laguna_blade_lua:OnRemoved()
end

function modifier_lina_laguna_blade_lua:OnDestroy()
	if not IsServer() then return end

	-- cancel if magic immune or invulnerable
	if self:GetParent():IsInvulnerable() then return end
	if self:GetParent():IsMagicImmune() and (not self:GetCaster():HasScepter()) then return end	

	-- cancel if linken
	if self:GetParent():TriggerSpellAbsorb( self:GetAbility() ) then return end

	-- apply damage
	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self.type,
		ability = self:GetAbility(), --Optional.
	}
	ApplyDamage(damageTable)
end