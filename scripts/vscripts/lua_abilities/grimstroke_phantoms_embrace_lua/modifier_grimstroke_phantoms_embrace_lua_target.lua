modifier_grimstroke_phantoms_embrace_lua_target = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_grimstroke_phantoms_embrace_lua_target:IsHidden()
	return false
end

function modifier_grimstroke_phantoms_embrace_lua_target:IsDebuff()
	return true
end

function modifier_grimstroke_phantoms_embrace_lua_target:IsStunDebuff()
	return false
end

function modifier_grimstroke_phantoms_embrace_lua_target:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_grimstroke_phantoms_embrace_lua_target:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_grimstroke_phantoms_embrace_lua_target:OnCreated( kv )
	if IsServer() then
		self.silence = false
	end
end

function modifier_grimstroke_phantoms_embrace_lua_target:OnRefresh( kv )

end

function modifier_grimstroke_phantoms_embrace_lua_target:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_grimstroke_phantoms_embrace_lua_target:CheckState()
	local state = {
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_grimstroke_phantoms_embrace_lua_target:GetEffectName()
	return "particles/units/heroes/hero_grimstroke/grimstroke_phantom_marker.vpcf"
end

function modifier_grimstroke_phantoms_embrace_lua_target:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end