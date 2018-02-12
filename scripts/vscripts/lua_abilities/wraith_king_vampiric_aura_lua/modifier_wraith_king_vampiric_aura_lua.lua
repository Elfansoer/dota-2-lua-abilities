modifier_wraith_king_vampiric_aura_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wraith_king_vampiric_aura_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Aura
function modifier_wraith_king_vampiric_aura_lua:IsAura()
	return true
end

function modifier_wraith_king_vampiric_aura_lua:GetModifierAura()
	return "modifier_wraith_king_vampiric_aura_lua_lifesteal"
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraRadius()
	return self.aura_radius
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraSearchType()
	print("toggle:",self:GetAbility():GetToggleState())
	if self:GetAbility():GetToggleState() then
		return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	end
	
	return DOTA_UNIT_TARGET_HERO
end

function modifier_wraith_king_vampiric_aura_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_wraith_king_vampiric_aura_lua:OnCreated( kv )
	-- references
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "vampiric_aura_radius" ) -- special value
end

function modifier_wraith_king_vampiric_aura_lua:OnRefresh( kv )
	-- references
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "vampiric_aura_radius" ) -- special value
end
--------------------------------------------------------------------------------
-- Modifier Effects
-- function modifier_wraith_king_vampiric_aura_lua:DeclareFunctions()
-- 	local funcs = {
-- 		MODIFIER_EVENT_ON_ATTACK,
-- 		MODIFIER_EVENT_ON_TAKEDAMAGE,
-- 	}

-- 	return funcs
-- end

-- function modifier_wraith_king_vampiric_aura_lua:OnAttack( params )
-- 	if IsServer() then
-- 		-- filter
-- 		local pass = false
-- 		if params.attacker==self:GetParent() then
-- 			pass = true
-- 		end

-- 		-- logic
-- 		if pass then
-- 			-- get heal value
-- 			self.attack_record = params.record
-- 		end
-- 	end
-- end

-- function modifier_wraith_king_vampiric_aura_lua:OnTakeDamage( params )
-- 	if IsServer() then
-- 		-- filter
-- 		local pass = false
-- 		if self.attack_record~=nil then
-- 			if params.record == self.attack_record then
-- 				pass = true
-- 			end
-- 		end

-- 		-- logic
-- 		if pass then
-- 			self.attack_record = nil

-- 			-- get heal value
-- 			local heal = params.damage * self.aura_lifesteal/100
-- 			self:GetParent():Heal( heal, self:GetAbility() )
-- 			self:PlayEffects( self:GetParent() )
-- 		end
-- 	end
-- end
--------------------------------------------------------------------------------
-- Status Effects

--------------------------------------------------------------------------------
-- Interval Effects

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_wraith_king_vampiric_aura_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_wraith_king_vampiric_aura_lua:GetEffectAttachType()
-- 	return PATTACH_XX
-- end

-- function modifier_wraith_king_vampiric_aura_lua:PlayEffects( target )
-- 	-- get resource
-- 	local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"

-- 	-- play effects
-- 		-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )
-- end