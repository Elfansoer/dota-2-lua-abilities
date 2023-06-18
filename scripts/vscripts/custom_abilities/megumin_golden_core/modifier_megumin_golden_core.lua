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
modifier_megumin_golden_core = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_megumin_golden_core:IsHidden()
	return false
end

function modifier_megumin_golden_core:IsDebuff()
	return false
end

function modifier_megumin_golden_core:IsPurgable()
	return false
end

function modifier_megumin_golden_core:RemoveOnDeath()
	return false
end

function modifier_megumin_golden_core:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_megumin_golden_core:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "core_radius" )
	self.castrange = self:GetAbility():GetSpecialValueFor( "core_castrange" )
	self.max_cores = self:GetAbility():GetSpecialValueFor( "max_cores" )

	if not IsServer() then return end

	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )
end

function modifier_megumin_golden_core:OnRefresh( kv )
end

function modifier_megumin_golden_core:OnRemoved()
end

function modifier_megumin_golden_core:OnDestroy()
end

function modifier_megumin_golden_core:Update()
	self.cores = #self.parent:FindAllModifiersByName( "modifier_megumin_golden_core" )
	self:SendBuffRefreshToClients()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_megumin_golden_core:AddCustomTransmitterData()
	-- on server
	local data = {
		cores = self.cores
	}

	return data
end

function modifier_megumin_golden_core:HandleCustomTransmitterData( data )
	-- on client
	self.cores = data.cores
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_megumin_golden_core:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}

	return funcs
end

function modifier_megumin_golden_core:GetModifierOverrideAbilitySpecial( params )
	if not self.parent:HasScepter() then return 0 end
	if params.ability:GetAbilityName() ~= "megumin_explosion" then return 0 end
	local specialname = params.ability_special_value

	if specialname == "yellow_radius" then
		return 1
	elseif specialname == "yellow_castrange" then
		return 1
	end

	return 0
end

function modifier_megumin_golden_core:GetModifierOverrideAbilitySpecialValue( params )
	local specialname = params.ability_special_value

	local base = params.ability:GetLevelSpecialValueNoOverride( specialname, params.ability:GetLevel() )
	local bonus = 0

	if specialname == "yellow_radius" then
		bonus = self.radius * self.cores
	elseif specialname == "yellow_castrange" then
		bonus = self.castrange * self.cores
	end
	
	return base + bonus
end
