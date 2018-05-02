modifier_lion_hex_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lion_hex_lua:IsHidden()
	return false
end

function modifier_lion_hex_lua:IsDebuff()
	return true
end

function modifier_lion_hex_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lion_hex_lua:OnCreated( kv )
	-- references
	self.base_speed = self:GetAbility():GetSpecialValueFor( "movespeed" )
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

function modifier_lion_hex_lua:OnRefresh( kv )
	-- references
	self.base_speed = self:GetAbility():GetSpecialValueFor( "hex_base_speed" )
	if IsServer() then
		-- play effects
		self:PlayEffects( true )
	end
end

function modifier_lion_hex_lua:OnDestroy( kv )
	if IsServer() then
		-- play effects
		self:PlayEffects( false )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lion_hex_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}

	return funcs
end

function modifier_lion_hex_lua:GetModifierMoveSpeedOverride()
	return self.base_speed
end
function modifier_lion_hex_lua:GetModifierModelChange()
	return self.model
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_lion_hex_lua:CheckState()
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
function modifier_lion_hex_lua:PlayEffects( bStart )
	local sound_cast = "Hero_Lion.Hex.Target"
	local particle_cast = "particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	if bStart then
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end