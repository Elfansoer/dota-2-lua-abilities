modifier_slardar_corrosive_haze_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_slardar_corrosive_haze_lua:IsHidden()
	return false
end

function modifier_slardar_corrosive_haze_lua:IsDebuff()
	return true
end

function modifier_slardar_corrosive_haze_lua:IsStunDebuff()
	return false
end

function modifier_slardar_corrosive_haze_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slardar_corrosive_haze_lua:OnCreated( kv )
	-- references
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" ) -- special value

	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_slardar_corrosive_haze_lua:OnRefresh( kv )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" ) -- special value
end

function modifier_slardar_corrosive_haze_lua:OnDestroy( kv )
	
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slardar_corrosive_haze_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}

	return funcs
end

function modifier_slardar_corrosive_haze_lua:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end

function modifier_slardar_corrosive_haze_lua:GetModifierProvidesFOWVision()
	return 1
end

--------------------------------------------------------------------------------

function modifier_slardar_corrosive_haze_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
	}

	return state
end
--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_slardar_corrosive_haze_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_slardar/slardar_amp_damage.vpcf"
	
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		0,
		self:GetParent(),
		PATTACH_OVERHEAD_FOLLOW,
		nil,
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		1,
		self:GetParent(),
		PATTACH_OVERHEAD_FOLLOW,
		nil,
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		2,
		self:GetParent(),
		PATTACH_OVERHEAD_FOLLOW,
		nil,
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	self:AddParticle(
		self.effect_cast,
		false,
		false,
		-1,
		false,
		true
	)
end