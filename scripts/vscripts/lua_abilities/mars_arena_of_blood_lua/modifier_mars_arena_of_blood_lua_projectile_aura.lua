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
modifier_mars_arena_of_blood_lua_projectile_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mars_arena_of_blood_lua_projectile_aura:IsHidden()
	return false
end

function modifier_mars_arena_of_blood_lua_projectile_aura:IsDebuff()
	return false
end

function modifier_mars_arena_of_blood_lua_projectile_aura:IsStunDebuff()
	return false
end

function modifier_mars_arena_of_blood_lua_projectile_aura:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mars_arena_of_blood_lua_projectile_aura:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.width = self:GetAbility():GetSpecialValueFor( "width" )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then return end

	self.owner = kv.isProvidedByAura~=1
	if not self.owner then return end

	-- create filter using library
	self.filter = FilterManager:AddTrackingProjectileFilter( self.ProjectileFilter, self )

	self:StartIntervalThink( 0.03 )
end

function modifier_mars_arena_of_blood_lua_projectile_aura:OnRefresh( kv )
	
end

function modifier_mars_arena_of_blood_lua_projectile_aura:OnRemoved()
end

function modifier_mars_arena_of_blood_lua_projectile_aura:OnDestroy()
	if not IsServer() then return end

	if not self.owner then return end
	FilterManager:RemoveTrackingProjectileFilter( self.filter )
end

--------------------------------------------------------------------------------
-- Filter Effects
function modifier_mars_arena_of_blood_lua_projectile_aura:ProjectileFilter( data )
	-- get data
	local attacker = EntIndexToHScript( data.entindex_source_const )
	local target = EntIndexToHScript( data.entindex_target_const )
	local ability = EntIndexToHScript( data.entindex_ability_const )
	local isAttack = data.is_attack

	-- only block things that aren't from this ability
	if self.lock then return true end

	-- only block attacks
	if not data.is_attack then return true end

	-- only block enemies
	if attacker:GetTeamNumber()==self:GetCaster():GetTeamNumber() then return true end

	-- only block projectiles that either one of them is inside
	local mod1 = attacker:FindModifierByNameAndCaster( 'modifier_mars_arena_of_blood_lua_projectile_aura', self:GetCaster() )
	local mod2 = target:FindModifierByNameAndCaster( 'modifier_mars_arena_of_blood_lua_projectile_aura', self:GetCaster() )
	if (not mod1) and (not mod2) then return true end

	-- create projectile
	local info = {
		Target = target,
		Source = attacker,
		Ability = self.ability,	
		
		EffectName = attacker:GetRangedProjectileName(),
		iMoveSpeed = data.move_speed,
		bDodgeable = true,                           -- Optional
	
		vSourceLoc = attacker:GetAbsOrigin(),                -- Optional (HOW)
		bIsAttack = true,                                -- Optional

		ExtraData = data,
	}
	self.lock = true
	local id = ProjectileManager:CreateTrackingProjectile(info)
	self.lock = false
	self.ability.projectiles[id] = data

	return false
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_mars_arena_of_blood_lua_projectile_aura:OnIntervalThink()
	local origin = self:GetParent():GetOrigin()

	for id,_ in pairs(self.ability.projectiles) do
		-- get position
		local pos = ProjectileManager:GetTrackingProjectileLocation( id )

		-- check location
		local distance = (pos-origin):Length2D()

		-- check if position is within the ring
		if math.abs(distance-self.radius)<self.width then
			-- destroy
			self.ability.projectiles[id].destroyed = true
			ProjectileManager:DestroyTrackingProjectile( id )

			-- play effects
			self:PlayEffects( pos )
		end
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_mars_arena_of_blood_lua_projectile_aura:IsAura()
	return self.owner
end

function modifier_mars_arena_of_blood_lua_projectile_aura:GetModifierAura()
	return "modifier_mars_arena_of_blood_lua_projectile_aura"
end

function modifier_mars_arena_of_blood_lua_projectile_aura:GetAuraRadius()
	return self.radius
end

function modifier_mars_arena_of_blood_lua_projectile_aura:GetAuraDuration()
	return 0.3
end

function modifier_mars_arena_of_blood_lua_projectile_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_mars_arena_of_blood_lua_projectile_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_ALL
end

function modifier_mars_arena_of_blood_lua_projectile_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_mars_arena_of_blood_lua_projectile_aura:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_mars_arena_of_blood_lua_projectile_aura:PlayEffects( loc )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_mars/mars_arena_of_blood_impact.vpcf"
	local sound_cast = "Hero_Mars.Block_Projectile"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, loc )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( loc, sound_cast, self:GetCaster() )
end