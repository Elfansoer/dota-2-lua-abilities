modifier_sniper_assassinate_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sniper_assassinate_lua:IsHidden()
	return false
end

function modifier_sniper_assassinate_lua:IsDebuff()
	return true
end

function modifier_sniper_assassinate_lua:IsPurgable()
	return false
end

function modifier_sniper_assassinate_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_assassinate_lua:OnCreated( kv )
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_sniper_assassinate_lua:OnRefresh( kv )
	
end

function modifier_sniper_assassinate_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sniper_assassinate_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}

	return funcs
end
function modifier_sniper_assassinate_lua:GetModifierProvidesFOWVision()
	return true
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sniper_assassinate_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_sniper_assassinate_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sniper_assassinate_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

function modifier_sniper_assassinate_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_sniper/sniper_crosshair.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent(), self:GetCaster():GetTeamNumber() )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		true
	)
end