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
end

function modifier_azura_gaze_of_exile:OnRefresh( kv )
end

function modifier_azura_gaze_of_exile:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_azura_gaze_of_exile:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_EVENT_ON_DEATH,
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
				if not unit:HasModifier("modifier_azura_gaze_of_exile_debuff") then
					unit:AddNewModifier(
						self:GetCaster(),
						self:GetAbility(),
						"modifier_azura_gaze_of_exile_debuff",
						{}
					)
				end
			else
				if not unit:HasModifier("modifier_azura_gaze_of_exile_buff") then
					unit:AddNewModifier(
						self:GetCaster(),
						self:GetAbility(),
						"modifier_azura_gaze_of_exile_buff",
						{}
					)
				end
			end
		end
	end
end

function modifier_azura_gaze_of_exile:OnDeath( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetParent() then
			pass = true
		end

		-- logic
		if pass then
			-- get caster
			local caster = self:GetCaster()

			-- refresh all basic abilities
			local total = caster:GetAbilityCount()
			for i=0,total-1 do
				local ability = caster:GetAbilityByIndex( i )
				if ability~=nil then
					if ability:GetAbilityKeyValues().AbilityType=="DOTA_ABILITY_TYPE_BASIC" then
						ability:EndCooldown()
					end
				end
			end

			-- replenish bolt charges
			local modifier = caster:FindModifierByNameAndCaster( "modifier_azura_multishot_crossbow", caster )
			if modifier~=nil then
				modifier:AddStack( modifier:GetAbility():GetSpecialValueFor("max_charge") )
			end
		end
	end
end

function modifier_azura_gaze_of_exile:CheckState()
	local state = {
	[MODIFIER_STATE_NO_TEAM_SELECT] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_azura_gaze_of_exile:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_azura_gaze_of_exile:GetEffectAttachType()
-- 	return PATTACH_XX
-- end