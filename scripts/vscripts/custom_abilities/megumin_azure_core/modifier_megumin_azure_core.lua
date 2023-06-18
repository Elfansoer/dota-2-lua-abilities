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
modifier_megumin_azure_core = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_megumin_azure_core:IsHidden()
	return false
end

function modifier_megumin_azure_core:IsDebuff()
	return false
end

function modifier_megumin_azure_core:IsPurgable()
	return false
end

function modifier_megumin_azure_core:RemoveOnDeath()
	return false
end

function modifier_megumin_azure_core:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_megumin_azure_core:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.manacost = self:GetAbility():GetSpecialValueFor( "core_manacost" )

	if not IsServer() then return end

	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )
end

function modifier_megumin_azure_core:OnRefresh( kv )
end

function modifier_megumin_azure_core:OnRemoved()
end

function modifier_megumin_azure_core:OnDestroy()
end

function modifier_megumin_azure_core:Update()
	self.cores = #self.parent:FindAllModifiersByName( "modifier_megumin_azure_core" )
	self:SendBuffRefreshToClients()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_megumin_azure_core:AddCustomTransmitterData()
	-- on server
	local data = {
		cores = self.cores
	}

	return data
end

function modifier_megumin_azure_core:HandleCustomTransmitterData( data )
	-- on client
	self.cores = data.cores
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_megumin_azure_core:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}

	return funcs
end

function modifier_megumin_azure_core:GetModifierOverrideAbilitySpecial( params )
	if params.ability:GetAbilityName() ~= "megumin_explosion" then return 0 end
	local specialname = params.ability_special_value

	if specialname == "blue_manacost_pct" then
		return 1
	end

	return 0
end

function modifier_megumin_azure_core:GetModifierOverrideAbilitySpecialValue( params )
	local specialname = params.ability_special_value

	local base = params.ability:GetLevelSpecialValueNoOverride( specialname, params.ability:GetLevel() )
	local bonus = self.manacost * self.cores
	
	return base - bonus
end
