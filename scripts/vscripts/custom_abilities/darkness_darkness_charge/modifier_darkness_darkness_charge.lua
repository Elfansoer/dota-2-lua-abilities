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
modifier_darkness_darkness_charge = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_darkness_darkness_charge:IsHidden()
	return false
end

function modifier_darkness_darkness_charge:IsDebuff()
	return false
end

function modifier_darkness_darkness_charge:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_darkness_darkness_charge:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.stun = self:GetAbility():GetSpecialValueFor( "stun" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.speed = self:GetAbility():GetSpecialValueFor( "movespeed" )
	self.resist = self:GetAbility():GetSpecialValueFor( "status_resistance" )
	self.debuff_immune = self:GetAbility():GetSpecialValueFor( "is_debuff_immune" )

	self.knockback_distance = 100
	self.knockback_duration = 0.2
	self.knockback_height = 30
	self.teleport_threshold = self.speed * 2
	self.interval = 0.1

	if not IsServer() then return end
	self.enemies = {}
	self.last_location = self.parent:GetOrigin()

	-- play effects
	local sound_cast = "Hero_Spirit_Breaker.ChargeOfDarkness"
	EmitSoundOn( sound_cast, self.caster )
	
	if self.debuff_immune==1 then
		self:PlayEffects()
	end
end

function modifier_darkness_darkness_charge:OnRefresh( kv )
end

function modifier_darkness_darkness_charge:OnRemoved()
end

function modifier_darkness_darkness_charge:OnDestroy()
end

function modifier_darkness_darkness_charge:SetTarget( target )
	self.target = target
	self.parent:MoveToPosition( target:GetOrigin() )
	self:StartIntervalThink( self.interval )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_darkness_darkness_charge:OnIntervalThink()
	if (not self.target) or (not self.target:IsAlive()) then
		self:Destroy()
		return
	end
	
	-- check if teleported
	if (self.last_location - self.parent:GetOrigin()):Length2D() > self.interval * self.teleport_threshold then
		FindClearSpaceForUnit( self.parent, self.last_location, true)
	else
		self.last_location = self.parent:GetOrigin()
	end

	self.parent:MoveToPosition( self.target:GetOrigin() )
	
	-- destroy trees
	GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.radius, false )

	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		if not self.enemies[enemy] then
			self.enemies[enemy] = true

			local direction = enemy:GetOrigin()-self.parent:GetOrigin()
			direction.z = 0
			direction = direction:Normalized()		

			-- create arc
			enemy:AddNewModifier(
				self.parent, -- player source
				self.ability, -- ability source
				"modifier_generic_arc_lua", -- modifier name
				{
					dir_x = direction.x,
					dir_y = direction.y,
					duration = self.knockback_duration,
					distance = self.knockback_distance,
					height = self.knockback_height,
					activity = ACT_DOTA_FLAIL,
				} -- kv
			)

			-- stun
			enemy:AddNewModifier(
				self.parent, -- player source
				self.ability, -- ability source
				"modifier_generic_stunned_lua", -- modifier name
				{ duration = self.stun } -- kv
			)

			-- apply damage
			local damageTable = {
				victim = enemy,
				attacker = self.parent,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self.ability, --Optional.
			}
			ApplyDamage(damageTable)

			-- play effects
			local sound_cast = "Hero_Spirit_Breaker.GreaterBash"
			EmitSoundOn( sound_cast, enemy )
		end
	end

	if (self.parent:GetOrigin()-self.target:GetOrigin()):Length2D() < self.radius then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_darkness_darkness_charge:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
		MODIFIER_PROPERTY_STATUS_RESISTANCE,

		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return funcs
end

function modifier_darkness_darkness_charge:GetModifierMoveSpeed_AbsoluteMin()
	return self.speed
end

function modifier_darkness_darkness_charge:GetActivityTranslationModifiers()
	return "haste"
end

function modifier_darkness_darkness_charge:GetModifierStatusResistance()
	return self.resist
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_darkness_darkness_charge:CheckState()
	local state = {
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
		[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
		[MODIFIER_STATE_IGNORING_STOP_ORDERS] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSLOWABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = self.is_debuff_immune==1,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_darkness_darkness_charge:GetEffectName()
	return "particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf"
end

function modifier_darkness_darkness_charge:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_darkness_darkness_charge:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_repel_buff.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end