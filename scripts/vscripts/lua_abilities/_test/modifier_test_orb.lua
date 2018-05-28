modifier_test = class({})

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
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_test:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACKED,
		MODIFIER_EVENT_ON_ATTACK_ALLIED,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PRE_ATTACK,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,

		MODIFIER_EVENT_ON_ORDER,
	}

	return funcs
end

function modifier_test:GetModifierPreAttack( params )
	print("PreAttack",params.record,params.attacker,params.unit,params.target)
end
function modifier_test:GetModifierProcAttack_Feedback( params )
	print("ProcAttack",params.record,params.attacker,params.unit,params.target)
end

function modifier_test:OnAttack( params )
	print("OnAttack",params.record,params.attacker:GetUnitName(),params.unit,params.target)
end
function modifier_test:OnAttacked( params )
	print("OnAttacked",params.record,params.attacker:GetUnitName(),params.unit,params.target)
end
function modifier_test:OnAttackFail( params )
	print("OnFail",params.record,params.attacker:GetUnitName(),params.unit,params.target)
end
function modifier_test:OnAttackLanded( params )
	print("OnLanded",params.record,params.attacker:GetUnitName(),params.unit,params.target)
end
function modifier_test:OnAttackRecord( params )
	print("OnRecord",params.record,params.attacker:GetUnitName(),params.unit,params.target)
end
function modifier_test:OnAttackRecordDestroy( params )
	print("OnDestroy",params.record,params.attacker:GetUnitName(),params.unit,params.target)
end

function modifier_test:OnOrder( params )
	print("OnOrder")
	for k,v in pairs(params) do
		print("",k,v)
	end
end
--------------------------------------------------------------------------------
-- Unused
function modifier_test:printImportant( params )
	if IsServer() then
	if params.attacker:GetUnitName() ~= nil then print("","attacker",params.attacker:GetUnitName(),"health",params.attacker:GetUnitName():GetHealth()) end
	if params.unit ~= nil then print("","unit\t",params.unit,"health",params.unit:GetHealth()) end
	if params.target ~= nil then print("","target\t",params.target,"health",params.target:GetHealth()) end
	if params.damage ~= nil then print("","damage\t",params.damage) end
	if params.original_damage ~= nil then print("","original_damage",params.original_damage) end
	if params.damage_type ~= nil then print("","damage_type",params.damage_type) end
		print("","health",self:GetParent():GetHealth())
	end
end
