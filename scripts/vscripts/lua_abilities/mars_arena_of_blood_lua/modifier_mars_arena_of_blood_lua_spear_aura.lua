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
modifier_mars_arena_of_blood_lua_spear_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mars_arena_of_blood_lua_spear_aura:IsHidden()
	return true
end

function modifier_mars_arena_of_blood_lua_spear_aura:IsDebuff()
	return true
end

function modifier_mars_arena_of_blood_lua_spear_aura:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mars_arena_of_blood_lua_spear_aura:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.width = self:GetAbility():GetSpecialValueFor( "spear_distance_from_wall" )
	self.duration = self:GetAbility():GetSpecialValueFor( "spear_attack_interval" )
	self.damage = self:GetAbility():GetSpecialValueFor( "spear_damage" )
	self.knockback_duration = 0.2

	self.parent = self:GetParent()
	self.spear_radius = self.radius-self.width

	if not IsServer() then return end
	self.owner = kv.isProvidedByAura~=1
	self.aura_origin = self:GetParent():GetOrigin()

	if not self.owner then
		self.aura_origin = Vector( kv.aura_origin_x, kv.aura_origin_y, 0 )
		local direction = self.aura_origin-self:GetParent():GetOrigin()
		direction.z = 0

		-- damage
		local damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(), --Optional.
		}
		ApplyDamage(damageTable)

		-- animate soldiers
		local arena_walls = Entities:FindAllByClassnameWithin( "npc_dota_phantomassassin_gravestone", self.parent:GetOrigin(), 160 )
		for _,arena_wall in pairs(arena_walls) do
			if arena_wall:HasModifier( "modifier_mars_arena_of_blood_lua_blocker" ) and arena_wall.model then
				arena_wall:FadeGesture( ACT_DOTA_ATTACK )
				arena_wall:StartGesture( ACT_DOTA_ATTACK )
				break
			end
		end

		-- play effects
		self:PlayEffects( direction:Normalized() )

		-- knockback if not having spear buff
		if self:GetParent():HasModifier( "modifier_mars_spear_of_mars_lua" ) then return end
		if self:GetParent():HasModifier( "modifier_mars_spear_of_mars_lua_debuff" ) then return end
		self:GetParent():AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_generic_knockback_lua", -- modifier name
			{
				duration = self.knockback_duration,
				distance = self.width,
				height = 30,
				direction_x = direction.x,
				direction_y = direction.y,
			} -- kv
		)
	end
end

function modifier_mars_arena_of_blood_lua_spear_aura:OnRefresh( kv )
	
end

function modifier_mars_arena_of_blood_lua_spear_aura:OnRemoved()
end

function modifier_mars_arena_of_blood_lua_spear_aura:OnDestroy()
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_mars_arena_of_blood_lua_spear_aura:IsAura()
	return self.owner
end

function modifier_mars_arena_of_blood_lua_spear_aura:GetModifierAura()
	return "modifier_mars_arena_of_blood_lua_spear_aura"
end

function modifier_mars_arena_of_blood_lua_spear_aura:GetAuraRadius()
	return self.radius
end

function modifier_mars_arena_of_blood_lua_spear_aura:GetAuraDuration()
	return self.duration
end

function modifier_mars_arena_of_blood_lua_spear_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_mars_arena_of_blood_lua_spear_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_mars_arena_of_blood_lua_spear_aura:GetAuraSearchFlags()
	return 0
end
function modifier_mars_arena_of_blood_lua_spear_aura:GetAuraEntityReject( unit )
	if not IsServer() then return end

	-- check flying
	if unit:HasFlyMovementCapability() then return true end

	-- check vertical motion controlled
	if unit:IsCurrentlyVerticalMotionControlled() then return true end

	-- check if already own this aura
	if unit:FindModifierByNameAndCaster( "modifier_mars_arena_of_blood_lua_spear_aura", self:GetCaster() ) then
		return true
	end

	-- check distance
	local distance = (unit:GetOrigin()-self.aura_origin):Length2D()
	if (distance-self.spear_radius)<0 then
		return true
	end

	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_mars_arena_of_blood_lua_spear_aura:PlayEffects( direction )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_mars/mars_arena_of_blood_spear.vpcf"
	local sound_cast = "Hero_Mars.Phalanx.Attack"
	local sound_target = "Hero_Mars.Phalanx.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 0, direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn( sound_target, self:GetParent() )
end