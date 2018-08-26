modifier_grimstroke_phantoms_embrace_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_grimstroke_phantoms_embrace_lua_debuff:IsHidden()
	return false
end

function modifier_grimstroke_phantoms_embrace_lua_debuff:IsDebuff()
	return true
end

function modifier_grimstroke_phantoms_embrace_lua_debuff:IsStunDebuff()
	return false
end

function modifier_grimstroke_phantoms_embrace_lua_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_grimstroke_phantoms_embrace_lua_debuff:OnCreated( kv )
	if IsServer() then
		self:SetStackCount( 1 )
	end
end

function modifier_grimstroke_phantoms_embrace_lua_debuff:OnRefresh( kv )
	if IsServer() then
		self:IncrementStackCount()
	end
end

function modifier_grimstroke_phantoms_embrace_lua_debuff:OnDestroy( kv )

end

function modifier_grimstroke_phantoms_embrace_lua_debuff:OnStackCountChanged( oldStack )
	if IsServer() then
		if self:GetStackCount()<1 then
			self:Destroy()
		end
	end
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_grimstroke_phantoms_embrace_lua_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_grimstroke_phantoms_embrace_lua_debuff:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end

function modifier_grimstroke_phantoms_embrace_lua_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
