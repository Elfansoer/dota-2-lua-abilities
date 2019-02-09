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
modifier_generic_tracking_projectile = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_tracking_projectile:IsHidden()
	return true
end

function modifier_generic_tracking_projectile:IsPurgable()
	return false
end

function modifier_generic_tracking_projectile:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_tracking_projectile:OnCreated( kv )
	if IsServer() then
	end
end

function modifier_generic_tracking_projectile:OnRefresh( kv )
	
end

function modifier_generic_tracking_projectile:OnRemoved()
end

function modifier_generic_tracking_projectile:OnDestroy()
	if IsServer() then
		self:StopTrackingProjectile()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_tracking_projectile:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_PROJECTILE_DODGE,
	}

	return funcs
end

function modifier_generic_tracking_projectile:OnProjectileDodge( params )
	if IsServer() then
		if params.target~=self:GetParent() then return end
		self.dodge = true
		ParticleManager:SetParticleControlEnt(
			self.effect_cast,
			1,
			self:GetCaster(),
			PATTACH_CUSTOMORIGIN,
			"",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)
	end
end

--------------------------------------------------------------------------------
--
function modifier_generic_tracking_projectile:PlayTrackingProjectile( info )
	-- self.effect_cast = ParticleManager:CreateParticle( info.EffectName, PATTACH_ABSORIGIN, info.Source )
	self.effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, info.EffectName, PATTACH_ABSORIGIN, info.Source )
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		0,
		info.Source,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		1,
		info.Target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		9,
		info.Source,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( info.iMoveSpeed, 0, 0 ) )

	return self.effect_cast
end

function modifier_generic_tracking_projectile:StopTrackingProjectile()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end