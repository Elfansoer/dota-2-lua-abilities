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
modifier_doom_doom_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_doom_doom_lua:IsHidden()
	return false
end

function modifier_doom_doom_lua:IsDebuff()
	return true
end

function modifier_doom_doom_lua:IsStunDebuff()
	return false
end

function modifier_doom_doom_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_doom_doom_lua:OnCreated( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.deniable = self:GetAbility():GetSpecialValueFor( "deniable_pct" )
	self.interval = 1

	-- scepter
	self.scepter = self:GetCaster():HasScepter()
	if self.scepter then
		damage = self:GetAbility():GetSpecialValueFor( "damage_scepter" )
	end
	self.check_radius = 900

	if not IsServer() then return end
	-- precache and apply damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	ApplyDamage( self.damageTable )

	-- Start interval
	self:StartIntervalThink( self.interval )

	-- play effects
	self:PlayEffects()
end

function modifier_doom_doom_lua:OnRefresh( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.deniable = self:GetAbility():GetSpecialValueFor( "deniable_pct" )

	-- scepter
	self.scepter = self:GetCaster():HasScepter()
	if self.scepter then
		damage = self:GetAbility():GetSpecialValueFor( "damage_scepter" )
	end

	if not IsServer() then return end
	-- update damage
	self.damageTable.damage = damage

	-- Create Sound
	local sound_cast = "Hero_DoomBringer.Doom"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_doom_doom_lua:OnRemoved()
end

function modifier_doom_doom_lua:OnDestroy()
	if not IsServer() then return end
	-- stop sound
	local sound_cast = "Hero_DoomBringer.Doom"
	StopSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_doom_doom_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_PASSIVES_DISABLED] = self.scepter,
		[MODIFIER_STATE_SPECIALLY_DENIABLE] = self:GetParent():GetHealthPercent()<self.deniable,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_doom_doom_lua:OnIntervalThink()
	-- Apply damage
	ApplyDamage( self.damageTable )

	-- scepter time check
	if self.scepter then
		-- get distance
		local distance = (self:GetParent():GetOrigin()-self:GetCaster():GetOrigin()):Length2D()
		if distance<self.check_radius then
			-- increment duration
			self:SetDuration( self:GetRemainingTime() + self.interval, true )
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_doom_doom_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_doom.vpcf"
end

function modifier_doom_doom_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_doom_doom_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf"
	local sound_cast = "Hero_DoomBringer.Doom"

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	-- ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		MODIFIER_PRIORITY_SUPER_ULTRA, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end