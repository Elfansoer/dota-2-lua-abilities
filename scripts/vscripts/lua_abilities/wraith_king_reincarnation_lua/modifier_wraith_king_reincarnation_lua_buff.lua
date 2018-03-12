modifier_wraith_king_reincarnation_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wraith_king_reincarnation_lua_buff:IsHidden()
	return not self.dead
end

function modifier_wraith_king_reincarnation_lua_buff:IsDebuff()
	return false
end

function modifier_wraith_king_reincarnation_lua_buff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wraith_king_reincarnation_lua_buff:OnCreated( kv )
	-- references
	self.delay_duration = self:GetAbility():GetSpecialValueFor( "scepter_duration" )

	self.dead = false
end

function modifier_wraith_king_reincarnation_lua_buff:OnRefresh( kv )
	self.delay_duration = self:GetAbility():GetSpecialValueFor( "scepter_duration" )
end

function modifier_wraith_king_reincarnation_lua_buff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wraith_king_reincarnation_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}

	return funcs
end

function modifier_wraith_king_reincarnation_lua_buff:GetMinHealth( params )
	print(params.attacker,params.unit,params.target,params.damage,params.record)
 	return 1
end

function modifier_wraith_king_reincarnation_lua_buff:GetMinHealth( params )
	print(params.attacker,params.unit,params.target,params.damage,params.record)
 	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_wraith_king_reincarnation_lua_buff:CheckState()
	local state = {
	[MODIFIER_STATE_XX] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_wraith_king_reincarnation_lua_buff:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_wraith_king_reincarnation_lua_buff:GetEffectName()
	return "particles/string/here.vpcf"
end

function modifier_wraith_king_reincarnation_lua_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end