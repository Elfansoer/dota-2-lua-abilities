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
modifier_aqua_gods_blessing_eris = class({})

local whitelist = {}
local blacklist = {
	["bonus_chance_damage"] = true,
}
local speciallist = {
	["chance"] = true,
	["evasion"] = true,
	["blind"] = true,
}

--------------------------------------------------------------------------------
-- Classifications
function modifier_aqua_gods_blessing_eris:IsHidden()
	return false
end

function modifier_aqua_gods_blessing_eris:IsDebuff()
	return self.is_enemy
end

function modifier_aqua_gods_blessing_eris:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_aqua_gods_blessing_eris:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.is_enemy = self.caster:GetTeamNumber()~=self.parent:GetTeamNumber()

	-- references
	self.multiplier = self:GetAbility():GetSpecialValueFor( "multiplier" )
	if self.is_enemy then
		self.multiplier = self:GetAbility():GetSpecialValueFor( "enemy_multiplier" )
	end

	if not IsServer() then return end

	self:RefreshStats()
end

function modifier_aqua_gods_blessing_eris:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_aqua_gods_blessing_eris:OnRemoved()
end

function modifier_aqua_gods_blessing_eris:OnDestroy()
	if not IsServer() then return end

	self:RefreshStats()
end

function modifier_aqua_gods_blessing_eris:RefreshStats()
	-- most items only update special values after re-equip them
	-- CalculateStatBonus doesn't work
	for i=0,5 do
		local item = self.parent:GetItemInSlot(i)
		if item then
			item:OnUnequip()
			item:OnEquip()
		end
	end

	-- some abilities with intrinsics only update special values after leveling up
	-- So, those modifiers need to be refreshed to update its values
	for i=0,self.parent:GetAbilityCount()-1 do
		local ability = self.parent:GetAbilityByIndex(i)
		if ability and ability:GetAbilityType()~=ABILITY_TYPE_ATTRIBUTES then
			ability:RefreshIntrinsicModifier()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_aqua_gods_blessing_eris:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}

	return funcs
end

function modifier_aqua_gods_blessing_eris:GetModifierOverrideAbilitySpecial( params )
	local abilityname = params.ability:GetAbilityName()
	local specialname = params.ability_special_value
	local level = params.ability_special_level

	-- force certain specials to be allowed / not allowed
	if whitelist[specialname] then return 1 end
	if blacklist[specialname] then return 0 end

	-- not affecting talents
	if IsServer() then
		if params.ability:GetAbilityType()==ABILITY_TYPE_ATTRIBUTES then
			return 0
		end
	else
		if abilityname:find("special_bonus") then
			return 0
		end
	end

	for word,_ in pairs(speciallist) do
		if specialname:find(word) then return 1 end
	end
	
	return 0
end

function modifier_aqua_gods_blessing_eris:GetModifierOverrideAbilitySpecialValue( params )
	local abilityname = params.ability:GetAbilityName()
	local specialname = params.ability_special_value
	local level = params.ability_special_level

	local base = params.ability:GetLevelSpecialValueNoOverride( specialname, level )
	
	return math.min( base * self.multiplier, 100 )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_aqua_gods_blessing_eris:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_repel_buff.vpcf"
end

function modifier_aqua_gods_blessing_eris:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end