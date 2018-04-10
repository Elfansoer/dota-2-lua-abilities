modifier_sandra_sacrifice = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sandra_sacrifice:IsHidden()
	return false
end

function modifier_sandra_sacrifice:IsDebuff()
	return false
end

function modifier_sandra_sacrifice:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_sacrifice:OnCreated( kv )
	if IsServer() then
		-- references
		self.radius = self:GetAbility():GetSpecialValueFor( "leash_radius" ) -- special value
		local master = self:GetAbility():RetATValue( kv.master )

		-- create master's modifier
		local modifier = self:GetAbility():AddATValue( self )
		self.master = master:AddNewModifier(
			self:GetParent(), -- player source
			self:GetAbility(), -- ability source
			"modifier_sandra_sacrifice_master", -- modifier name
			{
				duration = kv.duration,
				modifier = modifier,
			} -- kv
		)

		-- Start interval
		-- self:StartIntervalThink( self.interval )
		-- self:OnIntervalThink()

		-- effects
		self:PlayEffects()
	end
end

function modifier_sandra_sacrifice:OnRefresh( kv )
end

function modifier_sandra_sacrifice:OnDestroy( kv )
	if IsServer() then
		if not self.master:IsNull() then
			self.master:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
-- function modifier_sandra_sacrifice:OnIntervalThink()
-- end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sandra_sacrifice:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_puck/puck_dreamcoil_tether.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.master:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self.master:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)

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