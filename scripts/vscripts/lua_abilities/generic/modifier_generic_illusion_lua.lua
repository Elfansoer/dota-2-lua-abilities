modifier_generic_illusion_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_illusion_lua:IsHidden()
	return false
end

function modifier_generic_illusion_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_illusion_lua:OnCreated( kv )
	-- references
	self.duration = kv.duration
	self.outgoing = kv.outgoing
	self.incoming = kv.incoming
end

function modifier_generic_illusion_lua:OnRefresh( kv )
	
end

function modifier_generic_illusion_lua:OnDestroy( kv )
	if IsServer() then
		self:GetParent():ForceKill( false )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_illusion_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION,
		MODIFIER_PROPERTY_ILLUSION_LABEL,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_ILLUSION,
		MODIFIER_PROPERTY_IS_ILLUSION,

		MODIFIER_PROPERTY_LIFETIME_FRACTION,
	}

	return funcs
end

function modifier_generic_illusion_lua:GetModifierDamageOutgoing_Percentage_Illusion()
	return self.outgoing
end
function modifier_generic_illusion_lua:GetModifierIllusionLabel()
	return 1
end
function modifier_generic_illusion_lua:GetModifierIncomingDamage_Illusion()
	return self.incoming
end
function modifier_generic_illusion_lua:GetIsIllusion()
	return 1
end 

function modifier_generic_illusion_lua:GetUnitLifetimeFraction( params )
	return ( ( self:GetDieTime() - GameRules:GetGameTime() ) / self:GetDuration() )
end
--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_generic_illusion_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_generic_illusion_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end