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
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_stifling_dagger_lua_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,

	}

	return funcs
end

function modifier_phantom_assassin_stifling_dagger_lua_attack:GetModifierDamageOutgoing_Percentage( params )
	if IsServer() then
		return self.attack_factor
	end
end
function modifier_phantom_assassin_stifling_dagger_lua_attack:GetModifierPreAttack_BonusDamage( params )
	if IsServer() then
		-- base damage will get reduced, so multiply it by its inverse
		return self.base_damage * 100/(100+self.attack_factor)
	end
end
--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_phantom_assassin_stifling_dagger_lua_attack:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_phantom_assassin_stifling_dagger_lua_attack:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end
