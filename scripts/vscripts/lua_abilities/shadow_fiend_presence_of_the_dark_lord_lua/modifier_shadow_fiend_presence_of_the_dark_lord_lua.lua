modifier_shadow_fiend_presence_of_the_dark_lord_lua = class({})
--------------------------------------------------------------------------------

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:IsDebuff()
	return self:GetParent()~=self:GetAbility():GetCaster()
end

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:IsHidden()
	return self:GetParent()==self:GetAbility():GetCaster()
end

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:IsAura()
	if self:GetCaster() == self:GetParent() then
		if not self:GetCaster():PassivesDisabled() then
			return true
		end
	end
	
	return false
end

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:GetModifierAura()
	return "modifier_shadow_fiend_presence_of_the_dark_lord_lua"
end


function modifier_shadow_fiend_presence_of_the_dark_lord_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end


function modifier_shadow_fiend_presence_of_the_dark_lord_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:GetAuraRadius()
	return self.aura_radius
end

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:GetAuraEntityReject( hEntity )
	return not hEntity:CanEntityBeSeenByMyTeam(self:GetCaster())
end
--------------------------------------------------------------------------------

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:OnCreated( kv )
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "presence_radius" )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "presence_armor_reduction" )
end

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:OnRefresh( kv )
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "presence_radius" )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "presence_armor_reduction" )
end

--------------------------------------------------------------------------------

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_shadow_fiend_presence_of_the_dark_lord_lua:GetModifierPhysicalArmorBonus( params )
	if self:GetParent() == self:GetCaster() then
		return 0
	end

	return self.armor_reduction
end

--------------------------------------------------------------------------------
