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
modifier_outworld_devourer_astral_imprisonment_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_outworld_devourer_astral_imprisonment_lua:IsHidden()
	return false
end

function modifier_outworld_devourer_astral_imprisonment_lua:IsDebuff()
	return self:GetCaster():GetTeamNumber()~=self:GetParent():GetTeamNumber()
end

function modifier_outworld_devourer_astral_imprisonment_lua:IsStunDebuff()
	return true
end

function modifier_outworld_devourer_astral_imprisonment_lua:IsPurgable()
	return true
end

function modifier_outworld_devourer_astral_imprisonment_lua:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_outworld_devourer_astral_imprisonment_lua:OnCreated( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end
	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- play effects
	self:GetParent():AddNoDraw()
	self:PlayEffects()
end

function modifier_outworld_devourer_astral_imprisonment_lua:OnRefresh( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end
	-- update damage
	self.damageTable.damage = damage
end

function modifier_outworld_devourer_astral_imprisonment_lua:OnRemoved()
end

function modifier_outworld_devourer_astral_imprisonment_lua:OnDestroy()
	if not IsServer() then return end
	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- apply damage
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )

		-- play overhead event
		SendOverheadEventMessage(
			nil,
			OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
			self:GetParent(),
			self.damageTable.damage,
			nil
		)
	end

	-- play effects
	self:GetParent():RemoveNoDraw()
	local sound_loop = "Hero_ObsidianDestroyer.AstralImprisonment"
	StopSoundOn( sound_loop, self:GetCaster() )

	local sound_cast = "Hero_ObsidianDestroyer.AstralImprisonment.End"
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_outworld_devourer_astral_imprisonment_lua:CheckState()
	local state = {
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_outworld_devourer_astral_imprisonment_lua:PlayEffects()
	-- Get Resources
	local particle_cast1 = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_prison.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_prison_ring.vpcf"
	local sound_loop = "Hero_ObsidianDestroyer.AstralImprisonment"

	-- Create Particle
	local effect_cast1 = ParticleManager:CreateParticle( particle_cast1, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast1, 0, self:GetParent():GetOrigin() )

	local effect_cast2 = ParticleManager:CreateParticleForTeam( particle_cast2, PATTACH_WORLDORIGIN, nil, self:GetCaster():GetTeamNumber() )
	ParticleManager:SetParticleControl( effect_cast2, 0, self:GetParent():GetOrigin() )

	-- buff particle
	self:AddParticle(
		effect_cast1,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	self:AddParticle(
		effect_cast2,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_loop, self:GetCaster() )
end