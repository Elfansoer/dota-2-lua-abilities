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
modifier_midas_golden_valkyrie_ambient = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_valkyrie_ambient:IsHidden()
	return true
end

function modifier_midas_golden_valkyrie_ambient:IsPurgable()
	return false
end

function modifier_midas_golden_valkyrie_ambient:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_valkyrie_ambient:OnCreated( kv )
	if IsServer() then
		-- Create Ambient
		self:PlayEffects1( kv.style )
		self:GetParent():StartGestureWithPlaybackRate( ACT_DOTA_SPAWN, 1.1 )

		-- Play sound
		local sound_cast = "Hero_ArcWarden.TempestDouble"
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end

function modifier_midas_golden_valkyrie_ambient:OnRefresh( kv )
	if IsServer() then
		-- self:GetParent():RemoveNoDraw()
		self:GetParent():StartGestureWithPlaybackRate( ACT_DOTA_SPAWN, 1.1 )

		-- Play sound
		local sound_cast = "Hero_ArcWarden.TempestDouble"
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end

function modifier_midas_golden_valkyrie_ambient:OnRemoved()
end

function modifier_midas_golden_valkyrie_ambient:OnDestroy()
	if IsServer() then
		self:PlayEffects2()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_midas_golden_valkyrie_ambient:DeclareFunctions()
	local funcs = {
	    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	    MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_midas_golden_valkyrie_ambient:GetActivityTranslationModifiers()
    return "arcana"
end

function modifier_midas_golden_valkyrie_ambient:OnDeath( params )
	if params.unit~=self:GetParent() then return end
	self:PlayEffects2()
	self:GetParent():SetOrigin( self:GetParent():GetOrigin() - Vector( 0,0,1000 ) )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_midas_golden_valkyrie_ambient:GetStatusEffectName()
	return "particles/midas_golden_touch_fx.vpcf"
end

function modifier_midas_golden_valkyrie_ambient:PlayEffects1( style )
	-- ambient blade
	local particle_cast1 = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_a.vpcf"
	local particle_cast2 = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_b.vpcf"
	local effect_cast1 = ParticleManager:CreateParticle( particle_cast1, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	local effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

	if style and style~=0 then
		for i=9,12 do
			ParticleManager:SetParticleControl( effect_cast1, i, Vector(0,0,0) )
			ParticleManager:SetParticleControl( effect_cast2, i, Vector(0,0,0) )
		end

		if style==1 then
			ParticleManager:SetParticleControl( effect_cast1, 26, Vector(40,0,0) )
			ParticleManager:SetParticleControl( effect_cast2, 26, Vector(40,0,0) )
		elseif style==2 then
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

function modifier_midas_golden_valkyrie_ambient:PlayEffects2()
	local particle_cast = "particles/midas_golden_touch_explode.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- play sound
	local sound_cast = "Hero_VengefulSpirit.MagicMissileImpact"
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetParent() )
end