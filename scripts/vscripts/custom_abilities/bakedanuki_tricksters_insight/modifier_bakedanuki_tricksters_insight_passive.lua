modifier_bakedanuki_tricksters_insight_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bakedanuki_tricksters_insight_passive:IsHidden()
	return true
end

function modifier_bakedanuki_tricksters_insight_passive:IsDebuff()
	return false
end

function modifier_bakedanuki_tricksters_insight_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
modifier_bakedanuki_tricksters_insight_passive.modifier_name = "modifier_bakedanuki_tricksters_insight"

function modifier_bakedanuki_tricksters_insight_passive:OnCreated( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_mult = self:GetAbility():GetSpecialValueFor( "crit_mult" )
end

function modifier_bakedanuki_tricksters_insight_passive:OnRefresh( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_mult = self:GetAbility():GetSpecialValueFor( "crit_mult" )
end

function modifier_bakedanuki_tricksters_insight_passive:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bakedanuki_tricksters_insight_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_ABSORB_SPELL,
	}

	return funcs
end
function modifier_bakedanuki_tricksters_insight_passive:GetModifierPreAttack_CriticalStrike( params )
	local modifier = params.target:FindModifierByNameAndCaster( self.modifier_name, self:GetParent() )

	if modifier then
		if RandomInt( 1, 100 )<=self.crit_chance then
			return self.crit_mult
		end
	end
end

function modifier_bakedanuki_tricksters_insight_passive:GetAbsorbSpell( params )
	local modifier = params.ability:GetCaster():FindModifierByNameAndCaster( self.modifier_name, self:GetParent() )
	if modifier then
		self:PlayEffects()
		return 1
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bakedanuki_tricksters_insight_passive:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_dark_willow/dark_willow_leyconduit_marker_helper.vpcf"
	local sound_cast = "Hero_DarkWillow.Ley.Count"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 200, 200, 200 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetParent() )
end