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
modifier_medusa_stone_gaze_lua_petrified = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_medusa_stone_gaze_lua_petrified:IsHidden()
	return false
end

function modifier_medusa_stone_gaze_lua_petrified:IsDebuff()
	return true
end

function modifier_medusa_stone_gaze_lua_petrified:IsStunDebuff()
	return true
end

function modifier_medusa_stone_gaze_lua_petrified:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_medusa_stone_gaze_lua_petrified:OnCreated( kv )
	if not IsServer() then return end

	-- references
	self.physical_bonus = kv.physical_bonus
	self.center_unit = EntIndexToHScript( kv.center_unit )

	self:PlayEffects()
end

function modifier_medusa_stone_gaze_lua_petrified:OnRefresh( kv )
	if not IsServer() then return end

	-- references
	self.physical_bonus = kv.physical_bonus
	self.center_unit = EntIndexToHScript( kv.center_unit )

	self:PlayEffects()
end

function modifier_medusa_stone_gaze_lua_petrified:OnRemoved()
end

function modifier_medusa_stone_gaze_lua_petrified:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_medusa_stone_gaze_lua_petrified:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_medusa_stone_gaze_lua_petrified:GetModifierIncomingDamage_Percentage( params )
	if params.damage_type==DAMAGE_TYPE_PHYSICAL then
		return self.physical_bonus
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_medusa_stone_gaze_lua_petrified:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_medusa_stone_gaze_lua_petrified:GetStatusEffectName()
	return "particles/status_fx/status_effect_medusa_stone_gaze.vpcf"
end
function modifier_medusa_stone_gaze_lua_petrified:StatusEffectPriority(  )
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_medusa_stone_gaze_lua_petrified:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff_stoned.vpcf"
	local sound_cast = "Hero_Medusa.StoneGaze.Stun"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.center_unit,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector( 0,0,0 ), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOnClient( sound_cast, self:GetParent():GetPlayerOwner() )
end