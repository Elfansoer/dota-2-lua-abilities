modifier_generic_stunned_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_stunned_lua:IsDebuff()
	return true
end

function modifier_generic_stunned_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_stunned_lua:OnCreated( kv )
	if not IsServer() then return end

	self.particle = "particles/generic_gameplay/generic_stunned.vpcf"
	if kv.bash==1 then
		self.particle = "particles/generic_gameplay/generic_bashed.vpcf"
	end


	-- calculate status resistance
	local resist = 1-self:GetParent():GetStatusResistance()
	local duration = kv.duration*resist
	self:SetDuration( duration, true )
end

function modifier_generic_stunned_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_generic_stunned_lua:OnRemoved()
end

function modifier_generic_stunned_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_stunned_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_stunned_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_generic_stunned_lua:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_generic_stunned_lua:GetEffectName()
	return self.particle
end

function modifier_generic_stunned_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end