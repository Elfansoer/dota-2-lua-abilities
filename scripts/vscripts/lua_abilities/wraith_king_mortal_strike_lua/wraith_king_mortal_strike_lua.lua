wraith_king_mortal_strike_lua = class({})
LinkLuaModifier( "modifier_wraith_king_mortal_strike_lua", "lua_abilities/wraith_king_mortal_strike_lua/modifier_wraith_king_mortal_strike_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_summon_timer", "lua_abilities/generic/modifier_generic_summon_timer", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function wraith_king_mortal_strike_lua:GetIntrinsicModifierName()
	return "modifier_wraith_king_mortal_strike_lua"
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function wraith_king_mortal_strike_lua:OnAbilityPhaseStart()
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function wraith_king_mortal_strike_lua:OnSpellStart()
	-- unit identifier
	caster = self:GetCaster()
	target = self:GetCursorTarget()
	point = self:GetCursorPosition()

	-- get resources
	local delay = self:GetSpecialValueFor("spawn_interval")
	local unit_duration = self:GetSpecialValueFor("skeleton_duration")
	local unit_name = "npc_dota_wraith_king_skeleton_warrior"

	-- get modifier
	local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_wraith_king_mortal_strike_lua", self:GetCaster() )
	local charges = modifier:GetStackCount()

	-- spawn skeletons
	for i=1,charges do
		local summoned_unit = CreateUnitByName(
			unit_name, -- szUnitName
			self:GetCaster():GetOrigin(), -- vLocation,
			true, -- bFindClearSpace,
			self:GetCaster(), -- hNPCOwner,
			self:GetCaster():GetOwner(), -- hUnitOwner,
			self:GetCaster():GetTeamNumber() -- iTeamNumber
		)

		-- dominate units
		summoned_unit:SetControllableByPlayer( self:GetCaster():GetPlayerID(), false ) -- (playerID, bSkipAdjustingPosition)
		summoned_unit:SetOwner( self:GetCaster() )
		summoned_unit:AddNewModifier(self:GetCaster(), self, "modifier_generic_summon_timer", {duration = unit_duration})

		-- delay
		
	end

	modifier:SetStackCount( 0 )
end