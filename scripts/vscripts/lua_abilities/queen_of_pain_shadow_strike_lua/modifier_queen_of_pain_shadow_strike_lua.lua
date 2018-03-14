modifier_queen_of_pain_shadow_strike_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_queen_of_pain_shadow_strike_lua:IsHidden()
	return false
end

function modifier_queen_of_pain_shadow_strike_lua:IsDebuff()
	return true
end

function modifier_queen_of_pain_shadow_strike_lua:IsStunDebuff()
	return false
end

function modifier_queen_of_pain_shadow_strike_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_queen_of_pain_shadow_strike_lua:OnCreated( kv )
	-- references
	self.max_slow = self:GetAbility():GetSpecialValueFor( "movement_slow" )
	local init_damage = self:GetAbility():GetSpecialValueFor( "strike_damage" )
	local tick_damage = self:GetAbility():GetSpecialValueFor( "duration_damage" )

	if IsServer() then
		-- Initialize Damage Table	 
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = init_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}
		ApplyDamage( self.damageTable )

		-- Initialize tick damage
		self.damageTable.damage = tick_damage

		-- Damage tick calculation, considering status resistance
		self.total_duration = self:GetRemainingTime()
		self.tick_instance = 5
		self.ticks = 0
		local tick_interval = self.total_duration/self.tick_instance

		-- Slow tick calculation
		self.tick_instance_slow = 15
		self.tick_interval_slow = self.total_duration/self.tick_instance_slow

		-- Start interval
		self:StartIntervalThink( tick_interval )

		-- play effects
		self:PlayEffects()
	end
end

function modifier_queen_of_pain_shadow_strike_lua:OnRefresh( kv )
	
end

function modifier_queen_of_pain_shadow_strike_lua:OnRemoved()
	-- ensure last tick happened
	if (self.ticks and self.tick_instance) and self.ticks < self.tick_instance then
		self:OnIntervalThink()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_queen_of_pain_shadow_strike_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_queen_of_pain_shadow_strike_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.max_slow * (self:GetRemainingTime()/self.total_duration)
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_queen_of_pain_shadow_strike_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SPECIALLY_DENIABLE] = (self:GetParent():GetHealthPercent()<25),
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_queen_of_pain_shadow_strike_lua:OnIntervalThink()
	self.ticks = self.ticks + 1
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_queen_of_pain_shadow_strike_lua:GetEffectName()
-- 	return "particles/units/heroes/hero_queenofpain/queen_shadow_strike_debuff.vpcf"
-- end

-- function modifier_queen_of_pain_shadow_strike_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

function modifier_queen_of_pain_shadow_strike_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_queenofpain/queen_shadow_strike_debuff.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end