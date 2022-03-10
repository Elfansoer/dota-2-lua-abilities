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
modifier_primal_beast_uproar_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_primal_beast_uproar_lua_buff:IsHidden()
	return false
end

function modifier_primal_beast_uproar_lua_buff:IsDebuff()
	return false
end

function modifier_primal_beast_uproar_lua_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_primal_beast_uproar_lua_buff:OnCreated( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage_per_stack" )
	self.armor = self:GetAbility():GetSpecialValueFor( "roared_bonus_armor" )

	if not IsServer() then return end
	self.stack = kv.stack

	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	self:PlayEffects()
end

function modifier_primal_beast_uproar_lua_buff:OnRefresh( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage_per_stack" )
	self.armor = self:GetAbility():GetSpecialValueFor( "roared_bonus_armor" )

	if not IsServer() then return end
	self.stack = kv.stack	
end

function modifier_primal_beast_uproar_lua_buff:OnRemoved()
end

function modifier_primal_beast_uproar_lua_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_primal_beast_uproar_lua_buff:AddCustomTransmitterData()
	-- on server
	local data = {
		stack = self.stack
	}

	return data
end

function modifier_primal_beast_uproar_lua_buff:HandleCustomTransmitterData( data )
	-- on client
	self.stack = data.stack
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_primal_beast_uproar_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_primal_beast_uproar_lua_buff:GetModifierPreAttack_BonusDamage()
	return self.damage * self.stack
end
function modifier_primal_beast_uproar_lua_buff:GetModifierPhysicalArmorBonus()
	return self.armor * self.stack
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_primal_beast_uproar_lua_buff:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_uproar_magic_resist.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetParent(),
		PATTACH_OVERHEAD_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end