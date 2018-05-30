test_lua = class({})
LinkLuaModifier( "modifier_test", "lua_abilities/_test/modifier_test", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function test_lua:OnSpellStart()
	local caster = self:GetCaster()

	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_test", -- modifier name
		{ 
			duration = 10,
		} -- kv
	)
end

if IsServer() then
	function test_lua:GetValue()
		return 115, 93
	end
end