modifier_lich_frost_armor_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lich_frost_armor_lua:IsHidden()
	return true
end

function modifier_lich_frost_armor_lua:IsDebuff()
	return false
end

function modifier_lich_frost_armor_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lich_frost_armor_lua:OnCreated( kv )

end

function modifier_lich_frost_armor_lua:OnRefresh( kv )
	
end

function modifier_lich_frost_armor_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lich_frost_armor_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACKED,
	}

	return funcs
end

function modifier_lich_frost_armor_lua:OnAttacked( params )
	if IsServer() then
		-- dont autocast if...
		if not self:GetAbility():GetAutoCastState() then return end
		if self:GetParent():IsChanneling() then return end
		
		-- filter
		local filter = UnitFilter(
			params.unit,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
			self:GetParent():GetTeamNumber()
		)
		if filter ~= UF_SUCCESS then return	end

		-- check if castable
		if not self:GetAbility():IsFullyCastable() then return end

		-- cast ability
		-- self:GetParent():SetCursorCastTarget( params.unit )
		self:GetParent():CastAbilityOnTarget( params.unit, self:GetAbility(), self:GetParent():GetPlayerOwnerID() )
	end
end