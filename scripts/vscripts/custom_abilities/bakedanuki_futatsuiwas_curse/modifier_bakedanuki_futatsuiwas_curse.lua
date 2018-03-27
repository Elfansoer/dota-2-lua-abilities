modifier_bakedanuki_futatsuiwas_curse = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bakedanuki_futatsuiwas_curse:IsHidden()
	return false
end

function modifier_bakedanuki_futatsuiwas_curse:IsDebuff()
	return true
end

function modifier_bakedanuki_futatsuiwas_curse:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bakedanuki_futatsuiwas_curse:OnCreated( kv )
	-- references
	self.base_speed = self:GetAbility():GetSpecialValueFor( "hex_base_speed" )
	self.model = "models/props_gameplay/frog.vmdl"

	if IsServer() then
		-- play effects
		self:PlayEffects( true )

		-- instantly destroy illusions
		if self:GetParent():IsIllusion() then
			self:GetParent():Kill( self:GetAbility(), self:GetCaster() )
		end
	end
end

function modifier_bakedanuki_futatsuiwas_curse:OnRefresh( kv )
	-- references
	self.base_speed = self:GetAbility():GetSpecialValueFor( "hex_base_speed" )
	if IsServer() then
		-- play effects
		self:PlayEffects( true )
	end
end

function modifier_bakedanuki_futatsuiwas_curse:OnRemoved()
	if IsServer() then
		-- play effects
		self:PlayEffects( false )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bakedanuki_futatsuiwas_curse:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}

	return funcs
end

function modifier_bakedanuki_futatsuiwas_curse:GetModifierMoveSpeedOverride()
	return self.base_speed
end
function modifier_bakedanuki_futatsuiwas_curse:GetModifierModelChange()
	return self.model
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_bakedanuki_futatsuiwas_curse:CheckState()
	local state = {
	[MODIFIER_STATE_HEXED] = true,
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_SILENCED] = true,
	[MODIFIER_STATE_MUTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bakedanuki_futatsuiwas_curse:PlayEffects( bStart )
	local sound_cast = "Hero_DarkWillow.Ley.Stun"
	local particle_cast = "particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf"

	if not bStart then
		sound_cast = "Hero_DarkWillow.WillOWisp.Damage"
	end

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetParent() )
end

-- function modifier_bakedanuki_futatsuiwas_curse:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_bakedanuki_futatsuiwas_curse:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end