invoker_quas_lua = class({})
LinkLuaModifier( "modifier_invoker_quas_lua", "lua_abilities/invoker_quas_lua/modifier_invoker_quas_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function invoker_quas_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- add modifier
	local modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_invoker_quas_lua", -- modifier name
		{  } -- kv
	)

	-- register to invoke ability
	self.invoke:AddOrb( modifier )
end

--------------------------------------------------------------------------------
-- Ability Events
function invoker_quas_lua:OnUpgrade()
	if not self.invoke then
		-- if first time, upgrade and init Invoke
		local invoke = self:GetCaster():FindAbilityByName( "invoker_invoke_lua" )
		if invoke:GetLevel()<1 then invoke:UpgradeAbility(true) end
		self.invoke = invoke
	else
		-- update status
		self.invoke:UpdateOrb("modifier_invoker_quas_lua")
	end
end