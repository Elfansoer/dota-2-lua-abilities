bane_brain_sap_lua = class({})

--------------------------------------------------------------------------------
-- Custom KV
function bane_brain_sap_lua:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function bane_brain_sap_lua:CastFilterResultTarget( hTarget )
	local immune = 0
	if self:GetCaster():HasScepter() then
		immune = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		immune,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

--------------------------------------------------------------------------------
-- Ability Start
function bane_brain_sap_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local damage = self:GetSpecialValueFor("brain_sap_damage")
	local heal = self:GetSpecialValueFor("tooltip_brain_sap_heal_amt")

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then
		return
	end

	-- heal
	caster:Heal( heal, self )

	-- damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- Play effects
	self:PlayEffects( target )
end

--------------------------------------------------------------------------------
function bane_brain_sap_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_bane/bane_sap.vpcf"
	local sound_cast = "Hero_Bane.BrainSap"
	local sound_target = "Hero_Bane.BrainSap.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end