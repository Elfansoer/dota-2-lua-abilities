modifier_bakedanuki_tomfoolery_hidden = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bakedanuki_tomfoolery_hidden:IsHidden()
	return true
end

function modifier_bakedanuki_tomfoolery_hidden:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bakedanuki_tomfoolery_hidden:OnCreated( kv )
	if IsServer() then
		self:GetParent():AddNoDraw()
	end
end

function modifier_bakedanuki_tomfoolery_hidden:OnRefresh( kv )
	
end

function modifier_bakedanuki_tomfoolery_hidden:OnDestroy( kv )
	if IsServer() then
		self:GetParent():StartGestureWithPlaybackRate( ACT_DOTA_CAST_ABILITY_2, 2.0 )
		self:GetParent():RemoveNoDraw()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_bakedanuki_tomfoolery_hidden:CheckState()
	local state = {
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end