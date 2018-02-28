modifier_phantom_assassin_coup_de_grace_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_assassin_coup_de_grace_lua:IsHidden()
	-- actual true
	return false
end

function modifier_phantom_assassin_coup_de_grace_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_coup_de_grace_lua:OnCreated( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_bonus = self:GetAbility():GetSpecialValueFor( "crit_bonus" )
end

function modifier_phantom_assassin_coup_de_grace_lua:OnRefresh( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_bonus = self:GetAbility():GetSpecialValueFor( "crit_bonus" )
end

function modifier_phantom_assassin_coup_de_grace_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_coup_de_grace_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}

	return funcs
end

function modifier_phantom_assassin_coup_de_grace_lua:GetModifierPreAttack_CriticalStrike()
	if IsServer() then
		if self:RollChance( self.crit_chance ) then
			return self.crit_bonus
		end
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_phantom_assassin_coup_de_grace_lua:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_phantom_assassin_coup_de_grace_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_phantom_assassin_coup_de_grace_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end
