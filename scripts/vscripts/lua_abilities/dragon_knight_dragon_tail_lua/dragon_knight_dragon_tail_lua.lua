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
dragon_knight_dragon_tail_lua = class({})
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
function dragon_knight_dragon_tail_lua:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_lua" ) then
		return 400
	else
		return self.BaseClass.GetCastRange( self, vLocation, hTarget )
	end
end

--------------------------------------------------------------------------------
-- Ability Start
function dragon_knight_dragon_tail_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- check dragon modifier
	local modifier = caster:FindModifierByNameAndCaster( "modifier_dragon_knight_elder_dragon_form_lua", caster )

	-- check if simple form
	if not modifier then
		-- directly hit
		self:Hit( target, false )

		-- play effects
		local sound_cast = "Hero_DragonKnight.DragonTail.Cast"
		EmitSoundOn( sound_cast, caster )
		return
	end

	-- dragon form

	-- get data
	local projectile_name = "particles/units/heroes/hero_dragon_knight/dragon_knight_dragon_tail_dragonform_proj.vpcf"
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )

	-- create projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,                           -- Optional
		}
	ProjectileManager:CreateTrackingProjectile(info)
end

-- Helper
function dragon_knight_dragon_tail_lua:Hit( target, dragonform )
	local caster = self:GetCaster()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local damage = self:GetAbilityDamage()
	local duration = self:GetSpecialValueFor( "stun_duration" )

	-- damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- stun
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Play effects
	self:PlayEffects( target, dragonform )
	local sound_cast = "Hero_DragonKnight.DragonTail.Target"
	EmitSoundOn( sound_cast, target )
end

--------------------------------------------------------------------------------
-- Projectile
function dragon_knight_dragon_tail_lua:OnProjectileHit( target, location )
	if not target then return end

	self:Hit( target, true )
end

--------------------------------------------------------------------------------
function dragon_knight_dragon_tail_lua:PlayEffects( target, dragonform )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dragon_knight/dragon_knight_dragon_tail.vpcf"

	-- Get Data
	local vec = target:GetOrigin()-self:GetCaster():GetOrigin()
	local attach = "attach_attack1"
	if dragonform then
		attach = "attach_attack2"
	end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 3, vec )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		4,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end