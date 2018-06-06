modifier_midas_golden_touch = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_touch:IsHidden()
	return true
end

function modifier_midas_golden_touch:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_touch:OnCreated( kv )
	if IsServer() then
		self.n = 0
		self.pose = kv.pose
		self:StartIntervalThink( 0.1 )
	end
end

function modifier_midas_golden_touch:OnRefresh( kv )
	
end

function modifier_midas_golden_touch:OnDestroy( kv )
	if IsServer() then
		-- Effects
		print("destroy")
		self:GetParent():AddNoDraw()
		self:GetParent():ForceKill(false)
		-- UTIL_Remove(self:GetParent())
	end
end

function modifier_midas_golden_touch:OnIntervalThink()
	print("set pose params: ",self.pose,self.n)
	self:GetParent():SetPoseParameter(self.pose,self.n)
	self.n = self.n + 0.1
end
