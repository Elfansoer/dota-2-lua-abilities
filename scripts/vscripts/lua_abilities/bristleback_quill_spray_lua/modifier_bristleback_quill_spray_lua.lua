modifier_bristleback_quill_spray_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bristleback_quill_spray_lua:IsHidden()
	return false
end

function modifier_bristleback_quill_spray_lua:IsDebuff()
	return true
end

function modifier_bristleback_quill_spray_lua:IsPurgable()
	return false
end

function modifier_bristleback_quill_spray_lua:DestroyOnExpire()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_bristleback_quill_spray_lua:OnCreated( kv )
	if IsServer() then
		-- get AT value
		local at = self:GetAbility():AddATValue( self )

		-- Add stack
		self:GetParent():AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_bristleback_quill_spray_lua_stack",
			{
				duration = kv.stack_duration,
				modifier = at,
			}
		)

		-- set stack
		self:SetStackCount( 1 )
	end
end

function modifier_bristleback_quill_spray_lua:OnRefresh( kv )
	if IsServer() then
		-- get AT value
		local at = self:GetAbility():AddATValue( self )

		-- Add stack
		self:GetParent():AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_bristleback_quill_spray_lua_stack",
			{
				duration = kv.stack_duration,
				modifier = at,
			}
		)

		-- increment stack
		self:IncrementStackCount()
	end
end

function modifier_bristleback_quill_spray_lua:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Helper
function modifier_bristleback_quill_spray_lua:RemoveStack( kv )
	self:DecrementStackCount()
	if self:GetStackCount()<1 then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bristleback_quill_spray_lua:GetEffectName()
	return "particles/units/heroes/hero_bristleback/bristleback_quill_spray_hit_creep.vpcf"
end

function modifier_bristleback_quill_spray_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end