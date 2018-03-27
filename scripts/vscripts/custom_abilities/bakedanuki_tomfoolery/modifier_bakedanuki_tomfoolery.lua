modifier_bakedanuki_tomfoolery = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bakedanuki_tomfoolery:IsHidden()
	return false
	-- return true
end

function modifier_bakedanuki_tomfoolery:IsPurgable()
	return false
end

function modifier_bakedanuki_tomfoolery:DestroyOnExpire()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_bakedanuki_tomfoolery:OnCreated( kv )
	-- references
	self.illusion_incoming = self:GetAbility():GetSpecialValueFor( "illusion_incoming" ) -- special value
	self.illusion_outgoing = self:GetAbility():GetSpecialValueFor( "illusion_outgoing" ) -- special value

	-- Start interval
	if IsServer() then
		self:StartIntervalThink( kv.duration )
	end
end

function modifier_bakedanuki_tomfoolery:OnRefresh( kv )
	
end

function modifier_bakedanuki_tomfoolery:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bakedanuki_tomfoolery:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION,
		-- MODIFIER_PROPERTY_INCOMING_DAMAGE_ILLUSION,

		-- MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,

		MODIFIER_EVENT_ON_ABILITY_START,
		
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_bakedanuki_tomfoolery:GetModifierDamageOutgoing_Percentage_Illusion()
-- function modifier_bakedanuki_tomfoolery:GetModifierDamageOutgoing_Percentage()
	return self.illusion_outgoing-100
end

-- function modifier_bakedanuki_tomfoolery:GetModifierIncomingDamage_Percentage_Illusion()
function modifier_bakedanuki_tomfoolery:GetModifierIncomingDamage_Percentage()
	return self.illusion_incoming-100
end

function modifier_bakedanuki_tomfoolery:OnAbilityStart( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetCaster() then
			pass = true
		end

		-- logic
		if pass then
			self:GetAbility():StopTrick()
		end
	end
end

function modifier_bakedanuki_tomfoolery:GetMinHealth()
	return 1
end
function modifier_bakedanuki_tomfoolery:OnTakeDamage( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetCaster() then
			pass = true
		end

		-- logic
		if pass then
			if self:GetParent():GetHealth()<=1 then
				self:GetAbility():StopTrick()
			end
		end
	end
end
function modifier_bakedanuki_tomfoolery:OnDeath( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetAbility().tomfoolery.illusion then
			pass = true
		end

		-- logic
		if pass then
			self:GetAbility():StopTrick()
		end
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_bakedanuki_tomfoolery:OnIntervalThink()
	self:GetAbility():StopTrick()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
