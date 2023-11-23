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
modifier_darkness_crusaders_strength_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_darkness_crusaders_strength_buff:IsHidden()
	return false
end

function modifier_darkness_crusaders_strength_buff:IsDebuff()
	return false
end

function modifier_darkness_crusaders_strength_buff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_darkness_crusaders_strength_buff:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.base_regen = self:GetAbility():GetSpecialValueFor( "base_regen" )
	self.base_armor = self:GetAbility():GetSpecialValueFor( "base_armor" )
	self.base_magic = self:GetAbility():GetSpecialValueFor( "base_magic_resist" )
	self.barrier_regen = self:GetAbility():GetSpecialValueFor( "barrier_per_second" )
	self.stun_multiplier = self:GetAbility():GetSpecialValueFor( "stun_multiplier" )
	self.hex_multiplier = self:GetAbility():GetSpecialValueFor( "hex_multiplier" )

	self.damage_reflect = self:GetAbility():GetSpecialValueFor( "damage_reflect" )

	self.duration = self:GetAbility():GetSpecialValueFor( "bonus_duration" )

	self.interval = 0.1
	self.max_shield = 0
	self.shield = 0

	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_darkness_crusaders_strength_buff:OnRefresh( kv )
	-- references
	self.base_regen = self:GetAbility():GetSpecialValueFor( "base_regen" )
	self.base_armor = self:GetAbility():GetSpecialValueFor( "base_armor" )
	self.base_armor = self:GetAbility():GetSpecialValueFor( "base_magic_resist" )
	self.barrier_regen = self:GetAbility():GetSpecialValueFor( "barrier_per_second" )
	self.stun_multiplier = self:GetAbility():GetSpecialValueFor( "stun_multiplier" )
	self.hex_multiplier = self:GetAbility():GetSpecialValueFor( "hex_multiplier" )

	self.duration = self:GetAbility():GetSpecialValueFor( "bonus_duration" )
end

function modifier_darkness_crusaders_strength_buff:OnRemoved()
end

function modifier_darkness_crusaders_strength_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_darkness_crusaders_strength_buff:AddCustomTransmitterData()
	-- on server
	local data = {
		max_shield = self.max_shield,
		shield = self.shield
	}

	return data
end

function modifier_darkness_crusaders_strength_buff:HandleCustomTransmitterData( data )
	-- on client
	self.max_shield = data.max_shield
	self.shield = data.shield
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_darkness_crusaders_strength_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,

		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}

	return funcs
end

function modifier_darkness_crusaders_strength_buff:GetModifierPhysicalArmorBonus()
	if self:GetStackCount()==0 then
		return self.base_armor
	end
end

function modifier_darkness_crusaders_strength_buff:GetModifierMagicalResistanceBonus()
	if self:GetStackCount()==0 then
		return self.base_magic
	end
end

function modifier_darkness_crusaders_strength_buff:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		-- shows max and current shield value on client
		if params.report_max then
			return self.max_shield
		else
			return self.shield
		end
	end
	
	-- block based on damage
	local damage_absorbed = 0
	if params.damage>self.shield then
		self.shield = 0
		self:SendBuffRefreshToClients()

		damage_absorbed = self.shield
	else
		self.shield = self.shield-params.damage
		self:SendBuffRefreshToClients()

		damage_absorbed = params.damage
	end

	if self.damage_reflect > 0 then
		-- reflect damage
		local damageTable = {
			victim = params.attacker,
			attacker = self.parent,
			damage = damage_absorbed * self.damage_reflect/100,
			damage_type = params.damage_type,
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
			ability = self.ability, --Optional.
		}
		ApplyDamage(damageTable)
	end

	return -damage_absorbed
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_darkness_crusaders_strength_buff:OnIntervalThink()
	if self.parent:PassivesDisabled() then return end

	local hex = self.parent:IsHexed()
	local stun = self.parent:IsStunned() or self.parent:IsTaunted() or self.parent:IsFeared() or self.parent:IsCommandRestricted()

	-- check if disabled
	if
		hex or
		stun or
		self.parent:IsDisarmed() or
		self.parent:IsSilenced() or
		self.parent:IsMuted() or
		self.parent:IsRooted()
	then
		local multiplier = 1
		if hex then
			multiplier = self.hex_multiplier
		elseif stun then
			multiplier = self.stun_multiplier
		end

		self.shield = self.shield + self.barrier_regen * self.interval * multiplier
		self.max_shield = math.max( self.shield, self.max_shield )
		self:SendBuffRefreshToClients()
		
		self:SetDuration( self.duration, true )
	end
end
