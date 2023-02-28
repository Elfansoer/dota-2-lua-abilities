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
modifier_maple_martyrs_devotion = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_martyrs_devotion:IsHidden()
	return true
end

function modifier_maple_martyrs_devotion:IsDebuff()
	return false
end

function modifier_maple_martyrs_devotion:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_martyrs_devotion:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.health_pct = self:GetAbility():GetSpecialValueFor( "maintain_cost" )

	self.interval = 1

	if not IsServer() then return end

	self:StartIntervalThink( self.interval )
	self:PlayEffects()
end

function modifier_maple_martyrs_devotion:OnRefresh( kv )
end

function modifier_maple_martyrs_devotion:OnRemoved()
end

function modifier_maple_martyrs_devotion:OnDestroy()
	if not IsServer() then return end
	
	-- switch ability layout
	local ability = self.parent:FindAbilityByName( "maple_martyrs_devotion_end" )
	if not ability then return end

	self.parent:SwapAbilities(
		self.ability:GetAbilityName(),
		ability:GetAbilityName(),
		true,
		false
	)
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_maple_martyrs_devotion:OnIntervalThink()
	local victim = self.parent

	-- check has atrocity active
	local modifier = self.parent:FindModifierByName("modifier_maple_atrocity")
	local lethal_flag = DOTA_DAMAGE_FLAG_NON_LETHAL
	if modifier and modifier.unit then
		victim = modifier.unit
		lethal_flag = 0
	end

	local health = victim:GetHealth()
	local cost = victim:GetMaxHealth() * self.health_pct/100

	-- health cost 
	local damageTable = {
		victim = victim,
		attacker = self.parent,
		damage = cost,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self.ability, --Optional.
		damage_flags = lethal_flag + DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS, --Optional.
	}
	ApplyDamage(damageTable)
	
	-- destroy if can't sustain
	if health < cost then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_maple_martyrs_devotion:IsAura()
	if IsServer() and self.effect_cast then
		ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
		ParticleManager:SetParticleControl( self.effect_cast, 2, self.parent:GetOrigin() )
	end
	return true
end

function modifier_maple_martyrs_devotion:GetModifierAura()
	return "modifier_maple_martyrs_devotion_buff"
end

function modifier_maple_martyrs_devotion:GetAuraRadius()
	return self.radius
end

function modifier_maple_martyrs_devotion:GetAuraDuration()
	return 0.5
end

function modifier_maple_martyrs_devotion:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_maple_martyrs_devotion:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_maple_martyrs_devotion:GetAuraEntityReject( hEntity )
	if IsServer() then
		if hEntity==self.parent then
			return true
		end

		-- reject atrocity monster
		if hEntity:GetPlayerOwnerID()==self.parent:GetPlayerOwnerID() and hEntity:HasModifier("modifier_maple_atrocity_unit") then
			return true
		end
	end

	return false
end

function modifier_maple_martyrs_devotion:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/heroes_underlord/abbysal_underlord_darkrift_ambient.vpcf"

	-- Get Data
	local caster = self:GetCaster()
	local parent = self:GetParent()

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		2,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end