modifier_invoker_ghost_walk_lua_debuff = class({})
local intPack = require( "util/intPack" )
--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_ghost_walk_lua_debuff:IsHidden()
	return false
end

function modifier_invoker_ghost_walk_lua_debuff:IsDebuff()
	return true
end

function modifier_invoker_ghost_walk_lua_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_ghost_walk_lua_debuff:OnCreated( kv )
	if IsServer() then
		-- references
		self.enemy_slow = self:GetAbility():GetOrbSpecialValueFor( "enemy_slow", "q" )

		-- send to client
		local sign = 0
		if self.enemy_slow<0 then sign = 2 end
		local tbl = {
			sign,
			math.abs(self.enemy_slow),
		}
		self:SetStackCount( intPack.Pack( tbl, 60 ) )
	else
		-- receive from server
		local tbl = intPack.Unpack( self:GetStackCount(), 2, 60 )
		self.enemy_slow = (1-tbl[1])*tbl[2]
		self:SetStackCount( 0 )
	end
end

function modifier_invoker_ghost_walk_lua_debuff:OnRefresh( kv )
	if IsServer() then
		-- references
		self.enemy_slow = self:GetAbility():GetOrbSpecialValueFor( "enemy_slow", "q" )

		-- send to client
		local sign = 0
		if self.enemy_slow<0 then sign = 2 end
		local tbl = {
			sign,
			math.abs(self.enemy_slow),
		}
		self:SetStackCount( intPack.Pack( tbl, 60 ) )
	else
		-- receive from server
		local tbl = intPack.Unpack( self:GetStackCount(), 2, 60 )
		self.enemy_slow = (1-tbl[1])*tbl[2]
		self:SetStackCount( 0 )
	end
end

function modifier_invoker_ghost_walk_lua_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_ghost_walk_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_invoker_ghost_walk_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.enemy_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_invoker_ghost_walk_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_ghost_walk_debuff.vpcf"
end

function modifier_invoker_ghost_walk_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end