modifier_generic_silenced_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_silenced_lua:IsDebuff()
	return true
end

function modifier_generic_silenced_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_silenced_lua:OnCreated( kv )
	if not IsServer() then return end

	-- calculate status resistance
	local resist = 1-self:GetParent():GetStatusResistance()
	local duration = kv.duration*resist
	self:SetDuration( duration, true )
end

function modifier_generic_silenced_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_generic_silenced_lua:OnRemoved()
end

function modifier_generic_silenced_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_silenced_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_generic_silenced_lua:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end

function modifier_generic_silenced_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end