modifier_slark_dark_pact_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_slark_dark_pact_lua:IsHidden()
	-- final: true
	return false
end

function modifier_slark_dark_pact_lua:GetAttributes()
	return MODIFIER_ATRRIBUTE_MULTIPLE 
end

function modifier_slark_dark_pact_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_dark_pact_lua:OnCreated( kv )
	-- references
	self.delay = self:GetAbility():GetSpecialValueFor( "delay" )
	self.pulse_duration = self:GetAbility():GetSpecialValueFor( "pulse_duration" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.total_damage = self:GetAbility():GetSpecialValueFor( "total_damage" )
	self.total_pulses = self:GetAbility():GetSpecialValueFor( "total_pulses" )
	self.pulse_interval = self:GetAbility():GetSpecialValueFor( "pulse_interval" )

	-- Additional variables
	self.cast = false
	self.current_pulse = 0

	-- Start interval
	self:StartIntervalThink( self.delay )

end

function modifier_slark_dark_pact_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_slark_dark_pact_lua:OnIntervalThink()
	if IsServer() then
		if not self.cast then
			self.cast = true

			self:Splash()
			self:StartIntervalThink( self.pulse_interval )
		else
			self:Splash()
		end
	end
end

function modifier_slark_dark_pact_lua:Splash()
	-- purge
	self:GetParent():Purge(false, true, false, true, false)

	-- get damage per interval
	local damage_interval = self.total_damage/self.total_pulses

	-- find units in radius
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- do for each enemies caught
	for _,enemy in pairs(enemies) do
		-- Apply damage
		local damageTable = {
			victim = enemy,
			attacker = self:GetParent(),
			damage = damage_interval,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility()
		}
		ApplyDamage(damageTable)
	end

	-- Apply damage to self
	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetParent(),
		damage = damage_interval/2,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility()
	}
	ApplyDamage(damageTable)

	-- add counter
	self.current_pulse = self.current_pulse + 1
	if self.current_pulse >=10 then
		self:StartIntervalThink( -1 )
		self:Destroy()
	end
end