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
modifier_outworld_devourer_equilibrium_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_outworld_devourer_equilibrium_lua:IsHidden()
	return true
end

function modifier_outworld_devourer_equilibrium_lua:IsDebuff()
	return false
end

function modifier_outworld_devourer_equilibrium_lua:IsStunDebuff()
	return false
end

function modifier_outworld_devourer_equilibrium_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_outworld_devourer_equilibrium_lua:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.mana_steal = self:GetAbility():GetSpecialValueFor( "mana_steal" )
	self.mana_steal_active = self:GetAbility():GetSpecialValueFor( "mana_steal_active" )
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
end

function modifier_outworld_devourer_equilibrium_lua:OnRefresh( kv )
	-- references
	self.mana_steal = self:GetAbility():GetSpecialValueFor( "mana_steal" )
	self.mana_steal_active = self:GetAbility():GetSpecialValueFor( "mana_steal_active" )
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
end

function modifier_outworld_devourer_equilibrium_lua:OnRemoved()
end

function modifier_outworld_devourer_equilibrium_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_outworld_devourer_equilibrium_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_outworld_devourer_equilibrium_lua:OnTakeDamage( params )
	if not IsServer() then return end
	if params.attacker~=self.parent then return end

	-- check active
	local active = self.parent:HasModifier( "modifier_outworld_devourer_equilibrium_lua_buff" )
	if active then
		-- restore mana
		local mana = params.damage * self.mana_steal_active/100
		self.parent:GiveMana( mana )

		-- slow
		params.unit:AddNewModifier(
			self.parent, -- player source
			self:GetAbility(), -- ability source
			"modifier_outworld_devourer_equilibrium_lua_debuff", -- modifier name
			{ duration = self.slow_duration } -- kv
		)

		-- play effects
		self:PlayEffects2( params.unit )
		self:PlayEffects3()
	else
		-- restore mana
		local mana = params.damage * self.mana_steal/100
		self.parent:GiveMana( mana )

		-- play effects
		self:PlayEffects1( params.unit )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_outworld_devourer_equilibrium_lua:PlayEffects1( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_matter_manasteal.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_outworld_devourer_equilibrium_lua:PlayEffects2( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_matter_debuff.vpcf"
	local sound_cast = "Hero_ObsidianDestroyer.Equilibrium.Damage"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 2, target:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end

function modifier_outworld_devourer_equilibrium_lua:PlayEffects3()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_essence_effect.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end