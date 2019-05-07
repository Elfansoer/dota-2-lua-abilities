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
fairy_queen_quell = class({})
LinkLuaModifier( "modifier_generic_custom_indicator", "lua_abilities/generic/modifier_generic_custom_indicator", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fairy_queen_quell", "custom_abilities/fairy_queen_quell/modifier_fairy_queen_quell", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fairy_queen_quell_debuff", "custom_abilities/fairy_queen_quell/modifier_fairy_queen_quell_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function fairy_queen_quell:GetIntrinsicModifierName()
	-- Using custom indicator
	return "modifier_generic_custom_indicator"
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function fairy_queen_quell:CastFilterResultLocation( vLoc )
	-- Custom indicator block start
	if IsClient() then
		-- check custom indicator
		if self.custom_indicator then
			-- register cursor position
			self.custom_indicator:Register( vLoc )
		end
	end
	-- Custom indicator block end

	if not self:CheckFairies() then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function fairy_queen_quell:GetCustomCastErrorLocation( vLoc )
	if not self:CheckFairies() then
		return "#dota_hud_error_no_fairies"
	end

	return ""
end

function fairy_queen_quell:CheckFairies()
	if self:GetCaster():HasModifier( "modifier_fairy_queen_fairies" ) and self:GetCaster():HasModifier( "modifier_fairy_queen_fairies_counter" ) then
		local used = self:GetCaster():GetModifierStackCount( "modifier_fairy_queen_fairies_counter", self:GetCaster() )
		local fairies = self:GetCaster():GetModifierStackCount( "modifier_fairy_queen_fairies", self:GetCaster() )
		if used<=fairies then
			return true
		end
	end

	return false
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator
function fairy_queen_quell:CreateCustomIndicator()
	local particle_cast = "particles/custom_indicator_cone.vpcf"
	self.effect_cast = {}

	for i=1,3 do
		-- create particle
		self.effect_cast[i] = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:SetParticleControlEnt(
			self.effect_cast[i],
			1,
			self:GetCaster(),
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			self:GetCaster():GetAbsOrigin(), -- unknown
			false -- unknown, true
		)
		ParticleManager:SetParticleControl( self.effect_cast[i], 3, Vector(100,100,0) )
	end
end

function fairy_queen_quell:UpdateCustomIndicator( loc )
	-- update position
	local projectile_distance = self:GetSpecialValueFor( "projectile_distance" )
	local origin = self:GetCaster():GetAbsOrigin()
	local dir = (loc-origin):Normalized()*projectile_distance
	for i=1,3 do
		ParticleManager:SetParticleControl( self.effect_cast[i], 2, origin + dir )
	end

	-- changes based on fairies
	local fairies = self:GetCaster():GetModifierStackCount( "modifier_fairy_queen_fairies_counter", self:GetCaster() )

	if fairies==2 then
		local direction_short = dir*0.5
		ParticleManager:SetParticleControl( self.effect_cast[1], 2, origin + direction_short )
	end

	if fairies==3 then
		local direction_left = RotatePosition( Vector(0,0,0), QAngle( 0, -30, 0 ), dir )
		local direction_right = RotatePosition( Vector(0,0,0), QAngle( 0, 30, 0 ), dir )
		ParticleManager:SetParticleControl( self.effect_cast[2], 2, origin + direction_left )
		ParticleManager:SetParticleControl( self.effect_cast[3], 2, origin + direction_right )
	end
end

function fairy_queen_quell:DestroyCustomIndicator()
	-- destroy
	for i=1,3 do
		ParticleManager:DestroyParticle( self.effect_cast[i], false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast[i] )
		self.effect_cast[i] = nil
	end
end

--------------------------------------------------------------------------------
-- Ability Start
function fairy_queen_quell:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- consume fairies
	local fairy_modifier = caster:FindModifierByNameAndCaster( "modifier_fairy_queen_fairies", caster )
	local fairies,fairy_visual = fairy_modifier:GetFairies()

	-- load data
	-- local projectile_name = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf"
	local projectile_distance = self:GetSpecialValueFor( "projectile_distance" )
	local projectile_radius = self:GetSpecialValueFor( "projectile_width" )
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )

	-- get direction
	local projectile_direction = point - caster:GetOrigin()
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()

	-- create projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    bDeleteOnHit = false,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = projectile_name,
	    fDistance = projectile_distance,
	    fStartRadius = projectile_radius,
	    fEndRadius = projectile_radius,
		vVelocity = projectile_direction * projectile_speed,
	
		bHasFrontalCone = false,
		bReplaceExisting = false,
		fExpireTime = GameRules:GetGameTime() + 10.0,
		
		bProvidesVision = true,
		iVisionRadius = 300,
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	local projectile = ProjectileManager:CreateLinearProjectile( info )

	-- register projectile
	self.projectiles[projectile] = {}
	self.projectiles[projectile].fairies = fairies
	self.projectiles[projectile].fairy_visual = fairy_visual[1]

	-- two fairies launched
	if fairies==2 then
		self.projectiles[projectile].fairy_visual2 = fairy_visual[2]
	end

	-- three projectiles
	if fairies==3 then
		-- determine direction
		local direction_left = RotatePosition( Vector(0,0,0), QAngle( 0, -30, 0 ), projectile_direction )
		local direction_right = RotatePosition( Vector(0,0,0), QAngle( 0, 30, 0 ), projectile_direction )

		-- left projectile
		info.vVelocity = direction_left * projectile_speed
		projectile = ProjectileManager:CreateLinearProjectile( info )
		self.projectiles[projectile] = {}
		self.projectiles[projectile].fairies = fairies
		self.projectiles[projectile].fairy_visual = fairy_visual[2]

		-- right projectile
		info.vVelocity = direction_right * projectile_speed
		projectile = ProjectileManager:CreateLinearProjectile( info )
		self.projectiles[projectile] = {}
		self.projectiles[projectile].fairies = fairies
		self.projectiles[projectile].fairy_visual = fairy_visual[3]
	end

	-- Play effects
	local sound_cast = "Hero_SkywrathMage.ConcussiveShot.Cast"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
