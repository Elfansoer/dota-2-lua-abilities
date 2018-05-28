shaco_hallucinate = class({})
LinkLuaModifier( "modifier_shaco_hallucinate", "custom_abilities/shaco_hallucinate/modifier_shaco_hallucinate", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function shaco_hallucinate:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- create unit
	local illusion = CreateUnitByName(
		caster:GetUnitName(), -- szUnitName
		caster:GetOrigin(), -- vLocation,
		false, -- bFindClearSpace,
		caster, -- hNPCOwner,
		caster:GetOwner(), -- hUnitOwner,
		caster:GetTeamNumber() -- iTeamNumber
	)
	-- illusion:MakeIllusion()
	illusion:SetControllableByPlayer( caster:GetPlayerID(), false ) -- (playerID, bSkipAdjustingPosition)
	illusion:SetAbilityPoints( 0 )
	illusion:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_shaco_hallucinate", -- modifier name
		{ duration = duration } -- kv
	)
	-- illusion:SetPlayerID( caster:GetPlayerID() )

	local ability = illusion:GetAbilityByIndex(0)
	if ability then ability:SetLevel(1) end

	-- print all modifiers
	print("modifiers")
	local modifiers = illusion:FindAllModifiers()
	for k,v in pairs(modifiers) do
		print(k,v,v:GetName())
	end
end