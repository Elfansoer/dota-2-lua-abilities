modifier_shaco_hallucinate = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_shaco_hallucinate:IsHidden()
	return false
end

function modifier_shaco_hallucinate:IsDebuff()
	return false
end

function modifier_shaco_hallucinate:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_shaco_hallucinate:OnCreated( kv )
	if IsServer() then
		print("created")
	end
end

function modifier_shaco_hallucinate:OnRefresh( kv )
	
end

function modifier_shaco_hallucinate:OnDestroy( kv )
	if IsServer() then
		self:GetParent():MakeIllusion()
		self:GetParent():ForceKill(false)
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_shaco_hallucinate:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_SUPER_ILLUSION,
		MODIFIER_PROPERTY_ILLUSION_LABEL,
		-- MODIFIER_PROPERTY_IS_ILLUSION,-- broken
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	if IsServer() then
		table.insert(funcs,MODIFIER_PROPERTY_IS_ILLUSION)
	end
	print("Server:",IsServer())
	for k,v in pairs(funcs) do
		print("",k,v)
	end
	return funcs
end

function modifier_shaco_hallucinate:GetIsIllusion()
	print(IsServer(), "isIllusion")
	return 1
end

function modifier_shaco_hallucinate:GetModifierSuperIllusion()
	return true
end

function modifier_shaco_hallucinate:GetModifierIllusionLabel()
	return true
end

function modifier_shaco_hallucinate:OnTakeDamage( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end
		if self:GetParent():GetHealth()<=0 then
			self:GetParent():MakeIllusion()
		end
	end
end

--------------------------------------------------------------------------------
-- Status Effects
-- function modifier_shaco_hallucinate:CheckState()
-- 	local state = {
-- 	[MODIFIER_STATE_XX] = true,
-- 	}

-- 	return state
-- end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_shaco_hallucinate:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_shaco_hallucinate:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_shaco_hallucinate:PlayEffects()
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