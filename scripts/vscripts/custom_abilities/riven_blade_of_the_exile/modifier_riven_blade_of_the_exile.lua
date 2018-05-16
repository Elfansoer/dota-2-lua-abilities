modifier_riven_blade_of_the_exile = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_riven_blade_of_the_exile:IsHidden()
	return false
end

function modifier_riven_blade_of_the_exile:IsDebuff()
	return false
end

function modifier_riven_blade_of_the_exile:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_riven_blade_of_the_exile:OnCreated( kv )
	DOTA_ABILITY_TYPE_BASIC = 0

	-- references
	self.refresh_interval = self:GetAbility():GetSpecialValueFor( "refresh_interval" ) -- special value

	if IsServer() then
		-- Start interval
		self:StartIntervalThink( self.refresh_interval )
		self:RefreshCooldown()
	end
end

function modifier_riven_blade_of_the_exile:OnRefresh( kv )
	-- references
	self.refresh_interval = self:GetAbility():GetSpecialValueFor( "refresh_interval" ) -- special value

	if IsServer() then
		-- Start interval
		self:RefreshCooldown()
		-- self:StartIntervalThink( -1 )
		-- self:StartIntervalThink( self.refresh_interval )
	end
end

function modifier_riven_blade_of_the_exile:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_riven_blade_of_the_exile:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}

	return funcs
end
function modifier_riven_blade_of_the_exile:GetModifierPercentageCooldown( params )
	if not params.ability:IsItem() then
		return 100
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_riven_blade_of_the_exile:OnIntervalThink()
	self:RefreshCooldown()
end

--------------------------------------------------------------------------------
-- Helper function
function modifier_riven_blade_of_the_exile:RefreshCooldown()
	for i=0,self:GetParent():GetAbilityCount()-1 do
		local ability = self:GetParent():GetAbilityByIndex(i)
		if ability and ability:GetAbilityType()==DOTA_ABILITY_TYPE_BASIC then
			ability:EndCooldown()
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_riven_blade_of_the_exile:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_riven_blade_of_the_exile:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_riven_blade_of_the_exile:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		nFXIndex,
-- 		bDestroyImmediately,
-- 		bStatusEffect,
-- 		iPriority,
-- 		bHeroEffect,
-- 		bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end