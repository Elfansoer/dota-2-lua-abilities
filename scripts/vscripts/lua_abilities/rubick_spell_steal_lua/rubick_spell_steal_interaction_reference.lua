stolenInteraction = {}
function stolenInteraction:Init( baseAbility, callerAbility )
	self.base = baseAbility
	self.caller = callerAbility
end
function stolenInteraction:OnStolen( source )
	-- Abstract
end
function stolenInteraction:OnApplied()
	-- Abstract
end
function stolenInteraction:OnUnstolen()
	-- Abstract
end
function stolenInteraction.createSub()
	local target = {}
	for k,v in pairs(stolenInteraction) do
		target[k] = v
	end
	return target
end

-- Subclass: Requiem
requiem = stolenInteraction.createSub()
function requiem:OnStolen( source )
	-- get data
	local target = source:GetCaster()
	local modifier = target:FindModifierByNameAndCaster( "modifier_shadow_fiend_necromastery_lua", target )

	self.stack = 0
	if modifier then
		self.stack = modifier:GetStackCount()
	end
end
function requiem:OnApplied()
	-- get data
	local caster = self.base:GetCaster()

	-- Apply modifier
	local invoker = self.caller or self.base
	self.modifier = caster:AddNewModifier(
		caster,
		invoker,
		"modifier_shadow_fiend_necromastery_lua",
		{}
	)

	-- Modify modifier
end
function requiem:OnUnstolen()
	-- remove modifier
	if self.modifier then
		self.modifier:Destroy()
		self.modifier = nil
	end
end

-- Subclass: dummy
dummy = stolenInteraction.createSub()
function dummy:OnStolen( source )
	print("OnStolen",self.base:GetAbilityName())
end
function dummy:OnApplied()
	print("OnApplied",self.base:GetAbilityName())
end
function dummy:OnStolen()
	print("OnUnstolen",self.base:GetAbilityName())
end

result = {}
result.interactionList = {
	["default"] = stolenInteraction,
	-- ["shadow_fiend_requiem_of_souls_lua"] = requiem,
	["shadow_fiend_requiem_of_souls_lua"] = dummy,
	["shadow_fiend_shadowraze_a_lua"] = dummy,
}
 
function result.Init( baseAbility, callerAbility )
	local name = baseAbility:GetAbilityName()
	local target = result.interactionList[name]
	if target then
		target:Init( baseAbility, callerAbility )
	else
		target = result.interactionList["default"]
	end
	return target
end

return result