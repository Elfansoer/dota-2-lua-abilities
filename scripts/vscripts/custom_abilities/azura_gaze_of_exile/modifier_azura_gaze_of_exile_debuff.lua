modifier_azura_gaze_of_exile_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_azura_gaze_of_exile_debuff:IsHidden()
	-- final: true
	return false
end

function modifier_azura_gaze_of_exile_debuff:IsDebuff()
	return true
end

function modifier_azura_gaze_of_exile_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_azura_gaze_of_exile_debuff:OnCreated( kv )

end

function modifier_azura_gaze_of_exile_debuff:OnRefresh( kv )

end

function modifier_azura_gaze_of_exile_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_azura_gaze_of_exile_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_EVENT_ON_ABILITY_START,
	}

	return funcs
end

function modifier_azura_gaze_of_exile_debuff:OnOrder( params )
	if IsServer() then
		-- filter
		local unit = params.unit
		local target = params.target
		local pass = true
		if target~=nil then
			if not target:HasModifier("modifier_azura_gaze_of_exile") then
				pass = false
			end
		end

		-- logic
		if pass then
			self:Destroy()
		end
	end
end

function modifier_azura_gaze_of_exile_debuff:OnAbilityStart( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetParent() then
			pass = true
		end

		-- logic
		if pass then
			self:GetParent():Stop()
			self:Destroy()
		end
	end
end

