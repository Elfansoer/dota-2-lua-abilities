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
modifier_red_transistor_switch_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_switch_debuff:IsHidden()
	return false
end

function modifier_red_transistor_switch_debuff:IsDebuff()
	return true
end

function modifier_red_transistor_switch_debuff:IsStunDebuff()
	return false
end

function modifier_red_transistor_switch_debuff:IsPurgable()
	return true
end

function modifier_red_transistor_switch_debuff:GetTexture()
	return "custom/red_transistor_switch"
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_switch_debuff:OnCreated( kv )
	if not IsServer() then return end
	local parent = self:GetParent()

	-- store previous
	self.original_owner = parent:GetOwner()
	self.original_player = parent:GetPlayerOwnerID()
	self.original_team = parent:GetTeamNumber()

	-- dominate
	parent:SetOwner(self:GetCaster())
	parent:SetTeam(self:GetCaster():GetTeam())
	parent:SetControllableByPlayer(self:GetCaster():GetPlayerID(), false)

	-- attack move
	local order = {
		UnitIndex = parent:entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
		Position = parent:GetOrigin(),
		Queue = false,
	}
	ExecuteOrderFromTable( order )

end

function modifier_red_transistor_switch_debuff:OnRefresh( kv )
	
end

function modifier_red_transistor_switch_debuff:OnRemoved()
end

function modifier_red_transistor_switch_debuff:OnDestroy()
	if not IsServer() then return end
	local parent = self:GetParent()

	parent:SetOwner(self.original_owner)
	parent:SetTeam(self.original_team)
	parent:SetControllableByPlayer(self.original_player, false)
	parent:Stop()
end

-- --------------------------------------------------------------------------------
-- -- Modifier Effects
-- function modifier_red_transistor_switch_debuff:DeclareFunctions()
-- 	local funcs = {
-- 		MODIFIER_EVENT_ON_ATTACK,
-- 		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
-- 	}

-- 	return funcs
-- end

-- function modifier_red_transistor_switch_debuff:OnAttack( params )

-- end

-- function modifier_red_transistor_switch_debuff:GetModifierMoveSpeedBonus_Percentage()
-- 	return -100
-- end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_red_transistor_switch_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_DOMINATED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_red_transistor_switch_debuff:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_song_debuff.vpcf"
end

function modifier_red_transistor_switch_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

-- function modifier_red_transistor_switch_debuff:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_switch_debuff:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_red_transistor_switch_debuff:PlayEffects()
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