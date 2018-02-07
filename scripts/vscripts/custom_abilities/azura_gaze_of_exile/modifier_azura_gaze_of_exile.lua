modifier_azura_gaze_of_exile = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_azura_gaze_of_exile:IsHidden()
	return false
end

function modifier_azura_gaze_of_exile:IsDebuff()
	return true
end

function modifier_azura_gaze_of_exile:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_azura_gaze_of_exile:OnCreated( kv )
	-- references
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "bonus_range" )
	-- self:GetParent():NoTeamSelect()
end

function modifier_azura_gaze_of_exile:OnRefresh( kv )
	-- references
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "bonus_range" )
end

function modifier_azura_gaze_of_exile:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_azura_gaze_of_exile:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,
	}

	return funcs
end

function modifier_azura_gaze_of_exile:OnOrder( params )
	if IsServer() then
		-- filter
		local unit = params.unit
		local target = params.target
		local pass = false
		if target~=nil then
			if target==self:GetParent() then
				pass = true
			end
		end

		-- logic
		if pass then
			-- if enemies
			if unit:GetTeamNumber()==self:GetParent():GetTeamNumber() then
				print("stop!")
				unit:Stop()
				unit:Interrupt()
				unit:SetOrigin(Vector(0,0,0))
			end
		end
	end
end
		-- -- check order
		-- local order = params.order_type
		-- if (order==DOTA_UNIT_ORDER_ATTACK_TARGET) or
		-- 	(order==DOTA_UNIT_ORDER_CAST_TARGET) or 
		-- 	(order==DOTA_UNIT_ORDER_ATTACK_MOVE)
		-- then
		-- end
--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_azura_gaze_of_exile:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_azura_gaze_of_exile:GetEffectAttachType()
-- 	return PATTACH_XX
-- end