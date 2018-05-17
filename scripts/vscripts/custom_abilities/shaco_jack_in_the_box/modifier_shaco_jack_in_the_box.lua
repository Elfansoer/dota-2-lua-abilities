modifier_shaco_jack_in_the_box = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_shaco_jack_in_the_box:IsHidden()
	return false
end

function modifier_shaco_jack_in_the_box:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_shaco_jack_in_the_box:OnCreated( kv )
	-- references
	self.fear_duration = self:GetAbility():GetSpecialValueFor( "fear_duration" ) -- special value
	self.trigger_radius = self:GetAbility():GetSpecialValueFor( "trigger_radius" ) -- special value
	self.fear_radius = self:GetAbility():GetSpecialValueFor( "fear_radius" ) -- special value

	self.hidden = true

	-- -- find enemy vision reference (enemy Ancient)
	-- self.reference = CreateModifierThinker(
	-- 	self:GetCaster(), -- player source
	-- 	self:GetAbility(), -- ability source
	-- 	"modifier_some_modifier_lua", -- modifier name
	-- 	{}, -- kv
	-- 	self:GetParent():GetOrigin(),
	-- 	self:GetParent():GetOpposingTeamNumber(),
	-- 	false
	-- )

	if IsServer() then
		self.interval = 0.3

		-- Start interval
		self:StartIntervalThink( self.interval )
	end
end

function modifier_shaco_jack_in_the_box:OnRefresh( kv )
	
end

function modifier_shaco_jack_in_the_box:OnDestroy()
	if IsServer() then
		self:GetParent():ForceKill( false )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_shaco_jack_in_the_box:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}

	return funcs
end
function modifier_shaco_jack_in_the_box:GetModifierInvisibilityLevel()
	if self.hidden then 
		return 1
	else
		return 0
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_shaco_jack_in_the_box:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = self.hidden,
		[MODIFIER_STATE_DISARMED] = self.hidden,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_shaco_jack_in_the_box:OnIntervalThink()
	if self.hidden then
		-- locate enemies
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),	-- int, your team number
			self:GetParent():GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.trigger_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		-- caught enemy
		-- if #enemies>0 and (not self.reference:CanEntityBeSeenByMyTeam(self:GetParent())) then
		if #enemies>0 then
			-- apply fear
			enemies = FindUnitsInRadius(
				self:GetCaster():GetTeamNumber(),	-- int, your team number
				self:GetParent():GetOrigin(),	-- point, center point
				nil,	-- handle, cacheUnit. (not known)
				self.fear_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
				DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
				0,	-- int, flag filter
				0,	-- int, order filter
				false	-- bool, can grow cache
			)

			local pos_x = self:GetParent():GetOrigin().x
			local pos_y = self:GetParent():GetOrigin().y
			for _,enemy in pairs(enemies) do
				enemy:AddNewModifier(
					self:GetCaster(), -- player source
					self:GetAbility(), -- ability source
					"modifier_shaco_jack_in_the_box_fear", -- modifier name
					{
						duration = self.fear_duration,
						center_x = pos_x,
						center_y = pos_y,
					} -- kv
				)
			end

			-- reveal
			self.hidden = false
			self:StartIntervalThink( -1 )
			self:SetDuration( self.fear_duration, true )
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_shaco_jack_in_the_box:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_shaco_jack_in_the_box:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_shaco_jack_in_the_box:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		nFXIndex,
-- 		bDestroyImmediately,
-- 		bStatusEffect,
-- 		iPriority,
-- 		bHeroEffect,
-- 		bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end