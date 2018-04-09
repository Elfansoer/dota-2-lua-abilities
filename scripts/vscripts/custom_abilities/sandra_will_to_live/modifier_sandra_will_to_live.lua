modifier_sandra_will_to_live = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sandra_will_to_live:IsHidden()
	return false
end

function modifier_sandra_will_to_live:IsDebuff()
	return false
end

function modifier_sandra_will_to_live:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_will_to_live:OnCreated( kv )
	-- references
	self.delay = self:GetAbility():GetSpecialValueFor( "damage_delay" ) -- special value
	self.threshold_base = self:GetAbility():GetSpecialValueFor( "threshold_base" ) -- special value
	self.threshold_stack = self:GetAbility():GetSpecialValueFor( "threshold_stack" ) -- special value
end

function modifier_sandra_will_to_live:OnRefresh( kv )
	-- references
	self.delay = self:GetAbility():GetSpecialValueFor( "damage_delay" ) -- special value
	self.threshold_base = self:GetAbility():GetSpecialValueFor( "threshold_base" ) -- special value
	self.threshold_stack = self:GetAbility():GetSpecialValueFor( "threshold_stack" ) -- special value
end

function modifier_sandra_will_to_live:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sandra_will_to_live:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_sandra_will_to_live:OnTakeDamage( params )
	if IsServer() then
		if params.unit~=self:GetParent() or params.ability==self:GetAbility() then
			return
		end

		-- heal
		local heal = params.damage*((100-self.delay)/100)
		ModifyHealth( iDesiredHealthValue, hAbility, bLethal, iAdditionalFlags )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sandra_will_to_live:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sandra_will_to_live:GetEffectName()
	return "particles/string/here.vpcf"
end

function modifier_sandra_will_to_live:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_sandra_will_to_live:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	self:AddParticle(
		nFXIndex,
		bDestroyImmediately,
		bStatusEffect,
		iPriority,
		bHeroEffect,
		bOverheadEffect
	)

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end