-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
test_blockcamp = class({})
LinkLuaModifier( "modifier_test_blockcamp", "test_abilities/test_blockcamp/modifier_test_blockcamp", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function test_blockcamp:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local radius = 550

	-- init data
	local teamnumber = caster:GetTeamNumber()
	local origin = point
	local angle = 0
	local vector = Vector(radius,0,0)
	local zero = Vector(0,0,0)
	local one = Vector(1,0,0)
	local count = 14

	local angle_diff = 360/count

	for i=0,count-1 do
		local relative_location = RotatePosition( zero, QAngle( 0, angle_diff*i, 0 ), vector )
		local location = origin + relative_location

		local facing_direction = RotatePosition( zero, QAngle( 0, 200+angle_diff*i, 0 ), one )

		-- create unit
		local unit = CreateUnitByName(
			"npc_dota_phantomassassin_gravestone",
			location,
			false,
			caster,
			caster:GetOwner(),
			caster:GetTeamNumber()
		)
		unit:SetForwardVector( facing_direction )
		unit:SetNeverMoveToClearSpace( true )

		-- logic
		unit:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_test_blockcamp", -- modifier name
			{ duration = 10 } -- kv
		)
	end
end