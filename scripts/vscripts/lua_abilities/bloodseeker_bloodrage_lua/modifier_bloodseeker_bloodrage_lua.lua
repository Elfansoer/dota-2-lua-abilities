modifier_bloodseeker_bloodrage_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bloodseeker_bloodrage_lua:IsHidden()
	return false
end

function modifier_bloodseeker_bloodrage_lua:IsDebuff()
	return self.debuff
end

function modifier_bloodseeker_bloodrage_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bloodseeker_bloodrage_lua:OnCreated( kv )
	-- references
	self.debuff = self:GetCaster()~=self:GetParent()
	self.ampli = self:GetAbility():GetSpecialValueFor( "damage_increase_pct" ) -- special value
	self.heal = self:GetAbility():GetSpecialValueFor( "health_bonus_pct" ) -- special value
end

function modifier_bloodseeker_bloodrage_lua:OnRefresh( kv )
	-- references
	self.debuff = self:GetCaster()~=self:GetParent()
	self.ampli = self:GetAbility():GetSpecialValueFor( "damage_increase_pct" ) -- special value
	self.heal = self:GetAbility():GetSpecialValueFor( "health_bonus_pct" ) -- special value
end

function modifier_bloodseeker_bloodrage_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bloodseeker_bloodrage_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_bloodseeker_bloodrage_lua:GetModifierDamageOutgoing_Percentage()
	return self.ampli
end
function modifier_bloodseeker_bloodrage_lua:GetModifierIncomingDamage_Percentage()
	return self.ampli
end
function modifier_bloodseeker_bloodrage_lua:OnDeath( params )
	if IsServer() then
		if params.attacker~=self:GetParent() and params.unit~=self:GetParent() then return end

		-- check roshan kill
		if params.attacker:GetUnitName()=="npc_dota_roshan" or params.unit:GetUnitName()=="npc_dota_roshan" then return end

		-- if buffed unit kills
		if params.attacker==self:GetParent() and params.unit~=self:GetParent() then
			self:Heal( params.attacker, params.unit:GetMaxHealth() )
		end

		-- if buffed unit killed
		if params.unit==self:GetParent() and params.attacker~=self:GetParent() then
			self:Heal( params.attacker, params.unit:GetMaxHealth() )
		end
	end
end


function modifier_bloodseeker_bloodrage_lua:Heal( target, maxhealth )
	target:Heal( maxhealth*self.heal/100, self:GetParent() )
	self:PlayEffects( target )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bloodseeker_bloodrage_lua:GetEffectName()
	return "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf"
end

function modifier_bloodseeker_bloodrage_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_bloodseeker_bloodrage_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end