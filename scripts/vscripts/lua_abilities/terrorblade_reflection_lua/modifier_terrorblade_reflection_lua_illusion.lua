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
modifier_terrorblade_reflection_lua_illusion = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_terrorblade_reflection_lua_illusion:IsHidden()
	return true
end

function modifier_terrorblade_reflection_lua_illusion:IsDebuff()
	return false
end

function modifier_terrorblade_reflection_lua_illusion:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_terrorblade_reflection_lua_illusion:OnCreated( kv )
	-- references
	self.outgoing = self:GetAbility():GetSpecialValueFor( "illusion_outgoing_damage" )

	if not IsServer() then return end
end

function modifier_terrorblade_reflection_lua_illusion:OnRefresh( kv )
	
end

function modifier_terrorblade_reflection_lua_illusion:OnRemoved()
end

function modifier_terrorblade_reflection_lua_illusion:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_terrorblade_reflection_lua_illusion:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}

	return funcs
end

function modifier_terrorblade_reflection_lua_illusion:GetModifierMoveSpeed_Absolute()
	return 550
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_terrorblade_reflection_lua_illusion:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		-- [MODIFIER_STATE_UNSELECTABLE] = true,
		-- [MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		-- [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_terrorblade_reflection_lua_illusion:GetEffectName()
-- 	return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf"
-- end

-- function modifier_terrorblade_reflection_lua_illusion:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

function modifier_terrorblade_reflection_lua_illusion:GetStatusEffectName()
	return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_terrorblade_reflection_lua_illusion:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

-- function modifier_terrorblade_reflection_lua_illusion:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		effect_cast,
-- 		false, -- bDestroyImmediately
-- 		false, -- bStatusEffect
-- 		-1, -- iPriority
-- 		false, -- bHeroEffect
-- 		false -- bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end