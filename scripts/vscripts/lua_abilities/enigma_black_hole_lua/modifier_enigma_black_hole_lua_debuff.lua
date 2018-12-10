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
modifier_enigma_black_hole_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_enigma_black_hole_lua_debuff:IsHidden()
	return false
end

function modifier_enigma_black_hole_lua_debuff:IsDebuff()
	return true
end

function modifier_enigma_black_hole_lua_debuff:IsStunDebuff()
	return true
end

function modifier_enigma_black_hole_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_enigma_black_hole_lua_debuff:OnCreated( kv )
	self.rate = self:GetAbility():GetSpecialValueFor( "animation_rate" )
	self.pull_speed = self:GetAbility():GetSpecialValueFor( "pull_speed" )
	self.rotate_speed = self:GetAbility():GetSpecialValueFor( "pull_rotate_speed" )

	if IsServer() then
		-- center
		self.center = Vector( kv.aura_origin_x, kv.aura_origin_y, 0 )

		-- apply motion controller
		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
		end
	end
end

function modifier_enigma_black_hole_lua_debuff:OnRefresh( kv )
	
end

function modifier_enigma_black_hole_lua_debuff:OnRemoved()
end

function modifier_enigma_black_hole_lua_debuff:OnDestroy()
	if IsServer() then
		-- motion compulsory interrupts
		self:GetParent():InterruptMotionControllers( true )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_enigma_black_hole_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}

	return funcs
end

function modifier_enigma_black_hole_lua_debuff:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_enigma_black_hole_lua_debuff:GetOverrideAnimationRate()
	return self.rate
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_enigma_black_hole_lua_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_enigma_black_hole_lua_debuff:UpdateHorizontalMotion( me, dt )
	-- get vector
	local target = self:GetParent():GetOrigin()-self.center
	target.z = 0

	-- reduce length by pull speed
	local targetL = target:Length2D()-self.pull_speed*dt


	-- rotate by rotate speed
	local targetN = target:Normalized()
	local deg = math.atan2( targetN.y, targetN.x )
	local targetN = Vector( math.cos(deg+self.rotate_speed*dt), math.sin(deg+self.rotate_speed*dt), 0 );

	self:GetParent():SetOrigin( self.center + targetN * targetL )


end

function modifier_enigma_black_hole_lua_debuff:OnHorizontalMotionInterrupted()
	self:Destroy()
end