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
	print("Modifier created:",IsServer(),"----------------------")
	print("intpack: ",intPack,IsServer())
	for k,v in pairs(kv) do
		print(k,v)
	end
	if IsServer() then
		print("Server start")
		self.bonus1, self.bonus2 = self:GetAbility():GetValue()
		print("Server pre-stack",self:GetStackCount())

		local pack = { self.bonus1, self.bonus2 }
		self:SetStackCount( intPack.Pack( pack, 120 ) )
		print("Server post-stack",self:GetStackCount())
	else
		print("Client start")
		print("Client pre-stack",self:GetStackCount())
		print("Client post-stack",self:GetStackCount())
	end
	print("Second Part:",IsServer(),"----------------------")
	if IsServer() then
		print("Server pre-stack",self:GetStackCount())
		print("Server post-stack",self:GetStackCount())
	else
		print("Client pre-stack",self:GetStackCount())
		local unPack = intPack.Unpack( self:GetStackCount(), 2, 120 )
		self.bonus1 = unPack[1]
		self.bonus2 = unPack[2]
		self:SetStackCount(0)
		print("Client post-stack",self:GetStackCount())
	end
	print("Modifier end:",IsServer(),"----------------------")
	print("Bonus 1, 2:",IsServer(),self.bonus1, self.bonus2)
end
function modifier_test:OnRefresh( kv )
	print("Modifier created:",IsServer(),"----------------------")
	for k,v in pairs(kv) do
		print(k,v)
	end
	if IsServer() then
		print("Server start")
		self.bonus1, self.bonus2 = self:GetAbility():GetValue()
		print("Server pre-stack",self:GetStackCount())

		local pack = { self.bonus1, self.bonus2 }
		self:SetStackCount( intPack.Pack( pack, 120 ) )
		print("Server post-stack",self:GetStackCount())
	else
		print("Client start")
		print("Client pre-stack",self:GetStackCount())
		print("Client post-stack",self:GetStackCount())
	end
	print("Second Part:",IsServer(),"----------------------")
	if IsServer() then
		print("Server pre-stack",self:GetStackCount())
		print("Server post-stack",self:GetStackCount())
	else
		print("Client pre-stack",self:GetStackCount())
		local unPack = intPack.Unpack( self:GetStackCount(), 2, 120 )
		self.bonus1 = unPack[1]
		self.bonus2 = unPack[2]
		self:SetStackCount(0)
		print("Client post-stack",self:GetStackCount())
	end
	print("Modifier end:",IsServer(),"----------------------")
	print("Bonus 1, 2:",IsServer(),self.bonus1, self.bonus2)
end
function modifier_test:OnDestroy( kv )

end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_test:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

function modifier_test:GetModifierPreAttack_BonusDamage()
	return self.bonus
end