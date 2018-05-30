modifier_invoker_alacrity_lua = class({})
local intPack = require("util/intPack")
--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_alacrity_lua:IsHidden()
	return false
end

function modifier_invoker_alacrity_lua:IsDebuff()
	return false
end

function modifier_invoker_alacrity_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_alacrity_lua:OnCreated( kv )
	if IsServer() then
		self.damage = self:GetAbility():GetOrbSpecialValueFor( "bonus_damage", "e" )
		self.as_bonus = self:GetAbility():GetOrbSpecialValueFor( "bonus_attack_speed", "w" )

		local pack = { self.damage, self.as_bonus }
		self:SetStackCount( intPack.Pack( pack, 120 ) )
	else
		local unPack = intPack.Unpack( self:GetStackCount(), 2, 120 )
		self.damage = unPack[1]
		self.as_bonus = unPack[2]
		self:SetStackCount(0)
	end
end

function modifier_invoker_alacrity_lua:OnRefresh( kv )
	if IsServer() then
		self.damage = self:GetAbility():GetOrbSpecialValueFor( "bonus_damage", "e" )
		self.as_bonus = self:GetAbility():GetOrbSpecialValueFor( "bonus_attack_speed", "w" )

		local pack = { self.damage, self.as_bonus }
		self:SetStackCount( intPack.Pack( pack, 120 ) )
	else
		local unPack = intPack.Unpack( self:GetStackCount(), 2, 120 )
		self.damage = unPack[1]
		self.as_bonus = unPack[2]
		self:SetStackCount(0)
	end
end

function modifier_invoker_alacrity_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_alacrity_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end
function modifier_invoker_alacrity_lua:GetModifierPreAttack_BonusDamage()
	return self.damage
end
function modifier_invoker_alacrity_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_invoker_alacrity_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_invoker_alacrity_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_invoker_alacrity_lua:PlayEffects()
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