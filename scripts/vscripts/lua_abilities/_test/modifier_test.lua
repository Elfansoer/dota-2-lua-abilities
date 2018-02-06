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

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_test:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_MODIFIER_ADDED,
		MODIFIER_EVENT_ON_STATE_CHANGED,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,	
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE,
	}

	return funcs
end


--------------------------------------------------------------------------------
-- Event functions (follows order, but not necessarily happens directly after another)
function modifier_test:OnModifierAdded( params )
	print("MODIFIER_EVENT_ON_MODIFIER_ADDED")
	if IsServer() then
		for k,v in pairs(params) do
			print(k,v)
		end
	end
end

function modifier_test:OnStateChanged( params )
	if IsServer() then
		if params.unit == self:GetParent() then
			print("MODIFIER_EVENT_ON_STATE_CHANGED")
			for k,v in pairs(params) do
				print(k,v)
			end
		end
	end
end

function modifier_test:GetModifierSpellAmplify_Percentage(params)
	print("MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE")
	if IsServer() then
		for k,v in pairs(params) do
			print(k,v)
		end
	end
end
function modifier_test:GetModifierHealAmplify_Percentage(params)
	print("MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE")
	if IsServer() then
		for k,v in pairs(params) do
			print(k,v)
		end
	end
end

--------------------------------------------------------------------------------
-- Unused

function modifier_test:printImportant( params )
	if IsServer() then
	if params.attacker ~= nil then print("","attacker",params.attacker,"health",params.attacker:GetHealth()) end
	if params.unit ~= nil then print("","unit\t",params.unit,"health",params.unit:GetHealth()) end
	if params.target ~= nil then print("","target\t",params.target,"health",params.target:GetHealth()) end
	if params.damage ~= nil then print("","damage\t",params.damage) end
	if params.original_damage ~= nil then print("","original_damage",params.original_damage) end
	if params.damage_type ~= nil then print("","damage_type",params.damage_type) end
		print("","health",self:GetParent():GetHealth())
	end
end
