modifier_omniknight_guardian_angel_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_omniknight_guardian_angel_lua:IsHidden()
	return false
end

function modifier_omniknight_guardian_angel_lua:IsDebuff()
	return false
end

function modifier_omniknight_guardian_angel_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_omniknight_guardian_angel_lua:OnCreated( kv )
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_omniknight_guardian_angel_lua:OnRefresh( kv )
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_omniknight_guardian_angel_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_omniknight_guardian_angel_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	}

	return funcs
end

function modifier_omniknight_guardian_angel_lua:GetAbsoluteNoDamagePhysical()
	return 1
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_omniknight_guardian_angel_lua:GetEffectName()
-- 	if self:GetParent()~=self:GetCaster() then
-- 		return "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf"
-- 	end
-- end

-- function modifier_omniknight_guardian_angel_lua:GetEffectAttachType()
-- 	if self:GetParent()~=self:GetCaster() then
-- 		return PATTACH_ABSORIGIN_FOLLOW
-- 	end
-- end

function modifier_omniknight_guardian_angel_lua:PlayEffects()
	local sound_cast = "Hero_Omniknight.GuardianAngel"
	EmitSoundOn( sound_cast, self:GetParent() )

	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf"
	if self:GetParent()==self:GetCaster() then
		particle_cast = "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_omni.vpcf"
	end

	-- create particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		5,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)

	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end