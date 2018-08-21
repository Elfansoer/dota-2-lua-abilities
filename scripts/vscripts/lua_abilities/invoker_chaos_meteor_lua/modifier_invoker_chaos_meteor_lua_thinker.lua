modifier_invoker_chaos_meteor_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_chaos_meteor_lua_thinker:IsHidden()
	return true
end

function modifier_invoker_chaos_meteor_lua_thinker:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_invoker_chaos_meteor_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_chaos_meteor_lua_thinker:OnCreated( kv )
	if IsServer() then
		-- references
		self.caster_origin = Vector( kv.x, kv.y, kv.z )
		self.parent_origin = self:GetParent():GetOrigin()
		self.direction = self.parent_origin - self.caster_origin
		self.direction.z = 0
		self.direction = self.direction:Normalized()

		local delay = self:GetAbility():GetSpecialValueFor( "land_time" )
		self.radius = self:GetAbility():GetSpecialValueFor( "area_of_effect" )
		self.distance = self:GetAbility():GetOrbSpecialValueFor( "travel_distance", "w" )
		self.speed = self:GetAbility():GetSpecialValueFor( "travel_speed" )
		self.vision = self:GetAbility():GetSpecialValueFor( "vision_distance" )
		self.vision_duration = self:GetAbility():GetSpecialValueFor( "end_vision_duration" )
		
		self.interval = self:GetAbility():GetSpecialValueFor( "damage_interval" )
		self.duration = self:GetAbility():GetSpecialValueFor( "burn_duration" )
		local damage = self:GetAbility():GetOrbSpecialValueFor( "main_damage", "e" )

		-- variables
		self.fallen = false
		self.damageTable = {
			-- victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}

		-- vision
		self:GetParent():SetDayTimeVisionRange( self.vision )
		self:GetParent():SetNightTimeVisionRange( self.vision )

		-- Start interval
		self:StartIntervalThink( delay )

		-- roll forward
		-- self:GetParent():SetMoveCapability( DOTA_UNIT_CAP_MOVE_FLY )
		-- local ret2 = self:ApplyHorizontalMotionController()
		-- print("apply motion",ret2)

		-- play effects
		local sound_impact = "Hero_Invoker.ChaosMeteor.Cast"
		EmitSoundOnLocationWithCaster( self.caster_origin, sound_impact, self:GetCaster() )
	end
end

function modifier_invoker_chaos_meteor_lua_thinker:OnRefresh( kv )
	
end

function modifier_invoker_chaos_meteor_lua_thinker:OnDestroy( kv )
	if IsServer() then
		-- add vision
		AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.vision, self.vision_duration, false)

		-- stop effects
		local sound_loop = "Hero_Invoker.ChaosMeteor.Loop"
		local sound_stop = "Hero_Invoker.ChaosMeteor.Destroy"
		StopSoundOn( sound_loop, self:GetCaster() )
		EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_stop, self:GetCaster() )

		-- clean up
		self:GetParent():InterruptMotionControllers( true )
		-- UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_invoker_chaos_meteor_lua_thinker:CheckState()
	-- local state = {
	-- 	[MODIFIER_STATE_FLYING] = true
	-- }

	-- return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_invoker_chaos_meteor_lua_thinker:OnIntervalThink()
	if not self.fallen then
		-- meatball has fallen
		self.fallen = true
		self:StartIntervalThink( self.interval )
		self:Burn()

		print("","Start",self:GetParent():GetOrigin())
		local ret2 = self:ApplyHorizontalMotionController()
		print("apply motion",ret2)
		
		-- play effects
		local info = {
			Source = self:GetCaster(),
			Ability = self:GetAbility(),
			vSpawnOrigin = self.parent_origin,
			
		    bDeleteOnHit = false,
		    
		    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		    iUnitTargetType = DOTA_UNIT_TARGET_HERO,
		    
		    EffectName = "particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf",
		    fDistance = self.distance,
		    fStartRadius = self.radius,
		    fEndRadius =self.radius,
			vVelocity = self.direction * self.speed,
		
			bReplaceExisting = false,
			
			bProvidesVision = true,
			iVisionRadius = self.vision,
			iVisionTeamNumber = self:GetCaster():GetTeamNumber()
		}
		ProjectileManager:CreateLinearProjectile(info)

		local sound_impact = "Hero_Invoker.ChaosMeteor.Impact"
		local sound_loop = "Hero_Invoker.ChaosMeteor.Loop"
		EmitSoundOnLocationWithCaster( self.parent_origin, sound_impact, self:GetCaster() )
		EmitSoundOn( sound_loop, self:GetCaster() )
	else
		-- damages
		self:Burn()
	end
end

function modifier_invoker_chaos_meteor_lua_thinker:Burn()
	local particle_blast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local nFXIndex = ParticleManager:CreateParticle( particle_blast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( nFXIndex, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- apply damage
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )

		-- add modifier
		enemy:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_invoker_chaos_meteor_lua_burn", -- modifier name
			{ duration = self.duration } -- kv
		)
	end
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_invoker_chaos_meteor_lua_thinker:UpdateHorizontalMotion( me, dt )
	print("","Tick",self:GetParent():GetOrigin())
	local parent = self:GetParent()
	
	-- check distance
	if (parent:GetOrigin()-self.parent_origin):Length2D()>self.distance then
		self:Destroy()
		return
	end

	-- set position
	local target = self.direction*self.speed*dt

	-- change position
	parent:SetOrigin( parent:GetOrigin() + target )
end

function modifier_invoker_chaos_meteor_lua_thinker:OnHorizontalMotionInterrupted()
	if IsServer() then
		print("interrupted")
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_invoker_chaos_meteor_lua_thinker:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_invoker_chaos_meteor_lua_thinker:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_invoker_chaos_meteor_lua_thinker:PlayEffects()
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