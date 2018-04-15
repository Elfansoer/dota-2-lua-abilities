puck_illusory_orb_lua = class({})
puck_ethereal_jaunt_lua = class({})
LinkLuaModifier( "modifier_puck_illusory_orb_lua_thinker", "lua_abilities/puck_illusory_orb_lua/modifier_puck_illusory_orb_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Shared data
puck_illusory_orb_lua.projectiles = {}

--------------------------------------------------------------------------------
-- Ability Start
function puck_illusory_orb_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local damage = self:GetAbilityDamage()
	local projectile_speed = self:GetSpecialValueFor("orb_speed")
	local projectile_distance = self:GetSpecialValueFor("max_distance")
	local projectile_radius = self:GetSpecialValueFor("radius")
	local vision_radius = self:GetSpecialValueFor("orb_vision")
	local vision_duration = self:GetSpecialValueFor("vision_duration")

	local projectile_direction = point-caster:GetOrigin()
	projectile_direction = Vector( projectile_direction.x, projectile_direction.y, 0 ):Normalized()
	local projectile_name = "particles/units/heroes/hero_puck/puck_illusory_orb.vpcf"

	-- create projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetOrigin(),
		
	    bDeleteOnHit = false,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = projectile_name,
	    fDistance = projectile_distance,
	    fStartRadius = projectile_radius,
	    fEndRadius =projectile_radius,
		vVelocity = projectile_direction * projectile_speed,
	
		bReplaceExisting = false,
		
		bProvidesVision = true,
		iVisionRadius = vision_radius,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)

	-- sound modifier
	local modifier = CreateModifierThinker(
		caster,
		self,
		"modifier_puck_illusory_orb_lua_thinker",
		{ duration = 20 },
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false		
	)
	modifier = modifier:FindModifierByName( "modifier_puck_illusory_orb_lua_thinker" )

	-- register projectile
	local extraData = {}
	extraData.damage = damage
	extraData.location = caster:GetOrigin()
	extraData.time = GameRules:GetGameTime()
	extraData.modifier = modifier
	self.projectiles[projectile] = extraData

	-- activate sub
	self.jaunt:SetActivated( true )
end
--------------------------------------------------------------------------------
-- Projectile
function puck_illusory_orb_lua:OnProjectileThinkHandle( proj )
	-- update location
	local location = ProjectileManager:GetLinearProjectileLocation( proj )
	self.projectiles[proj].location = location
	self.projectiles[proj].modifier:GetParent():SetOrigin( location )
end

function puck_illusory_orb_lua:OnProjectileHitHandle( target, location, proj )
	if not target then 
		-- destroy reference
		self.projectiles[proj].modifier:Destroy()
		self.projectiles[proj] = nil
		self.jaunt:Deactivate()
		return true
	end

	-- damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = self.projectiles[proj].damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- effects
	self:PlayEffects( target )
	return false
end

--------------------------------------------------------------------------------
-- Ability Events
function puck_illusory_orb_lua:OnUpgrade()
	if not self.jaunt then
		-- init
		self.jaunt = self:GetCaster():FindAbilityByName( "puck_ethereal_jaunt_lua" )
		self.jaunt.projectiles = self.projectiles
		self.jaunt:SetActivated( false )
	end

	self.jaunt:UpgradeAbility( true )
end

--------------------------------------------------------------------------------
-- Effects
function puck_illusory_orb_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_puck/puck_orb_damage.vpcf"
	local sound_cast = "Hero_Puck.IIllusory_Orb_Damage"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end

--------------------------------------------------------------------------------
-- Sub-ability
--------------------------------------------------------------------------------
function puck_ethereal_jaunt_lua:OnSpellStart()
	-- get first index projectile
	local first = false
	for k,v in pairs(self.projectiles) do
		first = k
		break
	end
	if not first then return end

	-- find oldest projectile
	for idx,projectile in pairs(self.projectiles) do
		if projectile.time < self.projectiles[first].time then
			first = idx
		end
	end

	-- jump to oldest
	local old_pos = self:GetCaster():GetOrigin()
	FindClearSpaceForUnit( self:GetCaster(), ProjectileManager:GetLinearProjectileLocation( first ), true )
	ProjectileManager:ProjectileDodge( self:GetCaster() )

	-- destroy the oldest
	ProjectileManager:DestroyLinearProjectile( first )
	self.projectiles[first].modifier:Destroy()
	self.projectiles[first] = nil
	self:Deactivate()

	-- effects
	self:PlayEffects( old_pos )
end

--------------------------------------------------------------------------------
-- Helper: Deactivate
function puck_ethereal_jaunt_lua:Deactivate()
	local any = false
	for k,v in pairs(self.projectiles) do
		any = true
		break
	end
	if not any then
		self:SetActivated( false )
	end
end

--------------------------------------------------------------------------------
-- Effects
function puck_ethereal_jaunt_lua:PlayEffects( point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_puck/puck_illusory_orb_blink_out.vpcf"
	local sound_cast = "Hero_Puck.EtherealJaunt"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end