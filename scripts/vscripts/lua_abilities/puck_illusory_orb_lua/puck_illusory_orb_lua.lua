puck_illusory_orb_lua = class({})
LinkLuaModifier( "modifier_puck_illusory_orb_lua", "lua_abilities/puck_illusory_orb_lua/modifier_puck_illusory_orb_lua", LUA_MODIFIER_MOTION_NONE )

puck_illusory_orb_lua.projectiles = {}
--------------------------------------------------------------------------------
-- Ability Start
function puck_illusory_orb_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local projectile_speed = self:GetSpecialValueFor("orb_speed")
	local projectile_distance = self:GetSpecialValueFor("max_distance")
	local projectile_radius = self:GetSpecialValueFor("radius")
	local vision_radius = self:GetSpecialValueFor("orb_vision")
	local vision_duration = self:GetSpecialValueFor("vision_duration")

	local projectile_direction = point-caster:GetOrigin()
	projectile_direction = Vector( projectile_direction.x, projectile_direction.y, 0 ):Normalized()
	local projectile_name = ""

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
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)
end
--------------------------------------------------------------------------------
-- Projectile
function puck_illusory_orb_lua:OnProjectileHit( target, location )
end

--------------------------------------------------------------------------------
function puck_illusory_orb_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end

--------------------------------------------------------------------------------
-- Built-in functions
-- Helper: Ability Table (AT)
function puck_illusory_orb_lua:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function puck_illusory_orb_lua:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function puck_illusory_orb_lua:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function puck_illusory_orb_lua:GetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	return ret
end

function puck_illusory_orb_lua:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end