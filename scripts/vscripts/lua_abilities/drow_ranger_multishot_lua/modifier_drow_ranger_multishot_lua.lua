-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_drow_ranger_multishot_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_drow_ranger_multishot_lua:IsHidden()
	return false
end

function modifier_drow_ranger_multishot_lua:IsDebuff()
	return false
end

function modifier_drow_ranger_multishot_lua:IsStunDebuff()
	return false
end

function modifier_drow_ranger_multishot_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_drow_ranger_multishot_lua:OnCreated( kv )
	-- references
	local count = self:GetAbility():GetSpecialValueFor( "arrow_count" )
	local range = self:GetAbility():GetSpecialValueFor( "arrow_range_multiplier" )
	local width = self:GetAbility():GetSpecialValueFor( "arrow_width" )
	self.speed = self:GetAbility():GetSpecialValueFor( "arrow_speed" )
	-- self.angle = self:GetAbility():GetSpecialValueFor( "arrow_angle" )
	self.angle = 33.33

	if not IsServer() then return end

	-- none provided in kv file. shame on you volvo
	local vision = 100
	local delay = 0.1
	local wave = 3
	local wave_interval = 0.55
	self.arrow_delay = 0.033

	-- calculate stuff
	self.arrows = count/wave
	self.wave_delay = wave_interval - self.arrow_delay*(self.arrows-1)

	-- get projectile main direction
	local point = Vector(kv.x, kv.y, kv.z)
	self.direction = point-self:GetCaster():GetOrigin()
	self.direction.z = 0
	self.direction = self.direction:Normalized()

	-- set states
	self.state = STATE_SALVO
	self.current_arrows = 0
	self.current_wave = 0
	self.frost = false

	-- check frost arrows ability
	local ability = self:GetCaster():FindAbilityByName( "drow_ranger_frost_arrows_lua" )
	if ability and ability:GetLevel()>0 then
		self.frost = true
	end

	-- precache projectile
	local caster = self:GetCaster()
	local projectile_name
	if self.frost then
		projectile_name = "particles/units/heroes/hero_drow/drow_multishot_proj_linear_proj.vpcf"
	else
		projectile_name = "particles/units/heroes/hero_drow/drow_base_attack_linear_proj.vpcf"
	end

	self.info = {
		Source = caster,
		Ability = self:GetAbility(),
		vSpawnOrigin = caster:GetAttachmentOrigin( caster:ScriptLookupAttachment( "attach_attack1" ) ),
		
	    bDeleteOnHit = true,
	    
	    iUnitTargetTeam = self:GetAbility():GetAbilityTargetTeam(),
	    iUnitTargetType = self:GetAbility():GetAbilityTargetType(),
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,

	    EffectName = projectile_name,
	    fDistance = caster:Script_GetAttackRange() * range,
	    fStartRadius = self.width,
	    fEndRadius = self.width,
		-- vVelocity = projectile_direction * self.speed,
	
		bProvidesVision = true,
		iVisionRadius = vision,
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	-- ProjectileManager:CreateLinearProjectile(info)

	-- Start interval
	self:StartIntervalThink( delay )

	-- play effects
	local sound_cast = "Hero_DrowRanger.Multishot.Channel"
	EmitSoundOn( sound_cast, caster )
end

function modifier_drow_ranger_multishot_lua:OnRefresh( kv )
end

function modifier_drow_ranger_multishot_lua:OnRemoved()
end

function modifier_drow_ranger_multishot_lua:OnDestroy()
	if not IsServer() then return end

	-- stop effects
	local sound_cast = "Hero_DrowRanger.Multishot.Channel"
	StopSoundOn( sound_cast, self:GetCaster() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_drow_ranger_multishot_lua:OnIntervalThink()
	-- count arrows
	if self.current_arrows<self.arrows then

		self:StartIntervalThink( self.arrow_delay )
	else
		self.current_arrows = 0
		self.current_wave = self.current_wave+1

		self:StartIntervalThink( self.wave_delay )
		return
	end

	-- calculate relative angle of current arrow against cast direction
	local step = self.angle/(self.arrows-1)
	local angle = -self.angle/2 + self.current_arrows*step

	-- calculate actual direction
	local projectile_direction = RotatePosition( Vector(0,0,0), QAngle( 0, angle, 0 ), self.direction )

	-- launch projectile
	self.info.vVelocity = projectile_direction * self.speed
	self.info.ExtraData = {
		arrow = self.current_arrows,
		wave = self.current_wave,
		frost = self.frost,
	}
	ProjectileManager:CreateLinearProjectile(self.info)

	self:PlayEffects()

	self.current_arrows = self.current_arrows+1
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_drow_ranger_multishot_lua:PlayEffects()
	-- Get Resources
	local sound_cast
	if self.frost then
		sound_cast = "Hero_DrowRanger.Multishot.FrostArrows"
	else
		sound_cast = "Hero_DrowRanger.Multishot.Attack"
	end

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end