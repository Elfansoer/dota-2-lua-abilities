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
modifier_maple_cover_move = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_cover_move:IsHidden()
	return false
end

function modifier_maple_cover_move:IsDebuff()
	return false
end

function modifier_maple_cover_move:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_cover_move:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.damage_amp = self:GetAbility():GetSpecialValueFor( "damage_amp" )

	if not IsServer() then return end
end

function modifier_maple_cover_move:OnRefresh( kv )
	self.damage_amp = self:GetAbility():GetSpecialValueFor( "damage_amp" )
end

function modifier_maple_cover_move:OnRemoved()
end

function modifier_maple_cover_move:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_maple_cover_move:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_maple_cover_move:GetModifierIncomingDamage_Percentage( params )
	if params.attacker:GetTeamNumber() ~= self.parent:GetTeamNumber() then
		-- copy damage 
		local damageTable = {
			victim = self.caster,
			attacker = params.attacker,
			damage = params.original_damage * self.damage_amp/100,
			damage_type = params.damage_type,
			ability = self.ability, --Optional.
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION, --Optional.
		}
		ApplyDamage(damageTable)
	end

	return -100
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_maple_cover_move:ShouldUseOverheadOffset()
	return true
end

function modifier_maple_cover_move:GetEffectName()
	return "particles/units/heroes/hero_marci/marci_sidekick_self_buff.vpcf"
end

function modifier_maple_cover_move:GetEffectAttachType()
	return PATTACH_POINT_FOLLOW
end

function modifier_maple_cover_move:GetStatusEffectName()
	return "particles/status_fx/status_effect_marci_sidekick.vpcf"
end

function modifier_maple_cover_move:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end
