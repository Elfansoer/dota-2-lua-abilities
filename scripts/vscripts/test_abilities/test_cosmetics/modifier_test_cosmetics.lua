-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_test_cosmetics = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_test_cosmetics:IsHidden()
	return false
end

function modifier_test_cosmetics:IsDebuff()
	return false
end

function modifier_test_cosmetics:IsStunDebuff()
	return false
end

function modifier_test_cosmetics:IsPurgable()
	return false
end

-- function modifier_test_cosmetics:RemoveOnDeath()
-- 	return false
-- end

--------------------------------------------------------------------------------
-- Initializations
function modifier_test_cosmetics:OnCreated( kv )
	if IsServer() then
		-- ambient blade
		local particle_cast1 = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_a.vpcf"
		local particle_cast2 = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_b.vpcf"
		local effect_cast1 = ParticleManager:CreateParticle( particle_cast1, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		local effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

		if kv.style and kv.style~=0 then
			for i=9,12 do
				ParticleManager:SetParticleControl( effect_cast1, i, Vector(0,0,0) )
				ParticleManager:SetParticleControl( effect_cast2, i, Vector(0,0,0) )
			end

			if kv.style==1 then
				ParticleManager:SetParticleControl( effect_cast1, 26, Vector(40,0,0) )
				ParticleManager:SetParticleControl( effect_cast2, 26, Vector(40,0,0) )
			elseif kv.style==2 then
				ParticleManager:SetParticleControl( effect_cast1, 26, Vector(100,0,0) )
				ParticleManager:SetParticleControl( effect_cast2, 26, Vector(100,0,0) )
			end
		end

		ParticleManager:SetParticleControlEnt(
			effect_cast1,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_attack1",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)
		ParticleManager:SetParticleControlEnt(
			effect_cast2,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_attack2",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)

		self:AddParticle(
			effect_cast1,
			false, -- bDestroyImmediately
			false, -- bStatusEffect
			-1, -- iPriority
			false, -- bHeroEffect
			false -- bOverheadEffect
		)
		self:AddParticle(
			effect_cast2,
			false, -- bDestroyImmediately
			false, -- bStatusEffect
			-1, -- iPriority
			false, -- bHeroEffect
			false -- bOverheadEffect
		)
	end
end

function modifier_test_cosmetics:OnRefresh( kv )
	
end

function modifier_test_cosmetics:OnRemoved()
end

function modifier_test_cosmetics:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_test_cosmetics:DeclareFunctions()
	local funcs = {
	    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_test_cosmetics:GetActivityTranslationModifiers()
    return "arcana"
end

function modifier_test_cosmetics:OnDeath( params )
	if params.unit==self:GetParent() then
		-- play effects
		local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_death.vpcf"
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			1,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			3,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)
		ParticleManager:ReleaseParticleIndex( effect_cast )
	end
end

function modifier_test_cosmetics:GetStatusEffectName()
	return "particles/midas_golden_touch_fx.vpcf"
end
