modifier_chaos_knight_chaos_strike_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_chaos_knight_chaos_strike_lua:IsHidden()
	return true
end

function modifier_chaos_knight_chaos_strike_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_chaos_knight_chaos_strike_lua:OnCreated( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_bonus = self:GetAbility():GetSpecialValueFor( "crit_damage" )
	self.lifesteal = self:GetAbility():GetSpecialValueFor( "lifesteal" )
end

function modifier_chaos_knight_chaos_strike_lua:OnRefresh( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_bonus = self:GetAbility():GetSpecialValueFor( "crit_damage" )
	self.lifesteal = self:GetAbility():GetSpecialValueFor( "lifesteal" )
end

function modifier_chaos_knight_chaos_strike_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_chaos_knight_chaos_strike_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_chaos_knight_chaos_strike_lua:GetModifierPreAttack_CriticalStrike( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		if self:RollChance( self.crit_chance ) then
			self.record = params.record
			return self.crit_bonus
		end
	end
end

function modifier_chaos_knight_chaos_strike_lua:OnTakeDamage( params )
	if IsServer() then
		-- filter
		local pass = false
		if self.record and params.record == self.record then
			pass = true
			self.record = nil
		end

		-- logic
		if pass then
			-- get heal value
			local heal = params.damage * self.lifesteal/100
			self:GetParent():Heal( heal, self:GetAbility() )
			self:PlayEffects( self:GetParent() )
		end
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_chaos_knight_chaos_strike_lua:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_chaos_knight_chaos_strike_lua:PlayEffects( target )
	-- get resource
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"
	local sound_cast = "Hero_ChaosKnight.ChaosStrike"

	-- play effects
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- play sound
	EmitSoundOn( sound_cast, self:GetParent() )
end