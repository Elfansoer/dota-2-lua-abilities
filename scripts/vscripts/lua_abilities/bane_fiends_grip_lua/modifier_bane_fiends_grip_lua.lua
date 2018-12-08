modifier_bane_fiends_grip_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bane_fiends_grip_lua:IsHidden()
	return false
end

function modifier_bane_fiends_grip_lua:IsDebuff()
	return true
end

function modifier_bane_fiends_grip_lua:IsStunDebuff()
	return true
end

function modifier_bane_fiends_grip_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bane_fiends_grip_lua:OnCreated( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "fiend_grip_damage" ) -- special value
	self.mana = self:GetAbility():GetSpecialValueFor( "fiend_grip_mana_drain" ) -- special value
	self.interval = self:GetAbility():GetSpecialValueFor( "fiend_grip_tick_interval" ) -- special value

	-- Start interval
	if IsServer() then
		-- precache damage
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.damage * self.interval,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}

		-- start interval
		self:OnIntervalThink()
		self:StartIntervalThink( self.interval )

		-- play effects
		self:PlayEffects()
	end
end

function modifier_bane_fiends_grip_lua:OnRefresh( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "fiend_grip_damage" ) -- special value
	self.mana = self:GetAbility():GetSpecialValueFor( "fiend_grip_mana_drain" ) -- special value

	if IsServer() then
		self.damageTable.damage = self.damage * self.interval
	end
end

function modifier_bane_fiends_grip_lua:OnDestroy( kv )
	if IsServer() then
		self:GetAbility():StopSpell()

		-- stop effects
		-- self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bane_fiends_grip_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_bane_fiends_grip_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_bane_fiends_grip_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_bane_fiends_grip_lua:OnIntervalThink()
	if IsServer() then
		-- damage
		if not self:GetParent():IsMagicImmune() then
			ApplyDamage(self.damageTable)
		end

		-- mana drain
		local mana_loss = self:GetParent():GetMaxMana() * (self.mana/100) * self.interval
		if self:GetParent():GetMana() < mana_loss then
			mana_loss = self:GetParent():GetMana()
		end
		self:GetParent():ReduceMana( mana_loss )
		self:GetCaster():GiveMana( mana_loss )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_bane_fiends_grip_lua:GetEffectName()
-- 	return "particles/units/heroes/hero_bane/bane_fiends_grip.vpcf"
-- end

-- function modifier_bane_fiends_grip_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

function modifier_bane_fiends_grip_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_bane/bane_fiends_grip.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_color"))(self,effect_cast)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end