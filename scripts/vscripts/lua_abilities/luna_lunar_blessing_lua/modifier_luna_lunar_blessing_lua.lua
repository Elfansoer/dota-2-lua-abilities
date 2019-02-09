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
modifier_luna_lunar_blessing_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_luna_lunar_blessing_lua:IsHidden()
	-- cancel if break
	if self:GetParent():PassivesDisabled() then return true end
	return false
end

function modifier_luna_lunar_blessing_lua:IsDebuff()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_luna_lunar_blessing_lua:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.primary_attribute = self:GetAbility():GetSpecialValueFor( "primary_attribute" )
	self.bonus_night_vision = self:GetAbility():GetSpecialValueFor( "bonus_night_vision" )
	if IsServer() then
		local primary = self:GetParent():GetPrimaryAttribute()
		if primary==DOTA_ATTRIBUTE_STRENGTH then
			self.strength = 1
			self.agility = 0
			self.intelligence = 0
		elseif primary==DOTA_ATTRIBUTE_AGILITY then
			self.strength = 0
			self.agility = 1
			self.intelligence = 0
		elseif primary==DOTA_ATTRIBUTE_INTELLECT then
			self.strength = 0
			self.agility = 0
			self.intelligence = 1
		end
	end
end

function modifier_luna_lunar_blessing_lua:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.primary_attribute = self:GetAbility():GetSpecialValueFor( "primary_attribute" )
	self.bonus_night_vision = self:GetAbility():GetSpecialValueFor( "bonus_night_vision" )	
end

function modifier_luna_lunar_blessing_lua:OnRemoved()
end

function modifier_luna_lunar_blessing_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_luna_lunar_blessing_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BONUS_NIGHT_VISION,

		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}

	return funcs
end

function modifier_luna_lunar_blessing_lua:GetBonusNightVision()
	return self.bonus_night_vision
end

if IsServer() then
	function modifier_luna_lunar_blessing_lua:GetModifierBonusStats_Agility()
		-- cancel if break
		if self:GetParent():PassivesDisabled() then return 0 end
		return self.primary_attribute * self.agility
	end
	function modifier_luna_lunar_blessing_lua:GetModifierBonusStats_Intellect()
		-- cancel if break
		if self:GetParent():PassivesDisabled() then return 0 end
		return self.primary_attribute * self.intelligence
	end
	function modifier_luna_lunar_blessing_lua:GetModifierBonusStats_Strength()
		-- cancel if break
		if self:GetParent():PassivesDisabled() then return 0 end
		return self.primary_attribute * self.strength
	end
end
--------------------------------------------------------------------------------
-- Aura Effects
function modifier_luna_lunar_blessing_lua:IsAura()
	return self:GetParent()==self:GetCaster()
end

function modifier_luna_lunar_blessing_lua:GetModifierAura()
	return "modifier_luna_lunar_blessing_lua"
end

function modifier_luna_lunar_blessing_lua:GetAuraRadius()
	-- cancel if break
	if self:GetParent():PassivesDisabled() then return 0 end
	return self.radius
end

function modifier_luna_lunar_blessing_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_luna_lunar_blessing_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end