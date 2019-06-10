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
modifier_dark_willow_shadow_realm_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_willow_shadow_realm_lua_buff:IsHidden()
	return true
end

function modifier_dark_willow_shadow_realm_lua_buff:IsDebuff()
	return false
end

function modifier_dark_willow_shadow_realm_lua_buff:IsPurgable()
	return false
end

function modifier_dark_willow_shadow_realm_lua_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_willow_shadow_realm_lua_buff:OnCreated( kv )
	if not IsServer() then return end

	-- references
	self.damage = kv.damage
	self.record = kv.record
	self.time = kv.time
	self.target = EntIndexToHScript( kv.target )

	self.target_pos = self.target:GetOrigin()
	self.target_prev = self.target_pos

	-- create custom projectile
	self:PlayEffects()
end

function modifier_dark_willow_shadow_realm_lua_buff:OnRefresh( kv )
	
end

function modifier_dark_willow_shadow_realm_lua_buff:OnRemoved()
end

function modifier_dark_willow_shadow_realm_lua_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dark_willow_shadow_realm_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,

		MODIFIER_EVENT_ON_PROJECTILE_DODGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE, -- this does nothing but tracking target's movement, for projectile dodge purposes
	}

	return funcs
end

function modifier_dark_willow_shadow_realm_lua_buff:OnAttackRecordDestroy( params )
	if not IsServer() then return end
	if params.record~=self.record then return end

	-- destroy buff if attack finished (proc/miss/whatever)
	self:StopEffects( false )
	self:Destroy()
end
function modifier_dark_willow_shadow_realm_lua_buff:GetModifierProcAttack_BonusDamage_Magical( params )
	if params.record~=self.record then return end

	-- overhead event
	SendOverheadEventMessage(
		nil, --DOTAPlayer sendToPlayer,
		OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
		params.target,
		self.damage * self.time,
		self:GetParent():GetPlayerOwner() -- DOTAPlayer sourcePlayer
	)

	-- play effects
	local sound_cast = "Hero_DarkWillow.Shadow_Realm.Damage"
	EmitSoundOn( sound_cast, self:GetParent() )

	return self.damage * self.time
end

function modifier_dark_willow_shadow_realm_lua_buff:OnProjectileDodge( params )
	if not IsServer() then return end
	if params.target~=self.target then return end

	-- set target CP to last known location
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		1,
		self.target,
		PATTACH_CUSTOMORIGIN,
		"attach_hitloc",
		self.target_prev, -- unknown
		true -- unknown, true
	)
end
function modifier_dark_willow_shadow_realm_lua_buff:GetModifierBaseAttack_BonusDamage()
	if not IsServer() then return end

	-- track target's position each frame
	self.target_prev = self.target_pos
	self.target_pos = self.target:GetOrigin()

	-- the property actually does nothing
	return 0
end

--------------------------------------------------------------------------------
-- Graphics and Animations
function modifier_dark_willow_shadow_realm_lua_buff:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_willow/dark_willow_shadow_attack.vpcf"

	-- Get data
	local speed = self:GetParent():GetProjectileSpeed()

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		1,
		self.target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( speed, 0, 0 ) )
	ParticleManager:SetParticleControl( self.effect_cast, 5, Vector( self.time, 0, 0 ) )
end

function modifier_dark_willow_shadow_realm_lua_buff:StopEffects( dodge )
	-- destroy effects
	ParticleManager:DestroyParticle( self.effect_cast, dodge )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end