modifier_slark_essence_shift_lua = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_slark_essence_shift_lua:IsHidden()
	return false
end

function modifier_slark_essence_shift_lua:IsDebuff()
	return false
end

function modifier_slark_essence_shift_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_essence_shift_lua:OnCreated( kv )
	-- references
	self.agi_gain = self:GetAbility():GetSpecialValueFor( "agi_gain" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
end

function modifier_slark_essence_shift_lua:OnRefresh( kv )
	-- references
	self.agi_gain = self:GetAbility():GetSpecialValueFor( "agi_gain" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
end

function modifier_slark_essence_shift_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slark_essence_shift_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}

	return funcs
end
function modifier_slark_essence_shift_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		-- filter enemy
		local target = params.target
		if (not target:IsHero()) or target:IsIllusion() then
			return
		end

		-- Apply debuff to enemy
		local debuff = params.target:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_slark_essence_shift_lua_debuff",
			{
				stack_duration = self.duration,
			}
		)

		-- Apply buff to self
		self:AddStack( duration )

		-- Play effects
		self:PlayEffects( params.target )
	end
end

function modifier_slark_essence_shift_lua:GetModifierBonusStats_Agility()
	return self:GetStackCount() * self.agi_gain
end

--------------------------------------------------------------------------------
-- Helper
function modifier_slark_essence_shift_lua:AddStack( duration )
	-- Add counter
	local mod = self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_slark_essence_shift_lua_stack",
		{
			duration = self.duration,
		}
	)
	mod.modifier = self

	-- Add stack
	self:IncrementStackCount()
end

function modifier_slark_essence_shift_lua:RemoveStack()
	self:DecrementStackCount()
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_slark_essence_shift_lua:PlayEffects( target )
	local particle_cast = "particles/units/heroes/hero_slark/slark_essence_shift.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() + Vector( 0, 0, 64 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end