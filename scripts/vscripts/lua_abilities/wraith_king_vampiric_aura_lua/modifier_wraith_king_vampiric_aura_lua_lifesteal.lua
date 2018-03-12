modifier_wraith_king_vampiric_aura_lua_lifesteal = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wraith_king_vampiric_aura_lua_lifesteal:IsHidden()
	return false
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:IsDebuff()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wraith_king_vampiric_aura_lua_lifesteal:OnCreated( kv )
	-- references
	self.aura_lifesteal = self:GetAbility():GetSpecialValueFor( "vampiric_aura" ) -- special value
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:OnRefresh( kv )
	-- references
	self.aura_lifesteal = self:GetAbility():GetSpecialValueFor( "vampiric_aura" ) -- special value
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wraith_king_vampiric_aura_lua_lifesteal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.target:GetTeamNumber()~=self:GetParent():GetTeamNumber() then
			if (not params.target:IsBuilding()) and (not params.target:IsOther()) then
				pass = true
			end
		end

		-- logic
		if pass then
			-- save attack record
			self.attack_record = params.record
		end
	end
end

function modifier_wraith_king_vampiric_aura_lua_lifesteal:OnTakeDamage( params )
	if IsServer() then
		-- filter
		local pass = false
		if self.attack_record and params.record == self.attack_record then
			pass = true
			self.attack_record = nil
		end

		-- logic
		if pass then
			-- get heal value
			local heal = params.damage * self.aura_lifesteal/100
			self:GetParent():Heal( heal, self:GetAbility() )
			self:PlayEffects( self:GetParent() )
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_wraith_king_vampiric_aura_lua_lifesteal:PlayEffects( target )
	-- get resource
	local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"

	-- play effects
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, target:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end