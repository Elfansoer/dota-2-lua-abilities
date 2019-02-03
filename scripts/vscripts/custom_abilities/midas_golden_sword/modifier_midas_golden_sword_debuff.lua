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
	self.decay_rate = self:GetAbility():GetSpecialValueFor( "decay_rate" )
	self.decay_stack = self:GetAbility():GetSpecialValueFor( "decay_stack" )
	self.loop = 0

	if IsServer() then
		-- Increment stack
		self:SetStackCount( self:GetStackCount() + kv.slow )

		-- Start interval
		self.decay = false
		self:StartIntervalThink( kv.stack_duration )

	end
	self:PlayEffects()
end

function modifier_midas_golden_sword_debuff:OnRefresh( kv )
	self.max_stack = self:GetAbility():GetSpecialValueFor( "max_stack" )
	self.decay_rate = self:GetAbility():GetSpecialValueFor( "decay_rate" )
	self.decay_stack = self:GetAbility():GetSpecialValueFor( "decay_stack" )

	if IsServer() then
		-- if decaying, do nothing
		if self.decaying then return end

		-- Increment stack
		self:SetStackCount( self:GetStackCount() + kv.slow )

		-- if stack is higher than max, cast golden touch
		if self:GetStackCount()>=self.max_stack + self.loop then
			-- find abilty
			local ability = self:GetCaster():FindAbilityByName( "midas_golden_touch" )
			if ability and ability:GetLevel()>0 then
				-- cast the ability
				self:GetCaster():SetCursorCastTarget( self:GetParent() )
				ability:OnSpellStart()
			end

			self.loop = self.loop + self.max_stack

			-- -- destroy this
			-- self:Destroy()
		end

		-- Start interval
		self.decay = false
		self:StartIntervalThink( kv.stack_duration )
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
	}

	return funcs
end

function modifier_midas_golden_sword_debuff:GetModifierMoveSpeedBonus_Percentage()
	return - math.min(self.max_stack,self:GetStackCount())
end
--------------------------------------------------------------------------------
-- Status Effects
-- function modifier_midas_golden_sword_debuff:CheckState()
-- 	local state = {
-- 		[MODIFIER_STATE_INVULNERABLE] = true,
-- 	}

-- 	return state
-- end

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
		self:SetStackCount( math.min(self.max_stack,self:GetStackCount()) )
	end
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