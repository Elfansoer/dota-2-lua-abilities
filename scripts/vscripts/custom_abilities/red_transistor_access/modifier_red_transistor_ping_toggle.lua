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
modifier_red_transistor_ping_toggle = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_ping_toggle:IsHidden()
	return true
end

function modifier_red_transistor_ping_toggle:IsDebuff()
	return false
end

function modifier_red_transistor_ping_toggle:IsStunDebuff()
	return false
end

function modifier_red_transistor_ping_toggle:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_ping_toggle:OnCreated( kv )
	if not IsServer() then return end

	self.interval = kv.interval
	self.ready = true
end

function modifier_red_transistor_ping_toggle:OnRefresh( kv )
end

function modifier_red_transistor_ping_toggle:OnRemoved()
end

function modifier_red_transistor_ping_toggle:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_ping_toggle:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_red_transistor_ping_toggle:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	-- right click, switch position
	if 	params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION then
		self:Fire( params.new_pos )
	elseif 
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
		params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET
	then
		self:Fire( params.target:GetOrigin() )
	elseif params.ability==self:GetAbility() then
	-- stop or hold
	-- elseif 
	-- 	params.order_type==DOTA_UNIT_ORDER_STOP or
	-- 	params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
	-- then
	else
		-- self:Destroy()
		self:GetAbility():ToggleAbility()
	end
end

function modifier_red_transistor_ping_toggle:GetModifierMoveSpeed_Limit()
	return 0.1
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_red_transistor_ping_toggle:OnIntervalThink()
	self.ready = true
end

--------------------------------------------------------------------------------
-- Helper
function modifier_red_transistor_ping_toggle:Fire( position )
	if not self.ready then return end

	-- no mana
	if self:GetCaster():GetMana()<self:GetAbility():GetManaCost( -1 ) then return end

	-- spend mana
	self:GetAbility():PayManaCost()

	-- set cooldown
	self.ready = false
	self:StartIntervalThink( self.interval )

	self:GetCaster():SetCursorPosition( position )
	self:GetAbility():OnSpellStart()
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_red_transistor_ping_toggle:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_red_transistor_ping_toggle:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_red_transistor_ping_toggle:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_ping_toggle:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_red_transistor_ping_toggle:PlayEffects()
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
-- 		PATTACH_POINT_FOLLOW,
-- 		"attach_hitloc",
-- 		Vector(0,0,0), -- unknown
-- 		true -- unknown, true
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