--[[
Test Results:
- Arcana models has no wearables by default
- Only "npc_dota_creature" baseClass can have custom wearables
- Particle effect of PA Arcana model loads automatically
- Particle effect of PA custom wearables must be loaded manually (through modifier)
- Death particle effect of PA Arcana model must be loaded manually (through modifier)
- Arcana animation activity must be translated with "arcana" tag (through modifier)
]]
--------------------------------------------------------------------------------
test_cosmetics = class({})
LinkLuaModifier( "modifier_test_cosmetics", "test_abilities/test_cosmetics/modifier_test_cosmetics", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function test_cosmetics:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	self:CreateUnit( "npc_dota_pa_arcana_1", 2, caster:GetOrigin() + 100*caster:GetForwardVector() )
	self:CreateUnit( "npc_dota_pa_arcana_2", 0, caster:GetOrigin() - 100*caster:GetForwardVector() )
	self:CreateUnit( "npc_dota_pa_arcana_3", 1, caster:GetOrigin() - 100*caster:GetRightVector() )
end

function test_cosmetics:CreateUnit( name, style, location )
	local cosmetics = CreateUnitByName( name, location , true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber() )
	cosmetics:SetControllableByPlayer( self:GetCaster():GetPlayerID(), false )
	cosmetics:SetOwner( self:GetCaster() )
	cosmetics:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_test_cosmetics", -- modifier name
		{
			duration = duration,
			style = style,
		} -- kv
	)
end
