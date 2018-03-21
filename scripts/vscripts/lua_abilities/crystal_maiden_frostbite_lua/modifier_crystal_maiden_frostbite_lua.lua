modifier_crystal_maiden_frostbite_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_crystal_maiden_frostbite_lua:IsHidden()
	return false
end

function modifier_crystal_maiden_frostbite_lua:IsDebuff()
	return true
end

function modifier_crystal_maiden_frostbite_lua:IsStunDebuff()
	return false
end

function modifier_crystal_maiden_frostbite_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_crystal_maiden_frostbite_lua:OnCreated( kv )
	-- references
	local tick_damage = self:GetAbility():GetSpecialValueFor( "damage_per_second_tooltip" ) -- special value
	self.interval = 0.5

	if IsServer() then
		-- Apply Damage	 
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = tick_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}

		-- Start interval
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()

		-- Play Effects
		self.sound_target = "hero_Crystal.frostbite"
		EmitSoundOn( self.sound_target, self:GetParent() )
	end
end

function modifier_crystal_maiden_frostbite_lua:OnRefresh( kv )
	-- references
	local tick_damage = self:GetAbility():GetSpecialValueFor( "damage_per_second_tooltip" ) -- special value
	self.interval = 0.5

	if IsServer() then
		-- Apply Damage	 
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = tick_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
			ability = self, --Optional.
		}

		-- Start interval
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()

		-- Play Effects
		self.sound_target = "hero_Crystal.frostbite"
		EmitSoundOn( self.sound_target, self:GetParent() )
	end
end

function modifier_crystal_maiden_frostbite_lua:OnDestroy()
	StopSoundOn( self.sound_target, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_crystal_maiden_frostbite_lua:CheckState()
	local state = {
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_ROOTED] = true,
	[MODIFIER_STATE_INVISIBLE] = false,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_crystal_maiden_frostbite_lua:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_crystal_maiden_frostbite_lua:GetEffectName()
	return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
end

function modifier_crystal_maiden_frostbite_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end