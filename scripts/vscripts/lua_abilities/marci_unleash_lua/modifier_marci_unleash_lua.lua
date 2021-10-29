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
modifier_marci_unleash_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_marci_unleash_lua:IsHidden()
	return false
end

function modifier_marci_unleash_lua:IsDebuff()
	return false
end

function modifier_marci_unleash_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_marci_unleash_lua:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "bonus_movespeed" )

	if not IsServer() then return end

	-- basic dispel
	self.parent:Purge( false, true, false, false, false )

	-- add fury charge
	self.parent:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_marci_unleash_lua_fury", -- modifier name
		{} -- kv
	)

	-- play effects
	self:PlayEffects()

	-- not necessary, for fun
	self.hammer = self:GetCaster():GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
	if self.hammer then
		self.hammer:AddEffects( EF_NODRAW )
	end
end

function modifier_marci_unleash_lua:OnRefresh( kv )
	-- references
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "bonus_movespeed" )	

	if not IsServer() then return end

	-- basic dispel
	self.parent:Purge( false, true, false, false, false )

	-- play effects
	self:PlayEffects()
end

function modifier_marci_unleash_lua:OnRemoved()
end

function modifier_marci_unleash_lua:OnDestroy()
	if not IsServer() then return end

	-- destroy fury or recovery modifiers
	local fury = self.parent:FindModifierByNameAndCaster( "modifier_marci_unleash_lua_fury", self.parent )
	if fury then
		fury:ForceDestroy()
	end

	local recovery = self.parent:FindModifierByNameAndCaster( "modifier_marci_unleash_lua_recovery", self.parent )
	if recovery then
		recovery:ForceDestroy()
	end

	-- not necessary, for fun
	self.hammer:RemoveEffects( EF_NODRAW )	
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_marci_unleash_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,

		-- not necessary, for fun
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return funcs
end

function modifier_marci_unleash_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_ms
end

-- not necessary, for fun
function modifier_marci_unleash_lua:GetActivityTranslationModifiers()
	return "no_hammer"
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_marci_unleash_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_unleash_cast.vpcf"
	local sound_cast = "Hero_Marci.Unleash.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end