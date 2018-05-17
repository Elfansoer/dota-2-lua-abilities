modifier_shaco_deceive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_shaco_deceive:IsHidden()
	return false
end

function modifier_shaco_deceive:IsDebuff()
	return false
end

function modifier_shaco_deceive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_shaco_deceive:OnCreated( kv )
	if IsServer() then
		-- move
		local target = Vector(kv.target_x,kv.target_y,0)
		FindClearSpaceForUnit( self:GetParent(), target, true )
	end
end

function modifier_shaco_deceive:OnRefresh( kv )
	if IsServer() then
		-- move
		local target = Vector(kv.target_x,kv.target_y,0)
		FindClearSpaceForUnit( self:GetParent(), target, true )
	end
end

function modifier_shaco_deceive:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_shaco_deceive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}

	return funcs
end

function modifier_shaco_deceive:GetModifierInvisibilityLevel()
	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_shaco_deceive:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
-- function modifier_shaco_deceive:OnIntervalThink()
-- 	self.hidden = true
-- end