modifier_invoker_cold_snap_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_cold_snap_lua:IsHidden()
	return false
end

function modifier_invoker_cold_snap_lua:IsDebuff()
	return true
end

function modifier_invoker_cold_snap_lua:IsStunDebuff()
	return false
end

function modifier_invoker_cold_snap_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_cold_snap_lua:OnCreated( kv )
	if IsServer() then
		-- references
		self.damage = self:GetAbility():GetOrbSpecialValueFor( "freeze_damage", "q" )
		self.duration = self:GetAbility():GetOrbSpecialValueFor( "freeze_duration", "q" )
		self.cooldown = self:GetAbility():GetOrbSpecialValueFor( "freeze_cooldown", "q" )
		self.threshold = self:GetAbility():GetOrbSpecialValueFor( "damage_trigger", "q" )

		self.onCooldown = false

		-- Start interval
		self:Freeze()
	end
end

function modifier_invoker_cold_snap_lua:OnRefresh( kv )
	if IsServer() then
		-- references
		self.damage = self:GetAbility():GetOrbSpecialValueFor( "freeze_damage", "q" )
		self.duration = self:GetAbility():GetOrbSpecialValueFor( "freeze_duration", "q" )
		self.cooldown = self:GetAbility():GetOrbSpecialValueFor( "freeze_cooldown", "q" )
		self.threshold = self:GetAbility():GetOrbSpecialValueFor( "damage_trigger", "q" )
	end
end

function modifier_invoker_cold_snap_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_cold_snap_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_invoker_cold_snap_lua:OnTakeDamage( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end
		if params.damage<self.threshold then return end
		if self.onCooldown then return end
		self:Freeze()

		self:PlayEffects( params.attacker )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_invoker_cold_snap_lua:OnIntervalThink()
	self.onCooldown = false
	self:StartIntervalThink(-1)
end

--------------------------------------------------------------------------------
-- Helper functions
function modifier_invoker_cold_snap_lua:Freeze()
	self.onCooldown = true
	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = self.duration } -- kv
	)
	self:StartIntervalThink( self.cooldown )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_invoker_cold_snap_lua:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_cold_snap_status.vpcf"
end

function modifier_invoker_cold_snap_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_invoker_cold_snap_lua:PlayEffects( attacker )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf"
	local sound_cast = "Hero_Invoker.ColdSnap.Freeze"

	-- Get Data
	local direction = self:GetParent():GetOrigin()-attacker:GetOrigin()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1,  self:GetParent():GetOrigin()+direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end