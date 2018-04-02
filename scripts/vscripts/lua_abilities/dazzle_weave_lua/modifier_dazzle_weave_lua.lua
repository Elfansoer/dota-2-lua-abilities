modifier_dazzle_weave_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dazzle_weave_lua:IsHidden()
	return false
end

function modifier_dazzle_weave_lua:IsDebuff()
	return not self.buff
end

function modifier_dazzle_weave_lua:IsStunDebuff()
	return false
end

function modifier_dazzle_weave_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_dazzle_weave_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dazzle_weave_lua:OnCreated( kv )
	-- references
	self.armor_per_second = self:GetAbility():GetSpecialValueFor( "armor_per_second" ) -- special value

	-- generate data
	self.buff = self:GetParent():GetTeamNumber()==self:GetCaster():GetTeamNumber()
	self.tick = 1
	self.count = 0

	if not self.buff then
		self.armor_per_second = -self.armor_per_second
	end
	
	self:StartIntervalThink( self.tick )
end

function modifier_dazzle_weave_lua:OnRefresh( kv )
	
end

function modifier_dazzle_weave_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dazzle_weave_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_dazzle_weave_lua:GetModifierPhysicalArmorBonus()
	return self.count * self.armor_per_second
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dazzle_weave_lua:OnIntervalThink()
	self.count = self.count + 1
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dazzle_weave_lua:GetEffectName()
	if self.buff then
		return "particles/units/heroes/hero_dazzle/dazzle_armor_friend.vpcf"
	else
		return "particles/units/heroes/hero_dazzle/dazzle_armor_enemy.vpcf"
	end
end

function modifier_dazzle_weave_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end