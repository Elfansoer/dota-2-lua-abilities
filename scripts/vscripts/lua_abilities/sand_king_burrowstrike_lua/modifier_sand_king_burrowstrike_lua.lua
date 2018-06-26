modifier_sand_king_burrowstrike_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sand_king_burrowstrike_lua:IsHidden()
	return true
end

function modifier_sand_king_burrowstrike_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sand_king_burrowstrike_lua:OnCreated( kv )
	if IsServer() then
		-- references
		self.point = Vector( kv.pos_x, kv.pos_y, kv.pos_z )

		-- Start interval
		self:StartIntervalThink( self:GetDuration()/2 )
	end
end

function modifier_sand_king_burrowstrike_lua:OnDestroy( kv )

end

function modifier_sand_king_burrowstrike_lua:OnIntervalThink()
	FindClearSpaceForUnit( self:GetParent(), self.point, true )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sand_king_burrowstrike_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end