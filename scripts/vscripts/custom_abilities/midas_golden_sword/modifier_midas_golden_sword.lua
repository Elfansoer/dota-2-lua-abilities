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
modifier_midas_golden_sword = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_sword:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_sword:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_per_attack" )
	self.duration = self:GetAbility():GetSpecialValueFor( "decay_time" )
	if IsServer() then
		self.teamnumber = self:GetParent():GetTeamNumber()
	end
end

function modifier_midas_golden_sword:OnRefresh( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_per_attack" )
	self.duration = self:GetAbility():GetSpecialValueFor( "decay_time" )
end

function modifier_midas_golden_sword:OnRemoved()
end

function modifier_midas_golden_sword:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_midas_golden_sword:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_midas_golden_sword:GetModifierProcAttack_Feedback( params )
	local filter = UnitFilter(
		params.target,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self.teamnumber
	)
	if filter~=UF_SUCCESS then return end

	params.target:AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_midas_golden_sword_debuff", -- modifier name
		{
			stack_duration = self.duration,
			slow = self.slow,
		} -- kv
	)
end