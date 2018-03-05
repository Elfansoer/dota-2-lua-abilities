modifier_bristleback_bristleback_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bristleback_bristleback_lua:IsHidden()
	return true
end

function modifier_bristleback_bristleback_lua:IsDebuff()
	return false
end

function modifier_bristleback_bristleback_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bristleback_bristleback_lua:OnCreated( kv )
	-- references
	self.reduction_back = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value
	self.reduction_side = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value
	self.angle_back = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value
	self.angle_side = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value
	self.max_threshold = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value
	self.ability_proc = "bristleback_quill_spray_lua"

	self.threshold = 0
end

function modifier_bristleback_bristleback_lua:OnRefresh( kv )
	-- references
	self.reduction_back = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value
	self.reduction_side = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value
	self.angle_back = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value
	self.angle_side = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value
	self.max_threshold = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value
end

function modifier_bristleback_bristleback_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bristleback_bristleback_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_bristleback_bristleback_lua:GetModifierIncomingDamage_Percentage( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		local parent = self:GetParent()
		local attacker = params.attacker
		local reduction = 0

		-- Check target position
		local facing_direction = parent:GetAnglesAsVector().y
		local attacker_vector = (attacker:GetOrigin() - parent:GetOrigin()):Normalized()
		local attacker_direction = VectorToAngles( attacker_vector ).y
		local angle_diff = AngleDiff( facing_direction, attacker_direction )

		-- calculate damage reduction
		if angle_diff > (180-self.reduction_back) then
			reduction = self.reduction_back
		elseif angle_diff > (180-self.reduction_side) then
			reduction = self.reduction_side
		end

		return reduction
	end
end

function modifier_bristleback_bristleback_lua:OnTakeDamage( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetParent() then
			if not self:GetParent():PassivesDisabled() then
				pass = true
			end
		end

		if pass then
			-- add damage to threshold
			self.threshold = self.threshold + params.damage
			if self.threshold > self.max_threshold then
				-- reset threshold
				self.threshold = 0

				-- cast quill spray if found
				local ability = self:GetParent():FindAbilityByName( self.ability_proc )
				if ability~=nil then
					self:GetParent():CastAbilityNoTarget( ability, self:GetParent():GetPlayerID() )
				end
			end
		end
	end
end
--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_bristleback_bristleback_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_bristleback_bristleback_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end