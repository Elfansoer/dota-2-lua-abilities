modifier_bristleback_warpath_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bristleback_warpath_lua:IsHidden()
	return ( self:GetStackCount() == 0 )
end

function modifier_bristleback_warpath_lua:IsDebuff()
	return false
end

function modifier_bristleback_warpath_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bristleback_warpath_lua:OnCreated( kv )
	self.stack_max = self:GetAbility():GetSpecialValueFor("max_stacks")
	self.stack_damage = self:GetAbility():GetSpecialValueFor("damage_per_stack")
	self.stack_movespeed = self:GetAbility():GetSpecialValueFor("move_speed_per_stack")
	self.stack_duration = self:GetAbility():GetSpecialValueFor("stack_duration")
	self.stack_actual = 0
	self.stack_size = 5

	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_bristleback_warpath_lua:OnRefresh( kv )
	self.stack_max = self:GetAbility():GetSpecialValueFor("max_stacks")
	self.stack_damage = self:GetAbility():GetSpecialValueFor("damage_per_stack")
	self.stack_movespeed = self:GetAbility():GetSpecialValueFor("move_speed_per_stack")
	self.stack_duration = self:GetAbility():GetSpecialValueFor("stack_duration")

	self:SetStackCount( math.min(self.stack_actual,self.stack_max) )
end

function modifier_bristleback_warpath_lua:OnDestroy( kv )
	if IsServer() then
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bristleback_warpath_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,

		MODIFIER_PROPERTY_MODEL_SCALE,
	}

	return funcs
end
function modifier_bristleback_warpath_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.stack_movespeed * self:GetStackCount()
end
function modifier_bristleback_warpath_lua:GetModifierPreAttack_BonusDamage()
	return self.stack_damage * self:GetStackCount()
end
function modifier_bristleback_warpath_lua:OnAbilityExecuted( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetParent() then
			pass=true
		end

		-- logic
		if pass then
			-- check item ability
			local hAbility = params.ability
			if hAbility ~= nil and ( not hAbility:IsItem() ) and ( not hAbility:IsToggle() ) and ( not self:GetParent():PassivesDisabled() ) then
				self:AddStack()
			end
		end
	end
end

function modifier_bristleback_warpath_lua:GetModifierModelScale( params )
	return self.stack_size * self:GetStackCount()
end
--------------------------------------------------------------------------------
-- Helper
function modifier_bristleback_warpath_lua:AddStack()
	-- get AT value
	local at = self:GetAbility():AddATValue( self )

	-- Add stack
	self:GetParent():AddNewModifier(
		self:GetCaster(),
		self:GetAbility(),
		"modifier_bristleback_warpath_lua_stack",
		{
			duration = self.stack_duration,
			modifier = at,
		}
	)

	self.stack_actual = self.stack_actual + 1
	self:SetStackCount( math.min(self.stack_actual,self.stack_max) )
end
function modifier_bristleback_warpath_lua:RemoveStack()
	self.stack_actual = self.stack_actual - 1
	self:SetStackCount( math.min(self.stack_actual,self.stack_max) )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bristleback_warpath_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_bristleback/bristleback_warpath.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	-- Set entity attachment
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		3,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		4,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( self.effect_cast, 5, Vector( 1, 0, 0 ) )
end

function modifier_bristleback_warpath_lua:GetEffectName()
	if self:GetStackCount() > 0 then
		return "particles/units/heroes/hero_bristleback/bristleback_warpath_dust.vpcf"
	end
end

function modifier_bristleback_warpath_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end