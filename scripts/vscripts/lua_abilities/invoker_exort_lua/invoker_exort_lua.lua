invoker_exort_lua = class({})
LinkLuaModifier( "modifier_invoker_exort_lua", "lua_abilities/invoker_exort_lua/modifier_invoker_exort_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function invoker_exort_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- add modifier
	local modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_invoker_exort_lua", -- modifier name
		{  } -- kv
	)

	-- register to invoke ability
	self.invoke:AddOrb( modifier )
end

--------------------------------------------------------------------------------
-- Ability Events
function invoker_exort_lua:OnUpgrade()
	if not self.invoke then
		-- if first time, upgrade and init Invoke
		local invoke = self:GetCaster():FindAbilityByName( "invoker_invoke_lua" )
		if invoke:GetLevel()<1 then invoke:UpgradeAbility(true) end
		self.invoke = invoke
	end

	-- update modifiers
	local modifiers = self:GetCaster():FindAllModifiersByName( "modifier_invoker_exort_lua" )
	for _,modifier in pairs(modifiers) do
		if modifier:GetCaster()==self:GetCaster() then
			modifier:ForceRefresh()
		end
	end
end