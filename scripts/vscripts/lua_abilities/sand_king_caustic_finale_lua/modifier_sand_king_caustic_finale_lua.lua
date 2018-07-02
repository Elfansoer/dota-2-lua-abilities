modifier_sand_king_caustic_finale_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sand_king_caustic_finale_lua:IsHidden()
	return true
end

function modifier_sand_king_caustic_finale_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sand_king_caustic_finale_lua:OnCreated( kv )
	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "caustic_finale_duration" ) -- special value
end

function modifier_sand_king_caustic_finale_lua:OnRefresh( kv )
	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "caustic_finale_duration" ) -- special value	
end

function modifier_sand_king_caustic_finale_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sand_king_caustic_finale_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_sand_king_caustic_finale_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		-- check break
		if self:GetParent():PassivesDisabled() then return end

		-- check allies
		if params.target:GetTeamNumber()==self:GetParent():GetTeamNumber() then return end

		-- check spell immunity
		if params.target:IsMagicImmune() then return end

		-- add debuff if not present
		local modifier = params.target:FindModifierByNameAndCaster( "modifier_sand_king_caustic_finale_lua_debuff", self:GetParent() )
		if not modifier then
			params.target:AddNewModifier(
				self:GetParent(), -- player source
				self:GetAbility(), -- ability source
				"modifier_sand_king_caustic_finale_lua_debuff", -- modifier name
				{ duration = self.duration } -- kv
			)
		end
	end
end