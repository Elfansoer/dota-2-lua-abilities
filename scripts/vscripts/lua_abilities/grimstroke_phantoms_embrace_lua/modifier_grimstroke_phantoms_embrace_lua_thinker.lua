modifier_grimstroke_phantoms_embrace_lua_thinker = class({})
local tempTable = require("util/tempTable")
--------------------------------------------------------------------------------
-- Classifications
function modifier_grimstroke_phantoms_embrace_lua_thinker:IsHidden()
	return true
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:IsDebuff()
	return false
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_grimstroke_phantoms_embrace_lua_thinker:OnCreated( kv )
	if IsServer() then
		-- references
		self.target_modifier = tempTable:RetATValue( kv.target )
		self.target = self.target_modifier:GetParent()

		-- latchings		
		self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
		self.latch_offset = self:GetAbility():GetSpecialValueFor( "latched_unit_offset" )
		self.latch_duration = self:GetAbility():GetSpecialValueFor( "latch_duration" )

		-- tick and pop
		self.tick_interval = self:GetAbility():GetSpecialValueFor( "tick_interval" )
		local tick_damage = self:GetAbility():GetSpecialValueFor( "damage_per_tick" )
		self.pop_damage = self:GetAbility():GetSpecialValueFor( "pop_damage" )
		self.return_projectile = "particles/units/heroes/hero_grimstroke/grimstroke_phantom_return.vpcf"

		-- attacks
		self.health = self:GetAbility():GetSpecialValueFor( "destroy_attacks" )
		self.hero_attack = self.health/self:GetAbility():GetSpecialValueFor( "destroy_attacks_tooltip" )
		self.max_health = self.health

		-- initialization
		self.latching = false
		self.damageTable = {
			victim = self.target,
			attacker = self:GetCaster(),
			damage = tick_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
			damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
		}

		-- apply motion controller
		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
		end

		-- play effects
		self:PlayEffects1()
	end
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:OnDestroy( kv )
	if IsServer() then
		-- motion compulsory interrupts
		self:GetParent():InterruptMotionControllers( true )

		-- remove modifier
		if not self.latching then
			if not self.target_modifier:IsNull() then
				self.target_modifier:Destroy()
			end
		else
			if not self.modifier:IsNull() then
				self.modifier:DecrementStackCount()
			end
		end

		-- if phantom is alive, send projectile and pop damage
		if self:GetParent():IsAlive() and not self.forcedKill then
			local info = {
				Target = self:GetCaster(),
				Source = self:GetParent(),
				Ability = self:GetAbility(),	
				
				EffectName = self.return_projectile,
				iMoveSpeed = self.speed,
				bDodgeable = true,                           -- Optional		
			}
			ProjectileManager:CreateTrackingProjectile(info)

			-- damage
			self.damageTable.damage = self.pop_damage
			ApplyDamage( self.damageTable )

			-- play effects
			local sound_damage = "Hero_Grimstroke.InkCreature.Damage"
			EmitSoundOn( sound_damage, self:GetParent() )

			-- kill without animation
			UTIL_Remove( self:GetParent() )
			return
		end

		-- play effects
		self:PlayEffects3()

		-- kill parent
		self:GetParent():ForceKill( false )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_grimstroke_phantoms_embrace_lua_thinker:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACKED,
    	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:GetModifierIncomingDamage_Percentage()
	return -100
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:OnAttacked( params )
	if params.target~=self:GetParent() then return end

	-- reduce health
	if params.attacker:IsHero() then
		self.health = math.max(self.health - self.hero_attack, 0)
	else
		self.health = math.max(self.health - 1, 0)
	end
	self:GetParent():SetHealth( self.health/self.max_health * self:GetParent():GetMaxHealth() )

	-- play effects
	self:PlayEffects2()
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:GetOverrideAnimation()
	if self.latching then
	    return ACT_DOTA_CAPTURE
	else
	    return ACT_DOTA_RUN
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_grimstroke_phantoms_embrace_lua_thinker:CheckState()
	local state = {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_grimstroke_phantoms_embrace_lua_thinker:OnIntervalThink()
	-- Apply tick damage
	ApplyDamage( self.damageTable )

	-- play effects
	local sound_attack = "Hero_Grimstroke.InkCreature.Attack"
	EmitSoundOn( sound_attack, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_grimstroke_phantoms_embrace_lua_thinker:UpdateHorizontalMotion( me, dt )
	-- check target
	if self.target:IsInvisible() or self.target:IsMagicImmune() or self.target:IsInvulnerable() then
		self.forcedKill = true
		self:Destroy()
		return
	end

	-- check position
	if not self.latching then
		if (self.target:GetOrigin()-self:GetParent():GetOrigin()):Length2D()<self.latch_offset then
			-- change latch status
			self:SetLatching()
		end
		self:Charge( me, dt )
	else
		self:Latch( me, dt )
	end
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:Charge( me, dt )
	local parent = self:GetParent()
	local pos = self:GetParent():GetOrigin()
	local targetpos = self.target:GetOrigin()

	-- determine position
	local direction = targetpos-pos
	direction.z = 0		
	local target = pos + direction:Normalized() * (self.speed*dt)

	-- move to position
	parent:SetOrigin( target )
	parent:FaceTowards( targetpos )
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:Latch( me, dt )
	-- get position
	local target = self.target:GetOrigin() + self.target:GetForwardVector()*self.latch_offset

	-- move to position
	self:GetParent():SetOrigin( target )
	self:GetParent():FaceTowards(self.target:GetOrigin())
end

--------------------------------------------------------------------------------
-- Helper
function modifier_grimstroke_phantoms_embrace_lua_thinker:SetLatching()
	-- set status
	self.latching = true
	self:SetStackCount( 1 )

	-- tell the target modifier
	self.target_modifier:Destroy()

	-- add stack modifier
	self.modifier = self.target:AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_grimstroke_phantoms_embrace_lua_debuff", -- modifier name
		{ duration = self.latch_duration } -- kv
	)

	-- set latching duration
	self:SetDuration( self.latch_duration, false )

	-- start dps
	self:StartIntervalThink( self.tick_interval )

	-- play effects
	local sound_latch = "Hero_Grimstroke.InkCreature.Attach"
	EmitSoundOn( sound_latch, self:GetParent() )
end
function modifier_grimstroke_phantoms_embrace_lua_thinker:OnStackCountChanged( oldCount )
	-- only for animation
	if IsClient() then
		self.latching = true
	end
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_grimstroke_phantoms_embrace_lua_thinker:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_phantom_ambient.vpcf"
	local sound_spawn = "Hero_Grimstroke.InkCreature.Spawn"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
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

	-- Create Sound
	EmitSoundOn( sound_spawn, self:GetParent() )
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_phantom_attacked.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_grimstroke_phantoms_embrace_lua_thinker:PlayEffects3()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_phantom_death.vpcf"
	local sound_death = "Hero_Grimstroke.InkCreature.Death"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_death, self:GetParent() )
end