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
modifier_lion_mana_drain_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lion_mana_drain_lua:IsHidden()
	return false
end

function modifier_lion_mana_drain_lua:IsDebuff()
	return true
end

function modifier_lion_mana_drain_lua:IsStunDebuff()
	return false
end

function modifier_lion_mana_drain_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lion_mana_drain_lua:OnCreated( kv )
	-- references
	self.mana = self:GetAbility():GetSpecialValueFor( "mana_per_second" )
	self.radius = self:GetAbility():GetSpecialValueFor( "break_distance" )
	self.slow = -self:GetAbility():GetSpecialValueFor( "movespeed" )
	local interval = self:GetAbility():GetSpecialValueFor( "tick_interval" )

	self.mana = self.mana * interval

	if IsServer() then
		self.parent = self:GetParent()

		-- Start interval
		self:StartIntervalThink( interval )

		-- play effects
		self:PlayEffects()
	end
end

function modifier_lion_mana_drain_lua:OnRefresh( kv )
	
end

function modifier_lion_mana_drain_lua:OnRemoved()
end

function modifier_lion_mana_drain_lua:OnDestroy()
	if not IsServer() then return end

	-- unregister if not forced destroy
	if not self.forceDestroy then
		self:GetAbility():Unregister( self )
	end

	-- instantly kill illusion
	if self.parent:IsIllusion() then
		self.parent:Kill( self:GetAbility(), self:GetCaster() )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lion_mana_drain_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_lion_mana_drain_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_lion_mana_drain_lua:OnIntervalThink()
	-- check illusion, magic immune, or invulnerable
	if self.parent:IsMagicImmune() or self.parent:IsInvulnerable() or self.parent:IsIllusion() then
		self:Destroy()
		return
	end

	-- check distance
	if (self:GetParent():GetOrigin()-self:GetCaster():GetOrigin()):Length2D()>self.radius then
		self:Destroy()
		return
	end

	-- check mana
	local mana = self:GetParent():GetMana()
	local empty = false
	if mana<self.mana then
		empty = true
		self.mana = mana
	end

	-- absorbmana
	self:GetParent():ReduceMana( self.mana )
	self:GetCaster():GiveMana( self.mana )

	if empty then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_lion_mana_drain_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_lion/lion_spell_mana_drain.vpcf"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_mouth",
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