modifier_generic_summon_timer = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_summon_timer:IsDebuff()
	return true
end

function modifier_generic_summon_timer:IsHidden()
	return true
end

function modifier_generic_summon_timer:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_summon_timer:OnDestroy()
	if IsServer() then
		self:GetParent():ForceKill( false )
	end
end

--------------------------------------------------------------------------------
-- Declare Functions
function modifier_generic_summon_timer:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_LIFETIME_FRACTION
	}

	return funcs
end

function modifier_generic_summon_timer:GetUnitLifetimeFraction( params )
	return ( ( self:GetDieTime() - GameRules:GetGameTime() ) / self:GetDuration() )
end

--------------------------------------------------------------------------------