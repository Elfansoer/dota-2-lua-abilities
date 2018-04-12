modifier_sandra_sacrifice = class({})
local tempTable = require("util/tempTable")

--------------------------------------------------------------------------------
-- Classifications
function modifier_sandra_sacrifice:IsHidden()
	return false
end

function modifier_sandra_sacrifice:IsDebuff()
	return false
end

function modifier_sandra_sacrifice:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_sacrifice:OnCreated( kv )
	if IsServer() then
		-- references
		local master = tempTable:RetATValue( kv.master )
		self.leash_radius = self:GetAbility():GetSpecialValueFor("leash_radius")
		self.buffer_length = self:GetAbility():GetSpecialValueFor("leash_buffer")
		self.ms_bonus = self:GetAbility():GetSpecialValueFor("ms_bonus")

		-- load data
		local interval = 0.1
		self.normal_ms_limit = 550
		self.dragged = false
		self.buffer_radius = self.leash_radius - self.buffer_length

		-- create master's modifier
		local modifier = tempTable:AddATValue( self )
		self.master = master:AddNewModifier(
			self:GetParent(), -- player source
			self:GetAbility(), -- ability source
			"modifier_sandra_sacrifice_master", -- modifier name
			{
				duration = kv.duration,
				modifier = modifier,
			} -- kv
		)

		-- Start interval
		self:StartIntervalThink( interval )

		-- effects
		self:PlayEffects()
	end
end

function modifier_sandra_sacrifice:OnRefresh( kv )
end

function modifier_sandra_sacrifice:OnDestroy( kv )
	if IsServer() then
		if not self.master:IsNull() then
			self.master:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sandra_sacrifice:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_sandra_sacrifice:GetModifierMoveSpeedBonus_Constant()
	return self.ms_bonus
end

function modifier_sandra_sacrifice:GetModifierMoveSpeed_Limit()
	if IsServer() then
		-- zero is no limit
		return self.limit
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sandra_sacrifice:OnIntervalThink()
	if IsServer() then
		-- if dragged, just pass
		if not self.dragged then
			-- get info
			local vectorToMaster = self.master:GetParent():GetOrigin() - self:GetParent():GetOrigin()

			-- calculate facing angle
			local angleToMaster = VectorToAngles(vectorToMaster).y
			local slaveFacingAngle = self:GetParent():GetAnglesAsVector().y
			local angleDifference = math.abs(slaveFacingAngle - angleToMaster)
			if angleDifference > 180 then
				angleDifference = math.abs(angleDifference - 360)
			end

			-- calculate distance
			local distanceToMaster = vectorToMaster:Length2D()

			-- check if it is within boundaries
			if distanceToMaster < self.buffer_radius then
				-- within limit
				self.limit = self.normal_ms_limit
			elseif distanceToMaster < self.leash_radius + 0.1*self.buffer_length then
				-- about to be slowed. true limit is maximum + 0.1 * buffer length
				if angleDifference > 90 then
					self.limit = (1-(distanceToMaster-self.buffer_radius)/self.buffer_length) * self.normal_ms_limit
					if self.limit < 1 then
						self.limit = 0.01
					end
				else
					self.limit = self.normal_ms_limit
				end
			else
				-- outside, dragged
				local modifier = tempTable:AddATValue( self )
				self:GetParent():AddNewModifier(
					self:GetParent(), -- player source
					self:GetAbility(), -- ability source
					"modifier_sandra_sacrifice_pull", -- modifier name
					{ modifier = modifier } -- kv
				)
				self.dragged = true
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sandra_sacrifice:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_puck/puck_dreamcoil_tether.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self:GetParent() )

	local attach = ""
	if self.master:GetParent():ScriptLookupAttachment( "attach_attack2" )~=0 then
		attach = "attach_attack2"
	elseif self.master:GetParent():ScriptLookupAttachment( "attach_attack1" )~=0 then
		attach = "attach_attack1"
	else
		attach = "attach_hitloc"
	end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.master:GetParent(),
		PATTACH_POINT_FOLLOW,
		attach,
		self.master:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end