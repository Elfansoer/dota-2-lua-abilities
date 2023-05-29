modifier_antimage_spell_shield_lua = class({})

function modifier_antimage_spell_shield_lua:OnCreated( kv )
	self.bonus = self:GetAbility():GetSpecialValueFor("bonus_resist_pct")
end

function modifier_antimage_spell_shield_lua:OnRefresh( kv )
	self.bonus = self:GetAbility():GetSpecialValueFor("bonus_resist_pct")
end

--------------------------------------------------------------------------------

function modifier_antimage_spell_shield_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_REFLECT_SPELL,
		MODIFIER_PROPERTY_ABSORB_SPELL,
	}

	return funcs
end

function modifier_antimage_spell_shield_lua:GetModifierMagicalResistanceBonus( params )
	if not self:GetParent():PassivesDisabled() then
		return self.bonus
	end
end
function modifier_antimage_spell_shield_lua:GetAbsorbSpell( params )
	if IsServer() then
		if self:GetParent():HasScepter() and (not self:GetParent():PassivesDisabled()) and self:GetAbility():IsFullyCastable() then
			-- use resources
			self:GetAbility():UseResources( true, true, false, true )

			self:PlayEffects( true )
			return 1
		end
	end
end

modifier_antimage_spell_shield_lua.reflected_spell = nil
function modifier_antimage_spell_shield_lua:GetReflectSpell( params )
	if IsServer() then
		-- If unable to reflect due to the source ability
		if params.ability==nil or self.reflect_exceptions[params.ability:GetAbilityName()] then
			return 0
		end

		if self:GetParent():HasScepter() and (not self:GetParent():PassivesDisabled()) and self:GetAbility():IsFullyCastable() then
			-- use resources
			self.reflect = true

			-- remove previous ability
			if self.reflected_spell~=nil then
				self:GetParent():RemoveAbility( self.reflected_spell:GetAbilityName() )
			end

			-- copy the ability
			local sourceAbility = params.ability
			local selfAbility = self:GetParent():AddAbility( sourceAbility:GetAbilityName() )
			selfAbility:SetLevel( sourceAbility:GetLevel() )
			selfAbility:SetStolen( true )
			selfAbility:SetHidden( true )

			-- store the ability
			self.reflected_spell = selfAbility

			-- cast the ability
			self:GetParent():SetCursorCastTarget( sourceAbility:GetCaster() )
			selfAbility:CastAbility()

			-- play effects
			self:PlayEffects( false )
			return 1
		end
	end
end
--------------------------------------------------------------------------------
function modifier_antimage_spell_shield_lua:PlayEffects( bBlock )
	-- Get Resources
	local particle_cast = ""
	local sound_cast = ""

	if bBlock then
		particle_cast = "particles/units/heroes/hero_antimage/antimage_spellshield.vpcf"
		sound_cast = "Hero_Antimage.SpellShield.Block"
	else
		particle_cast = "particles/units/heroes/hero_antimage/antimage_spellshield_reflect.vpcf"
		sound_cast = "Hero_Antimage.SpellShield.Reflect"
	end

	-- Play particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Play sounds
	EmitSoundOn( sound_cast, self:GetParent() )
end

modifier_antimage_spell_shield_lua.reflect_exceptions = {
	["rubick_spell_steal_lua"] = true
}