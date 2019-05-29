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
modifier_viper_corrosive_skin_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_viper_corrosive_skin_lua:IsHidden()
	return true
end

function modifier_viper_corrosive_skin_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_viper_corrosive_skin_lua:OnCreated( kv )
	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self.max_range = self:GetAbility():GetSpecialValueFor( "max_range_tooltip" )
	self.magic_resist = self:GetAbility():GetSpecialValueFor( "bonus_magic_resistance" )
end

function modifier_viper_corrosive_skin_lua:OnRefresh( kv )
	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self.max_range = self:GetAbility():GetSpecialValueFor( "max_range_tooltip" )
	self.magic_resist = self:GetAbility():GetSpecialValueFor( "bonus_magic_resistance" )
end

function modifier_viper_corrosive_skin_lua:OnRemoved()
end

function modifier_viper_corrosive_skin_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_viper_corrosive_skin_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,

		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_viper_corrosive_skin_lua:GetModifierMagicalResistanceBonus()
	if not self:GetParent():PassivesDisabled() then
		return self.magic_resist
	end
end

function modifier_viper_corrosive_skin_lua:OnTakeDamage( params )
	if not IsServer() then return end

	-- filter
	if params.unit~=self:GetParent() then return end
	if self:GetParent():PassivesDisabled() then return end
	if params.attacker:GetTeamNumber()==self:GetParent():GetTeamNumber() then return end

	-- check distance
	local distance = (params.attacker:GetOrigin()-params.unit:GetOrigin()):Length2D()
	if distance>self.max_range then return end

	-- add debuff
	params.attacker:AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_viper_corrosive_skin_lua_debuff", -- modifier name
		{ duration = self.duration } -- kv
	)

	-- play effects
	local sound_cast = "hero_viper.CorrosiveSkin"
	EmitSoundOn( sound_cast, params.attacker )
end