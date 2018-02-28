modifier_phantom_assassin_stifling_dagger_lua_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_assassin_stifling_dagger_lua_attack:IsHidden()
	return true
end
function modifier_phantom_assassin_stifling_dagger_lua_attack:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_stifling_dagger_lua_attack:OnCreated( kv )
	-- references
	self.base_damage = self:GetAbility():GetSpecialValueFor( "base_damage" )	
	self.attack_factor = self:GetAbility():GetSpecialValueFor( "attack_factor" )

	-- Attack
	PerformAttack(
		 -- handle hTarget,
		 -- bool bUseCastAttackOrb,
		 -- bool bProcessProcs,
		-- bool bSkipCooldown,
		-- bool bIgnoreInvis,
		-- bool bUseProjectile,
		-- bool bFakeAttack,
		-- bool bNeverMiss
	)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_stifling_dagger_lua_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_phantom_assassin_stifling_dagger_lua_attack:GetModifierMoveSpeedBonus_Percentage()
	self.move_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_phantom_assassin_stifling_dagger_lua_attack:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_phantom_assassin_stifling_dagger_lua_attack:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end
