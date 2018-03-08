modifier_phantom_assassin_coup_de_grace_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_assassin_coup_de_grace_lua:IsHidden()
	-- actual true
	return false
end

function modifier_phantom_assassin_coup_de_grace_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_coup_de_grace_lua:OnCreated( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_bonus = self:GetAbility():GetSpecialValueFor( "crit_bonus" )
end

function modifier_phantom_assassin_coup_de_grace_lua:OnRefresh( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_bonus = self:GetAbility():GetSpecialValueFor( "crit_bonus" )
end

function modifier_phantom_assassin_coup_de_grace_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_coup_de_grace_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_phantom_assassin_coup_de_grace_lua:GetModifierPreAttack_CriticalStrike( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		if self:RollChance( self.crit_chance ) then
			self.record = params.record
			return self.crit_bonus
		end
	end
end

function modifier_phantom_assassin_coup_de_grace_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		if self.record then
			self.record = nil
			self:PlayEffects( params.target )
		end
	end
end
--------------------------------------------------------------------------------
-- Helper
function modifier_phantom_assassin_coup_de_grace_lua:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_phantom_assassin_coup_de_grace_lua:PlayEffects( target )
	-- Load effects
	local particle_cast = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf"
	local sound_cast = "Hero_PhantomAssassin.CoupDeGrace"

	-- if target:IsMechanical() then
	-- 	particle_cast = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact_mechanical.vpcf"
	-- 	sound_cast = "Hero_PhantomAssassin.CoupDeGrace.Mech"
	-- end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, 1, (self:GetParent():GetOrigin()-target:GetOrigin()):Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, target )
end