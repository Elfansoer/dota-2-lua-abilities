modifier_slark_shadow_dance_lua_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_slark_shadow_dance_lua_passive:IsHidden()
	return self:GetStackCount()==1
end

function modifier_slark_shadow_dance_lua_passive:IsDebuff()
	return false
end

function modifier_slark_shadow_dance_lua_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_shadow_dance_lua_passive:OnCreated( kv )
	-- references
	self.interval = self:GetAbility():GetSpecialValueFor( "activation_delay" ) -- special value
	self.neutral_disable = self:GetAbility():GetSpecialValueFor( "neutral_disable" ) -- special value
	self.bonus_regen = self:GetAbility():GetSpecialValueFor( "bonus_regen_pct" ) -- special value
	self.bonus_movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" ) -- special value

	if not IsServer() then return end
	-- find enemy fountain
	local fountains = Entities:FindAllByClassname( 'ent_dota_fountain' )
	for _,foun in pairs(fountains) do
		if foun:GetTeamNumber()~=self:GetParent():GetTeamNumber() then
			self.fountain = foun
		end
	end

	-- in a case where no fountain, just do self. thus inactive all the time
	if not self.fountain then self.fountain = self:GetParent() end

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_slark_shadow_dance_lua_passive:OnRefresh( kv )
	-- references
	self.interval = self:GetAbility():GetSpecialValueFor( "activation_delay" ) -- special value
	self.neutral_disable = self:GetAbility():GetSpecialValueFor( "neutral_disable" ) -- special value
end

function modifier_slark_shadow_dance_lua_passive:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slark_shadow_dance_lua_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,

		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_slark_shadow_dance_lua_passive:OnTakeDamage( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end
	if not params.attacker:IsNeutralUnitType() then return end

	-- set disable
	self.disable = true
	self:SetStackCount( 1 )
	self:StartIntervalThink( self.neutral_disable )
end

function modifier_slark_shadow_dance_lua_passive:GetModifierHealthRegenPercentage()
	return self.bonus_regen * (1-self:GetStackCount())
end
function modifier_slark_shadow_dance_lua_passive:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_movespeed * (1-self:GetStackCount())
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_slark_shadow_dance_lua_passive:OnIntervalThink()
	-- stack: 1 is seen, 0 unseen
	if self.fountain:CanEntityBeSeenByMyTeam( self:GetParent() ) then
		self:SetStackCount( 1 )
	else
		self:SetStackCount( 0 )
	end
end

--------------------------------------------------------------------------------
-- Stack Effects
function modifier_slark_shadow_dance_lua_passive:OnStackCountChanged( prev )
	if not IsServer() then return end
	if prev==self:GetStackCount() then return end

	if self:GetStackCount()==0 then
		self:PlayEffects()
	elseif self:GetStackCount()==1 then
		self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_slark_shadow_dance_lua_passive:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_slark/slark_regen.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	self.effect_cast = effect_cast
end

function modifier_slark_shadow_dance_lua_passive:StopEffects()
	if not self.effect_cast then return end
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
	self.effect_cast = nil
end