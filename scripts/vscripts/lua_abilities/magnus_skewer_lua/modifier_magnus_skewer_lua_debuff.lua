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
modifier_magnus_skewer_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_magnus_skewer_lua_debuff:IsHidden()
	return false
end

function modifier_magnus_skewer_lua_debuff:IsDebuff()
	return true
end

function modifier_magnus_skewer_lua_debuff:IsStunDebuff()
	return true
end

function modifier_magnus_skewer_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_magnus_skewer_lua_debuff:OnCreated( kv )
	if not IsServer() then return end

	self.dist = self:GetAbility():GetSpecialValueFor( "skewer_radius" )
	self.damage = self:GetAbility():GetSpecialValueFor( "skewer_damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )

	-- apply motion
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end

	-- play effects
	local sound_cast = "Hero_Magnataur.Skewer.Target"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_magnus_skewer_lua_debuff:OnRefresh( kv )
	
end

function modifier_magnus_skewer_lua_debuff:OnRemoved()
end

function modifier_magnus_skewer_lua_debuff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )

	-- debuff
	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_magnus_skewer_lua_slow", -- modifier name
		{ duration = self.duration } -- kv
	)

	-- damage
	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}
	ApplyDamage(damageTable)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_magnus_skewer_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_magnus_skewer_lua_debuff:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_magnus_skewer_lua_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_magnus_skewer_lua_debuff:UpdateHorizontalMotion( me, dt )
	local caster = self:GetCaster()
	local target = caster:GetOrigin() + caster:GetForwardVector() * self.dist

	me:SetOrigin( target )
end

function modifier_magnus_skewer_lua_debuff:OnHorizontalMotionInterrupted()
	self:Destroy()
end