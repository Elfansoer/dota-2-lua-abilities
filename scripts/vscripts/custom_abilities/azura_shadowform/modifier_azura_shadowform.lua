modifier_azura_shadowform = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_azura_shadowform:IsHidden()
	return false
end

function modifier_azura_shadowform:IsDebuff()
	return self:GetParent():GetTeamNumber()~=self:GetCaster():GetTeamNumber()
end

function modifier_azura_shadowform:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_azura_shadowform:OnCreated( kv )
	-- get references
	self.collision_radius = self:GetAbility():GetSpecialValueFor("collision_radius")
	self.interval = 0.3
	self.haste_speed = 550
	self.isCaster = false
	self.isAlly = false

	if IsServer() then
		-- determine parent's friend or foe
		if self:GetParent()==self:GetCaster() then
			self.resist = self:GetAbility():GetSpecialValueFor( "resist_ally_pct" )
			self.isCaster = true
		elseif self:GetParent():GetTeamNumber()==self:GetCaster():GetTeamNumber() then
			self.resist = self:GetAbility():GetSpecialValueFor( "resist_ally_pct" )
			self.isAlly = true
		else
			self.resist = self:GetAbility():GetSpecialValueFor( "resist_enemy_pct" )
		end

		-- add into affected units table
		if not self.isCaster then
			self:GetAbility():AddAffectedUnits( self:GetParent() )
		end

		-- Start interval to apply collision effect for caster
		if self.isCaster then
			self.parent = self:GetParent()
			self:StartIntervalThink( self.interval )
			self:OnIntervalThink()
		end
	end
end

function modifier_azura_shadowform:OnRefresh( kv )
	-- get references
	self.isCaster = false
	self.isAlly = false

		-- determine parent's friend or foe
	if IsServer() then
		if self:GetParent()==self:GetCaster() then
			self.resist = self:GetAbility():GetSpecialValueFor( "resist_ally_pct" )
			self.isCaster = true
		elseif self:GetParent():GetTeamNumber()==self:GetCaster():GetTeamNumber() then
			self.resist = self:GetAbility():GetSpecialValueFor( "resist_ally_pct" )
			self.isAlly = true
		else
			self.resist = self:GetAbility():GetSpecialValueFor( "resist_enemy_pct" )
		end

		-- add into affected units table
		if not self.isCaster then
			self:GetAbility():AddAffectedUnits( self:GetParent() )
		end

		-- Start interval to apply collision effect for caster
		if isCaster then
			self.parent = self:GetParent()
			self:StartIntervalThink( self.interval )
			self:OnIntervalThink()
		end
	end
end

function modifier_azura_shadowform:OnDestroy( kv )
	if IsServer() then
		if self.isCaster then
			self:GetAbility():CancelAbility()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_azura_shadowform:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DECREPIFY_UNIQUE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}

	return funcs
end

function modifier_azura_shadowform:GetModifierMagicalResistanceDecrepifyUnique()
	return self.resist
end

function modifier_azura_shadowform:GetModifierMoveSpeed_AbsoluteMin()
	if self.isCaster then return self.haste_speed end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_azura_shadowform:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = self.isCaster,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_azura_shadowform:OnIntervalThink()
	if IsServer() then
		-- find affected units around collision radius
		local units = FindUnitsInRadius(
			self.parent:GetTeamNumber(),	-- int, your team number
			self.parent:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.collision_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		for _,unit in pairs(units) do
			if unit~=self:GetCaster() then
				unit:AddNewModifier(
					self:GetCaster(),
					self:GetAbility(),
					"modifier_azura_shadowform",
					{}
				)
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_azura_shadowform:GetStatusEffectName()
	return "particles/status_fx/status_effect_vengeful_venge_image.vpcf"
end