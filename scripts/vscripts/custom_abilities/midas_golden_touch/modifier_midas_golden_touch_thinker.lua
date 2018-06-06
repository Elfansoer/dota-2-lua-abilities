modifier_midas_golden_touch_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_touch_thinker:IsHidden()
	return true
end

function modifier_midas_golden_touch_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_touch_thinker:OnCreated( kv )
	if IsServer() then
		print("create")
		self.sequence = self:GetCaster():GetSequence()
		self.n = 0
		self:GetParent():StopAnimation()
		self:GetParent():SetForwardVector( self:GetCaster():GetForwardVector() )
		self:GetParent():SetPoseParameter( self.sequence, self.n )
		self:StartIntervalThink( 0.3 )
	end
end

function modifier_midas_golden_touch_thinker:OnRefresh( kv )
	
end

function modifier_midas_golden_touch_thinker:OnDestroy( kv )
	if IsServer() then
		-- Effects
		print("destroy")
		UTIL_Remove(self:GetParent())
	end
end

function modifier_midas_golden_touch_thinker:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}

	return funcs
end

function modifier_midas_golden_touch_thinker:GetModifierModelChange()
	return self:GetCaster():GetModelName()
end
function modifier_midas_golden_touch_thinker:GetModifierModelScale()
	return self:GetCaster():GetModelScale()
end

function modifier_midas_golden_touch_thinker:CheckState()
	local state = {
		[MODIFIER_STATE_FROZEN] = true,
	}

	return state
end

function modifier_midas_golden_touch_thinker:OnIntervalThink()
	self.n = self.n + 0.1
	self:GetParent():SetPoseParameter( self.sequence, self.n )	
end
