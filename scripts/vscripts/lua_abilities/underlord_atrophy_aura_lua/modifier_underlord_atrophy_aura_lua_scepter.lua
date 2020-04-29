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
modifier_underlord_atrophy_aura_lua_scepter = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_underlord_atrophy_aura_lua_scepter:IsHidden()
	return self:GetStackCount()==0
end

function modifier_underlord_atrophy_aura_lua_scepter:IsDebuff()
	return false
end

function modifier_underlord_atrophy_aura_lua_scepter:IsStunDebuff()
	return false
end

function modifier_underlord_atrophy_aura_lua_scepter:IsPurgable()
	return false
end

function modifier_underlord_atrophy_aura_lua_scepter:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_underlord_atrophy_aura_lua_scepter:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.bonus_pct = 50

	if not IsServer() then return end

	self.modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_underlord_atrophy_aura_lua", self:GetCaster() )
end

function modifier_underlord_atrophy_aura_lua_scepter:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_underlord_atrophy_aura_lua_scepter:OnRemoved()
end

function modifier_underlord_atrophy_aura_lua_scepter:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_underlord_atrophy_aura_lua_scepter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

function modifier_underlord_atrophy_aura_lua_scepter:GetModifierPreAttack_BonusDamage()
	-- not applicable to original owner
	if self:GetParent()==self:GetCaster() then return 0 end

	-- calculate stack value
	if IsServer() then
		-- copy half of stack value
		local bonus = self.modifier:GetStackCount()
		bonus = math.floor( bonus*self.bonus_pct/100 )

		-- set stack
		self:SetStackCount( bonus )
	end

	return self:GetStackCount()
end

-- --------------------------------------------------------------------------------
-- -- Interval Effects
-- function modifier_underlord_atrophy_aura_lua_scepter:OnIntervalThink()
-- end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_underlord_atrophy_aura_lua_scepter:IsAura()
	local caster = self:GetCaster()
	local parent = self:GetParent()

	-- scepter
	if not caster:HasScepter() then return false end

	-- only for original owner
	return self:GetParent()==self:GetCaster()
end

function modifier_underlord_atrophy_aura_lua_scepter:GetModifierAura()
	return "modifier_underlord_atrophy_aura_lua_scepter"
end

function modifier_underlord_atrophy_aura_lua_scepter:GetAuraRadius()
	return self.radius
end

function modifier_underlord_atrophy_aura_lua_scepter:GetAuraDuration()
	return 0.5
end

function modifier_underlord_atrophy_aura_lua_scepter:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_underlord_atrophy_aura_lua_scepter:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_underlord_atrophy_aura_lua_scepter:GetAuraSearchFlags()
	return 0
end

function modifier_underlord_atrophy_aura_lua_scepter:IsAuraActiveOnDeath()
	return false
end

function modifier_underlord_atrophy_aura_lua_scepter:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_underlord_atrophy_aura_lua_scepter:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_underlord_atrophy_aura_lua_scepter:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_underlord_atrophy_aura_lua_scepter:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_underlord_atrophy_aura_lua_scepter:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_underlord_atrophy_aura_lua_scepter:PlayEffects()
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