modifier_test = class({})
local intPack = require("util/intPack")
print("intpack: ",intPack)
--------------------------------------------------------------------------------
-- Classifications
function modifier_test:IsHidden()
	return false
end

function modifier_test:IsDebuff()
	return false
end

function modifier_test:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_test:OnCreated( kv )
end
function modifier_test:OnRefresh( kv )
end
function modifier_test:OnDestroy( kv )

end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_test:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FINISHED,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
	}

	return funcs
end

function modifier_test:OnAttackStart( params )
	self:Print( "OnAttackStart", params )
end
function modifier_test:OnAttack( params )
	self:Print( "OnAttack", params )
end
function modifier_test:OnAttackFinished( params )
	self:Print( "OnAttackFinished", params )
end
function modifier_test:OnAttackFail( params )
	self:Print( "OnAttackFail", params )
end
function modifier_test:OnAttackLanded( params )
	self:Print( "OnAttackLanded", params )
end

function modifier_test:Print( text, params )
	if IsServer() then
		print(text)
		for k,v in pairs(params) do
			print("",k,v)
		end
	end
end