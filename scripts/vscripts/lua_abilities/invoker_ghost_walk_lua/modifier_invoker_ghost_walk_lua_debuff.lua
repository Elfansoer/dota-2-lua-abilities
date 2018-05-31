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
-- function modifier_invoker_ghost_walk_lua_debuff:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_invoker_ghost_walk_lua_debuff:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_invoker_ghost_walk_lua_debuff:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
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
-- 		nFXIndex,
-- 		bDestroyImmediately,
-- 		bStatusEffect,
-- 		iPriority,
-- 		bHeroEffect,
-- 		bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end