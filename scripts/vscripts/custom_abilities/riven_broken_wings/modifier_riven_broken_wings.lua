modifier_riven_broken_wings = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_riven_broken_wings:IsHidden()
	return false
end

function modifier_riven_broken_wings:IsDebuff()
	return false
end

function modifier_riven_broken_wings:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_riven_broken_wings:OnCreated( kv )
	if IsServer() then
		self:SetStackCount(kv.number)
	end
end

function modifier_riven_broken_wings:OnRefresh( kv )
	if IsServer() then
		self:DecrementStackCount()
	end
end

function modifier_riven_broken_wings:OnDestroy()
	if IsServer() then
		self:GetAbility():UseResources(false,false,true)
	end
end