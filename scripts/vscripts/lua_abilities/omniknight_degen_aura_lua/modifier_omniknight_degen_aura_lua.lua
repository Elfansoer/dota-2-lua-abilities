modifier_omniknight_degen_aura_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_omniknight_degen_aura_lua:IsHidden()
	return true
end

function modifier_omniknight_degen_aura_lua:IsDebuff()
	return false
end

function modifier_omniknight_degen_aura_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_omniknight_degen_aura_lua:IsAura()
	return true
end

function modifier_omniknight_degen_aura_lua:GetModifierAura()
	return "modifier_omniknight_degen_aura_lua_effect"
end

function modifier_omniknight_degen_aura_lua:GetAuraRadius()
	return self.radius
end

function modifier_omniknight_degen_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_omniknight_degen_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_omniknight_degen_aura_lua:GetAuraSearchFlags()
	return 0
end

function modifier_omniknight_degen_aura_lua:GetAuraDuration()
	return 2
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_omniknight_degen_aura_lua:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value

	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_omniknight_degen_aura_lua:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
end

function modifier_omniknight_degen_aura_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_omniknight_degen_aura_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_degen_aura.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )

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