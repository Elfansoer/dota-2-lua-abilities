modifier_sandra_will_to_live = class({})
local tempTable = require("util/tempTable")
--------------------------------------------------------------------------------
-- Classifications
function modifier_sandra_will_to_live:IsHidden()
	return false
end

function modifier_sandra_will_to_live:IsDebuff()
	return false
end

function modifier_sandra_will_to_live:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_will_to_live:OnCreated( kv )
	-- references
	self.delay = self:GetAbility():GetSpecialValueFor( "damage_delay" ) -- special value
	self.threshold_base = self:GetAbility():GetSpecialValueFor( "threshold_base" ) -- special value
	self.threshold_stack = self:GetAbility():GetSpecialValueFor( "threshold_stack" ) -- special value
	self.threshold_stack_creep = self:GetAbility():GetSpecialValueFor( "threshold_stack_creep" ) -- special value
	self.stack_duration = self:GetAbility():GetSpecialValueFor( "stack_duration" ) -- special value

	self.bonus_stack = 0

	if IsServer() then
		self:SetStackCount( self.threshold_base )
	end
end

function modifier_sandra_will_to_live:OnRefresh( kv )
	-- references
	self.delay = self:GetAbility():GetSpecialValueFor( "damage_delay" ) -- special value
	self.threshold_base = self:GetAbility():GetSpecialValueFor( "threshold_base" ) -- special value
	self.threshold_stack = self:GetAbility():GetSpecialValueFor( "threshold_stack" ) -- special value
	self.threshold_stack_creep = self:GetAbility():GetSpecialValueFor( "threshold_stack_creep" ) -- special value
	self.stack_duration = self:GetAbility():GetSpecialValueFor( "stack_duration" ) -- special value

	if IsServer() then
		self:SetStackCount( self.threshold_base + self.bonus_stack )
	end
end

function modifier_sandra_will_to_live:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sandra_will_to_live:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_MIN_HEALTH,
	}

	return funcs
end

function modifier_sandra_will_to_live:GetMinHealth()
	if IsServer() then
		self.currentHealth = self:GetParent():GetHealth()
	end
end
function modifier_sandra_will_to_live:OnTakeDamage( params )
	if IsServer() then
		if params.unit~=self:GetParent() or params.inflictor==self:GetAbility() then
			return
		end

		-- cancel if break
		if self:GetParent():PassivesDisabled() and (not self:GetParent():HasScepter()) then
			return
		end

		-- cover up damage
		self:GetParent():SetHealth( self.currentHealth )

		-- add delay damage if bigger than base threshold
		if params.damage > self.threshold_base then
			local attacker = tempTable:AddATValue( params.attacker )
			local modifier = tempTable:AddATValue( self )
			self:GetParent():AddNewModifier(
				self:GetParent(), -- player source
				self:GetAbility(), -- ability source
				"modifier_sandra_will_to_live_delay", -- modifier name
				{ 
					damage = params.damage,
					source = attacker,
					flags = params.damage_flags,
					modifier = modifier,
				} -- kv
			)
		end

		-- add threshold stack
		if params.attacker:GetTeamNumber()~=self:GetParent():GetTeamNumber() then
			local stack = self.threshold_stack
			if params.attacker:IsCreep() then
				stack = self.threshold_stack_creep
			end
			self:AddStack( stack )
		end

		-- effects
		self:PlayEffects( params.attacker )
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_sandra_will_to_live:AddStack( value )
	-- increment stack
	self.bonus_stack = self.bonus_stack + value
	self:SetStackCount( self.threshold_base + self.bonus_stack )

	-- add stack modifier
	local modifier = tempTable:AddATValue( self )
	self:GetParent():AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_sandra_will_to_live_threshold", -- modifier name
		{ 
			duration = self.stack_duration,
			modifier = modifier,
			stack = value,
		} -- kv
	)
end

function modifier_sandra_will_to_live:RemoveStack( value )
	-- decrement stack
	self.bonus_stack = self.bonus_stack - value
	self:SetStackCount( self.threshold_base + self.bonus_stack )
end

--------------------------------------------------------------------------------
-- Play Effects
function modifier_sandra_will_to_live:PlayEffects( attacker )
	-- references
	local particle_cast = "particles/items_fx/backdoor_protection_tube.vpcf"

	-- load data
	local direction = (self:GetParent():GetOrigin()-attacker:GetOrigin()):Normalized()
	local size = 150

	-- effect
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( size, 0, 0 ) )
	ParticleManager:SetParticleControlForward( effect_cast, 2, direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end