-- Projectile management
fairy_queen_quell.projectiles = {}
function fairy_queen_quell.projectiles:Destroy( projectile )
	if not self[projectile] then return end

	-- get handle
	local handle = self[projectile]

	-- destroy visual
	if handle.fairies==2 then
		local visual2 = handle.fairy_visual2
		visual2:DestroyFairy()
	end
	local visual = handle.fairy_visual
	visual:DestroyFairy()

	-- destroy handle
	self[projectile] = nil
end

function fairy_queen_quell:OnProjectileHitHandle( target, location, iProjectileHandle )
	if not target then
		self.projectiles:Destroy( iProjectileHandle )
		return
	end

	-- get fairies used for this projectile
	local fairies = self.projectiles[iProjectileHandle].fairies

	-- get data
	local damage = self:GetSpecialValueFor( "damage" )
	if fairies>=3 then
		damage = self:GetSpecialValueFor( "damage_strong" )
	end
	local buff_duration = self:GetSpecialValueFor( "buff_duration" )
	local debuff_duration = self:GetSpecialValueFor( "debuff_duration" )

	-- apply buff if allied and fairies >= 2
	if target:GetTeamNumber()==self:GetCaster():GetTeamNumber() then
		if fairies>=2 then
			target:AddNewModifier(
				self:GetCaster(), -- player source
				self, -- ability source
				"modifier_fairy_queen_quell", -- modifier name
				{ duration = buff_duration } -- kv
			)
		end

		return false
	end

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	-- apply debuff if enemy and fairies >=3
	if fairies>=3 then
		target:AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_fairy_queen_quell_debuff", -- modifier name
			{ duration = debuff_duration } -- kv
		)
	end

	-- play effects
	local sound_cast = "Hero_SkywrathMage.ArcaneBolt.Impact"
	EmitSoundOn( sound_cast, target )

	if fairies==1 then
		-- only damages first-hit enemy
		self.projectiles:Destroy( iProjectileHandle )
		return true
	end
	return false
end

-- only for visuals
function fairy_queen_quell:OnProjectileThinkHandle( iProjectileHandle )
	local fairies = self.projectiles[iProjectileHandle].fairies
	local location = GetGroundPosition( ProjectileManager:GetLinearProjectileLocation( iProjectileHandle ), self:GetCaster() ) + Vector( 0,0,100 )
	
	-- update fairy locations
	if fairies==2 then
		local visual2 = self.projectiles[iProjectileHandle].fairy_visual2
		visual2:UpdateFairy( location, 2400 )		
	end
	local visual = self.projectiles[iProjectileHandle].fairy_visual
	visual:UpdateFairy( location, 2400 )
end