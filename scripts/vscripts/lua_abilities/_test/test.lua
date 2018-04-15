test_lua = class({})
LinkLuaModifier( "modifier_test", "lua_abilities/_test/modifier_test", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function test_lua:GetIntrinsicModifierName()
	return "modifier_test"
end

function test_lua:CastFilterResultTarget( hTarget )
	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	if IsServer() then
		print("CAST_FILTER")
	end
	return UF_SUCCESS
end

function test_lua:OnAbilityPhaseInterrupted(  )
	print("INTERRUPTED")
end

function test_lua:OnAbilityPhaseStart()
	print("PHASE START")
end
function test_lua:OnSpellStart()
	print("SPELL START")
	-- self:GetCaster():AddNewModifier(
	-- 	self:GetCaster(), -- player source
	-- 	self, -- ability source
	-- 	"modifier_test", -- modifier name
	-- 	{ duration = 10 } -- kv
	-- )
end