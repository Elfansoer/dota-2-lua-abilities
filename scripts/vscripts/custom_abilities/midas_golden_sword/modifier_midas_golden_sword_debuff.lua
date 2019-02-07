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
modifier_midas_golden_sword_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_sword_debuff:IsHidden()
	return false
end

function modifier_midas_golden_sword_debuff:IsDebuff()
	return true
end

function modifier_midas_golden_sword_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_sword_debuff:OnCreated( kv )
	self.max_stack = self:GetAbility():GetSpecialValueFor( "max_stack" )
	self.chance_per_slow = self:GetAbility():GetSpecialValueFor( "chance_per_slow" )
	self.decay_rate = self:GetAbility():GetSpecialValueFor( "decay_rate" )
	self.decay_stack = self:GetAbility():GetSpecialValueFor( "decay_stack" )

	if IsServer() then
		self:AttackLogic( kv.slow, kv.stack_duration )
	end
	self:PlayEffects()
end

function modifier_midas_golden_sword_debuff:OnRefresh( kv )
	self.max_stack = self:GetAbility():GetSpecialValueFor( "max_stack" )
	self.chance_per_slow = self:GetAbility():GetSpecialValueFor( "chance_per_slow" )
	self.decay_rate = self:GetAbility():GetSpecialValueFor( "decay_rate" )
	self.decay_stack = self:GetAbility():GetSpecialValueFor( "decay_stack" )

	if IsServer() then
		self:AttackLogic( kv.slow, kv.stack_duration )
	end
end

function modifier_midas_golden_sword_debuff:OnRemoved()
end

function modifier_midas_golden_sword_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_midas_golden_sword_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TOOLTIP,
	}

	return funcs
end

function modifier_midas_golden_sword_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetStackCount()
end

function modifier_midas_golden_sword_debuff:GetModifierAttackSpeedBonus_Constant()
	return -self:GetStackCount()
end

function modifier_midas_golden_sword_debuff:OnTooltip()
	return self:GetStackCount()*self.chance_per_slow
end
--------------------------------------------------------------------------------
-- Interval Effects
function modifier_midas_golden_sword_debuff:OnIntervalThink()
	if not self.decay then
		-- hasnt been attacked, start decay
		self.decay = true

		self:StartIntervalThink( self.decay_rate )
	else
		-- decaying
		self:SetStackCount( self:GetStackCount() - self.decay_stack )

		if self:GetStackCount()<=0 then
			self:Destroy()
		end
	end
end

function modifier_midas_golden_sword_debuff:OnStackCountChanged( old )
	if IsClient() then
		self:UpdateEffects( self:GetStackCount() )
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_midas_golden_sword_debuff:AttackLogic( stack, duration )
	-- Increment stack up to maximum
	self:SetStackCount( math.min(self:GetStackCount() + stack, self.max_stack) )

	-- roll chance to cast golden touch
	local chance = self.chance_per_slow * self:GetStackCount()
	local r = RandomInt( 0,100 )
	if r<chance then
		-- cast if available and not golden
		local modifier = self:GetParent():FindModifierByName( "modifier_midas_golden_touch" )
		local ability = self:GetCaster():FindAbilityByName( "midas_golden_touch" )
		if ability and ability:GetLevel()>0 and (not modifier) then
			self:GetCaster():SetCursorCastTarget( self:GetParent() )
			ability:OnSpellStart()
		end
	end

	-- Start decay interval
	self.decay = false
	self:StartIntervalThink( duration )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_midas_golden_sword_debuff:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/midas_golden_sword.vpcf"

	-- Get data
	local stack = self:GetStackCount()

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( stack, stack, stack ) )
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( stack, stack, stack ) )

	-- buff particle
	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		true, -- bStatusEffect
		-1, -- iPriority
		true, -- bHeroEffect
		false -- bOverheadEffect
	)
end

function modifier_midas_golden_sword_debuff:UpdateEffects( stack )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( stack, stack, stack ) )
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( stack, stack, stack ) )
end