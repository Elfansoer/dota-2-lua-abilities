modifier_antimage_mana_break_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_antimage_mana_break_lua:IsHidden()
	return true
end

function modifier_antimage_mana_break_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_antimage_mana_break_lua:OnCreated( kv )
	-- references
	self.mana_break = self:GetAbility():GetSpecialValueFor( "mana_per_hit" ) -- special value
	self.mana_damage_pct = self:GetAbility():GetSpecialValueFor( "damage_per_burn" ) -- special value
end

function modifier_antimage_mana_break_lua:OnRefresh( kv )
	-- references
	self.mana_break = self:GetAbility():GetSpecialValueFor( "mana_per_hit" ) -- special value
	self.mana_damage_pct = self:GetAbility():GetSpecialValueFor( "damage_per_burn" ) -- special value
end

function modifier_antimage_mana_break_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_antimage_mana_break_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function modifier_antimage_mana_break_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		local target = params.target
		local result = UnitFilter(
			target,	-- Target Filter
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- Team Filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,	-- Unit Filter
			DOTA_UNIT_TARGET_FLAG_MANA_ONLY,	-- Unit Flag
			self:GetParent():GetTeamNumber()	-- Team reference
		)
	
		if result == UF_SUCCESS then
			local mana_burn =  math.min( target:GetMana(), self.mana_break )
			target:Script_ReduceMana( mana_burn, self:GetAbility() )

			self:PlayEffects( target )

			return mana_burn * self.mana_damage_pct
		end

	end
end

function modifier_antimage_mana_break_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/generic_manaburn.vpcf"
	local sound_cast = "Hero_Antimage.ManaBreak"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, target )
	-- ParticleManager:SetParticleControl( effect_cast, 0, vControlVector )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end
